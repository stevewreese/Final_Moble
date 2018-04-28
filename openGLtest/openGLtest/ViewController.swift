//
//  ViewController.swift
//  openGLtest
//
//  Created by u0396206 on 4/23/18.
//  Copyright © 2018 u0396206. All rights reserved.
//

import GLKit

class ViewController: GLKViewController, ControlDelegate{

    
    
    
    var theGame: GameView = GameView(frame: UIScreen.main.bounds)
    var theHighScore: HighScore = HighScore(frame: UIScreen.main.bounds)
    var theMainMenu: MainMenu = MainMenu(frame: UIScreen.main.bounds)
    
    enum mainShipMove {case left, right, up, down}
    var shipMove: mainShipMove = mainShipMove.up
    
    var stop = true
    var fire = false
    
    var whenToFire = 5
    
    var collectCoors: Array<Float> = [-0.3, 0.3, -1.0, -0.8]
    var enemyCoors: Array<Float> = [-0.30, +0.3, 0.1, 0.0]
    var bulletList: Array<UIView> = Array()
    
    var theControl: GameControl? = nil

    
    let triangleData: [Float] = [
        +0.3, -0.8,
        -0.3, -0.8,
        +0.3, -1.0,
        
        -0.3, -0.8,
        +0.3, -1.0,
        -0.3, -1.0,

        
       +0.30, +0.10,
       -0.30, +0.10,
       -0.30,  +0.0,
       
       +0.30, +0.10,
       +0.30, +0.0,
       -0.30,  +0.0,
    ]
    
    let triangleTextureCoordinateData: [Float] = [
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,

        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
    ]
    
    var marsTextureInfo: GLKTextureInfo? = nil
    var plutoTextureInfo: GLKTextureInfo? = nil
    
    var program: GLuint = 0
    var animationX1: Float = 0.0
    var animationY1: Float = 0.0
    var animationX2: Float = 0.0
    var animationY2: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        theControl = GameControl(coors: collectCoors, eCoors: enemyCoors)
        
        
        theControl?.delegate = self
        
        theGame.theControl = theControl
        theHighScore.theControl = theControl
        theMainMenu.theControl = theControl
        
        //theHighScore.backgroundColor = .white
        
        //theMainMenu.backgroundColor = .white

        
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)!
        EAGLContext.setCurrent(glkView.context)
        
        let vertexShaderSource: NSString = """

            attribute vec2 position;
            attribute vec2 textureCoordinate;
            uniform vec2 translate;
            varying vec2 textureCoordinateInterpolated;
            void main(){
                gl_Position = vec4(position.x + translate.x, position.y + translate.y, 0.0, 1.0);
                textureCoordinateInterpolated = textureCoordinate;
            }

        """
        
        var vertexShaderSourceMemory = vertexShaderSource.utf8String
        let vertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        glShaderSource(vertexShader, 1, &vertexShaderSourceMemory, nil)
        glCompileShader(vertexShader)
        var vertextShaderCompileSuccceded: GLint = 0
        glGetShaderiv(vertexShader, GLenum(GL_COMPILE_STATUS), &vertextShaderCompileSuccceded)
        
        let fragmentShaderSource: NSString = """
            
            varying highp vec2 textureCoordinateInterpolated;
            uniform sampler2D textureUnit;
            void main(){
                gl_FragColor = texture2D(textureUnit, textureCoordinateInterpolated);
            }

        """
        
        var fragmentShaderSourceMemory = fragmentShaderSource.utf8String
        let fragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        glShaderSource(fragmentShader, 1, &fragmentShaderSourceMemory, nil)
        glCompileShader(fragmentShader)
        
        var fragmentShaderCompileSuccceded: GLint = 0
        glGetShaderiv(fragmentShader, GLenum(GL_COMPILE_STATUS), &fragmentShaderCompileSuccceded)
        
        program = glCreateProgram()
        
        glAttachShader(program, vertexShader)
        glAttachShader(program, fragmentShader)
        
        glBindAttribLocation(program, 0, "position")
        glBindAttribLocation(program, 1, "textureCoordinate")
        
        glLinkProgram(program)
        
        var linkSucceeded: GLint = 0
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &linkSucceeded)
        
        glUseProgram(program)
        
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleData)
        glEnableVertexAttribArray(0)
        
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleTextureCoordinateData)
        glEnableVertexAttribArray(1)
        
        glUniform1i(glGetUniformLocation(program, "textureUnit"), 0)
        
        let marsTextureImage: UIImage = UIImage(named: "mars")!
        marsTextureInfo = try! GLKTextureLoader.texture(with: marsTextureImage.cgImage!, options: [:])
        
        let plutoTextureImage: UIImage = UIImage(named: "pluto")!
        plutoTextureInfo = try! GLKTextureLoader.texture(with: plutoTextureImage.cgImage!, options: [:])
        
        
        glClearColor(1.0, 0.0, 0.0, 0.0)
        
        self.view.addSubview(theMainMenu)
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        if(!stop)
        {
            
            switch(shipMove)
            {
            case .left:
                animationX1 -= 0.01
                collectCoors[0] -= 0.01
                collectCoors[1] -= 0.01
                break
            case .right:
                animationX1 += 0.01
                collectCoors[0] += 0.01
                collectCoors[1] += 0.01
                break
            case .up:
                if(animationY1 <= 1.8)
                {
                    animationY1 += 0.01
                    collectCoors[2] += 0.01
                    collectCoors[3] += 0.01
                }
                break
            case .down:
                if(animationY1 >= -0.8){
                    animationY1 -= 0.01
                    collectCoors[2] -= 0.01
                    collectCoors[3] -= 0.01
                }
                
                break
            }
            
        }
        
        theControl?.updateCoors(coors: collectCoors, eCoors: enemyCoors)
        
        
        if(fire){
            if(whenToFire == 5)
            {
                fireWeapon()
                whenToFire = 0
            }
            else{
                whenToFire += 1
            }
        }
        
        var index = 0
        
        for bullet in bulletList
        {
            bullet.frame.origin.y = bullet.frame.origin.y - 10
            if(bullet.frame.origin.y - 10 <= 0)
            {
                bulletList.remove(at: index)
                bullet.removeFromSuperview()
            }
            index = index + 1
        }
        
        theControl?.updateBullet(bulletList: bulletList)
        

        var removeList: Array<Int> = (theControl?.update())!
        
        for i in removeList{
            bulletList[i].removeFromSuperview()
            bulletList.remove(at: i)
            animationY2 = 3.0
            enemyCoors[2] += 3.0
            enemyCoors[3] += 3.0
        }
        
        theControl?.updateBullet(bulletList: bulletList)

        

        
            glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
  
            
            glBindTexture(GLenum(GL_TEXTURE_2D), marsTextureInfo!.name)
            glUniform2f(glGetUniformLocation(program, "translate"), animationX1, animationY1)
            glDrawArrays(GLenum(GL_TRIANGLES), 0, 6)
            
            glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
            glUniform2f(glGetUniformLocation(program, "translate"), animationX2, animationY2)
            glDrawArrays(GLenum(GL_TRIANGLES), 6, 12)
        

    }
    
    func goToGame() {
        self.view.addSubview(theGame)
        theMainMenu.removeFromSuperview()
        //stop = false
    }
    
    func goToHighScores() {
        theMainMenu.removeFromSuperview()
        self.view.addSubview(theHighScore)
        stop = true
    }
    
    func goToMainMenu() {
        theGame.removeFromSuperview()
        theHighScore.removeFromSuperview()
        self.view.addSubview(theMainMenu)
        stop = true
    }
    
    func moveUp() {
        stop = false
        shipMove = mainShipMove.up
    }
    
    func moveDown() {
        stop = false
        shipMove = mainShipMove.down
    }
    
    func moveRight() {
        stop = false
        shipMove = mainShipMove.right
    }
    
    func moveLeft() {
        stop = false
        shipMove = mainShipMove.left
    }
    
    func stopMove(){
        stop = true
    }
    
    func startFire() {
        fire = true
    }
    
    func stopFire() {
        fire = false
    }
    
    
    func fireWeapon(){
        var x1: Float = 0.0
        var y1: Float = 0.0
        var x2: Float = 0.0

        if(collectCoors[1] < 0)
        {
            x2 = Float( UIScreen.main.bounds.width / 2.0) * (1+collectCoors[1])
        }
        else{
            x2 =  Float( UIScreen.main.bounds.width / 2.0) * collectCoors[1] + Float(UIScreen.main.bounds.width/2)
        }
        if(collectCoors[0] < 0){
            x1 = Float( UIScreen.main.bounds.width / 2.0) * (1+collectCoors[0])
        }
        else
        {
             x1 =  Float( UIScreen.main.bounds.width / 2.0) * collectCoors[0] + Float(UIScreen.main.bounds.width/2)
        }
        
        if(collectCoors[2] < 0){
            y1 = Float(UIScreen.main.bounds.height / 2.0) * collectCoors[3] * -1.0 + Float(UIScreen.main.bounds.height/2)
        }
        else
        {
            y1 = Float( UIScreen.main.bounds.height / 2.0) * (1-collectCoors[3])
        }
        
        var bullet: UIView = UIView(frame: CGRect(x: Int (x1 + (x2 - x1)/2), y: Int (y1 - 5), width: 2, height: 5))
        //
        bullet.backgroundColor = UIColor.black
        theGame.addSubview(bullet)
        bulletList.append(bullet)
        
        
        
    }
    
    
    
    


}


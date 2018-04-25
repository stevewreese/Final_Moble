//
//  ViewController.swift
//  openGLtest
//
//  Created by u0396206 on 4/23/18.
//  Copyright © 2018 u0396206. All rights reserved.
//

import GLKit

class ViewController: GLKViewController, ControlDelegate{
    
    var theControl: GameControl = GameControl()
    var theGame: GameView = GameView(frame: UIScreen.main.bounds)
    var theHighScore: HighScore = HighScore(frame: UIScreen.main.bounds)
    var theMainMenu: MainMenu = MainMenu(frame: UIScreen.main.bounds)
    
    enum mainShipMove {case left, right, up, down}
    var shipMove: mainShipMove = mainShipMove.up
    
    var stop = true

    
    let triangleData: [Float] = [
        +0.0, -0.8,
        +0.3, -1.0,
        -0.3, -1.0,
        +0.40, -0.10,
        -0.80, +0.50,
        -0.15, -0.75,
    ]
    
    let triangleTextureCoordinateData: [Float] = [
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        0.5, 0.0,
        1.0, 0.7,
        0.2, 1.0,
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
        
        theControl.delegate = self
        
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
                break
            case .right:
                animationX1 += 0.01
                break
            case .up:
                if(animationY1 <= 1.8)
                {
                    animationY1 += 0.01
                }
                break
            case .down:
                if(animationY1 >= -0.8){
                    animationY1 -= 0.01
                }
                
                break
            }
                
            //TODO DRAW A TRIANGLE
            //animationX1 += 0.001

            
            //animationX2 -= 0.002
            //animationY2 += 0.0015
        }
            glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
  
            
            glBindTexture(GLenum(GL_TEXTURE_2D), marsTextureInfo!.name)
            glUniform2f(glGetUniformLocation(program, "translate"), animationX1, animationY1)
            glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
            
            //glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
            //glUniform2f(glGetUniformLocation(program, "translate"), animationX2, animationY2)
            //glDrawArrays(GLenum(GL_TRIANGLES), 4, 3)
        

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
    
    


}


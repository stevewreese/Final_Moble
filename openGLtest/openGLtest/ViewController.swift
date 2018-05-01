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
    
    enum level {case one, two, three}
    var theLevel: level = level.one
    
    enum mainShipMove {case left, right, up, down}
    var shipMove: mainShipMove = mainShipMove.up
    
    var stop = true
    var fire = false
    var pause = true
    
    var whenToFire = 5
    
    var count = 0;
    
    var collectCoors: Array<Float> = [-0.3, 0.3, -1.0, -0.8]
    var enemyCoors: Array<Array<Float>> = Array()
    var bulletList: Array<UIView> = Array()
    var enemyInPlay: Array<Bool> = [true, true, true, true, true, true, true, true]
    var animation: Array<Float> = [Float](repeating: 0.0, count: 16)
    
    var theControl: GameControl? = nil
    var gameProgGreen: UIView? = nil
    var lifeBar = 100

    
    let triangleData: [Float] = [
        +0.3, -0.8,
        -0.3, -0.8,
        +0.3, -1.0,
        -0.3, -0.8,
        +0.3, -1.0,
        -0.3, -1.0,
        
        //enemy 1
       +0.3, +1.0,
       +0.0, +1.0,
        0.3, +1.1,
       +0.0, +1.0,
       +0.3, +1.1,
        0.0, +1.1,
       
       //enemy 2
       -0.30, -1.1,
       -0.60, -1.1,
       -0.30, -1.0,
       -0.60, -1.1,
       -0.30, -1.0,
       -0.60, -1.0,
       
       //enemy 3
        -0.30, 1.0,
        -0.60, 1.0,
        -0.30, 1.1,
        -0.60, 1.0,
        -0.30, 1.1,
        -0.60, 1.1,
        
        //enemy 4
        0.70, -1.1,
        0.40, -1.1,
        0.7, -1.0,
        0.4, -1.1,
        0.7, -1.0,
        0.4, -1.0,
        
        //enemy 5
        +0.90, -1.10,
        +0.70, -1.10,
        +0.90, -1.0,
        +0.70, -1.1,
        +0.90, -1.0,
        +0.70, -1.0,
        
        //enemy 6
        -1.10, 1.0,
        -1.40, 1.0,
        -1.10, 1.1,
        -1.40, 1.0,
        -1.10, 1.1,
        -1.40, 1.1,
        
        //enemy 7
        +1.40, +1.0,
        +1.10, +1.0,
        +1.40, +1.10,
        +1.10, +1.0,
        +1.40, +1.10,
        +1.10, +1.1,
        
        //enemy 8
        -0.8, -1.1,
        -1.0, -1.1,
        -0.8, -1.0,
        -1.0, -1.1,
        -0.8, -1.0,
        -1.0, -1.0,
        
       
       
    ]
    
    let triangleTextureCoordinateData: [Float] = [
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,

        //1
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
        //2
        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        0.0, 0.0,
        //3
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
        //4
        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        0.0, 0.0,
        //5
        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        0.0, 0.0,

        //6
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
        
        //7
        0.0, 0.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,
        
        //8
        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        0.0, 0.0,

    ]
    
    var marsTextureInfo: GLKTextureInfo? = nil
    var plutoTextureInfo: GLKTextureInfo? = nil
    var plutoTextureInfo2: GLKTextureInfo? = nil
    
    var program: GLuint = 0
    var animationX1: Float = 0.0
    var animationY1: Float = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        popArray()
        
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
        
        let plutoTextureImage2: UIImage = UIImage(named: "pluto")!
        plutoTextureInfo2 = try! GLKTextureLoader.texture(with: plutoTextureImage2.cgImage!, options: [:])
        
        
        glClearColor(1.0, 0.0, 0.0, 0.0)
        
        self.view.addSubview(theMainMenu)
        
        gameProgGreen = UIView(frame: CGRect(x: 200, y: 50, width: lifeBar * 2, height: 5))
        gameProgGreen?.backgroundColor = .green
        theGame.addSubview(gameProgGreen!)
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        if(!pause)
        {
            if(!stop)
            {
                
                switch(shipMove)
                {
                case .left:
                    if(collectCoors[0] >= -1.0)
                    {
                        animationX1 -= 0.01
                        collectCoors[0] -= 0.01
                        collectCoors[1] -= 0.01
                        
                    }
 
                    break
                case .right:
                    if(collectCoors[1] <= 1.0)
                    {
                        animationX1 += 0.01
                        collectCoors[0] += 0.01
                        collectCoors[1] += 0.01
                    }
                    break
                case .up:
                    if(collectCoors[2] + animationY1 <= 2.5)
                    {
                        animationY1 += 0.01
                        collectCoors[2] += 0.01
                        collectCoors[3] += 0.01
                    }
                    break
                case .down:
                    if(collectCoors[3] + animationY1 >= -0.8){
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
            
            
            var theResuts : results = (theControl?.update())!
            
            if(theResuts.removelist[0] == 1)
            {
                bulletList[theResuts.removelist[1]].removeFromSuperview()
                bulletList.remove(at: theResuts.removelist[1])
                enemyHit(index: theResuts.removelist[2])
            }
            
            if(theResuts.hit){
                lifeBar -= 1
            }
            if(lifeBar >= 0)
            {
                gameProgGreen?.removeFromSuperview()
                gameProgGreen = UIView(frame: CGRect(x: 200, y: 50, width: lifeBar * 2, height: 5))
                gameProgGreen?.backgroundColor = .green
                theGame.addSubview(gameProgGreen!)

            }
            else{
                animationX1 = 3
                collectCoors[0] = 3
                collectCoors[1] = 3
            }
 
            
            theControl?.updateBullet(bulletList: bulletList)
            
            count += 1
            
            var enIndex = 0
            
            if(count >= 0 && enemyInPlay[enIndex])
            {
            
                animation[enIndex*2 + 1] -= 0.005
                enemyCoors[enIndex][2] -= 0.005
                enemyCoors[enIndex][3] -= 0.005
                if(enemyCoors[enIndex][2] < -1.1){
                    enemyInPlay[enIndex] = false
                }
                
            }
            
            enIndex += 1
            
            if(count >= 120 && enemyInPlay[enIndex])
            {
                animation[enIndex*2 + 1] += 0.005
                enemyCoors[enIndex][2] += 0.005
                enemyCoors[enIndex][3] += 0.005
                if(enemyCoors[enIndex][2] > 1){
                    enemyInPlay[enIndex] = false
                }
            }
            

            
            enIndex += 1
            
            if(count >= 30 && enemyInPlay[enIndex])
            {
                
                animation[enIndex*2 + 1] -= 0.005
                enemyCoors[enIndex][2] -= 0.005
                enemyCoors[enIndex][3] -= 0.005
                if(enemyCoors[enIndex][3] < -1.1){
                    enemyInPlay[enIndex] = false
                }
            }
            
            enIndex += 1
            
            if(count >= 180 && enemyInPlay[enIndex])
            {
                animation[enIndex*2 + 1] += 0.005
                enemyCoors[enIndex][2] += 0.005
                enemyCoors[enIndex][3] += 0.005
                if(enemyCoors[enIndex][2] > 1){
                    enemyInPlay[enIndex] = false
                }
            }
            
            enIndex += 1
            
            

            
            if(count >= 60 && enemyInPlay[enIndex])
            {
                animation[enIndex*2] -= 0.005
                animation[enIndex*2 + 1] += 0.005
                enemyCoors[enIndex][0] += -0.005
                enemyCoors[enIndex][1] += -0.005
                enemyCoors[enIndex][2] += 0.005
                enemyCoors[enIndex][3] += 0.005
                if(enemyCoors[enIndex][2] > 1.2 || enemyCoors[enIndex][0] < -1.2){
                    enemyInPlay[enIndex] = false
                }
                
            }
            enIndex += 1
            

            
            if(count >= 120 && enemyInPlay[enIndex])
            {
                animation[enIndex*2] += 0.005
                animation[enIndex*2 + 1] -= 0.005
                enemyCoors[enIndex][0] += 0.005
                enemyCoors[enIndex][1] += 0.005
                enemyCoors[enIndex][2] += -0.005
                enemyCoors[enIndex][3] += -0.005
                if(enemyCoors[enIndex][2] < -1.2 || enemyCoors[enIndex][0] > 1.2){
                    enemyInPlay[enIndex] = false
                }
                
                
            }
            enIndex += 1
            if(count >= 200 && enemyInPlay[enIndex])
            {
                animation[enIndex*2] -= 0.005
                animation[enIndex*2 + 1] -= 0.005
                enemyCoors[enIndex][0] += -0.005
                enemyCoors[enIndex][1] += -0.005
                enemyCoors[enIndex][2] += -0.005
                enemyCoors[enIndex][3] += -0.005
                if(enemyCoors[enIndex][3] < -1.2 || enemyCoors[enIndex][0] < -1.2){
                    enemyInPlay[enIndex] = false
                }
                
                
            }
            enIndex += 1
            
            if(count >= 120 && enemyInPlay[enIndex])
            {
                animation[enIndex*2] += 0.005
                animation[enIndex*2 + 1] += 0.005
                
                enemyCoors[enIndex][0] += 0.005
                enemyCoors[enIndex][1] += 0.005
                enemyCoors[enIndex][2] += 0.005
                enemyCoors[enIndex][3] += 0.005
                if(enemyCoors[enIndex][2] > 1.2 || enemyCoors[enIndex][0] > 1.2){
                    enemyInPlay[enIndex] = false
                }
            }
            
       
            if(checkWinState()){
                goToMainMenu()
            }
            
            

            
        }
        
        glBindTexture(GLenum(GL_TEXTURE_2D), marsTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animationX1, animationY1)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[0], animation[1])
        glDrawArrays(GLenum(GL_TRIANGLES), 6, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[2], animation[3])
        glDrawArrays(GLenum(GL_TRIANGLES), 12, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[4], animation[5])
        glDrawArrays(GLenum(GL_TRIANGLES), 18, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[6], animation[7])
        glDrawArrays(GLenum(GL_TRIANGLES), 24, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[8], animation[9])
        glDrawArrays(GLenum(GL_TRIANGLES), 30, 6)
        
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[10], animation[11])
        glDrawArrays(GLenum(GL_TRIANGLES), 36, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[12], animation[13])
        glDrawArrays(GLenum(GL_TRIANGLES), 42, 6)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), plutoTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), animation[14], animation[15])
        glDrawArrays(GLenum(GL_TRIANGLES), 48, 6)
        
        
 


    }
    
    func goToGame() {
        self.view.addSubview(theGame)
        theMainMenu.removeFromSuperview()
        pause = false
        //stop = false
    }
    
    func goToHighScores() {
        theMainMenu.removeFromSuperview()
        self.view.addSubview(theHighScore)
        stop = true
        pause = true
    }
    
    func goToMainMenu() {
        theGame.removeFromSuperview()
        theHighScore.removeFromSuperview()
        self.view.addSubview(theMainMenu)
        stop = true
        pause = true
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
    
    func pauseGame() {
        pause = true
    }
    
    func unPauseGame() {
        pause = false
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
    
    func popArray(){
        enemyCoors.removeAll()
        var numberOfEnemies = 8
        var index = 0
        var theIndex = 14
        while(index < 8){
            var newArray: Array<Float> = Array()
            newArray.append(triangleData[theIndex])
            theIndex += 2
            newArray.append(triangleData[theIndex])
            theIndex += 3
            newArray.append(triangleData[theIndex])
            theIndex += 2
            newArray.append(triangleData[theIndex])
            enemyCoors.append(newArray)
            theIndex += 5
            index += 1
        }
    }
    
    func enemyHit(index: Int){
        enemyInPlay[index] = false
        enemyCoors[index][0] = -1000
        enemyCoors[index][1] = -1000
        enemyCoors[index][2] = -1000
        enemyCoors[index][3] = -1000
        animation[index*2] = 0.0
        animation[index*2 + 1] = 0.0

    }
    
    func checkWinState() -> Bool
    {
        for boolean in enemyInPlay{
            if(boolean){
                return false
            }
    
        }
        return true
    }
    
    func newGame(){
        popArray()
        animation = [Float](repeating: 0.0, count: 16)
        animationX1 = 0.0
        animationY1 = 0.0
        collectCoors = [-0.3, 0.3, -1.0, -0.8]
        enemyInPlay = [true, true, true, true, true, true, true, true]
        self.view.addSubview(theGame)
        theMainMenu.removeFromSuperview()
        pause = false
        count = 0
    }
    
    
    
    


}


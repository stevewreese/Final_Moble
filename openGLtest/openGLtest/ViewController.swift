//
//  ViewController.swift
//  openGLtest
//
//  Created by u0396206 on 4/23/18.
//  Copyright © 2018 u0396206. All rights reserved.
//

import GLKit

class ViewController: GLKViewController, ControlDelegate{

    
    
    var winstate = GameOver(frame: UIScreen.main.bounds)
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
    var timing: Array<Int> = [0, 120, 70, 180, 200, 260, 300, 360]
    
    var theControl: GameControl? = nil
    var gameProgGreen: UIView? = nil
    var lifeBar = 100
    var score = 0
    var stage = 0
    var speed : Float = 0.003
    var shipdSpeed : Float = 0.05
    var damage = 10

    
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
        
        1.0, -1.0,
        -1.0, -1.0,
        +1.0, 1.0,
        -1.0, -1.0,
        +1.0, 1.0,
        -1.0, 1.0,
       
       
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
        
        1.0, 1.0,
        0.0, 1.0,
        1.0, 0.0,
        0.0, 1.0,
        1.0, 0.0,
        0.0, 0.0

    ]
    
    var marsTextureInfo: GLKTextureInfo? = nil
    var plutoTextureInfo: GLKTextureInfo? = nil
    var backgroundTextureInfo: GLKTextureInfo? = nil
    
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
        theHighScore.highScores = (theControl?.getHighScores())!
        theMainMenu.theControl = theControl
        winstate.theControl = theControl

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
        
        let marsTextureImage: UIImage = UIImage(named: "playerShip")!
        marsTextureInfo = try! GLKTextureLoader.texture(with: marsTextureImage.cgImage!, options: [:])
        
        let plutoTextureImage: UIImage = UIImage(named: "pluto")!
        plutoTextureInfo = try! GLKTextureLoader.texture(with: plutoTextureImage.cgImage!, options: [:])
        
        let backgroundImage: UIImage = UIImage(named: "level1")!
        backgroundTextureInfo = try! GLKTextureLoader.texture(with: backgroundImage.cgImage!, options: [:])
        
        
        glClearColor(0.0, 0.0, 0.0, 0.0)
        
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
                        animationX1 -= shipdSpeed
                        collectCoors[0] -= shipdSpeed
                        collectCoors[1] -= shipdSpeed
                        
                    }
 
                    break
                case .right:
                    if(collectCoors[1] <= 1.0)
                    {
                        animationX1 += shipdSpeed
                        collectCoors[0] += shipdSpeed
                        collectCoors[1] += shipdSpeed
                    }
                    break
                case .up:
                    if(collectCoors[2] + animationY1 <= 2.5)
                    {
                        animationY1 += shipdSpeed
                        collectCoors[2] += shipdSpeed
                        collectCoors[3] += shipdSpeed
                    }
                    break
                case .down:
                    if(collectCoors[3] + animationY1 >= -0.8){
                        animationY1 -= shipdSpeed
                        collectCoors[2] -= shipdSpeed
                        collectCoors[3] -= shipdSpeed
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
                score += 25
                theGame.setScore(score: score)
            }
            
            if(theResuts.hit[0] == 1){
                enemyHit(index: theResuts.hit[1])
                lifeBar -= damage
            }
            if(lifeBar >= 0)
            {
                gameProgGreen?.removeFromSuperview()
                gameProgGreen = UIView(frame: CGRect(x: 200, y: 50, width: lifeBar * 2, height: 5))
                gameProgGreen?.backgroundColor = .green
                theGame.addSubview(gameProgGreen!)

            }
            else{
                gameProgGreen?.removeFromSuperview()
                gameProgGreen = UIView(frame: CGRect(x: 200, y: 50, width: 0, height: 5))
                gameProgGreen?.backgroundColor = .green
                theGame.addSubview(gameProgGreen!)
                animationX1 = 3
                collectCoors[0] = 3
                collectCoors[1] = 3

                //winstate.isUserInteractionEnabled = true
                theGame.removeFromSuperview()
                if(theControl?.checkScore(score: score))!
                {
                    winstate.highScore = true
                    theHighScore.highScores = (theControl?.getHighScores())!
                    theHighScore.reload()
                }
                else{
                    winstate.highScore = false
                }
                self.view.addSubview(winstate)
                pause = true
                theMainMenu.greyOut()
            }
 
            
            theControl?.updateBullet(bulletList: bulletList)
            
            count += 1
            
            var enIndex = 0
            
            
            
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
            
                animation[enIndex*2 + 1] -= speed
                enemyCoors[enIndex][2] -= speed
                enemyCoors[enIndex][3] -= speed
                if(enemyCoors[enIndex][2] < -1.1){
                    enemyInPlay[enIndex] = false
                }
                
            }
            
            enIndex += 1
            
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                animation[enIndex*2 + 1] += speed
                enemyCoors[enIndex][2] += speed
                enemyCoors[enIndex][3] += speed
                if(enemyCoors[enIndex][2] > 1){
                    enemyInPlay[enIndex] = false
                }
            }
            

            
            enIndex += 1
            
            
            
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                
                animation[enIndex*2 + 1] -= speed
                enemyCoors[enIndex][2] -= speed
                enemyCoors[enIndex][3] -= speed
                if(enemyCoors[enIndex][3] < -1.1){
                    enemyInPlay[enIndex] = false
                }
            }
            
            enIndex += 1
        
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                animation[enIndex*2 + 1] += speed
                enemyCoors[enIndex][2] += speed
                enemyCoors[enIndex][3] += speed
                if(enemyCoors[enIndex][2] > 1){
                    enemyInPlay[enIndex] = false
                }
            }
            
            enIndex += 1
            
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                animation[enIndex*2] -= speed
                animation[enIndex*2 + 1] += speed
                enemyCoors[enIndex][0] += -speed
                enemyCoors[enIndex][1] += -speed
                enemyCoors[enIndex][2] += speed
                enemyCoors[enIndex][3] += speed
                if(enemyCoors[enIndex][2] > 1.2 || enemyCoors[enIndex][0] < -1.2){
                    enemyInPlay[enIndex] = false
                }
                
            }
            enIndex += 1

            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                animation[enIndex*2] += speed
                animation[enIndex*2 + 1] -= speed
                enemyCoors[enIndex][0] += speed
                enemyCoors[enIndex][1] += speed
                enemyCoors[enIndex][2] += -speed
                enemyCoors[enIndex][3] += -speed
                if(enemyCoors[enIndex][2] < -1.2 || enemyCoors[enIndex][0] > 1.2){
                    enemyInPlay[enIndex] = false
                }
 
            }
            
            enIndex += 1
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                animation[enIndex*2] -= speed
                animation[enIndex*2 + 1] -= speed
                enemyCoors[enIndex][0] += -speed
                enemyCoors[enIndex][1] += -speed
                enemyCoors[enIndex][2] += -speed
                enemyCoors[enIndex][3] += -speed
                if(enemyCoors[enIndex][3] < -1.2 || enemyCoors[enIndex][0] < -1.2){
                    enemyInPlay[enIndex] = false
                }
                
                
            }
            enIndex += 1
            
            if(count >= timing[enIndex] && enemyInPlay[enIndex])
            {
                animation[enIndex*2] += speed
                animation[enIndex*2 + 1] += speed
                
                enemyCoors[enIndex][0] += speed
                enemyCoors[enIndex][1] += speed
                enemyCoors[enIndex][2] += speed
                enemyCoors[enIndex][3] += speed
                if(enemyCoors[enIndex][2] > 1.2 || enemyCoors[enIndex][0] > 1.2){
                    enemyInPlay[enIndex] = false
                }
            }
            
       
            if(checkWinState()){
                
                if(theLevel == level.one)
                {
                    let backgroundImage: UIImage = UIImage(named: "level2")!
                    backgroundTextureInfo = try! GLKTextureLoader.texture(with: backgroundImage.cgImage!, options: [:])

                    newLevel()
                    speed = 0.006
                    damage = 15
                    if(stage == 0)
                    {
                        stage += 1
                    }
                    else{
                        stage = 0
                        timing = [300, 0, 30, 200, 260, 180, 120, 70]
                        theLevel = level.two
                    }

                }
                else if(theLevel == level.two)
                {
                    newLevel()
                    let backgroundImage: UIImage = UIImage(named: "level3")!
                    backgroundTextureInfo = try! GLKTextureLoader.texture(with: backgroundImage.cgImage!, options: [:])
                    speed = 0.012
                    damage = 20
                    if(stage == 0)
                    {
                        timing = [0, 120, 70, 180, 200, 260, 300, 360]
                        stage += 1
                    }
                    else if(stage == 1){
                        timing = [300, 0, 30, 200, 260, 180, 120, 70]
                        stage += 1
                    }
                    else{
                        timing = [100, 50, 30, 170, 230, 200, 120, 0]
                        theLevel = level.three
                    }
                }
                else{

                    theGame.removeFromSuperview()
                    self.view.addSubview(winstate)
                    pause = true
                    theMainMenu.greyOut()
                }
            }
        }
        
        glBindTexture(GLenum(GL_TEXTURE_2D), backgroundTextureInfo!.name)
        glUniform2f(glGetUniformLocation(program, "translate"), 0.0, 0.0)
        glDrawArrays(GLenum(GL_TRIANGLES), 54, 6)
        
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
        bullet.backgroundColor = UIColor.red
        theGame.addSubview(bullet)
        bulletList.append(bullet)
        
        
        
    }
    
    func popArray(){
        enemyCoors.removeAll()
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
        let backgroundImage: UIImage = UIImage(named: "level1")!
        theLevel = level.one
        stage = 0
        backgroundTextureInfo = try! GLKTextureLoader.texture(with: backgroundImage.cgImage!, options: [:])
        popArray()
        animation = [Float](repeating: 0.0, count: 16)
        timing = [0, 120, 70, 180, 200, 260, 300, 360]
        animationX1 = 0.0
        animationY1 = 0.0
        collectCoors = [-0.3, 0.3, -1.0, -0.8]
        enemyInPlay = [true, true, true, true, true, true, true, true]
        self.view.addSubview(theGame)
        theMainMenu.removeFromSuperview()
        pause = false
        count = 0
        lifeBar = 100
        speed = 0.003
        damage = 10
        score = 0
        theGame.setScore(score: score)
        for b in bulletList{
            let index = bulletList.index(of: b)
            bulletList[index!].removeFromSuperview()
            bulletList.remove(at: index!)
        }
    }
    
    func newLevel(){
        popArray()
        animation = [Float](repeating: 0.0, count: 16)
        enemyInPlay = [true, true, true, true, true, true, true, true]
        pause = false
        count = 0
    }
    
    
    
    


}


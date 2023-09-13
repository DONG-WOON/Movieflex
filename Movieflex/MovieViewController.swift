//
//  MovieViewController.swift
//  Movieflex
//
//  Created by 서동운 on 7/19/23.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var previewFirstImageView: UIImageView!
    @IBOutlet weak var previewSecondImageView: UIImageView!
    @IBOutlet weak var previewThirdImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designPlayButton()
        
        designImageView(name: previewFirstImageView)
        designImageView(name: previewSecondImageView)
        designImageView(name: previewThirdImageView)
        
        setRandomMovieImage(of: posterImageView)
        
        signupButton.addTarget(self, action: #selector(goToSignup), for: .touchUpInside)
    }
    
    @objc func goToSignup() {
        let vc = SignupViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func unwindToMovieVC(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func playButtonDidTapped(_ sender: UIButton) {
        setRandomMovieImage(of: posterImageView)
        setRandomMovieImage(of: previewFirstImageView)
        setRandomMovieImage(of: previewSecondImageView)
        setRandomMovieImage(of: previewThirdImageView)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        // 알럿
        let alert = UIAlertController(title: "주의", message: "내가 찜한 컨텐츠가 없습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true)
        
        // 액션시트
//        let alert = UIAlertController(title: "찜한 컨텐츠", message: nil, preferredStyle: .actionSheet)
//        let okAction = UIAlertAction(title: "확인", style: .default)
//        let suspendAction = UIAlertAction(title: "보류", style: .destructive)
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
//        alert.addAction(okAction)
//        alert.addAction(suspendAction)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true)
        
    }
    
    fileprivate func setRandomMovieImage(of imageView: UIImageView) {
        let randomNumber = Int.random(in: 1...5)
        imageView.image = UIImage(named: "\(randomNumber)")
    }
    
    fileprivate func designImageView(name imageView: UIImageView) {
        setRandomMovieImage(of: imageView)
        
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 3
        imageView.contentMode = .scaleAspectFit
    }
    
    fileprivate func designPlayButton() {
        let normalImage = UIImage(named: "play_normal")
        let highlightedImage = UIImage(named: "play_highlighted")
        
        playButton.setTitleColor(.white, for: .normal)
        playButton.setTitleColor(.red, for: .highlighted)
        playButton.setImage(normalImage, for: .normal)
        playButton.setImage(highlightedImage, for: .highlighted)
    }
}


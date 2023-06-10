//
//  OnboardingViewController.swift
//  HamHam
//
//  Created by Defne Çetiner on 22.04.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var NextButtonOutlet: UIButton!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
                if currentPage == slides.count - 1 {
                    NextButtonOutlet.setTitle("Hadi başlayalım", for: .normal)
                } else {
                    NextButtonOutlet.setTitle("Devam Et", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [
                    OnboardingSlide(title: "Sofralarınıza zenginlik katın", description: "Farklı tariflere göz atın. Damak tadınız bayram etsin.", image: #imageLiteral(resourceName: "1")),
                    OnboardingSlide(title: "Unutulmayan Tarifler...", description: "Tariflerinizi unutma endişenizi rafa kaldırıyoruz. Dilediğiniz tarifi HamHam'a kayıt edebilirsiniz.", image: #imageLiteral(resourceName: "2")),
                    OnboardingSlide(title: "Hazır mısınız? İşte başlıyoruz...", description: "Türkiye'nin en zengin yemek arşivi sizi bekliyor. Denenmiş binlerce tarife Göz atabilirsiniz.", image: #imageLiteral(resourceName: "3"))
                ]
    }
    
   
    @IBAction func nextButtonAction(_ sender: Any) {
        if currentPage == slides.count - 1 {
            performSegue(withIdentifier: "goHomePage" , sender: nil)
              }
        
             else {
                  currentPage += 1
                  let indexPath = IndexPath(item: currentPage, section: 0)
                  collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
              }
    }
    
}
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
            cell.setap(slides[indexPath.row])
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }
    }

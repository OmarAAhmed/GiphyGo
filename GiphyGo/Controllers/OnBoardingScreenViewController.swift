//
//  OnBoardingScreenViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import UIKit

class OnBoardingScreenViewController: UIPageViewController{
    
    var currentStage = 0
    var presenter = OnBoardingScreenPresenter()
    
     func configurePageView() {
        setViewControllers([presenter.getCurrentStaggeViewController(stage: currentStage, sender: self)], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.view.backgroundColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageView()
        setupPageControl()
    }
}

protocol PageViewControllerNavigation {
    func next(viewController: UIViewController)
}

extension OnBoardingScreenViewController: PageViewControllerNavigation{
    func next(viewController: UIViewController) {
        if viewController.isKind(of: CountryViewController.self) {
            currentStage += 1
            setViewControllers([presenter.getCurrentStaggeViewController(stage: currentStage, sender: self)], direction: .forward, animated: true, completion: nil)
        } else {
            presenter.navigateToTabBar{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension OnBoardingScreenViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentStage
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return 2
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentStage
    }
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.isUserInteractionEnabled = false
    }
}



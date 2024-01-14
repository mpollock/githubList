//
//  LoadingState.swift
//  Github List
//
//  Created by Michael on 1/14/24.
//

public enum LoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}

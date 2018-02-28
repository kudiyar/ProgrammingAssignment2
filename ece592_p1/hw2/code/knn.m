function [err0] = knn(num_neighbors, train, test)
%% regular knn with majority voting nearest neighbors
    test_NN=zeros(size(test,2),1); % classification results on test data
    for n1=1:size(test,2)
            distances=(test(1,n1)-train(1,:)).^2+(test(2,n1)-train(2,:)).^2; % distances to training samples
            [~,distances_index] = sort(distances);
            neighbors=distances_index(1:num_neighbors);
            class_predicted=(sum(train(3, neighbors))/num_neighbors>0.5);
            %class_predicted=(sum(class_samples(neighbors))/num_neighbors>0.5); % NN classifier
            test_NN(n1)=class_predicted; % store classification
    end
    err0=sum((test_NN' ~= test(3,:)))/length(test_NN);
end
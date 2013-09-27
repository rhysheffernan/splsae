%function test_example_DBN
load mnist_uint8;

train_x = double(train_x) / 255;
test_x  = double(test_x)  / 255;
train_y = double(train_y);
test_y  = double(test_y);

%%  ex1 train a 100 hidden unit RBM and visualize its weights
%rng(0);
% dbn.sizes = [100 100 100];
% opts.numepochs =   10;
% opts.batchsize = 100;
% opts.momentum  =   0;
% opts.alpha     =   1;
% dbn = dbnsetup(dbn, train_x, opts);
% dbn = dbntrain(dbn, train_x, opts);
% figure; visualize(dbn.rbm{1}.W');   %  Visualize the RBM weights
% figure; visualize(dbn.rbm{2}.W');   %  Visualize the RBM weights

%%  ex2 train a 100-100 hidden unit DBN and use its weights to initialize a NN
%rng(0);
%train dbn
dbn.sizes = [100 100 100];
opts.numepochs =  100;
opts.batchsize = 100;
opts.momentum  =   0;
opts.alpha     =   0.8;
dbn = dbnsetup(dbn, train_x, opts);
dbn = dbntrain(dbn, train_x, opts);

%unfold dbn to nn
nn = dbnunfoldtonn(dbn, 10);

%train nn
nn.learningRate  = 0.8;
opts.numepochs =  100;
opts.batchsize = 100;
nn = nntrain(nn, train_x, train_y, opts);
[er, bad] = nntest(nn, test_x, test_y);
er

assert(er < 0.12, 'Too big error');
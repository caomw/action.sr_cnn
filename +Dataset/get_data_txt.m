function dataset = get_data_txt(dataset)
if strcmp(dataset.name, 'jhmdb')
    num_frame_offset = -1;
end
dataset.cls_2_id = containers.Map(dataset.classes, 0:length(dataset.classes)-1);
for s = 1:length(dataset.train_splits)
    %% training
    train_idx = find(dataset.train_splits{s});
    train_idx = train_idx(randperm(length(train_idx)));
    % shuffle training idx
    fid = fopen(sprintf('imdb/cache/%s_train_rgb_split%d.txt', dataset.name, s),'w');
    for i = 1:length(train_idx)
        fprintf(fid, '%s/%s/%s %d %d\n', ...
            dataset.root, ...
            dataset.video_cls{train_idx(i)}, ...
            dataset.video_ids{train_idx(i)}, ...
            dataset.num_frames(train_idx(i)), ...
            dataset.cls_2_id(dataset.video_cls{train_idx(i)}));
    end
    fclose(fid);
    % shuffle training idx
    fid = fopen(sprintf('imdb/cache/%s_train_flow_split%d.txt', dataset.name, s),'w');
    for i = 1:length(train_idx)
        fprintf(fid, '%s/%s/%s/%s %d %d\n', ...
            dataset.flow_dir, ...
            dataset.name, ...
            dataset.video_cls{train_idx(i)}, ...
            dataset.video_ids{train_idx(i)}, ...
            dataset.num_frames(train_idx(i))+num_frame_offset, ...
            dataset.cls_2_id(dataset.video_cls{train_idx(i)}));
    end
    fclose(fid);

    %% validation
    fid = fopen(sprintf('imdb/cache/%s_val_rgb_split%d.txt', dataset.name, s),'w');
    test_idx = find(dataset.test_splits{s});
    for i = 1:length(test_idx)
        fprintf(fid, '%s/%s/%s %d %d\n', ...
            dataset.root, ...
            dataset.video_cls{test_idx(i)}, ...
            dataset.video_ids{test_idx(i)}, ...
            dataset.num_frames(test_idx(i)), ...
            dataset.cls_2_id(dataset.video_cls{test_idx(i)}));
    end
    fclose(fid);
    fid = fopen(sprintf('imdb/cache/%s_val_flow_split%d.txt', dataset.name, s),'w');
    for i = 1:length(test_idx)
        fprintf(fid, '%s/%s/%s/%s %d %d\n', ...
            dataset.flow_dir, ...
            dataset.name,...
            dataset.video_cls{test_idx(i)}, ...
            dataset.video_ids{test_idx(i)}, ...
            dataset.num_frames(test_idx(i))+num_frame_offset, ...
            dataset.cls_2_id(dataset.video_cls{test_idx(i)}));
    end
end

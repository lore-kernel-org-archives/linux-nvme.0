From: harryxiyou@gmail.com (harryxiyou)
Date: Thu, 11 Sep 2014 03:43:08 +0800
Subject: Which core does a NVMe IO request would go?
Message-ID: <CAD+1EGP=RLHGJYfK6PUUjA7X_W9GMRq2QS3OP9J87vjEyJpBLg@mail.gmail.com>

Dear all,

I am not sure "Which core does a NVMe IO request would go?" after
I read the NVMe driver source codes.

The code says that,


 648 static int nvme_make_request(struct request_queue *q, struct request *req)
 649 {
 650     struct nvme_ns *ns = q->queuedata;
 651     struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
...
 659
 660     return result;
 661 }


 289 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 290 {
 291     return dev->queues[get_cpu() + 1];
 292 }


dev->queues[get_cpu() + 1] tells us which core it goes but I don't know
what get_cpu() returns.


Could you please give me some suggestions?


Thanks, Harry

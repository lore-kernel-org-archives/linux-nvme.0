From: dingxiang@huawei.com (dingxiang)
Date: Thu, 30 Apr 2015 09:26:13 +0800
Subject: some questions about create I/O queues
In-Reply-To: <alpine.LNX.2.00.1504291321260.15930@localhost.lm.intel.com>
References: <1425382201-2556-1-git-send-email-sunad.s@samsung.com>
 <004301d060aa$99924070$ccb6c150$@samsung.com>
 <20150317125914.GB4003@linux.intel.com> <5540471F.5030606@huawei.com>
 <alpine.LNX.2.00.1504291321260.15930@localhost.lm.intel.com>
Message-ID: <554184B5.8070207@huawei.com>

On 2015/4/29 21:22, Keith Busch wrote:

> On Tue, 28 Apr 2015, dingxiang wrote:
>>   When I create I/O queues and not create from qid 1,for example, I create
>>   from qid 3,then I insmod nvme driver, there will be some error information as below
> 
> How did you manage to create IO queues starting from QID 3 when the
> driver wasn't loaded?
> 
> 

HI,Keith
   I have modified two places to create queues from QID 3 before the driver loaded,
details are as follows:
   kernel version:3.10

diff --git a/nvme-core.c b/nvme-core.c
index ce79a59..8325b58 100644
--- a/nvme-core.c
+++ b/nvme-core.c
@@ -226,7 +226,7 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,

 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-       return dev->queues[get_cpu() + 1];
+       return dev->queues[3];
 }

 void put_nvmeq(struct nvme_queue *nvmeq)
@@ -1703,7 +1703,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)

        q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
                                                                NVME_Q_DEPTH);
-       for (i = 0; i < nr_io_queues; i++) {
+       for (i = 2; i < nr_io_queues; i++) {
                dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
                if (IS_ERR(dev->queues[i + 1]))
                        return PTR_ERR(dev->queues[i + 1]);

   Thanks !

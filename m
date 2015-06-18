From: junjie.qian@yahoo.com (Junjie Qian)
Date: Thu, 18 Jun 2015 23:46:30 +0000 (UTC)
Subject: Question on the hardware dispatch queue in blk-mq and NVMe
 submission queue
Message-ID: <103340548.1813618.1434671190366.JavaMail.yahoo@mail.yahoo.com>

Hi all, 

I have one question (in latest kernel, 4.1.0) regarding the hardware dispatch queue in blk-mq and the submission queue in NVMe, that are these two queues the same one in the implementation? 

In another word, one IO (to SSD connected with NVMe) is issued from CPU, goes to the per-core software queue, then to hardware dispatch queue, what is next? The submission queue in NVMe or the device? 

Thanks! 
Best 
Junjie

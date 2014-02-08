From: xun.ni@intel.com (Ni, Xun)
Date: Sat, 8 Feb 2014 03:23:31 +0000
Subject: NVME device have unusual write performance
Message-ID: <91E2D863603AD4478F101CE81E76E45D01908ECC@SHSMSX103.ccr.corp.intel.com>

Hello, Matthew:

  I get a nvme device and finish performance test on this block device. According to the test result, there is some weird place in the write performance. I don't know whether I have something wrong in the testing, so I post it here:

  My kernel: 3.13.0+ , I am using FIO to test the performance, it directly read/write on the /dev/nvme0n1p1 with sync mode

  The attachment is the result. It compare the performance between NVME and Intel SSD 3500.

  Is it a problem or just a setting issue? Do you meet this problem before?

   Sorry for send twice because linux-nvme doesn't support HTML mail.

Thanks,
Xun
-------------- next part --------------
A non-text attachment was scrubbed...
Name: NVME_performance_result.zip
Type: application/x-zip-compressed
Size: 70463 bytes
Desc: NVME_performance_result.zip
URL: <http://merlin.infradead.org/pipermail/linux-nvme/attachments/20140208/80dd67cf/attachment-0001.bin>

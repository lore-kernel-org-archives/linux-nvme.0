From: bj.sung@sk.com (=?ks_c_5601-1987?B?vLq56cDn?=)
Date: Thu, 11 Jan 2018 06:41:49 +0000
Subject: The need for round robin path selector in nvme multipath
Message-ID: <d673362d861044979094e397f910c61f@skt-tnetpmx1.SKT.AD>

Hello.

We are testing dual-port NVMe SSD with nvme multipath code.
(http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-mpath)
Thanks Christoph. It is wonderful.

And I found that there is no plan to implement round robin path selector in this thread.
(http://lists.infradead.org/pipermail/linux-nvme/2017-November/013853.html)

However, in our environment, I think that there is a need for round robin path selector in nvme multipath.
Specifically, we measured that each port showed 400k IOPS for random read and 1.7 GB/s for sequential read in dual-port NVMe SSD.
After the simple implementation of round robin path selector in function nvme_find_path to utilize two ports, it showed that 500k IOPS for random read and 3.4 GB/s for sequential read.

I would like to discuss about this need.

Thanks.
/Jay Sung

From: xuehua@marvell.com (Xuehua Chen)
Date: Thu, 7 Jan 2016 17:34:53 +0000
Subject: Maximum NVMe IO command size > 1MB?
In-Reply-To: <568E4E6A.5000907@dev.mellanox.co.il>
References: <cc642ee3fec8476b9034e1ee397e8f42@SC-EXCH01.marvell.com>
 <20160106193127.GA20732@localhost.localdomain>
 <680a6c16f5464419b7e1974d04026951@SC-EXCH01.marvell.com>
 <568E4E6A.5000907@dev.mellanox.co.il>
Message-ID: <6828ca62cf25413a9be3b1ab8bcbe0e4@SC-EXCH01.marvell.com>

>I think 2048 is 1MB...
Could you double check?
>From https://www.kernel.org/doc/Documentation/block/queue-sysfs.txt

max_hw_sectors_kb (RO)
----------------------
This is the maximum number of kilobytes supported in a single data transfer.

> I don't think it's coming from any other limitation in the block layer since I'm able to transfer 8M and more in a single request with iser.

Is this transfer done via a single bio? How did you determine the single transfer size?

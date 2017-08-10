From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 10 Aug 2017 10:46:38 -0600
Subject: [PATCH] nvme: fix directive command numd calculation
In-Reply-To: <20170810110946.GA32638@lst.de>
References: <CGME20170809182322epcas2p177ff5f42184c24dcab4a73a9c640916b@epcas2p1.samsung.com>
 <1502303189-11939-1-git-send-email-kwan.huen@ssi.samsung.com>
 <6cfd6f4a-ead7-2e60-398e-748dd1b62b3c@kernel.dk>
 <20170810083650.GA22739@lst.de> <20170810110946.GA32638@lst.de>
Message-ID: <bb98568b-f8bf-5c88-4093-44491291a561@kernel.dk>

On 08/10/2017 05:09 AM, Christoph Hellwig wrote:
> On Thu, Aug 10, 2017@10:36:50AM +0200, Christoph Hellwig wrote:
>> Do you want to take it directly for the block tree?
> 
> I've actually got a set of nvme 4.13 patches now that I did a sweep
> over the list, so I'd be happy to take it.  There is one other
> I want to merge pending an ok from Keith.  With that I could send
> you a PR tomorrow, so we could still get it into -rc5.

Please do just pick it up, as long as it gets queued up for 4.13.

-- 
Jens Axboe

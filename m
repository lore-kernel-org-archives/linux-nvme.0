From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Thu, 16 Jul 2015 14:23:44 +0200
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <20150617135905.GA17119@infradead.org>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org> <55787DDE.7020801@bjorling.me>
 <20150611102935.GA4419@infradead.org> <557C5787.3000608@bjorling.me>
 <20150617135905.GA17119@infradead.org>
Message-ID: <55A7A250.5050307@bjorling.me>

> As a start add a new submit_io method to the nvm_dev_ops, and add
> an implementation similar to pscsi_execute_cmd in
> drivers/target/target_core_pscsi.c for nvme, and a trivial no op
> for a null-nvm driver replacing the null-blk additions.  This
> will give you very similar behavior to your current code, while
> allowing to drop all the hacks in the block code.  Note that simple
> plugging will work just fine which should be all you'll need.
>

A quick question. The flow is getting into place and it is looking good.

However, the code path is still left with a per device flash block 
management core data structure in gendisk->nvm. ->nvm holds the device 
configuration (number of flash chips, channels, flash page sizes, etc.), 
free/used blocks in the media and other small structures. Basically 
keeping track of the state of the blocks on the media.

It is nice to have it associated with gendisk, as it then easily can be 
accessed from lightnvm code, without knowing which device driver that is 
underneath.

If moving it outside gendisk, one approach would be to create a separate 
block device for each open-channel ssd initialized. E.g. /dev/nvme0n1 
has its block management information exposed through 
/dev/lnvm/nvme0n1_bm. For each *_bm, the private field holds a map 
between request_queue and bm. Effectively using a gendisk to act as a 
link between the real device and any FTL target. This seems just as 
hacky as the gendisk approach.

Any other approaches or is gendisk good for now?

Thanks, Matias

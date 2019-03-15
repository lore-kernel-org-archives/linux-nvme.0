From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 15 Mar 2019 13:44:13 -0700
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190315182458.GB3582@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me> <20190312143231.GA1149@lst.de>
 <8a80ce70-0b98-6c82-a47c-f312a41d2d2a@grimberg.me>
 <20190315162837.GA27308@lst.de>
 <cd8a5428-602f-c9c9-3cf9-235d13a9451a@grimberg.me>
 <20190315182458.GB3582@lst.de>
Message-ID: <980e3462-bd5c-dff9-2498-c323adaf0852@grimberg.me>


>>> I actually tested it by manually hacking a 8k block size into nvmet
>>> and and it works just fine for me.  Where do you see a division by
>>> zero with this patch exactly?
>>
>> You need your block size to exceed u16 bs.
> 
> I'll need to look into actually testing something that large, 

just run blktests nvme/009 test with multipath, nothing fancy (I used
ext4).

 From a quick look I think that ext4 tempfiles are coming from
the transaction subsystem so maybe that's why the inode i_blkbits
is 20? Not sure at all though...

Anyways, its very easy to reproduce.

> but the whole point of my patch is that we never even use the bs value
> for anything. So I'm not sure why that would matter.

But than with multipath, blk_queue_stack_limits assume that we have a
valid bs in the lower device queue.

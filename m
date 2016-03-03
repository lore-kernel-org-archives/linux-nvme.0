From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 3 Mar 2016 19:24:10 +0800
Subject: blk-mq merge flags
In-Reply-To: <20160303084609.GA14051@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
 <56D7247C.4000208@dev.mellanox.co.il>
 <20160302211729.GA3803@lst.de>
 <CACVXFVM=-BSTGbrO1MqciCs4zPAt1Lfk1=9DZr+NNur-R96j_g@mail.gmail.com>
 <20160303084609.GA14051@lst.de>
Message-ID: <CACVXFVPVBZkfyvvh1xTZiHbBeZGYepYuEpXhfZZ9+_k61==KzQ@mail.gmail.com>

On Thu, Mar 3, 2016@4:46 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Mar 03, 2016@07:55:15AM +0800, Ming Lei wrote:
>> > command indeed.  Except for keeping the flags in sync, which sounds
>> > like a good ?dea in general there is not reall need for this one.
>>
>> NO_SG_MERGE has been bypassed after bio splitting is introduced,
>> and looks it should have been removed.
>
> Partially at least.  Anyway, let's start a discussion on blk-mq merge
> flags.
>
> First I really hate the way how any merges are opt-in.  I'd be much
> happier with an opt-out to get the sane behavior by default.  Every
> drivers set BLK_MQ_F_SHOULD_MERGE, and while only a few drivers set
> BLK_MQ_F_SG_MERGE I suspect all should as well.  Especially as the
> SG merging is cheaper and more useful than the bio mergig in many
> cases.

After bio splitting is introduced, SG merging becomes much cheaper, and
I can't see the difference between SG_MERGE and NO_SG_MERGE when
doing test over null_blk.

Once multipage bvecs is supported, SG merging should be always because
the bvec stored in bio->bi_io_vec can be thought as sort of segment.

Also from hardware view, it is often more efficient to handle less segments.
Last time Keith mentioned the point too about NVMe.

That is why I think we might consider to remove the flag.


-- 
Ming Lei

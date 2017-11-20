From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 10:33:11 +0200
Subject: [PATCH v2 0/3] Fix request completion holes
In-Reply-To: <20171120073755.GA2236@infradead.org>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <1510611044.3735.49.camel@redhat.com>
 <e89f72c6-12ce-c149-c81e-f3adb43a8e9e@grimberg.me>
 <20171120073755.GA2236@infradead.org>
Message-ID: <37edfd7b-2de3-ba30-8770-8a14266d7cdd@grimberg.me>


>>> Sagi, are you ready for me to take this series in?  It seemed like there
>>> was a question as to whether you might want to try atomics instead of
>>> spin locks, or do you want to stick with spinlocks?
>>
>> I still need a review for this, and I think we'll get it in through the
>> nvme tree (via the block tree). Thanks.
> 
> I've  done an initial review pass, but I'd really like to see someone
> who has more RDMA experience to take a look as well.

Perhaps Max can have a look?

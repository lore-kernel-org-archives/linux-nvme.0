From: jmoyer@redhat.com (Jeff Moyer)
Date: Fri, 28 Apr 2017 10:27:50 -0400
Subject: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request
 prototypes
In-Reply-To: <20170428140923.GA32073@lst.de> (Christoph Hellwig's message of
 "Fri, 28 Apr 2017 16:09:23 +0200")
References: <20170427174501.18965-1-hch@lst.de>
 <20170427174501.18965-2-hch@lst.de>
 <x49inlpsoey.fsf@segfault.boston.devel.redhat.com>
 <20170428140923.GA32073@lst.de>
Message-ID: <x494lx8r4ih.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

>> If you got rid of request_idx, then this shouldn't build.  So, is there
>> some other prerequisite patch I'm missing?
>
> Yes, both you and I are.  It's "mtip32xx: use runtime tag to initialize
> command header" which is in Jens' for-4.12/block tree, but not in the
> post-merge one.

I see.  With that patch, my concern about walking off the end of the
array is addressed.  Thanks.

-Jeff

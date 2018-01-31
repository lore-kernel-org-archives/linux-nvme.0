From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 31 Jan 2018 03:21:02 +0000
Subject: [dm-devel] [PATCH v5] blk-mq: introduce BLK_STS_DEV_RESOURCE
In-Reply-To: <7baf8e0f-7a15-4529-c32b-4ce0ee172598@kernel.dk>
References: <20180130142459.52668-1-snitzer@redhat.com>
 <43ac2314-c98d-bb76-0dfb-171d15cc5fd8@wdc.com>
 <7baf8e0f-7a15-4529-c32b-4ce0ee172598@kernel.dk>
Message-ID: <1517368861.4421.2.camel@wdc.com>

On Tue, 2018-01-30@20:17 -0700, Jens Axboe wrote:
> BLK_STS_RESOURCE should always be safe to return, and it should work
> the same as STS_DEV_RESOURCE, except it may cause an extra queue
> run.
> 
> Well written drivers should use STS_DEV_RESOURCE where it makes
> sense.

Hello Jens,

I would appreciate it if other names would be chosen than BLK_STS_RESOURCE
and BLK_STS_DEV_RESOURCE, e.g. names that directly refer to the fact that
one of the two status codes causes the queue to be rerun and the other not.
I'm afraid that the currently chosen names will cause confusion.

Thanks,

Bart.

From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 23 Sep 2016 10:26:24 -0600
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <1b3470a4-aedc-a33a-8863-4954cfa2f52d@kernel.dk>
References: <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org> <20160922210255.GA11015@infradead.org>
 <023c01d21519$b3cda450$1b68ecf0$@opengridcomputing.com>
 <20160922214800.GA16008@infradead.org>
 <024201d2151d$28013b90$7803b2b0$@opengridcomputing.com>
 <022301d2152d$94c202e0$be4608a0$@opengridcomputing.com>
 <20160923033157.GA12637@infradead.org>
 <b118929e-a841-6262-3bd1-5a5c840199f2@kernel.dk>
 <20160923162309.GA4330@infradead.org>
 <1b3470a4-aedc-a33a-8863-4954cfa2f52d@kernel.dk>
Message-ID: <87bdb4f5-69b6-915a-3349-fac26157d00b@kernel.dk>

On 09/23/2016 10:24 AM, Jens Axboe wrote:
> On 09/23/2016 10:23 AM, 'Christoph Hellwig' wrote:
>> On Fri, Sep 23, 2016@10:21:50AM -0600, Jens Axboe wrote:
>>> I'm going to flush the remaining patches for 4.8 later today. Did you
>>> send it out yet? If so, I haven't seen it. I'll be traveling the next 2
>>> weeks. With internet, so I'll get some work done, but it'll be a bit
>>> more intermittent.
>>
>> It's about two patches earlier in this thread, but I can just resend it.
>
> OK, I was just looking for an email after that reply, thinking you were
> sending a new one.

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=c8712c6a674e3382fe4d26d108251ccfa55d08e0


-- 
Jens Axboe

From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 29 Jan 2018 14:00:11 -0700
Subject: [LSF/MM TOPIC] Two blk-mq related topics
In-Reply-To: <1517259390.3969.41.camel@HansenPartnership.com>
References: <20180129154455.GB17176@ming.t460p>
 <1517259390.3969.41.camel@HansenPartnership.com>
Message-ID: <fc833da8-f9de-d577-e1d3-c46d8c061d35@kernel.dk>

On 1/29/18 1:56 PM, James Bottomley wrote:
> On Mon, 2018-01-29@23:46 +0800, Ming Lei wrote:
> [...]
>> 2. When to enable SCSI_MQ at default again?
> 
> I'm not sure there's much to discuss ... I think the basic answer is as
> soon as Christoph wants to try it again.

FWIW, internally I've been running various IO intensive workloads on
what is essentially 4.12 upstream with scsi-mq the default (with
mq-deadline as the scheduler) and comparing IO workloads with a
previous 4.6 kernel (without scsi-mq), and things are looking
great.

We're never going to iron out the last kinks with it being off
by default, I think we should attempt to flip the switch again
for 4.16.

-- 
Jens Axboe

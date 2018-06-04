From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 14:08:50 +0200
Subject: [PATCH v2] nvme: trace: add disk name to tracepoints
In-Reply-To: <5af6f3ad-0932-ae45-a6f2-90e8e45726c5@grimberg.me>
References: <20180604075612.7277-1-jthumshirn@suse.de>
 <5af6f3ad-0932-ae45-a6f2-90e8e45726c5@grimberg.me>
Message-ID: <20180604120850.GA29495@lst.de>

On Mon, Jun 04, 2018@02:48:57PM +0300, Sagi Grimberg wrote:
>
>> Add disk name to tracepoints so we can better destinguish between
>> individual disks in the trace output.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
>> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>
> Nit: s/destinguish/distinguish/g
>
> Christoph, can you fix it up when applying or you want me
> to do it?

I can fix it up.

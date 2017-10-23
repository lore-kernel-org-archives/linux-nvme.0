From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Oct 2017 18:57:20 +0200
Subject: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
In-Reply-To: <68df1af0-7cc8-febc-e2f6-85251f120a76@grimberg.me>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
 <68df1af0-7cc8-febc-e2f6-85251f120a76@grimberg.me>
Message-ID: <20171023165720.GA28944@lst.de>

On Mon, Oct 23, 2017@06:32:47PM +0300, Sagi Grimberg wrote:
>>   	struct nvme_queue *nvmeq = hctx->driver_data;
>>   +	printk_ratelimited("%s: called\n", __func__);
>> +
>
> This must be a left-over...

Indeed, it is a left-over debug statement..

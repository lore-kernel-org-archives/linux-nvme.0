From: jschoenh@amazon.de (=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=)
Date: Sun, 27 Aug 2017 18:56:07 +0200
Subject: [PATCH] nvme: fix uninitialized prp2 value on small transfers
In-Reply-To: <20170827160041.GA21416@lst.de>
References: <1503842197-29978-1-git-send-email-jschoenh@amazon.de>
 <20170827160041.GA21416@lst.de>
Message-ID: <aac68289-a199-47c5-8392-1b7435cc324d@amazon.de>

On 08/27/2017 06:00 PM, Christoph Hellwig wrote:
> On Sun, Aug 27, 2017@03:56:37PM +0200, Jan H. Sch?nherr wrote:
>> The value of iod->first_dma ends up as prp2 in NVMe commands. In case
>> there is not enough data to cross a page boundary, iod->first_dma is
>> never initialized and contains random data.
>>
>> Comply with the NVMe specification and fill in 0 in that case.
>
> Zeroing it out is fine with me, but NVMe 1.3 says:
>
>    PRP Entry 2 (PRP2): This field:
> 	a) is reserved if the data transfer does not cross a memory page boundary.
>
> so I don't think the specification requires it to be zeroed.

And under "1.5 Conventions" it says:

    Hardware shall return ?0? for all bits and registers that are marked as reserved,
    and host software shall write all reserved bits and registers with the value of ?0?.

> What kind of controller do you have that wants PRP2 zeroed for transfers
> that don't cross a page boundary?

This came up while doing some tracing on NVMe commands, and the random values
were a bit odd...

Regards
Jan

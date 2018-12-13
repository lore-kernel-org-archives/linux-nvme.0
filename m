From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Dec 2018 08:14:57 -0800
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181213155235.GA10566@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me> <20181213083157.GD869@lst.de>
 <4f3f213e-9042-5963-d47d-0ee501bf94fa@grimberg.me>
 <20181213155235.GA10566@lst.de>
Message-ID: <0c5c172f-9b34-3cba-37ab-a39ad9351da5@grimberg.me>

>>> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>>> +		bio->bi_opf &= ~REQ_HIPRI;
>>> +
>>
>> Maybe we can simply check (q->queue_flags & (1 << QUEUE_FLAG_POLL)) and
>> avoid the extra atomic operation in the host path?
>>
>> Would it make sense?
> 
> test_bit is not usually implemented as an atomic operation.
> 
> Take a look at e.g.
> 
> arch/x86/include/asm/bitops.h:constant_test_bit()

Ah.. But its still read from volatile argument so still more expensive?

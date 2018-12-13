From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 21:13:30 +0100
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <0c5c172f-9b34-3cba-37ab-a39ad9351da5@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me> <20181213083157.GD869@lst.de>
 <4f3f213e-9042-5963-d47d-0ee501bf94fa@grimberg.me>
 <20181213155235.GA10566@lst.de>
 <0c5c172f-9b34-3cba-37ab-a39ad9351da5@grimberg.me>
Message-ID: <20181213201330.GD15478@lst.de>

On Thu, Dec 13, 2018@08:14:57AM -0800, Sagi Grimberg wrote:
>>>> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>>>> +		bio->bi_opf &= ~REQ_HIPRI;
>>>> +
>>>
>>> Maybe we can simply check (q->queue_flags & (1 << QUEUE_FLAG_POLL)) and
>>> avoid the extra atomic operation in the host path?
>>>
>>> Would it make sense?
>>
>> test_bit is not usually implemented as an atomic operation.
>>
>> Take a look at e.g.
>>
>> arch/x86/include/asm/bitops.h:constant_test_bit()
>
> Ah.. But its still read from volatile argument so still more expensive?

I don't think the volatile should make a difference.  I actually
compiled both versions and the test_bit version generates a movq + testl
insted of testb:

-	movq	120(%rbx), %rdx	# MEM[(const long unsigned int *)q_38 + 120B], _135
-	testl	$524288, %edx	#, _135
+	testb	$8, 122(%rbx)	#, q_40->queue_flags

But actually generates a larger object:

 36966	   9470	     88	  46524	   b5bc	blk-core.o-opencode
 36956	   9470	     88	  46514	   b5b2	blk-core.o-test-bit

No idea what is going there.

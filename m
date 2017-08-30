From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 30 Aug 2017 18:33:46 +0300
Subject: [GIT PULL] nvme update for Linux 4.14, take 2
In-Reply-To: <1504106914.2526.5.camel@wdc.com>
References: <20170829150507.rjixn6uf3id6kltx@infradead.org>
 <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
 <38ddd70f-3fec-09c0-dafb-eba1e8f9cc18@grimberg.me>
 <1504106914.2526.5.camel@wdc.com>
Message-ID: <a798247e-cc89-f189-4ad9-92095a86106e@grimberg.me>


>> I just realized that patch:
>> --
>> commit d352ae205d8b05f3f7558d10f474d8436581b3e2
>> Author: Bart Van Assche <bart.vanassche at wdc.com>
>> Date:   Thu Aug 17 16:23:03 2017 -0700
>>
>>       blk-mq: Make blk_mq_reinit_tagset() calls easier to read
>>
>>       Since blk_mq_ops.reinit_request is only called from inside
>>       blk_mq_reinit_tagset(), make this function pointer an argument of
>>       blk_mq_reinit_tagset() instead of a member of struct blk_mq_ops.
>>       This patch does not change any functionality but makes
>>       blk_mq_reinit_tagset() calls easier to read and to analyze.
>> --
>>
>> Makes it impossible for me to move controller reset flow to
>> nvme-core without adding a trampoline (as the reinit_request
>> is transport specific)...
> 
> Hello Sagi,
> 
> Sorry but I doubt that that patch makes it "impossible" to move controller
> reset flow to the NVMe core. There are already several function pointers in
> the nvme_ctrl_ops data structure and there is one such data structure per
> transport. Had you already considered to add a function pointer to that
> structure?

I have, that's the trampoline function that I was referring to, it feels
a bit funny to have aa nvme core function that would look like:

int nvme_reinit_request()
{
	return ctrl->ops->reinit_request()
}

I can easily do that, but doesn't it defeat the purpose
of blk_mq_ops?

From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 21 Jun 2017 15:12:27 -0300
Subject: [PATCH 0/2] nvme/quirk: backport to v4.4 stable for
 PCI_DEVICE(0x1c58, 0x0003)
In-Reply-To: <fa981a33-215a-b899-ae7a-022d5de8f661@kernel.dk>
References: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <fa981a33-215a-b899-ae7a-022d5de8f661@kernel.dk>
Message-ID: <44f89242-60f3-2ef2-da6b-6492c15cca55@linux.vnet.ibm.com>

On 06/21/2017 03:05 PM, Jens Axboe wrote:
> On 06/21/2017 12:03 PM, Mauricio Faria de Oliveira wrote:
>> Hi Christoph, Jens, and Greg.
>>
>> Would you ack these 2 backports to be applied to v4.4 stable?
>>
>> The backports differ from the upstream applied commits in two aspects:
>> 1) use PCI IDs directly rather than nvme quirk infrastructure (which was
>>    introduced later, commit 106198edb7 "nvme: add explicit quirk handling",
>>    and depends on many further changes, not required for this purpose).
>>     
>> 2) use 'struct nvme_dev->tagset' rather than 'struct nvme_ctrl->tagset'
>>    (similarly.)
>>
>> This has been built and tested on top of v4.4.70.
> 
> Applying those two to stable is fine with me.
> 

Thanks Maur?cio for the great backport (which I tested and it's working
properly, as expected).

And thanks Jens for the quick ack.
Cheers,


Guilherme

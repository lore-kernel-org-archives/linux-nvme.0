From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 27 Jun 2017 10:32:08 -0300
Subject: [PATCH 0/2] nvme/quirk: backport to v4.4 stable for
 PCI_DEVICE(0x1c58, 0x0003)
In-Reply-To: <20170627112934.GG10609@kroah.com>
References: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20170627112934.GG10609@kroah.com>
Message-ID: <bf99bef7-860d-12ca-2204-f790521325ad@linux.vnet.ibm.com>

On 06/27/2017 08:29 AM, Greg KH wrote:
> On Wed, Jun 21, 2017@03:03:21PM -0300, Mauricio Faria de Oliveira wrote:
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
> Always tell me what the git commit ids are for the patches in Linus's
> tree, as I need them.  I dug it out this time...
> 
> thanks,
> 
> greg k-h
> 

Thanks a lot Greg! Next time we won't forget.
Cheers,


Guilherme

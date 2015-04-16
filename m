From: javier@paletta.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Thu, 16 Apr 2015 17:14:06 +0200
Subject: [PATCH 5/5 v2] nvme: LightNVM support
In-Reply-To: <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-6-git-send-email-m@bjorling.me>
 <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
Message-ID: <694D3575-E49B-45BB-8E48-7188169B75F0@paletta.io>

Hi,

> On 16 Apr 2015,@16:55, Keith Busch <keith.busch@intel.com> wrote:
> 
> On Wed, 15 Apr 2015, Matias Bj?rling wrote:
>> @@ -2316,7 +2686,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
>> 	struct nvme_id_ctrl *ctrl;
>> 	void *mem;
>> 	dma_addr_t dma_addr;
>> -	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
>> +	u64 cap = readq(&dev->bar->cap);
>> +	int shift = NVME_CAP_MPSMIN(cap) + 12;
>> +	int nvm_cmdset = NVME_CAP_NVM(cap);
> 
> The controller capabilities' command sets supported used here is the
> right way to key off on support for this new command set, IMHO, but I do
> not see in this patch the command set being selected when the controller
> is enabled
> 
> Also if we're going this route, I think we need to define this reserved
> bit in the spec, but I'm not sure how to help with that.
> 
>> @@ -2332,6 +2704,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>> 	ctrl = mem;
>> 	nn = le32_to_cpup(&ctrl->nn);
>> 	dev->oncs = le16_to_cpup(&ctrl->oncs);
>> +	dev->oacs = le16_to_cpup(&ctrl->oacs);
> 
> I don't find OACS used anywhere in the rest of the patch. I think this
> must be left over from v1.
> 
> Otherwise it looks pretty good to me, but I think it would be cleaner if
> the lightnvm stuff is not mixed in the same file with the standard nvme
> command set. We might end up splitting nvme-core in the future anyway
> for command sets and transports.

Would you be ok with having nvme-lightnvm for LightNVM specific
commands?

Javier.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150416/ef38b819/attachment.sig>

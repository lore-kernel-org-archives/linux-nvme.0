From: david.darrington@hgst.com (David Darrington)
Date: Tue, 12 Apr 2016 20:31:10 +0000
Subject: [PATCH 2/2] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <570D569F.8020606@linux.vnet.ibm.com>
References: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1460405751-8884-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <01FE3AD6-3EC3-4806-9FC9-AC7C797D73BE@hgst.com>
 <570D569F.8020606@linux.vnet.ibm.com>
Message-ID: <531B064A-65F6-4A60-B2E6-CD536733D7DF@hgst.com>

Hi Guilherme,

Thanks for the clarification. I?ll followup with the product support team here and attempt to re-create.


Dave

On 4/12/16, 3:12 PM, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> wrote:

>On 04/12/2016 02:58 PM, David Darrington wrote:
>> When you say, ?This quirk is necessary because just
>> increasing the timeout is not enough - the driver must wait _before_
>> start reading NVME_REG_CSTS register on this specific adapter.,?
>> This doesn?t make sense to me. I?ve never seen this with the
>> HGST adapters. Have you reported this to HGST as a problem?
>
>Hey David, thanks very much for your comment. We're experiencing this 
>exact scenario, as described in commit message. Whenever the adapter 
>needs to be disabled, if we don't wait before reading the NVME_CSTS_RDY 
>bit, we end up reaching the timeout. The read result from this register 
>become 0xFFFF in sme time, and adapter is not able to finish the reset.
>
>If, on the other hand, we add this small timeout before start reading 
>the NVME_REG_CSTS register, everything works fine. Notice this patch is 
>a quirk, so if you are able to reproduce and have a firmware solution, 
>for example, it'd be better.
>
>Problem was reported to HGST (Murali is our contact) and the product 
>team is unable to find a root cause yet, while testers are hitting the 
>issue.
>
>Thank you,
>
>
>
>Guilherme
>
>
>>
>> On 4/11/16, 3:15 PM, "Linux-nvme on behalf of Guilherme G. Piccoli" <linux-nvme-bounces@lists.infradead.org on behalf of gpiccoli@linux.vnet.ibm.com> wrote:
>>
>>> When disabling the controller, the specification says the register
>>> NVME_REG_CC should be written and then driver needs to wait the
>>> adapter to be ready, which is checked by reading another register
>>> bit (NVME_CSTS_RDY). There's a timeout validation in this checking,
>>> so in case this timeout is reached the driver gives up and removes
>>> the adapter from the system.
>>>
>>> The PCI_DEVICE(0x1c58, 0x0003) (HGST adapter) end up being removed
>>> after a reset because driver keeps verifying the NVME_REG_CSTS until
>>> the timeout is reached. This patch adds a quirk for this adapter, by
>>> introducing a delay before nvme_wait_ready(), so the reset procedure
>>> is able to be completed. This quirk is necessary because just
>>> increasing the timeout is not enough - the driver must wait _before_
>>> start reading NVME_REG_CSTS register on this specific adapter.
>>>
>>> Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
>>> ---
>>> drivers/nvme/host/core.c |  4 ++++
>>> drivers/nvme/host/nvme.h | 13 +++++++++++++
>>> drivers/nvme/host/pci.c  |  2 ++
>>> 3 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 643f457..37817bb 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -824,6 +824,10 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>>> 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>>> 	if (ret)
>>> 		return ret;
>>> +
>>> +	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHECK_RDY)
>>> +		msleep(NVME_QUIRK_DELAY_AMOUNT_MS);
>>> +
>>> 	return nvme_wait_ready(ctrl, cap, false);
>>> }
>>> EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index f846da4..b8247c4 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -65,8 +65,21 @@ enum nvme_quirks {
>>> 	 * logical blocks.
>>> 	 */
>>> 	NVME_QUIRK_DISCARD_ZEROES		= (1 << 2),
>>> +
>>> +	/*
>>> +	* The controller needs a delay before starts checking the device
>>> +	* readiness, which is done by reading the NVME_CSTS_RDY bit.
>>> +	*/
>>> +	NVME_QUIRK_DELAY_BEFORE_CHECK_RDY	= (1 << 3),
>>> };
>>>
>>> +/* The below value is the specific amount of delay needed before checking
>>> + * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
>>> + * NVME_QUIRK_DELAY_BEFORE_CHECK_RDY quirk enabled. The value was found
>>> + * empirically. The value is in milliseconds.
>>> + */
>>> +#define NVME_QUIRK_DELAY_AMOUNT_MS		2000
>>> +
>>> struct nvme_ctrl {
>>> 	const struct nvme_ctrl_ops *ops;
>>> 	struct request_queue *admin_q;
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 220e0b5..a5e3d0e 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2173,6 +2173,8 @@ static const struct pci_device_id nvme_id_table[] = {
>>> 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
>>> 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
>>> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>>> +	{ PCI_DEVICE(0x1c58, 0x0003),	/*HGST adapter */
>>> +		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHECK_RDY, },
>>> 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>>> 	{ 0, }
>>> };
>>> --
>>> 2.1.0
>>>
>>>
>>> _______________________________________________
>>> Linux-nvme mailing list
>>> Linux-nvme at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>> Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:
>>
>> This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
>>
>

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF239EE6426
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2024 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GqF5tk5CCdE7I2Omn73wUtjDR/tONDpWlzVBUQnMAq8=; b=1l9NUomEbmoOPT3OgaAcX3L7IM
	Ze6TVjwnhwHXILswZNrP40u53gIXBfiHFUns3XFCtKB51BrC5PERpEJMEH5gHOBgBw/Lp5293bpNB
	vBI+lRikeBW1Dt/eEK0q9ffZqGf4/Rv76DHPddQFnZ1BbKStDMoWRimFCxyNU0LB098fA/bmnv2Z3
	ioNPj7o+eJGdX1lHFAW7PHsE6LNxGNYHKPOFT78lFWfoq8svz+TpuqAI8jpRBouxJxeVZLycT3vbe
	EmJMCASbOwWKFbkWAWCb3/swZcDEqn15ORQPQojtRq4KskH1eBlYNyQP7LJdyHX+QeS0KtUJRqKTa
	8BnNDgbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqZFI-00000006Jeh-1DBo;
	Tue, 17 Sep 2024 14:32:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqZFG-00000006JeS-3QIh
	for linux-nvme@bombadil.infradead.org;
	Tue, 17 Sep 2024 14:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GqF5tk5CCdE7I2Omn73wUtjDR/tONDpWlzVBUQnMAq8=; b=LhzdGgYiztEqnPQ4ifsGxsPbUJ
	hPd3tirI4nZ8LjGiDdF52NGntfC1M97XhVutfCJaiLTt4lzw6S2npf5Hpx9bPlfo88tllIwt7/Yla
	L1HLmbWhYfq9XJOI/In3MlbeVMLtKUqfITP4agYvmPkwbC+nflArwNtH43jH3lleLck9HH4uzseB6
	X9tDAzB4v/0q0Ywsqu8GtdPi5uzTkkTOGdinlfPByD2kEP/HxEeqJLxO9fhA0Qh6MsqiwrJuqNJ3l
	sb7lZ/AuYfHuEE/aWRg/uIONjH9LmSotipcSLAbg7jr0tS6fF1fh8bOABuZhMQ+LKE6rIu5Xnlizf
	5E1cc6/w==;
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqZFD-00000000cBM-0D1P
	for linux-nvme@lists.infradead.org;
	Tue, 17 Sep 2024 14:31:57 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so4011584b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2024 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726583512; x=1727188312; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqF5tk5CCdE7I2Omn73wUtjDR/tONDpWlzVBUQnMAq8=;
        b=iGwAAcnBCUgD3hCc04wUIuA3lQ2IjIM/VpjiHCvKizYtX2wteMqeA628t1xKn4v04v
         BXajR6xsREkG8/iojPzIDAIWbqPQU1Lz3iffFiRig2TauC3QdQIRtqoHXLLFnFxOpBJO
         fhljyjmgjUunmTwAsqfv+KSAuORyQXgtZJS5NkPRIauzkFkTUPb/t+7RECk4y8bVomvc
         4IHqs4tQhJy4Am2yIWg797G2oJD8UKjqB6tPHtElK2zURUFkgn5HTf7wdYFi0KuGOyN/
         cmmbkDMDKoyBO0OQ+L9D41pEqYnYr1OQjAiZ3R5SNfFedUk9HMXDIwdcW/Nj5u6OzFrE
         XmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583512; x=1727188312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqF5tk5CCdE7I2Omn73wUtjDR/tONDpWlzVBUQnMAq8=;
        b=fzJZAnS/+aLLV9vy8vUy1b2Zx/QtquBpQBr1NgDMRyu4SrWlmOhxWGsUXh0q6YEN7p
         hub/8SKjTVgCYptEPcuHHjHlexSu+pzuXjq0ZA4JGjupMLTVMIIvPU0Zgt2ewFQhYMrZ
         N2wJ8p0tYLE84Rg9AxoBN/YoFfVkpDTuBJI/jlGLut4e8lZW9WFbAGVBqmrxGl1Zxsjq
         648w0SKc/cAX0HIVv3qgGYI/EHWC5MpJKR+UrvkduzPWj47Cvm41ST/uZMISpuXO2/kP
         nw6nMo/SVGynQO7oDnTC07ZVvaqZ1bA1S6Z5oXlgXDp8DMwpCiZIe/3Vmn1STJ2Itsf6
         qnYQ==
X-Gm-Message-State: AOJu0YzAsQgzljcZT+5S1OevvSAo5401UDrdwYZsz87k4SVXc6feJaQs
	Yb0jJx7baTNg7sA4iajnf+632da/88f+UM+1vGH0AzPwEUxD8NX7
X-Google-Smtp-Source: AGHT+IFXFOzHhLRXtJrvG/MAhtzAkDKl8MZmZpqHV5TqUYsjc0nnfGBlAeqW7ImB5z/CBMmZGabMMg==
X-Received: by 2002:a05:6a00:21d4:b0:717:93d7:166b with SMTP id d2e1a72fcca58-719262065c5mr26988591b3a.25.1726583511504;
        Tue, 17 Sep 2024 07:31:51 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:eda1:ca50:32d0:a13c? ([240b:10:2720:5500:eda1:ca50:32d0:a13c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4990ca1esm5954927a12.35.2024.09.17.07.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 07:31:51 -0700 (PDT)
Message-ID: <788632b1-66c6-45b4-b8a9-c0556d53ab80@gmail.com>
Date: Tue, 17 Sep 2024 23:31:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: convert little endian NVME definitions to native
 format
To: Caleb Sander <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org
References: <20240916154422.356691-1-ikegami.t@gmail.com>
 <CADUfDZrqAgp49K2Ak-b230ERY8P66aXA4iAoCyyYr45PAbq+1Q@mail.gmail.com>
 <1bcdab96-f2cb-4116-9f04-4016b01bad36@gmail.com>
 <CADUfDZo=WwCTWwmY+UcUA7zpXb9CMpOsNC0icat7opwwFpJh=A@mail.gmail.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <CADUfDZo=WwCTWwmY+UcUA7zpXb9CMpOsNC0icat7opwwFpJh=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_153155_507236_EDB4F1CD 
X-CRM114-Status: GOOD (  19.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Yes just confirmed as the definition value is actually native byte order 
on the big endian environment as you mentioned.
Very sorry my first checking was incorrect. So let me drop the patch.

Regards,
Ikegami

On 2024/09/17 3:12, Caleb Sander wrote:
> On Mon, Sep 16, 2024 at 9:41 AM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>> For example the definition below is not native byte order I think.
>>       NVME_CTRL_ONCS_TIMESTAMP        = 1 << 6,
> Why not? CPUs assume native byte order for all arithmetic operations.
> The fact that you could print this value implies it must be
> represented in native byte order. Non-native endianness is only
> relevant when interacting with byte-addressable data external to the
> CPU (storage, network, etc.).
>
>> On 2024/09/17 1:12, Caleb Sander wrote:
>>> Why is this necessary? All these values obtained from the Identify
>>> Controller data structure are already stored in the CPU's native byte
>>> order. So testing them against native byte order constants looks
>>> correct.
>>>
>>> ctrl->oacs = le16_to_cpu(id->oacs);
>>> ctrl->oncs = le16_to_cpu(id->oncs);
>>> ctrl->mtfa = le16_to_cpu(id->mtfa);
>>> ctrl->oaes = le32_to_cpu(id->oaes);
>>> // ...
>>> ctrl->ctratt = le32_to_cpu(id->ctratt);
>>>
>>> On Mon, Sep 16, 2024 at 8:46 AM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>>>> This is to compare the definitions correctly with the converted values.
>>>>
>>>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>>>> ---
>>>>    drivers/nvme/host/core.c | 20 ++++++++++----------
>>>>    drivers/nvme/host/nvme.h |  4 ++--
>>>>    drivers/nvme/host/pci.c  |  2 +-
>>>>    3 files changed, 13 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index ca9959a8fb9e..5e26546e811a 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -1273,7 +1273,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
>>>>            * command completion can postpone sending a keep alive command
>>>>            * by up to twice the delay between runs.
>>>>            */
>>>> -       if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
>>>> +       if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS))
>>>>                   delay /= 2;
>>>>           return delay;
>>>>    }
>>>> @@ -1343,7 +1343,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
>>>>
>>>>           ctrl->ka_last_check_time = jiffies;
>>>>
>>>> -       if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
>>>> +       if ((ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS)) && comp_seen) {
>>>>                   dev_dbg(ctrl->device,
>>>>                           "reschedule traffic based keep-alive timer\n");
>>>>                   ctrl->comp_seen = false;
>>>> @@ -1699,7 +1699,7 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>>>>
>>>>    static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>>>    {
>>>> -       u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>>>> +       u32 result, supported_aens = ctrl->oaes & le32_to_cpu(NVME_AEN_SUPPORTED);
>>>>           int status;
>>>>
>>>>           if (!supported_aens)
>>>> @@ -1829,7 +1829,7 @@ static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
>>>>           if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
>>>>                   lim->max_hw_discard_sectors =
>>>>                           nvme_lba_to_sect(ns->head, ctrl->dmrsl);
>>>> -       else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
>>>> +       else if (ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_DSM))
>>>>                   lim->max_hw_discard_sectors = UINT_MAX;
>>>>           else
>>>>                   lim->max_hw_discard_sectors = 0;
>>>> @@ -1913,7 +1913,7 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
>>>>           if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>>>>                   return;
>>>>
>>>> -       if (nvm && (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
>>>> +       if (nvm && (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))) {
>>>>                   nvme_configure_pi_elbas(head, id, nvm);
>>>>           } else {
>>>>                   head->pi_size = sizeof(struct t10_pi_tuple);
>>>> @@ -2137,7 +2137,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>>>>           }
>>>>           lbaf = nvme_lbaf_index(id->flbas);
>>>>
>>>> -       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
>>>> +       if (ns->ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS)) {
>>>>                   ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
>>>>                   if (ret < 0)
>>>>                           goto out;
>>>> @@ -2341,7 +2341,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
>>>>
>>>>    static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
>>>>    {
>>>> -       if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
>>>> +       if (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_SEC_SUPP)) {
>>>>                   if (!ctrl->opal_dev)
>>>>                           ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
>>>>                   else if (was_suspended)
>>>> @@ -2520,7 +2520,7 @@ static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
>>>>           __le64 ts;
>>>>           int ret;
>>>>
>>>> -       if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
>>>> +       if (!(ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_TIMESTAMP)))
>>>>                   return 0;
>>>>
>>>>           ts = cpu_to_le64(ktime_to_ms(ktime_get_real()));
>>>> @@ -2541,7 +2541,7 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
>>>>           /* Don't bother enabling the feature if retry delay is not reported */
>>>>           if (ctrl->crdt[0])
>>>>                   acre = NVME_ENABLE_ACRE;
>>>> -       if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
>>>> +       if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))
>>>>                   lbafee = NVME_ENABLE_LBAFEE;
>>>>
>>>>           if (!acre && !lbafee)
>>>> @@ -3109,7 +3109,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>>>>            * controllers max_hw_sectors value, which is based on the MDTS field
>>>>            * and possibly other limiting factors.
>>>>            */
>>>> -       if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
>>>> +       if ((ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_WRITE_ZEROES)) &&
>>>>               !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
>>>>                   ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
>>>>           else
>>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>>> index 313a4f978a2c..25886b9d2796 100644
>>>> --- a/drivers/nvme/host/nvme.h
>>>> +++ b/drivers/nvme/host/nvme.h
>>>> @@ -860,9 +860,9 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
>>>>                   struct nvme_ns_head *head)
>>>>    {
>>>>           return head->shared ||
>>>> -               (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
>>>> +               (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_NS_MNGT_SUPP)) ||
>>>>                   (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
>>>> -               (ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
>>>> +               (ctrl->ctratt & le32_to_cpu(NVME_CTRL_CTRATT_NVM_SETS));
>>>>    }
>>>>
>>>>    /*
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index 7990c3f22ecf..f8fa424fa952 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -249,7 +249,7 @@ static void nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>>>>    {
>>>>           unsigned int mem_size = nvme_dbbuf_size(dev);
>>>>
>>>> -       if (!(dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP))
>>>> +       if (!(dev->ctrl.oacs & le16_to_cpu(NVME_CTRL_OACS_DBBUF_SUPP)))
>>>>                   return;
>>>>
>>>>           if (dev->dbbuf_dbs) {
>>>> --
>>>> 2.43.0
>>>>
>>>>


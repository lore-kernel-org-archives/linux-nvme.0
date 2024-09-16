Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D68AC3ABA2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7MW4+S0ZrtZ62Z7o767lO5zxBvgWJM0Q76agrWpgTk=; b=2aC0HlnjfIPCnqxJcE+gCbFgi2
	G2yoccuFva9YS5G1yYSxBrn8fuyTBNlybSovMzRFw5UbmwDE2apFDJNkHwG6EaN4GvpNTqmSZvDiH
	UFyBC98/iwPRNA62i8UZ9jzXmIpc5zw8+uzxCc0pmRJS2ruOnIwmcMHUpj97ySjm6C0X7NPCuNkI6
	G1TClyPr02XfnhycPamPSg0STP+lDaXH2Yk85JshXgM8TgWEuXDYdAcfTUiUHF3Q3UeATXKaPMlb0
	KLCua1HvV1A3K8rWs8EBXe9WGJPrUhVJfhVFY1br79eJiqbwJRZ0vRmIdMBxete1MhrsDdTfcE6v0
	mVSyL5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqEmq-00000004UX8-3bxc;
	Mon, 16 Sep 2024 16:41:16 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqEml-00000004UWH-0fY7
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 16:41:12 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-20536dcc6e9so25662925ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2024 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726504869; x=1727109669; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7MW4+S0ZrtZ62Z7o767lO5zxBvgWJM0Q76agrWpgTk=;
        b=KJD6Qe0ydQaKOWBFhSQu1kI5VcyWd9tMVzZ+L0CDmCTcGoVzV/lJbrOAPhFmtAO7FN
         evvzjMyivLoH3M9V/FEzn1+6BdvqWknzx4pQg1QWRoETjms5OMaEZrmlBx5k/vWhe3+5
         747IZK8BCFMCcG2GKHRBRnjVtxt3qWmU76+8HEmLGkkO/F+fRBoO1opLN4KCgVKiAfHc
         xJyOLejclBgjZydT/DGXyfRy8psaAM86SaK3AMl2GROJqwyUpzwd4E7eXBhugNgRWXZc
         u12v2eOhbklmUBIm8TsavuckqVOrN/fo7JK8xrO+JbtrKX3DjwpDhSTQ2Wd7GBNjbyj+
         Pd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726504869; x=1727109669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7MW4+S0ZrtZ62Z7o767lO5zxBvgWJM0Q76agrWpgTk=;
        b=jDv1vDZsVLQmhzO7Pe9d35lRhhAu7GLs3hCVVuPbcJgkTxBvOBiN1bYabLKePv6ohf
         q4SVvT8Q6DUkmaNbJWt+Qq2YZRYrauzuKXXU4AQ9ExV1WqJ+uAOyCdEOxl4HRdsVy3t7
         Cwj4AOevOJ3ouKhjkB8ugg+UP+ZTvpJtkeHHElaXDP/Gl/wO+A5xBq7PjC9nB6YmBn4M
         Q4HrE01x4dGDMf9FXGgCUdEBR0o3eGDT7Ff8cwt1cc0cU/Z8Qipe805cAyjs3FeMiG9u
         A7wtdDtQ+P1nwhZg8bnMTCV8IvHj0WRuS8hDRAh98PQb67zmH8RlWF9a7q+UKCjiMJ+w
         rFZw==
X-Gm-Message-State: AOJu0Yzr/dRpa2kIAvXOJqwza98/YUc4mr4izeErP2T2TBbnfPLNpxLH
	P51rkvynt/Vo4gPDUvTcw9UJBbGwo0FaVzw29wuBXeDzk2qFx3N0
X-Google-Smtp-Source: AGHT+IGAzR+/ASa1rJdffNkRat83uGrVNMJhy4u6t2srqKB+E1DzR4q0bbV1bfthkhzEKVm3hLcPbw==
X-Received: by 2002:a17:902:e54f:b0:206:b618:1d91 with SMTP id d9443c01a7336-2078262ce93mr180548145ad.5.1726504869347;
        Mon, 16 Sep 2024 09:41:09 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:497e:6580:bc24:5fdb? ([240b:10:2720:5500:497e:6580:bc24:5fdb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473161csm38066555ad.263.2024.09.16.09.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:41:09 -0700 (PDT)
Message-ID: <1bcdab96-f2cb-4116-9f04-4016b01bad36@gmail.com>
Date: Tue, 17 Sep 2024 01:41:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: convert little endian NVME definitions to native
 format
To: Caleb Sander <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org
References: <20240916154422.356691-1-ikegami.t@gmail.com>
 <CADUfDZrqAgp49K2Ak-b230ERY8P66aXA4iAoCyyYr45PAbq+1Q@mail.gmail.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <CADUfDZrqAgp49K2Ak-b230ERY8P66aXA4iAoCyyYr45PAbq+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_094111_234600_63CEFF9E 
X-CRM114-Status: GOOD (  20.85  )
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

For example the definition below is not native byte order I think.
     NVME_CTRL_ONCS_TIMESTAMP        = 1 << 6,

On 2024/09/17 1:12, Caleb Sander wrote:
> Why is this necessary? All these values obtained from the Identify
> Controller data structure are already stored in the CPU's native byte
> order. So testing them against native byte order constants looks
> correct.
>
> ctrl->oacs = le16_to_cpu(id->oacs);
> ctrl->oncs = le16_to_cpu(id->oncs);
> ctrl->mtfa = le16_to_cpu(id->mtfa);
> ctrl->oaes = le32_to_cpu(id->oaes);
> // ...
> ctrl->ctratt = le32_to_cpu(id->ctratt);
>
> On Mon, Sep 16, 2024 at 8:46 AM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>> This is to compare the definitions correctly with the converted values.
>>
>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>> ---
>>   drivers/nvme/host/core.c | 20 ++++++++++----------
>>   drivers/nvme/host/nvme.h |  4 ++--
>>   drivers/nvme/host/pci.c  |  2 +-
>>   3 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index ca9959a8fb9e..5e26546e811a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1273,7 +1273,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
>>           * command completion can postpone sending a keep alive command
>>           * by up to twice the delay between runs.
>>           */
>> -       if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
>> +       if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS))
>>                  delay /= 2;
>>          return delay;
>>   }
>> @@ -1343,7 +1343,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
>>
>>          ctrl->ka_last_check_time = jiffies;
>>
>> -       if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
>> +       if ((ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS)) && comp_seen) {
>>                  dev_dbg(ctrl->device,
>>                          "reschedule traffic based keep-alive timer\n");
>>                  ctrl->comp_seen = false;
>> @@ -1699,7 +1699,7 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>>
>>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>   {
>> -       u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>> +       u32 result, supported_aens = ctrl->oaes & le32_to_cpu(NVME_AEN_SUPPORTED);
>>          int status;
>>
>>          if (!supported_aens)
>> @@ -1829,7 +1829,7 @@ static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
>>          if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
>>                  lim->max_hw_discard_sectors =
>>                          nvme_lba_to_sect(ns->head, ctrl->dmrsl);
>> -       else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
>> +       else if (ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_DSM))
>>                  lim->max_hw_discard_sectors = UINT_MAX;
>>          else
>>                  lim->max_hw_discard_sectors = 0;
>> @@ -1913,7 +1913,7 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
>>          if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>>                  return;
>>
>> -       if (nvm && (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
>> +       if (nvm && (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))) {
>>                  nvme_configure_pi_elbas(head, id, nvm);
>>          } else {
>>                  head->pi_size = sizeof(struct t10_pi_tuple);
>> @@ -2137,7 +2137,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>>          }
>>          lbaf = nvme_lbaf_index(id->flbas);
>>
>> -       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
>> +       if (ns->ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS)) {
>>                  ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
>>                  if (ret < 0)
>>                          goto out;
>> @@ -2341,7 +2341,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
>>
>>   static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
>>   {
>> -       if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
>> +       if (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_SEC_SUPP)) {
>>                  if (!ctrl->opal_dev)
>>                          ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
>>                  else if (was_suspended)
>> @@ -2520,7 +2520,7 @@ static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
>>          __le64 ts;
>>          int ret;
>>
>> -       if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
>> +       if (!(ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_TIMESTAMP)))
>>                  return 0;
>>
>>          ts = cpu_to_le64(ktime_to_ms(ktime_get_real()));
>> @@ -2541,7 +2541,7 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
>>          /* Don't bother enabling the feature if retry delay is not reported */
>>          if (ctrl->crdt[0])
>>                  acre = NVME_ENABLE_ACRE;
>> -       if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
>> +       if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))
>>                  lbafee = NVME_ENABLE_LBAFEE;
>>
>>          if (!acre && !lbafee)
>> @@ -3109,7 +3109,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>>           * controllers max_hw_sectors value, which is based on the MDTS field
>>           * and possibly other limiting factors.
>>           */
>> -       if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
>> +       if ((ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_WRITE_ZEROES)) &&
>>              !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
>>                  ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
>>          else
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 313a4f978a2c..25886b9d2796 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -860,9 +860,9 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
>>                  struct nvme_ns_head *head)
>>   {
>>          return head->shared ||
>> -               (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
>> +               (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_NS_MNGT_SUPP)) ||
>>                  (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
>> -               (ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
>> +               (ctrl->ctratt & le32_to_cpu(NVME_CTRL_CTRATT_NVM_SETS));
>>   }
>>
>>   /*
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 7990c3f22ecf..f8fa424fa952 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -249,7 +249,7 @@ static void nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>>   {
>>          unsigned int mem_size = nvme_dbbuf_size(dev);
>>
>> -       if (!(dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP))
>> +       if (!(dev->ctrl.oacs & le16_to_cpu(NVME_CTRL_OACS_DBBUF_SUPP)))
>>                  return;
>>
>>          if (dev->dbbuf_dbs) {
>> --
>> 2.43.0
>>
>>


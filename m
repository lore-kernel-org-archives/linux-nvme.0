Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85DCD8C8E
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B145KD8e++H5H8gOSlDhp27emRCyB3jiBGAu0/EtMIQ=; b=Hjrkd2MbyXdmiuAzZF+ihiia2p
	KwyAGe/EFZxjr8j0/5ooTOTVyvwKmvAYPf9WITC3MrfgpqBfwaubv/6zuUx2svSSi0GVUVT4lEWZi
	TsLHBZwbYrpDU8ECpwCHzYl+fU3H+ZJ7BFbvN+Gc+sfOYGFPIk0GxcHeS1+2uyQX/bf/0VHLVkd6k
	pSYFLY1160OhAE65NxnCKx5V845HFZJHKEqkILO6RGI7b3NciLhsarfEnb4A55DtcTcbpRgo1kumy
	3V/TQJJPO/5JI8jN26d4hfZDx+XlzmICoK/Zot4JveWVRp+jhDJBqLKe2TAhuOHE4w5OryopeolNK
	D9lj4ISQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVtIr-00000001hKG-3ocM;
	Sat, 06 Jun 2026 15:51:17 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVtIp-00000001hJK-0FNs
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 15:51:16 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-372b4330deeso83779a91.0
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780761074; x=1781365874; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B145KD8e++H5H8gOSlDhp27emRCyB3jiBGAu0/EtMIQ=;
        b=T19xnWSrkCdbdMoo58ENkndOApiLA7kgOasY8DIababjyFcE/014sHLrQSeeWxWd4r
         Ko2KAiDkYL3VB+eZpKFrUXlfgV+xlLONEcuUeII+byemo7cbwPyA/L1S5Oc2jesBNAkO
         x2r+BbKY8SS7w2AV7ieUc6eyc4pAha0T7z2Sra9j7C10iZybyyeqvIgiU0g3bU1TwjTB
         zd9A3eGJuiWOKD2GW2pQ+4si93KjX9PD2Lg+Zm7vx9x4LB2Ri4CnUHofdCYVcU7m3yAO
         j71p4hWTN3SwP3OuMey/LS7v9d9yowi/qdNB9cY/mMfm6NDw+4I1gG2MNMcKh7tRIF1e
         U4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761074; x=1781365874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B145KD8e++H5H8gOSlDhp27emRCyB3jiBGAu0/EtMIQ=;
        b=oxy8yCo43yTJi/cIpEv+WyDyhSX0pysQYUkDVAnoWe6WcybBOogSIDdg66MklaxzjZ
         /eDZJUTA0BNr3EHYaOqoVTR9v1WXCARfMei1CuuSY8Ue3LKkd8GddGqKpXs8U80gPbuf
         XOCPupWJ0p6ABoWqjxOGbbAo9I+WKdlQYaophNoVlNEqAVdyCQWZTt+NVjDgMId5dhvx
         OTh8kaXlY310rbc9z4WihXKkKvxgdrHmX1zQBQfqAkeJIL59pgXYN7K2IIr8hFkUa3Fp
         IvPgDvKrpyJZ8c8/ScTqLvhCevI1eUnRZzYTxCWUbc4CKOyfwf4qHllzwfm1p6vFCTtu
         3RWA==
X-Forwarded-Encrypted: i=1; AFNElJ/DkDORFG2kzi1lwdXnvFKEnNAjG51whQvObKl+cCkgwhglfuRLaOtehRC0mADQF7rBDCx0xvz1/pCK@lists.infradead.org
X-Gm-Message-State: AOJu0YyX0guCDdLhSgwM9V53Vz+nWNa7w29qHgkkrthao2b4H2ODR0VL
	V+TofRvmGAbgT0WhRg3ENoMZwevIGadx4nI3Q8uDVmYwQSa4Hnvq4wco72DoWgwS
X-Gm-Gg: Acq92OG3DqIMJUc7CnqTxOe+LC9Ha+j1elFGC7qC1ojIardUW58piQewTsrSduSoyCS
	sUMMnHbwVq0UE5XJQ+ZGe3shcJZt5af/+/AiOmgMbwHB966zY1NKgVW6g0Ku/ECatcoRgGK9eZU
	6+BXGTspo2RcHyz+XntUQAmP9p7q/UFl7DATLv4T+EoR/s/swJCO0a4VV6cg3yNklZRCaZA+4ST
	VAxfcEDbAJUVqfvK8vakk2xWvEQEnXDGlQijUWr9C2NLiL+i5JLr4ToQ+/QTLABCpZ0J5ed4UwV
	wPKf9SIJOI44j5M+hJUmPxhFkgpaN3CVRKKeHFMnDnSEwQ8hwAylMJDTThopWegaXlsj0DL8dIl
	grW6pDCgQC7yI9kj1v0SzGtPNr6jM/cHm6nKJO/kE6RFFdHvpslZs8jPF0NNXuizUYvEZu95n6a
	2hJW9K9LGaqlck6Zgv27+mfIjf2XCPkyUUqNtp+yqngw==
X-Received: by 2002:a17:903:1b44:b0:2c0:c262:b925 with SMTP id d9443c01a7336-2c1e7f9252fmr104566115ad.25.1780761073850;
        Sat, 06 Jun 2026 08:51:13 -0700 (PDT)
Received: from [192.168.1.111] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm121917285ad.71.2026.06.06.08.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 08:51:13 -0700 (PDT)
Message-ID: <9ca8d72c-af36-43a4-90ab-90f13b02f4fb@gmail.com>
Date: Sat, 6 Jun 2026 23:51:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
Content-Language: en-MW
To: David Laight <david.laight.linux@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
 <20260606152930.6f2bf4ed@pumpkin>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260606152930.6f2bf4ed@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_085115_098512_886472A1 
X-CRM114-Status: GOOD (  26.84  )
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



David Laight 於 2026/6/6 晚上10:29 寫道:
> On Sat, 06 Jun 2026 21:25:26 +0800
> Nick Chan <towinchenmi@gmail.com> wrote:
> 
>> From: Yuriy Havrylyuk <yhavry@gmail.com>
>>
>> Apple NVMe controllers require tags of pending commands to not be shared
>> across admin and IO queues. However, on Apple A11 without linear SQ, it is
>> not possible for either queue to skip over some tags and must go from 0 to
>> the configured maximum before wrapping around.
>>
>> If a pending command tag is duplicated across queues, the firmware
>> crashes with: "duplicate tag error for tag N", with N being the tag.
>>
>> Instead of partitioning the tag space, which is not possible without
>> linear SQ, prevent tag collisions by keeping track of which tags are
>> currently in-flight across either queues, and return BLK_STS_RESOURCE to
>> temporaily block command submission when a collision would have occurred.
> 
> I look at using the atomic64_xxx() functions rather than the bitmask ones.
> The for_each_bit_set() loop is then an atmomic64_andnot() call.

That does in fact simplify the loop code. However, using the atomic function
complicates the apple_nvme_reserve_tag_t8015() and
apple_nvme_release_tag_t8015() since those functions deal with set/clear a
a bit in terms of an integer (the tag).

Especially in the apple_nvme_reserve_tag_t8015() function the function body
is then

	u64 tag_bit = BIT(nvme_tag_from_cid(cmd->common.command_id));

	return !(atomic64_fetch_or(tag_bit, &anv->t8015_active_tags) & tag_bit);

The function would need to explictly convert the tag to a bit, and then
explictly extract the bit value after performing the atomic operation,
both which of could have been done by test_and_set_bit().

So I do not see any overall benefit for using atomic_xxx() functions.

Best Regards,
Nick Chan

> 
> -- David
> 
> 
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
>> Signed-off-by: Yuriy Havrylyuk <yhavry@gmail.com>
>> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  drivers/nvme/host/apple.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>> index c1115e27a0d6..6354edf27225 100644
>> --- a/drivers/nvme/host/apple.c
>> +++ b/drivers/nvme/host/apple.c
>> @@ -203,6 +203,20 @@ struct apple_nvme {
>>  
>>  	int irq;
>>  	spinlock_t lock;
>> +
>> +	/*
>> +	 * Tags of pending commands must be unique across both Admin and IO
>> +	 * queue. However, on T8015, unlike T8103, without linear submission
>> +	 * queues, it is not possible for the either queue to skip some tags,
>> +	 * and both queues must go from 0 to their respective configured
>> +	 * maximum.
>> +	 *
>> +	 * Instead of reserving some tags for the admin queue, use a bitfield
>> +	 * to keep track of pending commands on either queue, and temporaily
>> +	 * block command submission by returning BLK_STS_RESOURCE until the
>> +	 * tag is freed on the other queue.
>> +	 */
>> +	unsigned long t8015_active_tags;
>>  };
>>  
>>  static_assert(sizeof(struct nvme_command) == 64);
>> @@ -290,6 +304,28 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
>>  				     "NVMMU TCB invalidation failed\n");
>>  }
>>  
>> +static bool apple_nvme_reserve_tag_t8015(struct apple_nvme *anv,
>> +					 struct nvme_command *cmd)
>> +{
>> +	u16 tag = nvme_tag_from_cid(cmd->common.command_id);
>> +
>> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
>> +		return false;
>> +
>> +	return !test_and_set_bit(tag, &anv->t8015_active_tags);
>> +}
>> +
>> +static void apple_nvme_release_tag_t8015(struct apple_nvme *anv,
>> +					 __u16 command_id)
>> +{
>> +	u16 tag = nvme_tag_from_cid(command_id);
>> +
>> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
>> +		return;
>> +
>> +	clear_bit(tag, &anv->t8015_active_tags);
>> +}
>> +
>>  static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
>>  				  struct nvme_command *cmd)
>>  {
>> @@ -652,6 +688,8 @@ static inline void apple_nvme_update_cq_head(struct apple_nvme_queue *q)
>>  static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>>  			       struct io_comp_batch *iob)
>>  {
>> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
>> +	unsigned long completed_tags = 0;
>>  	bool found = false;
>>  
>>  	while (apple_nvme_cqe_pending(q)) {
>> @@ -664,11 +702,26 @@ static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>>  		dma_rmb();
>>  		apple_nvme_handle_cqe(q, iob, q->cq_head);
>>  		apple_nvme_update_cq_head(q);
>> +
>> +		if (!anv->hw->has_lsq_nvmmu) {
>> +			struct nvme_completion *cqe = &q->cqes[q->cq_head];
>> +			u16 tag = nvme_tag_from_cid(READ_ONCE(cqe->command_id));
>> +
>> +			if (!WARN_ON_ONCE(tag >= BITS_PER_LONG))
>> +				__set_bit(tag, &completed_tags);
>> +		}
>>  	}
>>  
>>  	if (found)
>>  		writel(q->cq_head, q->cq_db);
>>  
>> +	if (!anv->hw->has_lsq_nvmmu && completed_tags) {
>> +		unsigned long tag_bit;
>> +
>> +		for_each_set_bit(tag_bit, &completed_tags, BITS_PER_LONG)
>> +			clear_bit(tag_bit, &anv->t8015_active_tags);
>> +	}
>> +
>>  	return found;
>>  }
>>  
>> @@ -790,6 +843,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (!anv->hw->has_lsq_nvmmu &&
>> +	    !apple_nvme_reserve_tag_t8015(anv, cmnd)) {
>> +		ret = BLK_STS_RESOURCE;
>> +		goto out_free_cmd;
>> +	}
>> +
>>  	if (blk_rq_nr_phys_segments(req)) {
>>  		ret = apple_nvme_map_data(anv, req, cmnd);
>>  		if (ret)
>> @@ -806,6 +865,9 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	return BLK_STS_OK;
>>  
>>  out_free_cmd:
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		apple_nvme_release_tag_t8015(anv, cmnd->common.command_id);
>> +
>>  	nvme_cleanup_cmd(req);
>>  	return ret;
>>  }
>> @@ -1165,6 +1227,9 @@ static void apple_nvme_reset_work(struct work_struct *work)
>>  	if (ret)
>>  		goto out;
>>  
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		WRITE_ONCE(anv->t8015_active_tags, 0);
>> +
>>  	dev_dbg(anv->dev, "Starting admin queue");
>>  	apple_nvme_init_queue(&anv->adminq);
>>  	nvme_unquiesce_admin_queue(&anv->ctrl);
>>
> 



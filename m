Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D92DC38A02
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AL27QyIM3bdvujNW/TxsQT8sPJru/yhP/aQDbgDvP+0=; b=w5Tc76+2bqTPvy5daTWYRB0CBk
	fxNlfuy9m770UW9iUYbR3Rq77/lkt/a9gFnl00kYqBgRBiW8bhabPgp0iHLjeAWRnuok2JSw5mL4h
	OnSOhiQwh3II+lLKtE013X76rPymtDzIrbOQujIBFR94543po1h6xsf5Kp5LZP2A8Xc93F/+zKY0x
	CjGwyxQUf8bCge7bEVUUCukLka6SNSbjMAaMbjcNRQpNE+vjPmkazZJHVrqttvxe9EIllskNsXpag
	FpFVPTnSKqVXm8WoDelhRMwG6WMZSgCJv98mmdaBUjyuBtoAOliOql9lY6TSLIbYNYrlDaGbM6wla
	uVG9TL1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opQgG-009nVs-7T; Mon, 31 Oct 2022 09:02:04 +0000
Received: from out199-2.us.a.mail.aliyun.com ([47.90.199.2])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opQgB-009nSz-Ov
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 09:02:02 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VTTcsAI_1667206907;
Received: from 30.178.83.209(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VTTcsAI_1667206907)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 17:01:48 +0800
Message-ID: <89940fb2-d34e-87aa-30b4-78d751af14f9@linux.alibaba.com>
Date: Mon, 31 Oct 2022 17:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20221030162906.3390-1-hch@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20221030162906.3390-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_020200_134519_588F5668 
X-CRM114-Status: GOOD (  21.42  )
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


在 2022/10/31 00:29, Christoph Hellwig 写道:
> While the specification allows devices to either deallocate data
> or to actually write zeroes on any Write Zeroes command, many SSDs
> only do the sensible thing and deallocate data when the DEAC bit
> is specific.  Set it when it is suppored and the caller doesn't
> explicitly opt out of deallocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>
> BTW, I'm tempted to slap a
>
> Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
>
> onto this.  While it doesn't fix the Write Zeroes support per se,
> it should help us with a lot of the devices timing out on Write Zeroes.
>
>   drivers/nvme/host/core.c | 6 +++++-
>   drivers/nvme/host/nvme.h | 1 +
>   include/linux/nvme.h     | 1 +
>   3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0090dc0b3ae6f..14568ae308fba 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -850,8 +850,11 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
>   	cmnd->write_zeroes.length =
>   		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
>   
> +	if (!(req->cmd_flags & REQ_NOUNMAP) && ns->dlfeat & (1 << 3))

Maybe we can add a series of macros to make the code easier to read.

Best regards,

Guixin Liu

> +		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
> +
>   	if (nvme_ns_has_pi(ns)) {
> -		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
> +		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
>   
>   		switch (ns->pi_type) {
>   		case NVME_NS_DPS_PI_TYPE1:
> @@ -2004,6 +2007,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   		}
>   	}
>   
> +	ns->dlfeat = id->dlfeat;
>   	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
>   	set_bit(NVME_NS_READY, &ns->flags);
>   	blk_mq_unfreeze_queue(ns->disk->queue);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a29877217ee65..00d3b438efe3f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -477,6 +477,7 @@ struct nvme_ns {
>   	u32 sws;
>   	u8 pi_type;
>   	u8 guard_type;
> +	u8 dlfeat;
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	u64 zsze;
>   #endif
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 050d7d0cd81b0..c96930b2c28fe 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -963,6 +963,7 @@ enum {
>   	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
>   	NVME_RW_PRINFO_PRACT		= 1 << 13,
>   	NVME_RW_DTYPE_STREAMS		= 1 << 4,
> +	NVME_WZ_DEAC			= 1 << 9,
>   };
>   
>   struct nvme_dsm_cmd {


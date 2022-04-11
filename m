Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FF9C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9ZmUgvN8T+viTjF4W/gQWxKm8epuYwMuHMH5maZLcg=; b=UUyQM9krPYSbM6XdLG43ai3PjN
	jCnJq1fsZGpYDxSdQ1+sHVfBfNuKK6lMvrrAcBOUa0rFnf47ded55GDN21A9hG4YXxmPMxyRuxpHx
	RjoZ2adCciKdTgpfrqqiz6JrdPn7MIa0RfP+bgoYxQjtncPwymqXUzVxoOeOVQ8vtjQPjl00IERCv
	cbAk1Fujem5+qYtG+WMhZiBme9o5TC4B75BJ7D/3T+l/kxebQCEH3vp0KBUnjHveZxDmCU6fhE0K+
	yq53C8W76B5MwWi1NDCleM53l2RU87PuL9ozvjjrjzzCe8lvXdgnNLmv4tIxHdTGcgUadLhLkMAxe
	Uk34Xktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndutx-009Mia-0I; Mon, 11 Apr 2022 14:20:21 +0000
Received: from mail-m118205.qiye.163.com ([115.236.118.205])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndutt-009Mgj-RR
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 14:20:19 +0000
Received: from [192.168.1.164] (unknown [218.106.117.245])
 by mail-m118205.qiye.163.com (HMail) with ESMTPA id E59BD2C8D1C;
 Mon, 11 Apr 2022 22:20:13 +0800 (CST)
Message-ID: <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
Date: Mon, 11 Apr 2022 22:20:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me, kingtous <kingtous@qq.com>
References: <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
From: =?UTF-8?B?6YeR6Z+s?= <me@kingtous.cn>
In-Reply-To: <20220411060746.GA14519@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQhpOH1ZCHh1LQxoeTUlOSR
 1VAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46Lzo*PjlWAk5NDQ9PHUIw
 N0IKFE1VSlVKTU9CTUNNQ0pPSEpLVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUpDVUpL
 TVVKSkxVSU9OWVdZCAFZQUxCSk83Bg++
X-HM-Tid: 0a8018ff1d7f2d27kusne59bd2c8d1c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_072018_082082_BCCF0B2B 
X-CRM114-Status: GOOD (  24.25  )
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

After applying the patch provided (based on official kernel 5.17.1), the 
suspend issue has gone, and works!

dmesg shows below:
[    0.489981] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    0.490002] nvme nvme0: pci function 0000:03:00.0
[    0.494897] nvme nvme0: missing or invalid SUBNQN field.
[    0.498902] nvme nvme0: allocated 16 MiB host memory buffer.
[    0.537800] nvme nvme0: 8/0/0 default/read/poll queues
[    0.543528] nvme nvme0: Ignoring bogus Namespace Identifiers
[    0.546709]  nvme0n1: p1 p2 p3 p4
[    0.985096] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data 
mode. Quota mode: none.
[    1.220554] EXT4-fs (nvme0n1p4): re-mounted. Quota mode: none.
[   36.672605] nvme nvme0: 8/0/0 default/read/poll queues
[   36.673717] nvme nvme0: Ignoring bogus Namespace Identifiers

btw, I checked the patch code, I noticed "MAXIO MAP1202" is hard coded 
in pci.c. I think not only MAP1202 has the problem mentioned in this 
thread, but also "MAXIO MAP1002"(Gloway Basic 1T NVMe SSD, which has the 
same suspend issue).
 > +	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 > +		.driver_data = NVME_QUIRK_BOGUS_NID, },

I highly doubt that MAXIO SSD controller may all have the issue of 
reporting nsid.


在 2022/4/11 14:07, Christoph Hellwig 写道:
> Plase try this patch:
> 
> ---
>  From 95cf9f00488ca5b203cb9205f108b8ec0c30d001 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 11 Apr 2022 08:05:27 +0200
> Subject: nvme: add a Namespace Identifiers quirk
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The MAXIO MAP1202 controllers reports completely bogus Namespace
> identifiers that even change after suspend cycles.  Disable using
> the Identifiers entirely.
> 
> Reported-by: 金韬 <me@kingtous.cn>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 24 ++++++++++++++++++------
>   drivers/nvme/host/nvme.h |  5 +++++
>   drivers/nvme/host/pci.c  |  2 ++
>   3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index efb85c6d8e2d5..907f4a2b3de87 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1282,6 +1282,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>   
>   	switch (cur->nidt) {
>   	case NVME_NIDT_EUI64:
> +		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
> +			return -1;
>   		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
>   			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
>   				 warn_str, cur->nidl);
> @@ -1290,6 +1292,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>   		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
>   		return NVME_NIDT_EUI64_LEN;
>   	case NVME_NIDT_NGUID:
> +		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
> +			return -1;
>   		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
>   			dev_warn(ctrl->device, "%s %d for NVME_NIDT_NGUID\n",
>   				 warn_str, cur->nidl);
> @@ -1298,6 +1302,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>   		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
>   		return NVME_NIDT_NGUID_LEN;
>   	case NVME_NIDT_UUID:
> +		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
> +			return -1;
>   		if (cur->nidl != NVME_NIDT_UUID_LEN) {
>   			dev_warn(ctrl->device, "%s %d for NVME_NIDT_UUID\n",
>   				 warn_str, cur->nidl);
> @@ -1399,12 +1405,18 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   	if ((*id)->ncap == 0) /* namespace not allocated or attached */
>   		goto out_free_id;
>   
> -	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
> -	    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
> -		memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
> -	if (ctrl->vs >= NVME_VS(1, 2, 0) &&
> -	    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
> -		memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
> +
> +	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
> +		dev_info(ctrl->device,
> +			 "Ignoring bogus Namespace Identifiers\n");
> +	} else {
> +		if (ctrl->vs >= NVME_VS(1, 1, 0) &&
> +		    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
> +			memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
> +		if (ctrl->vs >= NVME_VS(1, 2, 0) &&
> +	    	!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
> +			memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
> +	}
>   
>   	return 0;
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1393bbf82d71e..a2b53ca633359 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -144,6 +144,11 @@ enum nvme_quirks {
>   	 * encoding the generation sequence number.
>   	 */
>   	NVME_QUIRK_SKIP_CID_GEN			= (1 << 17),
> +
> +	/*
> +	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
> +	 */
> +	NVME_QUIRK_BOGUS_NID			= (1 << 18),
>   };
>   
>   /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d817ca17463ed..c386c91483505 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3447,6 +3447,8 @@ static const struct pci_device_id nvme_id_table[] = {
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> +	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
> +		.driver_data = NVME_QUIRK_BOGUS_NID, },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
>   		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),


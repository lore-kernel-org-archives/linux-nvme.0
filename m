Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D0BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 07:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nkDw5smB53L6Z/yfyMvgW5owqZ1PL/GoI9XQ7oSHtiU=; b=DrUWnlh756c+CKwjegZ/svvWzq
	IMcc0e7mrmOF8wNBjioLfIxuzWQYjr4tgTs96X4rMXcD2+UHQMiPCULZGBXfRfXD3NoPLxRdj28ct
	2OcaVuH5ZK2l2CzPaW4QQZJOHFKX4mSDAR7+/kZJfpmqOpsBiDlSI7KtotGlotVEJqKd6QqEMytq0
	ATUJY5eCQyNkUs9VokIq5oDw2uNjzKFQggmuF2C/Hms4tlKQFRTE+dhZmKVaFtpltVGiRJS+VM1a8
	JpuYj0E1ZGhh0fESHshr0I8MRkYa0gZEiGePO079oI+dfQdyYHciBF4YoLA0HjBHR3KSAfq9aaDBq
	mgIhPYdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFWOI-000A4z-JZ; Thu, 03 Feb 2022 07:18:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFWOB-000A2R-L5
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 07:18:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AAC932110B;
 Thu,  3 Feb 2022 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643872721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkDw5smB53L6Z/yfyMvgW5owqZ1PL/GoI9XQ7oSHtiU=;
 b=X6jBxWXKDVJb16z0Z2WqJTypoWc3XN/pLFV2zN723rmXH5T5UUg4a3N9IoPYsE3vPFHBC6
 yAKv25tfs8eh2muBkeTs3lGk8FuQoNmAR/kXW2zdmeYEC0tiOk1C/HRMIZ0Jm1QPBq5QTE
 4SUpjqBa2JEZZXR8tg9EA51+D4wvjMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643872721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkDw5smB53L6Z/yfyMvgW5owqZ1PL/GoI9XQ7oSHtiU=;
 b=WPvSE1R1zGkaNrxiIObFbce+hvnfBF1MZE3r+H00sm7hPoT/DB8Xb/mtuITYjsOIjNgZ23
 5JghB2ry4eYGiGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7738613310;
 Thu,  3 Feb 2022 07:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C1FDHNGB+2GkcQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 03 Feb 2022 07:18:41 +0000
Message-ID: <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
Date: Thu, 3 Feb 2022 08:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_231843_867246_BEAF6D65 
X-CRM114-Status: GOOD (  26.02  )
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

On 2/2/22 22:34, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the Discovery Controller Type (dctype)
> attribute. The dctype is returned in the response to the
> Identify command. This patch exposes the dctype through
> the sysfs. Since the dctype depends on the Controller
> Type (cntrltype), another attribute of the Identify
> response, the patch also exposes the cntrltype as well.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c | 35 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  3 +++
>   include/linux/nvme.h     | 10 +++++++++-
>   3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 872c389dc6d3..c65d44fb65c4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2992,6 +2992,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
>   
> +	ctrl->cntrltype = id->cntrltype;
> +	ctrl->dctype = id->dctype;
> +
>   	if (id->rtd3e) {
>   		/* us -> s */
>   		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
> @@ -3525,6 +3528,34 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>   static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
>   	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
>   
> +static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	switch (ctrl->cntrltype) {
> +	case NVME_CTRL_IO:	return sysfs_emit(buf, "io\n");
> +	case NVME_CTRL_DISC:	return sysfs_emit(buf, "disc\n");

'discovery', please. 'disc' is misleading here.

> +	case NVME_CTRL_ADMIN:	return sysfs_emit(buf, "admin\n");
> +	default:		return sysfs_emit(buf, "reserved\n");
> +	}
> +}
> +static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show, NULL);
> +
> +static ssize_t nvme_ctrl_dctype_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	switch (ctrl->dctype) {
> +	case NVME_DCTYPE_NOT_REPORTED:	return sysfs_emit(buf, "nr\n");

Please use 'none' here; 'nr' is ambiguous ('Number'?)

> +	case NVME_DCTYPE_DDC:		return sysfs_emit(buf, "ddc\n");
> +	case NVME_DCTYPE_CDC:		return sysfs_emit(buf, "cdc\n");
> +	default:			return sysfs_emit(buf, "reserved\n");
> +	}
> +}
> +static DEVICE_ATTR(dctype, S_IRUGO, nvme_ctrl_dctype_show, NULL);
> +
>   static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reset_controller.attr,
>   	&dev_attr_rescan_controller.attr,
> @@ -3546,6 +3577,8 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reconnect_delay.attr,
>   	&dev_attr_fast_io_fail_tmo.attr,
>   	&dev_attr_kato.attr,
> +	&dev_attr_cntrltype.attr,
> +	&dev_attr_dctype.attr,
>   	NULL
>   };
>   
> @@ -3569,6 +3602,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>   		return 0;
>   	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
>   		return 0;
> +	if (a == &dev_attr_dctype.attr && ctrl->cntrltype == NVME_CTRL_DISC)
> +		return 0;
>   
>   	return a->mode;
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a162f6c6da6e..e30626c00791 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -349,6 +349,9 @@ struct nvme_ctrl {
>   	unsigned long discard_page_busy;
>   
>   	struct nvme_fault_inject fault_inject;
> +
> +	enum nvme_ctrl_type cntrltype;
> +	enum nvme_dctype dctype;
>   };
>   
>   enum nvme_iopolicy {
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 855dd9b3e84b..af1494d83a52 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -43,6 +43,12 @@ enum nvme_ctrl_type {
>   	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
>   };
>   
> +enum nvme_dctype {
> +	NVME_DCTYPE_NOT_REPORTED = 0,
> +	NVME_DCTYPE_DDC = 1,		/* Direct Discovery Controller */
> +	NVME_DCTYPE_CDC = 2,		/* Central Discovery Controller */
> +};
> +
>   /* Address Family codes for Discovery Log Page entry ADRFAM field */
>   enum {
>   	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
> @@ -320,7 +326,9 @@ struct nvme_id_ctrl {
>   	__le16			icdoff;
>   	__u8			ctrattr;
>   	__u8			msdbd;
> -	__u8			rsvd1804[244];
> +	__u8			rsvd1804[2];
> +	__u8			dctype;
> +	__u8			rsvd1807[241];
>   	struct nvme_id_power_state	psd[32];
>   	__u8			vs[1024];
>   };

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer


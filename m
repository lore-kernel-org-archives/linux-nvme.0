Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF92C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wH9R+c2CFEFLzoUlcITd9YsuhL2kra+kI2fpeLVdjNo=; b=qxZ3yXhZJ9mfE6psgRmilbDI8c
	YczyWpbQ6iDuBlboXgEXLoE0AaqMfOLLi9cmsdhrD1dpRu1C4gMGOXV1dKWh+9NZbLwZhL95feNym
	IAvivqrxU9rd3UvibRIGnrAME20XrE03ljTG1oMSUw3UuIdLfDhgIDP1uQFeWfshuMYQzfN2+B8yh
	EG+FUkik811h/v+RcyFwZ7qAyADOvTslCihPEgzCnx/kyUrsbQ0BfTihKzCLGIoaSnpIndCmD6FPk
	DjEq3tGNg2tY0qz7TaJdNM2sea9Qv9X08Ku16ZkZtBFV559C72GsRaWVtEaL88N+Zt3BvgQT94okl
	Uzfg01XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD0tq-00EqP9-J3; Thu, 27 Jan 2022 09:17:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD0tn-00EqNX-4g
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 09:17:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 065D91F76E;
 Thu, 27 Jan 2022 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wH9R+c2CFEFLzoUlcITd9YsuhL2kra+kI2fpeLVdjNo=;
 b=O/r9ThjHhNGqzmTPm14ofB3YNfmVJsRhLmPC0ao23wJzpbMKO5MBDuEJa2M3b5gODN3/+Q
 QD29j5SkG3LL+fKkq4ugMmNM/uGdpwYOB5+N9qX2ySvLC52DM2bFijekz7KHMPQXXzetTK
 Ovk7FWC9aW17UrARyABjxJqWNoUz1OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wH9R+c2CFEFLzoUlcITd9YsuhL2kra+kI2fpeLVdjNo=;
 b=/ukXG5ZPUBvjYb/QwTvRDIhvcrUCKz48et4LNVmsxPMc5XAZiptPBbbLwwo6X6r/PBct0h
 Qp32j0S1cNlnn4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E10E713CFB;
 Thu, 27 Jan 2022 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1ucKNgdj8mFLGwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 09:16:55 +0000
Message-ID: <b680e4d4-4375-4b49-b3b5-dde8d0e7f097@suse.de>
Date: Thu, 27 Jan 2022 10:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] nvme-fabrics: add discovery controller type
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291022C56E35D6F93500AF79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB4291022C56E35D6F93500AF79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_011659_393317_85A6B558 
X-CRM114-Status: GOOD (  18.45  )
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

On 1/25/22 15:59, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the Central Discovery Controller (CDC). To
> differentiate between a CDC and a DDC (Direct DC), the identify
> response now carries a DCTYPE (Discovery Controller Type) field.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c |  3 +++
>   drivers/nvme/host/nvme.h |  2 ++
>   include/linux/nvme.h     | 10 +++++++++-
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4fc794d9c2f4..cd34b92e8e9d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2978,6 +2978,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->kas = le16_to_cpu(id->kas);
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
> +	ctrl->dctype = id->dctype;
>   
>   	if (id->rtd3e) {
>   		/* us -> s */
> @@ -3335,6 +3336,7 @@ nvme_show_int_function(numa_node);
>   nvme_show_int_function(queue_count);
>   nvme_show_int_function(sqsize);
>   nvme_show_int_function(kato);
> +nvme_show_int_function(dctype);
>   
>   static ssize_t nvme_sysfs_delete(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
> @@ -3533,6 +3535,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reconnect_delay.attr,
>   	&dev_attr_fast_io_fail_tmo.attr,
>   	&dev_attr_kato.attr,
> +	&dev_attr_dctype.attr,
>   	NULL
>   };
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index fe224016418e..f8b60f7346fd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -349,6 +349,8 @@ struct nvme_ctrl {
>   	unsigned long discard_page_busy;
>   
>   	struct nvme_fault_inject fault_inject;
> +
> +	enum nvme_dctype dctype;
>   };
>   
>   enum nvme_iopolicy {
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 855dd9b3e84b..82567d493c51 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -240,6 +240,12 @@ enum nvme_ctrl_attr {
>   	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
>   };
>   
> +enum nvme_dctype {
> +	NVME_DCTYPE_NOT_REPORTED = 0,
> +	NVME_DCTYPE_DDC = 1,
> +	NVME_DCTYPE_CDC = 2,
> +};
> +
>   struct nvme_id_ctrl {
>   	__le16			vid;
>   	__le16			ssvid;
> @@ -320,7 +326,9 @@ struct nvme_id_ctrl {
>   	__le16			icdoff;
>   	__u8			ctrattr;
>   	__u8			msdbd;
> -	__u8			rsvd1804[244];
> +	__le16			ofcs;
> +	__u8			dctype;
> +	__u8			rsvd1807[241];
>   	struct nvme_id_power_state	psd[32];
>   	__u8			vs[1024];
>   };

Please decode the fields for the sysfs attribute; 'cdc' is far easier to 
understand than '2'.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer


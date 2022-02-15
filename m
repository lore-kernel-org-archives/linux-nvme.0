Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC1DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8oKpWEcForb2w+9mEOd2FJhry8jc/PXr0tfcuqMcPXE=; b=r+v4rQ4Xh8VzqkdQ0XKPCrr+BV
	ERfcl+FbYpdXKrRqi+MNEupiAIu+WB3I5mJFkmALM+6AC6po2qJg/EB/Tk+fQf0EXNDgaqPbUaT86
	oOeqKBgzMEo/ge36KjrnkDueeq5Keiy63RnVxE8V7IJolVFZ/j9pu/8UWXn75VHZ1CvT0KTG2Q1KV
	m+/J+uDfcbNkP7qzOIyq9lpjHDXZnGxA3qvll7CkquszMdlpUN0VtyfP0xp665mIltzXkm3lirAgS
	+Xt4ij81tet2e0eS1wY+e8Cegtikon7j+mVVpabl0ehc/uo6pn2gusCN6lb/RJ3A+uHflyuDofCp1
	jpnMFt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK0Ix-003Xi3-CN; Tue, 15 Feb 2022 16:03:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK00R-003ObC-Gj
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 15:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644939882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oKpWEcForb2w+9mEOd2FJhry8jc/PXr0tfcuqMcPXE=;
 b=T9w2rd7riWPGaz8xzuVGKJ5npmhbBFokD8GJsNmDjg1MVr6yc8GsUkmBK/QduQ6iWK3TNx
 HQX+uYpjt2Qp11Pj9WbaBst2oABGkiLw1fUGeQb2LHe4hASVWD4Xj3hgjyOsSQC352L3vk
 5rZRMPkfLatrF2kJJCCB662ZAMjmQ0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-r-BF9n3tNgCAxsZ1PSsTrg-1; Tue, 15 Feb 2022 10:44:37 -0500
X-MC-Unique: r-BF9n3tNgCAxsZ1PSsTrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA5482F45;
 Tue, 15 Feb 2022 15:44:35 +0000 (UTC)
Received: from [10.22.32.107] (unknown [10.22.32.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 770A27317D;
 Tue, 15 Feb 2022 15:44:34 +0000 (UTC)
Message-ID: <54bd2c20-61aa-a187-613a-95d3718e0510@redhat.com>
Date: Tue, 15 Feb 2022 10:44:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_074443_696283_5E3D90EA 
X-CRM114-Status: GOOD (  30.55  )
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

Looks good.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 2/8/22 14:33, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the Discovery Controller Type attribute (dctype).
> The dctype is returned in the response to the Identify command. This
> patch exposes the dctype through the sysfs. Since the dctype depends on
> the Controller Type (cntrltype), another attribute of the Identify
> response, the patch also exposes the cntrltype as well. The dctype will
> only be displayed for discovery controllers.
> 
> A note about the naming of this attribute:
> Although TP8010 calls this attribute the Discovery Controller Type,
> note that the dctype is now part of the response to the Identify
> command for all controller types. I/O, Discovery, and Admin controllers
> all share the same Identify response PDU structure. Non-discovery
> controllers as well as pre-TP8010 discovery controllers will continue
> to set this field to 0 (which has always been the default for reserved
> bytes). Per TP8010, the value 0 now means "Discovery controller type is
> not reported" instead of "Reserved". One could argue that this
> definition is correct even for non-discovery controllers, and by
> extension, exposing it in the sysfs for non-discovery controllers is
> appropriate.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c | 39 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  3 +++
>   include/linux/nvme.h     | 10 +++++++++-
>   3 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b5e452aa3c0e..bb6ec2759e3e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
>   
> +	ctrl->cntrltype = id->cntrltype;
> +	ctrl->dctype = id->dctype;
> +
>   	if (id->rtd3e) {
>   		/* us -> s */
>   		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
> @@ -3523,6 +3526,40 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>   static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
>   	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
>   
> +static ssize_t cntrltype_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	static const char * const type[] = {
> +		[NVME_CTRL_IO] = "io\n",
> +		[NVME_CTRL_DISC] = "discovery\n",
> +		[NVME_CTRL_ADMIN] = "admin\n",
> +	};
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
> +		return sysfs_emit(buf, "reserved\n");
> +
> +	return sysfs_emit(buf, type[ctrl->cntrltype]);
> +}
> +static DEVICE_ATTR_RO(cntrltype);
> +
> +static ssize_t dctype_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	static const char * const type[] = {
> +		[NVME_DCTYPE_NOT_REPORTED] = "none\n",
> +		[NVME_DCTYPE_DDC] = "ddc\n",
> +		[NVME_DCTYPE_CDC] = "cdc\n",
> +	};
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
> +		return sysfs_emit(buf, "reserved\n");
> +
> +	return sysfs_emit(buf, type[ctrl->dctype]);
> +}
> +static DEVICE_ATTR_RO(dctype);
> +
>   static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reset_controller.attr,
>   	&dev_attr_rescan_controller.attr,
> @@ -3544,6 +3581,8 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reconnect_delay.attr,
>   	&dev_attr_fast_io_fail_tmo.attr,
>   	&dev_attr_kato.attr,
> +	&dev_attr_cntrltype.attr,
> +	&dev_attr_dctype.attr,
>   	NULL
>   };
>   
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
> index 855dd9b3e84b..21e92e97ca88 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -43,6 +43,12 @@ enum nvme_ctrl_type {
>   	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
>   };
>   
> +enum nvme_dctype {
> +	NVME_DCTYPE_NOT_REPORTED	= 0,
> +	NVME_DCTYPE_DDC			= 1, /* Direct Discovery Controller */
> +	NVME_DCTYPE_CDC			= 2, /* Central Discovery Controller */
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



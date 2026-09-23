Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B66C98304
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwHyWIRHXY3P9Fw/TPrR57c0xVbvLUEWr30qF/TORsY=; b=I2kqSNZ6OPJYFjr7tOptId5336
	JWVWn9OChBylmzaNko+Dcp5GRxcl8n6D+KVpl2qikxUOJf8rEm1lfzJeXbeJqzyhyfHjJbSGn6cHW
	uJHopsi7Q3q2BNc9cr77jMy58YCZKSaKH6ugTMjhTJV0An5O8qkszY2GzONQDh0JHTrVg6Vwxi0u0
	be/GKxvhCXL910iBKxKTjDoS2WV8xqGJclG686NMGJqnvF47kygAulbNV8DOCucITJj4Nf5li/3Lt
	hsxqGJCC3s0ZwvJZ0zvg20qWTBojBA8NCIwOQgsObeVSdudmTxDDTS5UX07ZObm6kRFKznAziM62r
	aiAovQZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Umg-00000009bmD-13rD;
	Wed, 23 Sep 2026 21:45:46 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Uma-00000009blL-1Nbx
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 21:45:44 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-14327018b37so43249c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790199939; x=1790804739; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OwHyWIRHXY3P9Fw/TPrR57c0xVbvLUEWr30qF/TORsY=;
        b=Dnd8d/V7oTAGmq5yovuMGgiBO6j/AeZ7ChrmNhax9B7Mih445a390eZAUFCXhbN2VM
         LVerZk3OU3bhsVEiBNYhGtwXXIioPOmJwFW7sQP6hs97VUiZqAIa2XMjPvlI8QenRmcl
         Xjyki860J9nbHe1E7su+2e5HrenGi2ViMEvlMFAKCWOOyFMffpGyVNurKE0Qfu8QEO5y
         a2fxEvy4ll9E4T9eot1+9d2RNWVjmxoza7RqZb9gqZXtVA+LR51sGy5Gbr65gKT6oJ6J
         Yxwkc4UrK8ayBHI1IckHRZtv5ZvXcjDAEsvqYLFl3rjR2D6gt75KAjtmvX70akzJKqJr
         pCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199939; x=1790804739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwHyWIRHXY3P9Fw/TPrR57c0xVbvLUEWr30qF/TORsY=;
        b=l5MqkMJuNv7zxLqqnF0bzVFBqIy49akTrHYQSjIOSMS03N7j/LWVe3sm/lgF/6tbvN
         lnGboJghvWPZMRVZTR3+gnpmznBrV52wQ2DBOq8kM/2s/0dgO4hg/SX8IHcZm1GJPsW+
         g5v0Qc6/9omO236FCS0G8RUtRtahElhNi8hW8Tw1jZmNupHfBCjaq5oLi4YaLyLtOaBh
         CNxO+OHbNCN/pH8aKNyvCVfn9OQhZcQeS3yjhG2k0mESMHx36AR4Taj285LIyOL5CoX+
         bp7A7mUMXb/NWTJz6N+1GWhguuzGTCpGB2kN89bvw4Af1Q4c1146t7ZnWiS+/HKCbxK8
         Jxrg==
X-Gm-Message-State: AFuF++k41KwzYCpViQNsKa7Drb748u3N7AyO7aODuFTaA3XEY5wf8WXU
	veSR2mZ7uRUH0QkdqzViadR/asUtNxK8orD2YWjtBqriXpztrPtRrfUZjpEXQ/dmRvqlKV0dVpE
	Kbxe3iJc=
X-Gm-Gg: AYBFou3kmlusQ2Ek+7RpGbx8j75N/DWsqBjNYyEqwdzGHnoGNIfbRL2s+Rm1WmLR3sJ
	rnDCrXGFh3t7slRuK0mgBwhH5ppwgcgpInpij33VBhvfBmrEUJ8hdyEVtY68xb4FqayoMXk8v0Y
	Dl0c0dUefi1wFVkKxDVdY/u3RdAshXgYvgo+lvl5DB9DBQ7JFchOCTSAqTEgBx/jU6dneMzIQBB
	o8CALxNwc90aa6ny0uvs8kUpsvEF9oFuYDgocwdnEwTytwpjp5dZMKjksMKZveyYBX2ZaJwYARH
	1BaKQ4eqRgH9Mj8AkU4dGAIa0vt8OG3Lz2nlT8Qfa1dYyQYwTh2svUye5ZKk/L/iJ495aLbgEOt
	Jv8up1nCaf7LHvRZx46bFoQEbyOVYQkunhmnlY2mZFgzUhd4rRIdWxIYI44wRqJ9rzGcxqSVue8
	zT+tvGAjXblROtYZAEUgBuR0FVOQGSH9QIHMPTYa8l5mJLiEz+MAlKwcXfhMIPwHUmtg+gDfGLY
	Tb2pcUYGT86IxVQBJc=
X-Received: by 2002:a05:7022:3a8b:b0:13b:32f4:e826 with SMTP id a92af1059eb24-1450404480emr343521c88.11.1790199938984;
        Wed, 23 Sep 2026 14:45:38 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e95c7bf6bsm7892192eec.8.2026.09.23.14.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:45:38 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:45:37 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: Add traffic based keep alive support to
 configfs
Message-ID: <20260923214537.GI2931-mkhalfella@purestorage.com>
References: <20260923202003.1776271-1-jtaubepe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923202003.1776271-1-jtaubepe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_144540_556678_2B89BA1C 
X-CRM114-Status: GOOD (  24.37  )
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

On Wed 2026-09-23 16:20:03 -0400, Jesse Taube wrote:
> Add the ability to turn on and off tbkas (traffic based keep alive
> support) via configfs. This is useful for testing and debugging.
> 
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> V1 -> V2:
>  - Add tbkas to nvmet_ctrl
>  - Force reconnect controllers when tbkas is set
>  - Use ctrl->tbkas in nvmet_execute_identify_ctrl and nvmet_req_init
> ---
>  drivers/nvme/target/admin-cmd.c |  4 +++-
>  drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
>  drivers/nvme/target/core.c      |  4 +++-
>  drivers/nvme/target/nvmet.h     |  2 ++
>  4 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 7764a3c0195c..26028be8fe4d 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -696,7 +696,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>  
>  	/* XXX: figure out what to do about RTD3R/RTD3 */
>  	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
> -	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
> +	ctratt = NVME_CTRL_ATTR_HID_128_BIT;
> +	if (ctrl->tbkas)
> +		ctratt |= NVME_CTRL_ATTR_TBKAS;
>  	if (nvmet_is_pci_ctrl(ctrl))
>  		ctratt |= NVME_CTRL_ATTR_RHII;
>  	id->ctratt = cpu_to_le32(ctratt);
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 6286e38436dd..2b879b1d4c3c 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1369,6 +1369,34 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>  }
>  CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
>  
> +static ssize_t nvmet_subsys_attr_tbkas_show(struct config_item *item,
> +					     char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%d\n", to_subsys(item)->tbkas);
> +}
> +
> +static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
> +					      const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	struct nvmet_ctrl *ctrl;
> +	bool tbkas;
> +
> +	if (kstrtobool(page, &tbkas))
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	subsys->tbkas = tbkas;
> +
> +	/* Force reconnect */
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
> +		ctrl->ops->delete_ctrl(ctrl);
> +	up_write(&nvmet_config_sem);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_tbkas);
> +
>  static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
>  						 char *page)
>  {
> @@ -1706,6 +1734,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>  	&nvmet_subsys_attr_attr_qid_max,
>  	&nvmet_subsys_attr_attr_ieee_oui,
>  	&nvmet_subsys_attr_attr_firmware,
> +	&nvmet_subsys_attr_attr_tbkas,
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	&nvmet_subsys_attr_attr_pi_enable,
>  #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..6b4bda231bd9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1227,7 +1227,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
>  		goto fail;
>  	}
>  
> -	if (sq->ctrl)
> +	if (sq->ctrl && sq->ctrl->tbkas)
>  		sq->ctrl->reset_tbkas = true;
>  
>  	return true;
> @@ -1677,6 +1677,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>  	mutex_lock(&subsys->lock);
>  
>  	ctrl->max_qid = subsys->max_qid;
> +	ctrl->tbkas = subsys->tbkas;
>  
>  	ctrl->sqs = kzalloc_objs(struct nvmet_sq *, ctrl->max_qid + 1);
>  	if (!ctrl->sqs)
> @@ -1865,6 +1866,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>  	}
>  
>  	subsys->ieee_oui = 0;
> +	subsys->tbkas = true;
>  
>  	subsys->firmware_rev = kstrndup(UTS_RELEASE, NVMET_FR_MAX_SIZE, GFP_KERNEL);
>  	if (!subsys->firmware_rev) {
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dbda55895f4f..2bc0e87ea981 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -270,6 +270,7 @@ struct nvmet_ctrl {
>  	u16			cntlid;
>  	u16			max_qid;
>  	u32			kato;
> +	bool			tbkas;
>  
>  	struct nvmet_port	*port;
>  
> @@ -343,6 +344,7 @@ struct nvmet_subsys {
>  	bool			subsys_discovered;
>  	char			*subsysnqn;
>  	bool			pi_support;
> +	bool			tbkas;
>  
>  	struct config_group	group;
>  
> -- 
> 2.55.0
> 


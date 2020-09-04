Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFCC433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEC92074D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x1E4YjA4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TfUxhprN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEC92074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SDnyKh/dZoj+uj0onblehU+Fi4vzu/KFIrl65r8jMf4=; b=x1E4YjA4TK8BkKKmbSu3n0bum
	q/6c+0saKsAA/YRj3bem/Fnb+SzR3G1jT7CWh1YiFV20avjjFaU3ZCUvKmIS78CHLACrkFk0jJfFe
	/T1P+y6wrMU/rZzeOKJozhRHcL9l8qLTejm5oPjpG/mJAF+o/UBlGEiYJcRGRRtQ5ftIxhY5gtI/B
	6+pP02kXUBdF4sPA3OGx+4bGvLhDuzQv+QGmcjAPoTWBYfE8DAH/v45gHH3WqmhMm9i0RHtzAna8z
	6WhsgWmdFSX7I7R6LgPbdx8PV2xdHF+lAQWqYrC3VT/T3m6RpGVA7FZlyWWDkIO9hPuDIwyZ93SCV
	cm84HqyMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEE4o-0001ch-AI; Fri, 04 Sep 2020 15:56:34 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEE3w-0001AZ-LI
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 15:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qJSjR7OEwqGAXFVOh0B1DWI0XNjEplTD0kO7EuLG78I=; b=TfUxhprNWx3SseYvxSiKnNS68b
 E87H2l8ipxjiJ5utc7HfupW1DxmHqfY9R4L99GZQ48tJzYUixMCIu8dZoku1HGumWPbHWf4sE5iUk
 YD6SuTsd1ErIytb6mW6h/xtRkfflBl6WevemLOaIopTZ+6Dwa77JHh7RnLYtT0sl7QRscNt+f6BII
 CBOOsEiZepQCqlk2zKMnMPab+nQG7x5xZqBHuuMCF0M5pkY2mKopz2O+XrXvsG76ueNrdN+adaghL
 BH98mCQAIBnIMBTKItYV3G2rHMwkjjdrMsoIOa4sooKO1WyVFMfJxkW1G8dIHMpbUSG3D/aHec0En
 iDDtfhMg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kEE3s-0007qX-CH; Fri, 04 Sep 2020 09:55:37 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-3-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <17e2b419-29b5-1f13-c081-dcc12ce4190b@deltatee.com>
Date: Fri, 4 Sep 2020 09:55:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904023929.5320-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/3] nvme: move get/put ctrl into dev open/release
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_115540_729843_4E7D62EC 
X-CRM114-Status: GOOD (  19.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-03 8:39 p.m., Chaitanya Kulkarni wrote:
> Introduce nvme_dev_release ctrl file release callback and move ctrl get
> and put operations from target passthru into host core in ctrl open and
> release file operations respectively. This is needed to atomically
> get/put ctrl and get/put ctrl module refcount without using any locks.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c       | 12 +++++++++++-
>  drivers/nvme/target/passthru.c |  7 ++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7c0def9184..a1707afcb710 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3262,6 +3262,16 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  	}
>  
>  	file->private_data = ctrl;
> +	nvme_get_ctrl(ctrl);
> +	return 0;
> +}
> +
> +static int nvme_dev_release(struct inode *inode, struct file *file)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
> +
> +	nvme_put_ctrl(ctrl);
>  	return 0;
>  }
>  
> @@ -3327,6 +3337,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  static const struct file_operations nvme_dev_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= nvme_dev_open,
> +	.release	= nvme_dev_release,
>  	.unlocked_ioctl	= nvme_dev_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
>  };

Once again, above this makes sense. Below this seems very much unrelated.



> @@ -4651,7 +4662,6 @@ struct nvme_ctrl *nvme_ctrl_get_by_file(struct file *f)
>  	}
>  
>  	ctrl = f->private_data;
> -	nvme_get_ctrl(ctrl);
>  
>  out_close:
>  	return ctrl;
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 14a842408035..9cd8fd2ddc72 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -507,11 +507,11 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
>  			 subsys, GFP_KERNEL);
>  	if (xa_is_err(old)) {
>  		ret = xa_err(old);
> -		goto out_put_ctrl;
> +		goto out_put_file;
>  	}
>  
>  	if (old)
> -		goto out_put_ctrl;
> +		goto out_put_file;
>  
>  	subsys->passthru_ctrl = ctrl;
>  	subsys->ver = ctrl->vs;
> @@ -526,8 +526,6 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
>  	mutex_unlock(&subsys->lock);
>  	return 0;
>  
> -out_put_ctrl:
> -	nvme_put_ctrl(ctrl);
>  out_put_file:
>  	filp_close(subsys->passthru_ctrl_file, NULL);
>  out_unlock:
> @@ -540,7 +538,6 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
>  	if (subsys->passthru_ctrl) {
>  		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
>  		filp_close(subsys->passthru_ctrl_file, NULL);
> -		nvme_put_ctrl(subsys->passthru_ctrl);
>  	}
>  	subsys->passthru_ctrl = NULL;
>  	subsys->ver = NVMET_DEFAULT_VS;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

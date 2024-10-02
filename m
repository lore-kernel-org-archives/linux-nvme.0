Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF4ECF31A0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blqLzWAqx+DmM8bXnRQDhQMhHti5vXZL3evTOTh6Jq4=; b=SM9KkKutzEpFOaKcP4xUR+GmVR
	o44ZBWTKuV1Tpc/uNt70pIwRZ30y1ePUz8C3+XkgrSDEoOPZeSHyBa9hLA0Ef8pSF8ZP4zgd/yLng
	BZjFJM3IlIotzARSJF9ZinLtxge9+q1Wy725eNSp2xmU+VoyKnGdLWnIezArKVlS/B95citB4Int1
	mIl04B00VNZCyV1EN+VlF6/KCWlyEoyyT2+GVslBRsyAagaJehrb6EdW4NiKzRL6XNoLItgZw5gIK
	EF7F1TsI7VTWMRVUOLxj+ZiIcG4OKibUuczVHOvLs0Z+1R2BKYWhi8jWRsM4mN9RQXaQm4wY5OOt/
	UcDWVK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svuXI-000000058iq-2bmT;
	Wed, 02 Oct 2024 08:16:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svuXF-000000058hn-3dNk
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 08:16:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 024AB227A8E; Wed,  2 Oct 2024 10:16:34 +0200 (CEST)
Date: Wed, 2 Oct 2024 10:16:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
	hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	msuchanek@suse.de, jonathan.derrick@linux.dev, okozina@redhat.com,
	nilay@linux.ibm.com
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
Message-ID: <20241002081633.GA22436@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com> <20240930164845.8406-2-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930164845.8406-2-gjoyce@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_011638_076395_668D67B9 
X-CRM114-Status: GOOD (  18.81  )
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

On Mon, Sep 30, 2024 at 11:48:43AM -0500, gjoyce@linux.ibm.com wrote:
> +static u32 nvme_get_timeout(struct nvme_ctrl *ctrl)

get_timeout feels a bit too generic for this specific controller/media
ready  timeout.

> +	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> +		u32 crto, ready_timeout;
> +
> +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
> +		if (ret) {
> +			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
> +				ret);
> +			return ret;
> +		}

And we really should be caching these values instead of reading the
register for every security command.

> +	u32 timeout;
> +	unsigned long timeout_jiffies;
> +	int ret;
> +
> +	timeout = nvme_get_timeout(ctrl);
> +	timeout_jiffies = jiffies + timeout * HZ;
>  
>  	if (send)
>  		cmd.common.opcode = nvme_admin_security_send;
> @@ -2335,8 +2376,19 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
>  	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
>  	cmd.common.cdw11 = cpu_to_le32(len);
>  
> -	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
> +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
>  			NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
> +	while (ret == NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY) {
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			dev_err(ctrl->device,
> +				"Device media not ready; aborting\n");
> +			return -ENODEV;
> +		}
> +		ssleep(1);
> +		ret =  __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer,
> +				len, NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
> +	}

And this also feels a bit odd in that it doesn't catch
NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY when it should be ready.
I think just marking when the controller is past the timeout and
only doing the retry until then might be the better approach.  And
maybe we should have it in the __nvme_submit_sync_cmd helper for
admin command as Security Send/Receive aren't the only commands with
this issue.



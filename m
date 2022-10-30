Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BBFC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVzYmWy/hdg06XKEHoMml8OlhOYyvbBC2Jym+l5Axnw=; b=S/xozXyS26aKo5kQblP3w7Ujxp
	W2not65cUxWuKb9X53kso71cxVr6AIh2vn0VrAIusOcZ0K4qbRM/iYnXNAOG6XqpNHZ1wdYnhmOHj
	06C0/y/hPOkPsC/b2Nd/YiAvsyibea2BFwpWWlGb2daNr//+DyvG8L4TL3lHaAYjvqTcYRu2wWTnH
	IHDwIQUqgB/m2BjOR2fW5fHpnr7JN4LV6tzPSF1gyvv73xDo8oB/0ZCzj3jmQB4N7ZFK8MZWsDj7R
	9x1EIeCfHD7OxqKHgbLqKkEyFWprE3c9PiVCBdSJZISjH9hNWUbOqYBZotLtkSy/JQrVVwI37XXH5
	ns597Mrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3F5-00DzCw-Oo; Sun, 30 Oct 2022 08:00:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3F2-00DzA5-2a
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:00:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2477868AA6; Sun, 30 Oct 2022 09:00:19 +0100 (CET)
Date: Sun, 30 Oct 2022 09:00:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-auth: use xarray instead of linked list
Message-ID: <20221030080018.GE4214@lst.de>
References: <20221028135027.116044-1-hare@suse.de> <20221028135027.116044-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028135027.116044-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_010024_422312_88F5D10E 
X-CRM114-Status: GOOD (  27.78  )
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

On Fri, Oct 28, 2022 at 03:50:27PM +0200, Hannes Reinecke wrote:
> The current design of holding the chap context is slightly awkward,
> as the context is allocated on demand, and we have to lock the list
> when looking up contexts as we wouldn't know if the context is
> allocated.
> 
> This patch moves the allocation out of the chap context before starting
> authentication and stores it into an xarray. With that we can do
> away with the lock and access the context directly via the queue number.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/auth.c | 116 ++++++++++++++++++++++-----------------
>  drivers/nvme/host/nvme.h |   3 +-
>  2 files changed, 66 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index b68fb2c764f6..7b974bd0fa64 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -72,10 +72,12 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>  				     0, flags, nvme_max_retries);
>  	if (ret > 0)
>  		dev_warn(ctrl->device,
> -			"qid %d auth_send failed with status %d\n", qid, ret);
> +			"qid %d auth_%s failed with status %d\n",
> +			 qid, auth_send ? "send" : "recv", ret);
>  	else if (ret < 0)
>  		dev_err(ctrl->device,
> -			"qid %d auth_send failed with error %d\n", qid, ret);
> +			"qid %d auth_%s failed with error %d\n",
> +			qid, auth_send ? "send" : "recv", ret);
>  	return ret;

This looks like an unrelated message fixup.

> @@ -870,29 +872,42 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>  		return -ENOKEY;
>  	}
>  
> -	mutex_lock(&ctrl->dhchap_auth_mutex);

> +	if (qid == NVME_QID_ANY)
> +		qid = 0;

I can't see how NVME_QID_ANY would ever be passed here.

> +	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
>  	if (!chap) {
> +		int ret;
> +
> +		chap = kzalloc(sizeof(*chap), GFP_KERNEL);
> +		if (!chap) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: error allocation authentication", qid);
> +			return -ENOMEM;
> +		}
> +		chap->qid = qid;
> +		chap->ctrl = ctrl;
>  
> +		INIT_WORK(&chap->auth_work, __nvme_auth_work);
> +		ret = xa_insert(&ctrl->dhchap_auth_xa, qid, chap, GFP_KERNEL);

GFP_NOFS?

Also xa_insert can fail with -EBUSY here if someone concurrently inserted
an entry now that there is no locking.

> +	} else {
> +		if (chap->qid != qid) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: authentication qid mismatch (%d)!",
> +				 chap->qid, qid);
> +			chap = xa_erase(&ctrl->dhchap_auth_xa, qid);
> +			__nvme_auth_free(chap);
> +			return -ENOENT;
> +		}

How can the qid not match given that the lookup is by qid?

> +		flush_work(&chap->auth_work);
> +		__nvme_auth_reset(chap);
> +	}

What protects us against someone concurrently freeing the entry here?

> @@ -901,33 +916,35 @@ EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
>  int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>  {
>  	struct nvme_dhchap_queue_context *chap;
>  
> +	if (qid == NVME_QID_ANY)
> +		qid = 0;

I can't see how NVME_QID_ANY gets passed here ever.


> +	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
> +	if (!chap) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: authentication not initialized!",
> +			 qid);
> +		return -ENOENT;
> +	} else if (chap->qid != qid) {

No need for an return after an else.  But I can't see how the qid
makes sense here.  But once again, what protects the entry from
being freed?

> @@ -947,7 +964,7 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
>  	ret = nvme_auth_wait(ctrl, 0);
>  	if (ret) {
>  		dev_warn(ctrl->device,
> -			 "qid 0: authentication failed\n");
> +			 "qid 0: authentication failed with %d\n", ret);

This looks like an unrelated message cleanup.


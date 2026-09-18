Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB6BC982DD
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UIURm3QZRxaUv2yfqPiCk/VKzCgSkbYh0WzZULMgB9s=; b=fDpX25OqxPNumGld3P4wiGURgL
	SnZ3S8qAHoFw0BhWRPZPPjMm5XfFqisi3etKqtIUlxJLLQXitE3zBPfFR0fwGi1+khvUpNqQlhoSS
	DNFXId3VkkcWFUbJ4btkHTi4qmX2PrjWy0TjfwhZq1ocMt71HKaw2dkrrkkv4e0PXzETdtnpw/dEz
	pEuvfgy+dFxACI5iIdsNtpEwE7S5xKjO5KDYTMqMnQfpDqjZHFZTHAG80YkuK+LjydYI105uqRe5L
	hleQX5bfDVUJFdZAoZ3iAUimh5fsUIVxizGLpb0ooKI5AEhrLmCqQs7VcyBteC5Hzx/P7fMXd+dpw
	25T1q0uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XLl-0000000EK1j-2GyL;
	Fri, 18 Sep 2026 12:05:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XLi-0000000EJzx-14yo
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:05:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2836A68BEB; Fri, 18 Sep 2026 14:05:46 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:05:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvmet: return Invalid Field for invalid NSIDs in
 Get Features 82h
Message-ID: <20260918120545.GB16425@lst.de>
References: <20260918033932.3864965-1-kanie@linux.alibaba.com> <20260918033932.3864965-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918033932.3864965-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_050550_617905_549FC080 
X-CRM114-Status: GOOD (  25.47  )
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

On Fri, Sep 18, 2026 at 11:39:32AM +0800, Guixin Liu wrote:
> The Reservation Notification Mask feature (FID 82h) rejects the same
> NSIDs for Get Features as for Set Features, plus the broadcast NSID:
> 
>   "A Get Features command that uses a namespace ID of FFFFFFFFh
>   shall be aborted with status code of Invalid Field in Command.
>   If a Set Features command or a Get Features command attempts to
>   access the Reservation Notification Mask on a namespace that does
>   not support reservations or is invalid, then that command is
>   aborted with status code of Invalid Field in Command."
> 
>   -- NVMe Base Specification, section 5.2.26.1.33
> 
> The Get Features handler routes the namespace lookup through
> nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
> unknown NSID.  Both rejected cases land there: a nonexistent NSID
> fails the lookup, and so does the broadcast NSID, which never names a
> namespace.  Both are aborted with Invalid Namespace or Format instead
> of Invalid Field in Command.
> 
> Translate the lookup failure to Invalid Field in Command, as was done
> for Set Features.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/nvme/target/pr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 927e3c44952b..8762ef64aa46 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -79,8 +79,12 @@ u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req)
>  	u16 status;
>  
>  	status = nvmet_req_find_ns(req);
> -	if (status)
> +	if (status) {
> +		/* 82h is Invalid Field for invalid and broadcast NSIDs */
> +		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
> +			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>  		return status;
> +	}

Same thing about the comment, and I guess a direct return would
also make this a tiny bit more readable.



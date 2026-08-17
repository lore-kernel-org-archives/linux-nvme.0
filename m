Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E8DC5DF66
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gwSGZor2XFKGLggORsgz3yt6P7IqwdtrGLOXfmc9+Ak=; b=FoIp/7nOLEVPcJrPd54BMNKibj
	zbF69muGM7XwuZkbdE3nssBRfy0avw0c/t53u8naekJbjD63jGlkw49bE8Kbqiw2FBbAmRZk0u15m
	FROtBBuhR+9FEe9Ed2TE3s/k9JS4edtHA9eVAlfMEonfwF/OKt9s11oQAFIMUv/0aPoq7UdBMBzps
	G3SaKQyrFt4a2HnPAlir8pQpm4C3A7buF+qQc4+NJVsgfYuw0HovMToeNqnO2gKT90LALGt8D1s7L
	qbUOJKFjHn9wlKCa3zkTehAzgg0qWx85CpMB/YYiCY61hjXWB77lKMeTRWoyw3YcTTD9Cabm2a2ty
	mVlmK5iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtfl-00000005ojY-3bfW;
	Mon, 17 Aug 2026 09:30:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtfi-00000005oin-2fPW
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 09:30:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 443F368CFE; Mon, 17 Aug 2026 11:30:17 +0200 (CEST)
Date: Mon, 17 Aug 2026 11:30:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
	harimishal1@gmail.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] nvme: fix racy access to FDP placement id array
Message-ID: <20260817093016.GA27776@lst.de>
References: <CGME20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8@epcas5p1.samsung.com> <20260817071158.2794-1-joshi.k@samsung.com> <20260817082303.GA22747@lst.de> <e8dff6d2-8e2c-4ccf-b8c6-671a1b9e7f09@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8dff6d2-8e2c-4ccf-b8c6-671a1b9e7f09@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_023022_826489_55B2BA83 
X-CRM114-Status: GOOD (  17.59  )
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

On Mon, Aug 17, 2026 at 02:52:42PM +0530, Kanchan Joshi wrote:
> On 8/17/2026 1:53 PM, Christoph Hellwig wrote:
> >> +	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> >> +		ns->head = head;
> >> +		ret = nvme_query_fdp_info(ns, info);
> >> +		if (ret < 0)
> >> +			goto out_clear_ns_head;
> >> +	}
> > The conditional assignment of ns->head here is weird.  Just pass it
> > explicitly to nvme_query_fdp_info so that you don't have this issue.
> 
> ns->head is required even beyond nvme_query_fdp_info().
> 
> nvme_query_fdp_info(..)
> -> nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
>   -> __nvme_submit_sync_cmd(...);
>    -> nvme_init_request();
> 
> Which is going to touch ns->head here:
>           if (req->q->queuedata) {
>                   struct nvme_ns *ns = req->q->disk->private_data;
> 
>                   logging_enabled = ns->head->passthru_err_log_enabled;
> 	}

Then we'll need to assign it earlier unconditionally instead in a prep
patch.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F59C52D6F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKEtWBzni7CfQ0VtUoQzea3eoY9VdlRz/13J7QffaA8=; b=T8Y7KF5UNO5Ke9NqJy1TwEL17K
	q3bYPiFmYDdY7nBQqc6nezfrRa+pcrFwP4hpH2rIXOfboWw+qWiZkQovXhDaAxmyFYOXkcXjHqm7Y
	7+bovkHQYY6L8yC0sCdoN8KwsGyf/qtzqWAai8CFDi9jNcbethpeFz/esSdz+C1hRqzra6x4IjpXZ
	GNimb2RbDaGFhTenJujYruNYIwhVmtIGXr9G66ffmLAAgdRRhGLh21091LwnsqUpNyCidQB7TnlhK
	EMhEY0T6OTeSy7t4620jV4DdUBpUOGJ4zNZuSWNJy1tsPQT62YH6XXD+De0xymEfoA8zg+qfv2Bqm
	g741Yh9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmSq-00000001spn-401h;
	Sat, 24 Aug 2024 08:49:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmSn-00000001spA-13pd
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:49:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F221227A87; Sat, 24 Aug 2024 10:49:33 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:49:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 09/10] nvme: add handling for app_tag
Message-ID: <20240824084933.GH8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104636epcas5p4825a6d2dd9e45cfbcc97895264662d30@epcas5p4.samsung.com> <20240823103811.2421-11-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-11-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_014937_520589_CEF0A9C0 
X-CRM114-Status: GOOD (  14.35  )
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

Maybe name this "add support for passin on the application tag" ?

> +static void nvme_set_app_tag(struct nvme_command *cmnd, u16 apptag)
> +{
> +	cmnd->rw.apptag = cpu_to_le16(apptag);
> +	/* use 0xfff as mask so that apptag is used in entirety */
> +	cmnd->rw.appmask = cpu_to_le16(0xffff);

Can you throw in a patch to rename these field to match the field names
used in the specification?  I also don't think the comment is all that
useful.

> +}
> +
>  static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
>  			      struct request *req)
>  {
> @@ -1010,6 +1017,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  				control |= NVME_RW_APPEND_PIREMAP;
>  			nvme_set_ref_tag(ns, cmnd, req);
>  		}
> +		if (bio_integrity_flagged(req->bio, BIP_CHECK_APPTAG)) {
> +			control |= NVME_RW_PRINFO_PRCHK_APP;
> +			nvme_set_app_tag(cmnd,
> +					 bio_integrity(req->bio)->app_tag);

Passing the request to nvme_set_app_tag would probably be a bit cleaner.



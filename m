Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE841FA3758
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 06:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mgkp1hVF8HPPXGHzeffL9DY1/PZ+CgypD5IansUpcKo=; b=dA0xOCk0EE2+sUpt6i9tSf+Rbc
	tHr1KGE9PIlpatx1H2rIroL0dNyJ/cR4yHpKS4zmzouZV/ef0/7rloc6luki3IwJMzslGie3Trzy6
	0q4q2/9vufyTAovX6/rXzyjbrm/xdCssfIZ5PAIj2gAETiMHyNZ0dv9aC1CDsrL5Igt4wNz1c/6Va
	t+kMkwTwEwCAU+IGR+CNydatioTI0rpOq3lfJeI4iZM+/CJyWEfzsCLpkXUvDpJYqGXnNY6Ty8vj2
	qsFF6g89HbGFubb8eCuTQbv4rboxgaL3sEiUdyutl/KM6sjssS6fp6zeHaSyZsh0oh4KZMK6X2Tp6
	N+E2K9nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqoPB-00000007ZeA-3bv0;
	Wed, 18 Sep 2024 06:43:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqoP9-00000007Zcw-1JoX
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 06:43:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0186F227A88; Wed, 18 Sep 2024 08:42:59 +0200 (CEST)
Date: Wed, 18 Sep 2024 08:42:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240918064258.GA32627@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com> <20240917062007.GA4170@lst.de> <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_234311_523654_7C5B97DC 
X-CRM114-Status: GOOD (  19.03  )
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

> > If the device (or file system, which really needs to be in control
> > for actual files vs just block devices) does not support all 256
> > we need to reduce them to less than that.  The kernel can help with
> > that a bit if the streams have meanings (collapsing temperature levels
> > that are close), but not at all if they don't have meanings. 
> 
> Current patch (nvme) does what you mentioned above.
> Pasting the fragment that maps potentially large placement-hints to the 
> last valid placement-id.
> 
> +static inline void nvme_assign_placement_id(struct nvme_ns *ns,
> +					struct request *req,
> +					struct nvme_command *cmd)
> +{
> +	u8 h = umin(ns->head->nr_plids - 1,
> +				WRITE_PLACEMENT_HINT(req->write_hint));
> +
> +	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
> +	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
> +}
> 
> But this was just an implementation choice (and not a failure avoidance 
> fallback).

And it completely fucks thing up as I said.  If I have an application
that wants to separate streams I need to know how many stream I
have available, and not fold all higher numbers into the last one
available.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1BCC5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4A8xMxZI9jaTSuKYHXVyo90NpDO7Fj9P565GdT33mD8=; b=F8/Yc8bSv+vMIYoitZMR4Mv5Cl
	MHVTjoLtLEs40JZbMGLdbTh39cmT4h6mYEXfgLJZIQfpwersuefMqu0EsztQdJX646mMggRCp24IX
	h0I4hMd9lFX6fserYoEBYTpt/43RI8TrqYi6v4Me/VDZiQ0GuobaWFb/5S/LE0ZpRU+7Z75T3EW/Y
	rSS0AulY4zOa83xEr/6eEMJP8K9FrKihIvvdfiLXB0pIAvYUN4wRutLiwEZ68fXz/g3rtKQ+eVV+p
	91U1m/nNWlNYHcYAsd2YpNU+/8Xpb32Up2ivTILUA4zEMKWArWiPjf2l034bUFXFt5Qk6Qv6pzh9N
	fNMLQ0Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsch-00000005fsP-0LA1;
	Mon, 17 Aug 2026 08:23:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsce-00000005fro-1GaQ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:23:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F74E68CFE; Mon, 17 Aug 2026 10:23:03 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:23:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] nvme: fix racy access to FDP placement id array
Message-ID: <20260817082303.GA22747@lst.de>
References: <CGME20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8@epcas5p1.samsung.com> <20260817071158.2794-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817071158.2794-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_012308_511658_D5F72CB3 
X-CRM114-Status: GOOD (  10.57  )
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

> +	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> +		ns->head = head;
> +		ret = nvme_query_fdp_info(ns, info);
> +		if (ret < 0)
> +			goto out_clear_ns_head;
> +	}

The conditional assignment of ns->head here is weird.  Just pass it
explicitly to nvme_query_fdp_info so that you don't have this issue.

Otherwise the patch looks good.


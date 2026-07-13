Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B93C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TfoLZjNyHqe1D+khy2JOQ1JnHn+TXdSVFpc5YrVbh+s=; b=pF/U97/YskBv6EIXQCyiZymUqP
	x/BmZVL6NcPUoY4AfWgbSr7cOnguhBCX5uc9jthmObZPyTrXeShTqbmr03EZ3fKPbsBSi2e0wKaYE
	EcOLwh0mpd00TI/jooW5bQC/V/lHPSbPRSo+Xc4j/It2T+bQTp0NpgpVhrclUkDcXT/ByGLap96Y6
	pgUR1LzRRC5qYffDKzCROo1fc4TDbuCrFq1STj9He9MJAr5GJzbCKwIt5jFDgyMh2HQ5X8KTRIuZI
	0MPjbcdKRO6iFCcM13BYXxaGZMIoayEEiY83gRMxO5E8vlwo4rzIr5fPTfSl9+HPXJSejKW7HRPCr
	30Sc+EuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFQW-000000097E6-1DLv;
	Mon, 13 Jul 2026 12:06:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFQU-000000097DR-0UGN
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 12:06:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C09D68C4E; Mon, 13 Jul 2026 14:06:18 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:06:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 1/2] nvme: add nvme_get_ns_head()
Message-ID: <20260713120618.GC19607@lst.de>
References: <20260713104238.3034640-1-john.g.garry@oracle.com> <20260713104238.3034640-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713104238.3034640-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_050622_305924_F8A7B11F 
X-CRM114-Status: GOOD (  13.85  )
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

On Mon, Jul 13, 2026 at 10:42:37AM +0000, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> Add a wrapper for getting a reference to the NS head.
> 
> This would be used in scenarios when we know that getting a reference
> would not fail.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

and I didn't realize we already did the unchecked tryget before your
patch.  Good to have this fixed, though.



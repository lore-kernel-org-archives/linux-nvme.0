Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CECC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ln0XPCsZb8T9rPdXg6t9gSJVk82kdxXuSnQXrjWTWY8=; b=0pbNVp3QFC9qUIfuKs1eyxQcty
	UzEtztj+373PiXFNFWU/gCopWC2P7nziI9CZ4xAOQxcjNxq0Kk/sKLa9BsJmBrCus5qpdIA2QlUlG
	344j6drkJdr2tMrIqYbDWjDO69PQi7FeYQwJfXIBxXsedFeAYTLfUrmPb4RffsdjGJ5Y9tXu1W7Ha
	5bvHDa7vK+0Y7tGIoCrkAVsoIiz1mJ1IAhZTcSVryhMjushDkXXQPZFUFjk9qp3nzqlIqkbaB9WXd
	0Cdyu2BXzlz0c+Xok+ECao+n68ESc4AI4KEZ0VtxbSM6gYU/ppuzXCGaj20pzny6wlacURVFFoPBj
	AVQVL+7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYTmJ-0000000C9Zw-3CWd;
	Mon, 29 Jul 2024 17:03:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYTmH-0000000C9WC-1lzp
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 17:03:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DCA0968B05; Mon, 29 Jul 2024 19:03:08 +0200 (CEST)
Date: Mon, 29 Jul 2024 19:03:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: fine-grained PI control
Message-ID: <20240729170308.GA31298@lst.de>
References: <20240705083205.2111277-1-hch@lst.de> <yq1ttgz5l6d.fsf@ca-mkp.ca.oracle.com> <CGME20240709071611epcas5p1c5f2b59325d562658522842f89a31861@epcas5p1.samsung.com> <20240709071604.GB18993@lst.de> <20240726102156.GA17572@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726102156.GA17572@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_100317_630708_66347ECF 
X-CRM114-Status: GOOD (  16.82  )
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

On Fri, Jul 26, 2024 at 03:51:56PM +0530, Anuj Gupta wrote:
> 
> I was thinking something like below patch[*] could help us get rid of the
> BIP_USER_CHECK_FOO flags, and also driver can now check flags passed by block
> layer instead of checking if it's user passthrough data. Haven't plumbed the
> scsi side of things, but do you think it can work with scsi? 
> 
> Subject: [PATCH] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
> 
> This patch introduces BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags which
> indicate how the hardware should check the payload. The driver can now
> just rely on block layer flags, and doesn't need to know the integrity
> source. Submitter of PI chooses which tags to check. This would also
> give us a unified interface for user and kernel generated integrity.

This looks reasonably to me for the in-kernel interface.  We'll still
need to deal with the fact that SCSI is a bit selective in what
combination of these flags it actually allows.



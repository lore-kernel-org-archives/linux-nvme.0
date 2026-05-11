Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A7CD4840
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7d3U4/aW6GYstxG35eFKtdM0EhapdyFcBX7jCJVDNe0=; b=CRACP0kvTBY/kz35RRleDL4XiW
	oML64PXlp719Xds+mESPX2/dhut0Nme7Uy5g4xhrK3To698xmPeGTG6QFGGJpnZ4BnE1ck2KFDasa
	jwLPkgkD+OykSuOOuVrcYuPQ0QIHtwHy2Jun2jxVT3nvEnyg0Fw6yf6Uv0M9u/8MoUlI38Ynz84Eo
	Q268qsKlEU8/7pu2MbdgZHYtr3RjDbHmwrql4oXXyYrDCryRFxRH+x2powBNzvK16vSfCIyl1UPJi
	YUzKIa3QYzC4ymd9iYYt8cn2LAfC1DB2fBrOCVC1GS64tUqOglBbVX+BUpRe/R0qmS59Hr5shmqu7
	wlG4baZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPnW-0000000DXi0-0hGy;
	Mon, 11 May 2026 12:31:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPnS-0000000DXgV-44Pi
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 12:31:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 277CE68C7B; Mon, 11 May 2026 14:31:37 +0200 (CEST)
Date: Mon, 11 May 2026 14:31:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
	kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mkhalfella@purestorage.com, chaitanyak@nvidia.com,
	hare@kernel.org
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin
 timeout per nvme controller
Message-ID: <20260511123135.GA17601@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-3-mlombard@redhat.com> <20260511080721.GB29677@lst.de> <DIFT9EP0Y3DI.29VPGB322MQ8F@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIFT9EP0Y3DI.29VPGB322MQ8F@arkamax.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_053143_264379_2864B048 
X-CRM114-Status: GOOD (  11.71  )
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

On Mon, May 11, 2026 at 01:29:10PM +0200, Maurizio Lombardi wrote:
> Both admin_q and fabrics_q are initialized to share the same
> NVME_ADMIN_TIMEOUT value, therefore keeping them in sync maintains the
> consistency.
> 
> If we didn't apply the timeout to fabrics_q, it would end up
> operating under a different timeout than the standard admin_q, is there
> any reason why we would want that?

Not sure.  I just want to make sure everything is properly documented.



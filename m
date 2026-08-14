Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B622C5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 06:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BkCAaL0QgMjcDACJglHNIc+mPjJVSmhB9wgz/GcnVGU=; b=DhGmrACapAiZ1KfI0HGg0LbtQY
	KfvQHKtitljG7mY1rK5qMBwZg2xLd/dw+jS0pIis4wZyR5KC3ECc3XtX5jsl9HG+beXB9fJoGRx8y
	f4smgIvzWuG2HPNkqQ16KHMVNlm7qv/k4WbPWy1rjTRdbe38+3ubqD60AOX5pH9yQk65aRR2ndQlb
	24ddltGwYLi6ErcoPDfpD29RvFOUcEXE1e4hqdqWySAc/tV659bwZgllmWpr61ecQzP+h1aDJGEVP
	y5oh+udl/EnbuJTzzOlQWdy8tXPW8J0ASJqRbRLypsGN00eT3aHZ+PVwlBJOTEHrTLK1jxokxtNZV
	WCQ2/MGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulWt-000000022sg-0P3j;
	Fri, 14 Aug 2026 06:36:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulWl-000000022sG-2pJV
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 06:36:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 461F168B05; Fri, 14 Aug 2026 08:36:16 +0200 (CEST)
Date: Fri, 14 Aug 2026 08:36:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 00/13] nvme-fc: FPIN link integrity handling
Message-ID: <20260814063616.GA9231@lst.de>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_233627_862035_87DFD3DC 
X-CRM114-Status: GOOD (  10.74  )
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

This touched a lot of core code for a fringe feature for a transport
that shouldn't even exist and is full of unmaintained and buggy code.

Why do you think we'd want to take it?



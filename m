Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC3CFED9E3
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTbGFX1TZVjK4Nz2hqPF0UA1glvRIVTVxow1+Ol1zR4=; b=HV1x2LPXmUOtRGorGPvgIjfuET
	26seCjKK4/XRiGLrdUav/YAuTIw65ZkjD7wltPLa2cd/bNaCIrpSIHsciMJ29aS/4nI+OaQ6TgYg0
	otF4+2ttUZT/lzXWCy5xSF+QT2bLY8aC1/QB6GMnzFYPdusjDfcsyjJUbttZ7zPpbSREXcuR+fdOe
	pvPAC3F9egRbRD/VSAIM61P5LS3y43AxcOKblpXCw4FXBwLjwyr7QNSZgYG7DBnRtxsWgmnDaz6RY
	GZNeTEAnxHVYe8qF3EJTjrUMKaFMQhAp7HS8+BQB5VvDghjW5ybnc8trp/041OfWr0vXrEb7+0KCx
	t9/um31g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Vz6-00000006gOd-2HI5;
	Tue, 17 Mar 2026 15:05:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Vz3-00000006gOI-3yVh
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 15:05:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C68AA68BEB; Tue, 17 Mar 2026 16:05:21 +0100 (CET)
Date: Tue, 17 Mar 2026 16:05:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API review
Message-ID: <20260317150521.GA7382@lst.de>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local> <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM> <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_080526_151178_164D613F 
X-CRM114-Status: GOOD (  12.77  )
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

On Tue, Mar 17, 2026 at 10:26:28AM +0100, Daniel Wagner wrote:
> The only way I currently see to resolve this is by using a different
> prefix for the library APIs (e.g., libnvme_) and reserving the nvme_
> prefix exclusively for NVMe spec APIs. However, I am unsure if this
> approach will reach a consensus here.

I think such a split would be immensely useful, not matter what the
final prefixes are.  The "nvme" tool has similar issues with a mix of
actual nvme command and calls to the kernel or other functionality.



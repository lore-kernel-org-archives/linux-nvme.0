Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E166C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTxTHVGH4NrPNv4Bdg7lSoqdD/RrbvE8+KFKBZNB3qo=; b=t60zQopot1swyuXWggC5uLrYRk
	XCAw8emSbQEsW5vfy/v13eGOu8U7VD1aiDUv2bxMGcP9fB8ne/2OAOxLQyR7pVVmt5JBpVLRynvfz
	TQ9TPiIXvL2WWRpLrNPK+1KWi54IBffAV2S7xXIHHTHIbprVjmldFHHYC5jWJlSNbm/CrETBrC5h3
	fRMnZLiO9H116zMF2vVgGUl0lsKIr2aRTCH9lat6D+yQ1d5bXK2cwbYUCgHTGO9T7IpPgY0ycPf9Z
	No4abnb6Pwz/Z9oi3fGBhF9UEDoUyDfZzz1D9Y/NgZ3KUKrd9W8OyQOgjZoRKLxMuoB0nle/qMFX4
	XuVqUH2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJWTw-00DoUy-3X; Mon, 14 Feb 2022 08:13:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJWTk-00DoU6-AO
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 08:13:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D132D68AA6; Mon, 14 Feb 2022 09:12:52 +0100 (CET)
Date: Mon, 14 Feb 2022 09:12:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Uday Shankar <ushankar@purestorage.com>,
 linux-nvme@lists.infradead.org,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220214081252.GA18231@lst.de>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_001300_548427_EB497E3E 
X-CRM114-Status: GOOD (  16.67  )
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

On Sat, Feb 12, 2022 at 01:22:21PM -0800, Keith Busch wrote:
> On Sat, Feb 12, 2022 at 07:34:22AM +0100, Christoph Hellwig wrote:
> > The answer is neither.  The fact that NVMe with ANA required namespaces
> > to be be attached to the same subsystem is good and important.
> > TPE 4034 is retrograde and completely broken in this respect and should
> > have never been ratifier.  Please fix your storage system to export
> > virtual subsystems like everyone else and don't break the nice NVMe
> > architecture.
> 
> If anything, the driver could check for duplicate namespace identifiers
> across subsystems so that we could warn about or prevent exposing them.

Yes, this has actually been something I've been wanting to do for a long
time.


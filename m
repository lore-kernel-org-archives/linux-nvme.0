Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571FFC83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UckKZ/3kJuYF7wmQUP2qzABTDKXr5iPPl1kXemQ8Cvo=; b=e1PsibL8rvIlZLnseQjxr/kpY2
	mCiO2AzD4yrCOYNJ7m+r9+5FedonuNo7QQ3eJ0YzBaX7FyO8h8W1Xmy+p8NE2B9tsR+Zgd8PR6pd5
	X4iwiTzrAblP4hCDxo6/hNaj0toxk/tR60KZuEn/ilJ7wdlFF2wIVGZKLLgOdqxwuiSW1tIoL0ylL
	UE8BSN38/ybYCZvJ7W7fToN9l3UqEJawOi8pDmzcwD6cpqTx3AlxJiO/I3Y7Cf14GiSadQKUShCLi
	Je7eJ4X8bSNFVwExndk9l+nDzvbWb72+xcS7eqAgH4DpJvkSUH4KLc+GnHtEdYNeqQeVONx4Dk0+b
	wt3hDnoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFty-0000000AmAZ-06ha;
	Thu, 03 Jul 2025 09:06:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFsz-0000000Alzj-41kV
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:06:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 93B8468C4E; Thu,  3 Jul 2025 11:05:33 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:05:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v2 2/3] nvme: prevent admin controller from smart log
 fetch (LID 2)
Message-ID: <20250703090533.GC4757@lst.de>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com> <20250702005830.889217-3-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702005830.889217-3-kamaljit.singh1@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_020542_141083_8C1A7092 
X-CRM114-Status: GOOD (  12.93  )
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

On Tue, Jul 01, 2025 at 05:58:28PM -0700, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.
> 
> In the future when support for the newly added LID=0 (supported log
> pages) is added, GLP accesses can be made smarter by basing such calls
> on response from LID=0 reads.

Let's leave this in.  Failing a get_log page is fine.  The difference
for discovery controllers is that implementing it is prohibited.



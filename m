Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE2CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HP5zulPTUv4kVa8DbnRz9Psg8fsfDSXI8ikH7t2B8Kw=; b=JKcVh4PKuwvU1oQ1ouMayrbo2j
	inRfyCFw2EEzW4A7JFFgFEyO0Ao+UuvrUfeosjFhN0VpLhNnagWLKqDj0p7Nugq8Otqf+5lUAa/m5
	1pzCLLp6/cSViGos0p+QmC2mQSiKGdVfOvLEakTQ5osD55XXAhfVZ1pX/AKILCxlXbEcIxdVZw1gE
	YvwGWNf8rc+V1fCIT88ctKvWr/+5au6TE0rDfYkivVw19c7XMagqWZbHFZX/kdpg6j3sd4SqcCO1+
	DCJ61Wt2GztDZlupxmFcwmDqJQdDrHI7qO1E0N81Emf0itErwZGhoPmCAleuN8g57BWZqbt9sSQiP
	scPkNRhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdJT-0000000Go6S-2tbB;
	Thu, 27 Nov 2025 14:49:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdJQ-0000000Go4C-1lP1
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 14:49:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FA1167373; Thu, 27 Nov 2025 15:49:16 +0100 (CET)
Date: Thu, 27 Nov 2025 15:49:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Eugene Korenevsky <ekorenevsky@aliyun.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <20251127144916.GA9423@lst.de>
References: <aSdiqVR-o6yNav6I@localhost.localdomain> <aSdoeEX_L2-3ccpF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdoeEX_L2-3ccpF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_064936_606049_BD8BE37A 
X-CRM114-Status: GOOD (  18.74  )
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

On Wed, Nov 26, 2025 at 01:52:08PM -0700, Keith Busch wrote:
> On Wed, Nov 26, 2025 at 11:27:21PM +0300, Eugene Korenevsky wrote:
> > Broken or malicious controller can send invalid ns id.
> > Out-of-band memory access may occur if remaining buffer size
> > is less than .nidl (ns id length) field of `struct nvme_ns_id_desc`
> > 
> > Fix this issue by making nvme_process_id_decs() function aware of
> > remaining buffer size.
> > 
> > Also simplify nvme_process_id_decs(): replace copy-pasted `case`
> > branches with table lookup.
> > 
> > Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
> > ---
> >  drivers/nvme/host/core.c | 80 ++++++++++++++++++++--------------------
> >  1 file changed, 39 insertions(+), 41 deletions(-)
> 
> Is this simpler check not sufficient?

I think we'll need a somewhat more complex check that at there
is at least enough space for the len member.  But I prefer that
style over a table lookup and magic name pasting macros.



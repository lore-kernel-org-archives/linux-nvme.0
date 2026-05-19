Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E98CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9NSPdrZJtGTWSoHTnIIz2HdENsXgcyQtNF0A/GX3UV4=; b=FoOqoN8G9W1gq/Ox8v+Zyk11uM
	C7Qr7tY9j9nE/yTdOyOQEoJQlEHe7+rBcdiMT7ewOqWiLWvHknPWveRLEQGncUqgoN8sDCZeArG4o
	Ux3ENuEZs0xS1KKZoVCsD+UNH0Koc2RP333S7DDcVrtKBI8yhbc5vh4X43aB3+YuUnIfjmhCCVxPr
	H8ABzoYsMpZrjEaOAu7FvAF8VtSuHGSJXhaIQi5zCzN71atbhSUGmsvdycD9JzBYyX9ubsDkORanY
	kw9JJhrMAGrO2AocSCAkSnlS1ze33rM0zjgJ2F/aWtg305BwJxs3ogxRxsmpMuGCtcBymVP0hVvps
	+fPorOeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEmg-00000000Tei-2bUB;
	Tue, 19 May 2026 07:22:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEme-00000000Te7-3hdp
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:22:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 389D168CFE; Tue, 19 May 2026 09:22:30 +0200 (CEST)
Date: Tue, 19 May 2026 09:22:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
Message-ID: <20260519072230.GB10436@lst.de>
References: <20260518140945.2751273-1-michael.bommarito@gmail.com> <20260518143706.2808177-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518143706.2808177-1-michael.bommarito@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_002233_061974_077B2C22 
X-CRM114-Status: GOOD (  15.09  )
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

> v2: drop the redundant cover letter shipped with v1.  A
>     single-patch send should not carry a cover; the lead
>     belongs in the commit message, which the patch below
>     already has.  The v1 cover also carried stale drafting-
>     time envelope markers that should have been stripped
>     before send.  Apologies for the noise; please ignore the
>     v1 cover at
>     https://lore.kernel.org/linux-hardening/20260518140945.2751273-1-michael.bommarito@gmail.com/
>     The patch hunks below are byte-identical to v1's 0001.

Cover letters for single patches are not required, but totally fine if
they add value.  I don't think you needed one here, but it also wasn't
actually harmful.



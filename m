Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E496CD5BAC
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lARkCJhaaZ4rsBx8PVOFjZr4ex
	hhJBB1tLmxgYvbdYy4ogrWaXz19K6t4oPi+/sN8RXBfSG3DcC0nAbmdsaoBT/OEST4zMXIMpaX4BL
	cJMspYBayOtZ7Gw+3gGi2gqxk1TfCBVJdv1BXDSz+ym0A9bAKmjPy2X62RtGNSjERL5ok4Nx6yMDx
	vwvbGCy0chFTWNCBs98iY+ed2oWO9eajnrHljxvwKEzkFqROVeboQinMf6C/oram6brUzLlfpbJ+F
	oj4MRC2XrM0RDz2gdta8+HLP2zL7bssf4bjOw2jbyzjTw/Je3MrD5HLbyGFe7x/So5i86kNZ/lhbq
	Gs8Rdx3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQM50-0000000AJmo-2g3K;
	Fri, 22 May 2026 09:22:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQM4y-0000000AJm1-1D3z
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 09:22:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9249568AFE; Fri, 22 May 2026 11:22:01 +0200 (CEST)
Date: Fri, 22 May 2026 11:22:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	David Laight <david.laight.linux@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
Message-ID: <20260522092201.GB8708@lst.de>
References: <20260519190615.2761667-1-michael.bommarito@gmail.com> <20260520133015.1018937-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133015.1018937-1-michael.bommarito@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_022204_466828_C5D7ADB3 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



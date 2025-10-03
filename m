Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CECCA471
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZtHmKJPpy5MpT63RZ7j5eHyj8SMDL3lY5IQBo2rtn9E=; b=c6LvlIGovg2Fic2mj45kMRIvvt
	OiSnJH8srh2Ats7HVYhvYRTyWCaULrq7a4xm7R5ZxrvTXozmLts/Yye1Hl7y4YTH6GkuKej8C4qdp
	NPJ+Hh7hNXrR0cUg3+fZ+Boi0j0FhdpF3MMqNllTQi1mSRCyLG9H2i14U1L3LmOSveHcxr7y1efBn
	SmromClSLQnIV1JDUC/U7awL446KljdBgWNKCk+3t8NGIGppQ+jkGLp+vp8txYebJpk2WJyQYczPi
	LY3FlaJKiYOcMb+Y+C825RcgQ6uWmx0ceXK2/vduBwj0mMcMKfx6gBgped08Vw4HoT7kP7Qs6AVfq
	xFBauQCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cov-0000000C1Qf-3AC5;
	Fri, 03 Oct 2025 10:15:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cos-0000000C1PN-33Y9
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 10:15:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7459F227AAC; Fri,  3 Oct 2025 12:15:17 +0200 (CEST)
Date: Fri, 3 Oct 2025 12:15:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com,
	gustavoars@kernel.org, hch@lst.de, james.smart@broadcom.com,
	kees@kernel.org, linux-hardening@vger.kernel.org,
	njavali@marvell.com, sagi@grimberg.me
Subject: Re: [PATCH v10 03/11] nvme-fc: marginal path handling
Message-ID: <20251003101517.GC15826@lst.de>
References: <20250926000200.837025-1-jmeneghi@redhat.com> <20250926000200.837025-4-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926000200.837025-4-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_031522_912960_68224F55 
X-CRM114-Status: UNSURE (   7.57  )
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

Please don't hide core changes in patches marked nvme-fc.



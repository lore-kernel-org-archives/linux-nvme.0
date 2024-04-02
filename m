Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4411C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rr3+MUzYpf0/8nwilIWgo8FeM+DEI9r4AxE3vMfqoDE=; b=JfLAi/iTpuJQmRQj/V5XWYP+Em
	UKIsYhzeKOmoogXOWdBfZC7hwSTu44GqR4GiDL/Cy9Xa2jL0sTayv9k5QVUiCaz2aQrn8mMe9wNHp
	LbH5OTou6KshCdnnnCrjuHO+Dq0FX1c15yCr5Hp++Qp+Zjok4OLelFqkjP/SYJHZnjaaeMBa+JTBY
	/Ozl1tM5EPVKYHv8DcGoPixQR+/Qw1xmM8kmQN/837ckIk9+2OYBrIJ8gRrkoLjPiAVj//34kcctn
	pix20rS0yxoB+QcnDC2WI3kwrIEh+8dbtHFPKJ4qjxrq5DE7FXJJZmQTW6dA7U7lEHH8B1j3RV00G
	jwACU+gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfh0-0000000Bjk2-2BVy;
	Tue, 02 Apr 2024 15:04:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfgx-0000000Bjjb-379i
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 15:04:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76CA268BFE; Tue,  2 Apr 2024 17:04:46 +0200 (CEST)
Date: Tue, 2 Apr 2024 17:04:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@fb.com, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node
 and print error
Message-ID: <20240402150446.GB1916@lst.de>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_080451_969349_3E10D254 
X-CRM114-Status: GOOD (  12.67  )
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

Hi Nilay,

can you see if this patch makes a different for your weird controller
with the listed but zero capacity namespaces?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b0498f320e6b9..ad60cf5581a419 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2089,7 +2089,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		ret = -ENODEV;
+		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);


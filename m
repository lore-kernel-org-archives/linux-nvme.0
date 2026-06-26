Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608D2CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3T4L93Ir8SQeBcCVTDDP4UHl721nY2iLqrzdXACqP9Y=; b=Gj+TGYKwraaTxgoUH4ewjoQVVr
	tg8qgh6fKEK7TIEmOiDBZIWy1eVK1EIhci3PwSOlCjSoE+IZaOBL5C135YjCbys3NrexepU5IcE9G
	XvbMYaxToMDC347vPGvG4W2VGaYDVXhdeOfRwBuw9X+pHpIfUAtlPkRXKYJwczVS4SSLdG7OZzTgF
	9wBbPGohFVNy4h+9t+rf6zmRCG57jB/xU1b55+ExjnzTLHol5BxYgHejg75ZrSDZmuUCILLLOo7yk
	1vEgMSb84+NtUi9OhYP7jCotYxgeoSwdRI8eozXQMYCIhFmNzl4GeLDYgLcjETH7BrrxXsrHOe2E/
	mgzU93GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd08P-0000000AbV7-08lZ;
	Fri, 26 Jun 2026 06:33:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd08N-0000000AbUn-07mQ
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:33:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFBBE68B05; Fri, 26 Jun 2026 08:33:47 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:33:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 02/17] nvme: add Clang context annotations for
 nvme_passthru_{start|stop}
Message-ID: <20260626063347.GB10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_233351_221796_B5667630 
X-CRM114-Status: UNSURE (   7.71  )
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

Note on the subject (also the following ones):  please just say context
analysis.  Currently only clang implements them, but that's an
implementation detail.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5333DCE8D52
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2024 07:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P5chTAJhzgcSOVZi9MlR+G0Sfml0Jgqb7wT0YNw3Gh8=; b=SufS6nlV/6C6CHAuT1nyugtsGH
	1Bj9EUexCAVlSf6h6AMpzuxs8bHULYrOAXzXHDlnxrqwirtHj+atRBmuWBh4sLQKoRExqIFc9/TTd
	owzpyAxroSIg4/c447edQ4kGaEjo2lgSI0ttZA+4j6DMe80XsLqQx5Wg9AMNgATMUmlyvv01eeXDP
	4jYoUvqafAI4ATOyztx0y9C7PhvupCbrKZPysUBPxhdJRcKCp9dFchJvm8mxBjNKipsdaD1LunCdS
	nSmIa4PH62/u0kZaE4IGikpiEbtktikRT727wK+9en4yr2/SVCIsXdBI6dP9QGi1yPqk5i901NREJ
	dIVjmHHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srBnU-00000009g6f-3x81;
	Thu, 19 Sep 2024 07:41:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srBnR-00000009g5d-21sz
	for linux-nvme@lists.infradead.org;
	Thu, 19 Sep 2024 07:41:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03089227AA8; Thu, 19 Sep 2024 09:41:40 +0200 (CEST)
Date: Thu, 19 Sep 2024 09:41:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andreas =?iso-8859-1?Q?K=FChn?= <andreas.kuehn@diekuehnen.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Open brace following function definition on next
 line
Message-ID: <20240919074139.GA23725@lst.de>
References: <20240918132939.10127-1-andreas.kuehn@diekuehnen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918132939.10127-1-andreas.kuehn@diekuehnen.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_004149_690559_53F644FE 
X-CRM114-Status: GOOD (  10.20  )
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

On Wed, Sep 18, 2024 at 03:29:35PM +0200, Andreas Kühn wrote:
> Open brace following function definition go on the next line. Fix it.

That's indeed our usual style, but random drive by cleanup aren't
really all that helpful and just create clutter.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B475CD5BD5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjcGq7vUDXo1n5PykEgO4JuMPpCYeKxB6AIIwWOjARo=; b=ntr45t3YK3uOVo0PllWLPAIp5X
	5SNvBTI5mAU8+MRuPgFVh6tCWsrfUSLjDAcTva0blUinYbaxMHS4SNzx4BTLCkjo82R5lujwPWzZJ
	Yfny1xssFZcWyx6/VU4VAaKR1I8gszTI3RI0JfOD09IQLNRn2M5MCg6MsrT0+EJAasXs0K0mbZGzh
	IkxqdlzMqX5NYCxeh4cUeAz3ykQ7nZHFL5qjDgkW34n6ghZ8gvKA+hT98ASLV63UwledQ51x30b/D
	smp8V4F+tKwVnd+HDyhDN18luSMGYCrYGX48zDvji2LG45fY7BS8bO1nRd4bZu3AcH7ttEYr7jWrd
	718O1qxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW8E-00000005OEm-0JTL;
	Thu, 28 May 2026 08:30:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW8C-00000005OE3-0Aqq
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:30:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2413968BEB; Thu, 28 May 2026 10:30:17 +0200 (CEST)
Date: Thu, 28 May 2026 10:30:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nvme: fix FDP fdpcidx bounds check
Message-ID: <20260528083016.GB7073@lst.de>
References: <20260527133205.GA12042@lst.de> <820c56d3908ffa2726e38c31eeb5d3d7701fc590.1779930057.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820c56d3908ffa2726e38c31eeb5d3d7701fc590.1779930057.git.gliuxen@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_013020_220807_09ACE6B7 
X-CRM114-Status: GOOD (  10.61  )
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

On Thu, May 28, 2026 at 09:43:24AM +0800, liuxixin wrote:
> 	<cover.1779930057.git.gliuxen@gmail.com>
> From: liuxixin <gliuxen@gmail.com>
> Date: Thu, 28 May 2026 09:00:36 +0800
> Subject: [PATCH v3 1/2] nvme: fix FDP fdpcidx bounds check

Somehow the mail format got messed up here.

Either way, the patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



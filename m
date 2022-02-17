Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C8C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 02:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MdoCcAk+OLslw71aT1g+FLgvYQdVds+g0psKDyCv4Dw=; b=IianZ0RXtHcLFGF2ogb0AsrtfG
	Ra7Xp/m+g0mdlkMS5iSXkTA4+Eni8X4mEEtLkuZk8W9Ztr//w8HDLed2PElcFvX4wLPrhY35OqE7I
	q4KHY3jJ5TCuQHpJUs9XCvzL1FnSuMBeqAFAB+vmTO0H673bG+wtkl3mVl5xks7ErElNAuVbBUzA/
	+CWgpfLneqnykpYtKR6YeHzL2jwM/Ei1lRPaJRk9BzhGeAo+ep0CmoJ4gXkbGBJZYwascSIJU15ah
	TCIBfmvVSu0G4WvTxw2wW0ciQfb7Tu4tUH2PM3oEJw5PCbq2ssnEd2d84QV7/UdKVEoc+KO+zv0ob
	KMmqkjvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKWLX-008joo-0m; Thu, 17 Feb 2022 02:16:39 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nKWLT-008joa-HD; Thu, 17 Feb 2022 02:16:35 +0000
Date: Wed, 16 Feb 2022 18:16:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, javier@javigon.com, anuj20.g@samsung.com,
 joshiiitr@gmail.com, pankydev8@gmail.com
Subject: Re: [RFC 03/13] io_uring: mark iopoll not supported for uring-cmd
Message-ID: <Yg2wA2xxrDthoCDi@bombadil.infradead.org>
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142233epcas5p3b54aa591fb7b81bfb58bc33b5f92a2d3@epcas5p3.samsung.com>
 <20211220141734.12206-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220141734.12206-4-joshi.k@samsung.com>
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

On Mon, Dec 20, 2021 at 07:47:24PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Currently uring-passthrough doesn't support iopoll. Bail out to avoid
> the panic.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>

Jens, can you fold this in to your series?

  Luis


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED1C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iM/K7mf/amSNC2IoVBnznB/hJH3Een9UGVC6zV6NeY=; b=tQh2zbLKTZkn/+5XfLAn6eyg88
	HlafmhpQxUqQtH8DfaBL1l5QbVCupDWVAir1ZIPSoxoyU8ig70DC8Pzjd6cYQpY8ohABLcXCDARGD
	8H6QGpjBbctFOPd1hoBwhYRcfbcprlY8PQ+jRipjDcSKJ7UmiMpRixNOCi03o/okUINF23ccNY28a
	pKEhLqppADz/Zv0nxLp/wNpNRlQddz6MLN5JvZ4lJQJmjwSaL50AVshtXcIS37mnAdy1sce9qYZYw
	P1x+fyVKspb86rWEQw9g4DtvuLSViRnbzh/dGcM/GYpzjod9o4HrJIdO+z0AyFVjd5iZ9/982KFtL
	7EYIYCwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovD4y-000wcy-4T; Wed, 16 Nov 2022 07:43:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovD4w-000wcU-Kn; Wed, 16 Nov 2022 07:43:26 +0000
Date: Tue, 15 Nov 2022 23:43:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	"Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Keith Busch <kbusch@kernel.org>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3SUnt6uuPoMiAVE@infradead.org>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114203412.383-1-jonathan.derrick@linux.dev>
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

On Mon, Nov 14, 2022 at 01:34:12PM -0700, Jonathan Derrick wrote:
> Adds a test which runs many formats and reset_controllers in parallel.
> The intent is to expose timing holes in the controller state machine
> which will lead to hung task timing and the controller becoming
> unavailable.

This passes just fine for me both on qemu and a thunderbolt attached
m.2 SSD.  So it seems to be hardware / timing dependent.


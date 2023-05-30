Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D79C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWWdPmiGz+I1qZLHvpqK5zN+jIL1btM5goMCaUaSM3Y=; b=xoRuBt6ZN5zu6CXw+Infm/2t30
	W1R+h+6OEVw30RhIzYUfOovnRT+51Ily22LhZJWHKxfRCCdY/+Bhanwb0KYxv2mZc75H+1T0tv4ZW
	xdTzfwYN/P8ucpL/GGLuu87Rapb9ZjHQpqaeJBky93l0Fri4sltY6boQtvGMq4He6OmH8SaRB+NHX
	438F+8fCnaE904hM38PECHjobBpCXpSaF2pOLUGYXM1fStQY+4z9cb3t1T9xgS/CGzmhrfsgjpqAt
	jZZqumYYFgH7bd4VZlPwaqWJIjmTzvZqmarUnOjRInfAEwxRjvAwKOU9IbUVTAqpzcfQGEAyApO2a
	afhJ+v6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4294-00EYn1-23;
	Tue, 30 May 2023 16:24:26 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q4292-00EYmV-1p;
	Tue, 30 May 2023 16:24:24 +0000
Date: Tue, 30 May 2023 09:24:24 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <ZHYjOFNo0eV+VeCL@bombadil.infradead.org>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530154231.8313-1-da.gomez@samsung.com>
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

On Tue, May 30, 2023 at 03:42:53PM +0000, Daniel Gomez wrote:
> Increase block size variable size to 32-bit unsigned to be able to
> support block devices larger than 32k (starting from 64 KiB).
> 
> Physical and logical block size already support unsigned 32-bit.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis


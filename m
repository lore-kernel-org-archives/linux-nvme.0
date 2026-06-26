Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D10CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SfT9QFf2D/HFoZ1hcpEDTY2yNk+HMK7BcksFVdyxM8=; b=FEfvLUiqsWrscCm/XX3UpTen33
	t5W3Xfo/GHfGPvqm3dU9n717YjqLDI0+87QGHNyuZFj6JqbVIL3lLqNovQTMBa+AEnWJuV+iFeAkI
	u3a7efDGLt23/eLzIgjxVGIkv1GndTvTVQ8Aa18uTS53KPbTg8ylgJDsjDIi8Nwu0Q7l8cw7Pc2ID
	r6e2PiCvGFPL5QNGUaQpyuuS3CTafciTS6o6TMkQyqDwYXk4A6VculFb0Dk+NZtoGVJeFeEIrkpF5
	EVeZQOWtZynvkC9mghr1udFisxS6D0BWn+D5aSR9oSqr/z0pUDg83dyNcYMFFgkbxuKtUacClhxFD
	GPJjcTRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0b3-0000000AdiT-2C4S;
	Fri, 26 Jun 2026 07:03:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0b1-0000000Adi5-0hde
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:03:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C73168AFE; Fri, 26 Jun 2026 09:03:24 +0200 (CEST)
Date: Fri, 26 Jun 2026 09:03:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH v3] nvme-rdma: pin device wrapper in remove_one
Message-ID: <20260626070324.GA11524@lst.de>
References: <20260623002329.3880334-1-zzzccc427@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623002329.3880334-1-zzzccc427@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_000327_360834_8A080119 
X-CRM114-Status: UNSURE (   8.03  )
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

What is the wrapper that the subject talks about?


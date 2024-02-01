Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DE5C47DDB
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VO6xstmzdIdXk/LqrcTYiPvGIqHnd57jyb03CJaUrtE=; b=jyoJVEdneTtXamWuJsrzbnAO1+
	kgQliXbDjKvWTaisWT016N6f9OZ+mG+dgpVLy3V6zsw7sMoMrxGQ+/AVF+v88ssttMJwnnDOXg7Wx
	fKFRVERHkFWiXuyLQI3W+p0S81OpDkrhhOd5W1RWfGJAcU9itHwXKrl6cS3T6XHwkQlRe4xlm7RiI
	bgn5Mg7c922keJ5oE03cTt1anHxBYayufns8IdZk3oenWeTksCHg7jKSHnOwZoLL16thkv7Hp7wrD
	aXHN6DwEX/yCQKyTksBJ/Vyc+CoLvVMkmAdze1782moiY9qoN3LEcEfatvD6/PSliKofpwHv0dmU9
	LfKN6CLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVRDV-00000006sFd-3xR3;
	Thu, 01 Feb 2024 07:10:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVRDT-00000006sEl-1pLH
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 07:10:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC02968AFE; Thu,  1 Feb 2024 08:10:27 +0100 (CET)
Date: Thu, 1 Feb 2024 08:10:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <20240201071027.GA17571@lst.de>
References: <20240131130400.625836-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_231031_637761_9189B95B 
X-CRM114-Status: UNSURE (   9.21  )
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

I don't want to spam the list with a full resend again, but I've
updated the branch here:

   git://git.infradead.org/users/hch/block.git blk-limits-base

   http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/blk-limits-base

with the bisection hazard found by Keith and the various review tags.


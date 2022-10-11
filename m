Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15A4C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 06:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gAmSm+hmcyME9uHbGP0nKwJb1jO8XrHCKiRoZYlYP9k=; b=AUJ1+dIDSAJi8aqflaeVT3GlqP
	Re0kqh0bIshtrwNMwaF7sP6bJJF4XcFUhaPPpAf4cbbUVc7Z5zjA3yS2bVHMYgBXgSvNZyIbxU9SE
	n46dZdPFY64qsRRgJK0ZDS3311aW1UgzfOIoICgvjCpytN6Bepov0U9BNa8LAyaraxGdPLGspOfu3
	u5ry6nq97HUwAD0nW32letYkcCg9XO4QSolzMOSSAolkNTitZX+F2O4zP3QP7CXUpNBnxbbVxXdNw
	S6LV1GnSjnyFjYTjxytGwNsZZ8bD3C947m6C4YRXek2CJDytnWvTnpDe7b+l2RC7sDFx1RnxzVgZ0
	xBh5SS9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oi8Ri-003MyL-W3; Tue, 11 Oct 2022 06:08:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oi8RU-003Mt9-EV
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 06:08:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7BC767373; Tue, 11 Oct 2022 08:08:29 +0200 (CEST)
Date: Tue, 11 Oct 2022 08:08:29 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@fb.com" <axboe@fb.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"Bacco, Mike" <mbacco@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Park, SeongJae" <sjpark@amazon.com>
Subject: Re: [PATCH v2] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Message-ID: <20221011060829.GA3172@lst.de>
References: <20220929182259.22523-1-risbhat@amazon.com> <EB43F4D1-BFD0-408B-93E7-10643B59F766@amazon.com> <b73250f3-2dd6-36da-4d69-3149959f2e67@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73250f3-2dd6-36da-4d69-3149959f2e67@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_230840_661170_3D81F199 
X-CRM114-Status: UNSURE (   7.40  )
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

The patch already made it to Linux 6.0, so I'm not sure what we need
to review again.


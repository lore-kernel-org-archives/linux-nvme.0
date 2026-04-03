Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDF9E88D85
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 04:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=BlTGqnCJGh4mB5RDKBN0tAN5xbPo1gnzhzo9p74pj1Y=; b=MyvbCC2idAO++6
	F9CVWV3dwfPquhq/p2mP+QMCeJeMLsBeNRiD58ubrAYkJ9oC5TaUL90GnVZF6ebB1UsKDbhbWRo+t
	vZwLe6M7klmkcduZEXiekWJH0y7AprICx1yyVKlnFqFNg3fn1PorkAR+7zE8uH0DZDdm5BJZWq/RF
	rsHLPj9Kj26CNbQfSi2dCz+3jkEzI5gPQNDSOf6e28kM2O2CEKfyJZm4K7bfVU6aPiP9LF6JxRQsk
	bWOcVF/1LXKgXLthRS+yyGALhO3Ly/M3StLwgQQ7VCzUGZHSRKYG3QZ2rAKTXahwG7yofu1idl3d4
	HAu1djIKv4VY30Artlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ssC-000000037MP-3D6b;
	Sat, 04 Apr 2026 04:44:40 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8b42-00000001psV-04Uc;
	Fri, 03 Apr 2026 09:43:43 +0000
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8FFDF40737CA;
	Fri,  3 Apr 2026 09:43:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8FFDF40737CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775209418;
	bh=BlTGqnCJGh4mB5RDKBN0tAN5xbPo1gnzhzo9p74pj1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ArS3juWVKe95xJXrOX2F6Ro0yZ8cseolXjAQ6iDUHnykQIiPxXKnylqzTCAnec2B8
	 q535YNWxALE+971ppWvQ43SqWyBv38lZaCMpA0iGwTw8p0Madg3maVBBl5//FHUIaw
	 ZiJGLy4cUxRlmBaihFSGjT1GykEtfuoERsRO8eis=
Date: Fri, 3 Apr 2026 12:43:37 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, 
	Peter Wang <peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Seunghwan Baek <sh8267.baek@samsung.com>, Seunghui Lee <sh043.lee@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Brian Kao <powenkao@google.com>, 
	Sanjeev Yadav <sanjeev.y@mediatek.com>, Wonkon Kim <wkon.kim@samsung.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 6.1.y v2 6/6] nvme: fix admin queue leak on controller
 reset
Message-ID: <20260403123652-2fd721d0de63be980e2ec1e9-pchelkin@ispras>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402-fox-attic-82ebf113@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_024342_223060_013517AC 
X-CRM114-Status: UNSURE (   7.79  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 03 Apr 2026 21:44:33 -0700
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

"Heyne, Maximilian" <mheyne@amazon.de>
> [ Have to do analogous work in nvme_pci_alloc_admin_tag_set in pci.c due
>   to missing upstream commit 0da7feaa5913 ("nvme-pci: use the tagset
>   alloc/free helpers") ]

nit: not actually needed for 6.1.y because the only callsite of
nvme_pci_alloc_admin_tag_set() there looks like

	if (!dev->ctrl.admin_q) {
		result = nvme_pci_alloc_admin_tag_set(dev);

Though that doesn't really matter and not worth resending I think.


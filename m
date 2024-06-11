Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67FC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6i8zumLIw7NdO+AtGmvgMx98SFLn4lQoL7iRtmc+54=; b=YTgPruGflxfnJF4n45VCul11VN
	XmhHO58QPw+UThmLFun9eMSvN8eQ2T+dZeM6JoMQyaWP7PQ4iRfwpJRUMPefqnm4MnqQCjoE+ITlr
	qNPF9bI8MDSDQcKEU2qXiljhszkucmIc5Zp60Fvxx36HzozeXfrQckHIZ4mkuYIMhbZteBgs57khs
	OgZ9U4ZamvRbL9LcTraVgnQ+SzUIw39DQvagBeXZMANQx2mfuaqAbvXspXgVGGisfRWtRs9TQxZ5M
	aX8/B8G+zEuu9fL+o13Blzf5PzwLKI0QUgZjr4CVPuDar2Ni6cpl3X9ZGxmWLW++XWuj9FCxOps0x
	PV4tBuNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvCO-00000007k8F-208P;
	Tue, 11 Jun 2024 06:41:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvCK-00000007k7j-3juA
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 06:41:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0211F67373; Tue, 11 Jun 2024 08:41:33 +0200 (CEST)
Date: Tue, 11 Jun 2024 08:41:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
	Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240611064132.GA6727@lst.de>
References: <20240529160053.111531-1-aaptel@nvidia.com> <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de> <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me> <20240610122939.GA21899@lst.de> <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_234137_170229_DFDCB4D0 
X-CRM114-Status: GOOD (  17.59  )
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

On Mon, Jun 10, 2024 at 05:30:34PM +0300, Sagi Grimberg wrote:
>> efficient header splitting in the NIC, either hard coded or even
>> better downloadable using something like eBPF.
>
> From what I understand, this is what this offload is trying to do. It uses
> the nvme command_id similar to how the read_stag is used in iwarp,
> it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
> the command_id to an internal MR for dma purposes.
>
> What I think you don't like about this is the interface that the offload 
> exposes
> to the TCP ulp driver (nvme-tcp in our case)?

I don't see why a memory registration is needed at all.

The by far biggest painpoint when doing storage protocols (including
file systems) over IP based storage is the data copy on the receive
path because the payload is not aligned to a page boundary.

So we need to figure out a way that is as stateless as possible that
allows aligning the actual data payload on a page boundary in an
otherwise normal IP receive path.


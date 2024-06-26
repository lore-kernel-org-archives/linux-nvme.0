Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E16C3064D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCTYOKymwFF9lbZxJuUmPnDtNdJWc6lUvU72/xA/53o=; b=0cNxQJfqipYofNxF8OACFMd7zq
	Xblkm0CdsDCmFXr72c//FhmkZKIrs/c5gq9J4HOWSbNdRVzT2jP9fLoQrsEvbQumtuak/pmasu1tR
	8u+KaD1f4n93Gy3OT4VvfmVR/AqScFl8a8YDHWUwYIimqamyJfHM6W+UC9h6zrEl9Kl4KssTVXDHW
	l3CoWoEYOJqEN+cfM2TAIFK/DQmaStOzhoTMw3v/gSiOQpYEVJKI6AKvqNZqwyrmhZTWv/hI3m0w+
	yEdVrJCf0xkdtoXnK+fiNHT8vZ0J2BbsbBADm6+alqUS/6Oa2mJ1xLGfn/olQxx/9PYo4XyXJ6LFU
	435I+y+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMUuh-00000007Su0-43hi;
	Wed, 26 Jun 2024 15:50:27 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMUud-00000007SqK-3E8i
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 15:50:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B4869CE2B29;
	Wed, 26 Jun 2024 15:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707C4C116B1;
	Wed, 26 Jun 2024 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417019;
	bh=udilUP9QJArcgyMP6AgqugC0tzaFDqpIwZeV/EYoOjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NGKZdkB9wmHhzG1udefXK8CwYhsvgWTSxQF4so9tYeWPv2xt2NFJKOeCh84sEDUAe
	 MAQIF9W5vjTpp7MMCzDd3iVWR2y2SI6cTu+QH4wDVaA9qZhsNYnjBHiMcs1dgm3gYp
	 TOaIlj27JITIV/4mMXTOhwcqMgnsd+ovaNRaYKw6SLrsCoWYleP/WsgdO4vzNUhPf5
	 xdEumhD4xXpkBFqBj5o9H1sO1NHt+NFCNi08mLsSijrAomVDTgn5R8YP4FU1L40Mqm
	 C7Yr/W1hKYdK0q6tRq9eTr8XvdsdITf5eMsImtCSCBOEwLn4qVVrx386TzS62oWpFb
	 J3vXLCn+g/HVg==
Date: Wed, 26 Jun 2024 08:50:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, Shai
 Malin <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
 Yoray Zack <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, mgurtovoy@nvidia.com, galshalom@nvidia.com,
 borisp@nvidia.com, ogerlitz@nvidia.com
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240626085017.553f793f@kernel.org>
In-Reply-To: <253v81vpw4t.fsf@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
	<20240530183906.4534c029@kernel.org>
	<9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
	<SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
	<253v81vpw4t.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_085024_299106_487916F8 
X-CRM114-Status: GOOD (  16.71  )
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

On Wed, 26 Jun 2024 18:21:54 +0300 Aurelien Aptel wrote:
> We have taken some time to review your documents and code and have had
> several internal discussions regarding the CI topic. We truly appreciate
> the benefits that a CI setup could bring. However, we believe that since
> this feature primarily relies on nvme-tcp, it might achieve better
> coverage and testing if integrated with blktest. Your design focuses on
> the netdev layer, which we don't think is sufficient.
> 
> blktests/nvme is designed to test the entire nvme upstream
> infrastructure including nvme-tcp that targets corner cases and bugs in
> on-going development.  Chaitanya, Shinichiro, Daniel and other
> developers are actively developing blktests and running these tests in
> timely manner on latest branch in linux-nvme repo and for-next branch in
> linux-block repo.
> 
> Again, we are open to provide NIC so that others can also test this
> feature on upstream kernel on our NIC to facilitate easier testing
> including distros, as long as they are testing this feature on upstream
> kernel. In this way we don't have to replicate the nvme-block storage
> stack infra/tools/tests in the framework that is focused on netdev
> development and yet achieve good coverage, what do you think?

I'm not sure we're on the same page. The ask is to run the tests on 
the netdev testing branch, at 12h cadence, and generate a simple JSON
file with results we can ingest into our reporting. Extra points to
reporting it to KCIDB. You mention "framework that is focused on
netdev", IDK what you mean.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF87C3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkJYFDmi++srkAyLAt3+Jwc6GNdjUpaQfArvFb/GpQk=; b=tyca5bHU2BiAgYJzph4weniMv3
	O9sNdDeioB6cV/pEDf5BmUQrncAJB76hQRpfEB+gbv/BvSZCrRYykbngCOPhoA6h+3J4tUMJUklg7
	ki9TYF7DgEBbJEKNjPWoDs+RMcXdWvdkXs0lnWOy8eIInlk3TO//tuCEUZ7jaz5ho19f3KnVWdfhi
	WMTQbf5p/4jv1EgAKB/ijxQnuXAAtThoXu2k6o6egDT8SdA94FcIjZmO1J0w0kWeSnqxUra0EpN4Y
	5kTwH/yjQrDDtiQUpBD/maJbLgDL2Oj3G/qi2QGRRuo/AlVJbDkMlREGMSJvxNatZetGZIycaGaX9
	SGwLEJgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW3f7-0000000AyhR-47OS;
	Tue, 23 Jul 2024 00:45:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW3f4-0000000Ayfk-3MbG
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 00:45:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2339460B6B;
	Tue, 23 Jul 2024 00:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31930C4AF0A;
	Tue, 23 Jul 2024 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695549;
	bh=GkJYFDmi++srkAyLAt3+Jwc6GNdjUpaQfArvFb/GpQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vEx8pyTpm7Ry0LvK3iONtB7g7kb2ORTSzy+SDxKk49cxZRaujmCT/7aQtqlOkhjBK
	 E6CZFTqexYw7xRRjcDtZWd77N7zBxdpXdGX36CS5qA+aVlI9IFZT1n0hvSp62Pi6WJ
	 92NdmP8ZR9S463RHLqddVNfiN5h80Tr+5jQXIgakmdV5sy/bq07Nhf1onLCDVwLwzT
	 7Scr2iiWlsgWxU5Zjz5QGupora2UCK/RxbISOI3quDw/1Au8229TtgciflnVXmWxWk
	 TO8JLkEnH+0C0h6PraGxV3Uve8ElkseriFjFdqrHYCSw3fgcOjYWzLbepXh4tsmFbt
	 pZZVogBof4GaA==
Date: Mon, 22 Jul 2024 17:45:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
 edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240722174548.404086ec@kernel.org>
In-Reply-To: <0cc50a53-fd8f-433d-bb69-c9d3f73ceace@kernel.dk>
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
	<0cc50a53-fd8f-433d-bb69-c9d3f73ceace@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_174550_936881_6F5228A5 
X-CRM114-Status: UNSURE (   7.23  )
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

On Mon, 22 Jul 2024 16:21:37 -0600 Jens Axboe wrote:
> Who's queuing up these patches? I can certainly do it, but would be nice
> with an ack on the networking patch if so.

For for it!


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C40EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=; b=Kt6qTz3DhGA7rf4SAQSSNoM2sz
	ydg0yW8xGhpqmoVianKhE+l7c2SWMUX33fbevzTAfskBQqK52vrN3e++O0KQzgoaeS/5nEVN+vOOP
	bUrc83Ta8vK6zaYO7wxVPLRu6RPUPsQfmfhAGyjSIXj9uQL9JOqqxhFT9Bi2Dx9xBaiAtQ0tdM/HR
	Zz670A/iVSrFkMrs0DmG24QJVzFJ3igeUAF6go9WyKY5Sb5OoCDseRwuEqCecVragBMP/wj59xVaa
	lx2igxt6vR3nZ2TitcF2zDcNQVU8efGQfWjAp5IBIJTlFwaN4IO0iL6JbkY9R+l6CfKFmAEmBmKxx
	u0lgR6vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcgN-000a6h-1z;
	Wed, 12 Jul 2023 16:27:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcgK-000a66-35
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:27:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7C9846181E;
	Wed, 12 Jul 2023 16:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6060DC433C8;
	Wed, 12 Jul 2023 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179231;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQbNWaOaEizbCcCcZdgGihct5HzRCHog1s+VqMGS+EM59SaGiND6CB+UHBR4e2cqU
	 bibWgsMd7XC6Z6XAS7hND6S24BkQZrYsGND5kdRysFdmzLRybo4DcHGIAs/H8Bm/VV
	 NjvPi5pMHb6QEMF/LKpIwx+F/fUO1unAMEIN+J2SrT01zSVi7fxpZBwl0UxZ/hSq/Z
	 81QfPhMFbKzPE7XdW7cftF5hJy3151rIzjTHXENlSVhxl0PQ2KPenoZozudhYuUcCJ
	 smUoJUUNszpTmuZqtzN/lKm1anNmd16WM0MkSayr6kUoGIiypiXAtqJhBvKdCt56qd
	 t50DLHA4MdgCA==
Date: Wed, 12 Jul 2023 10:27:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Minjie Du <duminjie@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers: host: fix parameter check in
 nvme_fault_inject_init()
Message-ID: <ZK7UXdV0zmStHyyT@kbusch-mbp.dhcp.thefacebook.com>
References: <20230712111838.11923-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111838.11923-1-duminjie@vivo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_092713_034213_E30FD298 
X-CRM114-Status: UNSURE (   7.76  )
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

Applied, thanks!


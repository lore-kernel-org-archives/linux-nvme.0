Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F66C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsblZq4Vy1D5xhsmIckbMgxJiA3763x8Y9bms9Mn7QU=; b=2lQxMm3nau+ZzxynuyJ8s8L5nu
	U5G55MePTQz6GWz1K/IWvl82ev22kQaB1rFAQc7thLvLq3upVLfrwCzcPIrdTAPJK5vrn5hh6sDoZ
	L24woc20bXnxyngxfjfcYHbZiYaeks6ae6TqBJXylnqVpBgoEx8UXNBUjCfY+ntUIiJVo/RXjdSbR
	TX7tabVJG5mtd5C7ZaO6T89Alry8oOLJoc+h6qyyVFHakL9E3QefuT4KSu3uYmI54jmJh7+/3tLUY
	y9X+QdhnINItcRPCfncCXYWR6frhhD6gf+eAPI/fkDdaFnlDd6FlP5h3ta4SSMxwSbnhXbgiaxaWR
	5cDmaZIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqVb-00000008V4i-3rnB;
	Wed, 05 Mar 2025 15:18:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqVZ-00000008V4C-0Hhh
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 15:18:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 927745C5C20;
	Wed,  5 Mar 2025 15:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474FC4CED1;
	Wed,  5 Mar 2025 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741187882;
	bh=4/XUH4d6qHByGlAYL7Gr+YXKagxCHVRhwdzC2f31ZOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nl73jgPhaTVbXFF+Cs/OL3fP5WkoaXbJnkKhHT1HzgT8uZk5UPXw4o+Im78AtGGDJ
	 Px7Jc5A4uaG7Zl2iCzQufMeMhuuKYsWAP1d0euB7b/JNV9RqZZuNlh6Am5fnsNlE0H
	 6dvl/rAe2U8UwfTiXqWJTNuX8LF8+vvlw/NFKnSSfDTvbJfdMcq9z68iLxRmGC+L1f
	 P43xWh+eNdUF9nxofS6ZRejz4Y8JFHRjNW2Iy/gsX0PUKjbGjVPPuBKoKlkFXS1t4o
	 eKodc7Y7es0UkWalQR6lijVH75ldm014ztpzev4pBB2IoFeMBSfP9tgV9avVrVeE/i
	 ATHAmOyB72t1A==
Date: Wed, 5 Mar 2025 08:17:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305141554.GA18065@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_071805_148920_836EDA34 
X-CRM114-Status: GOOD (  11.34  )
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

On Wed, Mar 05, 2025 at 03:15:54PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 26, 2025 at 10:55:21AM +0100, Hannes Reinecke wrote:
> > Plus there are some NVMe devices out there which _despite_ being PCIe do 
> > report NMIC and CMIC set (I won't name names, if you came across them 
> > you'll know)
> 
> ?????
> 
> NMIC and CMIC is perfectly normal and expected for multiported PCIe.
> WTF are you talking about?

Obviously he's not talking about multiported PCIe. And he's right, the
behavior of a PCIe hot plug is very different and often undesirable when
it's under native multipath.


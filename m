Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3C3C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7PtaOamb1AjdIz0vMuXBsUhlvLLCuwwAy0GB4rlcphY=; b=B1jLz2nIn8g+8P6/DhbS7AW/CL
	3kmb4diwfsGg16AYLdam1HiqNmWlm6Q6RXatw1DKMltsiwcHPIZLVaMIVveZIwZVCH1R0Wiok/ozI
	ucLfL5QwLtVbGk3L7Bvwue1J7ar2wNl4HOBXjCg8HwthTav9AZKr5l+con/EjQ2Nf2rp/00khy27z
	siXWa/9DU+TRCBquVFISXcf0ygLLNMxgeFMXM6otAM4KI/ic5Ec+Mr/BpshmKIUwV2juJDcs8jexw
	XEvFLy32+MIQBO/vHn+vzgLRExeRPbcPvbS9ls7fypgoixcgu7sC/Z0RVzFLdDpXccBpSMHO8BMNA
	T0SSJC4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSZSo-00FKXP-H2; Fri, 11 Mar 2022 07:13:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSZSm-00FKWn-FF
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 07:13:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CFAAF68AFE; Fri, 11 Mar 2022 08:13:19 +0100 (CET)
Date: Fri, 11 Mar 2022 08:13:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 1/3] tcp: export symbol tcp_set_congestion_control
Message-ID: <20220311071319.GA18222@lst.de>
References: <20220311030113.73384-1-sunmingbao@tom.com>
 <20220311030113.73384-2-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311030113.73384-2-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_231324_676223_F342B65F 
X-CRM114-Status: UNSURE (   9.40  )
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

Maybe add a kerneldoc comment now that this is an exported API?

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA43C282EC
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spk93ko1cjzw+QDyPJZHsyzyVX1zJ2iIbTMDVo9d7PM=; b=V1a8FSn+4JCxH7dqi/7Rn0L7PN
	0WXMKgO9l+mMPpS4v4PxQkYQHNs6yhRnatwUhB9Y2V5Sb+6wKB1l3m4g4QJr6EI4vU+HpvKNqEs1T
	/xz/H8SPwgWdiZbIs20qliZZrP7Eq3QXqSfVyQ6xuj2X7AI+Pg+YdhHua4TLu+xtYmcg9kiHTinXk
	YPxfo+PeTm/O4oZuyK4ZI2KjT0ne8w9CeYaMthWbs9inHVlH/HCLVogBzyR5ClGPnlUFdNH19t1Ib
	/9oXjJRAQLDBOsmEjbrQkT1Aexgfk3rWzLXXaxP9/53ux1WqaE7f6Zyzfwt7GLmZxa+iXcsvD/CLo
	GMa3gmNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tppXZ-00000008J7j-0Agk;
	Wed, 05 Mar 2025 14:16:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppXV-00000008J5w-2j2c
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:16:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D80E868AFE; Wed,  5 Mar 2025 15:15:54 +0100 (CET)
Date: Wed, 5 Mar 2025 15:15:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, hch@lst.de,
	bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250305141554.GA18065@lst.de>
References: <20250204211158.43126-1-bgurney@redhat.com> <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com> <Z7Sh-3yHbXVmRbNL@kbusch-mbp> <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com> <Z7TARX-tFY3mnuU7@kbusch-mbp> <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_061601_823796_48FF2C96 
X-CRM114-Status: GOOD (  10.26  )
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

On Wed, Feb 26, 2025 at 10:55:21AM +0100, Hannes Reinecke wrote:
> Plus there are some NVMe devices out there which _despite_ being PCIe do 
> report NMIC and CMIC set (I won't name names, if you came across them 
> you'll know)

?????

NMIC and CMIC is perfectly normal and expected for multiported PCIe.
WTF are you talking about?



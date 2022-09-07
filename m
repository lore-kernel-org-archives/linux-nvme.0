Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FAEC38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=humRnr41wuk1Vzgb3nyJ7Y09eafvtmgBngSKi+lBSjA=; b=OilCF4Q8XXuvUQCn/cAZ6MHbPB
	bI1/4qowDAZBsM0Y/jfXjPKV+MlidfvD6hx2daj7ArJnEqt4PmVDhwWz/l0/crS5icKIrOkoCoJXC
	/fF5F+l7hRNOvdrsqlFskC1Xbq+NDH4ipDtrVrJbBtYyqZwLnx6qUyNh/0sUZTBJvZY2H2NgUnpPK
	ltga0J59GwhrzKk/ynGIoe7llDB09HlXKaFTjljpjc9BpvN6N1y5Yih0WD1zkbIluM/mpme2Pq5KB
	5Cp+DmCSnTs2aXC+4FTvjBWSsdKIobu7gpSPxx7g6EKZ6lZK+yWm+jCPjacyLefv6HD+m5VQ22v04
	VbuP3m+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVqs8-004ZIz-GB; Wed, 07 Sep 2022 08:57:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVqcc-004PSE-CT
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 08:41:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ADD267373; Wed,  7 Sep 2022 10:41:17 +0200 (CEST)
Date: Wed, 7 Sep 2022 10:41:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: delay error recovery after link drop
Message-ID: <20220907084117.GA29779@lst.de>
References: <20220714122703.67621-1-hare@suse.de> <86f1824d-72d4-72e3-0071-4a07aeb04b7b@redhat.com> <2a5f39bd-c545-1224-12af-ce16feab4b5a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5f39bd-c545-1224-12af-ce16feab4b5a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_014122_660698_EBF298AC 
X-CRM114-Status: GOOD (  14.53  )
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

On Wed, Sep 07, 2022 at 10:57:20AM +0300, Sagi Grimberg wrote:
>> I'm not sure the NVMe/TCP host stack obeys this rule.
>>
>> The problem is, when the host fails to follow this rule, some NVMe/TCP 
>> controllers are found to corrupt data during cable pull tests.
>
> The delay needs to come explicitly from the controller, not guessed
> blindly by the host.

No timeout can work properly.  What we need is a proper handshake.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BD5CCA47F
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SUTKE9eujSFvwsbNKpWKdU5TI8R/6s8+P3qtIra+oA4=; b=VnTb43Kwvr/pMYFlH9g+JyPm7i
	ZvRZuSmnry+U3KQStLIh/i1CStx34CXrzRehvQeNlGAWHwrmfAedmzSwZzpJyr1yz/LU5YxyKsztd
	4LLYFrrf2P7nCzQkGrL3/P5d6pi2covZ6MkFAvrDc1f1k3Gg91XpC6esHTRp8Div/0DILAJWRNpbc
	V/LfqkYXgnh1TGn4WhqA9dexQM1oppG/EINkBv7ANlgerUkaFtn7ma50+Vq6aUQQ+YVleoQYm+EV6
	Jhip+Oudz5ENKBJte22jwP5MIqThWPEcwOHIhqZS0C8lfWFj7ckmC2BYJfluKL3qeYJ0jnF4H0DUk
	g2pHtyig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o980X-00BOQQ-Me; Wed, 06 Jul 2022 16:36:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o980S-00BOOY-QV
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:36:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1827D68B05; Wed,  6 Jul 2022 18:36:02 +0200 (CEST)
Date: Wed, 6 Jul 2022 18:36:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-loop: use nvme core helpers to cancel all
 requests in a tagset
Message-ID: <20220706163601.GA2404@lst.de>
References: <20220626140600.81362-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626140600.81362-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_093605_055730_9D5EF798 
X-CRM114-Status: UNSURE (   9.17  )
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

Thanks, applied to nvme-5.20.


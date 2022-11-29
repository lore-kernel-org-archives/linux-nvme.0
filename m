Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16192C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDCaGNbhJBpYKaYvf32Z+3xmSoCEeB5oRomEJngpDq0=; b=zZp2cv/M/S8LFZwewk1OMF6IEn
	/Uk+YMYTMb33i7ZI4Xm3rSV26y29NQs+bH9m6a0eMSoxu6dMn+Lr93ine3t3n/RWpDxT8jwMw7Ujl
	hLo2AZqHprbxHZKtdv6sWUivad4USpYrNFfOqyHzDvHsv4o3K50Oz2u0Pnu43cRDt6tByfL/QACb4
	g9TFFcg3pL31VVkff6Ra/D2nOgDhyMnoODm7X28rMctUtpiC0/q8NbKwPGyi+LjowkelwdUlndIlK
	eGD8RNC5ePLqbGW2P4q0PwfQTxMUl0pugrSK218i/EMyuXLgHUMzgav7T/Poqa5bCWXOZIdvob+65
	4vczp+lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00r1-008tPf-W6; Tue, 29 Nov 2022 13:40:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00qt-008tMi-Ev
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 13:40:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A49156732D; Tue, 29 Nov 2022 14:40:42 +0100 (CET)
Date: Tue, 29 Nov 2022 14:40:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: sagi@grimberg.me, hare@suse.de, kbusch@kernel.org, hch@lst.de,
	axboe@fb.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Message-ID: <20221129134042.GB13668@lst.de>
References: <20221122044929.27600-1-zhangqilong3@huawei.com> <20221129084725.GB26082@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129084725.GB26082@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_054047_692960_0CBDDD29 
X-CRM114-Status: GOOD (  12.92  )
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

On Tue, Nov 29, 2022 at 09:47:25AM +0100, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.1.

And I had to fix it to actually pass all the correct paramters to
kmemdup, so it looks like this code wasn't even compile test.

Btw, how can nvme_ctrl_dhchap_secret_store work without any kind
of locking?


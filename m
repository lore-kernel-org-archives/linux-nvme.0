Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD7C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQqKOdZcDcqb9MiukqXl1L0UcJSDTweC975GnbYZFA8=; b=QxiTygFrtbAZ2tdvsSZpdKbK1Y
	cYHPFOfG4HZGPVs/zDYNXUpwBnJuxfDqiSMVWksWiY013Pb58an2UwPtwES1Pnb4z1QehfNp8kkYk
	EsONkm664j74ECu/z7KZvKunvlxAaXew2VVMXC6riD6W08gv2OS2/PonPyYv0UqQTFrTAN6QTNjNC
	6fYd57M0Zc/ZF8izGjdjTvjihif2YPlrHUKEMs++Nbq32dtj1B72TolumXQGriQUdaXEEg4ytc9YB
	Lmbmwhm+tNmKPOPyFiMndYmnC9ol9pxXEecbYlM1Opylic15LDHEARcu/zoEwN5CwvOBJxNUR8P/B
	ImG4sJXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNGE-00G3k6-Bc; Thu, 22 Sep 2022 14:33:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN9q-00G0T1-8f
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:26:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2331F68AFE; Thu, 22 Sep 2022 16:26:27 +0200 (CEST)
Date: Thu, 22 Sep 2022 16:26:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rita Lin <ritach_lin@phison.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?77+9U+aZn++/vXw=?= <redd_huang@phison.com>,
	Tina Hsu <tina_hsu@phison.com>,
	Vita Hsueh =?utf-8?B?KOiWm+S8iuWAqSk=?= <Vita.Hsueh@quantatw.com>,
	"Wang, Audrey" <audrey.wang@hp.com>
Subject: Re: nvme-pci: disable write zeros support on SSDs
Message-ID: <20220922142626.GB28397@lst.de>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com> <20220922053137.GA27191@lst.de> <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com> <20220922055231.GA27560@lst.de> <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_072630_495208_73D214FE 
X-CRM114-Status: UNSURE (   9.96  )
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

Can you give me a Signed-off-by: for this patch as well?

Also should this really use the phison.corp-partner.google.com or
phison.com for the Author identification?  (Same for the signoff).



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E785ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 05:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5GwJV8di+ecvS2KUizkEVBELea2MT17KwHH/7axWE34=; b=F537XjmzGmNgzO41h1HOmmfIFB
	0DniJy9kYWtkLNSiQ0ZpvqA+suCsiTD7Uu5a9wssNpMP9ePrOUAuX14+lRmIrf6R+Yce8w0W8q/Nz
	/0bWdVOQnaqgWuXv52BwTc5Cu797+v1lFo6Lo8h+eBx9KKLVeiIWJezQxNmyIDVM0529kPXD0r/vZ
	U6CGh2VhQhxxTyF8zSpy/wstAE0qfINiyP6n/HlLT4wQYFKgKjRSCBSQJYZe3UGVLh7hmebDEjgfV
	MuessFDDSGoQ6mJ7NxevhnMJeKzznXk7TQ9taYqBScA7F4QH6Ic9Xn9GTZMxXs7vJzqKCYuHLfG1/
	bBsN2VEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV51U-00BWyz-EJ; Mon, 05 Sep 2022 05:51:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV4zo-00BVEX-IG
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 05:50:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2ECB68AFE; Mon,  5 Sep 2022 07:49:58 +0200 (CEST)
Date: Mon, 5 Sep 2022 07:49:58 +0200
From: "hch@lst.de" <hch@lst.de>
To: Sungup Moon <sungup.moon@samsung.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers/nvme/host: Fix namespace duplication check
 rule
Message-ID: <20220905054958.GA1069@lst.de>
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p4> <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220904_225008_834501_D40183EA 
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

On Thu, Sep 01, 2022 at 09:49:41AM +0900, Sungup Moon wrote:
> Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
> sub-system because of the bit size of ID.

Huh?  Fixed value of a EUI64 is brokem, so we must warn and ignore
those.  The whole point of the EUI64/NGUID/UUID is that they are
uniqueu per namespace.


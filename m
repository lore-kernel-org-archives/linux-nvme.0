Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E035FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 05:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yiH0IpIhpNgXh0UkurwTblZ1CW+wOzVp9GgOKSRBQsQ=; b=xFhRihaEqtT65+Axr8dEfmhbDa
	ljSlj9wRfb2t+ZpLBRnsOOQUt7zSLHtSig8Zifb7DSNY3V9jLxuaCc5/etIC/mHaTL0S489htD7t/
	qUqb58uMDFSxfN1lVhLUMfPVsz9yph6SmzUetKKFgnnaP18IKfhDFOF8K3E+0CBX0AEAi1kNDToP8
	pjureinvz590tiNzfaV9ANAbqX2WDtebocyM7GR0abuExoYjl3iIXBauVwo24sYjdOAgQKjfQ3DWg
	0cvj/LoJ8R7rWJykG6beDYxL9sbQOsXE1yX8eiKpVfBRNG/hHkhxg+gdCBTKONzG5XQOj5mw1M2a2
	9vTpn+zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndmvx-006pli-Dx; Mon, 11 Apr 2022 05:49:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndmvu-006plG-9P
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 05:49:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 64E4368AFE; Mon, 11 Apr 2022 07:49:45 +0200 (CEST)
Date: Mon, 11 Apr 2022 07:49:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tao Jin <me@kingtous.cn>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220411054945.GA14311@lst.de>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_224950_516260_72527474 
X-CRM114-Status: UNSURE (   9.57  )
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

So I couldn't really come up with a good heuristic for checking for
a valid EUI64 that would work here given that in one of the cases
the only bit set is in the OUI.  We'll need to a blunt quirk to disable
identifiers for this controllers.  Can you send the output of "lscpi -v"
that contains the vendor and device id?


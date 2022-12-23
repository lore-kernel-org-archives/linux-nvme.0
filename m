Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A52C4167B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0PnnaFY8/ctg2nALelBG54J1iRiVUdHVC83f9Yqn8U=; b=ivg0bys116o+l83y/nwEYeIIbW
	YQHN/1JmssSOHTG7cIWSrCyZMt+HT8bUU08GxoNFUqBNsFf/tru7HpA/tmpXWA5r5/FlYs38AHwl7
	63G0e/Wo900klKj30C4eTlgd5b4VqzELL+0OzAgxgOUIAaB2Mq49xBUPg3Kqa81xMChRo3kkf21oN
	ylfHNkRkzbUrgbOUSWcBotmhnBuQ4IJBQlfWpyUNf4IKdzy8gxo1FCjSW06q2IFH/oVTlANNS+nMq
	Aw8lkRI7AmoUkFT7LuLOCcVA+q0ENyUF9ROCTcFo02pB+lBJarKzhlG14WdJKCxAnYGycOZLDbcTn
	STLKlfYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8iel-008eub-HX; Fri, 23 Dec 2022 14:04:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8iei-008eqz-61
	for linux-nvme@lists.infradead.org; Fri, 23 Dec 2022 14:04:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6732B68AA6; Fri, 23 Dec 2022 15:04:04 +0100 (CET)
Date: Fri, 23 Dec 2022 15:04:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without
 effects v3
Message-ID: <20221223140404.GB26826@lst.de>
References: <CGME20221221145321epcas5p4ff234021b074bf0a513d1cb233135656@epcas5p4.samsung.com> <20221221101050.759606-1-hch@lst.de> <20221222081904.GA4413@green> <20221223074545.GA5356@lst.de> <20221223132856.GB27984@green>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223132856.GB27984@green>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_060412_388416_51C61D11 
X-CRM114-Status: GOOD (  12.83  )
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

On Fri, Dec 23, 2022 at 06:58:56PM +0530, Kanchan Joshi wrote:
> On Fri, Dec 23, 2022 at 08:45:45AM +0100, Christoph Hellwig wrote:
>> Btw, any chance you could write some tests for blktests to verify
>> the unprivilged passthrough operations?
>
> Good point, will look into that.
>
> FWIW I tested v3 with fio/liburing test and few nvme-cli commands. 

I've done testing with nvme-cli and su, but it might be worth wiring
that up.


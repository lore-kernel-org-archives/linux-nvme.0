Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F45C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3c2uOwS1BfC9Ze/MYKbt6Gof8yxkh/p+eczm86Tec3M=; b=VYmWlGd4IsIqwGRQp79oQ3Okoz
	mBd/SIWhEf81cPpybIGXV42fD+5ikNmS2DU6mq95YiIRNZ5ygfS5MBEzxyOLejzEZDwyrMDiTg7QP
	Miz+hxWOTN7JoAff7vD3emdkKTb5VsNHQ17JkDWNYc5bnsosWQriRWiONFRlbXQszwFubavpLSM3w
	lfeD+6k3kh3f8VmrSZGNxCxnIl8Elm9VJyrEzCn/7CkKHDdHqRpN93o2Zz1m/EnGDnVybg5x1RIyy
	95M1m0mczhcdnm6rno4D57euEiT+fpmO9cLHfLXJ/0Di/g0AwL0lyvfTT4Ra8Z2ziPJVwYWMQHjgH
	n4+L5Qrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovKaP-005WLI-Ld; Wed, 16 Nov 2022 15:44:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovKaM-005VzH-US
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 15:44:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 584D868AA6; Wed, 16 Nov 2022 16:44:16 +0100 (CET)
Date: Wed, 16 Nov 2022 16:44:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221116154415.GA18491@lst.de>
References: <CGME20221116130636epcas5p39a586e15d27045752f18d022f4efd74a@epcas5p3.samsung.com> <20221116130104.2186334-1-hch@lst.de> <20221116132502.GA5094@test-zns> <20221116133839.GA9364@lst.de> <20221116134322.GB5094@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116134322.GB5094@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_074423_150982_B26F29E7 
X-CRM114-Status: GOOD (  12.57  )
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

On Wed, Nov 16, 2022 at 07:13:22PM +0530, Kanchan Joshi wrote:
> I see, good to know. I am still missing something.
> This series is on top of nvme-6.2, since nvme_cmd_allowed did not exist
> earlier.
> In that case having this series or not having - gives the same effect,
> no?

Yes, no change due to the series introducing nvme_cmd_allowed.
It is just a convenient place to put the checks.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95ACC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yk3C+J0kgmcg+O83jAG8ezNrEGj+ggul+Prar8oowvY=; b=yEIREhjTiXd8DcrVB1HAK+BepQ
	EheeDB4J4W+HlLIHN/Msv3OYspUqxGAJLCo70/uZ845UUVe3ufYkqlxPnUl0t4XDp7rqB5vj8TP1y
	0AieiPslWFw5lZ8Fm1dcsRaGGFhK/NSP7KkJPB0PEil6sd2PmYZoONfVNq8h6Kipj1BcDYMdqeBwR
	EWRiC6AzLbimnxsHKf7SVJ1JvtW+Ud8QMlvjQyRU1f013lUMW3AxaPe/Q/6ADojvxwiX7igs/zNj9
	UG6nMale5g7yH5uKwfYKaDYIqg7wAoCGl33zxsCmSsFh4cmD7md02eeQ6zUJ226TfVV72xt66YVRS
	ovI0dbpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSJeh-00D3Wu-V5; Thu, 10 Mar 2022 14:20:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSJef-00D3Vc-3Z
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 14:20:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5AC9868AFE; Thu, 10 Mar 2022 15:20:34 +0100 (CET)
Date: Thu, 10 Mar 2022 15:20:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310142034.GA1038@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
 <20220309061541.GB31316@lst.de> <20220309175203.00006ee2@tom.com>
 <20220310083811.GA26953@lst.de> <20220310190636.00001695@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310190636.00001695@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_062037_324822_B7759C37 
X-CRM114-Status: GOOD (  14.50  )
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

On Thu, Mar 10, 2022 at 07:06:36PM +0800, Mingbao Sun wrote:
> I feel it’s not proper to create a sysfs entry for each socket.
> And for those sockets that do not have the exception of
> congestion-control, it’s merely a waste of resources.
> 
> Also, since these sockets generate and die dynamically, the info
> exported via fs may even do not have the opportunity to be seen by
> the user.
> 
> Anyway, if you insist that the checking and warning here is not proper,
> I can remove it. 

Something that can happen during normal operation is per definition no
something that should be warned about.


Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60647C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:30:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D8521974
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e86s5Odx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D8521974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VZfIubGc5Fnahv1Nq8O346besFqbCtTIYX+dNznteoo=; b=e86s5OdxlOi7fz5Mcs3kAofeK
	n+8vAeNg+sf4wQlBbdfwxx9RooIfrbH+LRDCBdu14OWiOrb0ocE3HtesgqYJn0Kb2vpnrHVo60gmo
	x99wtURo37VEapYOnBoT2SDaK9AvkXxqgY2V9wyxDTh15eO/tlwGtu1DZRQTIhZserWwkICPeGXNh
	OMXTDKSPEOatU7wRrhk/Rc0HmIu2A23l93Aa4FjG8oVJG1HRVV4h69XrhNU5msD35zX3Fp1Ya9JUc
	odVJfVPbScrmfykM9va+ld2OLP0bTM+Y55TUOppjBcHq5TBsB3nB92FYFbb443L+8dNy7oagxbKUI
	+0cCf1rwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKxLt-000650-AN; Wed, 23 Sep 2020 05:30:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKxLq-00064Z-Uz
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 05:29:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4D2C167373; Wed, 23 Sep 2020 07:29:56 +0200 (CEST)
Date: Wed, 23 Sep 2020 07:29:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianxianting <tian.xianting@h3c.com>
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200923052956.GA15063@lst.de>
References: <20200922062517.30031-1-tian.xianting@h3c.com>
 <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
 <20200922145842.GB28420@lst.de> <5099986543624f9fbbeb26c2173934ba@h3c.com>
 <20200922154105.GA31758@lst.de> <53ae0341e62346f985ca289c6325078d@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53ae0341e62346f985ca289c6325078d@h3c.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_012959_124187_7F42602A 
X-CRM114-Status: GOOD (  10.37  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 22, 2020 at 03:47:40PM +0000, Tianxianting wrote:
> Finally, it applied:)
> Thanks again for all your kindly guides to me.

Thanks a lot for the patch!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

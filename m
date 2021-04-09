Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C64C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:42:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9157B61165
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9157B61165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wbNxaLB6Zo7CpPJEjmVsY5cfFP2PLw/JJsqrUHhCpLs=; b=ffoC1jVtPwY/csOpqH4m2qiYL
	Dvnukd/O/dHLMBs0XBl82gOQG5yrp/qh1pgd2P1OYBD8/bBVg2H4SAglq3zxDFZ205UkSlGEkLW8g
	1ctkScvbItmNTpbpxd1L8oVmX8NpGTp4ezYXkR2J/PG+6q7g+zkK79V8ekIUldIjL+u2yyYkulgpb
	suU4D+BlqCKZi+Ao/ULirKojyk73wB82VcAYDM2ixodG+OtDemgMIkFwHH5tfqB8AfFo17PZNZgTY
	mwIfrSP72tYSyst0Hxd5to/BtVGpB1kFjFZEZE5IfOoYEIYmx5EXKx5ZWgUA2mQe1Uv3s34eoDEqG
	keKCYj+SQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUju9-00AB00-UL; Fri, 09 Apr 2021 05:42:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUjry-00AAhX-7e
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 05:39:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF8CD68BEB; Fri,  9 Apr 2021 07:39:47 +0200 (CEST)
Date: Fri, 9 Apr 2021 07:39:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Message-ID: <20210409053947.GC2575@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-10-hch@lst.de>
 <BYAPR04MB496582CF89AFF355FC0738BC86739@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496582CF89AFF355FC0738BC86739@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_063953_629825_5BE6D092 
X-CRM114-Status: GOOD (  13.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 09, 2021 at 02:46:45AM +0000, Chaitanya Kulkarni wrote:
> On 4/8/21 05:35, Christoph Hellwig wrote:
> > Add a helper to avoid opencoding ns_head->ref manipulations.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Should we wait to have a second user for this ? unless it is there
> in next patches in this series.

It is really to be symmetric to the put case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

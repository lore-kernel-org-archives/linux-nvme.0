Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF04C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF8D2075E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MaGvkxus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF8D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xoDPWOzg99tn10C1HQMDq4wTmYaT9K4xETN5Oxa/Uz0=; b=MaGvkxus2XTm3aNFKuhKdRHzA
	C2INbploo4zMLotRk023SFO3T5CM7m31q5St+Fwq4bSFb7uZ1Zczn/hKs8puHcmFGGTJ0LznRXNF6
	7sGxgCqLmNDpo3cBfLDsrIOrIX94JfoACS/ZoXLB2Wqp56V4cP+dKo8yISWojQQLpOIwzzIK23lgi
	Roh6jopMTzEszt01etyECZqXTjaxqA4wkfS6EcrQc8ON1qgfJMjeVTXg5ELhVAt8PTvnOltWvgpLu
	xDkzxVDJ9orMRIQWJDWcTQm2lY2dqDtq0tz3mLM5HLgi91CS6CTk9OYfxq5pPb+j2zaTiBdQ2rH7f
	ICa45qacA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k87A8-0000rA-Eo; Tue, 18 Aug 2020 19:20:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k87A6-0000qK-9f
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 19:20:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 651CE68AFE; Tue, 18 Aug 2020 21:20:43 +0200 (CEST)
Date: Tue, 18 Aug 2020 21:20:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3] nvme: skip noiob for zoned devices
Message-ID: <20200818192043.GA30412@lst.de>
References: <20200818162941.2674340-1-kbusch@kernel.org>
 <20200818172504.GA28474@lst.de>
 <20200818175054.GB3097355@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818180205.GA29087@lst.de>
 <bbbaf51c-d4e0-ae45-a247-1e44666f866b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbbaf51c-d4e0-ae45-a247-1e44666f866b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_152046_459421_0A531D3A 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 12:10:22PM -0700, Sagi Grimberg wrote:
> I'll wait for a new version, reverting the existing patch
> from nvme-5.9-rc for now...

Let's just go back to v2, sorry for all the fuzz I caused.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

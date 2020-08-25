Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C7C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:16:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3FA20706
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yvgR+gm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3FA20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3jLv5rV+LfpUIClGs560ESL+Z6+OYONTr1dbaRvIDfc=; b=yvgR+gm+8lBMw4+DtYnD4HBLS
	a0MaZYshCIjWzTwjjUh1VBRIegQJWxoP5o4DZFJM0nsrxluFWGdV42jXayIP3148SvjtHRlZKVZmx
	/EpEND6K7fMpJQdtlLIdmRglXHm1biKBCrRrw0qxTM1eZPa9spTHpZS/Y9y3taSpc9YZvpSi8GkZX
	beCZsXFn3JU5hnKTlTxnc49iiCJCL1WqbmlCzel2UOmEBn2tNq+/SluRH5NkddH+02kmavgqEtubs
	cYvAwRn/CEz1NwOvF8MVFTUkQ93XF28ofeCNZ6ZOWTJ8of4fAfeWY8ne3rxEN6C+Sha4pZKPJHbOp
	H3v0512cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kATCF-0002us-W5; Tue, 25 Aug 2020 07:16:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kATCC-0002rQ-KE
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 07:16:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 21B5968BEB; Tue, 25 Aug 2020 09:16:39 +0200 (CEST)
Date: Tue, 25 Aug 2020 09:16:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 0/9] fix possible controller reset hangs in
 nvme-tcp/nvme-rdma
Message-ID: <20200825071638.GA29661@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <5490be43-8be1-3c98-de3c-40b5323c10ec@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5490be43-8be1-3c98-de3c-40b5323c10ec@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_031640_802232_826EDBC2 
X-CRM114-Status: GOOD (  12.13  )
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
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 24, 2020 at 11:29:49AM -0700, Sagi Grimberg wrote:
> Guys,
>
> Given that there is consensus on all patches beside patch 2/9,
> can we get all the rest in and specifically take this one as
> an incremental step?

Fine with me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

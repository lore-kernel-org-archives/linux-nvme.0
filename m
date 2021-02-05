Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C1C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 16:25:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECB464DB2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 16:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECB464DB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jAcSR/ya/zeEA7dirbtwBCAXFuSWzJHFFj2DtgBjaK8=; b=HM1rH9fcijwXyxZBaPdastkTQ
	Qjkmf5KZXuRAZ57yDFt4zdMJugBJyRyTYYVqN+bLU0htSNAPLQOzSMlOELw05hddoEUmDMiyf/Fbc
	OZzSiq/zMRNCqonhKz3k4un1dGlt7FwSYXLsKP5EcIxVK23Xi91c+KsLMUnJ19zITS4nuRMaEQJMZ
	rVJzZMdR8ifh/6Id6Hr5ZaHujDIN2v74tqxm9ifiB5iIYwVMmxK2DB6KQTAqEp7kQJGw6Cmx5VzG5
	V/MjPeyQMyBJnLo+B0Vex/Zzyp2rNtUq1pgpagBAsldeTCtbYl0jkkmpgtelw1/Xn9whlh+GCVpId
	oswmbuhGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l83v0-0005GP-BQ; Fri, 05 Feb 2021 16:25:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l83ux-0005Fu-8U
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 16:25:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 904B768AFE; Fri,  5 Feb 2021 17:25:06 +0100 (CET)
Date: Fri, 5 Feb 2021 17:25:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: move NVMF_OPT_CTRL_LOSS_TMO to generic list of
 allowed options
Message-ID: <20210205162506.GA27415@lst.de>
References: <20210205154714.127995-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210205154714.127995-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_112511_418473_B7B8FFD6 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 05, 2021 at 04:47:14PM +0100, Hannes Reinecke wrote:
> Every single fabrics driver with the exception of loop is setting
> NVMF_OPT_CTRL_LOSS_TMO, and recent nvme-cli has begun to set this
> in the default options when create a discovery controller.
> As it's not listed for loop connections to the loop controller will
> fail.
> So move it to the generic options to avoid this failure.

Well, the option doesn't really make sense for loop.  I think nvme-cli
needs to be fixed to not set in this case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED849C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:42:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531B920715
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="24zzIEHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531B920715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LG3TJ33SQ13dSBOraDHs4gLVZLd3Z/KW8/XvM5E91bs=; b=24zzIEHpIHTPIHrCvaRbq+8cz
	JFFWjFvFr3N+2FQTpqeW03gKXIkzSe19ulPCQU5NcIJbetumMzZz8RbKuGTgizUnGnzz/WlqhG50s
	yTfkdjDdFB9jfU66SK/EjUp312HLqLBZ7wTFExNeX3728LrNPEMVuujlvlwAiWt0LioCnlYikN/6t
	1zZGZLwLzSeOw3YU2s3uGkJvJvBh7kGWA9DixA+sHjjU1lRRF8lEAXvdOZAB8iUt2BmagRX2VodTQ
	XOHbFJvGm9EPVmqS+zY9Zxgat33BtsYZ/wnPFOFoW37iaU9fs7bVFzxNT+efgUUPgBBrU6WdhlXs+
	dEN9ASIYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIpUx-0001td-I1; Thu, 17 Sep 2020 08:42:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIpUv-0001t3-B1
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 08:42:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C150067357; Thu, 17 Sep 2020 10:42:31 +0200 (CEST)
Date: Thu, 17 Sep 2020 10:42:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 2/3] nvmet: get transport reference for passthru ctrl
Message-ID: <20200917084231.GB5921@lst.de>
References: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
 <20200917011102.14819-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917011102.14819-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_044233_499302_2EF73DBF 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: logang@deltatee.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 16, 2020 at 06:11:01PM -0700, Chaitanya Kulkarni wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Grab a reference to the transport driver to ensure it can't be unloaded
> while a passthrough controller is active.

Applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

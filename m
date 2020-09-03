Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3FC433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C003420775
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ny/ruBoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C003420775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eYJo9Nd3PHvQMzBr4DcLV/LO0t77Lhm8BGuUmVKaQhg=; b=Ny/ruBohjWxn9elVIhtNhNQHT
	C/SG3lC34JxfDNJVFt7Gsf58cvg07hjaz9vLJM8W6ilST8C/8HHq69GK3C71obG9Y4uWZ6/4ARNaf
	pIE67E91KU74kVjF9slCFG/pYXbWrEP3KwD2NqvDlCf3yhsdF6L1racVwgJk+kErvlchuwnb2c5YM
	8R0Yjco3v7X37MMvRPgC/a4wXXkpWaN/urKioJaZyWmCZYRR4IBGLyawBpbnLbPdl5s1pGZWLHmZX
	13WVjZWCClFFZmnDZH9uawhvc675CWZQ/NRrca4Lt/7/usPU0V5ESz1nl7HEsICwWjKQzlSHvcLhw
	Q5/y3nmVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDrzv-0006pt-LF; Thu, 03 Sep 2020 16:22:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDrzs-0006oS-Ng
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 16:22:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3117967357; Thu,  3 Sep 2020 18:21:59 +0200 (CEST)
Date: Thu, 3 Sep 2020 18:21:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
Message-ID: <20200903162158.GE25423@lst.de>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
 <7310435c-5341-d95b-55e7-605c0dc7130e@deltatee.com>
 <92a8029f-88e9-abbf-a30a-a339df3c6dff@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92a8029f-88e9-abbf-a30a-a339df3c6dff@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_122200_904202_8E0E2EAE 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, Logan Gunthorpe <logang@deltatee.com>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 10:18:23AM -0700, Sagi Grimberg wrote:
> Lets overall split bug fixes from any enhancement. Bug fixes
> should go directly before we handle enhancements.

Yes.  I'd really like to see a minimal bug fix series, and for
real cleanups and maybe then we can get to likely/unlikely
micro-optimizations.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

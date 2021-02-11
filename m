Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB32C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:24:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE24764E5F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE24764E5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6OPk2ZBFIeJHXvybljAwuLulUASO+3NwwtZHASBS2xs=; b=zku9FQYIF9ygJRV6XMWjMJdgm
	sO2q+R3j8LqBWbZu4K3IyZkJw1is06CqVikGOTGuy65MptSncK+37f2HN9Zc89QTJQqo0k5aCNamr
	bnIkbrPhqU5B+JNidyF34Jmwxt8oP/qmYlyn/kUd1mO6jJzPeOUHxKJQ8EirqyxmwYTKwRze1E3kY
	c7pEoe/i6fhtXozd/2Mr1Y5pNpkLt2/LiW0K4Ko8+lnchPuD9L7W9HxFZe+SLLhPdv/6un9yszJau
	9amzzxD9Cf9aXL8A2yP+cb5j8iq+rBU9Gh+MSt6EspI2y6rEJpxVC7xiYgmIXmCG1mj79nMC8eZ7e
	jk8iZhMxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGdF-00021o-6m; Thu, 11 Feb 2021 18:24:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGdD-00021V-CN
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:24:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CC05A6736F; Thu, 11 Feb 2021 19:23:57 +0100 (CET)
Date: Thu, 11 Feb 2021 19:23:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: nvme-5.12 is crashing with fabrics discover
Message-ID: <20210211182357.GA25973@lst.de>
References: <f4f56a23-c458-5a4c-457d-d9478aea854a@grimberg.me>
 <BYAPR04MB4965CD9C122653C1009F0500868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965CD9C122653C1009F0500868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_132359_538463_C85A9F0F 
X-CRM114-Status: UNSURE (   9.85  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 06:17:56PM +0000, Chaitanya Kulkarni wrote:
> I think fix for this is present in the linux-block/for-next tree, can
> you see if that fixes
> your problem ?

Sorry that I attributed it to Keith in my last mail, this was you.  Looks
like it only made it into Jens' for-5.12/block tree, but not
for-5.12/drivers on which nvme-5.12 is based.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

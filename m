Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:31:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E58A64EBA
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 16:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E58A64EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=byOTehNG1f956SaN9yu+iqK1iZKv20wECEr7xwIVPjU=; b=TYz7KDX0XndovbwdnQxbrrLbQ
	j+ZEy9k7YJeehAId/rCfep8SqjTMFv7/XU/ej0MORyYX2ROJUqlJOuOTdY5qNvKkCO504XQVTnH8i
	Y69DM0ty3Zk7Smiyrhm9Myb6XMQvLll8Oy4jYm0p2Mx8+eMjRRLtY+XUc4IUFgdiKIv+/aRWzo0vw
	iMNTluVE/c2Ne2WoFvmGVm+uA2V4nv4+okJH6dGlhrTL2cARDfvhf88RGBzTIQOXFiZgQ8QokqtaW
	n2ico1i4rG6ywazxZ8g7zNU1TMeDQfeyT8H9kN7CmuB77Otqq6oGbNVFfcg4VApJ0wSZTHDbL2YMB
	RZ3ztsY6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEx3q-0003jW-BO; Wed, 24 Feb 2021 16:30:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEx3n-0003ih-Dv
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 16:30:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 13EAB67357; Wed, 24 Feb 2021 17:30:45 +0100 (CET)
Date: Wed, 24 Feb 2021 17:30:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 2/6] nvmet: set status on actual error condition
Message-ID: <20210224163044.GA10673@lst.de>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
 <20210216213112.20078-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216213112.20078-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_113047_620767_9F78CCFF 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 16, 2021 at 01:31:08PM -0800, Chaitanya Kulkarni wrote:
> In the nvmet_alloc_ctrl() set the status variable to its error value
> NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR in the actual error
> condition just like the rest of the code.

This is a pretty normal pattern in the kernel, so I don't see much
of a point to change it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8ACC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:01:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB39164DE7
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB39164DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5w7PxXT1TevigyQNRhCQMoZRtwrzR2f2yePvW+H52lg=; b=om9jnfDSu7D6keKdtp5cwriYL
	ElKu3tnNmpkNCLKZka8jLFW796X8XKQFL6Br31cdENkvn/K1rU+fnUlOM73q3lI1D34i3YGIPsb0P
	Ru5sZGRjhfahLgaNuV304MzniMbQ+jMv8btC00SoYqTtfEyQTHwPEgauQ97cirWGiToQ62KzEkw4Y
	I9rZCgpYKLc2lmhQpTxnntVC1YFJC+e10nfCuHgzqkZlJFSID4PAHcrq7DYztmUrV2IVHFimHUSNx
	IsmxbOPM9w7H9fVu08it+sxyKUr+feAn3svZ+133XPLsR/NEBcccAa6xm3+hbbEHgciabyzcBe1Mr
	R2m5pFdyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqyS-0005in-Pv; Wed, 24 Feb 2021 10:00:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqyR-0005iO-26
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 10:00:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BFA8168D0A; Wed, 24 Feb 2021 11:00:47 +0100 (CET)
Date: Wed, 24 Feb 2021 11:00:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] nvmet: allow setting model_number once
Message-ID: <20210224100047.GA9017@lst.de>
References: <20210217181153.15343-1-mgurtovoy@nvidia.com>
 <20210224094347.GA5965@lst.de>
 <119dbae3-9dc8-a5d8-0f35-20d619931db6@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <119dbae3-9dc8-a5d8-0f35-20d619931db6@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_050051_251803_3B9096FB 
X-CRM114-Status: UNSURE (   7.99  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 kbusch@kernel.org, oren@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 24, 2021 at 11:59:22AM +0200, Max Gurtovoy wrote:
> you don't need the id argument here.
>
> Otherwise looks good and it can be squashed to my patch.

Can you resend it with the updates?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

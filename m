Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF3C47096
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:32:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89836611C9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89836611C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H7oBonI54N6clyFCzbEiKvnN057IFmkl/Xq57NdPxYM=; b=LZw6lTBQgIihXA
	Ht8d7CBBhYgYofGfLyOqPZoZCR00PItCt07QyuoGtE42aDoGm4YITa/BVn4BkSkUDgmtrs8z4eqxJ
	dRac6doQI+rYLFMPV+vXClIF7KJJYymWJn3fEKuuPm9yntdDdOZ7KgVlgwPTrXLYUgGVY35Qx7pPU
	jMVuySkNt5FHD2SeSvyQ+9oliIg4zsLo14cd0kNzBoZYc5SnF5y5bEAbqQsLFLHPZZGvkLlzLEB9y
	6ejIBh771qCkALWFlQZNJ3x/Z045gvDVc0D2v7F9mP7RO3ta6lSTkNBKFOp5X9SyGUUxNqHjBmKVK
	L2A+91Vn37bveLxEzk5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lohpx-007XEk-Ak; Thu, 03 Jun 2021 07:32:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lohpS-007WzO-Pj
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 07:31:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2F9186736F; Thu,  3 Jun 2021 09:31:44 +0200 (CEST)
Date: Thu, 3 Jun 2021 09:31:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-multipath: call del_gendisk() in
 nvme_mpath_check_last_path()
Message-ID: <20210603073143.GA4829@lst.de>
References: <20210531070914.102439-1-hare@suse.de>
 <20210603072244.GA4687@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603072244.GA4687@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_003147_013643_4A216B59 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

As I had to rebase nvme-5.14 anyway, I've dropped the original patch to
keep the nshead around.  Can you resend it including the fixup in a single
patch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

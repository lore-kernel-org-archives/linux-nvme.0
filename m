Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FE2C433E1
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 05:09:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1C42078A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 05:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KrKBSRsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1C42078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tQuGRaWmKmhKKWT2ss7h+NcB0TKFt7AHnY8qh81EAbw=; b=KrKBSRsA3k/r8ST3s2xIluUug
	vWQcT9+ZbE9x9ODUULQphjc1rsw4diCFyayoMkyEw49m1J4TZWuTTf4DBeCCX4+HLD2IW5P0FOJLd
	UbU0UPwHCms3tHe8eENoDdI/WC4zQCpN7k8uJTPpPXnthfT8fe/xOgIfee2R8r4aW4uOdXze6udyJ
	vAIdQ+BBdtC7Tv4iHqg9oKVNl16i8/B5F7oFEI0PXftZUTegQWpfM57afI5cAjUp9/Z+YG9t0LEAC
	Wh/66Tv6Pjro4yqEeq5LYz7GwF6njzr227M+E+F+OJcOKmIqNucRDgtBPtEtCYyFf3/sVRpLWdyQN
	5BYppgUCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jt2KT-0005Re-M6; Wed, 08 Jul 2020 05:09:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jt2KP-0005Qq-GC
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 05:09:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 00ABF68AFE; Wed,  8 Jul 2020 07:09:00 +0200 (CEST)
Date: Wed, 8 Jul 2020 07:09:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] nvme-pci: use standard block status symbolic names to
 check return value
Message-ID: <20200708050900.GA3831@lst.de>
References: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_010905_668505_B179582C 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 08, 2020 at 10:18:01AM +0800, Baolin Wang wrote:
> It's better to use the same symbol as the return to check return value,
> and will always work in the unlikely event that the defines are reordered.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I'm really not sure this is worth it.  When designing the blk_status_t
type keeping 0 as was a deliberate design decision. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

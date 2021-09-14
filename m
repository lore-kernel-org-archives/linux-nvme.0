Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C266C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:31:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDE16112D
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DDE16112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2w/nKMZQzvdo0Cn0+iwsYlwII7Pl3qxPRM/MB/P3SJ4=; b=0qwJnY6ItUkl6V
	/fdS3NTZvrCpv8c2uacdu3TOiD71I+6DQ2yNpsCKaoh+Hh4FoNgbvXvKwqn8CJChwnIIAVd5o7QDP
	ddxZ97LJLZNCFeNE9Bv0dTdAao2EBOTV/4upfvJCgFAumYf7VrI7Z+oWyQjVh9kLF5to+BZB00Fik
	MChowO3d+T/05CyJj5dz8hcjNRG5zjTYoewKQrY2HzSI2DwEo9kS1T4mtt39F92fItwmMiQWlaB+t
	PVjyEuPtZcD7YaSAgfORSOAKcrU5dUd55dRZhtVcVhITGQd7nzOkZ7yTENtWNeGYi9m7ifnTiFLKI
	u8RjxQVQwcAGDKRwBpBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ1y5-004HYP-TR; Tue, 14 Sep 2021 06:30:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ1y3-004HXA-F7
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:30:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6CA3567357; Tue, 14 Sep 2021 08:30:52 +0200 (CEST)
Date: Tue, 14 Sep 2021 08:30:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210914063052.GA27942@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_233055_678410_7EE9AB2F 
X-CRM114-Status: GOOD (  15.86  )
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

On Tue, Sep 14, 2021 at 09:24:30AM +0300, Sagi Grimberg wrote:
> I agree it should not happen with xarray as inserts preserve sorting,
> but that patch has the non-trivial removal of the namespaces_rwsem which
> synchronizes in a lot in a lot of error recovery flows. It's very
> possible that xarray will introduce regressions.

I've actually started looking over the series earlier today, and staring
it I'm pretty sure the namespaces_rwsem is completely broken.  There
is nothing preventing the namespaces from going away in these loops.

But I can't see why we don't just always do a sorted insertation into
the ->namespaces list.  Just trying to figure out the history of the
delayed sort ATM.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

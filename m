Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF16BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:33:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8088B610A6
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8088B610A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IpYLmw8wdrKoVQ/aWoP17tUYNSZrVwGV25VZh3LUb0k=; b=0p3uwlw7i5Zox2
	Bc//YFT8LmKLAf8NnKQoOL5tiRXEruZVaSraFmeKHchytALoky//EZVZfV422PSovQrQx0nobcrcx
	LXUcMrc7E+t5aJMRjz0fbN1J7QqtDLt9wwokt7E1vDbGa3M69Djklwhj6EmX2ka8o4lVVuYJS1vYK
	vlZQeDqqVo32l6LILzO2FpuL4/2Qysx7olSbscbK+GMd9AMlBAi6UW2e1OmLv1uG0SbIiI5Ngxx71
	TSRd1pDR6Inj+5sB9bvlE2Ted53EdJqzaifKPlVJCVNm7LSgWlMBIcQahLU9asTS6hHZdwKiI0C0D
	kTSXAF5UAS53n7HzXsiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2vs-004UVa-Mf; Tue, 14 Sep 2021 07:32:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2vp-004UUB-Nu
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:32:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0CE7968AFE; Tue, 14 Sep 2021 09:32:37 +0200 (CEST)
Date: Tue, 14 Sep 2021 09:32:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210914073236.GA458@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
 <20210914063052.GA27942@lst.de>
 <e65e9c83-33ed-df58-0eed-4ecf9cb4485f@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e65e9c83-33ed-df58-0eed-4ecf9cb4485f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_003241_971621_9540A44F 
X-CRM114-Status: GOOD (  19.14  )
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

On Tue, Sep 14, 2021 at 10:09:43AM +0300, Sagi Grimberg wrote:
>
>>> I agree it should not happen with xarray as inserts preserve sorting,
>>> but that patch has the non-trivial removal of the namespaces_rwsem which
>>> synchronizes in a lot in a lot of error recovery flows. It's very
>>> possible that xarray will introduce regressions.
>>
>> I've actually started looking over the series earlier today, and staring
>> it I'm pretty sure the namespaces_rwsem is completely broken.  There
>> is nothing preventing the namespaces from going away in these loops.
>
> Where? the ns itself? the ns is removed from ctrl->namespaces list under
> this rwsem (nvme_ns_remove).

Sorry, with the series I meant the xarray conversion that removes the
rwsem entirely.

>> But I can't see why we don't just always do a sorted insertation into
>> the ->namespaces list.  Just trying to figure out the history of the
>> delayed sort ATM.
>
> Don't know the history.

git-blame teels me it showed up with the initial ID ns list support
from Keith, so not all that much history here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

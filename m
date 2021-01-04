Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6B3C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 21:06:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AD0207B0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 21:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD0207B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O9pK/e/vg30VxpF0yZlqryhZhEszKQRJiBo9HUsv5hk=; b=nLuv84rtehO7UnG6Yq0L5CJ+p
	DPoRaFH6bOZ5QrnFwxiJpgeL4JATT6tjEayd7cLOLLI9DBaZztVN92Q7yIZ9CUCPV4dYD77ECj45h
	fMpkJNKKSSXCZmbUWqt/BgGbVUvjUBjYxtkdMsfDCAfY2BDcQsPabfPKvBYDOc62DxQv/q6mzCVL7
	bMiMe1g8TNQpOXROoihJmHBGsfKDgDK7Tt2FMV8MT8F5IvzrYAP83tXNIlwjgtZpfxZp9sIA6bS+w
	dRlkwwcty7U+6Ij9llMqk3f3r2/JoBKVZh0YxpJ7fxdMINexfRDLdsecgAGVzrfjoYDrE44J5VTQu
	/zzcoM3HA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwX3W-0001X9-1g; Mon, 04 Jan 2021 21:06:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwX3S-0001Wm-PB
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 21:06:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 44B2EAD1B;
 Mon,  4 Jan 2021 21:06:15 +0000 (UTC)
Date: Mon, 4 Jan 2021 18:06:10 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210104210610.hliiupywksawgei3@hyori>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_160618_939884_8905890C 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you all for the feedback. I'll re-evaluate my patch and resubmit
it soon.

The problem clearly exists as I can easily reproduce it on my test
setup, but the strategy to fix it needs some rework apparently.

@Daniel maybe try tweaking your tests to use a smaller controller
loss timeout (-l option)? I do this on my tests because the default
value kicks in about 30min after hot-removal -- i.e. you
have to actually wait for the timeout to expire to trigger the bug.


Cheers,

Enzo

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFCEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:24:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217A060187
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 217A060187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fDJX5HThRQBoK9XeONsFuAqUMv9kG7tdT0JMt8erTY0=; b=WZ0ylUX4LnlGOs
	nof+Rxe+V9O47Xg76Xaso356CKsa1+ZVMc7D/0t4OXsrxnGQClR/GeGvdTaxwL4ytq99D90Q5R447
	MYYOqpmXn6645BJGaHEB/zDySo0a+RfuYmB5fu56/7mEjjqF8Un0PW+0FUo8SUPGNCXC3KGDwG7nv
	Fwsgmx5eSqeBAnUFekearNG/Xbmuu/H9nBfvbtB3cyj2cDl+A5mj0uMiNtb0gFlRxML1+KGv+AzyR
	8j6XaHaO73jDsEupWhoVyYWSX9fald5PO+0ICu+MwliosJ9++wCzLwQP5FafX4NdNyvXtfFs/7LVK
	jxT3TvRJtvT4QVWMCRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPokd-002Mpc-S6; Mon, 13 Sep 2021 16:24:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPokb-002Moy-R9
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 16:24:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F366C60187;
 Mon, 13 Sep 2021 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631550249;
 bh=NxdsPAnGQ0eAp1Wtzj9pba72attkbVH2hsTPsK3a+1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Egyau8fuGi1PTV/ziqM7nuCgBDwILXGgbXkg1Uqgv91tS7/PjwB1uFAH8JAZJmlEK
 0tWudTyUzIeMQggVQcH+jHEfSWxMT2k6AUtS/hvjSh+IpHZL3qQFqlImyTm9LaOLXP
 FC8B1sSg9WMyh8gvhuoPOMZsx/LpSUYwie55nRY+9p2jeSAVTVyWv5q5msCvsGXehb
 UaLavYAwhFJjR8Mx0cw862ze78NNUnYBqTbdJqGnveYP/XF3kxVDTUAIYR8f6HFrNs
 cY5lqiszxQu0++4rDX7Gm+H3BMeZhuUzrxgJ/XfvUjt+ogMzJWZf0y2E0xPSH7xKs+
 IUVOvpAAiYHhg==
Date: Mon, 13 Sep 2021 09:24:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210913162407.GD3283786@dhcp-10-100-145-180.wdc.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160756.GB3283786@dhcp-10-100-145-180.wdc.com>
 <20210913161104.GA7634@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913161104.GA7634@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_092409_937016_EE014DE3 
X-CRM114-Status: GOOD (  14.58  )
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

On Mon, Sep 13, 2021 at 06:11:04PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 13, 2021 at 09:07:56AM -0700, Keith Busch wrote:
> > I guess this works for the structures we have in place, but I think we
> > should replace the sorted list and with xarray. Then you can get
> > something simpler to follow like:
> 
> I guess that's fine for the short term.  It mean we'll have to walk
> the list for every namespace in the decriptor, but I've not actually
> seen deployments with crazy numbers of namespaces yet.

Oh, my suggestion depends on using the xarray implementation since the
current nvme_find_get_ns() also depends on a sorted list. Lookup
time with an xarray doesn't change with the number of namespaces, so
even a controller with lots of them should be fine if someone wants to make
such a device.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D6C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:45:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34882063A
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vn3N7tvm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="IT6+PQy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34882063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xzk2S/j4zkd+hgtCCzoX7kKng1kxWqXjPmQP/OEcexw=; b=Vn3N7tvm8tgde+958pb0lkhE7
	y1Lpw/zrA6Hahsbn6iWJ1MAznExiyQEKPAOO90FAK60cOCE6E9QgzKAHCWzIJLAFDUUVwWbVtYdMn
	FPknjU2UjF2r9tsg/U7HIFOyfWx4Zr04uXx46LTPwVndqHpPK73JhDdc5ZYFfuRzO0cQZo3d2nx7g
	5WQpqYnF0UhGiipMGma0hdGct6iual0nwv38ETTTvIb7oiUNblaaxOmEIYTPS5iakLg2L5R2/BK0/
	emgftxIKRrDNhBzG/7+RjlzcJxFyw8nv5DOiPv5ncsxidmBmHb+Yhtp8aByHBmVHNeU6u/bHS7YV0
	nlFioKOsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8eKJ-0005fe-LP; Thu, 20 Aug 2020 06:45:31 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8eKH-0005f9-63
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:45:29 +0000
Received: by mail-ej1-x642.google.com with SMTP id a26so1266090ejc.2
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B2y41juScN4ZEMe70aXDJO6X28WGacc1jO+T2JLh1b0=;
 b=IT6+PQy6X4iz+w6Eh7CIYhS3hgDl484sGcro3drqzFgNAve9mQvrXDPT4j/INV1mWP
 GNQdYmVU8BqCQmj6s0p1d8/uTlSbX6e2uea2PEm7J3Tu7GiY8I3o2fbSFOPcRK6++7sY
 d4Rj3txdjLkVxkoMMw67PHhFtOslq8uZyK9SLWwAj0eUOa5wLZI/Ta8HoEzd0KKsBK3C
 zs6qS0xTNbyXhG8OASIlwWNKIfluhxcIK3KQmi2GZ7fq74HEo4vMCljrYlhyc0rCSl1C
 NwZf14AlOcXz37b37RbFiX4Yi4Gj+o+6Gv6q1cqpXpdiAaLAuicEhK8PJW98v+C799NB
 crOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B2y41juScN4ZEMe70aXDJO6X28WGacc1jO+T2JLh1b0=;
 b=PhqJwzabs5lfQLYl7jZIHCoCIo0XhG/pUKBORSDDqjoSRdhvTCj7vptQojcAuR/3Xk
 mZFuVcDUDbpz4dbw+ZQr9GUmRTJ2oB07oeXnVp2tLlPbhIBJHTYGjpseeiA9a3UAeIVK
 y0ZAgT6wEtkxVKE3bRkqKfwq9egmpByMh5CjF/QJjKlNdbYmpOICH+qNFhE32fLRUWkI
 ds+ur++nKqr1sZpg2uMWqOyUeK2N0FgB2MRyALjq9BhZKvPH/z/LDkbzU3R7z3OdqGPY
 pCOBUZtB2AkE9CPHZprwZVe3fxcHXAuOQRxzdlXTbGIZ2rwD7BN+IJaqr+z7K2VOc3QK
 NMwA==
X-Gm-Message-State: AOAM530+VJYGjBJBSSUy5P3POW1fysA9xPOxzErkGSZIKfrtNNEyvpMV
 LgvyVjwqXeIrqh1DIjVwoLTE5g==
X-Google-Smtp-Source: ABdhPJyZYHK1KxivsA8bWcGYFGuwT622rCb6PKrf13z3/NhYNHnl3A6e5rd45/cGeuH+6eeUcuBENw==
X-Received: by 2002:a17:906:868a:: with SMTP id
 g10mr1223275ejx.342.1597905927822; 
 Wed, 19 Aug 2020 23:45:27 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id kt27sm819772ejb.15.2020.08.19.23.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 23:45:26 -0700 (PDT)
Date: Thu, 20 Aug 2020 08:45:25 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820064525.lae7fnnaiz7rkqvd@MacBook-Pro.localdomain>
References: <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
 <20200819083353.rwblagiesocfcq7i@mpHalley.local>
 <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200819104349.GA2697@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200819104349.GA2697@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_024529_234664_7A4AFA60 
X-CRM114-Status: GOOD (  17.77  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19.08.2020 12:43, Christoph Hellwig wrote:
>On Wed, Aug 19, 2020 at 09:14:13AM +0000, Damien Le Moal wrote:
>> While defining a zone append command for SCSI/ZBC is possible (using sense data
>> for returning the written offset), there is no way to define zone append for
>> SATA/ZAC without entirely breaking the ATA command model. This is why we went
>> after an emulation implementation instead of trying to standardized native
>> commands. That implementation does not have any performance impact over regular
>> writes *and* zone write locking does not in general degrade HDD write
>> performance (only a few corner cases suffer from it). Comparing things equally,
>> the same could be said of NVMe drives that do not have zone append native
>> support: performance will be essentially the same using regular writes and
>> emulated zone append. But mq-deadline and zone write locking will significantly
>> lower performance for emulated zone append compared to a native zone append
>> support by the drive.
>
>And to summarize the most important point - Zone Append doesn't exist
>in ZAC/ABC.  For people that spent the last years trying to make zoned
>storage work, the lack of such a primite has been the major pain point.
>That's why I came up with the Zone Append design in response to a
>request for such an operation from another company that is now heavily
>involved in both Linux development and hosting Linux VMs.  For ZAC and
>ZBC the best we can do is to emulate the approach in the driver, but
>for NVMe we can do it.  ZNS until just before the release had Zone
>Append mandatory, and it did so for a very good reason.  While making
>it optional allows OEMs to request drives without it, I fundamentally
>think we should not support that in Linux and request vendors do
>implement writes to zones the right way.

Ok. We will just pursue Linux support for the ZNS following the append
model.

>
>And just as some OEMs can request certain TPs or optional features to
>be implemented, so can Linux.  Just to give an example from the zone
>world - Linux requires uniform and power of two zone sizes, which in
>ZAC and ZBC are not required.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

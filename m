Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B7C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:29:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AE420658
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N+AC+JDI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0e9Zniyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IbGpK+hDfNJ0SBkfO8CkzH4qZJ8K5Z/UFyvFJ2xlEVI=; b=N+AC+JDICbe/q/U7GtTIQgJew
	Pl6kzOqmamAsUNzEKJEzcwXVcV89pUCrsEPzpYj2BU97hCXN+eGQv+Ta5cdDVjteV/152Z7cAhhw+
	SKlZPAWwC9DEwmUgorG4OVQ8PFJFYqGve+hR8lO/e/7anHBdGwwXhoXqxPaZvmLP95yBIHknj6bPU
	5ImbGV5Tc4lihqPQnYnftix74CPDobyrP5oUnZiVYXeuEfm3HsIdDWoJW8Dcz8rzsQDBX37oUzJ5d
	mIsuEzvZsLmXpXrl20RVDiyVdrBlh+VpWxPKWghcGJFZztRcQPUyBFyR9R9yCxjqYZleDs3QxpNjC
	KDl00oDqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85QC-0008Sp-Hv; Tue, 18 Aug 2020 17:29:16 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85QA-0008S9-Jk
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 17:29:15 +0000
Received: by mail-ed1-x541.google.com with SMTP id i6so15887613edy.5
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3/0UrSCWdiUFQjlCmwTT+sDLdgmMCbkkvjiVvm/Zb4Q=;
 b=0e9ZniydNVaI5+0HNp4JTj3vU9pqBMNjVOiGh3ElOE5Ouu6Ediz5A/BEtJaR8Yvadb
 C4WYUsAkrOXygNOwvi5dDs9VkD0FWK2suynMdogo87lgbhuPrF/lx8iymwJ/dkP0ZdPT
 bYrooWf1aJmO6wNkqGTI0tLWXJhyg/lh2lp3I39BrVspTnnihjy0E3Fi1rSF9F2smTSP
 tQcLx+EAsEWbVzaOiMsflFvTE74JcTRj6UETYLxS4QhgIf8dlDRdAd4Du4bokDZJuvDv
 naDhBGIim5OWIpqv/ztnr7J/BT2RHKRabHTRXBw076UJhXZoS0Uf3BPhWuX4h7oQg84x
 NvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3/0UrSCWdiUFQjlCmwTT+sDLdgmMCbkkvjiVvm/Zb4Q=;
 b=LVUJbP7aYdi+B3QpqVdJR+F+4f7u8KGealERFjifmycs5yZuoghfkcvoT6KsdhHWml
 d84Vu8AVXyOtPwIV8qUVnVfKcN+IjxWvDfXgxrOjH5OTGnf0zjIuY2kQX+GgIgedn3YB
 cy9fwcw+e99Mjt+gzlg4vtAq44I/PRLKeq3l1O7kECY/F1SUT6ucTSiH+6GI5TRCXfLU
 cPy03essE2fjHFPREdaFOx8cjZUdBFwUXO0A4ipcC66EjlK2WV3hfXzBZUlTwtUtrmWg
 RbCGi4lDWzsmEsFhi3wmr6apbWHHqoKcpPbr0Oknm1yPC1cxgu6qcfQTWKjEhL9T4ZZD
 tsIQ==
X-Gm-Message-State: AOAM531w3Rjuob1AGz5kmIiYN+I6nzDE8iptXcbmlV3MjXzw48IceQyX
 Io/GIxwiAPe3rC5fOOKJtJ/Iyw==
X-Google-Smtp-Source: ABdhPJzlBOCe1lDdHrtT3awmcFNNz4BOC3NXuiv9YMW6pUkc5e3zSKPkQFenrYEnw9XSdDgkG1B4Vg==
X-Received: by 2002:aa7:db10:: with SMTP id t16mr20427706eds.196.1597771753518; 
 Tue, 18 Aug 2020 10:29:13 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id l23sm16763331eje.46.2020.08.18.10.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 10:29:12 -0700 (PDT)
Date: Tue, 18 Aug 2020 19:29:12 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_132914_680933_548A21CC 
X-CRM114-Status: GOOD (  11.16  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18.08.2020 09:58, Keith Busch wrote:
>On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
>> a number of customers are requiring the use of normal writes, which we
>> want to support.
>
>A device that supports append is completely usable for those customers,
>too. There's no need to create divergence in this driver.

Not really. You know as well as I do that some features are disabled for
a particular SSD model on customer requirements. Generic models
implementing append can submit both I/Os, but those that remove append
are left out.

I would like to understand how we can enable these NVMe-compatible
models in Linux. If it is a performance concern, we will address it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

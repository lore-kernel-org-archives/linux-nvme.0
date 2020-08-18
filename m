Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B24C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:13:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9684206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WXfZ/z88";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QjKJC3iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9684206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ecf9Cm7R0/Dirf2EJGgtI+wCYU05Cx3j2QK9WAdQQdA=; b=WXfZ/z88yesFiY1vQDjRiiTBF
	RK67kFciD1/ruU0OBRUAsSfDdImAvdXM8ri6GO2RsdZyk20YL3ZitYmqeveIJmQIjx0Ii/1KCNtO+
	+eP3rqFMmKdhIac+bzvlDoyjgtVfNq8lgMBNR2+XYq3+FOpugjljTHntpBWZ0rg3pEQ1zWCibdg+o
	zZOl9slns/I1Zi7qoCDll8SToPTRD+tLZWvuFVZ6/KmeLmiwExm0g5z9toIZ6pyw+BMwI0Piwc8MC
	61n7lvXxZIiUG9kIKiZtGbHpgSXPhM8Ronv1u2Ra1kkGqFb/F0adL4uw4TYJBYBW6r4djq2zmCmWv
	+1ZrzvxNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k866k-0007jh-2E; Tue, 18 Aug 2020 18:13:14 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k866i-0007iy-2R
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 18:13:12 +0000
Received: by mail-ej1-x641.google.com with SMTP id qc22so23204411ejb.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RQfII6OqeocrTsbvngYvMEa5UN4ejkr0mhyGFMVV2I8=;
 b=QjKJC3iySsR8dz9ujNbGV5R10NnYiIbC/ryuhLdDQ9lgembtRbnqd4a0rdupEFVNlO
 yRwVn/5c82oryEoP9IEFcAg2+OObKL4tpoCfLlbSvPsQSi9V3W+gYd3n22c7aeTWqUZE
 tRn061KbpJ0SCBNooN8wut1QHG5cL3tbUe6Pt3QP+VqoScwBCLld3dsgWBuvXcRk/Zno
 8ajUIavPu7lx0uCaekPWbGEFzIjUPZGNBK0W/azNUVe4a0RwbjdN/SaDRP8Lb5srL6yI
 cpeIjqzOwz4vsjTC677/uzbksSNx4G56hZao9qJC5bQWU6CwMNYCo1w37BAfITjdzW/1
 Sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RQfII6OqeocrTsbvngYvMEa5UN4ejkr0mhyGFMVV2I8=;
 b=L6lWKH99REWJmy9Yl40pcQmJU41nE4ERw/g8wD4jonUJMWRufn3ohyc0AmeY80nfBV
 oFoOldtU0lw5sDZbIK5/Us3z8E75JN9yMtto5mJNZhKehA0imw58XgAgqe6zNdXYwJG+
 7LYJeGS0AlTAL7ZoUGobcveXIEWzvaLsatc9TYLrsM+npebXlf1hMWHSann+RH/yHX9a
 n0nVDTVQfLI97daWmkzdWSkSjHaLz27gWIJjCies8sbvTLW5JGnC6Owx0C7IOZucMtti
 4s9gOPTHNkGJH7cnPD0sCeBcYeLrkJpsOVATISDw/HL6lNTu7XoRNQbaEpatzsBDhElt
 KTvA==
X-Gm-Message-State: AOAM532yHyrD4+oPsLcvvuupZtJmlGukddffSZnyKk3Pu1z0jn5CZtu+
 KlrU1t0rW/FbYOwl4CQEyCa0pWy2Myfz9q7H
X-Google-Smtp-Source: ABdhPJyYTxGFLxcDuRDg/n92S6zWZuddbv3ZZNTVHZ8bxifAUCxXKO7s2DdTeLc9TBdj2q5NzpZHLg==
X-Received: by 2002:a17:906:bccf:: with SMTP id
 lw15mr22472412ejb.415.1597774390879; 
 Tue, 18 Aug 2020 11:13:10 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id w18sm16870282ejf.37.2020.08.18.11.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 11:13:10 -0700 (PDT)
Date: Tue, 18 Aug 2020 20:13:08 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818181308.7g3xom4lxwuoogev@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
 <20200818173936.GA3097355@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818173936.GA3097355@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_141312_135736_742D11D5 
X-CRM114-Status: GOOD (  14.36  )
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

On 18.08.2020 10:39, Keith Busch wrote:
>On Tue, Aug 18, 2020 at 07:29:12PM +0200, Javier Gonzalez wrote:
>> On 18.08.2020 09:58, Keith Busch wrote:
>> > On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
>> > > a number of customers are requiring the use of normal writes, which we
>> > > want to support.
>> >
>> > A device that supports append is completely usable for those customers,
>> > too. There's no need to create divergence in this driver.
>>
>> Not really. You know as well as I do that some features are disabled for
>> a particular SSD model on customer requirements. Generic models
>> implementing append can submit both I/Os, but those that remove append
>> are left out.
>
>You are only supporting my point: if your device supports append, you
>get to work in every ZNS use case, otherwise you only get to work in a
>subset.

There are several devices. Some of them enable append and some do not. I
would like to support the later too.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

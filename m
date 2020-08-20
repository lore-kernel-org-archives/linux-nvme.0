Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F01C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:37:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F67120786
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C05CNtAb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="1oTpqa9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F67120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uc/JUINf2ib3yWmUZSQFzhk7udmAUS3D2yc8fIsEmyg=; b=C05CNtAbDgQET5tZE0rqu3uSM
	l/6hkbJg7wkk1uXeREzDkmidOGZLkPtIzdlXme3lNjt+yZgwSKfgCKn3YS/9sAz2b22aqQHLWX4bs
	tpg3NVwiWbH6mDjH6lQNYlNDtrObjwxzmjWr8p5ugrOr4vTJj0c8QBgVrHL8OcqrZrEGuUVr4rCVg
	a3rEMfQ22sWNqF2x3sxGaaVU/o1Y5qUVOtH6xqG260MydWfKDr4G7R2y+gqfhgLQrSc7Zj7tiS/6X
	J3AQQaVEa4tO7FhXGwZ2pcfcHzZVOo23MPiyzD1FCxHIdekvZl0u9F5NUTwAhNhB05IHw7lhe/JU3
	gggyiXtqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8eCS-0004t2-4R; Thu, 20 Aug 2020 06:37:24 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8eCQ-0004sj-Dn
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:37:23 +0000
Received: by mail-ed1-x544.google.com with SMTP id ba10so736479edb.3
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sLKrzH9MwPqGsgXwtk2KOdG5Y1PUaWmaOENzy3RDTWI=;
 b=1oTpqa9mewNECohmMsYj+eRveSfefrahN/JWuEtdN5qZYeRSPgiHk+r5DSeOlqKXJ2
 xHZTqWPH4bMVTL9qtKpvEdwNg9cNFu8ni1UIgCkF0UdcIgEA9Y/JZa+241+kJALWMWdd
 A3ilCshO5/+M08eJSNj3KoovGweA4lFzvl8yWhS7WmXTWdD/q7KhlYVAtm2N6SwLPyrp
 fhcLdYR2jYUoYZaUjtpUVir7zG58kru94mQ8sxSoGPDhnF4a60y1PGoAPiaDD6e6BzR+
 EWrsad8bF6eimra08ezmAAp4jY5onVm5vyIIQq6jFMv0IiIE9KjkYcn4ML9mcknToqFn
 l1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sLKrzH9MwPqGsgXwtk2KOdG5Y1PUaWmaOENzy3RDTWI=;
 b=dVs/pb+UlEMNImTqxp1ZpEUJi3ex1v6DAGJRaLvYT8O9vh8dUQJ99+hR8JkogOUArz
 bRIiITzOfPDDGCyIRtIFDP0x3o9ZQbzMNpuNJpk6sm37sdw2rZyuLnP2x0o2oz3lfapL
 imh79a4MaWPVhD+EC1EExVtX9CxGAnhBQPGihqCmQd5VwjmiwWjUicp3MfSfbBfIm2iR
 PpV5v4ipYg7Seeib2LHoNFnKbEwmZajuQyItmKrUE7yTK26jQOQraVmtNX8Q1GmlxhDK
 jQ9X+6Gx9QtbhVWzMFpuFK+YtADgJbOWXPY3l9vJ9jMFGl6S1uyi4iRcZsf30SwlMYYm
 dXGg==
X-Gm-Message-State: AOAM530w6LPxx3lBl5S6GRh/rJqqkInZXDEkTKFXMQLn/8p8Y8c4fNiv
 HsIEGzNwlpAdrJgqy+wp2KHczQ==
X-Google-Smtp-Source: ABdhPJw1f+/LS3aQnQufiPMLSgWv3ikzJM2mUKgAo9msFfUJoqiNImvZgYem58Wk3tvok8hu+xBWaw==
X-Received: by 2002:aa7:d607:: with SMTP id c7mr1500254edr.184.1597905440828; 
 Wed, 19 Aug 2020 23:37:20 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id g9sm712181edk.97.2020.08.19.23.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 23:37:20 -0700 (PDT)
From: Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date: Thu, 20 Aug 2020 08:37:19 +0200
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_023722_646224_132497BD 
X-CRM114-Status: GOOD (  18.01  )
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
Cc: "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, david.fugate@linux.intel.com,
 "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19.08.2020 13:25, Jens Axboe wrote:
>On 8/19/20 12:11 PM, David Fugate wrote:
>> On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
>>> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>>>> If drive does not support zone-append natively, enable emulation
>>>> using
>>>> regular write.
>>>> Make emulated zone-append cmd write-lock the zone, preventing
>>>> concurrent append/write on the same zone.
>>>
>>> I really don't think we should add this.  ZNS and the Linux support
>>> were all designed with Zone Append in mind, and then your company did
>>> the nastiest possible move violating the normal NVMe procedures to
>>> make
>>> it optional.  But that doesn't change the fact the Linux should keep
>>> requiring it, especially with the amount of code added here and how
>>> it
>>> hooks in the fast path.
>>
>> Intel does not support making *optional* NVMe spec features *required*
>> by the NVMe driver.
>
>It's not required, the driver will function quite fine without it. If you
>want to use ZNS it's required. The Linux driver thankfully doesn't need
>any vendor to sign off on what it can or cannot do, or what features
>are acceptable.
>
>> It's forgivable WDC's accepted contribution didn't work with other
>> vendors' devices choosing not to implement the optional Zone Append,
>> but it's not OK to reject contributions remedying this.  Provided
>> there's no glaring technical issues, Samsung's contribution should be
>> accepted to maintain both spec compliance as well as vendor neutrality.
>
>It's *always* ok to reject contributions, if those contributions cause
>maintainability issues, unacceptable slowdowns, or whatever other issue
>that the maintainers of said driver don't want to deal with. Any
>contribution should be judged on merit, not based on political decisions
>or opinions. Obviously this thread reeks of it.
>

I'll reply here, where the discussion diverges from this particular
patch.

We will stop pushing for this emulation. We have a couple of SSDs where
we disabled Append, we implemented support for them, and we wanted to
push the changes upstream. That's it. This is no politics not a
conspiracy against the current ZNS spec. We spent a lot of time working
on this spec and are actually doing a fair amount of work to support
Append other places in the stack. In any case, the fuzz stops here.

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

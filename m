Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C04DC433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:04:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1059120786
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2mJBFqcA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="VGG8e8rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1059120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rAmjegMI8I+pAy8ibnqqEidmxbF1Avr4dJtQMOaZBQg=; b=2mJBFqcABXd/aaKE84Hj2Y/Dp
	eNDK6nc7FFAUFM/qeyPoCLdHv+dK9VZmPbJ9MrMRsuX51vJKRL/69x2ckgeeZVoWl9GL9+rVDgp8x
	ZqrQvfLApr9xzLYqubqRvBJTlS77PvYdk2iysBT/7LPgOl4hy/GD3vwU3+tu1DrPEzrVIORTORrP/
	CkX9cDitYtOqMVXndka/JObw6piIDjefLPQ5a4hV20dd3T2lWVQNy3wvOFx34gEMEApgLDhok6j1q
	S/oVuGefhxOsUO1YJ446tLVk0Unze29RQDUwvAkRe/hO2fdRFInl4Phf97oWJI6abAUVKLexaWk8p
	QgJ92QbvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85yM-0006wE-Ec; Tue, 18 Aug 2020 18:04:34 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85yJ-0006vU-IZ
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 18:04:32 +0000
Received: by mail-ej1-x641.google.com with SMTP id qc22so23172903ejb.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9QKHAAhm+KHbU8GvfwEcJcQk8+bGHLCS9A3L1Qovm7A=;
 b=VGG8e8rBUgq+wusx/5EpYei3LvUG/TzyKXGTkFmQlZox64SQJpa8yzW6cABSCc8tl9
 Xj10mwbxIwfc7qhjaZEjJv80G9y72NzVloYSjUtIBWsCZhfZLnVYyqjAL8/L0/ATptea
 IsGtx7Kuu5bfYicNTN5Zqm5mB9fJS1lE0L66KvlTsp+kGshLB92uyJCVAYm1ybPSui1G
 GinoO7B/egjpxEKzsYG7w6f/HY62ksQdhNtJr4lcIrQKRJdte+9EfyKY2yIbZPvVG2Tm
 hdFCB3bZd0MBnuvtkEWS6rRx+WRSFZ/UX6BiJJu0EL//1et+Rwz1T6upGLLOsclBlq2M
 Ixaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9QKHAAhm+KHbU8GvfwEcJcQk8+bGHLCS9A3L1Qovm7A=;
 b=YAgoU/qiBD03NrMsL41OFXsYbNRjH9Wz8eCppmPx8cy5TTa/6FT9efQqP9fLZrfYQS
 2YHQcfGnWBajAuiyDl5uJ5N6t/AZepzEhz2yL5SSDTkltihsQ3c43MaL0T+9WutravYi
 2nNgvwLZ40pZ7z4l8/jN3Vxoz3TGHovmMxQdFYqk5OA/BhJ26cKe30rlqAxzgif0jVL9
 z2HMjPStQGKuZ1BmKduMjZBP6v8mj0o+T04+LsR5mnhYYq4cOBvsegjT2VqWQ5jbJLY6
 NVUB+Hw0kBW04TdamTqVcKxFvoa46uyyQRGPtfClRGdDZszG0JYxoSLVrjU0qcVMJ+tm
 kcsA==
X-Gm-Message-State: AOAM531NKhnNm0y3OPEbY637G5y9SU9fmEtE47LWYJdQK+Dr8NI2RO8M
 jO9JuzM1VkLeGdVMR7y5zp++Dg==
X-Google-Smtp-Source: ABdhPJwO6PKA3P3xfj7/VKQ3x1v6vyAybcvAhV4ThQFQ5n+UhteH3ABWbvLTiFrMZIsbOxdBmTd0LA==
X-Received: by 2002:a17:906:b082:: with SMTP id
 x2mr22293779ejy.349.1597773870344; 
 Tue, 18 Aug 2020 11:04:30 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id pj19sm16819555ejb.66.2020.08.18.11.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 11:04:29 -0700 (PDT)
Date: Tue, 18 Aug 2020 20:04:28 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818155004.GA26688@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_140431_767678_29D754E1 
X-CRM114-Status: GOOD (  18.38  )
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
 kbusch@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18.08.2020 17:50, Christoph Hellwig wrote:
>On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
>> I understand that the NVMe process was agitated and that the current ZNS
>> implementation in Linux relies in append support from the device
>> perspective. However, the current TP does allow for not implementing
>> append, and a number of customers are requiring the use of normal
>> writes, which we want to support.
>
>The NVMe TPs allow for lots of things, but that doesn't mean we have
>to support it.

Agree. As I replied to Keith, I am just interested in enabling the ZNS
models that come with append disabled.

>
>> Do you have any early suggestion on how you this patch should look like
>> to be upstreamable?
>
>My position is that at this point in time we should not consider it.
>Zone Append is the major feature in ZNS that solves the issue in ZAC/ZBC.
>I want to see broad industry support for it instead of having to add more
>code just for zone append emulation than actual current ZNS support.  If
>in a few years the market place has decided and has lots of drives
>available in the consuer market or OEM channels we'll have to reconsider
>and potentially merge Zone Append emulation.  But my deep hope is that
>this does not happen, as it sets us back 10 years in the standards of
>zoned storage support again.

I understand that you want vendor alignment in the NVMe driver and I
agree. We are not pushing for a non-append model - you can see that we
are investing effort in implementing the append path in thee block layer
and io_uring and we will continue doing so as patches get merged.

This said, we do have some OEM models that do not implement append and I
would like them to be supported in Linux. As you know, new TPs are being
standardized now and the append emulation is the based for adding
support for this. I do not believe it is unreasonable to find a way to
add support for this SSDs.

If you completely close the door this approach, the alternative is
carrying off-tree patches to the several OEMs that use these devices.
This is not good for the zoned ecosystem nor for the future of Zone
Append.

Are you open to us doing some characterization and if the impact
to the fast path is not significant, moving ahead to a Zone Append
emulation like in SCSI? I will promise that we will remove this path if
requests for these devices terminate.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

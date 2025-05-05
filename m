Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD384C3ABBF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZtudP8whc5JWyiBQCvGvrdC2CkTXwDmcdreRv5eyPQ=; b=HUemM2sbIfQGNnOxQdWRRgRYq5
	bJMfgjFmlI3Qg+eawkMDWg5qbtO/nlZ8uDmoMgp7sfqZfspAI6BGHZob4tw7h0oqU6e3wo19xb8+4
	lqy2A1cQJcSPCmq6lPrmmYDx6IYsiLx2fNnLfssJa3H0a0n0QK+717UrUOvrxKYonwZioLfwCuTcd
	LP4S+HiB3TcnpJ03VWNw8iCtbNhdYfHX4cei/VflfrAvZUVSqucTmwUhHdAt6HR1DTVAh0pLDO4ac
	LWGZYH2pMPACh/VT9mR8onFhFhIhv/2/aU4SEQyixloem+fN1oJ8NhsxiMRLQcoPiTtT+Evaqnqs1
	hP0UJcIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC7xM-00000009jDi-1EDa;
	Tue, 06 May 2025 02:22:52 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4jS-00000008uVe-0ght
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 22:56:19 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4552369b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 15:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746485777; x=1747090577; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZtudP8whc5JWyiBQCvGvrdC2CkTXwDmcdreRv5eyPQ=;
        b=gacvIqOxkLYnJin0H34mb0wnDMEQQYHPUtCLqmH7DvQ+5jLmGp9o/hLGRJcOLPkSKS
         yOrsyuqES6gDVquX0VOOIOR7vzG4hca5hofBnkF4BCYN9p4cmBn3ylkuxPwm8pE+VhLh
         oS3H+cmbpxuKNyoXiM0TakKgv//PDWQWDXMvebcoQO25SV0ndwZtIMKPpOGYDUiFV0Ia
         KeXCGQnk7F5pbuXS80rD1j55SXoduhnW6/2ohL8vj/sA2p8fFcmD5d0vlbXQsC0poZGo
         uRb6E07GfzlgudxB0CUxz5r7dAmYQTo4FJiAqY0yLAxcWWq1kRSDmeMSDidA7fbYWYkP
         94dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485777; x=1747090577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZtudP8whc5JWyiBQCvGvrdC2CkTXwDmcdreRv5eyPQ=;
        b=Hbrepm3eXnCY1teKHOxJNSl39QLpLcXRCuw45C1ehPMVMvIM/Tq4idS3i3TSxm//TY
         SP03ZinNtJVut5fNq5qjSMMG8pzit3/SsVwf05t472t5ePTe43uQphFa4/12mN8Bi7nm
         h/A8RwkxtB2j5bWJt5awrXmGUlxTfifr8HWkp/iQQ5LlVs0m+KIbJt+X0pSdVj17+wuP
         zitqYc0euarDi47ReW1qsyDNtUNzcPoICcmwEqGvdFSip1fX0Rt0h9kcloDayGyFq3mp
         amZrAwQy0m5qX5YgWguPHrX9G0HWkB7nDEbq9/GZNkA7dRQooPJlwU36ggcpcdjuMtB9
         uNHw==
X-Forwarded-Encrypted: i=1; AJvYcCW49ImnBDVQufoU/RQrEq05okxBWei/5UOa2Lj0gJrZuC01CPOIiVHpVSgAKXP7rAme85GO41ow3UeG@lists.infradead.org
X-Gm-Message-State: AOJu0YxE1H1N7t+Pxypk+l03WHHzkiv4PJkEIqJVnae20sOaVjmGGvDb
	ZJKcQ+tf/blhMXDnoHRVQ4UhO/GTAHH3qXTRSbjKCV0ZmJw898cpCeRClGFJwOk=
X-Gm-Gg: ASbGncvKYfz+aEezbDuaGqwZtcsuzAfIUYKjkohXYoQioVTNixLascgFCO0drSQ0GiF
	5DlJJNFo4bNsJPLbds58rUgndVnCdREEiR3HCrELkMb/JgG6SPkchZMw38CI7XiVThHs87qqjj1
	UN3+iI9iYlvISBZo2ac4nvE0qZY4ylwWxdpMFDyyg1kCUvliVOI/YqbZhWAFXsUcu8kVNb/uYLR
	CQ3FJMkKGa1JqS9TgTj2SvwXbHGl3dAH9uelz5iE3sPcnZv9ZUjy0gNRfxAG2z7QtOsUH/J6dG8
	BZtxqMQw/ADI5hnCLwUB2oOkbHyz+GmJL49ID4KDlNZ8hJTOQJ1MSrYEHvnJpfwJ4L+4+0779/8
	bJAVaBqkjPfdAiQ==
X-Google-Smtp-Source: AGHT+IG0junclw7g29Tiqwx2VjZpghoTqY/gPZ70p9955vnBkCywMNmCzZAK8v7YO3Z5zsZcGqWWmQ==
X-Received: by 2002:a05:6a20:cf90:b0:1f5:64a4:aeac with SMTP id adf61e73a8af0-21182ec067cmr1039329637.33.1746485777257;
        Mon, 05 May 2025 15:56:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db9200sm7423761b3a.42.2025.05.05.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:56:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uC4jN-0000000HT0R-0Pro;
	Tue, 06 May 2025 08:56:13 +1000
Date: Tue, 6 May 2025 08:56:13 +1000
From: Dave Chinner <david@fromorbit.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Anton Gavriliuk <antosha20xx@gmail.com>, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBlCDTm-grqM4WtY@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area>
 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_155618_211943_567D47BC 
X-CRM114-Status: GOOD (  19.34  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 05, 2025 at 09:21:19AM -0400, Laurence Oberman wrote:
> On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> > On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > > So the MD block device shows the same read performance as the
> > > filesystem on top of it. That means this is a regression at the MD
> > > device layer or in the block/driver layers below it. i.e. it is not
> > > an XFS of filesystem issue at all.
> > > 
> > > -Dave.
> > 
> > I have a lab setup, let me see if I can also reproduce and then trace
> > this to see where it is spending the time
> > 
> 
> 
> Not seeing 1/2 the bandwidth but also significantly slower on Fedora42
> kernel.
> I will trace it
> 
> 9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64
> 
> Run status group 0 (all jobs):
>    READ: bw=14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
> 15.8GB/s), io=441GiB (473GB), run=30003-30003msec
> 
> Fedora42 kernel - 6.14.5-300.fc42.x86_64
> 
> Run status group 0 (all jobs):
>    READ: bw=10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2GB/s-
> 11.2GB/s), io=313GiB (336GB), run=30001-30001msec

So is this MD chunk size related? i.e. what is the chunk size
the MD device? Is it smaller than the IO size (256kB) or larger?
Does the regression go away if the chunk size matches the IO size,
or if the IO size vs chunk size relationship is reversed?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


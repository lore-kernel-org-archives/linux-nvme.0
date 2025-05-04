Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC92C369DC
	for <linux-nvme@archiver.kernel.org>; Sun,  4 May 2025 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfeBgs4UborAOcvG4HnMDQYljLnZG29GLGTw9gpzQk8=; b=3FcjeLC/Fp9xWp8hIMXwgQFLAS
	P/4LOlfuVZa9KJofoQVl4qV+Ye6ByVSmLMzRhX8xs5CIWKmF52nHN8HrRROnsTkZ9R8M+4HAMaSCx
	i4+bvvwLUz9nj/hHUVJVuBzzHww7TxNjCTURMcbPY/Fjdo/V85ywzWLm/ZO0uCVmms4aGCVTQq4fM
	MItT3AazV+shbCHhM7AWWOSxdgq1SvsX0sxx3tqZbJFbFOClyobnQzz7Y0p17X2UPtZpfWAqyzbOm
	fHgdSOilzwloFs3yGNvviQ5DN8fa0zVubOt7PiYiqY1PzDdFX0VjbgbajA3MoY9C32KLbSYxJmuWg
	CY0gbKbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBidj-000000066wq-0zx0;
	Sun, 04 May 2025 23:20:55 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBidd-000000066wP-2g1N
	for linux-nvme@lists.infradead.org;
	Sun, 04 May 2025 23:20:52 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-736c277331eso4431820b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 04 May 2025 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746400848; x=1747005648; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfeBgs4UborAOcvG4HnMDQYljLnZG29GLGTw9gpzQk8=;
        b=Gt3uGGp2GacTDgsMlbCVwLEGZ4LdRp9ai8VQepV0wgySdrWL1LBCrGKeNOP+nJuGOJ
         jJC5wawSPH2qBblsqIgfO/c3gMnq9ZYSLnzChOAEgIVxaKPmCkxIaH2nCgMyyUEs22lt
         ZP3bKqn4pGX5O6BtYV3ntGF/v0vmW/Ie3+f4EgNV8g0iVIVFMc1tRdS5lrYVSMjxkL19
         l0nKypf0c1/NALU0A5lHizFEgVo1zL5ur9i9v8sh6x9bdnqBR78QB93Texr7F87AZu5c
         vzB5S/MHNCak3xkRSuu9bI1LwwjaEc33AVejAsSfi24DyAy9onhXIWQVol6cUzi7SJW6
         QA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746400848; x=1747005648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfeBgs4UborAOcvG4HnMDQYljLnZG29GLGTw9gpzQk8=;
        b=WMJsK5Lx12vPrlDVzvIWDpfKk26XkyBLQCUdYaP4eppUCFfmJln1IerAorGnWLHzG9
         iPcezDhZ749IOCdtxFU6mBtfFB+d0ikkJYsYMONawB2kLBKTu1fiL6jNh80qiVWSfsgS
         a305w7nK5o1h5IjZLNxmIdfTzraFEDlegxtGxpGgHG9RDaxcBpx8qZzBTQZLWAsVVQmJ
         Zo/Mj1aGfpj+mUfmRnpntQOp7LkKt0rBSssSHBxaNyuL0ChBLcL/YNOfTjm8vJifBHPJ
         o8DTSwU4wz6H/RMZC8z+6fTm8MC0R5rP5f5dYeugN+twEDxBwx2gliwDVYZaZOpYpFML
         JUOg==
X-Gm-Message-State: AOJu0YxxTPMsjPLZN52gb09V5LbX9xD8CFkqGjZMQoAkeRGyjX4VkH/i
	g51GsJJwach6YwtCdBDA0XarVV/p62eKWTxzgZO0C6gWgsYQoYH1/teJfFNtoMs=
X-Gm-Gg: ASbGncs/7/4erQK+kUnUAy/kA0BVm/actK0GpSk3o73TLInudAzT82WxiJeYn1f9Pq6
	h42O5KUKsnKkBNNdXFWjVah3yzJ+ffg/242Pm6BuDO0djl6sAthD//dpNL5/YvuMeXzGZkq7taD
	XFJlr9TJxAXOPROEzEMq3RoJGIw2mJyOJidcMoYInMaeHspy6xAi/HBOQyv0Ig5ilP7O7hjnxGS
	ivQFDy0DTSTTMV0aHbu43oJsl2c4MdFYnq9MuXRq9lblf2YwNMSG3qAKtoJJ21aq4HwawSbHe5D
	de7bc2h3QSvlq5xytqTSEiu4/9AHUSj+xBhju8/D0pLPLf1oDItLNudkOCBzBwS0XbHiBNWUMGT
	eVl2K23qSQHWqIQ==
X-Google-Smtp-Source: AGHT+IGCM1oKSvy7l0H2B/hDL6kgsXjWiZgAvEkfu7nnKuE8VkwYZd2FK8GVtUX6+MWy4Rlsv/R+Rg==
X-Received: by 2002:a05:6a21:3416:b0:1ee:450a:8259 with SMTP id adf61e73a8af0-20bd8d4b1cdmr21085599637.18.1746400848366;
        Sun, 04 May 2025 16:20:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590218bdsm5548747b3a.99.2025.05.04.16.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 16:20:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uBhDp-0000000H1tf-2dG5;
	Mon, 05 May 2025 07:50:05 +1000
Date: Mon, 5 May 2025 07:50:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBfhDQ6lAPmn81j0@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_162050_619796_8F0ADEB7 
X-CRM114-Status: GOOD (  10.50  )
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

[cc linux-block]

[original bug report: https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com/ ]

On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk wrote:
> > What's the comparitive performance of an identical read profile
> > directly on the raw MD raid0 device?
> 
> Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> 
> [root@localhost ~]# df -mh /mnt
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/md127       35T  1.3T   34T   4% /mnt
> 
> [root@localhost ~]# fio --name=test --rw=read --bs=256k
> --filename=/dev/md127 --direct=1 --numjobs=1 --iodepth=64 --exitall
> --group_reporting --ioengine=libaio --runtime=30 --time_based
> test: (g=0): rw=read, bs=(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
> 256KiB-256KiB, ioengine=libaio, iodepth=64
> fio-3.39-44-g19d9
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=81.4GiB/s][r=334k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=43189: Sun May  4 08:22:12 2025
>   read: IOPS=363k, BW=88.5GiB/s (95.1GB/s)(2656GiB/30001msec)
>     slat (nsec): min=971, max=312380, avg=1817.92, stdev=1367.75
>     clat (usec): min=78, max=1351, avg=174.46, stdev=28.86
>      lat (usec): min=80, max=1352, avg=176.27, stdev=28.81
> 
> Fedora 42 (6.14.5-300.fc42.x86_64)
> 
> [root@localhost anton]# df -mh /mnt
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/md127       35T  1.3T   34T   4% /mnt
> 
> [root@localhost ~]# fio --name=test --rw=read --bs=256k
> --filename=/dev/md127 --direct=1 --numjobs=1 --iodepth=64 --exitall
> --group_reporting --ioengine=libaio --runtime=30 --time_based
> test: (g=0): rw=read, bs=(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
> 256KiB-256KiB, ioengine=libaio, iodepth=64
> fio-3.39-44-g19d9
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=41.0GiB/s][r=168k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=5685: Sun May  4 10:14:00 2025
>   read: IOPS=168k, BW=41.0GiB/s (44.1GB/s)(1231GiB/30001msec)
>     slat (usec): min=3, max=273, avg= 5.63, stdev= 1.48
>     clat (usec): min=67, max=2800, avg=374.99, stdev=29.90
>      lat (usec): min=72, max=2914, avg=380.62, stdev=30.22

So the MD block device shows the same read performance as the
filesystem on top of it. That means this is a regression at the MD
device layer or in the block/driver layers below it. i.e. it is not
an XFS of filesystem issue at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com


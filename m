Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E573DC369C2
	for <linux-nvme@archiver.kernel.org>; Sat,  3 May 2025 22:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3/BOZ1oqrbclwCS/0w9JT7451hLp7XldrjPCpknUI0=; b=hAkKfyUlr344jX5fxMiaescRPV
	XyWgJrK/+cjvL2C0EqLsp7rxlULeaMSuFB+qhZTa76wPFEZkJrfCJKcwUFP+g1lNvswpAsEeVXX2E
	NV+v/pF0wVYoYGKslBo3/wmih3rH4chfo+HrR73NuXO1kEmoqETgGZohekxQdmQ9Ru+bvu425gL1L
	fcKDov4I7RPjaYq7vIQCbvK3ldjuMz3jRjpfMPJ/ztevr1OpjGv03la1RBt/Wq19oicAE4zdsO87m
	HGxj9jZNvjs0XSCHVBjuyTWj6M2Q5Bub9PL+z8AcxihkURGRNBE+tSA65LSyH5LTmm2wapiaUjW/P
	unjT+Ppg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBL9m-00000004YON-3Fxt;
	Sat, 03 May 2025 22:16:26 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBL9j-00000004YNv-2Ukv
	for linux-nvme@lists.infradead.org;
	Sat, 03 May 2025 22:16:25 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so2728345b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 03 May 2025 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746310582; x=1746915382; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3/BOZ1oqrbclwCS/0w9JT7451hLp7XldrjPCpknUI0=;
        b=3TWr7K9G9z1nwrikUwDmF313ppYlK8KvWU9hZBXXBbc/xDXYo4C17Fw0A5TPnOGzBu
         GDLX2kmWHqy5VbQBMsRzYbtli9SSvPCcHO88EdmjXHYlxrk6ejY+cn16F08Rg+5zUj1n
         HXRbLkiDCZPAOOJW/r0EcSGAMlW/lkGZNN9iEalFn0SRjl+Emznr8JnCdJqG4vTxjNMA
         Pi/HNxtuUOHHGEFYrEPdUaGXU+sCBf5b5X8gEA55eAq8pDtubnOkLNgXGR6NwZWTh+hT
         B0wMcMVYD7qeCoVf4Qp+Vv6mVPPxicV+XSKdQd/U5kvthQX1VaN2opmmDtNcs9pNMjvg
         W9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746310582; x=1746915382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3/BOZ1oqrbclwCS/0w9JT7451hLp7XldrjPCpknUI0=;
        b=MZBdaRC6nErblasoyeQey15muLEkk+UzXM5dcw9XchEFQ95N9BmmXKUcNtUinX8opZ
         oOQ2AbXXtyK39waJTVVSbE6UdViCzuQSlgHB2Z1807QQAiRwswbJJkwoHtgnaY/wDvzt
         XRM43cHo4E9Pky1/XrU0mqD4ESFZ/IYeqCNjblTHhah3X+WGXP4T31qUE8tU6qIVyL69
         coKtZTtd6P2MOq1sc1l0wTEUTiq3kpG/hgYBTrYKxEdJHf7uN5VjshSGYv7w7/+vcV7K
         XnI6aVP5/fMXo0pYISjwJIaYFWRuIIJFkJDLykgauY1pgnKVikyJcGLgzDXBlQz5/+i2
         J1Gw==
X-Gm-Message-State: AOJu0YxAzp57XvAnaHOeFfG+4bavusozKprFM6T+n/VKB4FniguS90Xd
	x0mPvK1aXIhJSHjN48h9NdLeKxJAJTtzkE7zfFhQjfaLKSRBQCiWKCclvpWzXqM=
X-Gm-Gg: ASbGncufkVnZBw3iF7r7Y4C/og/CJaIkuV38SUuW8r7riBea7CBrutSYgfGzUE+H/HF
	mszBvgklzIY2KeuZ+G4kPMeUP6viVVX+aQ0v70yxREZwGwZK8VL1zC3FKb2q9Tis4pDyCUMxF8A
	lbzoqqgDGEQGXG+Oi9ytGeDqPoTEvQMYqPYnjrzhCOt0zwsMDXPvb1iQQ8jtIc2AJ3TLXNCkNqe
	NfR7+xK7tQbDVcc6cK7G4+a7va73ZvtO+v0siuERcI6ETlU653JLxZn6WIUvdBMtp/kuuumcd3M
	5x1LxtuKl/7nQ+sieJmHfE/d+H3GdCrkbZRVa6kXIMYjrWWytI/KDiaa4Z5JdlhT2RScBnWA0Ce
	6CDsbiulDHo6k7c6r1NfcKdn0
X-Google-Smtp-Source: AGHT+IGmuZRFjkJBnVjd0PafVKe4ogAwiZZ61mf+m/Kp5oR9p7LQ3yubCIm58SmnIqpQGdkDdBVuKw==
X-Received: by 2002:a05:6a21:100f:b0:1f5:75a9:5257 with SMTP id adf61e73a8af0-20e068196e5mr6049852637.13.1746310582249;
        Sat, 03 May 2025 15:16:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405909ca4csm3839134b3a.161.2025.05.03.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 15:16:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uBL9e-0000000GcsB-3gNd;
	Sun, 04 May 2025 08:16:18 +1000
Date: Sun, 4 May 2025 08:16:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBaVsli2AKbIa4We@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_151623_896628_3F30621F 
X-CRM114-Status: GOOD (  11.19  )
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

On Sun, May 04, 2025 at 12:04:16AM +0300, Anton Gavriliuk wrote:
> There are 12 Kioxia CM-7 NVMe SSDs configured in mdadm/raid0 and
> mounted to /mnt.
> 
> Exactly the same fio command running under Fedora 42
> (6.14.5-300.fc42.x86_64) and then under Rocky 9.5
> (5.14.0-503.40.1.el9_5.x86_64) shows twice the performance difference.
> 
> /mnt/testfile size 1TB
> server's total dram 192GB
> 
> Fedora 42
> 
> [root@localhost ~]# fio --name=test --rw=read --bs=256k
> --filename=/mnt/testfile --direct=1 --numjobs=1 --iodepth=64 --exitall
> --group_reporting --ioengine=libaio --runtime=30 --time_based
> test: (g=0): rw=read, bs=(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
> 256KiB-256KiB, ioengine=libaio, iodepth=64
> fio-3.39-44-g19d9
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=49.6GiB/s][r=203k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=2465: Sat May  3 17:51:24 2025
>   read: IOPS=203k, BW=49.6GiB/s (53.2GB/s)(1487GiB/30001msec)
>     slat (usec): min=3, max=1053, avg= 4.60, stdev= 1.76
>     clat (usec): min=104, max=4776, avg=310.53, stdev=29.49
>      lat (usec): min=110, max=4850, avg=315.13, stdev=29.82

> Rocky 9.5
> 
> [root@localhost ~]# fio --name=test --rw=read --bs=256k
> --filename=/mnt/testfile --direct=1 --numjobs=1 --iodepth=64 --exitall
> --group_reporting --ioengine=libaio --runtime=30 --time_based
> test: (g=0): rw=read, bs=(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
> 256KiB-256KiB, ioengine=libaio, iodepth=64
> fio-3.39-44-g19d9
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=96.0GiB/s][r=393k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=15467: Sun May  4 00:00:39 2025
>   read: IOPS=390k, BW=95.3GiB/s (102GB/s)(2860GiB/30001msec)
>     slat (nsec): min=1111, max=183816, avg=2117.94, stdev=1412.34
>     clat (usec): min=81, max=1086, avg=161.60, stdev=19.67
>      lat (usec): min=82, max=1240, avg=163.72, stdev=19.73
> 

Completely latency has doubled on the fc42 kernel. For a read, there
isn't much in terms of filesystem work to be done on direct IO
completion, so I'm not sure this is a filesystem issue...

What's the comparitive performance of an identical read profile
directly on the raw MD raid0 device?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


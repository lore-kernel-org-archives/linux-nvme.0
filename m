Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E66C433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 08:59:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F02D2071A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 08:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ffxeP8YC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THUsuvph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F02D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hyiiebldjy6/WM8Dj0mhgCHGTFPtdi7HdwcMRhwUNEQ=; b=ffxeP8YCYT83FjpTBKxDoszThJ
	yNKW9dLQgtDdM3tfqEext9kwVZ8SX2EPlXidP52z0j9GUCs8OMLd2dwwpmkL+TlBAPAJg5uaqpkpJ
	4ambxyxSsMM2prKk+KTJmgN+V6aXjxyjJTfI2yeHkNj9aB54HbZR56hz72xsJBoGMImZsUKDRPtL6
	+mTArNCaddeoTYiljqc16ok3PoBr21FeON8X9VPFXZ1wUctZiSOch2e4QeKWVa9K0qIL9+W+pqnny
	GdOBfb7dDVb4SsnuJ8GSztX65FNz4af80EOj1DX8SLRPK7aImmbHcurBdXkD4kZ+xXzEgyLJkZan2
	j73tp1Vw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyX4l-0000U0-NS; Thu, 23 Jul 2020 08:59:39 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyX4i-0000TH-Er
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 08:59:37 +0000
Received: by mail-ot1-x344.google.com with SMTP id 18so3829186otv.6
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Q+TEz2/R7ny7193rTVsz12koZcmFNadk6iGZqiWQMIY=;
 b=THUsuvphto9N6yM6SSLvuHM2LCu5x70+F1E4ORwwMbLErcp2hCWf3CRrqkw3Lu1+Nd
 WSu0YmFBbIZ9tvmHiXFZlF4+7374hJXrKbfGj6Gjj+wKBXXEbIajjGTlKI2R78WYg3Ex
 cIR8ATk/YTpM7wIbVEczB4Sitl1nFhrLoqn6sDuDgPeigxUbC04JuSHQB/XhmeIJ2/xo
 eNm7af8CatG8rWihjVxi7XZTHNvzKc9PkgdrYtMXeScD6x/RVBJnnsh/O2TDYcoB4LQk
 s94DUklq0kQ0FR9EdKSyB/5pIfRy/lRXhO0+ADC+zOQCSFH16DwSdGYPnfzL7t8dz6yF
 cYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Q+TEz2/R7ny7193rTVsz12koZcmFNadk6iGZqiWQMIY=;
 b=rYliCrkuypnyvu3fz4HaWxf0s3CMHQg6mnPB/rZ3y+HPLbK31VTkyQgbI9O4YMbiWb
 oyqMOowX4iKgwjyELqQUB5t5H+DN+wX4Z3X4MsXhgU86vMIoUlihk7rfYQU1YNsVGOt3
 aOv6I0VVvAYGLJTU8dBEPA2cxNvUR4HZFuHO5NXBgYK0R2VvkiU41of2ClrAgU0E2SvB
 CQ9z5zuWARi3ND3n3Al1r/HerArnLgNtQoRJ1Tap3qAp4TYX7yKpWeQ6Hc6o4t9Hfi+0
 bU0axGeRRnbbWSuIe0+n413se1VeDRZBM+oAnzYBatBzUOut0sOMyjDsqEIUqz64vR37
 smGA==
X-Gm-Message-State: AOAM533fWFF5NpXs4M6JRGOjA61zb0FpOLfpASdVe3n9KVlx3l2vnOkJ
 qQzpoIwX192PAJ6eGIv9lMW9UM+b5MiZEY08I2szHY3V22NL7A==
X-Google-Smtp-Source: ABdhPJx0qZPKGyvUlS6DqiELdNc4A2/8nzGQ3ySvCBGYIx7teDmGXW5ZJfIy2vCrZ6kxgJyYpwhABZ19Yvy9O4cN6vY=
X-Received: by 2002:a9d:12b5:: with SMTP id g50mr3230657otg.212.1595494772333; 
 Thu, 23 Jul 2020 01:59:32 -0700 (PDT)
MIME-Version: 1.0
From: Varad Gautam <varadgautam@gmail.com>
Date: Thu, 23 Jul 2020 10:59:21 +0200
Message-ID: <CAEidHJsDFmjzZ+sUcp1VHmd8A8vi-s91B3E0egkwGBx=XjOm=g@mail.gmail.com>
Subject: Enabling poll_queues on NVME with kernel-5.x
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_045936_535599_AA6626B5 
X-CRM114-Status: UNSURE (   6.14  )
X-CRM114-Notice: Please train this message.
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
Cc: vrd@amazon.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Since commit a4668d9ba ("nvme: default to 0 poll queues") [1], the
nvme driver needs to be explicitly configured with poll_queues > 0 to
allow enabling io_poll.

However, prior to poll queues separation in 4b04cc6a8 ("nvme: add
separate poll queue map") [2], io_poll was enabled by default on nvme
block devices.

This is leading to higher io latencies on nvme drives by default
(nvme.poll_queues=0, io_poll=0), visible with fio slat/clat/lat below.

The commit [1] says:

> We need a better way of configuring this, and given that polling is
> (still) a bit niche, let's default to using 0 poll queues.

Are there any plans / work needed for nvme to provide > 0 poll_queues
by default?

kernel-5.4, io_poll=0
---------------------
bash-4.1$ sudo fio /tmp/fio-workload
fio-workload: (g=0): rw=randrw, bs=16K-16K/16K-16K, ioengine=libaio, iodepth=1
fio 1.55
Starting 1 process
Jobs: 1 (f=3), CR=2000/0 IOPS: [m] [97.3% done] [17006K/17219K /s]
[1038 /1051  iops] [eta 00m:08s]]
fio-workload: (groupid=0, jobs=1): err= 0: pid=51062
  read : io=4564.1MB, bw=16013KB/s, iops=1000 , runt=291918msec
    slat (usec): min=3 , max=75 , avg= 5.61, stdev= 2.33
    clat (usec): min=59 , max=2584 , avg=173.86, stdev=307.87
     lat (usec): min=78 , max=2590 , avg=180.07, stdev=307.88
    bw (KB/s) : min=13140, max=19040, per=100.21%, avg=16045.14, stdev=1015.87
  write: io=4565.4MB, bw=16014KB/s, iops=1000 , runt=291918msec
    slat (usec): min=4 , max=86 , avg= 6.33, stdev= 2.85
    clat (usec): min=3 , max=420 , avg=39.54, stdev= 5.31
     lat (usec): min=40 , max=427 , avg=46.49, stdev= 6.53
    bw (KB/s) : min=13090, max=19104, per=100.22%, avg=16049.96, stdev=1055.02
  cpu          : usr=0.76%, sys=2.24%, ctx=587979, majf=0, minf=183
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued r/w/d: total=292153/292180/0, short=0/0/0
     lat (usec): 4=0.01%, 10=0.01%, 20=0.01%, 50=48.66%, 100=11.94%
     lat (usec): 250=35.31%, 500=2.28%, 750=0.24%, 1000=0.18%
     lat (msec): 2=0.72%, 4=0.67%

Run status group 0 (all jobs):
   READ: io=4564.1MB, aggrb=16012KB/s, minb=16397KB/s, maxb=16397KB/s,
mint=291918msec, maxt=291918msec
  WRITE: io=4565.4MB, aggrb=16014KB/s, minb=16398KB/s, maxb=16398KB/s,
mint=291918msec, maxt=291918msec

Disk stats (read/write):
  nvme0n1: ios=292073/292298, merge=0/135, ticks=50570/11593,
in_queue=0, util=35.54%

kernel-5.4 nvme.poll_queues=32 io_poll=1
----------------------------------------
bash-4.1$ sudo fio /tmp/fio-workload
fio-workload: (g=0): rw=randrw, bs=16K-16K/16K-16K, ioengine=libaio, iodepth=1
fio 1.55
Starting 1 process
Jobs: 1 (f=3), CR=2000/0 IOPS: [m] [97.3% done] [16809K/16678K /s]
[1026 /1018  iops] [eta 00m:08s]
fio-workload: (groupid=0, jobs=1): err= 0: pid=11017
  read : io=4565.5MB, bw=16009KB/s, iops=1000 , runt=291994msec
    slat (usec): min=3 , max=81 , avg= 5.41, stdev= 2.32
    clat (usec): min=60 , max=2593 , avg=165.01, stdev=309.91
     lat (usec): min=76 , max=2598 , avg=171.04, stdev=309.94
    bw (KB/s) : min=13076, max=19008, per=100.20%, avg=16041.43, stdev=926.95
  write: io=4565.2MB, bw=16010KB/s, iops=1000 , runt=291994msec
    slat (usec): min=3 , max=84 , avg= 6.04, stdev= 2.78
    clat (usec): min=2 , max=280 , avg=36.30, stdev= 4.14
     lat (usec): min=37 , max=286 , avg=42.96, stdev= 5.19
    bw (KB/s) : min=13085, max=19168, per=100.21%, avg=16042.78, stdev=978.02
  cpu          : usr=0.68%, sys=2.28%, ctx=587989, majf=0, minf=186
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued r/w/d: total=292163/292170/0, short=0/0/0
     lat (usec): 4=0.01%, 10=0.01%, 20=0.01%, 50=49.39%, 100=21.80%
     lat (usec): 250=25.09%, 500=2.11%, 750=0.13%, 1000=0.12%
     lat (msec): 2=0.65%, 4=0.70%

Run status group 0 (all jobs):
   READ: io=4565.5MB, aggrb=16009KB/s, minb=16393KB/s, maxb=16393KB/s,
mint=291994msec, maxt=291994msec
  WRITE: io=4565.2MB, aggrb=16009KB/s, minb=16393KB/s, maxb=16393KB/s,
mint=291994msec, maxt=291994msec

Disk stats (read/write):
  nvme0n1: ios=292051/292222, merge=0/143, ticks=47967/10589,
in_queue=0, util=34.31%


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a4668d9ba
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4b04cc6a8

Thanks,
Varad Gautam

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

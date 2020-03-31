Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB01C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 06:17:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3894206EB
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 06:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h9E3mVlt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtnzYGc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3894206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8vERtNwYDOv/rDmecMQRsTWtKI1r7GHtPjyETe89YXo=; b=h9E3mVltvfLf8Q
	dsOaYXVJ6P24IiCKWd+4KfstSJA4sqlq4iG/VsTKVjdeUf+VxdYIVYuZpjsW8k+vUqKzTxRN+7Hc1
	JLUEHw+Kom/EZPMaKVWGlLpRylkwY4pVM15soi3U8IMUucH/Hs/v3bBaPHTK4RcPLYVmx5uZ9mUt4
	SdHUNYPdrR3ta/qxCY6iV52apjvcdf6QVvOnEYQjLB/z33PxVj58WEXS9WC8At9CBxyOa/P1b/sG1
	WKl7+yd60cYMAY6oak6gVchU4NHYqm2vmV6aEXRfyi8IpCEv5IDkxoPEdQx0uhKp1vNohsQQNH1nk
	QUBxW+nkrQ5bCD7110xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJADC-0002tn-Fo; Tue, 31 Mar 2020 06:17:22 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJAD8-0002t9-Uw
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 06:17:20 +0000
Received: by mail-qk1-x744.google.com with SMTP id u4so21804109qkj.13
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WIxxK39yFs5OEp2hoQ/hVPAMvH8Vwu0fOy3U41jNDI4=;
 b=gtnzYGc01I61h4c7FPRTBKTYrGmeLJqPOxWQilD4KbLcH5GwVg/Uuv7hhK9eqxoldh
 gjL/pGOzzxVQMvQ/LcYJhqqsc8wDXhhftxFsch/8i5eoD8Q2dw3TiI5w9VXjtVwEX5uR
 ChUk3p8MIb5NoNxjV0sPR1r0huoWCYmshLRjSHiXCSUV8j9ma4mpP/0xj48nz3tusZ/c
 jz1NULPB1/cd+In7xBAVsHPDhZALLJwJDFNetP9lBc6qt32VxOWsLU+DWt89fx/OElCA
 +ISoWCYB7YSrFXcLmSbmztf9s9ctzTbv2gX4R+UhivVqvU1hgVwu0gV0lmTMYCks40gT
 AFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WIxxK39yFs5OEp2hoQ/hVPAMvH8Vwu0fOy3U41jNDI4=;
 b=AT7pbKVryLpe42m1FqH/iHUoJDJ1CfkqC94a6gY4kXEufmGr/RevZD9/J84aaO2yDC
 jCt63R4Qb4KYoCbEvZZ6Q9a+Ok0NIzBWkztPwxIOtmXLm15yOVVMJpOzde5DqSBIIx3H
 mi18I8IDdMTnKeQdv4OzBaVgCjFrU1t7OE+qaka/XJeYjV4XAtPe0oZlVbny4sPkATzB
 W29Qmz+VVvThWAv+LCg42ijZdX6I4nFTyCxQPVLUoExHxOr+sdzdtOM64Qpi+Aa/WW8E
 X+a+6unSPZY1TVF/yzBjF0ADpHwvAwcw2Hf3aZ05i8X/HhfOwc139lUi/UM/Zxj5Ajhn
 SJUw==
X-Gm-Message-State: ANhLgQ1tVOd4kInA/uERils+hv6fPNW+9zw5LYa5e+aZBFTPwBxisa2/
 v3dVSpdGe/2KOEF38/CzCnCawNZnILHPnxTFqno=
X-Google-Smtp-Source: ADFU+vvimfZGmVLQxjvf61mux56f6SGLVtWGf9mUsRFBg9JeB4PpjjH593/kiVxo4oDb2kCxZul1ifV79Wa5PbBquUc=
X-Received: by 2002:ae9:ee01:: with SMTP id i1mr3517974qkg.498.1585635437494; 
 Mon, 30 Mar 2020 23:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
In-Reply-To: <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Tue, 31 Mar 2020 14:17:06 +0800
Message-ID: <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_231719_000775_44F38EAB 
X-CRM114-Status: GOOD (  19.00  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> > On the driver implementation, the number of module parameters being
> > added here is problematic. We already have 2 special classes of queues,
> > and defining this at the module level is considered too coarse when
> > the system has different devices on opposite ends of the capability
> > spectrum. For example, users want polled queues for the fast devices,
> > and none for the slower tier. We just don't have a good mechanism to
> > define per-controller resources, and more queue classes will make this
> > problem worse.
> >
> We can add a new "string" module parameter, which contains a model number,
> in most cases, the save product with a common prefix model number, so
> in this way
> nvme can distinguish the different performance devices(hign or low end).
> Before create io queue, nvme driver can get the device's Model number(40 Bytes),
> then nvme driver can compare device's model number with module parameter, to
> decide how many io queues for each disk;
>
> /* if model_number is MODEL_ANY, these parameters will be applied to
> all nvme devices. */
> char dev_io_queues[1024] = "model_number=MODEL_ANY,
> poll=0,read=0,wrr_low=0,wrr_medium=0,wrr_high=0,wrr_urgent=0";
> /* these paramters only affect nvme disk whose model number is "XXX" */
> char dev_io_queues[1024] = "model_number=XXX,
> poll=1,read=2,wrr_low=3,wrr_medium=4,wrr_high=5,wrr_urgent=0;";
>
> struct dev_io_queues {
>         char model_number[40];
>         unsigned int poll;
>         unsgined int read;
>         unsigned int wrr_low;
>         unsigned int wrr_medium;
>         unsigned int wrr_high;
>         unsigned int wrr_urgent;
> };
>
> We can use these two variable to store io queue configurations:
>
> /* default values for the all disk, except whose model number is not
> in io_queues_cfg */
> struct dev_io_queues io_queues_def = {};
>
> /* user defined values for a specific model number */
> struct dev_io_queues io_queues_cfg = {};
>
> If we need multiple configurations( > 2), we can also extend
> dev_io_queues to support it.
>

Hi Maintainers,

If we add patch to support these queue count at controller level,
instead moudle level,
shall we add WRR ?

Recently I do some cgroup io weight testing,
https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test
I think a proper io weight policy
should consider high weight cgroup's iops, latency and also take whole
disk's throughput
into account, that is to say, the policy should do more carfully trade
off between cgroup's
IO performance and whole disk's throughput. I know one policy cannot
do all things perfectly,
but from the test result nvme-wrr can work well.

From the following test result, nvme-wrr work well for both cgroup's
latency, iops, and whole
disk's throughput.

Notes:
blk-iocost: only set qos.model, not set percentage latency.
nvme-wrr: set weight by:
    h=64;m=32;l=8;ab=0; nvme set-feature /dev/nvme1n1 -f 1 -v $(printf
"0x%x\n" $(($ab<<0|$l<<8|$m<<16|$h<<24)))
    echo "$major:$minor high" > /sys/fs/cgroup/test1/io.wrr
    echo "$major:$minor low" > /sys/fs/cgroup/test2/io.wrr


Randread vs Randread:
cgroup.test1.weight : cgroup.test2.weight = 8 : 1
high weight cgroup test1: randread, fio: numjobs=8, iodepth=32, bs=4K
low  weight cgroup test2: randread, fio: numjobs=8, iodepth=32, bs=4K

test case         bw         iops       rd_avg_lat   wr_avg_lat
rd_p99_lat   wr_p99_lat
=======================================================================================
bfq_test1         767226     191806     1333.30      0.00
536.00       0.00
bfq_test2         94607      23651      10816.06     0.00
610.00       0.00
iocost_test1      1457718    364429     701.76       0.00
1630.00      0.00
iocost_test2      1466337    366584     697.62       0.00
1613.00      0.00
none_test1        1456585    364146     702.22       0.00
1646.00      0.00
none_test2        1463090    365772     699.12       0.00
1613.00      0.00
wrr_test1         2635391    658847     387.94       0.00
1236.00      0.00
wrr_test2         365428     91357      2801.00      0.00
5537.00      0.00

https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test#215-summary-fio-output


Randread vs Seq Write:
cgroup.test1.weight : cgroup.test2.weight = 8 : 1
high weight cgroup test1: randread, fio: numjobs=8, iodepth=32, bs=4K
low  weight cgroup test2: seq write, fio: numjobs=1, iodepth=32, bs=256K

test case      bw         iops       rd_avg_lat   wr_avg_lat
rd_p99_lat   wr_p99_lat
=======================================================================================
bfq_test1      814327     203581     1256.19      0.00         593.00       0.00
bfq_test2      104758     409        0.00         78196.32     0.00
     1052770.00
iocost_test1   270467     67616      3784.02      0.00         9371.00      0.00
iocost_test2   1541575    6021       0.00         5313.02      0.00
     6848.00
none_test1     271708     67927      3767.01      0.00         9502.00      0.00
none_test2     1541951    6023       0.00         5311.50      0.00
     6848.00
wrr_test1      775005     193751     1320.17      0.00         4112.00      0.00
wrr_test2      1198319    4680       0.00         6835.30      0.00
     8847.00


https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test#225-summary-fio-output

Thanks
Weiping

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

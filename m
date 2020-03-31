Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3062C2D0EE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 10:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D08208E0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k/XlVFJu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNREeNvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D08208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y7cbO0uONJE828O3IMDpdfliKarRjOq0wSG2d/x7LHQ=; b=k/XlVFJusmfbSt
	yhunAEgceQYKei4gmOtY9zS7l5s9/Ka1Cox/CmjO6OYzKWiFFwxggCRy8IJKAxiVK4Zs8nGFhUoQe
	Cnth6HNRorapRSqU3R0wgIC9clEs8CUw8dvpVv9TWg34VxNukpqJPbgd/oqOnUD+5S7LFVRA2gW3q
	xq2VulS/g6TkGgjSsvHW7yQblrwmY98OUYLaJ4rnq5lNXdYpz7bWP8/fA6jMYoWMfpT4qTvHKhwyi
	kW+X+f7ogZI5+/DU00AXsMnqQqi7oheJbeY/WepA6oj1DT/+11QCHbHIhRwPElVVvhI/xUrFJDdEq
	LOK2+XcYdFJLEVSTSJjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJE7c-0000pT-NI; Tue, 31 Mar 2020 10:27:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJE7W-0000ni-2E
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 10:27:48 +0000
Received: by mail-wm1-x342.google.com with SMTP id i19so1983312wmb.0
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=O4fIR3uoc5tVQMLd54nQw5z05MiLWlZQFph3hoh5hlM=;
 b=BNREeNvNYwgfnw6nTJqmTLlP6Ea59Qm5Qn9DlWzIViFO3TYt8sSdmxxdNLK1HWoYhr
 EEVgwsusv7KukwJhgMKIXZfFxJYtQO3HNis6RMwQx5eaUw24hmzKLlSi5i340BJIvyUw
 3UO6IGaAHT9Wthrglu4j6CEdAPPSSY3E/4aIGksvtJAwRjWuZxmDfMI5XcjYMsFhlGBG
 U3K4rtw1sC7/dokiyiCS22py0flzcgUHorFO8UoxUKRbEBSkajxJWP4kV4EqxZxmiqjb
 uxhGvDruvvKjg5dixW/8hWDYchtK+krYB9BkZSOyRmpjIazTKIyehYAarmvrj3XVJf2+
 mw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=O4fIR3uoc5tVQMLd54nQw5z05MiLWlZQFph3hoh5hlM=;
 b=KpG4GDh0GC/vAfh2V0x3DDtjGp7ZykpeWyhD6nz0JfaVpCSCfZ8TDzGPOPwjsQ9QZh
 KQNCIWMMHMKT/W4bmo0SypHtHSFbIShb2vaoe1gGdDuYSBET0KzDs4OMJYUtZxT30qYh
 CGEgnIbBZkhScEZI/vROnOYIIdqhSpZFXyMinzFap68A8p0hlTMaBOThwFfysqXVUSBX
 u7R2FQ3m6fszIQC57UeQRAtk6ZZAIlge81gStSOPVwRYXCnspi0Vfq19oObi/ka/nreF
 fiKMxnIQu3F/XzvIp0th5A5EIkiuzDoj6vqVIICBDeTXB1Nc+rS+Mk+jblMTfKOKANf0
 7a2w==
X-Gm-Message-State: ANhLgQ0DsDFmdJKeLTN/9i4rov2VdcZIJst/L12txWFsouJ6qeJ9rDWf
 Y1LWi/kA1/FyOnbhMy30YPDaBw==
X-Google-Smtp-Source: ADFU+vuT8ZO2RI6CGCdp6V7ksxQiTdvtGPwc5+AD46tpl705hKR8Q0bVvOvO3nAs4slrRNYfPEPmPA==
X-Received: by 2002:a05:600c:204:: with SMTP id
 4mr2599467wmi.112.1585650463503; 
 Tue, 31 Mar 2020 03:27:43 -0700 (PDT)
Received: from [192.168.0.102] ([84.33.138.35])
 by smtp.gmail.com with ESMTPSA id k204sm3405860wma.17.2020.03.31.03.27.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 03:27:42 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
Date: Tue, 31 Mar 2020 12:29:05 +0200
Message-Id: <7CD57B83-F067-4918-878C-BAC413C6A2B3@linaro.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
To: Weiping Zhang <zwp10758@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_032746_139321_403F8E74 
X-CRM114-Status: GOOD (  20.16  )
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
 linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Minwoo Im <minwoo.im.dev@gmail.com>, cgroups@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> Il giorno 31 mar 2020, alle ore 08:17, Weiping Zhang <zwp10758@gmail.com> ha scritto:
> 
>>> On the driver implementation, the number of module parameters being
>>> added here is problematic. We already have 2 special classes of queues,
>>> and defining this at the module level is considered too coarse when
>>> the system has different devices on opposite ends of the capability
>>> spectrum. For example, users want polled queues for the fast devices,
>>> and none for the slower tier. We just don't have a good mechanism to
>>> define per-controller resources, and more queue classes will make this
>>> problem worse.
>>> 
>> We can add a new "string" module parameter, which contains a model number,
>> in most cases, the save product with a common prefix model number, so
>> in this way
>> nvme can distinguish the different performance devices(hign or low end).
>> Before create io queue, nvme driver can get the device's Model number(40 Bytes),
>> then nvme driver can compare device's model number with module parameter, to
>> decide how many io queues for each disk;
>> 
>> /* if model_number is MODEL_ANY, these parameters will be applied to
>> all nvme devices. */
>> char dev_io_queues[1024] = "model_number=MODEL_ANY,
>> poll=0,read=0,wrr_low=0,wrr_medium=0,wrr_high=0,wrr_urgent=0";
>> /* these paramters only affect nvme disk whose model number is "XXX" */
>> char dev_io_queues[1024] = "model_number=XXX,
>> poll=1,read=2,wrr_low=3,wrr_medium=4,wrr_high=5,wrr_urgent=0;";
>> 
>> struct dev_io_queues {
>>        char model_number[40];
>>        unsigned int poll;
>>        unsgined int read;
>>        unsigned int wrr_low;
>>        unsigned int wrr_medium;
>>        unsigned int wrr_high;
>>        unsigned int wrr_urgent;
>> };
>> 
>> We can use these two variable to store io queue configurations:
>> 
>> /* default values for the all disk, except whose model number is not
>> in io_queues_cfg */
>> struct dev_io_queues io_queues_def = {};
>> 
>> /* user defined values for a specific model number */
>> struct dev_io_queues io_queues_cfg = {};
>> 
>> If we need multiple configurations( > 2), we can also extend
>> dev_io_queues to support it.
>> 
> 
> Hi Maintainers,
> 
> If we add patch to support these queue count at controller level,
> instead moudle level,
> shall we add WRR ?
> 
> Recently I do some cgroup io weight testing,
> https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test
> I think a proper io weight policy
> should consider high weight cgroup's iops, latency and also take whole
> disk's throughput
> into account, that is to say, the policy should do more carfully trade
> off between cgroup's
> IO performance and whole disk's throughput. I know one policy cannot
> do all things perfectly,
> but from the test result nvme-wrr can work well.
> 
> From the following test result, nvme-wrr work well for both cgroup's
> latency, iops, and whole
> disk's throughput.
> 
> Notes:
> blk-iocost: only set qos.model, not set percentage latency.
> nvme-wrr: set weight by:
>    h=64;m=32;l=8;ab=0; nvme set-feature /dev/nvme1n1 -f 1 -v $(printf
> "0x%x\n" $(($ab<<0|$l<<8|$m<<16|$h<<24)))
>    echo "$major:$minor high" > /sys/fs/cgroup/test1/io.wrr
>    echo "$major:$minor low" > /sys/fs/cgroup/test2/io.wrr
> 
> 
> Randread vs Randread:
> cgroup.test1.weight : cgroup.test2.weight = 8 : 1
> high weight cgroup test1: randread, fio: numjobs=8, iodepth=32, bs=4K
> low  weight cgroup test2: randread, fio: numjobs=8, iodepth=32, bs=4K
> 
> test case         bw         iops       rd_avg_lat   wr_avg_lat
> rd_p99_lat   wr_p99_lat
> =======================================================================================
> bfq_test1         767226     191806     1333.30      0.00
> 536.00       0.00
> bfq_test2         94607      23651      10816.06     0.00
> 610.00       0.00
> iocost_test1      1457718    364429     701.76       0.00
> 1630.00      0.00
> iocost_test2      1466337    366584     697.62       0.00
> 1613.00      0.00
> none_test1        1456585    364146     702.22       0.00
> 1646.00      0.00
> none_test2        1463090    365772     699.12       0.00
> 1613.00      0.00
> wrr_test1         2635391    658847     387.94       0.00
> 1236.00      0.00
> wrr_test2         365428     91357      2801.00      0.00
> 5537.00      0.00
> 
> https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test#215-summary-fio-output
> 
> 

Glad to see that BFQ meets weights.  Sad to see how it is suffering in
terms of IOPS on your system.

Good job with your scheduler!

However, as for I/O control, the hard-to-control cases are not the
ones with constantly-full deep queues.  BFQ complexity stems from the
need to control also the tough cases.  An example is sync I/O with
I/O depth one against async I/O.  On the other hand, those use cases
may not be of interest for your scheduler.

Thanks,
Paolo

> Randread vs Seq Write:
> cgroup.test1.weight : cgroup.test2.weight = 8 : 1
> high weight cgroup test1: randread, fio: numjobs=8, iodepth=32, bs=4K
> low  weight cgroup test2: seq write, fio: numjobs=1, iodepth=32, bs=256K
> 
> test case      bw         iops       rd_avg_lat   wr_avg_lat
> rd_p99_lat   wr_p99_lat
> =======================================================================================
> bfq_test1      814327     203581     1256.19      0.00         593.00       0.00
> bfq_test2      104758     409        0.00         78196.32     0.00
>     1052770.00
> iocost_test1   270467     67616      3784.02      0.00         9371.00      0.00
> iocost_test2   1541575    6021       0.00         5313.02      0.00
>     6848.00
> none_test1     271708     67927      3767.01      0.00         9502.00      0.00
> none_test2     1541951    6023       0.00         5311.50      0.00
>     6848.00
> wrr_test1      775005     193751     1320.17      0.00         4112.00      0.00
> wrr_test2      1198319    4680       0.00         6835.30      0.00
>     8847.00
> 
> 
> https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test#225-summary-fio-output
> 
> Thanks
> Weiping


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

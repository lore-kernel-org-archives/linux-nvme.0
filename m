Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B155C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 05:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shRKojcJ3G+YzL1IOXUVI5CglVJvwXcRL6/hy+eLs54=; b=kmxlL0lyR5J/pfW4N4jtD4syLU
	MsIpx8TBy8K4geOIIUyehHfTwEUVXuum9v+RlwpOXGKhvrpO4RcQhw7BPkHbX9ABwsn+0dYwJaR7c
	/Ru9TjeMPJkAlGD4NpaZhdjXBHvhgjar7gyePUqzdaZgmpyKw7XEke5CJ+h9B1VQrdvkVtpEssGqm
	L1lC3Ad9dStv3ADNrVRjC3n7vN7l1GKJxKKZ2qOCVtSIxh5AaMJ+hfEYuypTp25u02OtNBJSVjwW/
	c4epQ/sSjFJ1VxCz+Anz3b/UYKZzyNtCB7/vtz3Ksmb6RZiOi496BeUWLahFWU2k+l2TFj46c+jTD
	kiifg2QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ExP-0059mA-WD; Mon, 04 Jul 2022 05:49:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ErV-00567u-8I
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 05:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656913384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shRKojcJ3G+YzL1IOXUVI5CglVJvwXcRL6/hy+eLs54=;
	b=bxQOuXslRRMhbWUPc4mozvUnZ9mf03lyNBJLUXEzT25Ovx/Hl3OOKc0U7Uzx4IfqcID4yc
	hOVX8w2eKHDA/L2C2IqjMOQUlQ9knT5umXjDQVRIkM45o9q9mge6VgAiN3uS70mTfRBeCX
	v8Yw1DKjc6sH6nQwNGVTD7SB5xLhG0E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-a373GcOuMuW5M5VXGS1FTA-1; Mon, 04 Jul 2022 01:43:03 -0400
X-MC-Unique: a373GcOuMuW5M5VXGS1FTA-1
Received: by mail-pj1-f70.google.com with SMTP id i15-20020a17090a2a0f00b001ef826b921dso1840126pjd.5
        for <linux-nvme@lists.infradead.org>; Sun, 03 Jul 2022 22:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shRKojcJ3G+YzL1IOXUVI5CglVJvwXcRL6/hy+eLs54=;
        b=Mb6gy52RoFHbC1Dr0fvuCt5CBDzgSLQ7v78DVwMQCq1yeLkiFe7n4b487L4L/hey5b
         8MQQqV6LZrLzhoSrWXGfeEQYgeBaz0ZAlhh5uOpN0hHcPTaMD7zCBZAkMAfGGtM8gfsy
         f9J7OCq/fawbTS/H/MnHowB/tSvg+1VEvjNZ5clO6DR25Wg7HCOUJFyl2OnVpCBxSwXW
         z0HQ6uBzrpKm9BIMMvb3ze2c7ab6Sw2FLrNjbwu5dtBXANRKGg3VG9jguUGX3PML7/r3
         gw4lzR8Aq7vJKJ8YpkbRtUsI4Ga6j1N4H7Gsq448ROoNfXC1hyb93QAOfK8Wn/osVGKI
         QgHw==
X-Gm-Message-State: AJIora8KFsXeiMvBWP0NZStC104lsU3zlRja3xpTOndNk8L9yV+LCM24
	O+lvmEiQxDZTuCCfNTMD/NojTi1Kn6RPoDvOopGqyfS6LWWHV+n11IBH5rLf7VXjQXD9XjaaZbF
	1rN4gCEoKXPuFwAyo08KLtRJTsbPiFDtDMVaxsTewerU=
X-Received: by 2002:a17:90b:1107:b0:1ef:8d13:542f with SMTP id gi7-20020a17090b110700b001ef8d13542fmr1413944pjb.204.1656913381999;
        Sun, 03 Jul 2022 22:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssPv5US/9hTXM4IwbZyG12cYdBYO0ipfRCJpKknxcM7kMZQIrRErxpj8o4hR75Ei4mE+tWsnqxPdSSk8zw4PY=
X-Received: by 2002:a17:90b:1107:b0:1ef:8d13:542f with SMTP id
 gi7-20020a17090b110700b001ef8d13542fmr1413913pjb.204.1656913381692; Sun, 03
 Jul 2022 22:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
In-Reply-To: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 4 Jul 2022 13:42:50 +0800
Message-ID: <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_224309_406970_0D72145E 
X-CRM114-Status: GOOD (  18.98  )
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

update the subject to better describe the issue:

So I tried this issue on one nvme/rdma environment, and it was also
reproducible, here are the steps:

# echo 0 >/sys/devices/system/cpu/cpu0/online
# dmesg | tail -10
[  781.577235] smpboot: CPU 0 is now offline
# nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
no controller found: failed to write to nvme-fabrics device

# dmesg
[  781.577235] smpboot: CPU 0 is now offline
[  799.471627] nvme nvme0: creating 39 I/O queues.
[  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
[  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18

On Thu, Jun 30, 2022 at 2:02 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
> I found this issue when I run blktests after offline cpus on
> linux-block/for-next, here are the steps and dmesg log,
> and from the log, the test failed with the target connect, feel free
> to let me know if you need any info/test, thanks.
>
> # echo 0 >/sys/devices/system/cpu/cpu0/online
> # ./check nvme/004
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]
>     runtime    ...  0.725s
>     --- tests/nvme/004.out 2022-06-30 01:50:53.637275584 -0400
>     +++ /root/blktests/results/nodev/nvme/004.out.bad 2022-06-30
> 01:55:22.321399448 -0400
>     @@ -1,5 +1,7 @@
>      Running nvme/004
>     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
>     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
>     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>     +Failed to write to /dev/nvme-fabrics: Invalid cross-device link
>     +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
>     +cat: /sys/block/n1/uuid: No such file or directory
>     ...
>     (Run 'diff -u tests/nvme/004.out
> /root/blktests/results/nodev/nvme/004.out.bad' to see the entire diff)
> # dmesg
> [ 1526.169417] numa_remove_cpu cpu 0 node 0: mask now 1-31
> [ 1526.170619] smpboot: CPU 0 is now offline
> [ 1531.030430] loop: module loaded
> [ 1531.115255] run blktests nvme/004 at 2022-06-30 01:55:21
> [ 1531.305557] loop0: detected capacity change from 0 to 2097152
> [ 1531.354299] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1531.402815] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> [ 1531.404124] nvme nvme0: creating 31 I/O queues.
> [ 1531.448181] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang



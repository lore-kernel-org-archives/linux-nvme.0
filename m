Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750F9C677C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 02:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CnmE0YsSVTKDoKOZ0iASLhaQmwekNJga4R7AypfnFY=; b=dbbnw7miQ4aW/qpixd8ajVotpH
	+nmoV3JkxXT7KEwSCzdob/jwyycAmS0iiguuoPzgf8BRxn/S4uuBrnu1DPDv8TrLj99T6QcwZ1P+I
	fiTTwA+uJHCf7Mgj7P/kXLkUcBAkR88odL7zwPEn7C8CpwG2Hd+26UBg2i082aZtmssUT8a21TC1q
	KB67QEuv2HbQfJktP5Y7n+6EA5gfHauzmNfrSPGVOUqHuENcgqUo+viUwiwMcshFGp2QuDh9LFUEq
	Tz+OjR0mWw6pzrhcI5ZG6EbNYYrk6ul3lP0HRTbWOmlqae5PnLeOn9VRFqyui1P0cXGavu6vk5EVM
	J0LjsMMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPAsS-00000008bf5-37QK;
	Wed, 11 Jun 2025 02:07:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPArm-00000008bdk-33jL
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 02:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749607621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CnmE0YsSVTKDoKOZ0iASLhaQmwekNJga4R7AypfnFY=;
	b=biUc9uZLZJDM4aNBH5Vnox71ATeV2Oa7rCaJ/6zCeDOY8KEKIuRNTxc3DOkaJaulP/xjrF
	w/rCf1jIweloVa1xwh9sHbuVCwbQIaejTkcEZRxBAF5hi4/9PqYFhQXNL851cXHaSn51eX
	VSJAplMJCIdOGBam0vDdGZ2gFnzey6I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-55pxw0omOwOwyI7PT6hlMA-1; Tue, 10 Jun 2025 22:06:54 -0400
X-MC-Unique: 55pxw0omOwOwyI7PT6hlMA-1
X-Mimecast-MFC-AGG-ID: 55pxw0omOwOwyI7PT6hlMA_1749607613
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32a9bbf1c2fso13838791fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 19:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749607613; x=1750212413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CnmE0YsSVTKDoKOZ0iASLhaQmwekNJga4R7AypfnFY=;
        b=L8Go/cSOGZsXrIdPPlNsqHOZT4M0sMbpEZaqnVG/HS5eT7A7vFiIXPh3MpIHMK7Knm
         fuy7D+1OO45k3plBmNyV77C9/s6C0mMW3Puq/is+9LRaVu2JGsssQtu8FiQnSnGJQHHe
         bWs7YBOR0p3988jg13GBEBYIGOKBN/CuLUhVGiAQLtkG5KTP3M6Zm755DdSzILDxImSO
         VcJjsl3KY2uAg+8H9J/diwW5uhRHPByvAptnhHRXjytP8CyFxaLTXaYvuHgaXk834V30
         DJEpLTdxV8NVU+lqA+u8uzIR2rU7rDLBqJuWIEM7WDZO2AN+/ubn5Vjnqq9D0upIq0t4
         08MQ==
X-Gm-Message-State: AOJu0Yz+f/MTUsVdqD/N4PuT25TuK1Zvk9cYqyiA0lqESETf6NAh3xnL
	KzrolvpMLH2R12/IEFxviy61ta2dYXLLw1MhgydykxvGl+Bi77n1GCUvOZYFrzgzGBYSwaq7D7s
	Ay1rflGaXwYXERgARWshesY4XRoQ3BRKu8RCxAowQOUi3xdvZiF2GxM9jF7xfF8aSAnX7cW0Jg7
	UndcSXxM4y9LTqig8fbIbBMjLaxHoGLB8MywfNXEUw58I=
X-Gm-Gg: ASbGncs9PZyeBQTQoB891LW47wZQlqFU/DG6p4i1QHzX/eZdAOgd3po0ppA7gGkId0g
	0aqou4Q9Ld96ZkI3FwUmp3yMHikKt6ezdYRwXljFaccP8XOU62BKbcc5lJyZb4pkkAJ6IDKYjVJ
	KBGo12
X-Received: by 2002:a05:651c:2105:b0:32a:864a:46f1 with SMTP id 38308e7fff4ca-32b223f60e7mr3149321fa.30.1749607613039;
        Tue, 10 Jun 2025 19:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC++6HJs0uzBAlz7ORD2Ntak8D/0xxibGvaFvts4QIuskzMCneaPDjONBXaM0i1iemN8jK8ijwnF9B+MMhphg=
X-Received: by 2002:a05:651c:2105:b0:32a:864a:46f1 with SMTP id
 38308e7fff4ca-32b223f60e7mr3149221fa.30.1749607612565; Tue, 10 Jun 2025
 19:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs93WutyoPLFMr0JidHhRAxHC1ZDcj-RvdnX=R7OaV5ejg@mail.gmail.com>
 <20250602055258.GA22318@lst.de> <c3864333-3f8d-4a06-97d2-825cc45f61a5@oracle.com>
 <CAHj4cs9MxW96b=a6sQOtz_DDc63uKcNX3dat-th__9D0bwRQ9g@mail.gmail.com>
In-Reply-To: <CAHj4cs9MxW96b=a6sQOtz_DDc63uKcNX3dat-th__9D0bwRQ9g@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 11 Jun 2025 10:06:40 +0800
X-Gm-Features: AX0GCFtai8Qti6q38q7mxYUJvqxaTVNwjmYaeJBxH5W-CZ-UQbNOXl4QMHz1KCY
Message-ID: <CAHj4cs-AfX51CE8X86yW-gt4VnP=W5LpZDguqwba+tDz8aSCnQ@mail.gmail.com>
Subject: Re: [bug report]BUG: workqueue leaked atomic, lock or RCU:
 kworker/u67:3[365] observed from v6.15-rc7
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Alan Adamson <alan.adamson@oracle.com>, martin.petersen@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AIOzenUbIHdjFu4dIj7eeSwfyiYv77-22EpK5P3zWWw_1749607613
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_190703_194738_F1148778 
X-CRM114-Status: GOOD (  28.45  )
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

On Tue, Jun 3, 2025 at 12:25=E2=80=AFAM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
>
>
> On Mon, Jun 2, 2025 at 3:52=E2=80=AFPM John Garry <john.g.garry@oracle.co=
m> wrote:
>>
>> On 02/06/2025 06:52, Christoph Hellwig wrote:
>>
>> +
>>
>> > On Thu, May 29, 2025 at 08:41:36PM +0800, Yi Zhang wrote:
>> >> Hi
>> >>
>> >> My regression test found this issue from v6.15-rc7, please help check
>> >> it and let me know if you need any infor/test for it, thanks.
>> >
>> > Hi Zi,
>> >
>> > The new code seems to be missing a queue_limits_cancel_update,
>> > the patch below fies it.  But what kind of devices is this?
>
>
> Yeah, the patch fixed the "BUG: workqueue leaked" issue.
> It's one Micron_9300_MTFDHAL3T8TDP NVMe disk installed on one DELL R6515 =
server with AMD EPYC 7232P CPU.
>
>>
>> > PCIe muti-controller subsystems aren't that command, and this
>> > looks like a grave bug, combined with the I/O page fault that
>> > looks really odd.
>> >
>
>
> Here is the full steps and logs I did to reproduce it:
> # nvme format -l1 -f /dev/nvme3n1
> Success formatting namespace:1
> # nvme reset /dev/nvme3
> # nvme list
> Node                  Generic               SN                   Model   =
                                 Namespace  Usage                      Form=
at           FW Rev
> --------------------- --------------------- -------------------- --------=
-------------------------------- ---------- -------------------------- ----=
------------ --------
> /dev/nvme0n1          /dev/ng0n1            S795NC0X201793       SAMSUNG =
MZWLO1T9HCJR-00A07               0x1          0.00   B /   1.92  TB    512 =
  B +  0 B   OPPA4B5Q
> /dev/nvme1n1          /dev/ng1n1                  S39WNA0K201139 Dell Exp=
ress Flash PM1725a 1.6TB AIC     0x1          1.60  TB /   1.60  TB    512 =
  B +  0 B   1.2.1
> /dev/nvme2n1          /dev/ng2n1            3F50A00H0LR3         KIOXIA K=
CMYDRUG1T92                      0x1          0.00   B /   1.92  TB    512 =
  B +  0 B   1UET7104
> /dev/nvme3n1          /dev/ng3n1            2135312ADFD1         Micron_9=
300_MTFDHAL3T8TDP                0x1        480.09  GB /   3.84  TB    512 =
  B +  0 B   11300DY0
> /dev/nvme4n1          /dev/ng4n1            S64FNE0R802879       SAMSUNG =
MZQL2960HCJR-00A07               0x1        960.20  GB / 960.20  GB    512 =
  B +  0 B   GDC5302Q
> /dev/nvme5n1          /dev/ng5n1            CVFT6011001V1P6DGN   INTEL SS=
DPEDMD016T4                      0x1          1.60  TB /   1.60  TB    512 =
  B +  0 B   8DV10171
> # nvme format -l0 -f /dev/nvme3n1
> Success formatting namespace:1
> # dmesg
> [ 2390.248457] nvme nvme3: nvme3n1: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
> [ 2398.087894] nvme nvme3: resetting controller
> [ 2401.937274] nvme nvme3: D3 entry latency set to 10 seconds
> [ 2402.008719] nvme nvme3: 16/0/0 default/read/poll queues
> [ 2402.029564] nvme nvme3: nvme3n1: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
> [ 2446.470477] amd_iommu_report_page_fault: 3 callbacks suppressed
> [ 2446.470489] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x0 flags=3D0x0020]
> [ 2446.486293] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x0 flags=3D0x0020]
> [ 2446.496099] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x0 flags=3D0x0020]
> [ 2446.505896] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x500 flags=3D0x0020]
> [ 2446.515863] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x0 flags=3D0x0020]
> [ 2446.525657] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x500 flags=3D0x0020]
> [ 2446.535631] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x0 flags=3D0x0020]
> [ 2446.545431] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x600 flags=3D0x0020]
> [ 2446.555400] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x0 flags=3D0x0020]
> [ 2446.565224] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT dom=
ain=3D0x0033 address=3D0x600 flags=3D0x0020]
>
>>
>>
>> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> > index f69a232a000a..4bb3c68b3451 100644
>> > --- a/drivers/nvme/host/core.c
>> > +++ b/drivers/nvme/host/core.c
>> > @@ -2388,6 +2388,7 @@ static int nvme_update_ns_info_block(struct nvme=
_ns *ns,
>> >        * atomic write capabilities.
>> >        */
>> >       if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
>> > +             queue_limits_cancel_update(ns->disk->queue);
>>
>> For that:
>>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>
>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>

Hi Christoph

Would you mind sending a formal patch for this issue? Thanks.


>>
>>
>> >               blk_mq_unfreeze_queue(ns->disk->queue, memflags);
>> >               ret =3D -ENXIO;
>> >               goto out;
>> >
>>
>> But for the scenario which triggers this:
>>
>>
>> [ 2313.264089] nvme nvme2: resetting controller
>> [ 2317.125038] nvme nvme2: D3 entry latency set to 10 seconds
>> [ 2317.201142] nvme nvme2: 16/0/0 default/read/poll queues
>> [ 2319.450561] nvme nvme2: nvme2n1: Inconsistent Atomic Write Size,
>> Namespace will not be added: Subsystem=3D4096 bytes,
>> Controller/Namespace=3D512 bytes
>>
>> ....
>>
>> [ 2319.881675] nvme nvme3: rescanning namespaces.
>> [ 2320.163354] nvme nvme3: nvme3n1: Inconsistent Atomic Write Size,
>> Namespace will not be added: Subsystem=3D4096 bytes,
>> Controller/Namespace=3D32768 bytes
>> [ 2320.177588] BUG: workqueue leaked atomic, lock or RCU: kworker/u67:3[=
365]
>>                      preempt=3D0x00000000 lock=3D0->1 RCU=3D0->0
>> workfn=3Dasync_run_entry_fn
>>
>> It is overkill to just not add the namespace? I was under the impression
>> that this would be an highly unlikely scenario (of inconsistent atomic
>> write sizes).
>>
> Yeah, although the kernel shows "Namespace will not be added:", but the n=
s still can be seen after the format operation:
> # nvme format -l1 -f /dev/nvme3n1
> Success formatting namespace:1
> # lsblk
> nvme4n1                     259:0    0 894.3G  0 disk
> nvme2n1                     259:1    0   1.7T  0 disk
> nvme0n1                     259:2    0   1.7T  0 disk
> nvme1n1                     259:3    0   1.5T  0 disk
> nvme3n1                     259:4    0   3.5T  0 disk
> nvme5n1                     259:5    0   1.5T  0 disk
> # dmesg
> [ 3324.943476] nvme nvme3: nvme3n1: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang



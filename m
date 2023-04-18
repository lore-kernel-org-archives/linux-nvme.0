Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC8AC77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2c0AMbW2RxgIo0VKdo1CjfH1jpEcTYqmQQ8hwsx9mnc=; b=MjajoKwGOwtZ1VU0LQ9FGPv55m
	qVXDXKYS0Rhib1lksIh3Zj989m+6jDcFRIFEMi3/u+aEYe3SrPnKhoyegYqRbNB3QDBHZeapOm5eR
	WsqpirHbyaF5xvYUbKLGosVt6OEwEOZoptoIBKjDmYInAcyEHvNBYryw1oPO+tMa7v1GMYtdn7hbW
	0Rod3Y0Uvow4DicdhfAX5Ce9L9r+PHCi8D+2QseV3a2oPeA7Hos0s22+VIDSdrpt1Gw1QXhi0DXkN
	bQiKvefH4XEfmbvnM6OmBwaMWPm0dmJ+rxz8etM8FUCL8y46U5NexBu/DU7oLTjZp+VRft1EZ4RkI
	RadjkJoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poc0j-000kA7-1t;
	Tue, 18 Apr 2023 03:28:05 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poc0g-000k9h-0j
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 03:28:03 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b67a26069so1503955b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681788478; x=1684380478;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c0AMbW2RxgIo0VKdo1CjfH1jpEcTYqmQQ8hwsx9mnc=;
        b=HJpD3D/XdBjbwkuiasNzbemaHaVzz4rX7TlDttolv6hHEmETIbARzqVy8gvO53PQpP
         z+8dZ50vHnq/exotr4M3qOSloiPXxyobUqWRmVT7OnqdMGr6DDg2R8GiRu1yc5MoJi9h
         mN7dMGLTZQrJq8wfJZaEhYOVDlevifrmjWdl4Ie0cPhBBOrKxCR0Iq3cc858hRD/mr3P
         r7gEWZ9UYtFuc3zc4t9XqSUG9+bkJicGcnNpAN/c5o94uBKDxnzd4vaN1Uzrx0Mye3Ge
         UORNVhW0j9IErebAEEzMJvXuHDgY2vBtMHhjSUuda+n3DCl+V3srYJ20kz7eS/T7z5hZ
         j2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681788478; x=1684380478;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c0AMbW2RxgIo0VKdo1CjfH1jpEcTYqmQQ8hwsx9mnc=;
        b=KL63a2e3RC7QocFyDHlSYJOh+sg68o52+O7u1NZAXKE+Sr7kOU/aoqorehf5+XJg+/
         prQslgjMrJSd56eYK9Z/J/nKLBkaw2WFVNhz/yyqJeGgm3UoU2za6EJPcCJo48nqRhd+
         9aWuz8p3Q74o++uI2tsNB2aZ3cxPCGr3Skp5/D+kofzl2xlRcfkIzba0v08uBYiN6FJI
         MxvcasvbhnvkPqi6UL2sigOc+ZhHFdqqMAZZrgdovdcBU3Qa5lIGLTCsRKgFis9aSVln
         3l+t2lbfgCp4AtFurkJaYW5CLAKmJFyHH4gx3Yj+gL0XEF4mNCNjeUmV8k0so8APbbm5
         mDNA==
X-Gm-Message-State: AAQBX9c+slp5RyzxQvQAgcvLNIyUnyq62Aw35q89GHbqL/o+B3KZ0iWn
	DfhkbcIuCKsOpPxpLggyAv4=
X-Google-Smtp-Source: AKy350bWfZMCe1mz+gBU6ovl3M8s1ndRJEWrBZoK2VcQTTmCXH+Qy6NV1L1oZe42yrHDGWPlaP5/AQ==
X-Received: by 2002:a17:903:41c6:b0:1a6:8268:9055 with SMTP id u6-20020a17090341c600b001a682689055mr884907ple.24.1681788477836;
        Mon, 17 Apr 2023 20:27:57 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902bccb00b0019309be03e7sm8400294pls.66.2023.04.17.20.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 20:27:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
From: Li Feng <lifeng1519@gmail.com>
In-Reply-To: <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
Date: Tue, 18 Apr 2023 11:29:54 +0800
Cc: Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5976C351-B2EB-4C25-A2AA-2A64EDD8CCDE@gmail.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
 <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
 <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_202802_461074_3BF27A73 
X-CRM114-Status: GOOD (  30.63  )
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



> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=889:33=EF=BC=8CSagi =
Grimberg <sagi@grimberg.me> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>>>> On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
>>>>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>>>>> to N-1. However, some cpus are busy for other jobs, then the =
nvme-tcp will
>>>>> have a bad performance.
>>>>=20
>>>> Can you explain in detail how nvme-tcp performs worse in this =
situation?
>>>>=20
>>>> If some of CPUs are knows as busy, you can submit the nvme-tcp io =
jobs
>>>> on other non-busy CPUs via taskset, or scheduler is supposed to =
choose
>>>> proper CPUs for you. And usually nvme-tcp device should be =
saturated
>>>> with limited io depth or jobs/cpus.
>>>>=20
>>>>=20
>>>> Thanks,
>>>> Ming
>>>>=20
>>>=20
>>> Taskset can=E2=80=99t work on nvme-tcp io-queues, because the worker =
cpu has decided at the nvme-tcp =E2=80=98connect=E2=80=99 stage,
>>> not the sending io stage. Assume there is only one io-queue, the =
binding cpu is CPU0, no matter io jobs
>>> run other cpus.
>> OK, looks the problem is on queue->io_cpu, see =
nvme_tcp_queue_request().
>> But I am wondering why nvme-tcp doesn't queue the io work on the =
current
>> cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
>> affinities for each hw queue, driver is supposed to submit IO request
>> to hardware on the local CPU.
>> Sagi and Guys, any ideas about introducing queue->io_cpu?
>=20
> Hey Ming,
>=20
> I have some vague memories wrt to this, but from what I recall:
>=20
> - The number of queues is dependent on both the controller and
> the user (Not a reason/motivation on its own, just clarifying).
>=20
> - It simply matches what pci does (to some extent, outside of rx side
> entropy that may exist), it just happens to take more cpu cycles due =
to
> the network stack overhead.
>=20
> - I didn't want io threads to change CPUs because of RFS/aRFS
> optimizations that people use, which allows the NIC to steer =
interrupts
> (and napi context) to where the io thread is running, and thus =
minimize
> latency due to improved locality. that on its own was shown to be =
worth
> over 30% reduction.
>=20
RFS works not good here. On my aarch64, the NIC irq is handled on NUMA =
node 2 CPU.
And nvme-tcp io-queue is busy on CPU0.

> - At some point nvme-tcp rx context used to run in softirq, and having
> to synchronize different cores (on different numa nodes maybe, depends
> on what RSS decided) when processing the socket resulted in high
> latency as well. This is not the case today (due to some nics back =
then
> that surfaced various issues with this) but it may be come back in
> the future again (if shown to provide value).
>=20
> - Also today when there is a sync network send from .queue_rq path,
> it is only executed when the running cpu =3D=3D queue->io_cpu, to =
avoid high
> contention. My concern is that if the io context is not bound to
> a specific cpu, it may create heavier contention on queue =
serialization.
> Today there are at most 2 contexts that compete, io context (triggered =
from network rx or scheduled in the submission path) and .queue_rq sync
> network send path. I'd prefer to not have to introduce more contention =
with increasing number of threads accessing an nvme controller.
>=20
> Having said that, I don't think there is a fundamental issue with
> using queue_work, or queue_work_node(cur_cpu) or
> queue_work_node(netdev_home_cpu), if that does not introduce
> additional latency in the common cases. Although having io threads
> bounce around is going to regress users that use RFS/aRFS...



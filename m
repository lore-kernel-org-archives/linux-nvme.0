Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB357ED7B87
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJAQ52iaRqlr3zBK7T2k8HaLTx9fGu9A3J3vlybMSyg=; b=tjtfcOCYJzn7LIJAbGCqXfa8Ip
	64Cve1H0fQLl2F1Hv+gHTPvoXk8CrXx9vC922hHjPpwcHL0Ut5ThIZpXMSSckgjk+KX7OCRdtoGNG
	ji4xa4sJxmHSMB+He9rniOvBMmdu84+S8uWOrA3WAf09+dBHnoCq1aqGFlrFrgtAvYg08YB8mCLy2
	duhioyaDjsT23OuJy2JxotpcWj2hf8QUbrydF+Ye2B793VJPqRuuoClvyLPFVuI+0iAG8B2m6GH/V
	pnEgimc79TpQTadYLDHhJ2DSXGTiBnUmSLscfPiodafBIMeTok07cKP2DW5ZFHCK802aNanjySEjV
	RuNACwaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYn4-0000000GwSn-0rMX;
	Tue, 14 Apr 2026 08:06:34 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCIwr-0000000FwK0-34mz
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 15:11:39 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-483487335c2so49967465e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Apr 2026 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776093096; x=1776697896; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJAQ52iaRqlr3zBK7T2k8HaLTx9fGu9A3J3vlybMSyg=;
        b=k6ODZ+aguAAPfrUU9BpAoajwK5BYD4+UhvVejuWcZdPIHChlT+ovyZKetfY1ilBzit
         Z9k6dJ5agMImAw9HPgGYxhTreu5ZNXZF4HetV62H+IlWKh20oMudzFfgzwWTKjyqIAbd
         JT7od9wari6b1UA/nD1Nco73EReaAKiJeBWRGWCQpJYuYodi7GabBVSoOpKPp4ETDk62
         FleYjZS17vkrEvNYOHrDEICd50pUEte06ZxoVcrR6KsLR0wYZENJJYtoabX3dFhlyXQU
         j78a4uEfcvI8XLhdxorHD1Tzkr2haQn8AtGvAF7YTqqNjAv1oHRmovaiQWtlf91bcoa1
         ObQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776093096; x=1776697896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJAQ52iaRqlr3zBK7T2k8HaLTx9fGu9A3J3vlybMSyg=;
        b=eWjBF53qP96nP+KydVOImL6hkTjLV7LTyUD5KS3hsn8w3onsWqTNtCdfUAhD5oENKd
         y18rBO50qI0UryC7n8VyDjACSQgHC6RlU/wvYufH/b0r/CrDYjgWTBts2O/zVYjYjutZ
         Ka0uE3HKKIFs7OMC64zTR6DzTl3VoSF2GMaJ3RTeo6p8dFVGznAEZ85YmpwRDVlEL+T+
         sXiYMMl3aCpUPTTbB0uJseyHJoUmu1vOSJ1JUbEk1DN+cuAuXQFfPa0zKn4XdGiBI0TD
         sAPSQg4neslEbsDFsT0iBSOZ+ixRcH8zNNI5EntqsJt+tczOyxcKYeKO7kFkujuYqamk
         lB1A==
X-Forwarded-Encrypted: i=1; AFNElJ9fs39xv0vfbiQfXerw+rtr7vxs5wIPIMPZgrbz5SsaR5W1I37gTu8Fj7rlWdIr4Oro9wXsg1RWXmMB@lists.infradead.org
X-Gm-Message-State: AOJu0YyWrpB1cZ/zwn1209+BHpWI0z7NRZCMeK0IEj5KYU98wQvxS2ej
	zyX0JZQr+s0I3YU2vAAT3otGaKPIT7XHF1VwAZootbeTjJ8o5wE0BVVy
X-Gm-Gg: AeBDieuLRrHz3Z/d/DHYVXgC+PG2wkCOiFcBtAKy5yAJDdGbqAP3UXKRP+QcOcHRzbZ
	pnr4MplC0Eqh0lrycyeIsnKxtUkA0KmyqMLyQlhzenyojcMfkJYIW6PpO/hBJnsYqCeGYyEg3jW
	p+dDM7Cu8igqk8Xc2kypCHrmeVPUnN6e7mBog7JPmb/6FXmO88W8/Ht5kTVn3J1/v1qvvc7l6l6
	ywchqHsTZ6za1/BuG7yVsIrQQ/9j/OsO3oXaEG8bERpXBN6oJyP05EbjhPSH49AtG0cxn7djYvc
	S4pBXCogOext0aXVCqrCUuAqzBoJcxzEupHUWve6feZryMjDoVAs0yE2EjExSq+m/0/eiXiuGCK
	J5OIyCgsSZJ/X2UNDF/fCaJS5ygSOAAqRJibuDGDIeuwPGl3CQqwC/+00LUHriuNo3RlnBasDaK
	3mBrIoOIsz1r4cFO50Er3qMGavsxvle2+f45KPaCbmHgwAI5RNE9Nlv/V3GcAbpyFmacV59HlHw
	71pnNJO
X-Received: by 2002:a05:600c:3149:b0:488:ae4e:519c with SMTP id 5b1f17b1804b1-488d683d505mr185844325e9.18.1776093095333;
        Mon, 13 Apr 2026 08:11:35 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5347ea5sm343257025e9.8.2026.04.13.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:11:34 -0700 (PDT)
Date: Mon, 13 Apr 2026 23:11:15 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <ad0Hk48y5JEeMlFk@fedora>
References: <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora>
 <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_081137_815723_11F3EB8A 
X-CRM114-Status: GOOD (  24.24  )
X-Mailman-Approved-At: Tue, 14 Apr 2026 01:06:33 -0700
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

On Sun, Apr 12, 2026 at 06:50:33PM -0400, Aaron Tomlin wrote:
> On Sat, Apr 11, 2026 at 08:52:00PM +0800, Ming Lei wrote:
> > > The critical issue lies at the invocation of group_cpus_evenly(). Without
> > > this patchset, the core logic lacks the necessary constraints to respect
> > > CPU isolation. It is entirely possible, and indeed happens in practice, for
> > > an isolated CPU to be assigned to a CPU mask group.
> > 
> > It is one bug report? No, because it doesn't show any trouble from user
> > viewpoint.
> 
> Hi Ming,
> 
> The lack of a formal bug report does not negate the fact that the current
> behaviour silently breaks the fundamental contract of CPU isolation from
> the administrator's perspective.
> 
> To illustrate the user-visible impact, the following demonstrates the
> difference between relying on isolcpus=managed_irq and isolcpus=io_queue
> under 7.0.0-rc3-00065-gd80965e205a5, which includes this series.
> 
> The Broadcom MPI3 Storage Controller driver allocates a full complement of
> 48 operational queue pairs. Consequently, a number of MSI-X vectors are
> generated and mapped directly onto the isolated cores thereby breaching
> isolation.
> 
>     # uname -r
>     7.0.0-rc3-00065-gd80965e205a5
> 
>     # tr ' ' '\n' < /proc/cmdline | grep isolcpus=
>     isolcpus=managed_irq,domain,2-47
> 
>     # cat /sys/devices/system/cpu/isolated
>     2-47
> 
>     # dmesg | grep -A 6 'MSI-X vectors supported:'
>     [   2.981705] mpi3mr0: MSI-X vectors supported: 128, no of cores: 48,
>     [   2.981705] mpi3mr0: MSI-X vectors requested: 49 poll_queues 0
>     [   3.001915] mpi3mr0: trying to create 48 operational queue pairs
>     [   3.011214] mpi3mr0: allocating operational queues through segmented queues 
>     [   3.101903] mpi3mr0: successfully created 48 operational queue pairs(default/polled) queue = (2/0)
>     [   3.111468] mpi3mr0: controller initialization completed successfully
> 
>     # awk '/mpi3mr0/ { print $1" "$NF }' /proc/interrupts
>     78: mpi3mr0-msix0
>     79: mpi3mr0-msix1
>     80: mpi3mr0-msix2
>     81: mpi3mr0-msix3
>     82: mpi3mr0-msix4
>     83: mpi3mr0-msix5
>     84: mpi3mr0-msix6
>     85: mpi3mr0-msix7
>     86: mpi3mr0-msix8
>     87: mpi3mr0-msix9
>     88: mpi3mr0-msix10
>     89: mpi3mr0-msix11
>     90: mpi3mr0-msix12
>     ...
>     122: mpi3mr0-msix44
>     123: mpi3mr0-msix45
>     124: mpi3mr0-msix46
>     125: mpi3mr0-msix47
>     126: mpi3mr0-msix48
> 
>     # grep -H '' /proc/irq/{119,120,121,122}/{effective,smp}_affinity_list
>     /proc/irq/119/effective_affinity_list:42
>     /proc/irq/119/smp_affinity_list:42
>     /proc/irq/120/effective_affinity_list:43
>     /proc/irq/120/smp_affinity_list:43
>     /proc/irq/121/effective_affinity_list:44
>     /proc/irq/121/smp_affinity_list:44
>     /proc/irq/122/effective_affinity_list:45
>     /proc/irq/122/smp_affinity_list:45

But typical applications aren't supposed to submit IOs from these isolated CPUs, so
in reality, it isn't a big deal.

> 
> 
> Now with isolcpus=io_queue,2-47 the allocation is structurally restricted
> at the source. The driver creates only two operational queues, confining
> all resulting interrupts exclusively to housekeeping CPUs (0 and 1):
> 
>     # uname -r
>     7.0.0-rc3-00065-gd80965e205a5
> 
>     # tr ' ' '\n' < /proc/cmdline | grep isolcpus=
>     isolcpus=io_queue,domain,2-47
> 
>     # cat /sys/devices/system/cpu/isolated
>     2-47
> 
>     # dmesg | grep -A 6 'MSI-X vectors supported:'
>     [   3.284850] mpi3mr0: MSI-X vectors supported: 128, no of cores: 48,
>     [   3.284851] mpi3mr0: MSI-X vectors requested: 49 poll_queues 0
>     [   3.305492] mpi3mr0: allocated vectors (3) are less than configured (49)
>     [   3.316528] mpi3mr0: trying to create 2 operational queue pairs
>     [   3.328013] mpi3mr0: allocating operational queues through segmented queues
>     [   3.340697] mpi3mr0: successfully created 2 operational queue pairs(default/polled) queue = (2/0)
>     [   3.350664] mpi3mr0: controller initialization completed successfully
> 
>     # awk '/mpi3mr0/ { print $1" "$NF }' /proc/interrupts
>     79: mpi3mr0-msix0
>     80: mpi3mr0-msix1
>     81: mpi3mr0-msix2
> 
>     # grep -H '' /proc/irq/{79,80,81}/{effective,smp}_affinity_list
>     /proc/irq/79/effective_affinity_list:1
>     /proc/irq/79/smp_affinity_list:1
>     /proc/irq/80/effective_affinity_list:1
>     /proc/irq/80/smp_affinity_list:1
>     /proc/irq/81/effective_affinity_list:0
>     /proc/irq/81/smp_affinity_list:0
> 
> > Sebastian explains/shows how "isolcpus=managed_irq" works perfectly in the
> > following link:
> > 
> > https://lore.kernel.org/all/20260401110232.ET5RxZfl@linutronix.de/
> > 
> > You have reviewed it...
> > 
> > What matters is that IO won't interrupt isolated CPU.
> 
> The isolcpus=managed_irq acts as a "best effort" avoidance algorithm rather
> than a strict, unbreakable constraint. This is indicated in the proposed
> changes to Documentation/core-api/irq/managed_irq.rst [1].

Yes, it is "best effort", but isolated cpu is only take as effective CPU
for the hw queue's irq iff all others are offline. Which is just fine for typical
use cases, in which IO isn't submitted from isolated CPU.



Thanks, 
Ming


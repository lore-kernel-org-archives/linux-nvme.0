Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935A6EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=; b=3/yq1fLfqxxyYRbCAF7ReY/F3i
	cSBdfZoVVuE5A21GzY1B1XfOD39kQBf20WbDW8+1zhZa0e7J93foT4kgLFVZ9X68dlQVWz2U9ya3B
	S6Jk2DcDG4sdFaAicFjRA7V8DyVWbDoHqJ2HvV6zeYV0h3P4DQIB08crsCMHAhXL//9gTOXX03hQQ
	SbjiG+SAjW3CItfI+mjwIz5lMBG0yDpOw9O2iz228xacp3I14V205i4T2+3+3/oZcQ2FBe5lLra6V
	36uDOW8V1+8FhUcPNQdWzJxOLFc4G8gtAfvH4w7PwH+eS8NcADLONIL+3V/+hShBWP8X7JTFGe4dV
	VfhVNWDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4TP-00DXoc-20;
	Tue, 11 Jul 2023 03:55:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4TL-00DXm8-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 03:55:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689047730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=;
	b=NktYc3ri/Dy6INM6p66UKgNN1rCeprS9+lXShs9PGxZupu1m+xC3u+ktJVeHi2bBIQpdse
	GDu2c/ewIE8ZQIo5LsoQHUY6bvA0HsDHb7SIgTZTOJTJA1++ITutdMdhQYYGGhW6KZie5q
	sr6ImHRkGIYes2/51yLZp8ne/plngyo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-PUIQrIorMsK3CfRsAXHmiQ-1; Mon, 10 Jul 2023 23:55:27 -0400
X-MC-Unique: PUIQrIorMsK3CfRsAXHmiQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635a3b9d24eso42435426d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 20:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047726; x=1691639726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=;
        b=bRU/YDzXAyw/OtA7E1bV+JzrHqNVsg2iKZLhPG3k0wX5Pc52gnq7H2EkmHQlATuLpJ
         NMUjiAJMoPNgvZ+SGdJltU55EocaBRFuXNNsulpO88Yq0ZCofYxQsgHBG4aZx7xyJKMq
         2uei1RtCYrJ/wtm+32Lz1NpKviVV/CuZ2pGItXzgakCaWko6eirABHqC5I7Ecegd9r3h
         DzscRAK467SlxnRJkzbCU/Jt8kMVnsunKV8WG03q47jTnt9OA4IO31yiEh0Ol0F9QCyR
         q4UMc/+hePD7pBeD+iDRkGZMM1Wnt7ST+Nl0MiMmm26SOmcn24MO56s3V8Ju2fdvRTUu
         XcbQ==
X-Gm-Message-State: ABy/qLY4CA+5WcWB+uGtoAbzm+Atrksz1aYLl1kIPV3H37yb70cuxLOG
	WIlI1+FD7BNIQWduAvAQ73j2g/GYfgspXOFbzVPInaarManccEDrSPyam7NlEk2wsrMID85uVEs
	mZR1LhgYlohuZLogjUq6MZFidlLUiUiOn8iZ8vfq+Kag=
X-Received: by 2002:a0c:8d45:0:b0:62f:ec76:f5b7 with SMTP id s5-20020a0c8d45000000b0062fec76f5b7mr11891452qvb.55.1689047726710;
        Mon, 10 Jul 2023 20:55:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTZhew2EUuIm724AKpM7YWVbIe48FZcuO2pasYKl7L1r04MF0dNfYfUrZnlan7BYQ6w00L0ejYouJH3uMuKwg=
X-Received: by 2002:a0c:8d45:0:b0:62f:ec76:f5b7 with SMTP id
 s5-20020a0c8d45000000b0062fec76f5b7mr11891446qvb.55.1689047726501; Mon, 10
 Jul 2023 20:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 11 Jul 2023 11:55:15 +0800
Message-ID: <CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, 
	Thomas Gleixner <tglx@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_205531_287074_4B640F5C 
X-CRM114-Status: GOOD (  21.40  )
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

On Mon, Jul 10, 2023 at 5:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > >
> > > Fix wrong queue mapping in case of kdump kernel.
> > >
> > > On arm and ppc64, 'maxcpus=3D1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> >
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
>

In fact, num_possible_cpus is not broken.

Quote from admin-guide/kernel-parameters.txt
       maxcpus=3D        [SMP] Maximum number of processors that an SMP ker=
nel
                       will bring up during bootup.  maxcpus=3Dn : n >=3D 0=
 limits
                       the kernel to bring up 'n' processors. Surely after
                       bootup you can bring up the other plugged cpu
by executing
                       "echo 1 > /sys/devices/system/cpu/cpuX/online".
So maxcpus
                       only takes effect during system bootup.
                       While n=3D0 is a special case, it is equivalent to "=
nosmp",
                       which also disables the IO APIC.

Here, as it explained, maxcpus only affects the bootup, later, extra
cpus can be online.

> That is documented in Documentation/admin-guide/kdump/kdump.rst.
>
> On arm and ppc64, 'maxcpus=3D1' is passed for kdump kernel, and "maxcpu=
=3D1"

On aarch64 and x86, nr_cpus=3D1 is used, while on ppc64, due to the
implementation, nr_cpus=3D1 can not be supported.


Thanks,

Pingfan

> simply keep one of CPU cores as online, and others as offline.
>
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=3D1' for
> kdump kernel.
>
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
>
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.
>
>
> Thanks,
> Ming
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



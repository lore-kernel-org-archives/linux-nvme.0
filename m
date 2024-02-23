Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418C6C48BC4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+EMzYo1BO0r2RRBivUJGcUDKfwUztImznrl1tit1yF0=; b=vP/5JPMbC9D+0m5lUMxVGfNK8D
	FzIOY1CF7EyJihbZVxoTnQGhiQDc0KvEQ/EcxayrqFbXl1Si/Tfl5kmJuGDkRpbXOSkIZYZYFpchb
	YAsNHJz7/jdMa8AaiFkN+h+lAyM5Q5gl5fsF+wC+d0hWG/GZM3Zml6G8GHbNTjXtgd/DYqKssnd8O
	LYDS453t9p2U0u4xI12ipImsTtpNCKBtPSkUGn+8A4sZVIqK2I2/MjRnS9FtMdkvEuf0+rsTWuxSU
	G24nF3E7kWf1oPAKik8i23zr20zqNrcIKGcrMNZ06KkJRlfgrZCTypdkSMkSQHfVSlbPSHiAWSq0e
	L/iJLauA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPNE-00000008DWm-3PZ0;
	Fri, 23 Feb 2024 06:49:32 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOH0-000000081iI-2ueP
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 05:39:09 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-512dfa097b1so666592e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Feb 2024 21:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708666722; x=1709271522; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+EMzYo1BO0r2RRBivUJGcUDKfwUztImznrl1tit1yF0=;
        b=MBV+jsoeLIhsov2Or/2jDf0zx39qcc/CaFY2tCNlSbq7aqQ11jWMqx1XuPAOODih/k
         14C4qTQStjlEvnSsEi/szichviWR/2+5DyDz3d300nFtjKQKa76vcLfFAsOA0Ijxs7KZ
         RXyiz6aeyp/7VeGAwoA6zE3N8ajYWh06U1kg2HPlJdSUTCvYVChdoCfMo6+4076bebpx
         has/ynjsofCxvJOSjlYZo8beZ8olUFqr9ka/5dzou72ZQXYfZ+jJDphyKKgcV1f4a0L9
         bhEjjFRDacZwA8UyV1zy2pxxFJs+vJK7oYv0ElJoAcAsjZyxs3ZDpw5RTG7u8r5+ctCT
         yGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708666722; x=1709271522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EMzYo1BO0r2RRBivUJGcUDKfwUztImznrl1tit1yF0=;
        b=hVu0QbmcorTvjpdoIMgVsP+DQgw361z9n4nZY7mtaYSEYPeG2GANa9qnN1gSyYPU6V
         7HsLmR5gVgLM6J3iraUvGqR/PzXNqpHJnyg+sbNvitv84nLg/n2RAz1zz4q2eN6NnrBH
         Es6jyFYvWWk2oh0Rp7SlPbZMaFL0IRDUmGsKqO+5iknDkJap8+9O6vN/iX8Hv27lp9fj
         RERfIk68r1I7k4tnxPQG2Lw6CkBceyyrDnZr/SFCjUEGFA6zNUAclJp6LQVS+nO7PHce
         mcbzv9t7ozSTWBL9u4wTbGIUuTmNV+ytLGHhUpirTjjgyhf8lyPgA7ibmoMTjZH5v18T
         ZpzA==
X-Forwarded-Encrypted: i=1; AJvYcCXi9oOxmLOQ+mpoyFCc/zx5/iHfjEWksow3S0aL9BkulgzyZQI5ydUe7A02MZnIPaklVq7fU3+VnwcAfh0KgdihXp2+doaCvJDMVrDKjZ4=
X-Gm-Message-State: AOJu0Yx6b8D647mvLuhOV9iKFUunBo1ma2w5q4rdWFb78S2dzvR1t3Zj
	1MYnYlaPlvrTyPelM3DlapTYdeCjroPEEYE5R03lJVARmolEeN9RRIP5AMlfChp/bPwRJtIc9Qq
	RP0cTG2LWXZV2yKDIb7VGG422QIhZQxRJaSM=
X-Google-Smtp-Source: AGHT+IFGHfyJI1sBt/b15+tGlqfwTBtPNLLcqirGAZK55Mb2nyasjg/jaJknpyFltfazJfHmiiCWepGt+aSLFzMGNbU=
X-Received: by 2002:a19:6556:0:b0:512:b25a:dfdb with SMTP id
 c22-20020a196556000000b00512b25adfdbmr653779lfj.27.1708666722362; Thu, 22 Feb
 2024 21:38:42 -0800 (PST)
MIME-Version: 1.0
References: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
 <53d746b8-a24e-45ac-ab70-c0a0cae6f4eb@kernel.org>
In-Reply-To: <53d746b8-a24e-45ac-ab70-c0a0cae6f4eb@kernel.org>
From: Jaehoon Shim <jmattshim@gmail.com>
Date: Fri, 23 Feb 2024 14:38:30 +0900
Message-ID: <CABj8Ayh4Wmkv2t=+sBhu_L9UVkZzBGY_RE-1J5y-e7jTXkwV=g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Adding NVMeVirt to Kernel mainline
To: Damien Le Moal <dlemoal@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_213908_176708_8EC93949 
X-CRM114-Status: GOOD (  21.91  )
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

On Thu, 22 Feb 2024 at 16:10, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2/22/24 10:38, Jaehoon Shim wrote:
> > Hi all,
> >
> > My research group has recently introduced NVMeVirt, a software-defined
> > virtual NVMe device implemented as a Linux kernel module. Upon
> > loading, NVMeVirt emulates an NVMe device that is recognized by the
> > host as a native PCIe device.
> > - https://github.com/snu-csl/nvmevirt
> > - https://www.usenix.org/system/files/fast23-kim.pdf
> >
> > Advantages of NVMeVirt are:
> > - Deployable in real environments (not virtual)
> > - PCI peer-to-peer DMA support
> > - Low-latency device support
> > - Multiple namespace support (each namespace can support different command sets)
> > - Multiple device support
> > - Various command set support (currently supporting ZNS and KV)
> > - Accurate performance emulation
> >
> > What if we can simplify NVMeVirt and add it to the Kernel mainline
> > just like the scsi_debug in the SCSI driver? This would offer an
> > accessible tool for developers, especially when NVMe devices with
> > specific spec are unavailable, to develop and debug the NVMe driver
> > functionalities.
>
> Qemu emulates nvme devices fairly well already.
>
> What is the backing store for you kernel module nvme emulation ? Memory only ?
> files or block device ? If it is the latter, how can you do "Accurate
> performance emulation". And what does "Accurate performance emulation" mean
> anyway ? Different NVMe drives from the same or different vendors have different
> performance characteristics. So what exactly are you emulating here ?
>
> >
> > Best regards,
> > Jaehoon
> >
>
> --
> Damien Le Moal
> Western Digital Research
>

During our evaluation, we have found out it is hard to emulate
low-latency SSDs using FEMU due to virtualization overhead.
Also, it is hard for FEMU to communicate with other real PCIe devices
(e.g., FPGA, GPU, NIC) on the host system.

NVMeVirt's backing store is kernel memory similar to SCSI_DEBUG.
A physical memory range needs to be reserved for NVMeVirt.

The accurate performance emulation means that current NVMeVirt
supports NAND flash SSD FTL performance model just like FEMU. It has a
page-mapping based FTL inside.
However, we support much more features of real SSD FTLs that other
emulators doesn't, such as write buffer, one-shot programing, multiple
FTL instances, etc.

In our research, we have emulated Samsung 970 Pro and Intel Optane SSDs.

We believe that NVMeVirt can open more opportunities to developers
regarding such advantages.


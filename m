Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB42C54E4A
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 14:02:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9E3206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 14:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eox4yIAZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensdev-com.20150623.gappssmtp.com header.i=@opensdev-com.20150623.gappssmtp.com header.b="Nw7TltX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9E3206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensdev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0VTWZJyGXitaNzzzMfEQIbX9lKgm2n3W1xhyKrdXzn4=; b=eox4yIAZSjAExg
	Tyc9H4tEW2xRuJ4m+xbg7nNgUh5wGpf5Vm2hL7fbTeON9/ixSURFkqryaeyPRkVyTm/fwOkhFigO2
	fpHjgEr1GZajNCV6kopKeZ5/IRNAn15Kks9zRfIhryaPZCGIELI6CXjpjPn2beDIZVoreb7NjqIJl
	9HuZVx5Y8X3Bgq7xn9WqCLwxVf4tNwXIHZ6i8NTtxJ+su0eluWffRLp9hBd8LGJLsdbmVwvwO7Vxt
	xM/sSoAFbfi8iAMAYBuDXQ9uejROUc5kfSNYVAxbO6w6ac/ZDmCcsRHYZjzF8yRwrUgj5uWNj9oER
	bC78VmZ1ct2TU1oU2nmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYVTy-0000EA-7m; Tue, 12 May 2020 14:02:06 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYVTt-0000Bo-NF
 for linux-nvme@lists.infradead.org; Tue, 12 May 2020 14:02:03 +0000
Received: by mail-qv1-xf33.google.com with SMTP id t8so5932362qvw.5
 for <linux-nvme@lists.infradead.org>; Tue, 12 May 2020 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opensdev-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IYjbch5+Kv4HFAUovo/fGOYci2Gi9cKRjAV61QhStiQ=;
 b=Nw7TltX14q62AgdCaC3ox9e8qdz5kymU9hcPKCHHdLjxWYpwbxPxtFfAT1zAMcuh2R
 IkG8+Vm1D8QTrCEbukq1374c9eGmqwTzGpsUcE+YcvWF5oiijApz9Ela+armlmUyDh87
 2wwGLe8z842yJwqNfEz9VY57kOC+phVqxIuBHKncfBPvEbr6W0rfh1BpbPYzWsX83pLm
 dR45d0s7AECOTzy9Knw8Da2V1HOLcUFDJs9YL4PyqJvf5SxSggPjz0C+dUGflWSeUugB
 zE9RHb6FPNZn4TRssIqr/KnG+uksIq0Hm89cFImkdKEx5M4U6GhcWdefFQpLK+1lZy+l
 ykoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IYjbch5+Kv4HFAUovo/fGOYci2Gi9cKRjAV61QhStiQ=;
 b=lcaBSVtXRtNxixvxOUK/MyR02YaoSu/Xp4N8YCJQdGS41sWKvLRJ8QAKJvjvR9VMes
 IhvBij5hwOVKdaLnW3ofTm+tAsX3h7mFExDXYtgQ/AurCnRveQ0H1+hRS4FwBwrf3+L4
 NmE+uzSbdAyOvXaU0ybvh9YbWTQgJM0jLofUPcH8IQtyaqBBDXhS7oSYCzT8ZWEiAcl+
 sofKvmO+XD86jjIZF7wI9gPSn69iu+yccQaYJG31O2kAdf8uYrr+j2+oyH86fh6LMyLY
 /GXwEwqqaEDWhrJcn6c6INwuJRPf8K0d4jOSGltfbENXLBY3lW2xaJ2VQM8ugdrWpRzM
 pfvw==
X-Gm-Message-State: AOAM531DIH0FkxP6mTeDCPSMTELkSjlCWScd79dgJpq3RvByhUrb+n1f
 I/3YiCM7guHgfszDqgNTrNKLKizNl0kEOf/BTRV9Q7thFLM=
X-Google-Smtp-Source: ABdhPJxYp8+Jy8NDCEnFmGFsvRxd7VTYHim2E7fkDM9P+isZXyKL1BCDohpIEbGx1LBgs7jSqPhZyQQ23DKJ7piopYA=
X-Received: by 2002:a05:6214:1548:: with SMTP id
 t8mr1358773qvw.248.1589292114977; 
 Tue, 12 May 2020 07:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGkZ3m9UE_T2RDM=TLTERopuA+AjHenH_9AkTYF8f5R52W5_FQ@mail.gmail.com>
 <CGME20200512092744epcas2p26a9b41de4da7f44c507cabd85919f4bf@epcms2p1>
 <20200512093828epcms2p49d1f8de8cfd77c6edff7cde47113896c@epcms2p4>
 <20200512094651epcms2p1afe65ce9247f92dfffc0e1f755a68405@epcms2p1>
In-Reply-To: <20200512094651epcms2p1afe65ce9247f92dfffc0e1f755a68405@epcms2p1>
From: Shivamurthy Shastri <shivamurthy.shastri@opensdev.com>
Date: Tue, 12 May 2020 16:01:18 +0200
Message-ID: <CA+rQJkKSZwBOVGO3O5XunBXTuhcnMrtqN9ysu-zAsUghjRCwoQ@mail.gmail.com>
Subject: Re: Problems in Samsung PM1733 SRIOV
To: rajend.singh@samsung.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200512_070201_808887_7F329F72 
X-CRM114-Status: GOOD (  16.07  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Peter Walker <peter.walker9520@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello Rajendra,

Thanks for the reply.

On Tue, May 12, 2020 at 11:47 AM Rajendra Singh
<rajend.singh@samsung.com> wrote:
>
> Hi Peter,
>
> PM1733 supports Virtualization Management as described in NVMe spec  (8.5 Virtualization Enhancements (Optional)).
> Hence to be able to use Virtual Fuction NVMe controllers you will first have to assign resources to the controller and then make the controller online. You can use nvme cli to send virtualization management commands.
>
> steps:
> 1) echo 0 > /sys/bus/pci/device/${bdf_pf}/sriov_drivers_autoprobe
> 2) echo${bdf_vf} > /sys/bus/pci/drivers/nvme/unbind

After step 2, I am unable to execute further steps

# echo 3 > /sys/bus/pci/devices/0000\:03\:00.0/sriov_numvfs
-bash: echo: write error: No such file or directory

> 3) echo 3 > /sys/bus/pci/devices/${bdf_pf}/sriov_numvfs
> 4) nvme admin-passthru/dev/nvme0 --opcode=0x1C --cdw10=0x10008 --cdw11=2
> 5) nvme admin-passthru/dev/nvme0 --opcode=0x1C --cdw10=0x10108 --cdw11=2
> 6) echo 1 > /sys/bus/pci/devices/${bdf_vf}/reset
> 7) nvme admin-passthru/dev/nvme0 --opcode=0x1C --cdw10=0x10009 --cdw11=0
> 8) echo 1 > /sys/bus/pci/device/${bdf_pf}/sriov_drivers_autoprobe
> 9) echo${bdf_vf} > /sys/bus/pci/drivers/nvme/bind
>
> Hope this helps !
>
> Thanks,
> ::Rajendra;
>
>
> --------- Original Message ---------
> Sender : Peter Walker <peter.walker9520@gmail.com>
> Date : 2020-05-12 18:27 (GMT+9)
> Title : Problems in Samsung PM1733 SRIOV
>
> Hello All,
>
> I am using Samsung PM1733 and testing the SRIOV feature of the device.
> There were some problems while enabling VFs.
>
> dmesg logs while booting system are as follows:
>
> # dmesg | grep nvme
> [    1.471488] nvme nvme0: pci function 0000:2d:00.0
> [    1.685264] nvme nvme0: Shutdown timeout set to 10 seconds
> [    1.694565] nvme nvme0: 8/0/0 default/read/poll queues
> [    1.695383] nvme0n1: detected capacity change from 0 to
> 214748364800
>
> # dmesg | grep "0000:2d:00.0"
> [    0.326083] pci 0000:2d:00.0: [144d:a824] type 00 class 0x010802
> [    0.326105] pci 0000:2d:00.0: reg 0x10: [mem 0xe1000000-0xe1007fff 64bit]
> [    0.326134] pci 0000:2d:00.0: reg 0x30: [mem 0xffff0000-0xffffffff
> pref]
> [    0.326368] pci 0000:2d:00.0: reg 0x20c: [mem 0x00000000-0x00007fff
> 64bit]
> [    0.326370] pci 0000:2d:00.0: VF(n) BAR0 space: [mem
> 0x00000000-0x000fffff 64bit] (contains BAR0 for 32 VFs)
> [    0.326517] pci 0000:2d:00.0: 31.504 Gb/s available PCIe bandwidth,
> limited by 8 GT/s x4 link at 0000:2c:00.0 (capable of 63.012 Gb/s with
> 16 GT/s x4 link)
> [    0.348295] pci 0000:2d:00.0: can't claim BAR 6 [mem
> 0xffff0000-0xffffffff pref]: no compatible bridge window
> [    0.348542] pci 0000:2d:00.0: BAR 6: assigned [mem
> 0xe1010000-0xe101ffff pref]
> [    0.348545] pci 0000:2d:00.0: BAR 7: no space for [mem size 0x00100000 64bit]
> [    0.348546] pci 0000:2d:00.0: BAR 7: failed to assign [mem size
> 0x00100000 64bit]
> [    0.348581] pci 0000:2d:00.0: BAR 6: assigned [mem
> 0xe1200000-0xe120ffff pref]
> [    0.348583] pci 0000:2d:00.0: BAR 0: assigned [mem
> 0xe1210000-0xe1217fff 64bit]
> [    0.348590] pci 0000:2d:00.0: BAR 7: assigned [mem
> 0xe1218000-0xe1317fff 64bit]
> [    0.490257] pci 0000:2d:00.0: Adding to iommu group 36
> [    1.471488] nvme nvme0: pci function 0000:2d:00.0
>
>
> Then I am enabling VFs with the below command:
>
> # echo 3 > /sys/bus/pci/devices/0000\:2d\:00.0/sriov_numvfs
>
> Then, the kernel tries to initialize the 3 new nvme VF devices (i.e.,
> /dev/nvme1, /dev/nvm2 and /dev/nvme3).
> However, initialization aborted with the below message.
>
> # dmesg
> [  200.776161] pci 0000:2d:00.1: [144d:a824] type 00 class 0x010802
> [  200.776785] pci 0000:2d:00.1: Adding to iommu group 37
> [  200.777073] nvme nvme1: pci function 0000:2d:00.1
> [  200.777149] nvme 0000:2d:00.1: enabling device (0000 -> 0002)
> [  200.777204] pci 0000:2d:00.2: [144d:a824] type 00 class 0x010802
> [  200.778805] pci 0000:2d:00.2: Adding to iommu group 38
> [  200.779193] nvme nvme2: pci function 0000:2d:00.2
> [  200.779224] nvme 0000:2d:00.2: enabling device (0000 -> 0002)
> [  200.779284] pci 0000:2d:00.3: [144d:a824] type 00 class 0x010802
> [  200.780146] pci 0000:2d:00.3: Adding to iommu group 39
> [  200.780430] nvme nvme3: pci function 0000:2d:00.3
> [  200.780460] nvme 0000:2d:00.3: enabling device (0000 -> 0002)
> [  231.336804] nvme nvme1: Device not ready; aborting initialisation
> [  231.336807] nvme nvme2: Device not ready; aborting initialisation
> [  231.336812] nvme nvme2: Removing after probe failure status: -19
> [  231.336828] nvme nvme1: Removing after probe failure status: -19
> [  231.344759] nvme nvme3: Device not ready; aborting initialisation
> [  231.344778] nvme nvme3: Removing after probe failure status: -19
>
> Please let me know if I am missing something while enabling VFs here.
>
> Thanks,
> Peter
>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> https://protect2.fireeye.com/url?k=80d23016-dd0238da-80d3bb59-000babff3793-6c678424a2515ee1&q=1&u=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme
>
>
>
>
>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Thanks,
Shiva

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

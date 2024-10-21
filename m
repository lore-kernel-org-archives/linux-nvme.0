Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96526D17129
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:In-Reply-To:References:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2GVCppwJPW/3fej0GoZi9mGivzxigOusl3CHD2WD+4=; b=b7imJcKlKZGwJHZJbZKCBRv0jf
	NqZtS7TcRS6TbWdIiByK5CUeSndy/ri1DXxzzq/g2Eio0bHi2j6jl9zP7/Z4+CPUgZQPlEeJQrPop
	moWIPuJvPCTpmPZHSPhiRAg03h0FpLmQeZQS95Z1FZhjpcuQhf5/iTLJoh/LybItQ/M8jW50Vbctl
	gjvIz6dm9o6ke1VZX8yqoFfRDX1JZgPKq8bS3X75+79xV1FIgSBqDGbSuid0rKS1Cwxau2rHYhO1z
	C+njQHnGrsQWyZkEcW3EK+uCt07Fm3gfMzLL9FGuBOtZ+usoIUBjYDzkO4KjxXFgMt9wtfawHQnO0
	GNTC3OUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2y9D-00000008RuE-0hoG;
	Mon, 21 Oct 2024 19:32:59 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2y9A-00000008Rsy-1T1p
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 19:32:57 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so32680956d6.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1729539174; x=1730143974; darn=lists.infradead.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2GVCppwJPW/3fej0GoZi9mGivzxigOusl3CHD2WD+4=;
        b=U9Wt42XAIDicp+NGldxMZjlYbLSpiIe9bCYhwyaphpPrSl+VamhQOyUHGHOF6k067G
         DkXCvB69er2ML6r2mdwyYCF51xkefw4QV/4KMw0bgEmtZn52lAkHBoOQBwfeV2Wmtna0
         R0ziqfKoshv2lcLKqZyyoP6FOuIrWV9EqurXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539174; x=1730143974;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2GVCppwJPW/3fej0GoZi9mGivzxigOusl3CHD2WD+4=;
        b=WSIJ+9GxKDGvIz/TsvXfuUt9JV855A9+zMKL+WYpkHB6sIEVduEfL3NBlrFJw1rQ+B
         LSzY5NhteOTlJ26VyP2z2A13t+BpFaJ0Z1JAsqrvcOG3Uk+zFKORvzdNnzwLQCP4lfJN
         7Vg7R8ODG3+4HK5SZWpFTu9LH6O3+6bfLPvZgD1tSyppi1zhAbxTPgwVTCeOiRDEibpl
         McWBf2yN2YJKDMNgwc4QSqpuCpZ1a2fEHDGEqM4qPZt0XHGJ20sWDw0Lq3Q7Es/IND5N
         Z9jxu38BlcWPLJG66YL2zbfnbhsyxW1tIxeWmwNruU2Vpbnj5aW8YUKYitQALnXoJFj1
         QL0w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Uoh1D4mtIV7n7axyvULtEVUh9M+2oQYLLsp2noj7RwpblYWmlmK8aXlMlGDXE8iiTN1hPdQFXdUW@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/96op7gurSwe8/UQNkYO8XadlOVKz1RfrSJMFZ8cTWsDeTC32
	TsMwPhy7efVcW8+WLbFToOYtGHoqe6V2dAAGiFFmu09Xi3QAtSSSG9zMAVRBwCI=
X-Google-Smtp-Source: AGHT+IFJ3WqDcwIYE7co1JSkBL9YNNro7rq4BjC8xcyxEEpJDeP8WVitGSQTYHW0+4k012/JKdJaEw==
X-Received: by 2002:a05:6214:5785:b0:6cb:3a1f:e47b with SMTP id 6a1803df08f44-6cde163e394mr146391696d6.52.1729539174295;
        Mon, 21 Oct 2024 12:32:54 -0700 (PDT)
Received: from WARPC (pool-96-241-42-78.washdc.fios.verizon.net. [96.241.42.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb113sm20601656d6.34.2024.10.21.12.32.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2024 12:32:53 -0700 (PDT)
From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
References: <CAO9zADza=73GsuzAcuyH-YfhS34qjkDtuJjGBReVGpfE6KN_ow@mail.gmail.com> <20241021191426.GA842491@bhelgaas>
In-Reply-To: <20241021191426.GA842491@bhelgaas>
Subject: RE: 6.1.0-17: nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
Date: Mon, 21 Oct 2024 15:32:52 -0400
Message-ID: <009a01db23f0$053c4240$0fb4c6c0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbLZb6GXTkCANLpCNg8vjWR72cxrGRg5IA
Content-Language: en-us
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_123256_443098_ED4D6A07 
X-CRM114-Status: GOOD (  14.67  )
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



-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org> 
Sent: Monday, October 21, 2024 3:14 PM
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>; linux-nvme@lists.infradead.org
Subject: Re: 6.1.0-17: nvme nvme0: controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0xffff

On Fri, Jan 05, 2024 at 09:49:58AM -0500, Justin Piszcz wrote:
> Hello,
> 
> Distribution: Debian Stable x86-64
> Kernel: 6.1.0-17
> 
> Reporting this as requested from the kernel message, I have now
> appended the recommended kernel boot parameters
> nvme_core.default_ps_max_latency_us=0 pcie_aspm=off and will see if
> this recurs.

Hi Justin, did anything ever come of this report?  Is it reproducible?
Did it seem to be related to suspend/resume?

[ ..] 

> 
> Regards,
> Justin

Yes-- this turned out to be the result of the Intel i9 13900k/14900k known
CPU failure/bug issue.  After working with Intel to replace the failing
i9-14900k with a replacement unit, everything has been rock solid without
any issues yet, running the new 0x12b microcode as of 10/21/2024.  This is
the first time I have seen stack smashing/NVME errors due to a CPU failing
but that is what it was, I have not seen a single instance of this error
after replacing the CPU.

Three is a more detailed account of the issue that I posted here:
https://forum.level1techs.com/t/debian-linux-stable-on-pro-ws-w680-ace-ipmi-
application-segfaults-kernel-panic/212854/8

Regards,
Justin






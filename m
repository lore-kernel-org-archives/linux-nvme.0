Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A588AC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 16:48:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA6A214D8
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jWni3cxv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Imv5vXpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA6A214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OkJwEDZuMAAuwbushJHgQnmCkl9I5GyQOBOQg9Orvd0=; b=jWni3cxvP02Y+PVLXqdoY7+3p
	qHWHK2oU+G06KEBBOUBeCXwfOzwvLMk1AO8DRhWAIMBLOZhSyi0V/v4ySKQfxJyQct3XFEfwZrNrD
	FHq3tHCTlC/8zikCNvWHHLtVi952fzAB/5nH4XS5rCz4MDqZK76+LPtqCx9ypmLN7QU2/Kcra54+P
	J7xEsDzsZWB98p4m4BXovFNOcCamlCy2kC3Z4OtlhjNCAu47ub23wa7AMRtLxzN9XjwArxjuSI4CN
	KHJ7JxrKT2glx4aZmgi95mDYPGPayGBLPxYJpZyl2kpsXMkFiDsnxtMM+ZMFCQQliOBP/ODL7/hNq
	FTRzuMIZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9S5-0005rP-Qf; Tue, 01 Sep 2020 16:48:09 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9Rn-0005hT-Nw; Tue, 01 Sep 2020 16:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598978856;
 bh=iS+KmbY1ndEJSpXJ6ApP71r110vbaj/m88hnuZyQwTA=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=Imv5vXpy1qp/I67L2YJX3mOB/Q5tUGNqvvy+yPjK/PWKC9TxW8eyLmTRbZI54RcFr
 taYlt/lXFj9V+KLfkIFm8WE+tVXu31J/LjSFRKcGCqbrwKufPkbrG8PFFgaAsD0L86
 8AdCJVk5LuNz0ro3JE7+3PFQDRI2svn2BRheLeXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1kzdF62DEe-00mXqh; Tue, 01
 Sep 2020 18:41:16 +0200
Subject: Re: [PATCH 07/28] 53c700: improve non-coherent DMA handling
From: Helge Deller <deller@gmx.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-8-hch@lst.de>
 <1598971960.4238.5.camel@HansenPartnership.com>
 <20200901150554.GN14765@casper.infradead.org>
 <1598973776.4238.11.camel@HansenPartnership.com>
 <3369218e-eea4-14e9-15f1-870269e4649d@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <77c9b2b6-bedc-d090-8b23-6ac664df1d1f@gmx.de>
Date: Tue, 1 Sep 2020 18:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3369218e-eea4-14e9-15f1-870269e4649d@gmx.de>
Content-Language: en-US
X-Provags-ID: V03:K1:4Y8gxSC3mimemrR4PtvEKNwyw28FqcRZSkoK2gQkqvo/KOoRbTg
 w40kQskhrNaheI6REKgULCG68Fy6MEYc0KsJy9WRPUH71+WKoerrwaE3EISLn47wt9qPakq
 Z9gMZCEqcjMGAkwuPOCtdfBULoqR2MkqoEWEFsPLv/Ad3iHMpMr0z0ACL6exzE1IUZ+o2Jw
 GUtUnwHdeUzKCJ46isMYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vo/Gto9JtrM=:ORJj6RnqLoHtXBUmlE5sRC
 BD5L9QciGpXTD1pTNIRuo2CfbiqfL1ZzI8DtZ+ZA6EUcUlPX7xTcHImudURPNWFeU2JTMoKvL
 ENvejZ9mnVi6+QBTzj+yUniTVDx6U3B8Dx4ZMfOrk5si6v1a9+P5judvadSHMz/rbnHDrrt32
 83OJRTgP5mXPD3jlB8iu0b7gNpKpleqMba3EnVpuotvydGFmM1xfjCLCiDDERBvk+gYx+NYpL
 i5lOKLEtwqJmyyGZ78+ArgKIblHv6nB/2JgTeLdxNmLFBR/W3EutNmuKBgxMoAZiV4FRLH2im
 d39JkFscnYy+mrVn33easdU2iARkMUzaFEMVTyYtwfzbUm6XA73DBoV8Ou42I9ypqAyO83hvN
 +VMAWmZvYXyq/pyY6kyaklOq3oBe1yjGBeBkhXI3Ooae9cT8/g5Xl67geKIR1ogxDllDj/vcz
 anUHA5DtX8aC+aDWN2iTcXrG+KndlnuQDbaPw9pxEyeDwAmgJOahzFzRr0TkctDxYOe1qKZJ2
 MMepsgtFbxhs0ip3OZIG3b5C11OjgQnOL0z3I4uO/SM+aWVApJNmdti/RYGB5stoeEkAZi984
 h51pZhZcq5fQv+mcE4njZBptlTedeerReELlWLqT92WxHgNxRPyawxyXCL5qIt4xi9UJQM1VN
 Ok1UYq395UPpWbrg5X6mATquh+HVrsR+vvmIgntkgstoxazmBm6El+yLYZhvR91c1ptSsnjpp
 fUWMPoPdKKoYUJPIptIUAu4Da3KdxQPcTUdAVVonaWEAQQfFFbWvlKOVxN6jP7txaQaEci+Po
 xIFd5vdQo5b9X13C3ZAU/4e5TLLnwdSLw7bHJKZiJSixPcL5dgtlysaysHOEHTESTxXf1dcrx
 2tP8ZacvmRJCcrBk29gjFhKheIIfPvApwvuhxZK8nb8PI8nINueBfc3OiOLPLdA4w/wjqxUx4
 WsyBU9YgrEkyQ1g/lOf0tzuhqgxI0izcI1rZjP1Ufxb+2pjLLmZs8pGyMS3h6CJSSnShW18Mf
 XQokFNxZGzSayjCkVq6reFW4f3bcaL1GE/+SrXslnbYzT3NiLoOU1scIAiz0LLV1psKkKtrBL
 ByIFBm0coYNQbiVcu82a5/wV6XSRRe/7KRJOesb8+Uml3pI3dl/AbJ9ftHiPnEW5fOs6NCUjt
 rCPRhW75s9LxQo8475qLagL/BmiOVbMP6XK0IK/93JbHqRxXv8IGGph5fuboQ06L1fYgSqgPK
 1/VX2wVpCCiASBj0a
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_124752_108373_74E62B37 
X-CRM114-Status: GOOD (  18.64  )
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
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 01.09.20 18:21, Helge Deller wrote:
> On 01.09.20 17:22, James Bottomley wrote:
>> On Tue, 2020-09-01 at 16:05 +0100, Matthew Wilcox wrote:
>>> On Tue, Sep 01, 2020 at 07:52:40AM -0700, James Bottomley wrote:
>>>> I think this looks mostly OK, except for one misnamed parameter
>>>> below. Unfortunately, the last non-coherent parisc was the 700
>>>> series and I no longer own a box, so I can't test that part of it
>>>> (I can fire up the C360 to test it on a coherent arch).
>>>
>>> I have a 715/50 that probably hasn't been powered on in 15 years if
>>> you need something that old to test on (I believe the 725/100 uses
>>> the 7100LC and so is coherent).  I'll need to set up a cross-compiler
>>> ...
>>
>> I'm not going to say no to actual testing, but it's going to be a world
>> of pain getting something so old going.  I do have a box of older
>> systems I keep for architectural testing that I need to rummage around
>> in ... I just have a vague memory that my 715 actually caught fire a
>> decade ago and had to be disposed of.
>
> I still have a zoo of machines running for such testing, including a
> 715/64 and two 730.
> I'm going to test this git tree on the 715/64:
> git://git.infradead.org/users/hch/misc.git dma_alloc_pages

This tree boots nicely (up to a command prompt with i82596 nic working):

53c700: Version 2.8 By James.Bottomley@HansenPartnership.com
scsi0: 53c710 rev 2
scsi host0: LASI SCSI 53c700
scsi 0:0:6:0: Direct-Access     QUANTUM  FIREBALL_TM3200S 300X PQ: 0 ANSI: 2
scsi target0:0:6: Beginning Domain Validation
scsi 0:0:6:0: tag#56 Enabling Tag Command Queuing
scsi target0:0:6: asynchronous
scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
scsi target0:0:6: Domain Validation skipping write tests
scsi target0:0:6: Ending Domain Validation
scsi 0:0:6:1: tag#63 Disabling Tag Command Queuing
st: Version 20160209, fixed bufsize 32768, s/g segs 256
sd 0:0:6:0: Power-on or device reset occurred
sd 0:0:6:0: Attached scsi generic sg0 type 0
LASI 82596 driver - Revision: 1.30
Found i82596 at 0xf0107000, IRQ 17
eth0: 82596 at 0xf0107000, 08:00:09:c2:9e:60 IRQ 17.
sd 0:0:6:0: [sda] 6281856 512-byte logical blocks: (3.22 GB/3.00 GiB)
sd 0:0:6:0: [sda] Write Protect is off

Christoph, you may add a
Tested-by: Helge Deller <deller@gmx.de> # parisc
to the series.

Helge

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

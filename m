Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73FCC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:48:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680A464F7C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680A464F7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cKR7sngsAgHljT0YFH0lSQk98UoO5m1d8ytEieH/GOE=; b=3RW+43lMMhWKRlfj/9TIH4HRM
	zaIL5LiZpznaKgFgZIpzD2wcDM6ROXY0our2Me29JjdVjLR1K6zIuoGUBwDDqgDbmuQZIMuA8pWSw
	evXDPJnojRnj/9EapamhkiYjV4hR79EujPCv/caohX9d2+GfSoIZPhmBGd1brff2mfpAXAkmxFXFu
	Ui2zZMdhqsjeAdB17O/ARFOHsjbf90snyMdPHgdqcriJt2irOKKGrOSkIB29hGn7uikaVGq2PQU3u
	Z99TeI5V+ms6e/EAU3b5iLxuEJNEOhGyQ4KWIBs3oLf1nwvE1Q49UQm6bmQiPV3Pttl/gfapbB63P
	4YuzxIWwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7LJz-00036R-Lq; Wed, 03 Feb 2021 16:48:03 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7LJx-000356-F7
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 16:48:02 +0000
Received: by mail-oi1-x236.google.com with SMTP id k142so517557oib.7
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 08:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qZEmNp2ZakxDJznFqcVZ1P80OyQOGPyM6d5UCk5d3vk=;
 b=lrPEG74DOtqh0L7paTBjafFI44X0ikYaEsGMLmHNqbxviTPPH2RmXs68TIGDoMrrC1
 DjwAxBpCyW1/ZZ/A1Mimjxt21m2+NePiopmTdSUrmjhtvyiwZ31SAHWPe++B7SGi6YJV
 dOHc9ig1W+xyZ6263TnU6LVUd8RyDzTwUXkVWh4m0MuUvp7u46NIDMTe1RFSJ03m3QqH
 lhed1HQeGZphcYM/6mCFIxFXlYyKIG4gL4tOl9gr9ChfCJI7lTUqro7G4WXbJDYhRvAW
 tehtMsu6xdSQKpB/mqrFgpd6bs/dy57W3Ay5G60j4GwuamIYASeUDTfiEkTiPdrU6uVR
 yWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qZEmNp2ZakxDJznFqcVZ1P80OyQOGPyM6d5UCk5d3vk=;
 b=pgly/rr2aTaakaomrsicwXxHClhuISAH0TFSNk/m1dwpnWKlDGQqvUUnyU1mJDi08n
 YvL1Fd+5hpR0bkOraxITBeofQXlDyhPO3R5qxNlGuf4Btt/YOtLcgm295nVLbxGYyymp
 KbK8unWRkKqrZh3o4Mq0MzvR7O/J8HHYxjU2JRDc6ymQKuchx7oXSllpq6VvVUwvu2va
 QBopmvm4548yGjlWdp+8CPTTIva9fUZZh7/D7OVHnXevjR0paQhiwJ83NCCfsjonKZ+O
 4Anlz2fdEQ+9pcRe5E9p5GOo6tO1z4HXFnhdDPOjbQdxy1Q+7TtWz9FnN23a6uws9doW
 koDQ==
X-Gm-Message-State: AOAM533dHQOjFC2ePe2fjD/lqSxPVVSKjGbsVqt3ttnlS8QYjzPpNNp7
 xCAtn6ejjLGl4ccAXRQzFj4AWhQgvFgOQJ6oTOQpvg==
X-Google-Smtp-Source: ABdhPJz2RpbhkniHRFTWA/PnemwFxygMLB82C8ofE36DFtyCupwdbGrY9bzMHloCpMlEZy/Z9AXkapfX8D+WwztZi8I=
X-Received: by 2002:aca:b9c1:: with SMTP id j184mr2575743oif.63.1612370877454; 
 Wed, 03 Feb 2021 08:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <20210203133712.GA24674@lst.de>
In-Reply-To: <20210203133712.GA24674@lst.de>
From: Jianxiong Gao <jxgao@google.com>
Date: Wed, 3 Feb 2021 08:47:45 -0800
Message-ID: <CAMGD6P1Ksn4DJ0w=O20Ou7BOKAW9yzwJgRV57xaqLdVDK4ATaQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_114801_544949_109A7539 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>, bgolaszewski@baylibre.com,
 Marc Orr <marcorr@google.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 axboe@fb.com, Erdem Aktas <erdemaktas@google.com>,
 iommu@lists.linux-foundation.org, jroedel@suse.de,
 Keith Busch <kbusch@kernel.org>, dan.j.williams@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>
> Please try with this extra patch:
>
I have tried with the extra patch and it still fails to boot.
I have attached dmesg output for the error:

-------------dmesg starts here-----------------
[    6.357755] XFS (nvme0n1p2): Mounting V5 Filesystem
[    6.430092] XFS (nvme0n1p2): Torn write (CRC failure) detected at
log block 0x20d0. Truncating head block from 0x20e0.
[    6.442828] XFS (nvme0n1p2): Starting recovery (logdev: internal)
[    7.272456] XFS (nvme0n1p2): Ending recovery (logdev: internal)
[    7.610250] systemd-journald[434]: Received SIGTERM from PID 1 (systemd).
...
[   10.054121] systemd[755]:
/usr/lib/systemd/system-generators/systemd-rc-local-generator
terminated by signal ABRT.
[   10.726122] audit: type=1400 audit(1612370261.090:4): avc:  denied
{ search } for  pid=783 comm="systemd-sysctl" name="crash"
dev="nvme0n1p2" ino=50789805
scontext=system_u:system_r:systemd_sysctl_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   10.751764] audit: type=1400 audit(1612370261.090:5): avc:  denied
{ search } for  pid=783 comm="systemd-sysctl" name="crash"
dev="nvme0n1p2" ino=50789805
scontext=system_u:system_r:systemd_sysctl_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.366607] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[   12.376379] audit: type=1400 audit(1612370262.740:6): avc:  denied
{ write } for  pid=788 comm="systemd-remount" name="crash"
dev="nvme0n1p2" ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.413155] systemd-journald[781]: Received request to flush
runtime journal from PID 1
[   12.428917] audit: type=1400 audit(1612370262.793:7): avc:  denied
{ write } for  pid=815 comm="journalctl" name="crash" dev="nvme0n1p2"
ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.453006] audit: type=1400 audit(1612370262.799:8): avc:  denied
{ write } for  pid=817 comm="systemd-random-" name="crash"
dev="nvme0n1p2" ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   13.306030] plymouth[853]: segfault at 0 ip 00007f2eabca8090 sp
00007fffe94d8c08 error 6 in libc-2.28.so[7f2eabbcd000+1b9000]
[   13.318772] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[   78.782418] sed[911]: segfault at 0 ip 00007fc3540da090 sp
00007ffdb4373ff8 error 6 in libc-2.28.so[7fc353fff000+1b9000]
[   78.794007] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
--------------dmesg ends here-----------

-- 
Jianxiong Gao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

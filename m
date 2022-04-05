Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E60C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dtTvKsnbPiz/iEPRO7T9fc0dbhR7Qpouw7hAuHZcwWA=; b=W9VYtebboQSCcQ6BfG62J03tsW
	WP6xvLayRlAez2TyzNTXrT+N5JS7tzr5bVmpuR3BEniSjbPUzsIBuhBSXoGHpOuM0nC2rQsegyd/K
	+ODgHco9pv7Ggk+PS9vla9K4Nx5VTR7ewcHE33s3Dym4y/Cf8Hvr8XyaSmL0+RgL1nsJLjPoIpFQ0
	OR+xfZbHBZHulgkiAUbMUfZEG2q7E8W5OrA+5tjzRjZuxh9k1gTUk+opm37DqbyuJZCOCgE4mZQYU
	ZMAR15ALwEbczHtn7Cme7uxBfig71sxhk1pzx3YkdDwNFTRqWahW6uDmEeOe4yAGUrUmTYLYwVnmC
	VfFjpqAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbpMK-002UQ4-6b; Tue, 05 Apr 2022 20:01:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbpMC-002UKO-63
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 20:00:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F0DAE61899;
 Tue,  5 Apr 2022 20:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A431CC385A0;
 Tue,  5 Apr 2022 20:00:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="oK7/f0ji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1649188847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtTvKsnbPiz/iEPRO7T9fc0dbhR7Qpouw7hAuHZcwWA=;
 b=oK7/f0jibQ+nQO++4aLYVnNDKBEGWa/7cfSL8349HqQ75s9Lb0fNVeWui1udeUit4C4PbC
 D+1sD99Lc4S0twNy++TKh9i2IaN3In/mV/nHIm1GioaAQBAk8ikA4pTdIvfRsxDUoWz6jm
 vSuPxMXuQuW4ive1duqSisC4LPADm8Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76c4e30d
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Tue, 5 Apr 2022 20:00:46 +0000 (UTC)
Date: Tue, 5 Apr 2022 22:00:37 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yi Zhang <yi.zhang@redhat.com>, alan.adamson@oracle.com
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, alan.adamson@oracle.com,
 linux-kernel@vger.kernel.org
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Message-ID: <Ykyf5Zuz1W8yHhNY@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_130052_567184_48E2CF65 
X-CRM114-Status: GOOD (  12.88  )
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

Hi Alan,

I too am seeing this. Tracking it down to the same commit, I decided to
enable NVME_VERBOSE_ERRORS to get some more information. Now on boot and
everytime I wake up from sleep, I see:

[   89.098578] nvme nvme0: Shutdown timeout set to 8 seconds
[   89.098683] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE
[   89.119363] nvme nvme0: 16/0/0 default/read/poll queues

With that middle line in red.

Question is: is this actually an error? If not, maybe it shouldn't be
printed as a KERN_ERR. And if it's printed as a KERN_INFO, maybe it
should only do so when CONFIG_NVME_VERBOSE_ERRORS=y? Or do you think
there is actually some other diagnostic value in having this print
always?

Using a Samsung SSD 970 EVO Plus 2TB, firmware version 2B2QEXM7, in case
that's useful info.

I also noticed a ~2 second boot delay on 5.18-rc1:

[    0.917631] pstore: Using crash dump compression: deflate
[    0.917807] Key type encrypted registered
[    0.951840] ACPI: battery: Slot [BAT0] (battery present)
[    3.146765] nvme nvme0: Shutdown timeout set to 8 seconds
[    3.146918] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE
[    3.188852] nvme nvme0: 16/0/0 default/read/poll queues
[    3.198163]  nvme0n1: p1 p2
[    3.199554] Freeing unused kernel image (initmem) memory: 12952K

I haven't looked into it much, but I assume it's also NVMe related? Or
maybe the vconsole is just initializing faster so I see text where
before I didn't. Not sure.

Regards,
Jason


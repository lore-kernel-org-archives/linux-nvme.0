Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9ABEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vot7UJJVpJ71h9n8M8aXN7ul6XziXsbungwW4jgtDo4=; b=bQSMDcFyL+NKjK
	XlYywhWSWUFZqyZyavBjhXWDJNJwkm1snqaY0fE5rQg4z8/GuP50r8wM6ucn+yqz31QPUkaklop9F
	xGMaMPQoPtRCzJL3WHiX7AnVX6W/U92fpYu3ylHrjPA9zggSL2oBePa5IKBmHrFEKBGNZr6+b+VIx
	/sabVxnPB+5sMyPtl6w5mUiSB8aQvu0d0GvPSZrKu429HNeGCL3t/2+oMOlGsAarcpMx7ODT0T2o5
	e1VIhb1RQF4321Zo2HworWImXsE2YirFT+n5A7KOnwh5X/W1GRPFHrx4aXJAGgFQdVqfVaCk8+Clp
	drFmL50vGAjGmQOgWjdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qImdu-00AuWi-06;
	Mon, 10 Jul 2023 08:53:14 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qImdr-00AuUw-16
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 08:53:13 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qImdY-0003UR-Rh; Mon, 10 Jul 2023 10:52:52 +0200
Message-ID: <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
Date: Mon, 10 Jul 2023 10:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US, de-DE
To: Keith Busch <kbusch@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Clemens S." <cspringsguth@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>,
 Hannes Reinecke <hare@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Pankaj Raghav <p.raghav@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688979191;a233b225;
X-HE-SMSGID: 1qImdY-0003UR-Rh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_015311_539752_9BB64D40 
X-CRM114-Status: GOOD (  18.29  )
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 27.06.23 18:10, Keith Busch wrote:
> On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
>> See Bugzilla for the full thread.
>>
>> The reporter had a quirk (see above) that fixed this regression,
>> nevertheless I'm adding it to regzbot to make sure it doesn't fall
>> through cracks unnoticed:
>>
>> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_bug.cgi?id=217593
>> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCGL-000MV
> 
> These bug reports really should go to the vendors that created the
> broken device with non-unique "unique" fields.

I understand that, but I think we need middlemen for that, as I or Bagas
don't have the contacts -- and it's IMHO also a bit much too ask us for
in general, as regression tracking is hard enough already. At least
unless this becomes something that happen regularly, then a list of
persons we could contact would be fine I guess. But we simply can't deal
with too many subsystem specific special cases.

> It's easy enough for me
> to write the quirk patch, but it's not the ideal solution and may harm
> devices/firmwares with the same VID:DID that don't have this problem.
> Not being the vendor, I'm not in a postition to know that, so CC'ing
> some Samsung folks.

Another request came in today, even with a pseudo-patch:
https://bugzilla.kernel.org/show_bug.cgi?id=217649

To quote:
```
As with numerous NVMe controllers these days, Samsung's
MZAL41T0HBLB-00BL2, which Lenovo builds into their 16ARP8 also suffers
from invalid IDs, breaking suspend and hibernate also on the latest
kernel 6.4.2.

The following change restores this functionality:

File: root/drivers/nvme/host/pci.c
Change:

-	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },

+	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G, 512G and 1TB */
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
```

Ciao, Thorsten


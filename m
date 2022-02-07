Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78008C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 03:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXfoYxN3uKmwWWbrhiF3MNRpYg7qi0zGNmLgS/+21UM=; b=O6qqfs/xSORuysbEJB7bTeoBcA
	t9C8a/WMy5Mw85wK+7q5MfphKBl/YOocmpT1QVyyooA16t9eCJxSEWUZIxLWf8ZaZgrMLLwqYPVLk
	4sf13RHUW4KJM1AQmFAXMgVcwglWCoWOAbMEIcy0xdWBvWxbFTyZgJHpzwxBEhzLMoSxBJILepVmz
	L5CyINqRnBcrpQkKTgOL+WJ+F5fuUhy4ii1G6k7WVicLTJxiDX9CpE3jso600I5zUE19SsxtI29X1
	GKRsWjNpn4pZfcCg1YE53mfWwgDkURx5ejHUvJ1JzF9s0bVNH1czeSvxwwvHQqlIdY85XpYqOqZBV
	FI9LzyCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGutW-008xvb-DM; Mon, 07 Feb 2022 03:40:50 +0000
Received: from hiro.icebalm.com ([172.245.134.119])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGutT-008xvG-Ea
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 03:40:48 +0000
Received: from citadel.icebalm.com (unknown [10.0.10.6])
 by hiro.icebalm.com (Postfix) with ESMTPS id 6CAFC5F405;
 Sun,  6 Feb 2022 21:40:43 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by citadel.icebalm.com (Postfix) with ESMTP id 2310A1203D51;
 Sun,  6 Feb 2022 22:40:43 -0500 (EST)
Received: from citadel.icebalm.com ([127.0.0.1])
 by localhost (citadel.icebalm.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id pY472YR3Q98y; Sun,  6 Feb 2022 22:40:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by citadel.icebalm.com (Postfix) with ESMTP id D3EDA120AB00;
 Sun,  6 Feb 2022 22:40:42 -0500 (EST)
X-Virus-Scanned: amavisd-new at icebalm.com
Received: from citadel.icebalm.com ([127.0.0.1])
 by localhost (citadel.icebalm.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id REcvzxalcv47; Sun,  6 Feb 2022 22:40:42 -0500 (EST)
Received: from citadel.icebalm.com (citadel.icebalm.com [10.0.10.6])
 by citadel.icebalm.com (Postfix) with ESMTP id B9A211203D51;
 Sun,  6 Feb 2022 22:40:42 -0500 (EST)
Date: Sun, 6 Feb 2022 22:40:42 -0500 (EST)
From: Warren Chartier <icebalm@icebalm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <1869888068.137.1644205242618.JavaMail.zimbra@icebalm.com>
In-Reply-To: <20220207022157.GA634225@dhcp-10-100-145-180.wdc.com>
References: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
 <20220207022157.GA634225@dhcp-10-100-145-180.wdc.com>
Subject: Re: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in
 Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.10.6]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in
 Linux
Thread-Index: tnBXTI/Kjvgo045BxZE3uGEB1CJpPA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_194047_568598_08743C00 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
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

----- On Feb 6, 2022, at 9:21 PM, Keith Busch kbusch@kernel.org wrote:

> On Sun, Feb 06, 2022 at 03:02:54PM -0500, Warren Chartier wrote:
>> Summary: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in Linux
>> 
>> Full Description:
>> XPG Gammix S70 Blade 1TB PCIe Gen 4.0 NVMe drive is detected by the Linux kernel
>> however when block operations are performed on it these errors are generated:
>> 
>> [ 3.958786] nvme 0000:0e:00.0: invalid VPD tag 0xff (size 65535) at offset 7
>> [ 71.726420] nvme nvme1: controller is down; will reset: CSTS=0xffffffff,
>> PCI_STATUS=0xffff
> 
> An all f's response generally indicates we can't communicate with the
> end point on this link. The description here usually means there's some
> platform incompatibility with the automated power settings.
> 
> Try adding kernel parameter 'pcie_aspm=off'. If that doesn't work,
> add kernel parameter 'nvme_core.default_ps_max_latency_us=0'.

Hi Keith,

Thanks for the quick response and the suggestions. Unfortunately 'pcie_aspm=off' didn't seem to make a difference and when adding 'nvme_core.default_ps_max_latency_us=0' I get this:

[    4.035844] nvme 0000:0e:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
[    4.035847] nvme 0000:0e:00.0: failed VPD read at offset 1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6B1CD343F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7S8TFeRtfIflMZqYczhwMgASjd4d1VGNaJSlMhkzseQ=; b=AnLCImeBOvDkLe/tHt5No9GAqv
	gwTkbUXj4GSWSKNe+4v+signbBJG5WllZAM6Y4macs6WEw/NFnFOB5TxWRlVSpM8j0fcavHst0Xcj
	Mw0fiSQlm7dhOXKsOTAVIO83fL3ESjUq28teXOnKwczJ7GcMzej/qyG7nfd6+TemzaXRe34goymSj
	QcqJGEMQb0M5FKUxHTr/1L8u1p8wIWmN9mgWPt5jUiCnTE53JAO09Jsrc0fagjWp1V6a45SoS6TS0
	z6yNYy6nAchRivuyayoD0B3/7r+gZXSmvJUMd66Iccb2fakYcvguGxnfdwTDXq8J64ryVPvWA7JCB
	mE8KVmdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL3Kx-00000004aCn-39od;
	Thu, 07 May 2026 18:20:39 +0000
Received: from out28-61.mail.aliyun.com ([115.124.28.61])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL3Kt-00000004aBU-2ooV
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 18:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778178032; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=7S8TFeRtfIflMZqYczhwMgASjd4d1VGNaJSlMhkzseQ=;
	b=oRxdQe1kC5INvVK5iu3ZQP2uh+NGWQFiiDqAh2qhI9Yb1QEWPsm189RV2V2L5k4X4qEij13pa9WmELZjV5KPJcZHhEu9G3dyTzVfn6Dd+PDI40EHCuQ+gn+9spO8nbX3rxi/iz+QS4yIvYCFv+1ZXlulzTht3/4k4oki3OQimbSQ8kgpVxtJv1IWM7ZAVx0uXDYL8AeCK6ao3Dbpos9MWUakhYED0p75yhqQpVXjAyzz4Sy4XZRM/f61/XnIMd2qe7bFx/NcEruY0EF7lnichhZeEysvdmN3aaHvqJjAGlaXhs9MkfVrb+hioVtNqSdQR2UPY5mYs6ubJIHsOsX9cQ==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4633881|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0101608-0.000487045-0.989352;FP=10475684823147583248|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hRv3Kad_1778178030;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hRv3Kad_1778178030 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 02:20:31 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Pascal Terjan <pterjan@google.com>
Subject: The wrong usage of NVME_QUIRK_IGNORE_DEV_SUBNQN
Date: Fri, 08 May 2026 02:20:30 +0800
Message-ID: <EgTEZ7GYRxSc3ZRAxjIuBQ@alancui.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_112035_890778_E35745B8 
X-CRM114-Status: GOOD (  15.18  )
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

Hi Busch,

Sorry for my bad, but the prior patch which is merged into mainline may
be a mistake:
nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808
(7f991e3f9b8f044640bcb5fa8570350a68932843 at mainline).

At first, I searched around the web, many many customer grade devices breaks
compliance with specification, and some answers tell to add quirk for the device
https://bbs.archlinux.org/viewtopic.php?id=296004
> If you do not want to see the warning you need to ask the kernel developers to add
> NVME_QUIRK_IGNORE_DEV_SUBNQN for whatever the device is that does not support SUBNQN.

https://forum.corsair.com/forums/topic/166499-mp600-1tb-linux-firmware-113-nvme-protocol-quirk/
> This issue with invalid SUBNQN field is a known issue in a number of NVMe units.
> If you look at the kernel code you will see that it has a dedicated quirk for it.
> See NVME_QUIRK_IGNORE_DEV_SUBNQN in ...

Then I did a search on "SUBNQN" on mailling list, then a patch:
[PATCH] nvme: Add quirks for Lexar 256GB SSD
(6e6a6828c517fb6819479bf5187df5f39084eb9e at mainline)
(https://lists.infradead.org/pipermail/linux-nvme/2021-February/023121.html)
said: 
> ... and add NVME_QUIRK_IGNORE_DEV_SUBNQN to avoid a warning.

I think the way to resolve the warning is quirk for it, so did i.


But, the NVMe specification said:
> Support for this field (SUBNQN) is mandatory if the controller supports
> revision 1.2.1 or later.

And the code in kernel is
```
if (ctrl->vs >= NVME_VS(1, 2, 1))
	dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
```

So the warning "nvme nvme0: missing or invalid SUBNQN field." is appropriate and since
the device will not report itself supports SUBNQN at all, it will not cause any problem
and it do break the NVMe compliance, in order to that, the NVME_QUIRK_IGNORE_DEV_SUBNQN
in my patch for "Samsung PM981/983/970 EVO Plus" and in the Terjans' patch for
"Lexar 256 GB SSD" should be reverted, however, leave them there should not cause any problem.

I can confirm the "Samsung PM981/983/970 EVO Plus" can work well without the
prior patch, I do believe the "Lexar 256 GB SSD" can also, because Terjan said
the quirk on SUBNQN is only for suppressing the "missing or invalid SUBNQN field".
This mail is copied to Terjan for fact checking.

Since the missing SUBNQN is a known issue in a massive number of NVMe units.
I'd suggest add a chapter for it in Documentation/nvme/feature-and-quirk-policy.rst to
tell users the missing SUBNQN is a firmware bug of drives, so warning for the device
is appropriate, and it will affect nothing like performance etc.

I apologize for my recklessness and lack of due diligence again.

Alan.





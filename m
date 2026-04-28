Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7468FF886F
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 07:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDNaAnkw4apIfnB/nDCIrYQ1QbHo75Y/miOJKi6xUyY=; b=2bBAyQxi/QW5oUdkKl9hFemY1t
	1ac7zCRJpOhqnrJ0XmyEqfyWoyUM71BXDGIBckCCLdz8O7BmETnRD4Qq7r6fu8jAqRjEhpBHGRt/M
	WPZddvN8a/1PWBNUoCRp9tgtCnF/YKFTepGVRIvweY3sSXTMw1CZXxOpZFmz6B6RHNw8GiHMLXMu3
	IN8v9Z7DQNufTv+1i+++4hDRxHyPGCkK60EPV/Que/mDmnyeZAwPIleRPu3mHEar+5VrYoyccksFp
	fs6T3gYgRwGc6NMJmEKcHLTsAQHL0v9UWggSt51Ih39KcWiFq8qMmq4xuWD++SSx5C2ixIXQg1m0I
	W8aQPcLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcf6-00000000fmq-3mG3;
	Tue, 28 Apr 2026 07:15:16 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcf3-00000000flb-2SoX
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 07:15:14 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 36abb07c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Apr 2026 09:15:10 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 09:15:10 +0200
Message-Id: <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Chao Shi" <coshi036@gmail.com>
Cc: <linux-nvme@lists.infradead.org>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Jens Axboe" <axboe@kernel.dk>,
 "Tatsuya Sasaki" <tatsuya6.sasaki@kioxia.com>,
 <linux-kernel@vger.kernel.org>, "Sungwoo Kim" <iam@sung-woo.kim>, "Dave
 Tian" <daveti@purdue.edu>, "Weidong Zhu" <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
X-Mailer: aerc 0.21.0
References: <20260428022911.1288485-1-coshi036@gmail.com>
 <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
In-Reply-To: <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_001513_965109_ACE9F426 
X-CRM114-Status: UNSURE (   9.28  )
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

On Tue Apr 28, 2026 at 8:47 AM CEST, Keith Busch wrote:
> On Mon, Apr 27, 2026 at 10:29:11PM -0400, Chao Shi wrote:
>> nvme_keep_alive_work() always allocates with BLK_MQ_REQ_RESERVED, but
>> nvme_alloc_admin_tag_set() only sets reserved_tags for fabrics.  Since
>> commit b58da2d270db ("nvme: update keep alive interval when kato is
>> modified"), userspace can start keep-alive on any transport via Set
>> Features (KATO), after which the allocation trips WARN_ON_ONCE() in
>> blk_mq_get_tag() and fails with -EWOULDBLOCK:
>>=20
>>   nvme nvme0: keep-alive failed: -11
>>=20
>> Reserve one admin tag for keep-alive on all transports.  Fabrics keeps
>> two, the second being for the connect command.
> =20
>> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modi=
fied")
>>=20
>> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
>>=20
>> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
>> Acked-by: Dave Tian <daveti@purdue.edu>
>> Acked-by: Weidong Zhu <weizhu@fiu.edu>
>> Signed-off-by: Chao Shi <coshi036@gmail.com>
>> ---
>>=20
>> Reproducer (run as root on an unpatched kernel with a PCIe NVMe device):
>
> You have a PCI controller that doesn't return Invalid Field In Command
> status to the KATO feature? That's weird, it's fabrics specific feature.

Are you sure that it's fabrics-only?

The spec 2.0a, at section 5.27.1.12 Keep Alive Timer (Feature Identifier
0Fh)

says:
"Keep Alive Timeout (KATO):
=20
This field specifies the timeout value for the Keep Alive feature in
milliseconds.  [...]
The default value for this field is 0h for NVMe transports that do not requ=
ire use of the Keep Alive
feature (e.g., NVMe over PCIe). For NVMe transports that require use of the=
 Keep Alive feature
(e.g., RDMA and TCP), the default value for this field is 1D4C0h "

To me, it sounds like for nvme-pci, keep alive isn't required, but could
be activated.


Maurizio


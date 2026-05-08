Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294CBCD3447
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUk2uon+sbjIgbVV/CUdhGhb99sbUABPZ4JTl6d0PnU=; b=HYeSy6Sz1MthQIH9YoMjBAovWe
	EKonglmf0lJpivP/NDsyOWTPVA6G2lPvv228i3ofKXNA53rsFYjnWE7EQaEBnaRdgBMJZRg+Irole
	zpSKFnLVRQCoi5bR9F1vNvEDIUEaynVypicl7w2tR38NCGaDWE0PbH2AtJElk7gV8+P6NN093tlhC
	JduXq93NPR/ZMgFcmsr1uTdKpiGLy/BSDVt1eOLiYQ+o0xkXlvP1gcvYDxa+u/YMqVGH9v31mWA8H
	9BQfYBgWfpkXXtAfqzmkClpIM/c8PESi1ebxWZhsh1FBEZMg0eGD2LpsAcAloWUgKwdU+q5PPGL1X
	55I5bToA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLIB3-00000006CCA-2xH6;
	Fri, 08 May 2026 10:11:25 +0000
Received: from out28-58.mail.aliyun.com ([115.124.28.58])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLIB0-00000006CBa-3oa6
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 10:11:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778235079; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=AUk2uon+sbjIgbVV/CUdhGhb99sbUABPZ4JTl6d0PnU=;
	b=Lgt/y8ialQW9RjXICyLgs0d8dk8/R+MCbyJwEXn1t/bH+Crw5oBohPtnbTALoMj8plXW00PQ7+V71dmApGh5vk1qrTk3reBZTIiixF7L5/rKzRkDawEjRIoJXSjpzfiD5jE7UFdtPwa4xCxy+HgnIz1q8ig5KMoRcOcmMA6k6eTfplfNjLkbk+haJRadrOmFKjyKw9TwmBdXJoxd7ZnS+4od7R2jgyVykDZurVGbZuiysGctsy/D3GNt2UYTXXAaNV+dlOSTWTLol13PkB1JUg7NX2M+X+iOD8PigzozYI4SiJxAkf/j+AOsfpodxvBwjsjUM9ApjdkJ3SU+ovcDuQ==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.876631|0.3382213;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.0667751-0.00116862-0.932056;FP=13936419611070772482|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hSW17B._1778235078;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hSW17B._1778235078 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 18:11:18 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Pascal Terjan <pterjan@google.com>
Subject: Re: The wrong usage of NVME_QUIRK_IGNORE_DEV_SUBNQN
Date: Fri, 08 May 2026 18:11:18 +0800
Message-ID: <e0Qdery1QcSgRO30DoVH-A@alancui.cc>
In-Reply-To: <af2YtHjq3mhWiyJA@kbusch-mbp>
References: <EgTEZ7GYRxSc3ZRAxjIuBQ@alancui.cc> <af2YtHjq3mhWiyJA@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_031123_138301_65750872 
X-CRM114-Status: GOOD (  12.41  )
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

On Friday, 8 May 2026 16:03=EF=BC=8Cyou wrote=EF=BC=9A

> Okay, please send a revert. The number of devices that got such
> fundamental things wrong is truly astounding, so I generally just take
> such reports and patches as a reaction to a real observation.

The patch contains a revert has been sent to mailling list.

I've only recently started using Linux desktop on a physical machine
and am trying to contribute. Sorry for my recklessness.

A patch attached for reference. If the Linux kernel explicitly
states in documents that it won't perform a quirk in this situation,
perhaps I can go to those BBS forums to correct their statements. And
this may help to avoid wrong usage of quirks like My and Terjan's patch.

Alan.

=2D--
diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentatio=
n/nvme/feature-and-quirk-policy.rst
index e21966bf20a8..9d9e791da692 100644
=2D-- a/Documentation/nvme/feature-and-quirk-policy.rst
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
@@ -75,3 +75,18 @@ Quirks will not be added to the Linux kernel for hardwar=
e that isn't available
 on the mass market.  Hardware that fails qualification for enterprise Linux
 distributions, ChromeOS, Android or other consumers of the Linux kernel
 should be fixed before it is shipped instead of relying on Linux quirks.
+
+NVME_QUIRK_IGNORE_DEV_SUBNQN
+-------------------------
+
+The incorrect implementations of SUBNQN is a known issue in a massive numb=
er of
+NVMe units.  However, the warning "nvme nvmex: missing or invalid SUBNQN f=
ield."
+is usually appropriate and will not affect performance or behavior etc.  T=
hat is
+because the support for SUBNQN is mandatory if the controller supports NVMe
+revision 1.2.1 or greater, and it reported itself without a SUBNQN field w=
hich
+breaks compliance with the specification. This should be not quirked by th=
e Linux
+Kernel.
+
+The intent of NVME_QUIRK_IGNORE_DEV_SUBNQN is to solve the NQN confliction=
 caused
+by defective firmware that provides a non-globally-unique NQN.  When multi=
ple
+such devices are installed in a system, only one will be recognized and en=
abled.





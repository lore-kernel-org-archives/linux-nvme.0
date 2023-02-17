Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A662C636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Message-ID:
	References:In-Reply-To:Subject:To:From:Date:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJOrWASn1KJFlLvlIKJZqbxCPYwdIyTSYnMBcjeRoOo=; b=Y3nVrFBm2VB2OGfzxSaRH7032e
	cjaqFcd+WtOzIR1kLISMKXPgi/XPXTAM1QUS+EjwI2CH4HzbOy2RVtOUr6VLh5rwGc2Qt9rhOmwgR
	M1cN2T1aLYNi68FP9/UabiP0ptrvZCV6Tm3wqkIS+lqD0R6KzFYG1+PzCb4IK+rC8r0tManR95brX
	v7/QfX5m3UNHiisAysnv0+O+pyyPFrYGRdUO+qIHebAX6ezAbaggGxQqdlxPbyqyGHOZBomLC+VwR
	kIjk7LkKi7sa3SdJB0QCnF1qE95kSnX9IqBkKqy7BMnQTDEm1jD6j0YtlqAfTCzi/ErxECMLWhGhv
	wZz8k6mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0nA-00EI0w-0Y; Fri, 17 Feb 2023 13:28:48 +0000
Received: from mx0.riseup.net ([198.252.153.6])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0n6-00EHzY-2V
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 13:28:45 +0000
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.riseup.net", Issuer "R3" (not verified))
	by mx0.riseup.net (Postfix) with ESMTPS id 4PJCLy6tWNz9snQ;
	Fri, 17 Feb 2023 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1676640523; bh=8fASVHpyoFgeoRzMaCkRuqhdXLGnGo7qBsW5zDpbjik=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=ErZm9UZsvzTGeMI95HWyL9X+xVIOgIRbLD4MCMZjxuc/Qic0noHZmx/yRKPUvF1AW
	 jExlJISFUQtZQFyD3MmcBnInEDH2JdVJX6cVsFPmStTCMwjPlm40OA8qWw5dB3vKZj
	 w4EvIJFAQh1bIz8ikPRJzQjCGzb3S06EB26pmGxU=
X-Riseup-User-ID: 645A3C20C7D1BFB75EDEBE416DC82D77C0A378C10D6179E40B344884531EEE8A
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews1.riseup.net (Postfix) with ESMTPSA id 4PJCLy3Y9bz5wGf;
	Fri, 17 Feb 2023 13:28:42 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 17 Feb 2023 13:28:42 +0000
From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
In-Reply-To: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
Message-ID: <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
Content-Type: multipart/mixed;
 boundary="=_bf0b7822c2a448583e03e9796c1547ea"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_052844_176555_8F8017FC 
X-CRM114-Status: GOOD (  15.80  )
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

--=_bf0b7822c2a448583e03e9796c1547ea
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8

Ivan Rubinov писал(а) 2023-02-10 15:10:
> From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
> From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> Date: Fri, 10 Feb 2023 14:59:41 +0300
> Subject: [PATCH] Add quirk for ADATA SX6000PNP
> 
> Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c734934c407c..c63443d531b3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
>      { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
>          .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                  NVME_QUIRK_DEALLOCATE_ZEROES, },
> +    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
> +        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | NVME_QUIRK_BOGUS_NID, },
>      { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
>          .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                  NVME_QUIRK_DEALLOCATE_ZEROES, },
I am sorry guys its doesnt work. I send new file which work

Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d839689..3f4da40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3480,6 +3480,9 @@ static const struct pci_device_id nvme_id_table[]
= {
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
+                .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+                                NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },

--=_bf0b7822c2a448583e03e9796c1547ea
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=297cca.patch
Content-Disposition: attachment;
 filename=297cca.patch;
 size=749

U2lnbmVkLW9mZi1ieTogSXZhbiBSdWJpbm92IDxsaW51eGtlcm5lbHBhdGNoODIzNEByaXNldXAu
bmV0PgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMKaW5kZXggZDgzOTY4OS4uM2Y0ZGE0MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKQEAgLTM0ODAsNiAr
MzQ4MCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxl
W10gPSB7CiAJeyBQQ0lfREVWSUNFKDB4MTBlYywgMHg1NzYyKSwgICAvKiBBREFUQSBTWDYwMDBM
TlAgKi8KIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5RTiB8CiAJ
CQkJTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCisJeyBQQ0lfREVWSUNFKDB4MTBlYywgMHg1NzYz
KSwgICAvKiBBREFUQSBTWDYwMDBQTlAgKi8KKyAgICAgICAgICAgICAgICAuZHJpdmVyX2RhdGEg
PSBOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VCTlFOIHwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCiAJeyBQQ0lfREVWSUNFKDB4MWNjMSwg
MHg4MjAxKSwgICAvKiBBREFUQSBTWDgyMDBQTlAgNTEyR0IgKi8KIAkJLmRyaXZlcl9kYXRhID0g
TlZNRV9RVUlSS19OT19ERUVQRVNUX1BTIHwKIAkJCQlOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VC
TlFOLCB9LAo=
--=_bf0b7822c2a448583e03e9796c1547ea--


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F03C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Message-ID:
	References:In-Reply-To:Subject:To:From:Date:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QMLRBNXoK8UzYoKzAJLX7PVlEdx+3bMb+lNltj2YJo=; b=pHEW6FfEDMM+q9N9df8vDUQDNs
	IRInzhohO6p0uUh2zJIeoEEHKpKQ3zr+HIHPDS3Vq5PDjRL8bapUYYMiiuL5z6XRRXVKZYm7KuyKx
	o1SP515lCfmOTbgijMv0DI3Zg4pCI7cvHN2OjYpzZa31UHQm3km0KWdNi9N78KP4NXqCxZGhNljxl
	0akruqKjTnj6FNkI7+DpHCU7bz43MeNAOoMpW5JHTxJOwhc7Dki+9PhDWHnUf/f8t4OJBa48FvUux
	/Cv6LViJbMu1H7f06iHxm3JzXEfLWCRPJCXFrJ4pYbC30//PCubAod66BkxTSqSRMX8qoSvuST53z
	RFzdJUhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0mC-00EHiv-QW; Fri, 17 Feb 2023 13:27:48 +0000
Received: from mx0.riseup.net ([198.252.153.6])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0m9-00EHh0-Gk
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 13:27:46 +0000
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.riseup.net", Issuer "R3" (not verified))
	by mx0.riseup.net (Postfix) with ESMTPS id 4PJCKn2V88z9t3h;
	Fri, 17 Feb 2023 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1676640461; bh=+gmLoCvL0iUpljEU2PYg7NAV40BsyaRXP5y+kVzGDnk=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=b8OlU3aLMOHOOO5Erhik+znwjOQW5cej1IvmRHwSPpuGQxVp3LpmSsMN0/0Yp3vHq
	 5J7xkjX0QhnGp/IMas3A06ZfdvDrZOlywPO1XxBxjS7r2azFpyqkjXIFjOjhzIozPM
	 qYwURb1Cp7L49zoN+Uey/5o3iX94XeUTnQBENKJw=
X-Riseup-User-ID: 6F33C339317B2041990C88585AE87EFD691A97EFE941E6C9D0DB58759395B535
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews1.riseup.net (Postfix) with ESMTPSA id 4PJCKm6dm4z5wXY;
	Fri, 17 Feb 2023 13:27:40 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 17 Feb 2023 13:27:40 +0000
From: user090909 <fuckgithub@riseup.net>
To: busch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
In-Reply-To: <ed916236ae7f2823aeccc8a85230abe5@riseup.net>
References: <ed916236ae7f2823aeccc8a85230abe5@riseup.net>
Message-ID: <8e5c6d584894271cf393a64d8bcef699@riseup.net>
Content-Type: multipart/mixed;
 boundary="=_2066e2defc1c3c382436fb51a9f669cc"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_052745_654256_57666C0B 
X-CRM114-Status: GOOD (  15.53  )
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

--=_2066e2defc1c3c382436fb51a9f669cc
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8

user090909 писал(а) 2022-12-26 17:15:
> From 65e5a06268a4510f2858cbd182dbc60caf7003ff Mon Sep 17 00:00:00 2001
> From: user090909 <fuckgithub@riseup.net>
> Date: Mon, 26 Dec 2022 17:12:54 +0300
> Subject: [PATCH] Add quirk for ADATA SX6000PNP
> 
> Signed-off-by: user090909 <fuckgithub@riseup.net>
> ---
>  drivers/nvme/host/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f0f8027644bb..ca48d0b229e8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3415,6 +3415,9 @@ static const struct pci_device_id nvme_id_table[]
> = {
>  	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
>  		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
>  				NVME_QUIRK_BOGUS_NID, },
> +	{ PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
> +                .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
> +                                NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
This patch doesnt work. Sorry. I send new which work.

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

--=_2066e2defc1c3c382436fb51a9f669cc
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
--=_2066e2defc1c3c382436fb51a9f669cc--


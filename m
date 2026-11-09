Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD0606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C5tWlrK1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbIobevT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=IPqoabHbu77LPOnSoJzvRvVP3yUbcrU+U3U6st6wFZI=; b=C5tWlrK1oJ8PbvCds2z1SuafIm
	zI2BECKVNoRFWlq8i+BjEMYpUnvVgSYMAhIeen3ck19C2JOPMNVQ27Qwo3AKWV7FZxl1IoZWbx7y4
	XdQBvfZSROXgcxbLal3JmcCJ248Ribu90h+AlrOvKsRe4QSn/D9bO+AvXuaSpi8m4+OCbuJnpojeh
	KTWD0yy+fDajDeY9zWSsvnPijgZj4Q2hc/m71Ww2GAJS74vlOoP8gr0UxOpUsSnVTNFC5CExq/AnO
	HTibQyoqv/e/ZdU6ho8JP2Dv0SCa2Vqp+GHDjSbeOztQfibuJOHJQ7n2rUnOwfVfQyJToUaQHmUoT
	uiJovs4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVm3-00000001d7y-1Sl0;
	Mon, 09 Nov 2026 20:15:27 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVm0-00000001d60-3XtU
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:15:26 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c49c32650adso6143566b.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794255322; x=1794860122; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPqoabHbu77LPOnSoJzvRvVP3yUbcrU+U3U6st6wFZI=;
        b=fbIobevTSBpZpTzvnFzjUn+MnPiSEdqLgy4ZXbJryUZ1mGInVz8JE4050bKQex2xeL
         LDgWn7LKvQdl+GaU5Tps67X4k45GIJjJrIN5jESU5vsoheaORJpFDbS9/DoyFU9khXnD
         4qPAl1aaAjVsipOII6f/lmEKEHXGYz0JDoctmDJOvqITyoQvBXVMOHY4+8ocDxW27oaH
         mh5a5ANsX0CJq/MRaSbU32OKEi+kIErHsRZKjBzCi85G5PCGa3Ayhiz/UaPMEIaEHW9c
         SoIJo5FjChgK1yKnBAaTFQudIIDuHlHD7cGhZQ5im92LzZ2Oc55iO3YjgP/WOd0xdCsT
         jT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255322; x=1794860122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPqoabHbu77LPOnSoJzvRvVP3yUbcrU+U3U6st6wFZI=;
        b=fqTeIfELJV36BGr9+JEN4D2b0VUiaz8jCgEuspimu6WyXkPBUAIZv71bcuaDNx5t/h
         sZSB68YeuEWD5tDF7RwpT1ysDuSt1NvczTrOajoLfLeCKJh/UP1IbJkFqyz6dwAA3MT7
         U2kLSfXlD75qsWpmzM4lJ2QBnc9o7amFK2kjDnaxfNe9PCxntU4BBw1KTz9sYX+p4m73
         /aobt/E2+2QbuORM3JBYOpWi7ONzRipTUx1zaFqx0V/LgxEYYHxfOxhqQN6NFO1D7z6P
         ul3EtjtQrUqB9drn/IkC4O5es78XHrgDxuiuEMC3pv+huYFc7rlP5qtGjCY/zWtBAQf8
         dmHA==
X-Gm-Message-State: APuU4Z9Bixg5IZgYMf4T/9ZrqH0ZueaqsFoS+xnXD4UBl6jbpnVtIZBl
	xJLU0ZImoQ//+NHB6tf3BaujcnEuSFaRMm6eHJ7kS2EO1Kw3PH7c27d5H9QRKoDRX5fIGA==
X-Gm-Gg: AYBFou2j4ucIiGLATqRFroWbGsGhJjyIYYAuif1zBgf2erQY+rfNTzGKIKf/I9/jTAa
	FX3NL9Z6/EJ7N6ndSiaaBnvwzH6cHKfQd2bfcjCY63odVFHsCFIgUG1wcCOxwx+1Qnb5NScCLvE
	4Ed9W0OQvMRj7apOUohx9NaFFqB/JldJ401nDaKf0Qm4gGZcpITP12i4YQ6ofWNn8ItGAdsqgzM
	t2XZ2cMnZ4bUGQIvATjxJiK2dx0HRRXVvS0eyW6vDsbT+aGU8akYa8y6cjD6qa02WqTXrJGz3A0
	voPA332uMCnL3yEHnBzLrbW/qV47+1w5LzgxDB6Vl2L2jssZ8CpcLFq8Z98bvQmXKg7fEfmQE4K
	JIr/A2W0YT8wZJp7r19WwdjvKjcgKMfKFa0+VFMlWTtn0iwhRmISLngciflQ2Ado0suvXHfp78Z
	6JU5A++ENMpHoY8WbaLdk0mwJaJ/z91+AeTbxogvMjZgmZ+19eIy7bfP4fvNs8yi+Z6q5EYCsbM
	6hKqlHbYNsyGp0C4/nN0jVgCGaYlOMfzO+pbHetbjmSkGk/L2y5XZMMFNOtQNdiM4FH8hD3GBBO
	Uq029Azd8fYWCMOZ4y4GZpjViMIZYqfL++MwozgaA/0OEW4kqaVi2FH0LAxz+ryV5f1e6xcBlYx
	8DIYINYS3k2ucAQ==
X-Received: by 2002:a17:906:7947:b0:c40:80eb:c543 with SMTP id a640c23a62f3a-c504922a243mr37773866b.4.1794255321720;
        Mon, 09 Nov 2026 12:15:21 -0800 (PST)
Received: from fedora.tailb87685.ts.net (ip-194.15.124.140.laito.net.pl. [194.15.124.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a62b303sm10811066b.58.2026.11.09.12.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 12:15:21 -0800 (PST)
From: Platon Miller <platon.ksenzenkokk@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Platon Miller <platon.ksenzenkokk@gmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS for Lexar NQ790
Date: Mon,  9 Nov 2026 21:15:03 +0100
Message-ID: <20261109201503.10098-1-platon.ksenzenkokk@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_121524_888902_16D92BC9 
X-CRM114-Status: GOOD (  11.03  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Lexar SSD NQ790 (PCI ID 1d97:5236, firmware 1.7.O.4F) advertises
a non-operational power state PS4 with 70000us exit latency. When the
controller enters PS4 via APST, it experiences significant latency
resuming from sleep and gets stuck reporting 100% active/busy time,
leading to noticeable I/O latency spikes in userspace.

Add NVME_QUIRK_NO_DEEPEST_PS to nvme_id_table for this device to prevent
it from entering PS4, while retaining shallower power-saving states.

Signed-off-by: Platon Miller <platon.ksenzenkokk@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8088d5aa..5414b16d4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4508,6 +4508,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1d97, 0x5236), /* Lexar NQ790 / NM800 PRO */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
-- 
2.56.0



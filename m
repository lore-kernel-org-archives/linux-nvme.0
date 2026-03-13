Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A4A106FD7E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 05:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTxGLIuoUQlWALlWPaV5+5jytWPHVII3wottToiK6HE=; b=S0bjXCbbZ3jehzDathDjAcMr9F
	IhI4/u0RZbZsjpMxMJAStn9fJJIiNJqYnGA7itog3dG5YrozBkcAalmsZlr6uRoNa/eBF/LicD7pH
	yWHtHu20io5K8bZZ8mhwKkq+mpXHuFZIH7b4gF/Bcpsf6EQj1fqPu/QHEZfRMe5WvPka/8RbXcffh
	QtgE18ZKWoKsmvpfR/EjxsVT/2uff3X3ig8GaL2Gqbpc7AMx5DawYO/PO2RdJnh4Q5pD6kFhtfzWo
	qQkNcVa5AhFYNjAD2ikk4O8tLSi8ledD5J3RWTY4yD+Jupvww8hYw9NC3CZf/Oo1F0SU9+UmgUPHO
	gF4Zo1Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0v1x-0000000Gdnp-1Ic6;
	Fri, 13 Mar 2026 05:25:49 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0v1u-0000000Gdmy-3NU2
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 05:25:48 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-82990763921so1602324b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2026 22:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773379545; x=1773984345; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTxGLIuoUQlWALlWPaV5+5jytWPHVII3wottToiK6HE=;
        b=cs+XavpIGqdKZO+0ng3VfCTX6iWkd7VytIuh+paipKFtIP9SDHiKwE+eJk/cndY6RG
         2122qV3RaY5kxHG8CqbBZ069Y+BCwrQItPPN0oQy7BJL5+BF0f2LZL3rLB9SPxMPJkqA
         M69blpp1FbCS0/ftxrUUAqGz3/uhFisc88A3dWBB1Q9tE/t5Q3NYpIvRVaakSSlx6b8b
         8oGldCi2hD4uAHkor8MYAMtWEDW/qYLZ3jU4ct38ZFkaJoa2W2P+WNYAYrXhoanpxNXN
         ZXJl97nR2rnwMYZ6Ubmi0RyLyV8naGMWoOyBimzmmX+roAU1EiOmZSrAATI+LQ/c1eoN
         YDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773379545; x=1773984345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTxGLIuoUQlWALlWPaV5+5jytWPHVII3wottToiK6HE=;
        b=EdhD+Tn49ngCvCUol6oGxkwM1FYP+Wp1W26qnHuMdt8N50EAE7Dg7XzUiNeoJQH7fO
         lXgf6HHeEt4Tn98EJl8Es7MYcZpE3TCUIIG8VErhfGuOfL+AfvgoCBlkFUZzgOPNN3K/
         kM+srT9jBv52M6uO0G0+OcjHvjW5NSdKv06XI8k28NxNwZT9Xy5sP3aRBP6DIBuxC9/7
         XzrcT+y7KLJf3xUVa+CQ9g6AD3byZkBzcuRKY1uR/mca/R/RSAP157ZIXlbKk/gjMm7b
         04u7KNGFllMHRb9W6k8N9fzh6fO1KL3EjjXPDvlBU94cbqTRx1pby0D8QRESBHdT3SX4
         aaYw==
X-Forwarded-Encrypted: i=1; AJvYcCWiHZ7cc4xusx0eLgf3+EAbIcOMZ0kTMxeLPS5xflAyPbE7P/G1n3i+CS0tbLPkpkRyvHWhmF0ge+Ky@lists.infradead.org
X-Gm-Message-State: AOJu0YzABl624RJR3W8hGhEaoNKAxhaI3HkQp+HOIJ5un9Kdr7vSu2CY
	tqLO7PToZd7QW48tSkmOPRyjpmaLeqeKI36DDPdWd4RGAjQ1jGNaLzN5
X-Gm-Gg: ATEYQzxeLCA1zkPRtX59pZ5HSBF4gnCxPMNbEblpuPdcnmrodrA+fKjFBr77m6GZ2g6
	otRPhTp/HVpNaTlJIfHJwZNtvU5bNBPvvh4vCY2s9+lvriMPqyfVO0ATbUOMyERSi17n1WTxRog
	cdX4F2LXdb6r3u+nDlFZMaO8O1n/EsmVinV/NIWuMvzG5/aLzZf1jlgoszXDlCDLQyhTuF18XDw
	awxAKo1y99HIx+K260I1Hfh3tDCjbDpxe6ougeqkYdnpUZk2bKiQEIFQwgMcvegvNl048vvV8xH
	wM+vca4ttp0PxXw/qwYtX26qrNc3JuwK06IzLY4AHi4nID0TSXenGFQT0vkKcf5Vzs0l7KwVrH2
	Vz46fXuErlEEUL5PVOlwFNbn4Fg4C0JhMsK5iul0zx4Ld/lW8sRDTKa7flhv9ItLxtUX3Wpd/wY
	oVmhBHVN60xJREiqKXAZ2Cie2x2uDylhrwIYizZqc2rrdg
X-Received: by 2002:a05:6a00:896:b0:824:a20f:17a4 with SMTP id d2e1a72fcca58-82a19951991mr1876870b3a.64.1773379545452;
        Thu, 12 Mar 2026 22:25:45 -0700 (PDT)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073b1d29sm4591309b3a.63.2026.03.12.22.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 22:25:45 -0700 (PDT)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: hare@suse.de,
	cleech@redhat.com
Cc: hch@lst.de,
	ioerts@kookmin.ac.kr,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	yjshin0438@gmail.com,
	stable@kernel.org
Subject: [PATCH v2] nvmet: auth: validate dhchap id list lengths
Date: Fri, 13 Mar 2026 14:24:09 +0900
Message-ID: <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de>
References: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_222546_871874_3F6E983D 
X-CRM114-Status: GOOD (  16.29  )
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

From: Yunje Shin <ioerts@kookmin.ac.kr>

The function nvmet_auth_negotiate() parses the idlist array in the
struct nvmf_auth_dhchap_protocol_descriptor payload. This array is 60
bytes and is logically divided into two 30-byte halves: the first half
for HMAC IDs and the second half for DH group IDs. The current code
uses a hardcoded +30 offset for the DH list, but does not validate
halen and dhlen against the per-half bounds. As a result, if a
malicious host sends halen or dhlen larger than 30, the loop can
read past the 60-byte array into adjacent slab memory, triggering a
KASAN slab-out-of-bounds read.

KASAN splat:
[    4.241646] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send+0x19b8/0x2090
[    4.242874] Read of size 1 at addr ffff8881045754e8 by task kworker/1:1H/41
[    4.265342] The buggy address belongs to the cache kmalloc-96 of size 96
[    4.266291]  allocated 72-byte region [ffff8881045754a0, ffff8881045754e8)
[    4.270337] page dumped because: kasan: bad access detected

This patch fixes the issue by introducing NVME_AUTH_DHCHAP_MAX_HASH_IDS
and NVME_AUTH_DHCHAP_MAX_DH_IDS defined as 30, which explicitly indicates
the maximum boundaries allowed per NVMe specification. The lengths halen
and dhlen are validated against these boundaries before processing,
preventing the out-of-bounds reads.

Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Cc: stable@kernel.org
Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v2:
    - Replaced the runtime 'sizeof' calculation (idlist_half) with explicit 
      NVME_AUTH_DHCHAP_MAX_HASH_IDS and NVME_AUTH_DHCHAP_MAX_DH_IDS macros
      to clearly reflect the 30:30 split limit per Chris Leech's feedback.

 drivers/nvme/target/fabrics-cmd-auth.c | 11 ++++++++++-
 include/linux/nvme.h                   |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..acba4878a873 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -72,6 +72,14 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	    NVME_AUTH_DHCHAP_AUTH_ID)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 
+	/*
+	 * idlist[0..29]: hash IDs
+	 * idlist[30..59]: DH group IDs
+	 */
+	if (data->auth_protocol[0].dhchap.halen > NVME_AUTH_DHCHAP_MAX_HASH_IDS ||
+	    data->auth_protocol[0].dhchap.dhlen > NVME_AUTH_DHCHAP_MAX_DH_IDS)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
 		u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
 
@@ -97,7 +105,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	dhgid = -1;
 	fallback_dhgid = -1;
 	for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
-		int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
+		int tmp_dhgid =
+			data->auth_protocol[0].dhchap.idlist[i + NVME_AUTH_DHCHAP_MAX_HASH_IDS];
 
 		if (tmp_dhgid != ctrl->dh_gid) {
 			dhgid = tmp_dhgid;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b09dcaf5bcbc..ea0393ab16fc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1824,6 +1824,8 @@ struct nvmf_auth_dhchap_protocol_descriptor {
 	__u8		dhlen;
 	__u8		idlist[60];
 };
+#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
+#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
 
 enum {
 	NVME_AUTH_DHCHAP_AUTH_ID	= 0x01,
-- 
2.43.0


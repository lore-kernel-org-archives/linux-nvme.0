Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD6606ACC4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BW5Yg9Ia;
	dkim=pass (2048-bit key, unprotected) header.d=sufficit.com.br header.i=@sufficit.com.br header.a=rsa-sha256 header.s=google header.b=bcrnGg8A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=fQTKdjJLJFie4TNyy0orWizyhorA+PZS+iMTu3uy56Q=; b=BW5Yg9Ia98kRmYy9C7pmIDFvnI
	FR4lAaCcgOFgGb3AHEhkETZDdI9WkXFXRsxaKEuO6bQd3GfcSkZWE08qv/5tEQV9yYNZTfjusjI/s
	kDSNCXkGo5+bzLZaPuzwpUQwf5W07brUb5WBVwvv6X0RjvrDWUSFmoWSpTuvmprLNRSgmxFpbsC65
	ykRqgGc2sO8120NIRsyPpeYGfbis/81W6C9eDjVuyB9DC2kOlicUsFgJkW/Rfg/sFU3DMWBiJCNXz
	7dUpIIbLVlPhaP0y4Xbo0OqSEyAEuGn3t27mLCma7V1rYI/Timny3VaxrmCOP0oMEFwf1y5t5lG9B
	34FqNrWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJubm-0000000EOts-0UOX;
	Thu, 22 Oct 2026 15:21:34 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJubk-0000000EOtS-0Bhu
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 15:21:33 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1519014f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 08:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792682489; cv=none;
        d=google.com; s=arc-20260327;
        b=PTNPJi4F65AiaE6QFIVT5W+cMpplkekDKa3IMYrU8IoCvW43mkI6LWBGoEECPJA7wh
         z0+Q6knJnADKv6re0aeRKuX0yYG+VWJ0F8+bhr0GWiLNThO6zuqq0yBqm3EcM8nEDSv6
         g1BWLNZggF/F7PKCSZJU5YbZCvzFQymCCeNpiUzkCai6J9sjGkpC8Hxt2CCVjHLQeDYz
         W1G8lxBoOq64zbW5j1oxJvGzHxk3AjQlA8w04U/kyckvg/L8Hgvr8VwYAcRJjvl5Mreo
         t9lEvyby9veco8FPd5HocFeRR1WHGf9UbjR0rGAu/8RPrx1VSnCqdQhQPmLMCvyTUX0N
         XxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fQTKdjJLJFie4TNyy0orWizyhorA+PZS+iMTu3uy56Q=;
        fh=fit4/o4DTl25+FOwIzRvxtF32QH90CvqgwGsR3IqO8o=;
        b=TWoRHc8JR7tABN0hIaz7UjPJzhw2XhiU3zTJ5ZPZ8YMlNc0X8KTbzsN3TvxcvJ0dPx
         Eh5AI9LGXUHc13w/bplydyilBqoV/apB4UUianRyuKKDtQUCcbZqkivpKVQr1j+YSRxv
         U5CLmKo2Q7egiptxacm+XIHYZ5asi5L8Vf0lZaJnVQCSwVnabNe8onlCEt3D6u1AZZhg
         5MCj0k6NcIoRSS2l4aVf2UjpHgYVTLxSoy5QCu7m38caOcHW7NC3/Mmrr12wjndJJN8N
         yKdUZ0oBooXR3VaRkaSMbOZe7BizqciArLSL5u2gFipSqXOgA1D1e4f3qz2jAc/jW3fW
         TGAw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sufficit.com.br; s=google; t=1792682489; x=1793287289; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQTKdjJLJFie4TNyy0orWizyhorA+PZS+iMTu3uy56Q=;
        b=bcrnGg8AE4Ar1QNDcTipmkjUvAJekP2eVUZLTRgLDlWhxlHcyN+hvqkVvswJDjiETy
         XO0Zdj7utfl7Uw1lArD4yVaGCH2BoqEFwFqi6Q8Wlv1IedOa++4/FDWPRt4ivPxEDWP0
         VbAnlUJ4O1IOkiJ6mXz15E/HBcq1lzzNZDTgTuWD+hESLo65F8jlLYawEVks+5CYxTgT
         rJGUd/JmBqhbFzcJnk8+8N9oCabUXaom1gzcefBKnTpFKbu99LQ5m+2OvbH0mPpu5fGq
         sZuJLtXJvUGB4vEmgFB8FOd0MWQbPa7rvPEz5fvJCKg1/pSIga1h7fu4LxATAQk7O6wF
         KHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682489; x=1793287289;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fQTKdjJLJFie4TNyy0orWizyhorA+PZS+iMTu3uy56Q=;
        b=j8D6KRx2Od2xkzvTC3YEFFAX1CeZWAsNkZ5gadiM1/wRBE29+g3lWnblGKo5CrnrJq
         MgELIbtANN9N7m5oeBfCDpwkB2Czaqwzf3AGQ6ome9f+8kKorGgE1KqR/mioYa8SFAbi
         ri3JjQqfyqRpPVYS6FpKgy4gnxfu/+wuFAn8aTdG6if4Vjha51SdLZrnCfl6Vuhx+3bd
         jltwONOjwoCx9slGMlmiU11EvxEXn4IYZtucgMIVrysZlbJVC1t++V1HfWVbE5hqtK45
         2f8MmEa1SVd4hembCs5VWC2TnJ737KcnFhwpLkw/n6W/nvu6Bz8T9fXet1N8rxQeiMZP
         1hFA==
X-Gm-Message-State: AFq9FYI+fYn6N6BKXCIJWtQYn/vy/vaSlLumHZxVp3q61yb9mtsweo9X
	gB6yNLeAwPE4y3WVvRnlBgSYHIZESP/P7iw+7EbyxZ3H7rCSts8so+6oXEsY98FhY+9fuDSZ4cp
	HINOB6xBBR6fquJJvi2ltjE64BL48HgEiRI/ZRSy2AaJNM0K9FUfQPY3zCA==
X-Gm-Gg: AYBFou2OzE3ZJhT19IGCC7kd2cfH3N3o2v5KJL92Qmu56ZkkB9Q99LMUTvST4v4wofN
	anNDqzk1wIfi46GJvZiPbkK41KQ5KWky453LGcETiFtnl3fXdaCKUxmvjbrzk3RLD8gaz2aNFhh
	BUNW29Fy/OT4B6s04zKe5JHmqVDPtF8a/+57fOe2L0Vbn4H+0qNW+bgzRjpZvY3bCxaQu1ZKHdM
	HJhfe/TXY4QjU8DmTFvxhsZJHcPv/ungT8AECGyMoo+jn6X/nLlOHkFmMlLzX4VTJ8xCHeE4dEu
	/OyBfSopCosHkdiB2ByCPT1gUzNP4LvI2j1S4GeyR2+h3gJY96GkoEjFENJm803rLeG2J1W5vlx
	OGPlYicX1p23B/g0TyJZYzqlH4yS0YqJ8hZR1P90Q/ychKujl6rCkiZ53zEaTipwRgjRYGsBiQp
	IVq2aVwFU16oBhmiw=
X-Received: by 2002:a05:6000:1ac5:b0:48e:791:1cb with SMTP id
 ffacd0b85a97d-48e264cc332mr12251288f8f.35.1792682486515; Thu, 22 Oct 2026
 08:21:26 -0700 (PDT)
Received: from 609194959516 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 08:21:25 -0700
Received: from 609194959516 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 08:21:25 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Hugo Deco <hugodeco@sufficit.com.br>
Date: Thu, 22 Oct 2026 08:21:25 -0700
X-Gm-Features: AclHuK8-Ul-g1fyZ3e-YHhnJ17W_759CR1Y_L1YZcQFjXiUZlknPFhv6Hs2UL14
Message-ID: <CAGFVba_mDRomduXFV5HugBvb9sKhNzdhgDvkCvUvcdOhy4ri4Q@mail.gmail.com>
Subject: [PATCH] nvme: add NO_FUA quirk for ADATA XPG GAMMIX S70 BLADE
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_082132_113817_2AEB24B1 
X-CRM114-Status: GOOD (  13.45  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the ADATA XPG GAMMIX S70 BLADE (PCI 1cc1:5370, firmware 03020P5E)
every Write with the FUA bit set takes 200, 400 or 600 ms to complete,
always a multiple of ~200 ms, while a plain Write completes in
0.0-0.4 ms and a Flush in ~1.3 ms. Tracing nvme_setup_cmd and
nvme_complete_rq shows the whole delay is between submission and
completion, i.e. inside the device (e.g. FUA write, control 0x4000:
598.3 ms).

Because ext4/jbd2 issue FUA for every journal commit, fsync() on this
drive stalls for 250-890 ms and desktop applications freeze.

Add NVME_QUIRK_NO_FUA, which stops advertising BLK_FEAT_FUA while
keeping the volatile write cache enabled, so the block layer emulates
FUA with a Write followed by a Flush. Durability semantics are
unchanged.

With the quirk applied, 4 KiB O_DIRECT|O_DSYNC writes and
create+write+fsync drop from 250-890 ms to a 0.82-0.85 ms median
(30 samples, two partitions on the same drive).

Signed-off-by: Hugo Deco <hugodeco@sufficit.com.br>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7eb0f9f..5c0d74d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2477,6 +2477,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
 	else
 		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
+	if (ns->ctrl->quirks & NVME_QUIRK_NO_FUA)
+		lim.features &= ~BLK_FEAT_FUA;

 	if (info->is_rotational)
 		lim.features |= BLK_FEAT_ROTATIONAL;
@@ -3090,6 +3092,15 @@ struct nvme_core_quirk_entry {
 };

 static const struct nvme_core_quirk_entry core_quirks[] = {
+	{
+		/*
+		 * ADATA XPG GAMMIX S70 BLADE (fw 03020P5E) takes 200-600 ms
+		 * to complete FUA writes while Flush takes ~1.3 ms.
+		 */
+		.vid = 0x1cc1,
+		.mn = "XPG GAMMIX S70 BLADE",
+		.quirks = NVME_QUIRK_NO_FUA,
+	},
 	{
 		/*
 		 * This Toshiba device seems to die using any APST states.  See:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a643c47..2128b40 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -183,6 +183,12 @@ enum nvme_quirks {
 	 * Admin queue DMA buffers must be page aligned
 	 */
 	NVME_QUIRK_ADMIN_PAGE_ALIGN		= (1 << 23),
+
+	/*
+	 * The device is extremely slow on FUA writes but fast on Flush;
+	 * do not advertise FUA so the block layer emulates it.
+	 */
+	NVME_QUIRK_NO_FUA			= (1 << 24),
 };

 static inline char *nvme_quirk_name(enum nvme_quirks q)
@@ -236,6 +242,8 @@ static inline char *nvme_quirk_name(enum nvme_quirks q)
 		return "dmapool_align_512";
 	case NVME_QUIRK_ADMIN_PAGE_ALIGN:
 		return "admin_page_align";
+	case NVME_QUIRK_NO_FUA:
+		return "no_fua";
 	}

 	return "unknown";
-- 
2.53.0


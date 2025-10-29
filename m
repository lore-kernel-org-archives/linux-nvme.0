Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96E8CCF9FE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OdkzqzCHfZ6lX/G1aEBTisGzK+PfZoRnqikf15uBIgk=; b=1qGI3umt5Dwfd4KA1Fyo8U0R/V
	LOol0SDJNwbMGnG1VdjPh8Sn+Sr4pdDBjJi8F0EGxKniunePgnVGiAUJZeZlu1FMx4HwjOnPu+lDn
	AxAfV16b9xsffAyzRSb3LMkx/eiqSysGfl4AtUNV8QrGBFt26J2IeJGHnymlNLDKMvN765iSHZlg8
	5QUr7H3XxdskumwLJHHD5HpkwO9sOluk7xShX+MPZoaGWtmWXOSSE5PdYPHumEs/JDwFR2TNhxMfA
	4/N0qyuU59EUd8b/+zQp41Ub9UYs600OEdDt1JWDJsTHCZHA2H2tDaxF1xudDEEkEVwl9uU51Oi+Q
	5SHn4ofQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEqcq-00000006Hvk-3RQ1;
	Fri, 31 Oct 2025 15:01:12 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDu8J-0000000Grr6-3Yxz
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 00:33:48 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-63e35e48a25so6872537d50.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Oct 2025 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761698024; x=1762302824; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdkzqzCHfZ6lX/G1aEBTisGzK+PfZoRnqikf15uBIgk=;
        b=L5GvgYUAafVwB/FH//A3EJJV07pgA/ruXlM4sIuUYmaLwyPQg4O6A5Y7YIWXO0gAlj
         xsAz/TInprTS+You7dY0v6Mgc2FONsnpdLvT92ZiIvGHQ6DRb+xmtmrJHmGy4bS5SFTe
         3p4JIJqQ51ev1tG0K025p9v0wBiCZCcYtll6X5BX9H7Hy8LS6H2nzLBKLFKqGPemGfcb
         k6F1PniJc2mpT0oNA/Jp/uMABpQWnymQk978j4T5Tn5hOpia695qrHTg2N+5LBha0Sud
         DjBjveAl7dMcRAholrSnehNyHgSwPo0QQEffNuh/X78EG6Ub6JsIFmL4/odVvDFlNuOw
         pFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698024; x=1762302824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdkzqzCHfZ6lX/G1aEBTisGzK+PfZoRnqikf15uBIgk=;
        b=PQXzVGpUTQRt/L38KRZGzcnq6pD9wkVRVk1V9u7e6HtdLMNqOLiHXEqQRtBPjITYfh
         hLgzZBVMrq5vjo7x6DPE5q4HGOkICWjBnertHB6b/vtyEKtS+2sQe1nsv3e0smDkjCrI
         jMY5+r+oxR7NovuXKF4RZoPndMUsjdjQouYkp/O5gjUgCKcv4JE8OANfufxJXArweoQo
         JB+gQKaWMb9/zlvmLAZvEjt1n2wrruoHcl/Qkp9r4psxcpoEcJeAdGrdZbvSHu3bW1b0
         9QG4PCVuBzI9lVQ4xMU0InMpcW5mPRI3Dh70M3nnlw52D2sblflpV3hPcttBSbwVLhH1
         FgFA==
X-Forwarded-Encrypted: i=1; AJvYcCWP45TunhLAbEFe0A057VSNdj0T9o7A+XTm9QY760O5bILLCmzt1ns37RFAafIQwwTmlxVUrW8YOvpb@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6JjlOugvyLEHz1p5oxfO05NLeicb25jqxB3JZ0o76QDGVdDnO
	F5STD0FEIPLeEw9pWC1MFqFV9WMma23/QHAW02D6YhmaOt5SRiUfY+SMCaNm/lxIHqYmM1aP+nV
	7BPattUPDHo4l2z5P7ZAAd+Ynnjc0kDw=
X-Gm-Gg: ASbGncuftBlX2KWiYC28HR4Fu4PzcrlKPOwlmauSYjfXDISdEgqWpRzVsV5aLnCkRMg
	sBA6uG6nxrKP73H5KDJNGxr8JjMsNXKNLhSY5I4pW+Yfu4GRZNS5Ev2Npx+T1a8x+QAiA5yLGAJ
	M5WpaRrOdz2H1UevngrZdYZnSTITHKBQV4NAYPiqFHNGKvV39M6LLgMFLiNc5nSz/s1Kyk93EhA
	+Sc8HQHFPvdLGgxWLRO9eWnomWTpBYrzNI4AVAcW2JznBo7O3sBkMGpM4pNBA==
X-Google-Smtp-Source: AGHT+IH8PgR7V2uY37H0wYQDjQR6xlhgm7FhFPcPvl1vmv2cs7yqZ+C8q5wJQr019dnrfiwzfFBlR64OWNQipqYxDYo=
X-Received: by 2002:a05:690e:250c:20b0:63e:bea:b050 with SMTP id
 956f58d0204a3-63f76ce8491mr1103976d50.12.1761698024494; Tue, 28 Oct 2025
 17:33:44 -0700 (PDT)
MIME-Version: 1.0
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 28 Oct 2025 17:33:17 -0700
X-Gm-Features: AWmQ_bkg218Xr7uioK4Or0oWvQTwIEaOMn_DJhVceyZlHc7jfJr1jLfii0nJT1M
Message-ID: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_173347_918890_13BCE205 
X-CRM114-Status: GOOD (  13.64  )
X-Mailman-Approved-At: Fri, 31 Oct 2025 08:01:11 -0700
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

Hi Daniel,

> nvme_fc_ctrl_put can acquire the rport lock when freeing the
> ctrl object:
>
> nvme_fc_ctrl_put
>   nvme_fc_ctrl_free
>     spin_lock_irqsave(rport->lock)
>
> Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

While I agree that we can=E2=80=99t hold the rport lock when calling
nvme_fc_ctrl_put, nvme_fc_ctrl_free also does a nvme_fc_rport_put,
which could also trigger nvme_fc_free_rport, making rport invalid.
Should we also add kref get on the rport before entering the
list_for_each_entry loop?

Also, because nvme_fc_ctrl_free removes itself from the
rport->ctrl_list, should we also start using list_for_each_entry_safe?

So, something like this?

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..fcd30801921b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1468,14 +1468,16 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rpor=
t,
 {
        struct fcnvme_ls_disconnect_assoc_rqst *rqst =3D
                                        &lsop->rqstbuf->rq_dis_assoc;
-       struct nvme_fc_ctrl *ctrl, *ret =3D NULL;
+       struct nvme_fc_ctrl *ctrl, *tmp, *ret =3D NULL;
        struct nvmefc_ls_rcv_op *oldls =3D NULL;
        u64 association_id =3D be64_to_cpu(rqst->associd.association_id);
        unsigned long flags;

+       nvme_fc_rport_get(rport);
+
        spin_lock_irqsave(&rport->lock, flags);

-       list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+       list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
                if (!nvme_fc_ctrl_get(ctrl))
                        continue;
                spin_lock(&ctrl->lock);
@@ -1488,11 +1490,15 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rpor=
t,
                if (ret)
                        /* leave the ctrl get reference */
                        break;
+               spin_unlock_irqrestore(&rport->lock, flags);
                nvme_fc_ctrl_put(ctrl);
+               spin_lock_irqsave(&rport->lock, flags);
        }

        spin_unlock_irqrestore(&rport->lock, flags);

+       nvme_fc_rport_put(rport);
+
        /* transmit a response for anything that was pending */
        if (oldls) {
                dev_info(rport->lport->dev,

Regards,
Justin


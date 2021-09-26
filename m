Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC3C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 04:34:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA4C60F39
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 04:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FA4C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ur+IuZC9rPhJhlEx23KEPduxUEYd2U+U4Xqt9Ak09Ug=; b=ja/7Nx93v3XIV8
	emLvgANuN+Wy+cFrYJy/7bIqLOp3rsqDKUvxU5s3UQEUeyLJczkYdJnPXF6WKnjJv+RxjJ7m8UwWx
	WAXvSyBes70zlNfPBKAiSnkNUXgv3eYvsdUFNI6cOoYDyX/BgQcpGXYQVBIIo0jLvYwjjXC6lu8W/
	TmyhXgKNHAT6GxLdtcN5n17VQVgH3mOJqqDov+agWvl/CDibekrkDM/hzqV7vP3YZ1CfX3teJizeB
	2m5WSPZg9e+9qCk8hULxjqMDRODqH04mrIX5xRNDv4g9Os6kkObV8GLprCW/OTLJIr+JbxDgKULGU
	Wc59eCb6qi7s1wQ6TGEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mULrs-00HaHC-JC; Sun, 26 Sep 2021 04:34:24 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mULrp-00HaGu-1Q
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 04:34:22 +0000
Received: by mail-oo1-xc36.google.com with SMTP id
 p22-20020a4a8156000000b002a8c9ea1858so4749350oog.11
 for <linux-nvme@lists.infradead.org>; Sat, 25 Sep 2021 21:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=RhGaGGFscF8ywwf0ExE64EzmMnC8TYkz16jaGStC8BE=;
 b=gFGtIBCrzuEiDnNKSZpFWdDTpLdxPZpGLxiWWJsVMPAyypoOvmxG7h+0HPbQDAFyo/
 cHF5VVE665YcztDcvxEtIwzfwesBXi/ooRknTn99C83htth9M7ow6p2WPXvmhG+ZBJcm
 9AruFteuFMiXgpyxFj8HgkkhLCnrMtTjwaDNrwzG4WBXxBienVHqn2z1TQakIo959iZs
 Kte38u8M2BPTedd9NTOm0c4L7MN7WANnbO+auKGFkzdtpYwYfqRoc9V6l/paSl0Wxr+t
 FJr6X0QFp6DyurXGeg+a2OpNOHHW4zl0RoDv0nz6eEsOMhs6aXf4gh97iCKDhWdSuUVv
 3BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=RhGaGGFscF8ywwf0ExE64EzmMnC8TYkz16jaGStC8BE=;
 b=KfxNp7fhbUIcLp4Yc15y95CDi/ld/1WRwBs5oQ5ulxGudXWYAPzVG4398MSeONG7HE
 Ut6sUkyCYCIENZ3yGXmAsySeBf/u+RUooiUx9d9m+pZes4bxkkJnPbxh7iDGWRrRK8Uj
 tMv4rFqgkbvBnW73oAVV+AGVnXhKmaCHKbmlo/0Owy2y7CIG/72L9rTI9ei3ML5li8RS
 yhfbUE4fcZ89CtEo9Enan3kpvYoHoVYxTD9daZMUFwSgFUMJ8eoUMWy5IyOJ5Da49de3
 OJvQnBC7rxe5tna5CF8NKO2i6VHMQfk/NwqnSzMArMtVbBzNkeGONmjG32QpwehfPKsw
 UI7w==
X-Gm-Message-State: AOAM5307fXeD2O2vQ1mvrXAPnJhTc5YjOWKlNQkd2T/0IpMHdgUVLDSr
 sybsS7JvJd1X5rrjDBX/2wsI11rWaH/oGezQMbc=
X-Google-Smtp-Source: ABdhPJzNWKFrO39burHlxReijX4Ux8CRpcqASv/CXvfWwVzlyp21CcGtvxy3JaHxylGlON1oCbM1PRfb0A8LaToud4k=
X-Received: by 2002:a05:6820:358:: with SMTP id
 m24mr15312527ooe.34.1632630859907; 
 Sat, 25 Sep 2021 21:34:19 -0700 (PDT)
MIME-Version: 1.0
From: Steven Seungcheol Lee <sc108.lee@gmail.com>
Date: Sun, 26 Sep 2021 13:34:10 +0900
Message-ID: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
Subject: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, sc108.lee@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_213421_108794_6FE059CB 
X-CRM114-Status: UNSURE (   7.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

lbaf, lbafe used on nvme driver
Base spec:
    NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified
    NVMe-Zoned-Namespace-Command-Set-Specification-1.1a-2021.07.26-Ratified

Signed-off-by: Steven Seungcheol Lee <sc108.lee@@gmail.com>
---
 include/linux/nvme.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..c11eda4be426 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -368,7 +368,10 @@ struct nvme_id_ns {
  __le16 npdg;
  __le16 npda;
  __le16 nows;
- __u8 rsvd74[18];
+ __le16 mssrl;
+ __le32 mcl;
+ __u8 msrc;
+ __u8 rsvd81[11];
  __le32 anagrpid;
  __u8 rsvd96[3];
  __u8 nsattr;
@@ -376,8 +379,7 @@ struct nvme_id_ns {
  __le16 endgid;
  __u8 nguid[16];
  __u8 eui64[8];
- struct nvme_lbaf lbaf[16];
- __u8 rsvd192[192];
+ struct nvme_lbaf lbaf[64];
  __u8 vs[3712];
 };

@@ -387,16 +389,21 @@ struct nvme_zns_lbafe {
  __u8 rsvd9[7];
 };

-struct nvme_id_ns_zns {
+struct nvme_zns_id_ns {
  __le16 zoc;
  __le16 ozcs;
  __le32 mar;
  __le32 mor;
  __le32 rrl;
  __le32 frl;
- __u8 rsvd20[2796];
- struct nvme_zns_lbafe lbafe[16];
- __u8 rsvd3072[768];
+ __le32 rrl1;
+ __le32 rrl2;
+ __le32 rrl3;
+ __le32 frl1;
+ __le32 frl2;
+ __le32 frl3;
+ __u8 rsvd44[2772];
+ struct nvme_zns_lbafe lbafe[64];
  __u8 vs[256];
 };

--
2.17.0.windows.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

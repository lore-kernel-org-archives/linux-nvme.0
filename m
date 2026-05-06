Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA923CD3439
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 20:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NYeUsBaK4AfDsRcd9WqI2mvay3n/+UbmmkB4jPz4ai8=; b=yKMd3GP1sAPIQqWHgqpaGzQKQ2
	E3ODlfUwB4+TLEZLB/Nssy8W8pwRQjaL2Zmlw54CPdluSvIKiyluMUQGe+Xlc8JYFuVbvP1H+eLp8
	drmSB7iCWC5BJu4bjnSVzxDPfMhPC6JqJNgFtFrMfUA3Vx928IFsdtLMHpmgLlKA2psRWnehaDVCF
	frcw/wVtiXPhzPdRIXvnVCG/cAAUK0UJR3Z5bAC8XJRPRO1HaqiDLyHQ0elXShKB/xRAH5khgkFjQ
	/IgHHRNkqIrGxKXRfnSxzu28vhhZj88I4GH/oHIGgYFRPknhQWf8O4qpxLxwKXkp8Ys+BRxGrKk9E
	LXMFhFOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjFo-000000023LK-0rwm;
	Wed, 06 May 2026 20:54:00 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjFm-000000023Ku-3W5U
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 20:53:58 +0000
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-463f00cda04so49515b6e.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 May 2026 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100837; x=1778705637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYeUsBaK4AfDsRcd9WqI2mvay3n/+UbmmkB4jPz4ai8=;
        b=SWvw+FitaFSBeYJoOZ7PiQqoVkHLJaYUonKGqCPtHsPcPxkr2+ifUH96I80yxWsmLX
         KofNnnC1Z6o3fgFyJ7Ne3Qcw/C06vPp0OzCgDzneRO+jk8VeCSHUHON45k3BoFr+PWsC
         rKaarNXeyYEmor1XqnnXo5sot/g/kOaPRNWXxLkGCVMS7JLRh0C2V17m5BJXpsjAUI/I
         8NbIuwFiIla7Nci3tstzwd4oyjK/CyPTc8KVzLA0x8ZO93AbMFDSPeR7QujIXHm1mMa0
         qbszetNsUKa2kh5l72P7a3NvzmnLFj4SubzcxWqa+hNfAXwnTWsQtEsWBgrJ2u8tZl6F
         X8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100837; x=1778705637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYeUsBaK4AfDsRcd9WqI2mvay3n/+UbmmkB4jPz4ai8=;
        b=hwrWkUAkL7Zf9RQFbCvV6UXxO6UtOow2JWpG9tspFWXXzyHMJyOTnRrVWerrWib0ls
         ZGlrlzXyfiqRo6PysK6fkL2RrWiUnIuJlVMKlQ6RFVP+7E0k2HV1HXCw1r601WhNbN0W
         9B2n40udMQ6Neo7KIg0HiC/wnriqOUunt0pqvBZ78AmFrlaNKQ/ZqQx8hx874iQlXeFQ
         ZtqUOvJwt1Qo06zBgHt90vpbNcleL+6JuERyV5vWNY2GMYmlW6dXK3cW5MFBYPvac7gg
         ozF43cuXf/lVN1jubG8MeAu3xBwNdMemVLdaUlj1vTmUgxZoROtwA6ah5s0qZAAdEAQ2
         cGYg==
X-Gm-Message-State: AOJu0YyEDWoAM8z3o+cI24hiXO4h11dlwDeqazGzfqB/UpLC1x86lRjD
	pq8LiWZ1Ff7Ru1q3/0II6V98l27N6gPo2woZc1Udg3FlESuHBBjle/8K2IcVSg==
X-Gm-Gg: AeBDieviwo3t85HpV8kgKjLV0jWpEesRMu1YhByOLThgLLVs1fGBGgzHKATTZHPNBGX
	JxFpJus0V2plNqOlaRmecrLr+IfKcqC17xJaM2KD1z0jccgw+btVmKxXA4STgTzynD0O2rh1t9S
	xX7Hlj87zpoDr07tKDQtlHUgSvqZi6MpVCegAKfQKjVdEgQy/HIxVnQhwzXb8PoHGrUSXpzrbcO
	r8lQgFm3JnFgsXa9wSchLnWdwP+b5sP2vh9heNwwXGJm3AP0YtN1NW9GDThpPzBY6X9VEfdmWE4
	MIUA622fKSoLNkCgxpjYZzoElJ9O7UyLGkyaeoQx3Kx8v5NXBCGYeWtQywaYS7gLtYTAYsj1vcP
	OIh20dS+SJTgxnnCgWWj9Ul0lemyosk3+MjnObgnJ5G2M3j6bjKUdsAP31TVwzl4y2TOCKWckbC
	rxRgU5zgVxJ0CJWneazOlKY9a/VI7/xW1Jl+D6MITGLz0ML5nCZq3w
X-Received: by 2002:a05:6808:d4b:b0:467:4fb:f225 with SMTP id 5614622812f47-4804209429emr2745724b6e.9.1778100837037;
        Wed, 06 May 2026 13:53:57 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4351bfb3b74sm735870fac.0.2026.05.06.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:53:56 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-nvme@lists.infradead.org,
	Martin George <marting@netapp.com>,
	Daniel Wagner <wagi@kernel.org>
Cc: stuart.hayes@dell.com,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] fabrics: fix NULL dereference in nvmf_update_tls_concat
Date: Wed,  6 May 2026 22:53:45 +0200
Message-ID: <20260506205345.64478-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_135358_908554_CC2AEF15 
X-CRM114-Status: GOOD (  10.31  )
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

The recently added function nvmf_update_tls_concat() dereferences struct
nvmf_disc_log_entry *e, but e will always be NULL when called via
libnvmf_discovery_nbft(). This can result in a segmentation fault when
attempting "nvme connect-all --nbft".

Check for NULL pointer before dereferencing.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 libnvme/src/nvme/fabrics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libnvme/src/nvme/fabrics.c b/libnvme/src/nvme/fabrics.c
index 4572b9c5b..326287ec6 100644
--- a/libnvme/src/nvme/fabrics.c
+++ b/libnvme/src/nvme/fabrics.c
@@ -1228,6 +1228,9 @@ __public int libnvmf_disconnect_ctrl(libnvme_ctrl_t c)
 static void nvmf_update_tls_concat(struct nvmf_disc_log_entry *e,
 		libnvme_ctrl_t c, libnvme_host_t h)
 {
+	if (!e)
+		return;
+
 	if (e->trtype != NVMF_TRTYPE_TCP ||
 	    e->tsas.tcp.sectype == NVMF_TCP_SECTYPE_NONE)
 		return;
-- 
2.51.0



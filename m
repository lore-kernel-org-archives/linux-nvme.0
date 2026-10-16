Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF61CCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2DGvHsg3p95DZsVwADiFfgXPnEb5RStlDyPXgePKJCs=; b=0FHxOp2tf3M7sOZFIy+qvGK+NN
	jc78nqQOKU/Hm3WbSFRlOnM5yHL5wWr6dwI9CM2odEs2N+eC1EYzbvB7HiRTGHIqgkvVQLfyM5V4Y
	fLvmi/QcflDeytDP0iKO2v4CW9ZjRnXydGxfKhwLOdanasLY8KFHoX/smad2bh3m4SDT2sWWrHWG5
	TtBoi5HW9N5GJ19eYM+XQJzY0VE2c5QUhiCaQllOFDOhs/7GR96JM189WGLhr4s8lwZdv4TGDCm8Y
	8ldERY+ELyKen0U2pedx8JccOSsqAGlPqzG8l9dLBMYhmFeC2Oxe1IUW7JmYWDORke9WLRmN4akHu
	v7uy3VIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkGr-00000003Kq6-0P0p;
	Fri, 16 Oct 2026 15:55:01 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkGo-00000003KpU-1Hbj
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 15:54:59 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so85529a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166097; x=1792770897; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DGvHsg3p95DZsVwADiFfgXPnEb5RStlDyPXgePKJCs=;
        b=XBTSDDtKjiXEYKhMGuDIzqBAhGqeAkkvAYrmh9USpqTCeay4++AzvAYhqmL6IRJo2J
         adRXcPO+bsivl+fHw+3gh4zbnGSmgrrTSukMgE5j80Ay1Z2CLC7EsPq9pasQzUYnCw5J
         wVWt5c78/xGGkMlSa82uIRVs2iEQ3OfVwyFJ7X8glvElBYMPZ+0+fu2/5NqzpHfndHJq
         p++Xj8dSRfd0UePW+MfM2Ep0IX1E5SYhUJ0pzJSnv9A24P55vzKVyqszilwmBLSAjWpx
         wTjfzjWHVcG5fgvqkaAgAaIJwZp1Vci4g1sW2v4fqn5RGiryqeUFLWlFwwUQJh19DGbg
         yVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166097; x=1792770897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DGvHsg3p95DZsVwADiFfgXPnEb5RStlDyPXgePKJCs=;
        b=nakkD4HI3lIMMnBotrFRquOEvDLKkjKQtNJJJ+JnkjVpaN8Mg1wh+gWxHY0+HG6hOb
         lDZl74/LULniEKX/Ga3g9CGo4akUZ5/1E5dpZYn8Q9V4yD6DY5fGwYhqU0KPZiv3tkjE
         WxZlhxMBMbdqJvaZW+qq5UKpcKJSJA+sUUvXvdIRGEbT4pkNXiF3kg1dzJYZ902fDdQO
         1FroHVCGn1Y7dlsr8OLj0V0C8+9EkNKstKDGGDBWco0cwXaqfsi6H9tjx9BiB7g99L19
         8+ddK0w6/AOcWauUS0eZfLadNSHWFAH7aMNwOjRDwO6ZdubMn0q4wxQlQTDI1+SEio9+
         /bhA==
X-Forwarded-Encrypted: i=1; AKwUvBzQCvCnVJZRakTMyqhHhJlM8u+rzTZiWKL7FeUmhZpVWNV15Q51eh876q9vCJOjh496fDonUx66as6I@lists.infradead.org
X-Gm-Message-State: AFq9FYJ1VynUolCzG/MPO/YfhIr2bmWoxNLNxophucrAAEjky9JSYqa7
	jLchBK6NnYmB+Q9v7gmT/+wY95Fc0n1OGlngBUCFmJazb7HUfCrut2pY
X-Gm-Gg: AYBFou0nM6qU1caTPmVWX5CLq3HZYJTJ4SyvkgXfvIbYPngtfcr0rpHrCZlygE5f7nl
	/mSorT109QLxnrS+TZjPqKaW0pHjFPZIrSuN5GYZdL4clqVA5Fj8uAzCEW+anF+2xDVQHaBSJhQ
	pICkstk9EELKcAwIeixCMGJIhjZttUZZDTlBgv075MueaPHt8zK+NCIMH1ji4TeJzTApfCSNq8R
	aMVyD0yrj3psex55Oz/m0N6OEFaL+ZSevos4zBPJgjHpeMs2zFJHhrBOAkKnMat6T2/g9KROH50
	B5dQ4AQIELeQiu4StK1o+jsJHsOkWcoQx2pCcAn03Tm12yLzP60002343AnWv5PgLQap+tnkqiP
	tu0DgJ40t3BcuMhg/A7oIngK+QODsfK5c0OxwPnWKeuTW7e36DiR03tXuI5nss94ZJBoVPweoJ2
	UifwTtCIX4UgC5wShWKNTmZq/5bsJCDm1Hb/LUFEpeC1r6Hi4hxM37/uBx87YwoToBs2wFYzsT8
	XZDI1Oj2sc5aWNKyNSYdTxHboj6okLsnorUxxF1P/75P/EaFjA=
X-Received: by 2002:a17:90b:1c83:b0:3ac:a11a:7c91 with SMTP id 98e67ed59e1d1-3acef55d796mr192926a91.44.1792166097338;
        Fri, 16 Oct 2026 08:54:57 -0700 (PDT)
Received: from casta ([2401:d800:20b:1196:6a2:5930:14e3:f74b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3b798d3sm1920946a91.3.2026.10.16.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:54:56 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: paul.ely@broadcom.com
Cc: nareshgottumukkala83@gmail.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nguyen Duy Nhat Anh <neganhat@gmail.com>,
	syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Subject: [PATCH] nvmet-fc: skip port entry rebinding if already bound to a target port
Date: Fri, 16 Oct 2026 22:54:15 +0700
Message-ID: <20261016155415.10521-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_085458_340288_8C0A0016 
X-CRM114-Status: GOOD (  10.97  )
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

In nvmet_fc_portentry_rebind_tgt(), nvmet_fc_tgtlock serializes access to
nvmet_fc_portentry_list, but does not prevent multiple concurrent or
duplicate target port registrations from attempting to rebind to an
already-assigned port entry.

When pe->tgtport is non-NULL, WARN_ON() is triggered and pe->tgtport is
overwritten, leading to kernel warnings and leaking the reference count
acquired by nvmet_fc_tgtport_get().

Fix this by checking if pe->tgtport is already set before acquiring a
reference count and rebinding. If it is bound, skip the entry to prevent
clobbering existing bindings.

Reported-by: syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be62d4b375542ecebd17
Signed-off-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..9b7fd8f5bd47 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1324,7 +1324,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 			if (!nvmet_fc_tgtport_get(tgtport))
 				continue;
 
-			WARN_ON(pe->tgtport);
+			if (pe->tgtport)
+				continue;
+
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
 			break;
-- 
2.55.0



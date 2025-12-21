Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515DFE67495
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzNNutwwPYOOE5XQMImsVxgStocylnuPDzQADd5Cwn8=; b=MOIhJRcCXmIRyr5ab7Mcp5E/rJ
	TihNKF0SGHzi2dhA8vD8IshtAt/wLcZOlxkuVczeM0Tuw6g2JnbbGCubCuHdY6p1Yn1CKAHrv3i4a
	WENtoIMhiabcZ+bMBxEoo32ipPou9393pC/lzpsDDKvzwVfWqIr3euN3CvJ1cnTTbm7OZ3sE3ZCox
	7ygC7o5X3+sn45fyeuAgRGi+RDRz98wCx0pTy32EyMZQGpS128VcNOPlLGqvJlFNVJbVTjwNoaIeU
	D6uMwMBLufSUlfLrWrGQUg+KBOnmXo1Moa7DPNv0fpISEfXiW/8H+7qnaNRBz5ZMoEv1t7EWpL9Z8
	RGsrXoWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXQwa-0000000CmYS-2eU8;
	Sun, 21 Dec 2025 21:26:24 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXQwX-0000000CmXa-45wZ
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 21:26:23 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2a0d67f1877so42057215ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Dec 2025 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352381; x=1766957181; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzNNutwwPYOOE5XQMImsVxgStocylnuPDzQADd5Cwn8=;
        b=mDPQpV04gZEhVA5hgZqEHDHDrNofavS4S8vo3wr3gXQOUV9CDT5AostKCV/lzsseeW
         I5JHo1N2Q0/xA7xIv586Igl2YhK2KaYd1lVBm/EHG9UGM4VgFGUfA/8WsY4t5OfXZLbq
         Qx+x9DdOxDd3URsVo4ifhudhOV1ms7lzBytOdYXuMM4N8uBBa3kttBdMjZ87+Pqcf9jN
         wb5fh+a2diynQ3+84cfT5rKj5XUnby98g4nhV0HfNbiSNWK0cq6n3NjpfVjqGIlIJHWO
         w+O0abmACXU091HcesvokV2+mW7LxTC87QuDGk5aec8OelRtXeZBSeBuyDjVozrGZ8NS
         J1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352381; x=1766957181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MzNNutwwPYOOE5XQMImsVxgStocylnuPDzQADd5Cwn8=;
        b=hVpNjp4w3AkG34vkEiPkldSy4oA9B5XCl6Z0zZXCnHbfBhoUDckFELmF5sKpZjz5H1
         2/hu2rYQsAsUK8uM3iZAI532dQ0RQ1xH4Zyzu/eKaHepP2NzS+qFgtHgrcBhxASsBhk0
         upo92WZtjXVPa9cYisWGhhd3Qd5Jr0prKZH3f1m1Fb+YThmyR16nF5y5vAKCiGQkveJ2
         4XoN77n3+nMuCO/E3F/tYiDMiwkpQzobC6c3UiAUUCmTbrcgVZvMYsdhhKVESlVWKhR8
         Tlm2c2EMPDMqDy+xfpmYg/W7oGk6Z26SNVGOwWyPQjaAzzzS/C/alzDH1OvigOdteADX
         uQzQ==
X-Gm-Message-State: AOJu0YxPmZP0Aj6oMPVcZkASU65X7cYT/lx2vzw4aFuzeK6UFXhwXRXO
	I8cI1DT21KW7emySrukLbWh6oMly3rghG5kL/YivjDaP5TtS6heA8/9j
X-Gm-Gg: AY/fxX5ymrAv7QRVmrSIIzH3iTuG+q3uun+28G9gF1BuSgTuRKcoHemVnC4nkskFthQ
	D0DYLq5qAcKiHNbqfwezgNvy+SNHSCTLHR5jrkP9Gg1hm13Zm2VzPqYmcPpytEjKNLbYII9Im/j
	A6rCGIfwM/U43j6nsnvNE9AvgmhtkPFfSIZueyQo6ab1S/ohjAo6Rg54bZVkjX/5Or5gxgrCk2Q
	QfoSQMEbY+hHkmB6zo8bkmsGIrBg3KvyQ1T60kG6OfH+kYCO1whBexfvKVSSjk7QuUR1sImDKq1
	3DiTrhg+B2wgjfIpgFuEXcNoe9/iGepOWZdcjaZo+cGfH+0akJ+VZT5WClcdvLdcOcwny3u8xa1
	PenR22sekScdcvPm35EDU777kn2DYJjqepCq/Y9GwaLHhNUbgdHB+Tdpcg6RiqXUuerjf2klsh8
	FtL+t7YXW2LegTWKdK+UeYdw==
X-Google-Smtp-Source: AGHT+IGET/zemvwkcThwrXSlT35N3SWE3SEyvdef7Qp8vkm7Ot7k0L85/gWs+uh/4cILSpdsqgoTcA==
X-Received: by 2002:a05:7301:da88:b0:2b0:5435:2e04 with SMTP id 5a478bee46e88-2b05ec1c6aamr8533522eec.19.1766352380860;
        Sun, 21 Dec 2025 13:26:20 -0800 (PST)
Received: from [192.168.5.71] ([172.59.162.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm24884636eec.2.2025.12.21.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:26:20 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
Date: Sun, 21 Dec 2025 13:26:10 -0800
Subject: [PATCH 1/2] nvme/host: move nvme_ns_info into nvme header file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-nvme_ns_validation-v1-1-9f7a385707af@gmail.com>
References: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
In-Reply-To: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Tran <alex.t.tran@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=alex.t.tran@gmail.com;
 h=from:subject:message-id; bh=kNH1BF9F6TtGl+l+aiqP91q+e26HBf7D5nKvJFkGnkw=;
 b=kA0DAAoBdPl9NEQmzcgByyZiAGlIZfmg2jbvvn8Fb6cG8SIaVHfqcIDrPmuN1P2QT/gyOHa0e
 okCMwQAAQoAHRYhBACiFWIbThJXFRWtx3T5fTREJs3IBQJpSGX5AAoJEHT5fTREJs3InIwQAINU
 C28BM5GzCqbii4pZz5ns9+UisvVH9Hwx/uX58hw0sSA8JJPJvGP40MuNAEbFqvltW8CwbznRDwu
 +DwUyXY5zJNc5APKea4VCzBVRM7Tfe72pxfYYJWLIQDIg8AfEXZ12+y91Z7IOSJgZYoZG2IXYLE
 URjdFpFT65Q6s2fMhSSs/qr+fXTWUQ3dX9uVXJrGolU3HMp1aXsqP0BbfwOo27H1ySm6aNkvkyF
 0O5Jb5PLtBBNNSl6xaXEI5awOPGz3D+mIAnoVKlHY5Bayhcojxz+7jKGsBmYfrn7+F3b1j3gYL7
 SMa2rn3uy5AIhXhadIdT8+2q/H55UQPcryAQgVOAhPTdnGu5Qx2tDf1LTg5KCKPTFJEMk8gH9CC
 Qw4cbZ2ixBNNpQEW6t/Y1K8Jmr7Xu4vLlr2VnU4R4eL/mXAk7aC4s7YY8dElVI8u92h98pGb+bV
 RKui4M7vd/DnEx9lr0QaTsWx7R2f6CEPUpR7t+GQovTsOR83iWF1AN8BM1KTumtzYfKe7Z4N39C
 ZniPbhDRZL8DyGWYZCv5jxs56TKqu+qpHWX+1qFBHGUsAZKq4iitBcIYXgLy+BMkHceuApBoete
 7AID59hwWrYC8FpwhERzCEhBPLnnL8TviHhl286T2ENLV0mCzgcMBrkn9vV7kb419ND4O4AIefn
 po5jk
X-Developer-Key: i=alex.t.tran@gmail.com; a=openpgp;
 fpr=00A215621B4E12571515ADC774F97D344426CDC8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_132622_020889_49B9A2F4 
X-CRM114-Status: GOOD (  13.05  )
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

The nvme_ns_info struct is moved into the nvme header file.
This is done because it is used as a field in the nvme_ns struct
to store the pending info being used in the following patch.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/nvme/host/core.c | 15 ---------------
 drivers/nvme/host/nvme.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f1f4d0b3c570de285a5eb17bb08e..fab321e79b7cdbb89d96d950c1cc8c1128906770 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -33,21 +33,6 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
-struct nvme_ns_info {
-	struct nvme_ns_ids ids;
-	u32 nsid;
-	__le32 anagrpid;
-	u8 pi_offset;
-	u16 endgid;
-	u64 runs;
-	bool is_shared;
-	bool is_readonly;
-	bool is_ready;
-	bool is_removed;
-	bool is_rotational;
-	bool no_vwc;
-};
-
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c5c42777bd9309a983ef0196c1b95..ff4e7213131298a1a019eaa3822ca26f857b2443 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -525,6 +525,21 @@ enum nvme_ns_features {
 	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeroes supported */
 };
 
+struct nvme_ns_info {
+	struct nvme_ns_ids ids;
+	u32 nsid;
+	__le32 anagrpid;
+	u8 pi_offset;
+	u16 endgid;
+	u64 runs;
+	bool is_shared;
+	bool is_readonly;
+	bool is_ready;
+	bool is_removed;
+	bool is_rotational;
+	bool no_vwc;
+};
+
 struct nvme_ns {
 	struct list_head list;
 

-- 
2.51.0



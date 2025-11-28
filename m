Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E71DD116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=; b=z24P6FSjXXgjWBbPFHzPy9GhEm
	pxVOQRD1hYM2kLwxYSVKdFFuTAP7DoEuoTCj7oidp03YzfxZTvsaEUKkgKkT7KiW/odfbA0Idi4Uq
	Nbu2bGGpeZ/ZYmGPhqVsiznEb7BUI+0X/Ezt6FvgVwwwat2KA+wNs4pMtMzvXO1xvPAsdIcYKadQZ
	QO15RWmixgtjV+y50qt0JFk90gC7+Ox7un0b0ljrVVgKGZUOhhxCFdblXsx3ZWhSIkEjHeH3PLVK4
	Up4WVNUTepIRlJpZVtwSRvidGY4u3fbUi1935DjzmHJ2+40neTwoh2zrWU3XpwBn++Mi4nmHyl23I
	vPuegWbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuM-000000009IP-3sGv;
	Fri, 28 Nov 2025 08:32:50 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuK-000000009Hg-35U0
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:32:49 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-298145fe27eso25864525ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318768; x=1764923568; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=;
        b=dYp32dDSrOvbf0ydj/+imweIafZi+I7bptNX7/AjPnC/n70x3O3C8C85NrDF7OUmAJ
         Bv3dr65t7SprHWGiGEXKu5aEZkUabU4gxYsGKNls1P8Emq1MqDC8DEXUMeFrpHoYzkY7
         8jQP6daEYFhBTnYIMkp7y2VXQWmsJqtbYQ4V6GEh/mkIzkMqVoQEE/ln4+vcMwsEZ3UN
         4fmbd23RdMaxFJ8V3+Rj0PGEABCjeC6KPLrlBqx7LfTZKQ8bRBwnXW0A4/mdeyqin2/r
         4xIEktOwOu9riLcaFsjXKip4ef0pCLYXMdpaUkBpexTMyzthHALfv5E3pf0oKY0nqwhG
         QbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318768; x=1764923568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=;
        b=P35sz8tjs58r3oVnGI8NeTEa8UMOPP1ySfA8yf72P4QKenshUHmBaFo49R1va/0fyt
         PbZEROaVDOGzKrGsFqTC2YEdZSnfAfclo0APS006APUKfVe58F1c3u9G0L2punlAZp6+
         LQExtM33OJyrBvRbHY7koLODjTzDHrl0SOrKrZoWq9Fe8D0ik1dwhXipZUrP7rFOmOR+
         RKBK95fBGPlFlH2JRRIglnTP7p41/P/UAgLhIClDZ0ieV2gIix0EorgyBKnaOxTdiVh6
         zslQ79nOLmlnbD3BSkZm5cfTYgvsXi/TLE+nkOSQCZ3oV74iHnV83E2/SqEZN0gKUouc
         VJFA==
X-Forwarded-Encrypted: i=1; AJvYcCVTgafag8d1Dc2qc7ZZuixVXx0L+tiE+cHsE/RJnN9yi0/et25v7QuHCaF6iW/e671/iyMdEVp0beAE@lists.infradead.org
X-Gm-Message-State: AOJu0YxSG6gpa9LiTDKf4/9E3vFUa5PZ9QJRbx+XUSjWVnqz3QRUBR1u
	NlPzYq/FqYY7vgl6yw/3DyVwRjHACYQsg7WonGR7mdzCjCkIXDv9LPKkLccicApr
X-Gm-Gg: ASbGnctxwEdIK2O0ejveXv93qcXSpejyODtwK87hrbS/BmAt43H3LZFj5AcagXTL97J
	UNQNOQxH2Kvh1K36Mfa40zb3n1bYrQn0XyyO0h5Ny5FKg1ij4+r4cGelpg8IBVEkK6BXFwvmAg+
	vvUKFfk6IiVk9/5dv36HuPfrHsT+iUHcix/TTrXSrDpJjWq96uxYVLA5neZ5wN4pN2wb9gPCHlu
	gQ5szb1sw++0ucUyNflQr8Af21MgMfP3QfMir5Io2t6jmv4w+EborFjz8I1Z/QS1urI1HKEKPHg
	ICzL0N7vm2HlCgLBUTVn51xYOek38kSnEHZilKOBFHDAc2BIdqhnB7lF6EmrAYArdz6YXT9W/pZ
	1/RBPyu3yr+T5/dNdS9zmLh+AZOtt5ggQ+ZrL+U913Du9iBvsMrUhyDFTdamfn+bP/Hx+SWJdVK
	hozDn5LN370N1FfT1GlHq0D+4AFA==
X-Google-Smtp-Source: AGHT+IExXZt7YE3nF+952Md7MiVvxMbDW7G+yswwYtoDXLwvootnd7yuttY35MGv7RVbIjqP5duRMQ==
X-Received: by 2002:a05:7022:670e:b0:11b:a73b:233b with SMTP id a92af1059eb24-11cb68354b6mr8088695c88.28.1764318767897;
        Fri, 28 Nov 2025 00:32:47 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:47 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:09 +0800
Message-Id: <20251128083219.2332407-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003248_777876_CD0F58E1 
X-CRM114-Status: GOOD (  12.67  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Andreas point out that multiple completions can race setting
bi_status.

The check (parent->bi_status) and the subsequent write are not an
atomic operation. The value of parent->bi_status could have changed
between the time you read it for the if check and the time you write
to it. So we use cmpxchg to fix the race, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..aa43435c15f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
 static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
+	blk_status_t *status = &parent->bi_status;
+	blk_status_t new_status = bio->bi_status;
+
+	if (new_status != BLK_STS_OK)
+		cmpxchg(status, BLK_STS_OK, new_status);
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
 	bio_put(bio);
 	return parent;
 }
-- 
2.34.1



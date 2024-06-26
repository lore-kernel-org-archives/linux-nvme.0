Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8253CC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=quNMt21k5Tu+QFDqj3HStB/o/6SWdJctxGCAsXhdbxw=; b=gaEDiX27T3ntfEqfn46+Hdc12d
	oKikl3WO6UXVpJhxn1PYkIDXHLWTLkVYv25NbDJioRKdravacB5mY3HJlcspHP9/+O6Md46u/Ys7c
	7s7haKEZBIvAgOeO/kvhtZnraSxOKk0dlrN5A5xYESct8yl2qvW66pO8EBMbe8Ciat5Gowi5VCDxN
	nh0+Oge9JJas0HpgdaBC242Rub5pJp3bWBJDZolepClg55kNQqmBygnec0/Kh4yOvCnuDZ/Sz/Yoo
	6MfKrVxS9QV9LGoEPANY/F37Dg7dYAiZX7vo28qT3XrORe24t0HvjkMvN6Q7erOmZio6zbYVPbVaG
	qmuKIEfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbt-000000086KK-3Zfm;
	Wed, 26 Jun 2024 19:47:17 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbn-000000086H6-2lR7
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:47:13 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6b5031d696dso32806866d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431230; x=1720036030; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quNMt21k5Tu+QFDqj3HStB/o/6SWdJctxGCAsXhdbxw=;
        b=iKyh+qhFhIK2eotCWB3iLf7m/Mg9o7lTbvHjJoQJZIsSdjkyzoZSyHFp501881VPGB
         ogqmNqFJplmXSxKaft47j9jGUmLrBZ7h+kgVdrIyg1CkBuUUnINIBCY5LsGdz/PJ/RUL
         HwpbROKkir5BhHeePHBX8ZCqlrmV0OqNszz4MwF7rTL1BsHDaelANLpz04engvgQiA2Q
         kcKsRz3eeAeyFu2juj3VIwlbURfWZHtfpM5rkxoiwTRy6Ev383YDxFicQ2rLiYZYsI4+
         95rsJCwzvQRm1Gk9TXNtI0qtXMsZU0h4MFeMKAgcGj77RlB7m9IdQkxSYUkVpvZVxscH
         Bf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431230; x=1720036030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quNMt21k5Tu+QFDqj3HStB/o/6SWdJctxGCAsXhdbxw=;
        b=FNLmiCA5t4sQyDneaFkowQzHF5MQuc3Ib06tZXiiWX8C655s/GN9ZZPGiRnMfcWDmC
         7Lka0OpDVt5NTlTh1o8yH5vsfRT1yE5vaZYY3rCWfkUX4VOl7M8uEcc5JHuEct+lD8CS
         9x3c2W2SBKModHv0S7HFaAuGypDu/CTYMtUwgKG0uLZldoX/egmKZFa8Hzm5gp29cUtn
         9rRb+qzB/+iNpBod+zPeItZ0Ok2iiYgT/LAUXchNQqPhP235W/hvuJln1XMNDWslCno4
         6HmJgYDDd6JFrQIkSECT7P4+tMO10qL5MHbjCRe0p0uxOiRs8bJIiqR+CmMaa6gEDaRF
         Pr1g==
X-Forwarded-Encrypted: i=1; AJvYcCUcR8A1kTvUB1t13+zzuver8rNIy8NFFzBMZRigtoIsFh6Kskt4KLcCP7/oyWFlr15m/WBwxmuD/UOZJ23gjBlRB7eAz4nyMDUp0ZZQtm4=
X-Gm-Message-State: AOJu0YwVBttyXdJbLnyI+VRpzI1dzIyVhNh55TJ9VBRqWLYnZgeDYWhY
	01T6PjpzGyj5ildMTDHnAnxOJdrZ8ULPPk58iU8Tr1IPS5cSxyYM
X-Google-Smtp-Source: AGHT+IHM/Hxcy2etI4hhkfIvRl+8PUp0crGZyN/TKijgBq+jzHdzfOIXVu30DrVTR8nykcty6UyYRQ==
X-Received: by 2002:a05:6214:1630:b0:6b2:c840:7a2 with SMTP id 6a1803df08f44-6b540aa8879mr114912716d6.45.1719431230584;
        Wed, 26 Jun 2024 12:47:10 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:10 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v7 1/4] driver core: don't always lock parent in shutdown
Date: Wed, 26 Jun 2024 14:46:47 -0500
Message-Id: <20240626194650.3837-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_124711_828159_5D7E05BE 
X-CRM114-Status: GOOD (  15.18  )
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

Don't lock a parent device unless it is needed in device_shutdown. This
is in preparation for making device shutdown asynchronous, when it will
be needed to allow children of a common parent to shut down
simultaneously.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..03edf7a7ec37 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4815,7 +4815,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4839,7 +4839,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3



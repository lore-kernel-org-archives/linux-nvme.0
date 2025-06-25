Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F87C7EE31
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+3SW8vJVKoCSfPWTHdZMGnwJ8NA6WVZ3bsZQcUT5XA=; b=4HgsdbsIFqxTnyvVEImVZNkEqq
	FaimPO4Vt6kEh1yW3CPLmFexvx895I90gyilriWj+kmWUNsBkViOi/Q7VrKK7y12etTnapyUVLrhG
	SRZV/dfgbIEYvDGN00qcKdjUyzWQLA/ovUu4IEeiU2+hanXOrIGZkaz8dc0YnwRCYzhLlURQwm5SM
	YYzfsqyPjkqZehiPy6U0GDg9OZc6+Id5jUqe+JCF1K2+iFa2tntMiLi4leOlmKCa0ens0I8Bn9Rz6
	k3c6X8h2mEdJRUUQS0VM/niFiVfyMrnCU7pCYyUxQ5BlpllBnRksWRVl25HpHbIQr+Ayqf1Ds7LMM
	Zb/+QITA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWrr-00000009tEZ-3fQu;
	Wed, 25 Jun 2025 20:37:15 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWaN-00000009p7w-49fh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:19:18 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-73a45bb28f1so664734a34.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882751; x=1751487551; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+3SW8vJVKoCSfPWTHdZMGnwJ8NA6WVZ3bsZQcUT5XA=;
        b=LQZdntWZb5fCehljHjgBJJI+lvMYgE81NYpSAKustQyaHl2D4dpDL12x8CVPH+2jfx
         KrDWqeVDqXcXi7yfJGlQ/aLvemrPrRmaaOPVl688yEJU/l1P6q4iBf40ZYXFn6d6d6n5
         pz2mYG20xnA8wj/ks0Y6pLcu3J7FYQYDz1dnZdTHZ2Jevh4PGNNUZ+3p0kOzWyuQ++AP
         f4LsK+6TsP6XnKGhcWcpZlNvVA5HiwbA86euaLwFZB3+na+QEohVJxAqK/Eo6Dd/zhB6
         gk0V71rNq1hPsxBPBiPes0q389iVkhgKVnPoOc6Zw+AX/f7EkCtXwo+aiXWY7YEld23d
         xR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882751; x=1751487551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+3SW8vJVKoCSfPWTHdZMGnwJ8NA6WVZ3bsZQcUT5XA=;
        b=Ob9ciciwd/2i7QJ8Gf8TuI4PbXwgariTiAQB/eztImGmwku79bl9slLDENMShWD8i6
         qCzR2bH5k8jiBClxmprPrIAiIBO7Zlc4sHvK3V3vRnSD8NIrtM/wHcj5yBzUrKr1ufP2
         R+CKxOGGwLfzIhl3v99nDGgj6LxzglpuMggLmkSSsGOqbSl29L5kOIzNnFWPO6z5h/VV
         BYRkvClkbSkN0XyVpaedbZoh/sMQjLv1Cb9ET1oUhqialmK4UlFMsfCv9D2X6kG0HQgk
         xYNu9yd/EbxVsCfaN/KOlY59pTHXM4tfka1Igw9J/gAbhrhgdj6SHgE0YgX5fUPpalOC
         wujw==
X-Forwarded-Encrypted: i=1; AJvYcCXB/1omd8Jh5+7rr1IoDCkxSfA+NvLbL19MH8nwybZS65DJtFVoSbO9yluBS0q0WUuQi5L0HpE10MT/@lists.infradead.org
X-Gm-Message-State: AOJu0YwEL/6FlYGT02OvDcwL0Dq5ebmUt0ugRfNbe3FC4k1uky1Zgbfj
	RuWf1paGvdsnOYC/mZnO0TaTeyRAvCWG1tUpVvgNM3es/xxOvib4cn3z
X-Gm-Gg: ASbGncsVEbLXQ6bqUIr6FFalt9BTD5NbHuee1lRj4xGlb5xdLYKProBGP+fW8TSN9OT
	mlF3nR+EesjkoFpecc/Pkbu/EAXybniqoQ60TvRM9cp+OYxPqfrlbBOKNoqKc06Sbh4ANvVRiVX
	S/vIQ7WjhcpVn42f2DwBnkP6bxKuyjwcWAkgYh0DhFZDX7TleZFqirxv2yYv/RofjuoT4RamFXs
	75ii73sALcVfa8EoPbwO1TO1DE9Qcq9Dl0YcZLSm25zEC/Y+4YtT5kO9h+BGZxA30h/PVTSF/aO
	zjJW+H+wLfjd2NLXEXLrFgUa2aZXTinGsfdcux6Z63KVRiFniUjXe5S9LSVotSNW7axhfCNCQje
	LEtksGWU=
X-Google-Smtp-Source: AGHT+IH3tdJswFN36V2uHSc+zADQ3AIuPT/3nG6JE2jqxtQe0s1SSwBgNwMBzhMPrf7gPrzC+jyOYQ==
X-Received: by 2002:a05:6808:3021:b0:3f3:d6f9:69a5 with SMTP id 5614622812f47-40b1c8ca908mr942017b6e.8.1750882750920;
        Wed, 25 Jun 2025 13:19:10 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2319188b6e.42.2025.06.25.13.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:10 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v10 2/5] driver core: don't always lock parent in shutdown
Date: Wed, 25 Jun 2025 15:18:50 -0500
Message-Id: <20250625201853.84062-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_131912_034294_BAF05355 
X-CRM114-Status: GOOD (  15.08  )
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
index cbc0099d8ef2..58c772785606 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4823,7 +4823,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4847,7 +4847,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3



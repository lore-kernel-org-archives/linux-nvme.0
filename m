Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5544FCEE339
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LPm/X+fl96wDokyJYUzE4ML1aoLjDUpa0pIP+DD6nQ0=; b=dzi6aOR08+iFVSq0OuYwvEC/4n
	HGu+/lCCdtDgLb9BfUgY77SGZKpH8XKjrySyM3hSyr2FgPfISPyIEl5M3o6dDiVoojA9QEFmOSKlT
	JElBiT1VOfdAlh4Y8zOwdOsU4KIzMYX+XyNfwr0PkRB/2iLz36MR8cxZVSCacv+J7kuX3p1RyUBdU
	nfYjxhd6fh8lv/5+3/CwqmzMkB+EnFPVJvJpYsZFghjE1aWcDXElAejjbC7i+3MQiYdsMBHKDFJ7I
	+NhIPUOmaZFaVGPAjPd63lOfB+akNHYnSzQgkUxriQBCxHEFWF+JKgRsPu4TgYAh0kqpS8PSNDh8n
	wR7a5dZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syaxa-0000000AIRW-0PjS;
	Wed, 09 Oct 2024 17:58:54 +0000
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syawf-0000000AIBs-1UME
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:57:58 +0000
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5e9876999cdso20762eaf.3
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496675; x=1729101475; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPm/X+fl96wDokyJYUzE4ML1aoLjDUpa0pIP+DD6nQ0=;
        b=MlRI1mN+C63z8wpw/LrVfU/mKvtbHzPwU5ipG4UxZ7GrHTIr0XnVBoXKJUFRXrHXSu
         33oECOZHdclrWJSIDspx10M+5BTMMiOd0CztArigKtztvfw/N0P5pLn+0r7XIlFe+Ndr
         L4n/HDeYBqhMDgb+HHsjU5O4wpd5nI4mKj8RhwD0XE/92y+8wn53Or7W1UDAi9jxMmmZ
         N+ToIN8CqNhgLnFK3OwRT6/allZTAnYtLWLzR554X/mj3F2KoyRvKrVsylovTxB4EHaq
         Qa47PVmiuhrUhuO7kriXazdsi2SE+4jQlgUVpNsvY6s4GQU+IjeJH4yX9WeerBtuccpz
         U+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496675; x=1729101475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPm/X+fl96wDokyJYUzE4ML1aoLjDUpa0pIP+DD6nQ0=;
        b=Yx1IwibxW9HcrB/uqY/xOCd+xakr44qizYlLzFYzqtCSxZdjg2V9bVfaYVExBVemCo
         5Kr4PLHz1GIImGorY4nv0NhoVG2uUf56yWgLJJ1ov/C3NwrvmnNb0FPXSY1VlEIEVWuK
         FYI3kh4nl/Kau/aa68mY+tAS4g9H4pW38a451OQ7ZozGIM5ZLNP/KAlYX/9ZavDmvU6A
         vFki4M+MFETuNxC1guxoDAvDnAX6Cs2HFhDHPJ0c8zRRvtWQ/OtezuS9/WLY6XtEg0u/
         LQxGDb1hMP86YUPDnmlgAiT3mHX4ZNealH8Ae/i0qYb/vvEUrHQCOUJU+D0N445weHp3
         3ltg==
X-Forwarded-Encrypted: i=1; AJvYcCWbqwyyOJbDD9Z6GDQZIyvs6wVsMhttX7nG9JJaXUCLfozp5bV/6MeRq/tVayhyRJUrjX3umwMCnHVl@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+iPSp+1HX2QJjLp67f6M/Xl9PjJeUIgkpR0Q0Z20QXvl29bDK
	sOZ8OodTj7HlhZHPQNJKWlLiElPB7vQ3L4b0jmO9iztiVkzMFP+i
X-Google-Smtp-Source: AGHT+IHq3n5qVynTl8WGUVgCMZSQGlNypP2wpgIrsgNF+ymCZyRCtVqjwo6pYhcKUfn4qky9AfEi4w==
X-Received: by 2002:a05:6820:c93:b0:5e1:e748:7d2 with SMTP id 006d021491bc7-5e987a8eda4mr2540631eaf.1.1728496675654;
        Wed, 09 Oct 2024 10:57:55 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:55 -0700 (PDT)
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
Subject: [PATCH v9 1/4] driver core: don't always lock parent in shutdown
Date: Wed,  9 Oct 2024 12:57:43 -0500
Message-Id: <20241009175746.46758-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_105757_423317_B2D31276 
X-CRM114-Status: GOOD (  15.16  )
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
index a4c853411a6b..2bf9730db056 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4816,7 +4816,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4840,7 +4840,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3



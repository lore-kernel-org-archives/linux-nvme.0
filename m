Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1334DCEE33D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F8vdUqTwAeQy+DBjPCY8gBIxE4oT4FIOu6arJHu9ptk=; b=DlS1rrtzK1cGkqcCKx5bsJxYhS
	zKzxSkIoWR3nhaXoYm6kWGhIcB27oFe6gNdj0HWDbmXopDB9Ilk9goYfM6UpAPRUggpC9L3ozl+S4
	m27Ja6pcnb/hSp9cuuPcNPdvWNmiYHWrT0lDx8igJsGXXQPy9iZOX3v+3V+g29U7Xb2FKzIWmH1Np
	C7KJGCjkNrTTijx10Xv6N3RPIe0x5haZ5rSPNfh3DjaWoV7kRj53D6n1IV6W/NqX6JQgIHQOndmur
	q90ZPwp7W/61WDSjTs3mS6gtBT9hjh0ot8ggJSNCvqYojt8QerSrL8MoHsPZ8xdikMPqhE4S1lgTX
	H0z4oy7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syaxc-0000000AISs-0ahE;
	Wed, 09 Oct 2024 17:58:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syawi-0000000AID7-2xIY
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Oct 2024 17:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=F8vdUqTwAeQy+DBjPCY8gBIxE4oT4FIOu6arJHu9ptk=; b=ZM0+calzhopjroaOdvbcnm8UQE
	il0cX5KZXC1Xx7KL1t88fnRwEoMzZ8Wb53WOVei3Z1g5bsyiUsQnYlyXjg08Aa35NKA9CgyQh2z7y
	XeMoZqlbt5YaRy0fJ9K7XYOT2QG6bBETNiQ1W0xs40OGqSrdywYw7Ah4AlGpPumjtSA4iAqhktGYS
	91yJERX4uV/jYwNVxIK0/eG1ouPw0r/Uk5W1D13g7JUfvTKPOvU2zxYABxj6Vv4IEgfexFSKSX/UD
	N5H1Lp8zZg2onRdIBMdqy9u+lFZ/P26S9pxlDroUmqBaO0kiWHV5vWHwYyuzlzvu4AWl/aUUJsmit
	GgOtMNhw==;
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syawf-000000054LR-2xAm
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:57:59 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5e804f043b6so26872eaf.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496674; x=1729101474; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8vdUqTwAeQy+DBjPCY8gBIxE4oT4FIOu6arJHu9ptk=;
        b=IfyTAKJiPWUbuuxUtz9oUxVXv1FabeYhhrL7Ndb2ehezuJGwsjunUkXQv2/pr4ebUJ
         AyG3dycwd1wGhvtXBXEa2eneeBc66ABuJqXjqcVTynrbhOtZVjCieYrOV3UkEKtJ0oGo
         h0uPu7f09YngU4FUJTHOZWJVzrmcSCl3oSWwW1W9/qkIG1NFdc5CT6J60SQu66fn+9fB
         tpckUI1DI7w5UKh8zClEh+EgaGMdB50fmb0n/mtyXNOnzqEY1K4yF6WXC80i75kXGrOY
         cMZxGsVa03SqD/hX0JiW/mACuI2SVGpoa+cC+IUas/oZQKQPFcbpDuH7jD2N+GfH7/t1
         Fx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496674; x=1729101474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8vdUqTwAeQy+DBjPCY8gBIxE4oT4FIOu6arJHu9ptk=;
        b=CuBzvklhJTa+2DR6maUinRQNMsZARDA+CAV6U10DMq5IuZ80PR/Fx60kgOQ6DuPy6v
         IoOWGzgSsxhAqdXbMi/QywDWXP6e/kxIT46XK4QBapPl/NLAtbGkdR8f1jw8g565YRVk
         Ort8e1Rl1NLxKCLxsFO7PQyMD+fkGmpkxjWnSTtrb0x7/obS55MqQU8KZ1U4DYEN3Vvb
         /4FgZUj8ve72jSH9c8sAh9HdK3PjFxFeS00IsWpW/NESGq4roVImwORB3LGqcwUSiFEq
         9Yls1WFaL0WxlAadUpuYzNYiOwu+UoOsN9vebefwJ2Okc0nU4uEaH1Wr/wO6UxJcPOpR
         GrFw==
X-Forwarded-Encrypted: i=1; AJvYcCVtSFjcQ6I0TgRLe0rFt09xs1P3zFBBS6UDhAmZTszP/YNpdXnDRWbA/u1gAPYvMzWpa9/FBS2vXn4o@lists.infradead.org
X-Gm-Message-State: AOJu0YwTa9/6IG2lSvbElqQPkGQQvSTLDzYXcfC/JqcJBJqA11/IJxUm
	o+KTZfsksuP6JBM2/lzK3cjPXT++hK6hj6/kX6qwugztsaQrJxny
X-Google-Smtp-Source: AGHT+IE84LUL0LOcNOeXvoKlVeV0GFii2lBodn4kkLieI5aprfMaZbaKqPhVzXLAGZl2YkmHz7QHsg==
X-Received: by 2002:a05:6820:16a5:b0:5e7:c504:1fba with SMTP id 006d021491bc7-5e98794421fmr2401442eaf.0.1728496673825;
        Wed, 09 Oct 2024 10:57:53 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:53 -0700 (PDT)
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
Subject: [PATCH v9 0/4] shut down devices asynchronously
Date: Wed,  9 Oct 2024 12:57:42 -0500
Message-Id: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_185757_817502_B3E77D14 
X-CRM114-Status: GOOD (  16.75  )
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

This adds the ability for the kernel to shutdown devices asynchronously.

Only devices with drivers that enable it are shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Changes from V8:

Deal with shutdown hangs resulting when a parent/supplier device is
  later in the devices_kset list than its children/consumers:
  * Ignore sync_state_only devlinks for shutdown dependencies
  * Ignore shutdown_after for devices that don't want async shutdown
  * Add a sanity check to revert to sync shutdown for any device that
    would otherwise wait for a child/consumer shutdown that hasn't
    already been scheduled

Changes from V7:

Do not expose driver async_shutdown_enable in sysfs.
Wrapped a long line.
 
Changes from V6:

Removed a sysfs attribute that allowed the async device shutdown to be
"on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
previously "safe" is now the only behavior, so drivers now only need to
have the option to enable or disable async shutdown.

Changes from V5:

Separated into multiple patches to make review easier.
Reworked some code to make it more readable
Made devices wait for consumers to shut down, not just children
  (suggested by David Jeffery)

Changes from V4:

Change code to use cookies for synchronization rather than async domains
Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
  opt-out of async shutdown (when not disabled), with ability to control
  driver opt-in/opt-out via sysfs

Changes from V3:

Bug fix (used "parent" not "dev->parent" in device_shutdown)

Changes from V2:

Removed recursive functions to schedule children to be shutdown before
  parents, since existing device_shutdown loop will already do this

Changes from V1:

Rewritten using kernel async code (suggested by Lukas Wunner)


Stuart Hayes (4):
  driver core: don't always lock parent in shutdown
  driver core: separate function to shutdown one device
  driver core: shut down devices asynchronously
  nvme-pci: Make driver prefer asynchronous shutdown

 drivers/base/base.h           |   4 +
 drivers/base/core.c           | 137 +++++++++++++++++++++++++++-------
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 4 files changed, 118 insertions(+), 26 deletions(-)

-- 
2.39.3



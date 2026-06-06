Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACD1CD8C92
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NeEBBh0lNzCCAreOc9bk7WWW8nd2UTHn7HjqcTneUFU=; b=jhiXrmZv9vb5NsttoIglOL+3Pd
	Z45veDqZyTHgzF/4SNNN7YvSh7TnGD2zU5pQiSRBv17Fa6CHsDEgg+u2CEDdqKPXpxmsdkoOoy7lE
	qjhj7oWm97HXcRYu9ZV/G1oYiTqhla2yJsAylQn9EgXa98pVnfbOp8QCmvr3n5XSiqW9QssysrLFV
	XNe1K7QM2wXysywIbnxV1HI9vGFIrlfNInvFqZBW82UGkk4xXgX6YRZ0M2N58YAHM8fr8Q91XT3/Q
	8Obo/FXBe8VKlqYdx/xofyG+L+hhxcvQG3Uj3rU1bRsucaKcELPJKIE3AMIDvbpJj2GNIP4KhOTW+
	zFxx8jtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVr2W-00000001cAq-2mv1;
	Sat, 06 Jun 2026 13:26:16 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVr2S-00000001c8Q-18HV
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 13:26:16 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8423efd76c8so1935750b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780752371; x=1781357171; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeEBBh0lNzCCAreOc9bk7WWW8nd2UTHn7HjqcTneUFU=;
        b=DW5Hfp1aHZlb5Fw3I3RwBy6yzB/TEqU3N/PcykkSHnUVGQymgrJsGL9HG98pbtBHSz
         Tc+6sC7AOYnovM7ADN2W/hADVlWD8EZ6IMeQ4cbuPceml4JlSR9q2tYXGy8h39of2EhE
         pmjY+GKf1aO4yEV8obrndaWIPjP0DDGVKHi3t1HmRDAL6xUtSk6f39yyUcaH7F4CJH9Q
         aRFDOr3Gi1CFAQWTIVXdJmbo52ZfFkjtPVFHHzWwsnVK/Pc5xEn/kU4VpaEeEmNmwFZC
         +48w5iJVSEh2DU6T9dPq79RRiOEhLH3iTCCzME4SdJaf8nCdfKY5asVrmHPsWnQamMtm
         aAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780752371; x=1781357171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NeEBBh0lNzCCAreOc9bk7WWW8nd2UTHn7HjqcTneUFU=;
        b=OzvqJUY82Vmx3ETTnLuH/tF7J7666rd94CFk6KQK0f7CSotF4AjhoyQDU3jG00ly89
         kRgvms4QzX2vJpY3ZssBykABaixOHXnZj8NvlqjZ0/HiiLXzuZWQTkz69CcrUHKZZHVx
         LvANuE4tgjjPfNRicji+KUAUvmQhf7mYcc1+e1pxer6b4hNNH3lNpLMCjeKT8phKENpm
         ktqlw8RaCp5GMXXZQVVxiIhuWCNEwanoI3TXFJ89tgtXWxiYa6VVwOdvqDbx+Go/6QKm
         KmyUsCgSmcCNYLHp8ckmuQJ3oiYIQIbxF4CF/Oe5up9h1oAWKP77IeDpibmXtK7TLV+J
         pm0A==
X-Forwarded-Encrypted: i=1; AFNElJ/ngHIYDMAlCCsIErdikTJwqVnhnBj0jcPaw9qM9CoSJ4RXePBa/k+urZ4Z+c9hvKYcTQPXLZWtFKhj@lists.infradead.org
X-Gm-Message-State: AOJu0YyWea5rGwbx599zwTYGNmZaxDetQHic4LBat7LLGy+XSXh96+DY
	3SfCEL7noufvV8EkJUQssegl9YBjX0/3IRIC5bCjstNWLkvi1r6vtUFE
X-Gm-Gg: Acq92OER07+yZplia24skHim26gBpUvbUlnnYVQW8LD+WCAn5Yo0CiefnXaBhwkez9s
	1c5ZDL3uCf4BME8L+28t187sAd/f+5lpt9c2sytmsA7+lctg+iuaurnk9MH+5D9wTEkx9qDhssO
	G6lqgxddfTXlZJBSLDsQJMwJXPZZgmIpcvqK04uT2d3CVru3NMbDjHTbFzCQKnyW3eKeCrFw89r
	/1iBIVKRTXT97mApuVRTj7EpA7+OAexDpIAFHq78BTdUsgUw3QoxQfX2uuvmj+5DdMuJkIkXUoQ
	ebBWCLOkmMSaz0OamFqurjDFX/MBwIlFBA4YaqIJWYgw7WGbu3nug1gUBoYPgECDrPv04eWpfZb
	7FDzS5GtWZwjx+cj4dM4gpE1+l/mjH3ZvEiNXJC1GV50EkuwXfqDnllef5s5n2qb6qL8mlrEjEo
	w4A9by/IfYt6bHi/CL0E/G/+uR5RufWMbnUNZd/bohwGJC1Qo=
X-Received: by 2002:a05:6a00:1da3:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-842b0dafd4bmr8292626b3a.22.1780752371348;
        Sat, 06 Jun 2026 06:26:11 -0700 (PDT)
Received: from [127.0.1.1] ([223.122.38.120])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-842829188b9sm12910688b3a.59.2026.06.06.06.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:26:10 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 06 Jun 2026 21:25:25 +0800
Subject: [PATCH 1/2] nvme-apple: Only limit admin queue tag space when with
 Linear SQ is present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-prevent-tag-collision-t8015-v1-1-93ccf4eca550@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=m24MQbKzf1MwyNbAaZ52Y2HqborWGOg5ZSaflev6tNc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqJB/qBCoYq0Ez0tQV9FSpbDzHKmr987/6Tm152
 E69XiIGqPCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaiQf6gAKCRABygi3psUI
 JL6OEACOBZpKq3tWJKlPioh5me2NNMMRMIe5utVW0bqMBKpjmqP3LeRjWQm/VfeKB48ntOYS1BI
 hks3Rnd4mrLdzCbnspo9epLHKpgBwJ4CsEKcisn22n9MSykbzwBKIkpgp71ndvvIYb/bxqi086A
 u440qaBo820Tyc74ElD93CuXgIsAutDV+hw3VJqvTSwPDTXEsZ03bQNGoe7yZOCyrqvj1PIz7fE
 xkmtUoD+suZJTjmXCn2ohTLExkZnNPABpqNrQ8UkYQ/yjYIgiolVEl4X6LKCLw38/pxF+pIJs+3
 1+y88fttHsS7FbTj7lDp2ZSUC+KniJCuFaEJECQjCNpyNLZSpotYI8qY3OK/VaoiGNIgBnyGme+
 7RzHd9HylqE9CsUQs60eWBoCkBlnWEiwTnxWLark0pSduu/Phw7FMOMFlvhJxBcdyWdPCZTIkkt
 k63yDX1dpoP3QNa37PkcG2VRM+CESHNgOHzcAbgbWQEgFgV7FFb6QJsT2piKh+ltPWZoGPcbZG7
 h0CUC+KwmkfrHxHDJHo9+XjYtCKdlx58Pv2TPyH9iB8BXlLPjdsrQXQzWrV8z9kdIBQZ/gUo6KW
 w14kgVGXMdIhSxF7Sssl/671LE82DMKMlS1Yx11HXwySbpL008BGXMl+pcypaWTzDmUeBo9i2cM
 VFCscrmIgwrx07A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_062612_447211_0F52388E 
X-CRM114-Status: GOOD (  15.01  )
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

Apple NVMe controllers require tags of pending commands to not be shared
across admin and IO queues. However, on Apple A11 without linear SQ, it is
not possible for either queue to skip over some tags and must go from 0 to
the configured maximum before wrapping around.

As a result, in order to prevent tag collision, dynamic tag reservation
while a command is in-flight becomes necessary. In this context, there is
no reason to limit the admin queue's tag space, as it is not helpful in
preventing tag collision.

Cc: stable@vger.kernel.org
Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c692fc73babf..c1115e27a0d6 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1303,7 +1303,10 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 
 	anv->admin_tagset.ops = &apple_nvme_mq_admin_ops;
 	anv->admin_tagset.nr_hw_queues = 1;
-	anv->admin_tagset.queue_depth = APPLE_NVME_AQ_MQ_TAG_DEPTH;
+	if (anv->hw->has_lsq_nvmmu)
+		anv->admin_tagset.queue_depth = APPLE_NVME_AQ_MQ_TAG_DEPTH;
+	else
+		anv->admin_tagset.queue_depth = anv->hw->max_queue_depth - 1;
 	anv->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
 	anv->admin_tagset.numa_node = NUMA_NO_NODE;
 	anv->admin_tagset.cmd_size = sizeof(struct apple_nvme_iod);

-- 
2.54.0



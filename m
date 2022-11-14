Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D3C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SDnwehKDfCDB3RNzwlYNGyxrCi+1dxz8DyBnuNfd2Wo=; b=zbyDnFUH6ubYXlwNB96qLrYugA
	LHK6olyLuhwOc7nqndqxohNDimbtILv5eUjVb3i/m0khzovWMZtQQo6s4h3gqPUp80w2fpybRN4GF
	Edju3/Rkpyi6jAsI6AcQii1DAg1E1oU3WU8mWcV5nDIrwdeFxbziPHMh0p+zrxvEIU72M2S1usQEF
	78WgJHHNnpsee3GcPNZDukvC6faLyUEKE5Sn0QkpAvYB3QldTPD8qGRRtjix9Uxt+zC6jX2aXsx13
	5di00RcdE3rpWnaiKadkOEcbZ0vKv+6bTUK8YU+dbuiFPYcI1QakQnQl80v/Dl1cnkvKr+tSkoKlm
	l2aR/i0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouTDU-00GMXb-I1; Mon, 14 Nov 2022 06:45:12 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouTDR-00GMWt-5C
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 06:45:10 +0000
Received: by mail-wr1-f47.google.com with SMTP id w14so16293945wru.8
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 22:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDnwehKDfCDB3RNzwlYNGyxrCi+1dxz8DyBnuNfd2Wo=;
        b=CYH97ek97pNj41Nn7oGazq46tPpiET8RykTmMxt4wgcalwvrUCRHn46JL127ZlHpMG
         oqt/ghK0QxYkomeV71puf4RebQxMwzBdgNDZur/7xd9N0NVGAAReVwYf6egYpRaNO4Lh
         +ktgaiV7YOdGOYQZRvbMBMbBCUH6T8Qh/uRyPa4yW8qKVGKb8+QU0/JNCQ47qjlH6EIV
         izLZcYFOMQDQx/YCUMeXn3mZdOsk+q6i1bVB/f+7ell07sFmdBB2ULU0sb7wv1uWpvUw
         fwdDyJbcTUjsZMEYfUXc1kxFpGjuokY25251XUiAhgFNi2m144AnzGOAu76/hp3joaRc
         cTsg==
X-Gm-Message-State: ANoB5pkoCdgHyn24cCf4HxDh5Xy8wvSrxIoqoBIOSbBmYS70Ahasm38X
	Kq4ZfJ0sqFJoa6PlWUegbWp+bp/7o0Q=
X-Google-Smtp-Source: AA0mqf5JoKXQvHd6u+yBXOgSjm0yO78KWjLUxviYXVItYfbWCW/W1GveXXXVMBJvzVCI7xw9hE894A==
X-Received: by 2002:a05:6000:16ca:b0:236:cab3:fd9e with SMTP id h10-20020a05600016ca00b00236cab3fd9emr6643708wrf.452.1668408304488;
        Sun, 13 Nov 2022 22:45:04 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d540b000000b0022cdeba3f83sm8609227wrv.84.2022.11.13.22.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 22:45:03 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet: fix another memory leak
Date: Mon, 14 Nov 2022 08:45:02 +0200
Message-Id: <20221114064502.1077048-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_224509_219205_7A8AC680 
X-CRM114-Status: GOOD (  11.41  )
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

When changing dhchap secrets we need to release the old
secrets as well.

kmemleak complaint:
--
unreferenced object 0xffff8c7f44ed8180 (size 64):
  comm "check", pid 7304, jiffies 4295686133 (age 72034.246s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 4c 64 4c 4f 64 71  DHHC-1:00:LdLOdq
    79 56 69 67 77 48 55 32 6d 5a 59 4c 7a 35 59 38  yVigwHU2mZYLz5Y8
  backtrace:
    [<00000000b6fc5071>] kstrdup+0x2e/0x60
    [<00000000f0f4633f>] 0xffffffffc0e07ee6
    [<0000000053006c05>] 0xffffffffc0dff783
    [<00000000419ae922>] configfs_write_iter+0xb1/0x120
    [<000000008183c424>] vfs_write+0x2be/0x3c0
    [<000000009005a2a5>] ksys_write+0x5f/0xe0
    [<00000000cd495c89>] do_syscall_64+0x38/0x90
    [<00000000f2a84ac5>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index c4113b43dbfe..4dcddcf95279 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -45,9 +45,11 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	if (!dhchap_secret)
 		return -ENOMEM;
 	if (set_ctrl) {
+		kfree(host->dhchap_ctrl_secret);
 		host->dhchap_ctrl_secret = strim(dhchap_secret);
 		host->dhchap_ctrl_key_hash = key_hash;
 	} else {
+		kfree(host->dhchap_secret);
 		host->dhchap_secret = strim(dhchap_secret);
 		host->dhchap_key_hash = key_hash;
 	}
-- 
2.34.1



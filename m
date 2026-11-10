Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979C606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZL1OV818;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lasCrbV2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=esd16OW0Lew55lMSuVcuYFtBqCpJVqbCAV6xh+QEm90=; b=ZL1OV818Q1FJliC7a/0kXE5dw7
	zhDCSbEv3n0wH/pDfKhN1tncXNZYQtpxg/Zr1VPFybW9Q/ZBMe06hBU3DTvm+uxciego3duKzGj7b
	L0cuQZpurrRTy6AKZ2p/HghQ4j3xSD6PZu0cADGZxN4DJs7IyfuJmW7xaDFkG0lGLKJdInypLlac5
	bW++varDjdT0+8Ziay9gGXsRxud77CL2lbWG9d2kzFaMmc4yMiZCWn3J6aY8CilFF5C+1PxG5pYVX
	sWRnOiR/yXZl4xJzv6+5GP6tgBjCu+fLR5kkuv3o92hh3rE4hpMtltr8KIBKinUx5o4RQVmAEbObG
	woiUahfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQh1q-000000034GL-2YFU;
	Tue, 10 Nov 2026 08:16:30 +0000
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQh1o-000000034Fn-2vHV
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 08:16:29 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3720addb068so3046009eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 00:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794298588; x=1794903388; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=esd16OW0Lew55lMSuVcuYFtBqCpJVqbCAV6xh+QEm90=;
        b=lasCrbV2cGKssddQNMVCX+E25Sd1hqt2/rt8ydMSSi/+JBdKFXT5MeHtcARGJVotBv
         5q6VLKZ1Cuc+3wxXzPz8yZCgnT2guCEOZOVUNZEsbX8LqsFcDSZUcTTmkNrj8BO2w599
         HxOzhTGgCEem6a6KcHdimjtrr5LwgkM3efYTKTyws0fk2y6vBaTe94K9/Yiv3JjHokmm
         lIy7UvgSZhe+TDmJgbfiAZaQIT6e8h9KNQzk9uFPGY9S2g5X9SAcBV8xU7GpEtTA3dOj
         49W/D9YKVm1ssDNNuMTJv9tbMsEMt3UaZVggy7mR49qrpWOP340oXVW+UUxQvsCzhW8C
         LUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298588; x=1794903388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esd16OW0Lew55lMSuVcuYFtBqCpJVqbCAV6xh+QEm90=;
        b=iqKmxBY+NtanX9meHLTJdJNT3WlJg7OrkI8nAeQdfw4QMBow4AzvwICoRipzse4lsh
         +8+yDHQyjwFXSLTQGtngMESyLLFvey5uVlZs73pvtIxfbQMJkB0F85Vc9YqXuByViKll
         2rH8M1sAtDxAn48BFBnJphFxZ1Gy+NVdgI1CS9DgEFbwRg3ayRAhY6ui3UZDFUfHbenL
         +gzPROwBxNHVDvcpszefbEeSc47FXSJbzwSpDYVlgqQhUG/G5NE8yN65J1WQsi0YLulX
         5s47CnePPcm7mflp1VTvl+RHHtTWjjBM9z8C/C8dfJ05KewQgrgkd195zlYjumVL4NiT
         vSOw==
X-Forwarded-Encrypted: i=1; AL+hErFu160pyU6rqeJVGdT1ZhBO6idUn3oxy9oJ5i5WLViMHkGoJbbUWe3VFgm1TekJnijmVccnlJoP2IXX@lists.infradead.org
X-Gm-Message-State: APuU4Z9XiYcg02CGhAu4fcDCYFyd/cf5tq9AGWg5aR3ni+8eg/CySIxo
	fGfeG+nNG60uE00JnvHBZKlNKv1rxYWJstuOUkFKKMFV12T/LMk3uoKA
X-Gm-Gg: AYBFou0/nwl9nN+HSrVmGbUApXcIsqBTv8ew+DoJAxkFSVh6AxNiNd3g3MAYp5U/IZF
	xzvPYBAMv3W1xnAY+37WLTJ1RkybW1jcGR1ygYfW7vNR0Ok0qw4C502y+Ij9yWDa0KLrTQsKENy
	ftn9eM/UyeWe50qJc5lE5H4GaB6THghDZukLG4kFbdngNCxV48DzFcy4gLfJuVXrGm5PoCDzjBt
	863d3f04PyNFd7znt7vRKzV5fMYgMUACJP8Fx3MRFzaQNLRRvXUaP9vwWHPOgPJ2WmYN3ud4Nig
	yOd84Mid7m9tZ8YKhBMz45BsCXRd3f8CrZc7uj5wZ1cbQO1WOJCgjqiKy1UJtTNwclYs+GeRkcc
	Lz5UyXuMKxISY3txh7f7MOfJhcLXGll5UzJc1Bc4w7r5i+Yuo2Vd8bbbpYpcsQu2/P1CkNoDKQX
	2uLDPOxm6+EshwGhct72X0XE0u86RWKujuidvWe1oqRibFdiyi8JDbwKLkVwZPO7Lgkrf7Epva9
	zukN58vyj0A6Qmm4As06AOzVfoFNwod2ubmhvc2tlC66GQ3LhvIP31vMe5tFyGVDNz+a+BN6IIQ
	0blmOyBD2hqVZRBYoIr47KxNSGqOewbvqLHFNXZVGspKc633l+E=
X-Received: by 2002:a05:7022:6985:b0:182:6c6c:d876 with SMTP id a92af1059eb24-1b3b6037d0amr3423422c88.8.1794298587594;
        Tue, 10 Nov 2026 00:16:27 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm10891140c88.10.2026.11.10.00.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 00:16:26 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@kernel.org,
	hare@suse.de,
	hch@lst.de,
	kbusch@kernel.org,
	kch@nvidia.com,
	sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2] nvmet: synchronize DH-CHAP secret removal
Date: Tue, 10 Nov 2026 08:15:59 +0000
Message-ID: <20261110081559.2730-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_001628_737702_D4F206CF 
X-CRM114-Status: GOOD (  10.11  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The empty-secret path in nvmet_auth_set_key() modifies and frees
host authentication secrets without holding nvmet_config_sem.

nvmet_setup_auth() accesses these fields under the read lock,
allowing concurrent secret removal to cause a use-after-free.

Acquire nvmet_config_sem for writing while clearing the secrets
to synchronize with authentication setup.

Fixes: bb2df18958b4 ("nvmet-auth: allow to clear DH-HMAC-CHAP keys")
Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v2:
 - Add Fixes trailer.

 drivers/nvme/target/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..8fe521690ccd 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -26,6 +26,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	char *dhchap_secret;
 
 	if (!strlen(secret)) {
+		down_write(&nvmet_config_sem);
 		if (set_ctrl) {
 			kfree(host->dhchap_ctrl_secret);
 			host->dhchap_ctrl_secret = NULL;
@@ -35,6 +36,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 			host->dhchap_secret = NULL;
 			host->dhchap_key_hash = 0;
 		}
+		up_write(&nvmet_config_sem);
 		return 0;
 	}
 	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
-- 
2.55.0



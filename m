Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAE606A31E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sqW924RW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I+SurLOU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ziCcW6Nw+6VJzNQIJUH4e2sx0xcfbPPXXhObGwJmYIE=; b=sqW924RWGSP4NtQxcat7qWEfp9
	fFjDNeUX+lC5kTV1sybWIhFzeaHu2UjRF+DJg7uokycHxRAVN/2zTd4YauSP3R7pFBOOpI7JQ3J66
	nGn5C45vOl4wVMVuqXV6KPNkb6dOSI74hIW2NQsc49/hA+Dlm331MFH1eDuUPZoCTjST/e3sREUHv
	P/s9KGD3oV3XSywQuvA/hl0vAH6kqX3PXuzNTG4FnUAWOccBL1fmQ4TFbnEROO4h1GloLFG9sEcZT
	HS0leRPFcfaf3ADYANGm1rrtFmJnRaLptCZWulo4ipsIyUk5KKteQzyQhm8DG0fLmbMD6xzA6iaqV
	r912BhJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKKqX-0000000Gqqv-3zpY;
	Fri, 23 Oct 2026 19:22:33 +0000
Received: from mail-pj2-x09.google.com ([2607:f8b0:4864:39::9])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKKqQ-0000000Gqq2-2oup
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 19:22:27 +0000
Received: by mail-pj2-x09.google.com with SMTP id d9443c01a7336-2e613f813b0so1585085ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783345; x=1793388145; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziCcW6Nw+6VJzNQIJUH4e2sx0xcfbPPXXhObGwJmYIE=;
        b=I+SurLOULzn0t7MPVjXqogXx8TbgLgDb7tZ5vD+ZtE6jISL1fqRp4jUT6FPsKp7nBj
         XnfYTzwnxkCdJo/Txc2mglKkYYupNdhwybwB8xEZa14zCaFBZQOb7bhg+OAR/tS2SiJ+
         aEKQVeGQOU/10zCJFWwJCxipdKQKgeE5LDPqOecwDYROk9UFvT6pkAXhCTaJzNbaCYQI
         H8ztNhUHGMRfsUjv0Ruj1N57pFFmm18mFLOnku2c3aU+C7A4pjEyXTgaahbHnbYBhVW+
         b3rK9dGkr6tsWWnJgoDfP/sbVTCqefZKU0c7MsP9X0qiY45p09c3ZtC/BOHo0IGTgv48
         qbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783345; x=1793388145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziCcW6Nw+6VJzNQIJUH4e2sx0xcfbPPXXhObGwJmYIE=;
        b=jDp8lsrVjiZqEPecCcY/GX/Ch1GSBZVJzAF7YCGQF4x1q2bDR1bylkJT6IrEra9/gj
         seom1+VO6QK5ohUxecwvdunUE8Y7VlrwBeCZIyfSPcwpC0x4Md67pczJjyDq0vXkIl5t
         6OPrrPCIiqlJ+KprEFx1no0s4bOTD2jQpq2t/yxYyUemklzcI1aEfej6ST4S3v2B7MLG
         HB28Qq3VmiY/F6Vv0AA0Ewb9Z49JT+BqRkztcK7Wi6N6Yqnnu+68Jl0q0FyT4tuYy4Qx
         j5YujQk6E+DQumiq/WsukE9G/JNoeHR8h2HJ1UYsqFZtZTh5o2MGECgqKEqIZdZ4YZ2i
         DE5g==
X-Forwarded-Encrypted: i=1; AKwUvBxKsTmI6FL2q3yCPY5wJrsnAzQUp4uQJXdw5fS+ilQp3tH1Vs7aw1oUpZI/B84HGhrsqK/AsHbM0q9Z@lists.infradead.org
X-Gm-Message-State: AFq9FYLAI8LuU8piZScLC2hMv0oyMvW7vBd0Btvqvb8xs/KhPqCcF2SM
	5gQ11IG6WfJ0BPWCEE8VBpsn3+ua01TtsoZySRKyQ5YgdgqUquJDBhV6
X-Gm-Gg: AYBFou2gbKgo+QCcs6E2bC2qt08GBZdbigGeS61vidrMzhNrMBnmlhfIEzy/nXTsH4M
	J+tSIqtxx7NUe7aiL3u99tY863RtPUsQUFzgyPUo+0faI25RnmZxHDBS9hdn67BlXwCZv3YM8xk
	LG5ajpVOppafaUr7rfCqYU6cNEmKb4kPLh3yiKrhKPNiMNao1V/UuaPH76fuzP5p44xgTUa6PtD
	BBnflQWDn2Pa48MGl8y2WUinZjmoJbfdITNoaYlHG7d/7h0RAHxn0UKnHrxjwh++UVb5+xW8env
	1MAWMf8YX6Ro2eSn/pnXMdVAL6jICGqnBRVHzxmLDBIMhH4thIStoNHwbaJF25HNyfk/kR1E7Ct
	2BCtV78BG9JetjA2PaKpGcaSBQj1gslnCW71Rv8ygrpT9Un0dZFh//3+Rm9BEdIqqrjSWLPsY7S
	HJkyPGA12R+B6IkGjVIHGI+C5nJtvknRuNQM8gHbWDagra2LyfhVc18Q2/UvjXHTSvtRJcjIKKx
	bi9LsayfB579rR+ZGs+Sps1Sgcz5Q48uPpmpf1xGanJkOCnNynzIccnTq9UneAxjdCg89uwvh+X
	KAI=
X-Received: by 2002:a17:90b:1647:b0:3ad:677f:567f with SMTP id 98e67ed59e1d1-3adeb694368mr116319a91.40.1792783344585;
        Fri, 23 Oct 2026 12:22:24 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:20e4:738f:8d42:88af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm174163a91.6.2026.10.23.12.22.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 12:22:20 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: use the enabled transport when disabling a port
Date: Sat, 24 Oct 2026 03:18:51 +0800
Message-Id: <20261023191851.5316-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_122226_720125_457E8ABF 
X-CRM114-Status: GOOD (  16.40  )
X-Spam-Score: 0.4 (/)
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_disable_port() looks up the transport from the current
disc_addr.trtype, while nvmet_enable_port() records the transport in
port->tr_ops.  If trtype is changed while a port is being enabled, the
port can be removed through a different transport, passing the private
data of the original transport to the wrong ->remove_port().

The same mismatch is reachable with loop and RDMA: loop add_port()
leaves port->priv NULL, and RDMA remove_port() dereferences it.

Use port->tr_ops for removal and serialize trtype changes with
nvmet_config_sem in nvmet_addr_trtype_store(), so the transport that
added the port is also the one that removes it.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Reported-by: syzbot+c98b21427617af7f547a@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=c98b21427617af7f547a
Link: https://lore.kernel.org/all/6acbc835.a150a118.27e199.003c.GAE@google.com/T/
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 drivers/nvme/target/configfs.c | 16 ++++++++++++----
 drivers/nvme/target/core.c     |  8 +++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b03b5d1c2dc3..955f2b127970 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -387,10 +387,15 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	ssize_t ret = count;
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
+	down_write(&nvmet_config_sem);
+
+	if (nvmet_is_port_enabled(port, __func__)) {
+		ret = -EACCES;
+		goto out;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (sysfs_streq(page, nvmet_transport[i].name))
@@ -398,7 +403,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	}
 
 	pr_err("Invalid value '%s' for trtype\n", page);
-	return -EINVAL;
+	ret = -EINVAL;
+	goto out;
 
 found:
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
@@ -407,7 +413,9 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		nvmet_port_init_tsas_rdma(port);
 	else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
 		nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
-	return count;
+out:
+	up_write(&nvmet_config_sem);
+	return ret;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 07a74c2e1f58..5aaeeffc9ba2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -393,11 +393,13 @@ void nvmet_disable_port(struct nvmet_port *port)
 
 	lockdep_assert_held(&nvmet_config_sem);
 
-	port->enabled = false;
-	port->tr_ops = NULL;
+	if (!port->enabled)
+		return;
 
-	ops = nvmet_transports[port->disc_addr.trtype];
+	ops = port->tr_ops;
+	port->enabled = false;
 	ops->remove_port(port);
+	port->tr_ops = NULL;
 	module_put(ops->owner);
 }
 

base-commit: 864c07de0c7dcbca58b61625dfa2e461ae63b242
-- 
2.39.5 (Apple Git-154)



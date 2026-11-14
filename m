Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B20606A89B
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A7V9z7yJ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tF3DwaP5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=v7tiXwNesGNvlwhrKa30W0lwvT4MH6zCN7lk+DjVWfM=; b=A7V9z7yJeZzSWB
	4VEkoeL6gamg/pGTQr8zRySR892gIAJl0OsZhZTvHkTyMEKYMh0EiTrBzabN6IxiVDFwRlNCjNSzJ
	gg1Kv3amV2+7ZCILk2TQL7kYIPCSmHmQP33/dbFGj99R4nN3Iim79HnjjLOI8DWmG3xeqeTgzRmaX
	7hq6pXBKY6oyypP+icKIig22k9TeDhytfn8Gxw8KH+EdsbXH3u6ulEABAMkc0PXHB1JCzzh+WNfdB
	Qh4c0f2NSzkJrXLH5d2ZSqYLchn2hnaiIDJpm23yaWxke+qy27eNzvxeQ+lh9mXLKToD1BZ5vkB7q
	IOZzoJRw6iakBNR/UFpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS6Ky-0000000FV0G-3eZj;
	Sat, 14 Nov 2026 05:30:04 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS6Kt-0000000FUyY-49Pl
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 05:30:01 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ed06b725fdso19055375ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 21:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794634199; x=1795238999; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7tiXwNesGNvlwhrKa30W0lwvT4MH6zCN7lk+DjVWfM=;
        b=tF3DwaP59c47F3/MJsWGz9Rp2Po//Fq8lx3eaYRXmIkRoZpw5YpFZMCKRC6D1R8YWC
         pNzsd0scDnewxSZmQfWNh0hCLE8GZiPU8O2b4yLZDSdcpwdEhvyJ0tmn9jfYJ5+tgV68
         S0+xdd/HGH1xFHnD/7biUntulnCi1Iztg50SnT4KKSKQ5i5+SMZ+I6PD4vGdnEAbrWu+
         MhfqEGUrvc+63geiVvr0X39kMgKFeFFuzi3nlwIYsCeWO+efvQllVmpomfnxtWM01GsQ
         NEKWykPepwTqR+KhvVisOgvTa6ZOKI74sv770zXC4MwGg3RwBoCdRJFhv/WzDcHjtcnz
         kxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794634199; x=1795238999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7tiXwNesGNvlwhrKa30W0lwvT4MH6zCN7lk+DjVWfM=;
        b=yvLOLrvKXw4/vmSOLSaxCGXD9H8F+H8lo92KFLRSy1ARCN/UAbo/SbRizBFkbniLyi
         aBYUveNEY1KJmpDjokc7BfhAWuy8QKgsbu8k40h4have09FLpXzgQxdkw0hvpqjUC3LC
         +Lnvs2ZwKixO15kBCpPcShHbC6b6BiGzwzAYafMjsrGf9i6VryBaBwvSY0NA1Ac6TE5v
         NUfg7RFh5hKldcXQgEkzRwTHsB8YAeWRhgsZRY4mJayUCiqbuqixYMbUU8ti+xLdZ4SS
         JOeDnETzgIazeQDfuNsdWRvvCz1rwmbJdGIFrqJSuKJOhzrzTosDCzUfoSZ3U2tL49fN
         f13g==
X-Forwarded-Encrypted: i=1; AL+hErF8t42ty/aR4vjsqsTrXJ9v378szwSWe0ANkivX8b+YKLE6JdKyMpHaLYoxlZ9ZFDLZNOLLyAR1x+h0@lists.infradead.org
X-Gm-Message-State: APuU4Z+kTLGZoKZlw3Ts8dfuQUjMkp11MKjz42Dc0TMnQZkJW4IXlQlC
	RSjgw9+PHqFhfipX9VEpbM7Hn+L6AqmyvRHZBZmNpQxk91gG/nWDxdkS
X-Gm-Gg: AYBFou00DPBLQmD0sA+PjxgyjT8witUZmJBp4NWSAA9sB+RkjY7NUPgbGWcH0SC7Abk
	bI/cJFmHnfBEt5/GBmfywosS/ua7PaPN5E+mBPElxpwhsmc6wta/+PdPeL2ky3Q6zeCS51k1S3L
	pyMIkn3Eq6vAk6HCNRqfvAkr1pvuNwWHSMV/Turhmz40yNkmUScoMQ+GinJQ+JQ+RHdZpb2JFuR
	nppJgJqAG9c6da2dLm5/WI7ksMT/QbPG52sNWZWU82ViS4yPpXlkTEANBEMWYwq0Muawlf9urgl
	fAQaocpa8MZnRPG6dMUCionK5N7ktV1rFXDi6sLeOIarWNMRjMDgrgGz2+H1ViJb+vI0xFhX8Qf
	blQ816uzPCu6Ut4alMGcFYT/mP4UZTpnisDWaHvplOSbLOY7rmaPo7ly6EVHv3LYoMDODqOYSAS
	tnjKL9y6E+YpWAuJ3fHz1FSBD4GBRvb+sLcDHlElOEGgmET+nhyux/8uwl85TgxZJJynVFHw7ec
	KkBz3uRZ4d8wcoJrTaxs3oVzjQGh+ZSBevfI6nvoySXE/fziX9RaKJFbs/Bea7ds07Emu4ReJzL
	pRWUgzlj1qPA3Un9vdmRg12naezCZE1jz5oM2SLm3t+Es0JDm/YrLXPAed0yAtxlhcHA1rsZGmd
	AYqVWf3xlcdKqehC2r2CCiGeAx9KL+mSEBtB/iHQE39N3kOE9pJrujp0=
X-Received: by 2002:a17:902:c411:b0:2e5:debe:cb4b with SMTP id d9443c01a7336-2edf1e7b0a5mr61346585ad.10.1794634199067;
        Fri, 13 Nov 2026 21:29:59 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2001:f40:90e:5ed4:d53:b5f5:a144:fe4f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f874871sm17760225ad.54.2026.11.13.21.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:29:58 -0800 (PST)
From: Izaac Chong <izaacchong934@gmail.com>
Date: Sat, 14 Nov 2026 13:29:46 +0800
Subject: [PATCH v2 1/2] configfs: fix use-after-free of default group in
 configfs_symlink()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-configfs-symlink-uaf-v2-1-48c9cf068a91@gmail.com>
References: <20261114-configfs-symlink-uaf-v2-0-48c9cf068a91@gmail.com>
In-Reply-To: <20261114-configfs-symlink-uaf-v2-0-48c9cf068a91@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com, 
 linux-nvme@lists.infradead.org, Izaac Chong <izaacchong934@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794634191; l=3255;
 i=izaacchong934@gmail.com; s=20261114; h=from:subject:message-id;
 bh=BLAVQgSrEVNkosJ1RawvnEwRkMMxTH81O2DKWV4iSkg=;
 b=xwJeQRV6EtAOLyaWisKx2TbtvO1K9D6hg9FkRjY8VTX+fnyRwQVeAN35/0byNBdaNsvX7iYMl
 1rIG8bSOcNnCMtfjXczQrkkQiq5s1v3j5nv2pud5kUaBkDHcaEfyOI+
X-Developer-Key: i=izaacchong934@gmail.com; a=ed25519;
 pk=IFfOWcK2ZRkDtCqaNggolAwpvIidYMt3Oar3NEnvqzY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_213000_047098_961F64CD 
X-CRM114-Status: GOOD (  15.24  )
X-Spam-Score: -1.8 (-)
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

configfs_symlink() drops the parent directory's inode lock while it
resolves the link target, and keeps a reference to parent_item across
that window. When the parent is a default group, such as
ports/<n>/subsystems/ in the NVMe target, parent_item is embedded in
the containing object (struct nvmet_port). A reference on the embedded
item does not keep the containing object alive, so a concurrent rmdir of
the port can free it. allow_link() and the final config_item_put() then
touch freed memory:

  BUG: KASAN: slab-use-after-free in nvmet_port_subsys_allow_link+0x41/0x2e0
  Call Trace:
   nvmet_port_subsys_allow_link+0x41/0x2e0 drivers/nvme/target/configfs.c:1059
   configfs_symlink+0x59a/0x1030 fs/configfs/symlink.c:196
   vfs_symlink+0x18b/0x330 fs/namei.c:5794

detach_groups() marks a default group's directory S_DEAD while holding
that directory's inode lock, before the containing object can be freed.
So drop the parent_item reference before unlocking dir, and after
re-taking the lock return -ENOENT if dir is dead. Otherwise look
parent_item up again, which is safe while dir is locked and alive.

Fixes: 351e5d869e5a ("configfs: fix a deadlock in configfs_symlink()")
Reported-by: syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0996ac2197dd7420c3e
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Izaac Chong <izaacchong934@gmail.com>
---
 fs/configfs/symlink.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 89178f5d371a..1b2c9048a920 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -166,11 +166,11 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 
 	parent_item = configfs_get_config_item(dentry->d_parent);
 	type = parent_item->ci_type;
+	config_item_put(parent_item);
 
-	ret = -EPERM;
 	if (!type || !type->ct_item_ops ||
 	    !type->ct_item_ops->allow_link)
-		goto out_put;
+		return -EPERM;
 
 	/*
 	 * This is really sick.  What they wanted was a hybrid of
@@ -200,7 +200,20 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
-		goto out_put;
+		return ret;
+
+	/*
+	 * parent_item may be a default group embedded in an object that a
+	 * concurrent rmdir freed while dir was unlocked, so we dropped our
+	 * reference above.  detach_groups() marks dir S_DEAD under its inode
+	 * lock before the containing object can go away, so it is safe to
+	 * look parent_item up again only if dir is still alive.
+	 */
+	if (IS_DEADDIR(dir)) {
+		ret = -ENOENT;
+		goto out_put_target;
+	}
+	parent_item = configfs_get_config_item(dentry->d_parent);
 
 	if (dentry->d_inode || d_unhashed(dentry))
 		ret = -EEXIST;
@@ -218,11 +231,10 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 						     target_item);
 	}
 
+	config_item_put(parent_item);
+out_put_target:
 	configfs_put(target_sd);
 	config_item_put(target_item);
-
-out_put:
-	config_item_put(parent_item);
 	return ret;
 }
 

-- 
Git-143)



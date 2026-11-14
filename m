Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD3606A880
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PVOI++MY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ACDmRbg6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=JXqAbYuZ2vpS9frtjoNHLZmHrsnGeUx2jopCaJzDTbs=; b=PVOI++MY2BWu7frWd9/kbidxv+
	dy0YMZYYyJW+Q/HISzJ2oUmT/dgTUcrYaNlGcLnGCS/eJEc+BHLV1wJvWkZA64q01a/GcUWX0FY3D
	XE010QbaEuUWEImqoKLGTwBH5HJpaZ4J8KQQ8FcyiV6w+hPPYdwWWmk6o2L4f5WcSS3h2uWQvF3NQ
	7uZE0z68UB+hf4oln0GFV67zIu8wyRPZSO1sRyMxg0S3tPjXE9eubXuFuPowxD0pNjt9SsJ3MfeZG
	O8sC8DRl7itaOhoZ0Y2VNk4sWIYygKWtKiTFk0EsUOn0lwBHvfA/GOOpKV5sq+gx1FSrVLMGj6X2H
	aWZ7TMIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS3y8-0000000F8t5-1zqt;
	Sat, 14 Nov 2026 02:58:20 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS3y6-0000000F8sT-0UOq
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 02:58:19 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so796314a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794625097; x=1795229897; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JXqAbYuZ2vpS9frtjoNHLZmHrsnGeUx2jopCaJzDTbs=;
        b=ACDmRbg6pWqSS6qRJWlrShlsau4sg4aqbCwiqzqvWI8/GRCzz/n57SV2RK+x1IYibp
         9EX78euhAeqfE0oHaWzSLYfAFjszWzPe//MV7tamHu/HmF3qANFxKBxKEOq7REkH+MHO
         HJE6YI8kfdckkbLnejAGWgjmObKgxXdBMGUyWmw/Yfkhlusd1CVuxJEhIWfDldgo8TFi
         Qmb32Ru9BPCQsNc1MzVddKFPayQer2H0nJ8SGvcJWrQaO67vYWkfMJedlN7AAMfEN/HJ
         q8oah4Uoa+iLh7K6raV0vznzpCrLM2n0IIG3qvdv1xHXcTb5SBwExWuOblYt4vSEfhz7
         z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625097; x=1795229897;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JXqAbYuZ2vpS9frtjoNHLZmHrsnGeUx2jopCaJzDTbs=;
        b=gj6fYxA4LRUVnlaY/jjjfdQN2nkIuZ3dQwinfA69U5QkxgMqU+Ebngwg0GNsGtitHW
         qhjqQ54Da0JdAtZwoaasu7OqdvKqHTw/f9VfJNHfpVigaVIm/67xAPT9PMdjwzgbJ2PV
         opBk+OEUnNoSjG7+9va+nTEvFSUYSgKSJ7gUhOOrxIJzLrXIkN4sE5Q8vZAVl/8Oj9FB
         YXP7Ia6bdn88sIPOGIPh3FTiARhehZE4RLCl3PXUoHNZainUn/+PHMlqYxMo883vTa2R
         sGavlbMM+rNsRkoVM0Cjnz7t1/PE4jmhJbNIgbJKzSHehs3+M6VQPXZhERWbYSiVqK+R
         tcMQ==
X-Forwarded-Encrypted: i=1; AL+hErEsxuT7dYSpac22LgOpsT+UvwTTsox1SMD0FX2LBn99qsyZHSoFRBCHfWohbZUJI7EcBqAVtX1+RrVE@lists.infradead.org
X-Gm-Message-State: APuU4Z84qBhZJu/tGGCmJ6xq5I8i65n3xrcswcjBZZ5a1YXV5qw64dFN
	ISlqHIKYpNb5QZTZLX0K+cdAs5kTMSROJUyjOCw49sTlr/g5uXb+20qh8YHJnsDE
X-Gm-Gg: AYBFou1+7XpyhG/NSstQSBJIAE5VddGSyAn+u6Drmy+9PjxfKi1XxD3UCRTtqfYya+V
	wI/2r+xrj9YxURLlt2VIEX1kKk+sWroCNePiygk1yu6vvA2rHW+Uz/0OQkeEVdQNXq/0UzSYG/K
	xIKOy3yNUe9YPwmLELjIgw0/dKtNuHPRu48wew+gCpkGQKicLzdLZjK3LlSwVYhgANfYV1VVOCZ
	ctp/kMp/yoXJLjOFic/7grt/xIFtD+dmhI8rqzL1MxiBLELAzaImYQNSRjLR71cFk93bJ/u2cHN
	m+tYJgSJF1kRMEOUrOPKyUKtC0T2i6bhTeRlO/EjqFVS/xazHag4qADkwOti/q+3AFPY8JcCUC+
	KJR2LRW6YXfXrcE2srN1OWus5iznpY0eAmCyTZ31nBK9fjk6uIyXKsruFqTCHoDhP+TAXZ0a7n9
	HMu/JEabWXcpySxj+LIrGWqswoKJPuRKKu9xR1aTk4Zowog00RRTNR39/YzQxsTJhaNJuixuvMM
	+WvK8kxMZgJpuY+6CNaAA+B4NjAV03U3Wf5VXAZmNW7xExsUY1dRJ39Azd6JPy0/v1+hvLl0kDp
	74AEzIB/e4XRy3tmvn6Zhll4XwrrMkfQQ9hscrec2TT+j7wC6rTRBLbx0HisvboSu2zDxkiz0cc
	ruYeLQ8KfBvWULco6YpDFKlgMHuuP2XQFwCwGUvonPYTWBXrJ49q3hfI=
X-Received: by 2002:a17:90b:5806:b0:3a7:db88:3491 with SMTP id 98e67ed59e1d1-3b1b0a4cf70mr3720380a91.33.1794625096978;
        Fri, 13 Nov 2026 18:58:16 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2001:f40:90e:5ed4:d53:b5f5:a144:fe4f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm7141206a91.1.2026.11.13.18.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:58:16 -0800 (PST)
From: Izaac Chong <izaacchong934@gmail.com>
Date: Sat, 14 Nov 2026 10:58:04 +0800
Subject: [PATCH] configfs: fix use-after-free of default group in
 configfs_symlink()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-configfs-symlink-uaf-v1-1-1446154abdda@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ6CMBBA0auQWTOJJVDRqxAXbZnioBbSEQIh3
 J2Ky7f4fwOhyCRwzzaINLPwEBJUnoF7mtARcpsMxaXQSqkS3RA8d15Q1s+bwwsn49FVbV1aq83
 tqiGlYyTPy7ltHn/LZHty398L9v0AXpA4CHgAAAA=
X-Change-ID: 20261114-configfs-symlink-uaf-c5d84bb6a976
To: Breno Leitao <leitao@debian.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, 
 syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com, 
 linux-nvme@lists.infradead.org, Izaac Chong <izaacchong934@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625093; l=4212;
 i=izaacchong934@gmail.com; s=20261114; h=from:subject:message-id;
 bh=J+KkHfs0mzJGU6K6QSM4d4XD/5HOyjXhZy3CNgCcS3Q=;
 b=mrAQQ+OlG7DqTqvgoTQiyvjTue8vzz74E39xnsarPkOZ3nCwUlyMJzzPu58vmE637kNmAxcWC
 +nYbFUOXXYnCCmTdRVpJnrE7HHaXot7VvJRYg9//1IR4K1TIrVkGqKb
X-Developer-Key: i=izaacchong934@gmail.com; a=ed25519;
 pk=IFfOWcK2ZRkDtCqaNggolAwpvIidYMt3Oar3NEnvqzY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_185818_165380_0875C0A6 
X-CRM114-Status: GOOD (  17.55  )
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
Tested with the syzbot C reproducer on v7.4-rc2 in QEMU with KASAN:
without this patch the reproducer triggers the slab-use-after-free in
nvmet_port_subsys_allow_link() on the first run; with it, 3 runs of
5 s each are clean, and normal link/unlink/rmdir of a port still work.
I tried to have syzbot test it, but #syz test is currently disabled
(syzkaller issue #8122).

syzbot's AI patch (v1-v3, still in moderation) pinned the root item of
the default group. This takes a simpler approach: drop the parent
reference before unlocking, and recheck IS_DEADDIR() after relocking,
since detach_groups() sets S_DEAD under the same inode lock.

Not tested: lockdep was not enabled during the reproducer runs, and I
did not confirm that the new -ENOENT path is hit during the race.
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
 

---
base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
change-id: 20261114-configfs-symlink-uaf-c5d84bb6a976

Best regards,
--  
Izaac Chong <izaacchong934@gmail.com>



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC50CD8CA8
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jun 2026 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAbvIUWiFDMirl0Us4mmXPOFTeBDDg/l/sWK35AjUMY=; b=jQXBC3pzRo6e4vRTW5jWacqBwW
	inspQAI6UGXX/MTfTDbt++JmrGXohWY6IP6y72ceIKGhrzKbrKepuOjiXMOfe3iDdB3kGY7rdbjxy
	YbX/zEXuFHpdfqguf3eJgOogRdurvA9ES4dwO4mFrw87UNBwDJJ1L/SIBMXMbxmAsSb89HqFh8CXh
	PEC4FHbV3m7MWYlzsVzug25P55xiH3BS5d7o8oIdg6ZqAhmfBqpQd7u1omV5u+gk6+86oAEuv+LDt
	XgIuErY676NZV6Om+yw6UDUuNfY+IKo6UgSjtZOncNCXduUXB8p2cg9SaC+09N/cwkpNhHWdlBf51
	rRf5tNWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKF-0000000CE23-1uMq;
	Sat, 13 Jun 2026 11:14:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKA-0000000CE0i-2FAG
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jun 2026 11:14:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E51D04025A;
	Sat, 13 Jun 2026 11:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300B1F00A3A;
	Sat, 13 Jun 2026 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349288;
	bh=rAbvIUWiFDMirl0Us4mmXPOFTeBDDg/l/sWK35AjUMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3XL1fyhrftVFOLPF84Df+TTb73VAzcQvlCy01QFpNnNLR+lrQy3Wp3ANOp7bGdBc
	 SNfiIoLHPFP7Z5nIf9ngsTVNRUx1jlViV5CPl8ZwctmYskVewSN5OD8KEYti8BxQp/
	 EJTRlNMX5ImixUfWTASm241+ePdMSM13FArgc9oCj/fS+9JOdl9ezSyof4Y5JOWtDC
	 BauN0oWNazApx5hpcA7CtcHr6a1ynu6VdxIjhXwvRHDhBpAuN15HD6VLpWuihbDD0E
	 cidzlg2yrkOJOWoTPCaDoW3aW0vYqRwSSe2F2d8vsjPxkV9om6pe2DMI4WIBx64u2P
	 KKVkGj/tHu9JQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/8] fs/configfs: rework configfs_is_root()
Date: Sat, 13 Jun 2026 13:14:30 +0200
Message-ID: <20260613111437.101763-2-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@suse.de>

configfs_is_root() should not check for static structures, but
use the information in the structure itself.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/mount.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 4929f3431189..e5c01d5e4d2d 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -49,7 +49,9 @@ static struct config_group configfs_root_group = {
 
 int configfs_is_root(struct config_item *item)
 {
-	return item == &configfs_root_group.cg_item;
+	struct configfs_dirent *sd =
+		item->ci_dentry->d_fsdata;
+	return sd->s_type == CONFIGFS_ROOT;
 }
 
 static struct configfs_dirent configfs_root = {
-- 
2.51.0



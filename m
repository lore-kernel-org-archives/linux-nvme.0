Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D109C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hdU5ls8WrZqnB6XcqbSDmjL6xy2k02oGZxBDsQ7NsXM=; b=AboQH63o3i0/gaVe8BqUtkZDZg
	mVsNXIqBuSljCdqGbLrmhu2lDh6wAeKuAtfgq5l2AVwli2vR7ObZtzEHTrfKks1bV+ZXx6In6UIye
	TdFl3hvBPXzuNHTMXEGnfK1LOc+1B0BkynYEEdM2eN7vgxsI8BM1D83Hr2mlkVjYIQew8zWvXggl2
	XfC4JofjLrfP5fz68NI7IhRbV/GmGDrHAV2QhV2azw7UhZZsim5RjevVB9h3eaa0C5jXo92OefMqt
	USLRFj1b5l+6ngMYJn+to2lTTE7OCNJIPOOXJBUikvc2EpVCrNPvZPppj7D/XNuOBNHgA3J7hKL6T
	E0wjoGHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3cO-00BJTv-21;
	Wed, 03 Jan 2024 15:57:20 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3cL-00BJS3-1N
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 15:57:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id ABA8DB811FB;
	Wed,  3 Jan 2024 15:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55748C433C9;
	Wed,  3 Jan 2024 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704297435;
	bh=3PfcWwd6revmKQ+P7oeW/epk2Jli0IGYdbJw4sDRDcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4lwkSa4/5o6qLH3t+1W4bSQpDY1x1qz8rx9BQ5IzXaVc09MGPcJlf9qb8i8G9s9V
	 mHoHD61mNxrvIjvBM2JDSCcbhVYAIV6LYx60NX8kPw6GFhHkrstb9l17NF9i3Jk4PV
	 9Y8mkwjXJs89ZmniTW/Jxo3S31GOW5khJLCaL4LowShL7iEppnlgYgY/S004CfPyzd
	 dizB9PXsCRq7cDrIPNm7lzF8SH7hwDtE0dhqCFswf/KKcCvXWcT15CSBJ6XUVShz35
	 y8uCvTmeOBh8zBYQsqfi9ysAxNp6OViN+2JthKDzptByOg594agbMnEJ3+h0sIx+/f
	 Y08U1Epw6A87w==
From: Arnd Bergmann <arnd@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme: trace: avoid memcpy overflow warning
Date: Wed,  3 Jan 2024 16:56:56 +0100
Message-Id: <20240103155702.4045835-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103155702.4045835-1-arnd@kernel.org>
References: <20240103155702.4045835-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_075717_689133_16B114AC 
X-CRM114-Status: GOOD (  12.25  )
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

From: Arnd Bergmann <arnd@arndb.de>

A previous patch introduced a struct_group() in nvme_common_command to help
stringop fortification figure out the length of the fields, but one function
is not currently using them:

In file included from drivers/nvme/target/core.c:7:
In file included from include/linux/string.h:254:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);
                        ^

Change this one to use the correct field name to avoid the warning.

Fixes: 5c629dc9609dc ("nvme: use struct group for generic command dwords")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 155334ddc13f..dbb911fd502d 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -84,8 +84,7 @@ TRACE_EVENT(nvmet_req_init,
 		__entry->flags = cmd->common.flags;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
-			sizeof(__entry->cdw10));
+		memcpy(__entry->cdw10, &cmd->common.cdws, sizeof(__entry->cdw10));
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
 		  "meta=%#llx, cmd=(%s, %s)",
-- 
2.39.2



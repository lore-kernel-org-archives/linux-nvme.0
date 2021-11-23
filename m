Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2880CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txgVtOYe8itrttqCBTGEOY4AR6fYy1qjlGff0NfMl7s=; b=NWnR3rPrOTFGuMUW7x5oym3AUs
	Dv0rr4ViUwbx444lmrw43KUtYctOlSD3oBq/pPpRQO6ngZl/AxGqGBos0b+bX7iZbWDmH2XxKGy9W
	j5KF4neri9QC/z/IC1SAEAM0c6hgrxScL1+fZSuTkdv2X9tdCGfYDzHUhw8NSnZUA1fXSHEAdt+gp
	RBzGJI/67jQDky/6QSmcgmYxivsQYVL+YIyQe+WfAoTFpju/e7DPY7g9t4npV91+17eOXYmKTfNSn
	oesVjCDTTHVldett9amysEqjwZcjAKUDAywJ4MsOn+tBqwixuGHspHMRvFmsbAsJJRc/YGARTU4p5
	xp/2VVxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQap-0017JY-P4; Tue, 23 Nov 2021 07:51:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYq-0016hD-4g
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1CE621FD5C;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txgVtOYe8itrttqCBTGEOY4AR6fYy1qjlGff0NfMl7s=;
 b=SLLDfvo+LQNaXm3d7Zt0JpGIhERXfPc/KdwXOKyOiXSsJou6q6TrAHgZ6Us9LxDkTQzNv9
 wX2yiod9JksPhuUg7fWcuuUw+5a9B6tqiNGZWSBb+BYE9esPyZ17HggKzoywIRPsiu8fYe
 33vOAeXSBTbNUmYYmrP1StqjU3MAcew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txgVtOYe8itrttqCBTGEOY4AR6fYy1qjlGff0NfMl7s=;
 b=+M8AnKC04Dg66I4osjT1YJ5TI2GLSUJGaeF+s5xyxvsMuyHHNyzbsGnECe8gbiHYMdRA7w
 HIQZiWxNjg88feAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 23925A3B87;
 Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 12F755191883; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/10] nvme/rc: do not print error message when no nvme device
 is found
Date: Tue, 23 Nov 2021 08:49:31 +0100
Message-Id: <20211123074940.113390-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234952_457202_0FC6F1F9 
X-CRM114-Status: GOOD (  10.98  )
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

_find_nvme_dev() will only print an nvme device node if one is found,
so no point in printing an error message.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c27cde..086c094 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -306,6 +306,7 @@ _find_nvme_dev() {
 	local subsysnqn
 	local dev
 	for dev in /sys/class/nvme/nvme*; do
+		[ -e "$dev" ] || continue
 		dev="$(basename "$dev")"
 		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
-- 
2.29.2



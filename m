Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33287C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FL3ukziMuP3lXKRN+J4rF26X/ySQSuYfMDXpif4XENE=; b=Rl2MCk9hCCQOYZLn7JtOaXm59u
	IP4Tw0O+biHvsMuiHiTcDVw4hslsbHrR8OyG7KA/9fnMLcKyK6aUtYZALQeSQ3CJm4sXAvQG7+Gof
	MRYcQsevK+SVSHZCtDdLe6p3WVdy+53F46lS7IFyckew03nZp8T0Gn5e3RbG8THiWlqAczrPbq1X9
	ElOxtnp/nTSzKL/EOkG2YzeFuus+9ucAwwuoxdRa5OS8Yl00F4Dtwq2vnxcbd/YGLTe2YdwvK2o7F
	wQTjV+lulqYkKGlDQ70d2erDoQRiywCnvdaymHXg5n9sbnJkvajGqDFL+Wh6WiG8bJWzSaWAAxjvt
	VfZOwEGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Kd-00FDAf-I9; Mon, 22 Nov 2021 08:05:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4Ar-00FAuJ-Uy
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 78D0B218A4;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FL3ukziMuP3lXKRN+J4rF26X/ySQSuYfMDXpif4XENE=;
 b=GsHFdPY9v8UF6PKgHrmRVvznyWHTZw6mzcBfuUc/ul0bNbSqx6hESSQ9Z+5tXO9esnc0c6
 P2De20LC5DGEJpeVqU+VbHkNvlDldc9zq0NiSgDjJjs27R8bDn+wL63W77gVKU2hSmJvPm
 SI07vOQTBi7WtwvBYY6d6jdSuG19Dnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FL3ukziMuP3lXKRN+J4rF26X/ySQSuYfMDXpif4XENE=;
 b=IM/43R/jRkLieJ8MMXw8YAPhybvN/B1IVlYUxR6qtNHjIIN8jTE5ZroO4WzxvpfAbnNBA6
 K9RFb4jrN4KLFyBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4A2B6A3B88;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3ACED51917EF; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/9] nvme/rc: do not print error message when no nvme device
 is found
Date: Mon, 22 Nov 2021 08:55:16 +0100
Message-Id: <20211122075524.26207-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_230939_51747473 
X-CRM114-Status: GOOD (  11.07  )
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
2.26.2



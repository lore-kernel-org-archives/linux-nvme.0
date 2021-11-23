Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4B9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKGYENReaGCmB9+Lz7gJ1EC7SZqKIzVsnLfgn6arU5E=; b=LsIKaIKmEsTjPYtbjkGL0gqT3M
	WM25Ra3kypvEiFGiE7sgd4OUvEqrEVs9rrCjbOnIDcEHYOUBuwoN6leMlhNyj1xKuw6r0pNSh4HGO
	6MAwksY5o7vogeUB+VW6szxm0UH/iTAKOpQtkJ7tR6yijOqnKMqh8F5+Q+xUnstDugf1ALLBtgwtU
	9NWobyXbxUxfvW6odcab2tajrFVY+08zbHzXCFYJjuCmaRrrWhqcCiCr7quudPgXaBfwaA6MMXMDg
	2KRQOpOfD4aHo7w6LNPP6hKWayAtdRUbFSW0s4IOVjIZcGS72t0UYnIBmimYmnFz83cgjWsJacOZL
	ht1n4TSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQZX-0016uz-PX; Tue, 23 Nov 2021 07:50:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYq-0016hC-5c
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:55 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 202BF1FD5E;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKGYENReaGCmB9+Lz7gJ1EC7SZqKIzVsnLfgn6arU5E=;
 b=T9AuXvwYJbZ4as98bh3KEEwYb5qRbZT3Z6QuUVWS2qk7TGpKX8vJNdOzDy0PjnFad9NdvX
 /0oLa1LHGUBgijCbQ9oRKjRduiimJ3ftgTCxRnf3K39RVhNP/WGtZQyEmF4QJuAEBv0Bjx
 poNvhUjmBqbCWuwh7ujQP2j9qvCmjPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKGYENReaGCmB9+Lz7gJ1EC7SZqKIzVsnLfgn6arU5E=;
 b=1myMV1L0Jd+j6xQUM/gjGY6N7oCjr6unUjDVCof7tAeK+EwIjIS9gXBUh3i+HbNwpeXMPn
 K4BdX/yOzqbUmrCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2A826A3B88;
 Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 15FD65191885; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Date: Tue, 23 Nov 2021 08:49:32 +0100
Message-Id: <20211123074940.113390-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234952_426537_69583978 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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

When removing a subsystem we need to clear out the allowed_hosts
subdirectory, otherwise removal will fail.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 086c094..aa223df 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -262,6 +262,7 @@ _remove_nvmet_subsystem() {
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	rm "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
 
-- 
2.29.2



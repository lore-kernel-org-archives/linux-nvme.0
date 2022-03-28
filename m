Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3E3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKGYENReaGCmB9+Lz7gJ1EC7SZqKIzVsnLfgn6arU5E=; b=GdATdTpYgGojE5tEqNmisCbLLj
	bgyjnqndwPT0p5A9vrBWZoUFVXpmLS3pPMAuIzrAPAFHpYIKTEtGN92k0s8aw+slZ9YrxeblPizox
	YZNY0ebgN0QpsEpuUeoXbS/qu5bOlGT1YKM9pwZ9qVg1dUceuZ3IyefvI8g4thiNL/U69Lf/V2Z9n
	nioh4goE6gK80+Ecb23myM0tylNs4oR/bNPU0NrSZtzlhEArYAQvLXnJOTdwfN7UL0QBjy709nOsR
	pMS9eLxpQI2pMkWGo1sco2Mh9shCIAPEUlM0jJTI6taP7qcGKsfP/VhWCHp4HE4wMIL8fPlTqLE6e
	mFjIGOxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTH-008900-S1; Mon, 28 Mar 2022 10:19:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uS-O5
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 487B7210ED;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKGYENReaGCmB9+Lz7gJ1EC7SZqKIzVsnLfgn6arU5E=;
 b=e0BpG4ExNbxj9v3LAdQRVW7cGW7++eAqQcS+wvlLmcwoPJom+B+ZEmCEspCEzdsXo2aYpX
 LC68UcxKnKy1tJfjiyjtCEXkaILHimdJoU4rCAao1wUpdG63s7wIUwcCkpKFbM+u98Hey7
 BI7HGsvnj31AUga3QjU9ky+7XmC2tok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKGYENReaGCmB9+Lz7gJ1EC7SZqKIzVsnLfgn6arU5E=;
 b=OkCNo6VEHjpRMlWqqG9ZvLOZ8jsQqQczKsOqw+VpEKMZ1uPn6IIsc6R6Uc6UydUvE9S8PH
 h8ezNltPCjvjelAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 3DCF7A3B8A;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 2EB1951939BD; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Date: Mon, 28 Mar 2022 12:18:47 +0200
Message-Id: <20220328101855.73975-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031922_033866_95CC3427 
X-CRM114-Status: UNSURE (   8.19  )
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



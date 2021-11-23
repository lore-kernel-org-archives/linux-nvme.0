Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCl644BS86xIuOgxKcQTaXj0Oocl1yF68WtmvUFdCkI=; b=pvXf6YyxnK4WCYkb5HdWVpLtPa
	W+V1SVLCfmuheE9MubvAj8KrjZ4xvWU+FvXB6OHRw2tUWgIwyJF2zrugbyC7Klpy5uKKMRCw0JzN0
	vdc1s1uQbaujMQBNMLWxzWa1UfeRBQg+YoCBmquEZLbu7Hw9cG3NjQXBOWoL8I6kLbAZfhvK253I7
	XJHV/ZJ3nwmO0KJ+9ajzSuaPmK5Lju7B2Rl/K/O9Wsav/q7QBZUBR06b08iUUkvitVFt8t6gEm1mE
	89QiEHqFIS7Uor3/XXuZbGhKws/UFxcDTs/aSMHu2cKTzRshnDWXn4JcOOAmZmBFxxvMIVT6OAA1K
	Z965MpRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQZ5-0016ne-Ks; Tue, 23 Nov 2021 07:50:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYq-0016hB-41
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:55 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 16E351FD58;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCl644BS86xIuOgxKcQTaXj0Oocl1yF68WtmvUFdCkI=;
 b=xt0OfuBg3ZUYlalLwakygWJC4NlXBmeY5Yha4rBWGuBQ/RxQ8htwINhIocB1oGKEQIBNst
 lK120wDr/zwTQUDWTFzSlTBedbyMIB8BOJKoAi2+jj8zfdul33rVZz5fBFEs3sMd4aILRc
 icwYMvUleDKJfX7i/V7O05RXMMCNtWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCl644BS86xIuOgxKcQTaXj0Oocl1yF68WtmvUFdCkI=;
 b=hQxaewOeuVXlMoNJnJbz+Hge3yonY+5r+/an4svzCuEXeBEogj1E36z7petArQhPfH/ZK2
 fjYdTMA8cCw0oBBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2ED7CA3B89;
 Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 1CFD25191887; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/10] nvme/rc: clear hosts directory in _cleanup_nvmet()
Date: Tue, 23 Nov 2021 08:49:33 +0100
Message-Id: <20211123074940.113390-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234952_425605_14E67226 
X-CRM114-Status: UNSURE (   9.60  )
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

From: Hannes Reinecke <hare@suse.com>

When clearing out the configuration we need to clear the 'hosts'
directory, too, as scripts might have added host configurations.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index aa223df..c284602 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -122,6 +122,12 @@ _cleanup_nvmet() {
 		rmdir "${subsys}"
 	done
 
+	for host in "${NVMET_CFS}"/hosts/*; do
+		name=$(basename "${host}")
+		echo "WARNING: Test did not clean up host: ${name}"
+		rmdir "${host}"
+	done
+
 	shopt -u nullglob
 	trap SIGINT
 
-- 
2.29.2



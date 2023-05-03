Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C870C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuH7OxLZZ6mL7lQtqpx6kEOj3SSaSSRaBrLmSYsP3ug=; b=MCPEzPVIcJ4yWGeugkAyKjHsv1
	qrWFVSFBPlQbTp0/BeVzZEfZxwNiHabuXCnVlRuLGX31r6dVn+GJxfcjLyycY5AQjbA7UdmTViH65
	dgPM1oI8hkdZ2RvY38Bt0WBUv/iqNVTk7eglBtLOShoOdQMee+HwXnc5dqwbgB9ceQhxWHAO9FbyI
	F/icyccthvmM2RYeydoNqdQ2smPdo+eeRltXAkiJad6XmLEUTstWCHO/Sk8BLWHObnBJ5aLeC85hi
	rpM7E0LiJuLFSoSNMiQwdWW0pjddLZq7joPvKBBEcN2ytTk7K2cYkkPkX6eDFxTBps1dM1H6wp0oo
	NnQAuxJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SN-003kJa-1x;
	Wed, 03 May 2023 08:03:23 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SE-003kAT-21
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 669B9200AE;
	Wed,  3 May 2023 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuH7OxLZZ6mL7lQtqpx6kEOj3SSaSSRaBrLmSYsP3ug=;
	b=SRxHYgUvOSN/luK2rX8SG+kDeTVs9HlxQ0Q56silroZmpi65o5b1Z9mA/hy6YejXCc55za
	t8XBXMTuruM6kEBn1mSXCSMFOZyewF/2Gbug6JdhZeDjGjlbWuCfrt2MzqvUjHxnDo7pQx
	1k5AUC6CzVMuf57L6AD1y6rHAVrUfG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuH7OxLZZ6mL7lQtqpx6kEOj3SSaSSRaBrLmSYsP3ug=;
	b=MQsYinun/4qb6UR8wykBHkBj3B7HWuhYIDDbO1gfb8OtbtSXjXKPJVdER2q9b9QvUDR5fT
	ZgYcKFCeuM1bpuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59B0C1331F;
	Wed,  3 May 2023 08:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id R8DkFUEVUmQ5YgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 06/12] Documentation: Add info on nvme_tr_type
Date: Wed,  3 May 2023 10:02:52 +0200
Message-Id: <20230503080258.14525-7-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010314_809270_8A234D96 
X-CRM114-Status: UNSURE (   9.63  )
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

Mention that the nvme tests can be parametrized.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 3550f377f487..7e827fba7ac0 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -98,6 +98,13 @@ requires that the kernel be compiled with `CONFIG_BLK_DEV_ZONED` enabled.
 RUN_ZONED_TESTS=1
 ```
 
+### NVMe test parameterizing
+
+The NVMe tests can be additionally parameterized via environment variables.
+
+- nvme_tr_type: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Run the tests with the given transport.
+
 ### Running nvme-rdma nvmeof-mp srp tests
 
 Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
-- 
2.40.0



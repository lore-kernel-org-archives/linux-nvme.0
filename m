Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B290C001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qnuw4NSvn2AmhK06974lvXqwW3/Fg/EvxHvoLZgamm0=; b=eUK4lPRN4Dx16YI7LAQpWyl0uS
	VKAKbnge2D7lquRUULQcA9Mtf5mFu/4R8q8K4sa+ClLVg5IBGL2qb3aVeOh15Aya+8P6Rvxar4Hjl
	Qg2z/qVWcY+zOD0sVmx2CAKwOWMJSTHxunxsZ4HEUyZh34GQIwTt0+moBkct5PK0eh9ZvfWg1nUOZ
	j5jFER9EOzy/rRbDZCxFFbiUnhxFq2+9Z6JuO6UCDddO/Ar9oeMWkOFbXGz3OnHvJeMaEobQHeh+G
	4/1WSiZMBHPcGSJdjCTvMODPJZ4RfAiaqvlgaqqzAqHLH7nD5jQr1NayyQnjXx1pDlS0nYf4cagJ7
	5CdW5blQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIot-0027L4-0u;
	Tue, 08 Aug 2023 09:16:03 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIop-0027IQ-0k
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 09:16:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92F0320315;
	Tue,  8 Aug 2023 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691486154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qnuw4NSvn2AmhK06974lvXqwW3/Fg/EvxHvoLZgamm0=;
	b=g6i559iBH9MrSdxsx+7dOMGeY+vjhzEajYfhYUYJR0KUPgg6dNMPEl9S1hDp0P53s19uZv
	9uRD0wtn1SkmVvYkTf/DIXy9j2ODF8+08nxFRm5yN8nEFqQ9H6x1+HCBuJBC9RTOgLA9WD
	BRQaKv4+VHLk7iD0n6gpNAzWbZSnGWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691486154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qnuw4NSvn2AmhK06974lvXqwW3/Fg/EvxHvoLZgamm0=;
	b=owksqn4iATOVSM18f+6OO5xQrSJ/30YxSMbLOEn0XX7gBrNwS8E+8yR0p1IYwn1uvDOXke
	9xgimDGGv+6YteDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8640613451;
	Tue,  8 Aug 2023 09:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sSuoIMoH0mQ/EwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:15:54 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v3 0/2] Do not pass disable_sqflow if not supported
Date: Tue,  8 Aug 2023 11:15:48 +0200
Message-ID: <20230808091550.25349-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_021559_419106_491B1A23 
X-CRM114-Status: UNSURE (   8.92  )
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

Follow up on the discussion in [1]

[1] https://lore.kernel.org/linux-nvme/676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me/

changes:
v3:
  - do not even try to use disable_sqflow if when it not supported
v2:
  - use cached options table
v1
  - initial verison

Sagi Grimberg (2):
  fabrics: Read the supported options lazy
  fabrics: Do not pass disable_sqflow if not supported

 src/nvme/fabrics.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.41.0



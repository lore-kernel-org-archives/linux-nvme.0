Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF73C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hstRHPtrpOcBlDp6LFA5+2lp7rWbV1Gd9Ha/HQ48ZkE=; b=taDzGvMyvE6vLH8346imtNO62u
	AIAkNr6v7vpbgZQQb/L78FqEvrA8mRPe9KNuypE7T3R+NlEObIEfad8IfcbYrzTLqBunp1uiyhya9
	nysyFQuP/dEy3npoUOQ/F9LAmL2hdzCYt/cfu3wEgh0uiItdEWQnPFIZYLprLAA/XglTIgFxyEjPe
	rbQwK4VRKSNAgnfDNBx9eBd8Egd3DiB+ang3c9k6k9voeB3R3x1uE+V5niAmDywbdThk798t660Bo
	ZnAELUucGawhsTwDuzhD9zhlAadaWA+nbVL/c5iM1JetVfRam5v7T3v8P6nGgAUbY4/q3xsr08Ecj
	Hf4KZjVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRh6-00HFF2-1m;
	Wed, 29 Mar 2023 09:02:12 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRh3-00HFBx-2M
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 09:02:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69643219CD;
	Wed, 29 Mar 2023 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680080524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hstRHPtrpOcBlDp6LFA5+2lp7rWbV1Gd9Ha/HQ48ZkE=;
	b=gqvQ8h3hheao6ZnLNIfd3R/CEtQWEajlUXrKx/d+uo5WacjhxYTA8zTgYWNBqe1pVtT1lD
	GyiHh/YCcyF78Y2uymbYpIRDStTIf5ACHD/6LL6nHtx4osYQEzTnJggh7Ic8AYjvEmiVUe
	7wUzoymV9oPWHTi5x4VOsXVz1dRLzS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680080524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hstRHPtrpOcBlDp6LFA5+2lp7rWbV1Gd9Ha/HQ48ZkE=;
	b=VuB1TsVIb0+xkHqgyxuBrY7uOB39g3nC3jfFW16iIuzUTrtEw6Sr2vU3eRb8q+780xCls8
	dufmKkqDnVPGC8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CAD1138FF;
	Wed, 29 Mar 2023 09:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xqmWFoz+I2RRdgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/4] Test different queue types
Date: Wed, 29 Mar 2023 11:01:58 +0200
Message-Id: <20230329090202.8351-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_020209_928189_FF38AABE 
X-CRM114-Status: UNSURE (   8.85  )
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

Setup different queues, e.g. read and poll queues.

As discussed I introduced a _require_nvme_trtype() function to limit the test to
tcp and rdma. I've upated the existing _require_nvme_type_is_*() checks to
explicit transport checks.

Test run against current nvme-6.4 but it still needs patch #3 from [1] to
survive.

[1] https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@meta.com/

changes:
 v3:
   - added _require_nvme_trtype() 
   - updated test requirement checks
   - replaced double shift instructions with 'shift 2'
   - updated license type
   - added FAIL checks
 v2:
   - make most arguements optional for _nvme_connect_subsys
   - move variable decleration at the beging of _nvme_connect_subsy
 v1:
   - initial version

Daniel Wagner (4):
  nvme/rc: Parse optional arguments in _nvme_connect_subsys()
  nvme/rc: Add nr queue parser arguments to _nvme_connect_subsys()
  nvme/rc: Add parametric transport required check
  nvme/047: Test different queue types for fabrics transports

 tests/nvme/041     |   7 ++-
 tests/nvme/042     |  10 +++--
 tests/nvme/043     |  10 +++--
 tests/nvme/044     |  23 ++++++----
 tests/nvme/045     |   6 ++-
 tests/nvme/047     |  66 +++++++++++++++++++++++++++++
 tests/nvme/047.out |   2 +
 tests/nvme/rc      | 103 +++++++++++++++++++++++++++++++++++++++------
 8 files changed, 194 insertions(+), 33 deletions(-)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.40.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8333C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZOUr56X6oLTAguiKSagJZCZFiRNyzc9eBOo+j7o65JM=; b=yBkHY3dHsDVq8uLe3qOP1uDz3T
	a2NJWEEcnMLrEF0MN/4QwuSIM82VX185/9+uQcB2v+jfkpW6Z7LoTvxzmVqANyroiJoBNPumckJWo
	TV5casZ70inNLA0sof/Zvu6ZejHKuf0gnRu9d8LDJI1ggPuhe8ZaF5SQyKvt2Kldd28viASvxaIRr
	ugrLH68ybzsIhYUIGqW3cqFeiIVItEjvaeM9QvEjQETKfJnPEF5npW/JL/+IL1rNH8eCbVRgd2dVB
	oQEjEULWJZxpjyErpWSSUH2Z1bM11NEdDypY0GHaar0NRf4FmBMOt+rsaw6BC7/ZUDmZ/D4oC1qfw
	J6PJJ19w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pevWe-00Fbcn-0Q;
	Wed, 22 Mar 2023 10:17:00 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pevWa-00FbZL-2v
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 10:16:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 505CE339B2;
	Wed, 22 Mar 2023 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679480212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZOUr56X6oLTAguiKSagJZCZFiRNyzc9eBOo+j7o65JM=;
	b=2JuL4xcNF4GZFaUSvrWQbOkNXVPAdMsmU+GuRYZ6Dk8ZBxCdvc9oknm1eODr1Fb2FSznT9
	Mo3NM/dSevCEmbBPIGcoMdNfyEXMdhvDTtyIisUJUIXwiiuZk1YGr3wifEe7DVYrN4QS8r
	MDlccMztxVi2hSmoXs3Y+HyUmU1x4/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679480212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZOUr56X6oLTAguiKSagJZCZFiRNyzc9eBOo+j7o65JM=;
	b=PnFDhm8zTI/oWCH2TLAPIeGzb5sb3u5LENFT/Pz9FuqFKdCCO0EHPq/jbqkay08hVdGeMA
	q0y/Z6gkjNhNg5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 419DE138E9;
	Wed, 22 Mar 2023 10:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jnrTD5TVGmR7DAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 10:16:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/3] Test different queue counts
Date: Wed, 22 Mar 2023 11:16:45 +0100
Message-Id: <20230322101648.31514-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_031657_093533_CA8C8C77 
X-CRM114-Status: UNSURE (   8.95  )
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

There is still the problem that _require_nvme_trtype_is_fabrics also includes
the loop transport which has no support for different queue types.

See also https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@meta.com/

changes:
 v2:
   - make most arguements optional for _nvme_connect_subsys
   - move variable decleration at the beging of _nvme_connect_subsy
 v1:
   - initial version

Daniel Wagner (3):
  nvme/rc: Parse optional arguments in _nvme_connect_subsys()
  nvme/rc: Add nr queue parser arguments
  nvme/047: Test different queue counts

 tests/nvme/041     |  7 +++-
 tests/nvme/042     | 10 +++--
 tests/nvme/043     | 10 +++--
 tests/nvme/044     | 23 +++++++----
 tests/nvme/045     |  6 ++-
 tests/nvme/047     | 65 +++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 +
 tests/nvme/rc      | 96 +++++++++++++++++++++++++++++++++++++++++-----
 8 files changed, 190 insertions(+), 29 deletions(-)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.40.0



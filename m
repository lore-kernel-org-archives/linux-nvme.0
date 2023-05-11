Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B2C7EE26
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8F01zoG6qFkp/pYPpjhsWI00zUgECS/Cfwhlo7ouPA=; b=Pg71EXNJYZkawMDjZy9jsPAV28
	WlRaxoDoiEBKUMhtU75W9lex3m1dHNg2jlH5/jgA1Kr4YsrZ2LIhUG251sBjJ3P6G/s5FO8KPsJMP
	sekI/b3lMDjMtJqpqeXNkgIi9Mq2/xi7YRrVhOcbpbN1FLQ1KdNb8k6MYsfXmmRwhLtaUDpsCg+02
	pCSygR1LFxuJ6OCGpYfEuTBLA0x4tbH75z+faXOsSBpFIldjD4hi/vrvrarvAHnZe8y9NExpz3IaU
	I10AUebYG+5CJFdUnZuxkEVIULZE1PGSnoh1Ye5wlvHVI7aLq2Uq0orbCZLlueS4WQiwyxmFlJSRL
	JLnCpWyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zo-008yiV-1U;
	Thu, 11 May 2023 14:10:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zl-008yfO-1X
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:10:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AC561FF00;
	Thu, 11 May 2023 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683814212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8F01zoG6qFkp/pYPpjhsWI00zUgECS/Cfwhlo7ouPA=;
	b=x2Nxq1+L+Wp/OsUzrzpq9C7C+amTDIHErO+8C2KYch3yTpnPSf+CGTV7OyUNM/47b8XCYv
	9QetYQyZHxVMLtJo3D8DbhdvFvA/URIAe9Nn0CKJaoxNjFC7z2kauYH47365lLNaE37m5a
	aO8ldkedBCNEkiA9avrIoCd9GW2Wtok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683814212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8F01zoG6qFkp/pYPpjhsWI00zUgECS/Cfwhlo7ouPA=;
	b=NnAIm9hvdcwAp/TEkNo9P8DtTAXyrQuI9jXoCn59Iq3N4i6T9m6aMusxEzER+UJ1UHCZEh
	RMAv7T/m/7esagAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE528134B2;
	Thu, 11 May 2023 14:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gCx2MUP3XGR0PwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 06/11] Documentation: Add info on nvme_trtype
Date: Thu, 11 May 2023 16:09:48 +0200
Message-Id: <20230511140953.17609-7-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_071013_659877_3A3844DA 
X-CRM114-Status: UNSURE (   9.23  )
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

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 3550f377f487..33c2a512eb6b 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -98,6 +98,13 @@ requires that the kernel be compiled with `CONFIG_BLK_DEV_ZONED` enabled.
 RUN_ZONED_TESTS=1
 ```
 
+### NVMe test parameterizing
+
+The NVMe tests can be additionally parameterized via environment variables.
+
+- nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Run the tests with the given transport.
+
 ### Running nvme-rdma nvmeof-mp srp tests
 
 Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
-- 
2.40.0



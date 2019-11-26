Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D0AC432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113FD2071E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="deIhzXos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113FD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sc67Kds7/49gzPyFkyzIhnUn61iUxUzBrEFS0zCoGGc=; b=deIhzXos9ua44R
	STQ0G3GqEBumSMTqS+qISx4GnyLr6czhj5fXDcJIhrdLBlKrgek2/ivJ3aRr99V3wXkbZR/1E4k4P
	+dXqHaSuJlocqsQ9AajmYrUIlK0O1FNCqV4mz9dAd4rv86DMmMcTfH/j2rTtpEtsNL2t12LgYNvvI
	HMM34jazEzmSzu2zrfD477wxI+O5XAbxBOoJIduiarqg3toWFc+n6M5Qnd/ItU/8niXNMP87RkVxF
	dDkJNB4dck0ifzj6vRs5QTEr5a+4Ao9kzloUhByRAH5zwgRZXMJfOM0Fvhs+tS6gq5ObgQzKVYrZq
	KG0Z39i57QpbdeLM7gsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZjIi-0007RZ-JZ; Tue, 26 Nov 2019 22:27:16 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZjIg-0007R3-9I
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 22:27:15 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 14:27:13 -0800
X-IronPort-AV: E=Sophos;i="5.69,247,1571727600"; d="scan'208";a="211562920"
Received: from unknown (HELO caliente.lm.intel.com) ([10.232.116.67])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 14:27:12 -0800
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: edmund.nadolski@intel.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
Subject: [PATCH v2 0/1] A few code cleanups
Date: Tue, 26 Nov 2019 15:26:31 -0700
Message-Id: <20191126222632.2446-1-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_142714_366958_BC76A78B 
X-CRM114-Status: UNSURE (   5.84  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patchset adds a few simple cleanups to the nvme code.

v2:
 Emit informational message when an error occurs.

Edmund Nadolski (1):
  nvme: remove unused return code from nvme_alloc_ns

 drivers/nvme/host/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.20.1

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

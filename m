Return-Path: <SRS0=16Sh=3M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A17C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 20:20:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24B122522
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVgdU+y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24B122522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D3oVz1NgUfRnSliHMPXhc6zIAHzlXtJjSa9rwFFgJx0=; b=eVgdU+y6qANBTW
	pIszgS1i+8kUZyjSPhZ0GaxKG+BsgEwsl5DFOQ+qYkM/YaWfgjiQch5GSkyWQwBdDM5E+vMLOMpmK
	s8A228kuswNg/BXGwbTrB1IQfD+M2PeqwABp+KtTZNi1KMKW7/ZHCu/4GKQUwWLI9zgffBmCJ797M
	SWv8AxZIPcag196UBCmrPRW27HpMD5tprb0RBQp0LhYDV9WqCwUmv7V4dJy44Kju7ncaMc8IiRHt5
	5WQdUWkejrYPap1Xu7pTM5bBmWU5344T8VuaOvEQ1Q1CfLBWIbPS7zgOx+pTxClHhcKaA5ITP6M69
	aR2dhXqsf2X81MzoKw/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iuixP-0001l7-8q; Thu, 23 Jan 2020 20:20:03 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuixM-0001Zu-TE
 for linux-nvme@lists.infradead.org; Thu, 23 Jan 2020 20:20:02 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jan 2020 12:19:58 -0800
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; d="scan'208";a="220784060"
Received: from unknown (HELO caliente.lm.intel.com) ([10.232.116.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jan 2020 12:19:57 -0800
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: edmund.nadolski@intel.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/1] nvme: clear stale nvmeq->tags after tagset free
Date: Thu, 23 Jan 2020 13:19:46 -0700
Message-Id: <20200123201947.4482-1-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200123_122000_953375_57EAA73E 
X-CRM114-Status: UNSURE (   5.06  )
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

v2:
 - clear from nvme_tagset_free instead of .exit_hctx callback.

Edmund Nadolski (1):
  nvme: clear io tags when freeing tagset

 drivers/nvme/host/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

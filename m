Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498C4C432C0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 16:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1342068F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 16:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G84DQ1Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1342068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8d+7GsDr86fKNigmvqT+NjriQBPwYP6RuIwd+I1Kklg=; b=G84DQ1Ot+VsGnY
	cXGXcLt1p5+rK5KoLVCqIbmgJNwoAXgyrcil8Tj8+v6r1oezl38HPu9snG5hIWAdPxNMvnrRYeqEY
	Az7Vyy8CckghIv/9+/9XeHVz4RisdanOVy+4dq7PvJcqiBpxfEuAaQAXYX+3tdI6kq8aer4byNJ9a
	0bqhurCqCzVLV+FFjzWA/2TEbwuzRZgMKa9DpwqOh2QgVgShLcJ4jwJXtEIQwhQuCSAbj6U0gyCKY
	Fd4/S5SXfrwUs2vnOuFx0ffiUlD0LfY8vzgk+YfjOwtiJfATmr3QINv+tRGX9+2xfbl9t6c3fY+0i
	UhooykOkkouJ7vtxZkVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZGt7-0003s2-8A; Mon, 25 Nov 2019 16:06:57 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZGt5-0003r8-1q
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 16:06:56 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Nov 2019 08:06:54 -0800
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; d="scan'208";a="202404082"
Received: from unknown (HELO caliente.lm.intel.com) ([10.232.116.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Nov 2019 08:06:53 -0800
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: edmund.nadolski@intel.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
Subject: [PATCH 0/2] A few code cleanups
Date: Mon, 25 Nov 2019 09:06:10 -0700
Message-Id: <20191125160612.3542-1-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_080655_100885_7C84C6D6 
X-CRM114-Status: UNSURE (   6.47  )
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

Edmund Nadolski (2):
  nvme: remove unused return code from nvme_alloc_ns
  nvme: else following return is not needed

 drivers/nvme/host/core.c | 21 ++++++---------------
 drivers/nvme/host/pci.c  |  2 +-
 2 files changed, 7 insertions(+), 16 deletions(-)

-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

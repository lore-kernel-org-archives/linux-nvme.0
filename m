Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A7C02198
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4wre0zPXnPNZa7TvD+8Q/ufmle3Zd24pfRjVh5eCkBk=; b=fSjimiL2kGWrrkrMV72EJBCC4s
	SM46pFhfWzrWy96wBX3xRdrs2UdobjgkIRWlnIi5pdvZmieeNDMWxLSngaYcSk3dLmjX8qm2S2FgQ
	C8zF2nMDcwlJrydR5j0TpTpN9WIwoCgD90tW73FXib2QKbL64NcbvmzAzdRyg1vj1uKMBzg2bZG2c
	7XMg1qwGYnEx+nPWedTyyYiG1IEy0qQQEwsBxzsp83PtiyNTirLBUYuFAGFVLhyTmeJCG/EK2OnnH
	Ctd7fFuLaJ+6GN0S7/4afJNDk8+un66O49BkfVTgtnQL4DzgA4kYU2mjQ18cKVr9VoXu0HtIFRLHY
	vCDfi6OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thcvR-00000001nWS-0Ixg;
	Mon, 10 Feb 2025 23:10:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwq-00000001aot-4ALy
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Feb 2025 22:08:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4wre0zPXnPNZa7TvD+8Q/ufmle3Zd24pfRjVh5eCkBk=; b=poQAL1XHrP8of0jzetwyhpPOEw
	tggl4OkbiL/NAXFpvd77Sj5OWF5UqYRsq00J7L1Yk22gvxGHicreRtixlS99kN1SBCFNuuji0R3qY
	8gu3VApSlXUlnqxW9NUQ9iogD7bps/BfZdG6xH6R5MJGyVMuubW/fAxqaCf84THwDSr+AM6erHkq3
	xXf03MDTNkWbjB+n/Lwba2mKIcZmgWJBISWwZQwJ54zWOWkzxORpIw+pCLNLSRwLuJb1KYl7q/DWF
	NGQWWitv61faW/eBqlhP0hS6mrwqxCSJwTtYjiAyY/4wwtUZLBQnJWM1od6EMY7PdU0XHvloVHXkA
	R3igIoqg==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwj-00000000JC9-3qg1
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 22:08:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 149E9A41709;
	Mon, 10 Feb 2025 22:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF24C4CED1;
	Mon, 10 Feb 2025 22:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739225282;
	bh=g9Xjg9cRHUAnfzq3QJcdsj1gM6HY3NgCqlft412Sjio=;
	h=From:To:Subject:Date:From;
	b=UZO52I+xzllM1tsVYy7xdVFHsoqteWXUO1wtSWDcyRYQacrYQ3sHymZ6jJfYcB/6+
	 PAuqCkXBq7gErUH77BUbFigD0NolWaoK8ya24fi8NzyNVNoUiJKJxP6C4DO49F5Z8K
	 5yLqd4Rtj7M8GdyHpU3egax79nQDD0Eu00gcMw1pNbVazqJFh/Aig7ecnzX/BwU+/a
	 aDC5li1QSghbepTX7TQF3f33jACzXioiyc2XUOyc25XLtO1qUTpiyxVJGHJ0n/cZpm
	 6FrHt1B3VCuxE01bugQ31t/MlaGnpb/CsFY2pJ8VUwcKBG45PtYD0StNNRsISlpakI
	 YiADgcETqCCcw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 0/4] nvme pci-epf target and tcp host fixes
Date: Tue, 11 Feb 2025 07:06:53 +0900
Message-ID: <20250210220657.1762684-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_220806_417866_2E4406B7 
X-CRM114-Status: UNSURE (   9.33  )
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

All,

4 patches in this series to fix some issues with the PCI endpoint
function target driver and a trivial fix for a compilation warning with
the tcp fabrics host driver.

Changes from v1:
 - Added patch 3 to fixe RCU stalls under heavy workload with the
   pci-epf target driver

Damien Le Moal (4):
  nvmet: pci-epf: Correctly initialize CSTS when enabling the controller
  nvmet: pci-epf: Do not uselessly write the CSTS register
  nvmet: pci-epf: Avoid RCU stalls under heavy workload
  nvme: tcp: Fix compilation warning with W=1

 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/pci-epf.c | 39 ++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.48.1



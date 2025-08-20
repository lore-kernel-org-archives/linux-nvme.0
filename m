Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D06CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uZUjCRr2nlA9E9AfiyuX6GZgUonqs2UYhzbCMwY5Ze0=; b=1jerThUwlZeiMP9XXW4fp1d3Fn
	sGvNLNFN4D2/uBzvY7rQfsoug4UIe9jr48z9qLcUEGFwk8Q5w6DVGVYmqriK6jPCMbBARqqeiX6wN
	4omwzaLjQfqZS8zJsCugDtTe4ZAI5rPlgFora+Q6eUzZRZQ83uZB6Yfrg93/X7NbdbBf7BEbtjat8
	jkwX/HSSuKRCEEnISJ3QKC+e51kpv8Ydfgx1myzX/Nh9XhWmCVNCFsCbIpM2hvPZ15z89IGrzUN+u
	DuDHtD9Yxbb6nhmSu9AlTD2BzeZwgpEnbq2/Tp0+ExpTs4lgKkXsFn+sjWvPSdM/7nmBsOz11lal+
	x9MjiQ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uogbs-0000000DHaH-33HL;
	Wed, 20 Aug 2025 11:04:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoerm-0000000CrlJ-0gcq
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 09:12:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 93B6B61430;
	Wed, 20 Aug 2025 09:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BC2C4CEEB;
	Wed, 20 Aug 2025 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755681141;
	bh=YKPdEoNUAkUaX4oZOPkIhdN8Mk15rJBAZJUdHjNcAWs=;
	h=From:To:Cc:Subject:Date:From;
	b=Tii0W23ypvWKu0EXkd3rRRtIhpUMBc3K9TciAboWFiLABZov7ETeLSsyYv7w4xQPJ
	 S+7Z/PdDZfUTxid9GYTA9ljhlszQeWL5jQHR33PMxKTFddyHlY10T1XXpefpWT9Rx3
	 lo+7YtYwVMLktCLq+afuaVPYxSdktzA5moDyT/BBr490k4v1XQz+20gpoBRPIO/rb3
	 pC4xxfqUDlJlxBF6EBVJjqfiX8Dfbib7OE8spntxo5ykIOdAdVx0ANLIwZen8USMNf
	 vTm+8pju+yRZztZ5nQka0o7leB+56LwXD103bf4XJHYloFitU5hWnkLpRqOjL49V+x
	 Q9+XZlwb5Dibg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/2] crypto,nvme: fixup HKDF-Expand-Label implementation
Date: Wed, 20 Aug 2025 11:12:09 +0200
Message-ID: <20250820091211.25368-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

As per RFC 8446 (TLS 1.3) the HKDF-Expand-Label function is using vectors
for the 'label' and 'context' field, but defines these vectors as a string
prefixed with the string length (in binary). The implementation in nvme
is missing the length prefix which was causing interoperability issues
with spec-conformant implementations.

This patchset adds a function 'hkdf_expand_label()' to correctly implement
the HKDF-Expand-Label functionality and modifies the nvme driver to utilize
this function instead of the open-coded implementation.

As usual, comments and reviews are welcome.

Chris Leech (1):
  crypto: hkdf: add hkdf_expand_label()

Hannes Reinecke (1):
  nvme-auth: use hkdf_expand_label()

 crypto/hkdf.c              | 55 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/common/auth.c | 33 +++++++++--------------
 include/crypto/hkdf.h      |  4 +++
 3 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.43.0



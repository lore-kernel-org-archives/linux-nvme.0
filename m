Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E30C5AC81
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6O6fwYO0V1o+Gk5m4zyd3j81GTFYD7SIa8ITeriVOr8=; b=3dxUq1TXeSek4q
	HtUt2Jy+Tmf1RIsi6RiOcH5GJqFZlmu1LTuN3xx+dDh93EKuFSjPMYeKIjSFvTvxP9muVBmxnXuFi
	Uv2bli6+5TB7VeMAwNnjXCoNQRy5UZ3ym38pvoLVBZE+8Ftjy8u3gYVqX0yVC8rB93JI2I1rhn9s7
	92DTHuykHdYb/urzfJrVh/GfurlWpy6Evr1Pqx6ap/WPsSK+xy8i/BOy9sSaU0KsxviIFRIG4TVsK
	urlKyy8yPzSt4V1lwn8lyYMFAMEBP0sPjyv7rUvfXZH/qd0R2U99eamM9jHBsVtnaTkh+asKZoh9O
	4PUMr5Hutu2pep9aGGTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01h-000000065Pc-3E8K;
	Thu, 06 Aug 2026 15:28:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065Dt-2sRr;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F15B60AB0;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42DB0C2BCC7;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=97rXyYGAbf+UW53T2G9gDyGIgLk+bK8TQS1U6+lks6c=;
	h=From:Subject:Date:To:Cc:From;
	b=LRDnI40SUVOKDS5Z3QK3Gf68m58P+JIqLdq08I9knGIppbPwVUh564mLz0wQh1GJz
	 84yXR9wACZHuPMAXxFpqwbddyM5nZV+D4IBbd0yndmYzXUjuu+rvJaQyFY6p5vQ1+I
	 coBd1PX0Xj4Z9pmZoFFIw+UUbPZTInneMz32HPq/i2xXg77wIMHAh7PQznoK5IsrnQ
	 vP8Ut1TWRjH2CbBn+o3WtxgGxQ8lMwT8KLMiOGx4muQZQWNbmjIi6TMqILY7QlCxj8
	 oG6bWNKtJaumpo9jg3LlYgjFvGgfgKZzbL/rNTkq/ZWx3UbRYKGp9y8JQW3BBKXNro
	 im2NnTFqHYh6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB27C56208;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH 0/6] Apple NVMe fixes for macOS 15+ firmware / M4 support
Date: Thu, 06 Aug 2026 17:27:32 +0200
Message-Id: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQoCIRCA4VeROTcwmoj0KtFBd8eaIAutLRDff
 W33+B3+v0HlIlzhpBoUXqTKMw/og4LpFvKVUeZhMGQceXIYLeblwZi+IQoS0dE7bX00GkbzKpz
 kt/3Ol931E+88vf8T6H0FOg1ZLXEAAAA=
X-Change-ID: 20260806-b4-nvme-fwabi-000386148b21
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=97rXyYGAbf+UW53T2G9gDyGIgLk+bK8TQS1U6+lks6c=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCjX5qiO3ThWxxLc1vD5y+Mjzz90rn7IxlvtXiEdw/
 5KQ1t3RUcrCIMbFICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhI43dGhrXse6xOvZooXxUo
 s2rZPyGBhSr2FxoznN6ZiOws3CRzYAUjw+vmOHlN3coX8+KtjMo8Hrjf0lwpkLusl2lJpdqnStl
 qNgA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407
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

Hi,

This series fixes a bunch of bugs that were working fine with M1/M2 NVMe
controllers with older firmware but are now starting to bite us.
With macOS 15 a new firmware is installed for the controller and both
XNU and the controller are a bit more strict now. This firmware is
required once we add M4 support.

The first patch fixes a panic that can happen when the controller fails
to initialize, which now happens for the first time with the new
firmware. The other fixes then make it work again.

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Sven Peter (6):
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme: Add a quirk for page aligned admin queue buffers
      nvme-apple: Require page aligned buffers on the admin queue
      nvme-apple: Drop the PRP null check chicken bit

 drivers/nvme/host/apple.c | 32 +++++++++++++++-----------------
 drivers/nvme/host/core.c  |  5 ++++-
 drivers/nvme/host/nvme.h  |  7 +++++++
 3 files changed, 26 insertions(+), 18 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260806-b4-nvme-fwabi-000386148b21

Best regards,
--  
Sven Peter <sven@kernel.org>




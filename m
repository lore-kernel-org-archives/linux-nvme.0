Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F47CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tt1PtBnXfqz3eJM+DhKGhyYr3pyUg+tKPpi6OvEGgpo=; b=4IVe60SINJUVTIHzfk+srajCti
	2KkP0JhoN8wyM2nTqDrzXBiQYf0AtkBLyLhIhT7sj/C80nBXdyRwc8oDyrYmn7IJTw08FhBG9CUgu
	oBmnFtAInM4wMt2iW5n+ZfcqxXrqiKHJ8RNyUkxgOBst/kMuVk8u6USd0D3R2sNIBk4Nu0BxzapRq
	XL1Sd/1acE56Kyqjf7nrOvcnRkPTP8pQITwMB6Q0tn3T6+sdt8vp+NltukNT+vfns2NWxslhSU0Mq
	qGQO0UGQ9+QynCgO6FFlU/PDAtQR/DKvgOTPiD8C7B7OjLIdW5aWox6FPNP/mvmsQkfoIceYAyPy8
	4VHqoQBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWp-00000008LSZ-0kmg;
	Wed, 01 Oct 2025 15:14:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWn-00000008LRr-0tFK
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 15:14:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E282E409D9;
	Wed,  1 Oct 2025 15:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DCDC4CEF1;
	Wed,  1 Oct 2025 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331640;
	bh=hDZM8QXYGAXwxcjqGlhYwYCYK3ucWfH0RwtX/IbaSp0=;
	h=From:To:Cc:Subject:Date:From;
	b=sToL9OFN5pLqHb+0t5gOQWEoaSJPlqSWh+xsnNykmSfXj2zXzw6sCTVHdi6UPsiID
	 3ebimlIBYELUvRizpHhzIrEYAWwoWnPqnCrKuEabjOFhQzdAGkuR/kCWQHsa4paMr2
	 l+bLuCrUJqVX6q6M5H6pTRakfZVBfPFjikm5z9CSepLScerO/VX4XhpaViiqwwfFz/
	 vgRI5VX5pKd9M04MW4G7xC8lO18QHChbcxeUonA80ek1CUQ1c88HPMJhZvQS0kOQ9Y
	 n3DW+0ac61UKuVAKFV6vwjUhq6MVCgnMHzOhrPjhSr98auOSfcGnNa5teS6O676OJi
	 chT1ec85HtRoA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/4] nvme-keyring: kbuild fixes
Date: Wed,  1 Oct 2025 17:13:47 +0200
Message-ID: <20251001151351.121181-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_081401_266941_FCC681EF 
X-CRM114-Status: UNSURE (   9.59  )
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

Hi all,

the kbuild robot uncovered some issues when having authentication
disabled. This patchset will correct them.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme-keyring: use correct format specifier
  nvme-keyring: typo in nvme_dhchap_psk_lookup()
  nvme-fabrics: make call to nvme_auth_extract_key() conditional
  nvme-keyring: fixup declaration of nvme_dhchap_psk_hash()

 drivers/nvme/common/keyring.c |  2 +-
 drivers/nvme/host/fabrics.c   | 10 ++++++++++
 include/linux/nvme-keyring.h  |  4 ++--
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.43.0



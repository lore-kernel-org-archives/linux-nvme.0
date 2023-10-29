Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5F4C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 23:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AiS7edw9zXGXOX8u8q0Kwy8eP3uM4xrKh030ozf50rA=; b=y0CDOappjxAjeD4Lq6ow/9UhNI
	akkZirshZuHzg2OPJBnwjXbNzg/1ujGrtpYGMEX+aSn6SfyQ/ljsCez3xsMH177YU08pbHzRERrOy
	lelKvyv5LlzgHLg+9xtre17sEQQw6taxJjjxgilZNun1D7r9jyNK56nLDA4oU12gEqGBhOZZO54Zn
	A5+eeB37Y2bLNIxONJnwDe5hC0L3H6oOF9MBbxJAvpfu8sHoNrBId/oZ35qX4WyZ4b1YIgdPz4sIp
	DyFZAx6pThnSllq2sGVNyGp1HKNPa7ZwL5RuHj5Zgc6NIkmhPbRVXWU2PZds5KSKfiWu1zIyG4mtY
	BPwpPqPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxElL-002El7-04;
	Sun, 29 Oct 2023 23:00:07 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxElF-002Ehk-23
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 23:00:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 3185AB80735;
	Sun, 29 Oct 2023 23:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74D3C116B7;
	Sun, 29 Oct 2023 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620399;
	bh=CJqlyIhB/xA4mTuuYRBU2/HCHTC5X8HdZJoiM/AgBcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSdNN91aRfkQSwhBpjzOsxXVxvKRtGlC4+iMXngm+YEjLtL2Fs/hb9Xyjt0N9G2t7
	 nkqulQrCMY62/bj1gsVcMnw77Hbu+jmbaQ+3o0gLTqGIPA9O0ZD4ZRbwlU/Re6Z7T6
	 7wUiESwASBw9FoS4IKiPt2L6HoAWXUGzax01d1VU9nQblDO4A/98sJFo3AmWpnlueO
	 Nh9baiHZJkI0rNM7v4DcD2JSPr96+zripMzQ4AM1LC3qdSioNGcipWE1MkczxuK293
	 nrUyohQ8LMjOIWxUj7ouvw49qCqQkurlWUrBLU/3NX/GA1ojRlgH0iZMhnexeMKYhA
	 ftkPeqBZZZfQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	welsh@cassens.com,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 27/28] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date: Sun, 29 Oct 2023 18:59:02 -0400
Message-ID: <20231029225916.791798-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_160001_887615_D78051F0 
X-CRM114-Status: GOOD (  10.14  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 ]

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 65172a654a198..19a61cddb56d2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3307,7 +3307,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.42.0



Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F3DC33CAF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7952073A
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KmP/Lo3u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZmlqdvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7952073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gregFh22H5mIUXOCRBSgAg88bdUST6m3FHWq/t0jZ/U=; b=KmP/Lo3uC4iTrR
	NlXhOP+TcoIb2Y57XGRNFAa1gFLD772D8BlDDdkB3+yFtjgW72iReYlghtWG7uE/XUbZ9cF13FkPm
	5mPWw1wAER7GIlbERpFM5qKpdQhRu5JKA0bgWoZqtqdOfYX78qCAbwBMSeRbr4YQG17SPcf7Dga4c
	CxhT1HQNevXjnsCMuO4bnh/VtxAwUTyIdrIy1jgJgwSEYbxoCOvw3XqX4tAi5S9zrP/HzvMM0bBIS
	LirCg2faxaQynHIHWU5Z3His/JOFx4RPbqwZvfH4TgrzYxrzgwBzSac2lpWn1Cs+vkxuwKwxcAMuz
	XO+CAew9rarc9PIGwhHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1is9Z9-0006di-DY; Thu, 16 Jan 2020 18:08:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is8xp-00073M-Kb
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 17:29:53 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F4F02470D;
 Thu, 16 Jan 2020 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579195789;
 bh=dD48XLursiYa//ePhMcMMl4C1MPrYkYGKY8FF/TExg4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DZmlqdvZVywIM7sIbFoRHeGTLSb+2RoS2daKQPJozSJd4kcncmMqZI75C7Ai22UPS
 hnejJmjatu9KlG75dB3oxCkeAw+LBQ+IlL2LIovdM0raEqdxElIlcL3UWEZnTH4w20
 8zapg/LofbksdntflHMRsS04fjS4q39N6fBo77Xw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 311/371] nvme: retain split access workaround for
 capability reads
Date: Thu, 16 Jan 2020 12:23:03 -0500
Message-Id: <20200116172403.18149-254-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200116_092949_718152_82706F67 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 3a8ecc935efabdad106b5e06d07b150c394b4465 ]

Commit 7fd8930f26be4

  "nvme: add a common helper to read Identify Controller data"

has re-introduced an issue that we have attempted to work around in the
past, in commit a310acd7a7ea ("NVMe: use split lo_hi_{read,write}q").

The problem is that some PCIe NVMe controllers do not implement 64-bit
outbound accesses correctly, which is why the commit above switched
to using lo_hi_[read|write]q for all 64-bit BAR accesses occuring in
the code.

In the mean time, the NVMe subsystem has been refactored, and now calls
into the PCIe support layer for NVMe via a .reg_read64() method, which
fails to use lo_hi_readq(), and thus reintroduces the problem that the
workaround above aimed to address.

Given that, at the moment, .reg_read64() is only used to read the
capability register [which is known to tolerate split reads], let's
switch .reg_read64() to lo_hi_readq() as well.

This fixes a boot issue on some ARM boxes with NVMe behind a Synopsys
DesignWare PCIe host controller.

Fixes: 7fd8930f26be4 ("nvme: add a common helper to read Identify Controller data")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd11cced3678..3788c053a0b1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2274,7 +2274,7 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 
 static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	*val = readq(to_nvme_dev(ctrl)->bar + off);
+	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

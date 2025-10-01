Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4353BCCA472
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCby7RSGgJOPOjFe4EbgrqVLYf9CZqlsG//4VZU1QJ4=; b=CrnBiwyApF7LoNrWQFkKixPJW3
	0tgsY9ZI4Uc/ErFPnoDz60J8yml9xro71Z8RJznRste6iXf+vunVuSukVens5rVOdam4iwX+E41iG
	2CC98XKIy/LKI07a75r7GO4vvIaqUFr50li4uKpSc5tVKRaQYz2HT45w6SE1qzMQiwKY7fqwDLx/w
	fsk1ny8vEdhIBoGF0e+Cn69meTUhh5xdhiEpi7/tj3CUNhEijXlwVPc1YElvFHW1FIpP9VHocXb2s
	+EwjyXDcL5jNQ1iGL2UVweyfpRpu1mLOobxQX01Doq3kWcnuKW/j6XoXcnFiNuw0Fr0LDiNgvKtSl
	/53F782Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWs-00000008LUi-3Sp4;
	Wed, 01 Oct 2025 15:14:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWr-00000008LTZ-0BdZ
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 15:14:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AE5F848C98;
	Wed,  1 Oct 2025 15:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252C7C4CEF1;
	Wed,  1 Oct 2025 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331644;
	bh=i9l/j6UudWk8LVHeOzd5dLEcSMgstXKbR/Ps7dQ21IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELwZrkjPVngzlzKG8KZp8XvjYVOAxyFN7PvBxjkfg0IXqhkgq84j9dwp7eCPs2Ag9
	 n8j4edVttqQwtNbDNiijZciTuZvS75/1Qgb0MTWMss+mVa0QnsT7HahSWKminec7S/
	 QQFiejhyxqQbf540Q5dNR9xgZbS9iTNt1cqe5RfmRtWnPWJbNWF/JTK77D/FtY9T44
	 Xm28Auz8nOs23a3G+cGW1C92+e1OEn5lrWFLPWPMhZ8HmeweBjrj7U9d2IZxw0ozwU
	 BjmhHUvlxJoPCedLWYUp8oDXFI46/g1HRlZsy86mHbqToO1xJO/jT9SSIynvW6HRqk
	 31VLJ4L1eSMUA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/4] nvme-keyring: typo in nvme_dhchap_psk_lookup()
Date: Wed,  1 Oct 2025 17:13:49 +0200
Message-ID: <20251001151351.121181-3-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001151351.121181-1-hare@kernel.org>
References: <20251001151351.121181-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_081405_097892_4C0D1F32 
X-CRM114-Status: GOOD (  11.30  )
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

Spurious semicolon in the function stub nvme_dhchap_psk_lookup().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com/
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 include/linux/nvme-keyring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index d8baa71f061d..6115bf5cf346 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -50,7 +50,7 @@ static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
 	return ERR_PTR(-ENOTSUPP);
 }
 static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
-		const char *hostnqn, const char *subnqn, u8 hmac);
+		const char *hostnqn, const char *subnqn, u8 hmac)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.43.0



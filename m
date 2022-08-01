Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA00C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4o0kWDh6ZNcJp/Ux8d1DgOiYxc4S8pVlPx5fSzy6eec=; b=g/ySc6eyWCv+7VdjfK8s5G0P2B
	SPLVU59MLpxVeVfjTlnaew8IlyyAu0pDMZxysVRL76iNuFoKHMUFn4OfuF+fhOmqvYmBJSLBy0VRd
	6754AwggiUC6cm9iiB7fHasdHMcZ8RrbfP/jkM+YVkjNOoYZeNl2NiP2PWtSXm/zVX/1gIgIXBigp
	mvcTfRUImc8cxalLt9j6Z2HtFFHqLwfk9gviF4oqylWRmrzktE/IamzPKMBLAhl/PtdXuuALsqLNR
	Kxd6HxJGw4Ih1xt5SRsqQUhNmcWFjbTMjFVBVmSR11+zAIglAir3EuI0E72ImrF0Tz1xCqscPPF5q
	pzAqwf5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIa8R-008wSW-TB; Mon, 01 Aug 2022 18:27:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIa8O-008wKH-2L
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 18:27:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9781368AA6; Mon,  1 Aug 2022 20:27:14 +0200 (CEST)
Date: Mon, 1 Aug 2022 20:27:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	muneendra.kumar@broadcom.com, james.smart@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "nvme-fc: fold t fc_update_appid into
 fc_appid_store"
Message-ID: <20220801182714.GA17613@lst.de>
References: <20220801162713.17324-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801162713.17324-1-emilne@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_112720_755140_5E7B220D 
X-CRM114-Status: GOOD (  15.95  )
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

On Mon, Aug 01, 2022 at 12:27:13PM -0400, Ewan D. Milne wrote:
> This reverts commit c814153c83a892dfd42026eaa661ae2c1f298792.
> 
> The commit c814153c83a8 "nvme-fc: fold t fc_update_appid into fc_appid_store"
> changed the userspace interface, because the code that decrements "count"
> to remove a trailing '\n' in the parsing results in the decremented value being
> incorrectly be returned from the sysfs write.  Fix this by revering the commit.

Wouldn't something like the patch below be much simpler and cleaner:


diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9987797620b6d..e24ab688f00d5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3878,6 +3878,7 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
 static ssize_t fc_appid_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
+	size_t orig_count = count;
 	u64 cgrp_id;
 	int appid_len = 0;
 	int cgrpid_len = 0;
@@ -3902,7 +3903,7 @@ static ssize_t fc_appid_store(struct device *dev,
 	ret = blkcg_set_fc_appid(app_id, cgrp_id, sizeof(app_id));
 	if (ret < 0)
 		return ret;
-	return count;
+	return orig_count;
 }
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 #endif /* CONFIG_BLK_CGROUP_FC_APPID */


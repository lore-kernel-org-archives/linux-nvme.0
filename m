Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECC3C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFtDdSx7wFPs8wt11gic3TO1BgaTX2W2SO/kh6sCvlw=; b=yRwF4DUiCWaMzWnrLhve1NR8vn
	uxx0IL2BVevNQxSLzxhxuBqHuQkoKuKcgqvV+Is9Zq/MNlNjZDmvf4mef9/nSOQxPbyAAoz2k/kQa
	0wXQWI+NonIrLA0p59NWLEieR50YGIj1M07A4YlseMax+/B/oitZE0lFYcqzhORr8rbwIkour2eAq
	eDBbclbzXLgZdgC+xLebypt9ENM+YuHCRt7Zpl8t+UYYug+Ku/9NkWtcxIkoC63XYo1sBtjPt5d0V
	9ezPrRwY4s0WMY3WPYKGJ0ky7Ll6GJGhHrWPKd2oD39ywJQGGUQJ7mijcmmDMgpQ1gjShpDDhHfZe
	ogZF0v+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhrpM-00000000TXY-3HNx;
	Wed, 06 Mar 2024 14:01:00 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhrpJ-00000000TWN-37Mb
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 14:00:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D0753CE21BE;
	Wed,  6 Mar 2024 14:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5B7C433C7;
	Wed,  6 Mar 2024 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709733655;
	bh=lbjlDSrqVL3uTgTETeuoaGAO3obwLToeBTJ1YzzicsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AK70nl1eUel/Pb8V6utWM4YILO/Nj8exPYTTa2IBW9oN+wgJbVTf/PGD3wXJUrIAW
	 OfCV2K+5CFSrPjiuhcpH5BFUXGbfVN8iLTeLoW72trNFnZclKioo5yAkOmkOu+6vR4
	 t2zhrhu6SaIoxsRwCSzEFwl6T1GqHxb89/5IoNas403U9VeelkDG2t/y3APeZRppYy
	 48BNMlRsN4aVFRxGxXWBFkpxyBPknG+k9fKBq9Bltf0YQQnz9rlDHG7HapM6mZJ8om
	 uQO1JYFVqBNf04LUp+2Iftn7m3GxvdAGceC0eRz5jXwyvQmi9QzA/QbJFPMcyX0Om2
	 VbTHAjG7XBNlw==
Date: Wed, 6 Mar 2024 07:00:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Message-ID: <Zeh3E0qz2BE16yKP@kbusch-mbp>
References: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_060058_111272_11F307D6 
X-CRM114-Status: GOOD (  16.01  )
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

On Wed, Mar 06, 2024 at 03:03:03PM +0900, Shin'ichiro Kawasaki wrote:
> When nvme_identify_ns() fails, it frees the pointer to the struct
> nvme_id_ns before it returns. However, ns_update_nuse() calls kfree()
> for the pointer even when nvme_identify_ns() fails. This results in
> KASAN double-free, which was observed with blktests nvme/045 with
> proposed patches [1] on the kernel v6.8-rc7. Fix the double-free by
> skipping kfree() when nvme_identify_ns() fails.

Your patch is good and applied for nvme-6.9. I just want to mention we
have a bit of an inconsistency in how the driver handles this pattern:
nvme_identify_ns_nvm() only sets the caller's pointer on success, but
nvme_identify_ns() and nvme_identify_ctrl() set it all the time. If we'd
only set it on success, then this problem wouldn't happen, so a possible
follow up suggestion to prevent the caller from having a pointer to
freed memory:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c4d928585ce35..2baf5786a92fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1403,8 +1403,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1533,6 +1535,7 @@ int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
--


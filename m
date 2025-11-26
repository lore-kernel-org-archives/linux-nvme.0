Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1695D111A3
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4uCmHB+sNFoSj/7w+pBqCdGDSfwjl88ek+wEkNeeOY=; b=Fsnvu1WeB3DJJckWhteDweG3d+
	lpy9WR1tYTu0i6VysnICa+TCzRxAOAHJe+gyXnMbIzmp4rTGA9vtQtKAfvaa4tVsXHTkHlVvt564v
	IbX5BnQXOgXZA3Ri0w+GFWlXXx66iNpmW/Fl9jf+RRtzBob0Ca4CfUfSpfIc/x/8YQwNFRTdYVlUn
	swJYWRRTzptewyoRPCyliBCoJe3N7bscOmFPfk2Bw01A9unG+MW/c+41l81d1347zVHhnd8I9XFsk
	/EqDlLYPUgmO8dD+OiZ06VR6q1mcw3YXcN7uGSbC+rYsd5RAgYiMr4M+5w7Ac4ebXUjkZ7Cl3Q9gW
	oDhK3PtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOMUn-0000000FdmR-03tp;
	Wed, 26 Nov 2025 20:52:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOMUl-0000000FdmL-2ScN
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 20:52:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B54B0601B2;
	Wed, 26 Nov 2025 20:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FFDC4CEF7;
	Wed, 26 Nov 2025 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764190330;
	bh=ummODbuTVwODNNLpHfFOIPFZYiF413uJ/4Wkgzo7XZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5cZ/O8jMVlp6qey1w+QzRXddTfwJjNAM4kFLC38sm6dOEVCLkfipUPYA8eTJBOkI
	 V4vbGqj4VEACvIWBKEW5CqXECCt70mR7A6wA5R1NOvGEckR3SA6u4AR7yO1XNiz1Q0
	 kAPHk9br5oxJ85qhP7kjDgaDQJQvUteoFnsmoL04Lpncb3dH9RpCazEcEkVKEVunsI
	 TElRXPxaSTy0rpqFibnmcrKmpuFc9Q53UMW9dDQXR0ZguOUZqf/Ui4R0xt6nvcb6kI
	 DMCyfPpOfkY72gmxeDif6LfriM73zWP1HvLofIYXVaNkf64KDYnXeCEmOQ/R8k/B0I
	 8W4z4mr+2LD5A==
Date: Wed, 26 Nov 2025 13:52:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aSdoeEX_L2-3ccpF@kbusch-mbp>
References: <aSdiqVR-o6yNav6I@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdiqVR-o6yNav6I@localhost.localdomain>
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

On Wed, Nov 26, 2025 at 11:27:21PM +0300, Eugene Korenevsky wrote:
> Broken or malicious controller can send invalid ns id.
> Out-of-band memory access may occur if remaining buffer size
> is less than .nidl (ns id length) field of `struct nvme_ns_id_desc`
> 
> Fix this issue by making nvme_process_id_decs() function aware of
> remaining buffer size.
> 
> Also simplify nvme_process_id_decs(): replace copy-pasted `case`
> branches with table lookup.
> 
> Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
> ---
>  drivers/nvme/host/core.c | 80 ++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 41 deletions(-)

Is this simpler check not sufficient?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa534f1d6b27a..6cc43cbb04dd9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1566,7 +1566,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
        for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
                struct nvme_ns_id_desc *cur = data + pos;

-               if (cur->nidl == 0)
+               if (cur->nidl == 0 || cur->nidl + pos > NVME_IDENTIFY_DATA_SIZE)
                        break;

                len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
--


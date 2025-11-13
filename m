Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2BFCD98D2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UIAf6yBqFv65Lk+izH88Z+n4NE1MsebK/TU6t59mwY=; b=KbBdZKnxwUEynwPPlA63jUsEL1
	/Yld3xwlXZ/FqRRCACjtAioNGahEkJamzJdCxvm4JOnOfRwSnNhp09/34xh6QU0MoSx5DPvga3LAs
	ozzxabmscGZSjStm6/bzh+k1Oecw9ag3i1SHg+cIusmUY+j2BfqYNRFhDTszDFf2AGB2ac9WpeJ/E
	RDKwlqrOD65NaEgYsD8qqvLtB0Grruvfgcph5SNJoqPfdvOAd+yjfzsq8qRC5tjUsUIAqpAj1Ix7L
	VqybqfYJHbQeOvIrkB0qRyyO1IGQ6rpglfmnwMntOmm1z17BmMgBPLqulvsNiiDARO9fUADIWOCt6
	yPgArEzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdMl-0000000B2g3-1rOS;
	Thu, 13 Nov 2025 19:52:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdMi-0000000B2fh-1Hbf
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 19:52:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 25F6443364;
	Thu, 13 Nov 2025 19:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A566C4CEF8;
	Thu, 13 Nov 2025 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063539;
	bh=QbTUe6a1+4aEbxz3ZqTrn1EgdpNUmW80HgS3yuxDreU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+vNXREOvbzwz9oe5TmZlFRg8Ktk0X3UM/yagsN9Y+pfojKv3kDTQQ609dXj6Uckl
	 EGvM8cFZ0C9jhYfFrh0/hkyuniIJXN3py43mvikWFQcRGoRL5H7+0DMtjzrLL17OLP
	 bgvDfPlKONVssTXYe7BONJTPLHuKaAkMq2+R4O5+7MxCQbLxCMscI7XVcdoaXPzXYq
	 1utYXcMWIZAFtgTEcsIOs3OXjUVFxJdrTg25wH0oXkXnk0EULF50nJ4aQsZmFwqT01
	 wV6O/FrUSLicfHTaqBqvaGyL+cWr48y4eRs9Cu6UpeHd8wvpGCy8s9Ck0LrCOp6GJy
	 ab6No2JhtE6Ww==
Date: Thu, 13 Nov 2025 14:52:16 -0500
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <aRY28IRvBFmTW6cz@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_115220_389434_17BE36F1 
X-CRM114-Status: GOOD (  15.65  )
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

On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
> be a fatal error. And secondly, this just further backs up that there's
> ZERO testing done on this patchset at all. WTF?
> 
> FWIW, the below makes it boot just fine, as expected, as a default zero
> filled iter then matches the UNKNOWN case.

I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The
state is never set in that case, but I think it should have been.

---
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 951f81a38f3af..1dfcdafebf867 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -166,6 +166,8 @@ pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
 			__pci_p2pdma_update_state(state, dev, page);
 		return state->map;
 	}
+
+	state->map = PCI_P2PDMA_MAP_NONE;
 	return PCI_P2PDMA_MAP_NONE;
 }
 
--


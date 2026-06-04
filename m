Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95637CD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:From:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dI9hVL01c71ih5HvIFpqlh4uVw1MCRSvG/NKiWvcWLQ=; b=nqmZucmp7XcUwS5aZ58YobqAd6
	XZPRSLWa7Jdwx7fTfzSKvBmi5fxUCk1U5wjbtvCk+IJiPefADvU1ayRi0ZjaQlQd6WqOfAwJNpCX8
	zyufgTbecedJDpWFGuHoTvb6DSgRhmtJ65pPdCHqpCa0zLFG0vJlF/7UIzmEocSaCTWuY+eUX8+I5
	WuXrDg3NjogzdtAv+qsObqzIcNbkaTF9LsgRztoMiUvkJtJvChc7oeOMhrYlha5LRoaZrl3Sri8gN
	6CufCz31VBUdIt3SeezPEOUbZva3OFDMaQ8PJAX5mfaCj2dCF7R+v645VeNI1NXuZteV4XlaBeuD7
	oodXovBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV3iz-0000000GQ5F-0vdt;
	Thu, 04 Jun 2026 08:46:49 +0000
Received: from mail-106118.protonmail.ch ([79.135.106.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV3iw-0000000GQ4G-15HU
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 08:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780562801; x=1780822001;
	bh=dI9hVL01c71ih5HvIFpqlh4uVw1MCRSvG/NKiWvcWLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FutPsjt6ixwu6+7P7T7PGrHGeO39WDWshmwGRwgTwRbsLMmKPbrHYmFG4mOCLQvsL
	 Sjj3+ESf+ngf1Tt1Q46V5uw/8qmc775mEU/AyTgh0pjEIcjlZ5/B98oFzwKtVydQV2
	 JXWA9SgYjV8x+WS7dyN4+WYLNhPYCR1a2ZrTfzWwYBu3OeOEb0DcK/WWraoowefi0l
	 R8I0AD1l7dMY/cRVuzDuZmUU519gfQnFXvHrnyjMUELrcI7zB8X1/cO6JJ1NRfiY83
	 nRB7FntcL2ztrHGTRyo/tSn8BQUYF4kJKQufyl5b+W/Qcn5Lg0j6K5NL5LiXs9Fxtm
	 QYjP6OEXPf0fw==
Date: Thu, 04 Jun 2026 08:46:33 +0000
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] nvmet-rdma: reject inline data with a nonzero offset
Message-ID: <20260604084624.120032-1-hexlabsecurity@proton.me>
In-Reply-To: <ahm6Ksr3rfGdnOsN@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me> <ahm6Ksr3rfGdnOsN@kbusch-mbp>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 30d429d49ffc879a29fff9a077634f43f6f5c5dc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_014646_973198_24C29A8A 
X-CRM114-Status: GOOD (  16.67  )
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

nvmet_rdma_map_sgl_inline() takes a host-controlled offset and length
from the inline SGL descriptor and bounds-checks them against the
per-port inline_data_size:

=09u64 off =3D le64_to_cpu(sgl->addr);
=09u32 len =3D le32_to_cpu(sgl->length);
=09...
=09if (off + len > rsp->queue->dev->inline_data_size)
=09=09return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;

This is unsound whenever the offset is nonzero:

 - "off + len" is evaluated in u64 and wraps modulo 2^64.  A descriptor
   with addr =3D 0xfffffffffffffe00 and length =3D 0x1000 wraps the sum to
   0xe00 and passes the check.  nvmet_rdma_use_inline_sg() then stores
   the offset into scatterlist::offset (unsigned int) and the block
   layer reads out of bounds of the inline page; a large len also makes
   num_pages(len) exceed NVMET_RDMA_MAX_INLINE_SGE and overruns the
   fixed-size inline_sg[] array.

 - Even computed without wrapping, inline_data_size is configurable up
   to max(SZ_16K, PAGE_SIZE).  An offset in (PAGE_SIZE, inline_data_size]
   passes the bound and then "PAGE_SIZE - off" in
   nvmet_rdma_use_inline_sg() underflows, leaving scatterlist::length at
   ~4 GiB and the offset pointing past the first inline page.

A nonzero inline offset is never legitimate here.  nvmet advertises
icdoff =3D 0, nvme_rdma_setup_ctrl() refuses to use a controller that
reports a nonzero icdoff ("icdoff is not supported!"), and
nvme_rdma_map_sg_inline() sets the inline descriptor addr to icdoff, so
a compliant initiator always sends offset 0.  nvmet_rdma_use_inline_sg()
likewise assumes the inline data begins at the start of the first inline
page (the RNIC DMAs it to page offset 0); any nonzero offset also
mis-describes the scatterlist even when it is in bounds.

Reject a nonzero offset directly.  This closes the u64 overflow, the
inline_sg[] overrun and the PAGE_SIZE - off underflow together, and is
simpler than bounding the offset.

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data"=
)
Cc: stable@vger.kernel.org
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Keith, thanks for the suggested form

=09if (off > rsp->queue->dev->inline_data_size ||
=09    len > rsp->queue->dev->inline_data_size - off)

It does stop the u64 overflow, but while testing it I found it is still
incomplete when a port is configured with inline_data_size > PAGE_SIZE
(it is settable up to max(SZ_16K, PAGE_SIZE)): an offset in
(PAGE_SIZE, inline_data_size] passes that bound and then "PAGE_SIZE - off"
in nvmet_rdma_use_inline_sg() underflows, leaving scatterlist::length at
~4 GiB pointing past the first inline page. The block backend then
executes the out-of-bounds read (KASAN trace below). Since a compliant
initiator never sends a nonzero inline offset (nvmet advertises
icdoff =3D 0 and nvme_rdma_setup_ctrl() refuses a nonzero icdoff),
rejecting off !=3D 0 closes that case too and is even simpler, so this
formal patch uses that instead of bounding the offset.

Verified on a KASAN build (inline_data_size =3D 16384) over an rdma_rxe
soft-RoCE loopback nvmet-rdma target with a block backend:
  - offset 0, 4 KiB inline write: succeeds, clean (control).
  - offset 8192, len 4096: without this patch the bounds check passes
    and the block backend executes the out-of-bounds read
      BUG: KASAN: slab-out-of-bounds in copy_folio_from_iter_atomic
      Read of size 4096 ...
    with this patch it is rejected ("invalid inline data offset!").
  - offset 4095 (< PAGE_SIZE): without this patch it is in bounds but
    mis-describes the SGL (NVME_SC_SGL_INVALID_DATA, no OOB); with this
    patch it is rejected up front.
  - offset 0 keeps working (no regression for compliant initiators).

 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -854,7 +854,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_=
rsp *rsp)
 =09=09return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 =09}

-=09if (off + len > rsp->queue->dev->inline_data_size) {
+=09if (off || len > rsp->queue->dev->inline_data_size) {
 =09=09pr_err("invalid inline data offset!\n");
 =09=09return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 =09}
--
2.43.0



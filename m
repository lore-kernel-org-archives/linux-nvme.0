Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE8ECD6E75
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:From:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujDKy6SWWWi8FQFzqh264wUeyQqzjQjB5x1dbv93N9A=; b=2FEq2pWONylx6P6FvUmc/cg5qg
	iV6rFiApmdudzGH5wQlmfKJMsDlqhhCqZBciQ7b6u5nFBiHoOz/ZSWdOiX5Az7FEuYqLbG+UNl2pP
	ysra0W8UuIgBVLmNtRcaYoHPunCy2mogaD2T9Z4gPAm+tUBN8fg5SNbEvOduGfppuBHJr3VzQFOOq
	IOZJw4ADL2uYN36Etjy0C3mg5HRNx5Cbnly+Wyg1KxnLk9CB+/EhrMwz9Lz2W7lOFhFVXbYc3lgO4
	3NN198zy8PsV85N20pm7Hvff5evfYssOUOGKg58hub8xNWQE+7Vu17KHl//Ov754FSxX/oCmIthv9
	va2BphxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVDsQ-0000000HDpc-18zu;
	Thu, 04 Jun 2026 19:37:14 +0000
Received: from mail-106120.protonmail.ch ([79.135.106.120])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVDsH-0000000HDov-0UHs
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 19:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=pidt2ukzyrggdauwg4b2q6m3ty.protonmail; t=1780601819; x=1780861019;
	bh=ujDKy6SWWWi8FQFzqh264wUeyQqzjQjB5x1dbv93N9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gO6rlClGX2rUj1P/zjADI2XSlrzTs/Z8DIcwM6+vGcKbbPTHF944ed7AHU/svnDAB
	 lKZdpDbDXFiErt27KaRWARK7g37jnGakUYP7SKuatzc9d0/q6F5fX9mbTOgUVyJJTg
	 gtxameNyvkRyftqodHv98Tg6ahoZgSu03F8XjQC3OIXEo4EwWSDA2l04HKKxrhNl5n
	 6STdQgx4i9RvHBTJ1vZCaZmMX95BR9wgLKc8OichtUO1J0CntObHzHt44mnZdWi0DD
	 76zOssE3t82y4aGjHPGsrN+xhu4EGdGtlYd4O81cIQ26+01LiJeay2tg0pnjRJdfII
	 G5BSGnLCnUQdw==
Date: Thu, 04 Jun 2026 19:36:54 +0000
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2] nvmet-rdma: handle inline data with a nonzero offset
Message-ID: <20260604193645.178350-1-hexlabsecurity@proton.me>
In-Reply-To: <aiFR81yE9_BIsNbM@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me> <ahm6Ksr3rfGdnOsN@kbusch-mbp> <20260604084624.120032-1-hexlabsecurity@proton.me> <aiFR81yE9_BIsNbM@kbusch-mbp>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: e669ea10f8438003e78f5e4cf1408c764e65c494
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_123705_829706_17640F18 
X-CRM114-Status: GOOD (  15.26  )
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

nvmet_rdma_use_inline_sg() maps the host-controlled inline data offset
into the per-command inline scatterlist.  The bounds check admits any
offset with off + len <=3D inline_data_size, but the mapping still assumes
the data begins in the first inline page:

=09sg->offset =3D off;
=09sg->length =3D min_t(int, len, PAGE_SIZE - off);

When a port is configured with inline_data_size > PAGE_SIZE (settable up
to max(SZ_16K, PAGE_SIZE)), an offset in (PAGE_SIZE, inline_data_size]
makes "PAGE_SIZE - off" underflow, so sg->length is set to ~4 GiB and
the block backend reads far past the first inline page.  num_pages(len)
also ignores the offset, so an in-bounds offset whose [off, off+len)
span crosses a page boundary under-counts the scatterlist.

Map the offset properly: split it into a page index and an in-page
offset, start the scatterlist at that page, and size the page count from
page_off + len.  Because the request scatterlist may now start at
inline_sg[page_idx] rather than inline_sg[0], generalize the inline-SGL
identity test in nvmet_rdma_release_rsp() to a range test; otherwise the
persistent inline scatterlist is mistaken for an allocated one and
nvmet_req_free_sgls() frees an inline page (and warns in
free_large_kmalloc()).

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data"=
)
Cc: stable@vger.kernel.org
Suggested-by: Keith Busch <kbusch@kernel.org>
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v1 rejected a nonzero offset; per Keith's note a nonzero in-capsule SGL
offset is legitimate (it is the per-command SGL Offset field, distinct
from the controller ICDOFF attribute that nvme_rdma_setup_ctrl() refuses
when nonzero), so v2 handles it instead, using Keith's suggested
page_idx/page_off form for nvmet_rdma_use_inline_sg().

Review context (not for the commit log):

Bound safety: with off + len <=3D inline_data_size the highest inline_sg[]
index touched is page_idx + sg_count - 1 =3D floor((off + len - 1) /
PAGE_SIZE) <=3D num_pages(inline_data_size) - 1 =3D inline_page_count - 1
(<=3D NVMET_RDMA_MAX_INLINE_SGE - 1), and page_off < PAGE_SIZE so
PAGE_SIZE - page_off cannot underflow.  The release_rsp range test is a
strict generalization of the old "!=3D inline_sg" test: inline_sg[0] is in
range (unchanged: not freed), allocated/keyed SGLs are outside it (still
freed), and only the new inline_sg[1..] starts are additionally treated
as inline.

Decides identically on 32- and 64-bit builds: off is u64, so the offset
arithmetic and PAGE_SIZE - page_off are evaluated in 64-bit on both ABIs;
num_pages() sees page_off + len <=3D 16384 (positive, int-safe on both);
the release_rsp comparison is a pointer comparison, identical semantics
on ILP32 and LP64.  (-m32/-m64 model output identical.)

A/B on a KASAN build (inline_data_size =3D 16384) over an rdma_rxe
loopback nvmet-rdma target with a block backend, inline write:
  - offset 0: succeeds, clean (control + no regression).
  - offset 8192: before this patch the block backend reads out of bounds
      BUG: KASAN: slab-out-of-bounds in copy_folio_from_iter_atomic
      (sg->length =3D 0xfffff000); with this patch it is served from the
      correct inline page, in bounds, no KASAN and no free_large_kmalloc
      warning.
  - the use_inline_sg() rework alone (without the release_rsp change)
      trips on offset 8192:
      WARNING: ... free_large_kmalloc ... Not a kmalloc allocation
        nvmet_req_free_sgls <- nvmet_rdma_release_rsp <- nvmet_rdma_send_do=
ne

 drivers/nvme/target/rdma.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 565183a20007..eb975fbd74a1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -666,7 +666,8 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rs=
p *rsp)
 =09if (rsp->n_rdma)
 =09=09nvmet_rdma_rw_ctx_destroy(rsp);

-=09if (rsp->req.sg !=3D rsp->cmd->inline_sg)
+=09if (rsp->req.sg < rsp->cmd->inline_sg ||
+=09    rsp->req.sg >=3D rsp->cmd->inline_sg + queue->dev->inline_page_coun=
t)
 =09=09nvmet_req_free_sgls(&rsp->req);

 =09if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
@@ -821,24 +822,25 @@ static void nvmet_rdma_write_data_done(struct ib_cq *=
cq, struct ib_wc *wc)
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
 =09=09u64 off)
 {
-=09int sg_count =3D num_pages(len);
+=09u64 page_off =3D off % PAGE_SIZE;
+=09u64 page_idx =3D off / PAGE_SIZE;
+=09int sg_count =3D num_pages(page_off + len);
 =09struct scatterlist *sg;
 =09int i;

-=09sg =3D rsp->cmd->inline_sg;
+=09sg =3D &rsp->cmd->inline_sg[page_idx];
 =09for (i =3D 0; i < sg_count; i++, sg++) {
 =09=09if (i < sg_count - 1)
 =09=09=09sg_unmark_end(sg);
 =09=09else
 =09=09=09sg_mark_end(sg);
-=09=09sg->offset =3D off;
-=09=09sg->length =3D min_t(int, len, PAGE_SIZE - off);
+=09=09sg->offset =3D page_off;
+=09=09sg->length =3D min_t(u64, len, PAGE_SIZE - page_off);
 =09=09len -=3D sg->length;
-=09=09if (!i)
-=09=09=09off =3D 0;
+=09=09page_off =3D 0;
 =09}

-=09rsp->req.sg =3D rsp->cmd->inline_sg;
+=09rsp->req.sg =3D &rsp->cmd->inline_sg[page_idx];
 =09rsp->req.sg_cnt =3D sg_count;
 }

--
2.43.0



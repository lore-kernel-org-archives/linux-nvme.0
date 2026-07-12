Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF78DC44506
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/WQDuqK/NjChhbBxD3JTeFauC+f/uWS/uyRXi7bvcA=; b=AcPbONHn2w10h1/SZjIm7uZlPi
	enotB/Bws3SpqgBjWQOD8uFRUazwXAf4uH767DyTftnA4GUDYArSP4jWlM7pISB0pe84qe2fbS0jw
	6rUoE0nrw4NEjn+K6SI1QJPfzC4saN+xHYOoryV/FnpJLCEqBTt1QUGFlFLMwP6dR+8zVo43H+7NL
	2mpmsh+1+q2D7E6KwHMQW/4A017UC7AXEBaGIUt9dtiXiQ1lxTrrg+CtfZ5ovqC485Gq49PAOaneP
	BC3n+H/FHem+1NqiSTXJVvRgcpDGld9Ksm1oa+UTNiaQRl5y7a7niDGoGatS3uziCuGP141p9oWHT
	O8pF26mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB2e-00000008OfW-40Xk;
	Mon, 13 Jul 2026 07:25:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wipt5-00000007HQi-0s8p
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 08:50:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4237340870;
	Sun, 12 Jul 2026 08:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927001F000E9;
	Sun, 12 Jul 2026 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783846210;
	bh=3/WQDuqK/NjChhbBxD3JTeFauC+f/uWS/uyRXi7bvcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e9uXBDi5t/Gg6bKf6bIWllf5kORgw+CsndL1cYQve78SVa/u4E+4W6PQh+wiIIDfF
	 HdQ90R/K5XGn2MxrLR26hp+2ogq51C53RFkdnbRBI/IysdiTo7mZ1galQHJPe/qpg2
	 St/PmancZXHAe7eEllyoKCUDpTxfGEA1lAj8vzfZOEwODq4tPMCO38o/JVDtGKonDN
	 RbSBunSXd1ifaECsK+KY93bmateqV7gfwJXJuFRYzhSO451APa5GhGT88+OAEVTVr2
	 SuYvRd+gveLivi6QRyOt+1ClObAW9U8xA+DbU1sQnwGm+Wq+Ehcjj264X/qycRr9Sz
	 H0uaVmkwnxqpw==
Date: Sun, 12 Jul 2026 11:50:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, mkalderon@marvell.com,
	zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, bvanassche@acm.org,
	kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	cel@kernel.org, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
	anna@kernel.org, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, michaelgur@nvidia.com,
	edwards@nvidia.com, phaddad@nvidia.com, eadavis@qq.com,
	yishaih@nvidia.com, kalesh-anakkur.purayil@broadcom.com,
	andriy.shevchenko@linux.intel.com, clm@meta.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 rdma-next] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260712085003.GC33197@unreal>
References: <20260709055211.2498307-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709055211.2498307-1-ernis@linux.microsoft.com>
X-Mailman-Approved-At: Mon, 13 Jul 2026 00:25:23 -0700
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

On Wed, Jul 08, 2026 at 10:51:29PM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> The nvmet-rdma consumer of max_srq clamps it against
> ib_device.num_comp_vectors, which stays a signed int, so that site
> uses min_t() instead of min() to handle the signed/unsigned mismatch.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect
> ---
> Changes in v10:
> * Convert max_srq to u32. Use min_t() against the still-signed ib_device.num_comp_vectors.
> * Update commit message.
> * Change rdma_restrack_count() to return u32 and make fill_res_info()'s curr and max u64.
> Changes in v9:
> * Switch the srq_size module parameter accessors to param_get_uint and
>   kstrtouint()/param_set_uint() so they match the now-unsigned
>   nvmet_rdma_srq_size variable.
> Changes in v8:
> * Convert the remaining non-negative counter fields max_ee_rd_atom,
>   max_ee_init_rd_atom, max_ee, max_rdd, max_raw_ipv6_qp and max_srq_wr
>   to u32; keep max_srq as int (its consumer compares it against
>   ib_device.num_comp_vectors, still int).
> * Drop all remaining min_t() where plain min() now works.
> * Make the srq_size module parameters unsigned int so the srq_size min()
>   stays a plain min().
> * Replace the ternary-inside-min() with the simpler "if (x) x--;".
> * Reorder the send_queue_depth min() to min(value, CONST) to match the
>   sibling site.
> * Restore reverse xmas-tree declaration order.
> * Collapse the min()/min3() assignments that now fit onto a single line
>   within 100 columns.
> * Print the now-u32 fields with %u instead of %d.
> Changes in v7:
> * Drop min_t() in all sites where a plain min() (or min3()) works
>   cleanly
> * Guard nvme/host/rdma.c num_inline_segments computation against a
>   device reporting max_send_sge == 0, so the u32 subtract
>   cannot wrap to UINT_MAX.
> * Use %u when printing the newly-u32 capability fields
>   in diagnostic messages.
> Changes in v6:
> * Fix subject prefix: net-next -> rdma-next.
> Changes in v5:
> * Add U8_MAX clamps in iser_verbs, nvme/host, nvme/target, isert,
> * rds/ib_cm, smbdirect/connect and smbdirect/accept where u32 capability
>   fields were directly narrowed into u8 rdma_conn_param fields without
>   clamping.
> * Guard the inline_sge_count calculation in nvmet_rdma_find_get_device()
>   to prevent u32 underflow when both max_sge_rd and max_recv_sge are
> zero.
> * Expand type migration to 9 additional fields (max_mw, max_raw_ethy_qp,
>   max_mcast_grp, max_mcast_qp_attach, max_total_mcast_qp_attach, max_ah,
>   max_srq, max_srq_wr, max_srq_sge)
> * Fix min_t(int,...) in svc_rdma_transport; min_t(u32,...) in ipoib,
>   srpt, nvme/target, rds/ib, rtrs-clt, rtrs-srv, xprtrdma/verbsdd.
> * Fix frwr_ops.c u32 underflow guard (reorder check before subtraction)
> * Change sc_max_send_sges to unsigned int, inline_sge_count to u32
> * Fix %d -> %u in rxe_qp, rxe_srq, ipoib_cm, ib_isert,
> * svc_rdma_transport
> * Update commit message.
> Changes in v4:
> * Drop clamping the values in mana_ib_query_device, instead update
>   the props values from int to u32.
> Changes in v3:
> * Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
>   caps cache does not need to be clamped.
> * Move all clamping exclusively to mana_ib_query_device(), which is the
>   only place the cached u32 values are narrowed into the signed int
>   fields of struct ib_device_attr.
> * Reframe commit message: this is a u32-to-int type boundary fix, not a
>   CVM/untrusted-hardware hardening patch.
> Changes in v2:
> * Update patch title.
> ---
>  drivers/infiniband/core/cq.c               |  3 +-
>  drivers/infiniband/core/nldev.c            |  3 +-
>  drivers/infiniband/core/restrack.c         |  2 +-
>  drivers/infiniband/hw/qedr/verbs.c         |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c         | 22 ++++-----
>  drivers/infiniband/sw/rxe/rxe_srq.c        | 16 +++----
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c    | 10 ++---
>  drivers/infiniband/ulp/ipoib/ipoib_verbs.c |  3 +-
>  drivers/infiniband/ulp/iser/iser_verbs.c   |  5 +--
>  drivers/infiniband/ulp/isert/ib_isert.c    |  7 ++-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c     | 11 ++---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c     | 11 ++---
>  drivers/infiniband/ulp/srp/ib_srp.c        |  2 +-
>  drivers/infiniband/ulp/srpt/ib_srpt.c      | 21 +++++----
>  drivers/nvme/host/rdma.c                   |  8 ++--
>  drivers/nvme/target/rdma.c                 | 26 ++++++-----
>  fs/smb/smbdirect/accept.c                  |  5 ++-
>  fs/smb/smbdirect/connect.c                 |  5 ++-
>  fs/smb/smbdirect/connection.c              |  8 ++--
>  include/linux/sunrpc/svc_rdma.h            |  4 +-
>  include/rdma/ib_verbs.h                    | 52 +++++++++++-----------
>  include/rdma/restrack.h                    |  2 +-
>  net/rds/ib.c                               | 10 ++---
>  net/rds/ib_cm.c                            | 10 ++---
>  net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
>  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
>  net/sunrpc/xprtrdma/verbs.c                |  2 +-
>  27 files changed, 129 insertions(+), 133 deletions(-)

This patch touches too many areas to delay it further. Let's merge it
now and improve it later, if needed.

Thanks


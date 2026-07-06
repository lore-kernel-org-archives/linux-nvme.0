Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5D6C44501
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9jiSSkCBnbVD7ihxmuDYCTOJSaEPHEl7wjng44WMYRs=; b=Ewd66cfG+S1vzZYo3/+LPYT2er
	sYAfdoOnO4YYa443gj0FuCkXYdz5TRzJJ843v9Qoqy2Ob0lRa6J6AMcSEh0UswIrwn0tx7NuGjSeG
	okQAzcoT5zCZIhkmXWVCivwAJwk+2zF0bbeYh/8pRkxpt3JfgVynxX1mduuu27BKRZsc1Bv0FomzS
	HPE8ueqJR7EHC72PaWWUv6K3woPqHHTOxrkeeAie2mejre2r+0BaRRNecqSmMxBfb0KNRAyVgMQL5
	acMG+gWuAmN4lJAvweAxNcx+hcSVdZqNouna9GQFe3eQ4jnV8iqUhfzCqHAJ/a5lY0tNfPU9iIzr3
	eJMxRAqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whN58-0000000GXgy-3Xui;
	Wed, 08 Jul 2026 07:52:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgf1Y-0000000BtyU-15ix
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 08:49:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 065104352A;
	Mon,  6 Jul 2026 08:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978CA1F000E9;
	Mon,  6 Jul 2026 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327795;
	bh=9jiSSkCBnbVD7ihxmuDYCTOJSaEPHEl7wjng44WMYRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQADDgAfKOb+QRTcxlAPYJxUo81CV+X2k0sH4dqu4MXUhUvI8d0gKIn3fSYrA1PX/
	 tkL8EscUhizGPIAmstyC+IcGi0Bpq2pmvmlHX04vH8BLW7siC04DcmJ3HXxv8hq27U
	 Cm3VdQdVL+4wwVwhFK7HQmPqA48e10qpeEhHd7fFACoRgnafr1d4FUho7fCK2UTrgb
	 YogOm5FOfD941STn0/3UYZu0szCwziMiufd32dSLEBhvVT9dg6Be1JIoRbfI00bgNA
	 1oij26/UKxOAPFBnCcX21MUoXrF/X4CgR3ssY2W31wgMyjX/YgrYc2fFtMVYhbR2Xe
	 VpXfNmIUilBiw==
Date: Mon, 6 Jul 2026 11:49:50 +0300
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
	horms@kernel.org, kees@kernel.org,
	andriy.shevchenko@linux.intel.com, clm@meta.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v9] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260706084950.GK15188@unreal>
References: <20260703060329.896125-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703060329.896125-1-ernis@linux.microsoft.com>
X-Mailman-Approved-At: Wed, 08 Jul 2026 00:52:34 -0700
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

On Thu, Jul 02, 2026 at 11:02:57PM -0700, Erni Sri Satya Vennela wrote:
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
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect
> ---
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
>  drivers/infiniband/hw/qedr/verbs.c         |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c         | 22 +++++-----
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
>  drivers/nvme/target/rdma.c                 | 22 ++++++----
>  fs/smb/smbdirect/accept.c                  |  5 ++-
>  fs/smb/smbdirect/connect.c                 |  5 ++-
>  fs/smb/smbdirect/connection.c              |  8 ++--
>  include/linux/sunrpc/svc_rdma.h            |  4 +-
>  include/rdma/ib_verbs.h                    | 50 +++++++++++-----------
>  net/rds/ib.c                               | 10 ++---
>  net/rds/ib_cm.c                            | 10 ++---
>  net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
>  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
>  net/sunrpc/xprtrdma/verbs.c                |  2 +-
>  24 files changed, 122 insertions(+), 127 deletions(-)

The following code is still missing. Also, what about mxa_srq?
Why wasn't it converted as well?

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index f599c24b34e8..aae4f3f6bcba 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -454,7 +454,8 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
        };

        struct nlattr *table_attr;
-       int ret, i, curr, max;
+       u64 curr, max;
+       int ret, i;

        if (fill_nldev_handle(msg, device))
                return -EMSGSIZE;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index cfee2071586c..1b2f9df49e28 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -61,7 +61,7 @@ void rdma_restrack_clean(struct ib_device *dev)
  * @type: actual type of object to operate
  * @show_details: count driver specific objects
  */
-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
+u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
                        bool show_details)
 {
        struct rdma_restrack_root *rt = &dev->res[type];
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 451f99e3717d..c081384740ce 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -123,7 +123,7 @@ struct rdma_restrack_entry {
        u32 id;
 };

-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
+u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
                        bool show_details);
 /**
  * rdma_is_kernel_res() - check the owner of resource


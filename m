Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72081CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95z+KUvYfzNjg72dlH7hJkUUewGQ6v3lUPAeGOBaQN4=; b=Eoyyj6vdpEwHNKhYg0Yshu6Ozh
	HFK42XTfBxvOydFIdY8z3MPA8u7TIG/hXAY9IhxG41HNcX2W80zSg7TxJOpfyu35OtHZAtF0YvEDr
	wWcbUmuNRu2nz8oJZO7mBiHhs4VYJFUwzNlwodQq1+qPnk1gtBDTi3B8nj6OeAzqnzUE2BXPr29nE
	RT0ycHS6CDX2X20B2S9wCQJXK0wtMr/pZpOzdoLGdcXeSQ31hSM0TrkfwkKYBIfqwSRa7w1BpNfsX
	HYQ0PTnS66YBD2FKWtWVzvbau8gPXhdlqwCFvVciC7ZyBLnnibbGm0dZTP0kh/QGUnILf65CkwgFs
	VmCntUNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4rX-00000008FIX-10CT;
	Wed, 12 Nov 2025 07:01:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4rU-00000008FHk-3FXd
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 07:01:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9036227AB7; Wed, 12 Nov 2025 08:01:40 +0100 (CET)
Date: Wed, 12 Nov 2025 08:01:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v5 6/6] nvmet-tcp: Support KeyUpdate
Message-ID: <20251112070138.GG4873@lst.de>
References: <20251112042720.3695972-1-alistair.francis@wdc.com> <20251112042720.3695972-7-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112042720.3695972-7-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_230149_096751_A6943241 
X-CRM114-Status: GOOD (  30.46  )
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

On Wed, Nov 12, 2025 at 02:27:20PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
> a KeyUpdate handshake type then the underlying TLS keys need to be
> updated.
> 
> If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe host sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> v5:
>  - No change
> v4:
>  - Restructure code to avoid #ifdefs and forward declarations
>  - Use a helper function for checking -EKEYEXPIRED
>  - Remove all support for initiating KeyUpdate
>  - Use helper function for restoring callbacks
> v3:
>  - Use a write lock for sk_user_data
>  - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
>  - Remove unused variable
> v2:
>  - Use a helper function for KeyUpdates
>  - Ensure keep alive timer is stopped
>  - Wait for TLS KeyUpdate to complete
> 
>  drivers/nvme/target/tcp.c | 203 ++++++++++++++++++++++++++------------
>  1 file changed, 142 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 818efdeccef1..486ea7bb0056 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
>  
>  	/* TLS state */
>  	key_serial_t		tls_pskid;
> +	key_serial_t		handshake_session_id;
>  	struct delayed_work	tls_handshake_tmo_work;
>  
>  	unsigned long           poll_end;
> @@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
>  	struct sockaddr_storage	sockaddr_peer;
>  	struct work_struct	release_work;
>  
> +	struct completion       tls_complete;
> +
>  	int			idx;
>  	struct list_head	queue_list;
>  
> @@ -214,6 +217,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
>  static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>  static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> +				   enum handshake_key_update_type keyupdate);
> +#endif
>  
>  static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>  		struct nvmet_tcp_cmd *cmd)
> @@ -832,6 +839,23 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>  	return 1;
>  }
>  
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
> +{
> +	if (ret == -EKEYEXPIRED &&
> +	    queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
> +					return true;
> +
> +	return false;

Extra indentation before the return true.  This could also be simplified
down to

	return ret == -EKEYEXPIRED &&
		queue->state != NVMET_TCP_Q_DISCONNECTING &&
		queue->state != NVMET_TCP_Q_TLS_HANDSHAKE;

or if you want to do away with the ifdef entirely:

	return IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) &&
		ret == -EKEYEXPIRED &&
		queue->state != NVMET_TCP_Q_DISCONNECTING &&
		queue->state != NVMET_TCP_Q_TLS_HANDSHAKE;

Othwise looks good.


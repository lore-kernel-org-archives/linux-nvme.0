Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F4CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rjPJQkM0fLk8gYwjAGYei/TCZcpAauv07XZFNpzHPC8=; b=xhp2qIx21Xk0UHgxZ5okcp1P10
	RLVHd52fIhBe81lOxdYt9b1yf9yd4SEnSOdpO04zfZdo9X8UQcr5OirwiJzMjmeBc1VDngXF4fijO
	Hhe4tGra/v1OUsX50gaKow8LTtH38Rz3Ea2Dix4JIF18Wk8J0+vMQoGYJu6CCXq0JIElUiWTqT3i6
	yJm9p/Mmzb5N8dy/SbmlfoElJ7yYCML0MQ7jQZpUloL0uhX5L3M9p4y/ruhAQqocmbNjxmV4OY5bW
	w7iz51zF+46kFSkaHbVUVPYJRekmdMDHHQCSqLeIfMCDAVHEsDIehV8Q4SrzNMU6WjAIxW/X4JENq
	kEbqh+KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHD3-00000007YCt-0pca;
	Wed, 10 Jun 2026 11:35:01 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXEYh-000000077Ib-0ICU
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 08:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=rjPJQkM0fLk8gYwjAGYei/TCZcpAauv07XZFNpzHPC8=; b=OfNsxpF9+NS6EnvAw3LrRN4MYk
	TscG52hSzQTtzwQ0GDX+3Jkad+GQvqJyax19KbAUFAZG6JhiOzxO+AeutzctfO+aOSz8F7GEltP+e
	NveACjQ1S3caoQ8J5/V0zuP2woD9H5Z0FhVHAvKZ5ovujpMkx5HnUIIleyEYjTh/OgkRPLdBQDtCu
	d1auYNOAdWzI2t+yvnZk6XGQ6t7NuK47aQ8U9WbZkS/aGcUIIb+VyK+lcBc3tPzM7PlF1iyM+n/oq
	Dq4b+T+/RUVCUhKzEP7tBYv+mKTLG7XEdeDibZyShJ6GxdSALI0baX983m7Rg9j9qCkuQFQYRxbEM
	0+aaG9w27NQR1srXf1kuc51VNv8QAfgHa02TWKdf7oNRMldGcr1I5Jk/MrYm+Z4/U+fU+KzcZfdkD
	Zun6uplYCq5m9zMS9gd2JZd2Us0ay3WIXnPBvQWD40Jmn+C9FDZsAW6nPV4UwNaCvZHOXpL3Ea/yA
	VbIsbcej6XidTcEsuN6h3Fbh;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wXEYV-0000000FFf5-2R6t;
	Wed, 10 Jun 2026 08:44:59 +0000
Message-ID: <c62b32d0-1469-4204-9af9-5ef3b47e3996@samba.org>
Date: Wed, 10 Jun 2026 10:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v7] RDMA: Change capability fields in
 ib_device_attr from int to u32
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com, sagi@grimberg.me,
 mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, achender@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 andriy.shevchenko@linux.intel.com, ebadger@purestorage.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
References: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_014511_125337_3FB723E7 
X-CRM114-Status: GOOD (  11.30  )
X-Mailman-Approved-At: Wed, 10 Jun 2026 04:34:59 -0700
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

Am 06.06.26 um 09:07 schrieb Erni Sri Satya Vennela:
> diff --git a/fs/smb/smbdirect/accept.c b/fs/smb/smbdirect/accept.c
> index 529740005838..44b681a20725 100644
> --- a/fs/smb/smbdirect/accept.c
> +++ b/fs/smb/smbdirect/accept.c
> @@ -32,8 +32,9 @@ int smbdirect_accept_connect_request(struct smbdirect_socket *sc,
>   	/*
>   	 * First set what the we as server are able to support
>   	 */
> - sp->initiator_depth = min_t(u8, sp->initiator_depth,
> - sc->ib.dev->attrs.max_qp_rd_atom);
> + sp->initiator_depth = min3(sp->initiator_depth,
> + sc->ib.dev->attrs.max_qp_rd_atom,
> + U8_MAX);
>   
>   	peer_initiator_depth = param->initiator_depth;
>   	peer_responder_resources = param->responder_resources;
> diff --git a/fs/smb/smbdirect/connect.c b/fs/smb/smbdirect/connect.c
> index cd726b399afe..34a3e72c38fb 100644
> --- a/fs/smb/smbdirect/connect.c
> +++ b/fs/smb/smbdirect/connect.c
> @@ -182,8 +182,9 @@ static int smbdirect_connect_rdma_connect(struct smbdirect_socket *sc)
>   	if (sc->ib.dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>   		sc->mr_io.type = IB_MR_TYPE_SG_GAPS;
>   
> - sp->responder_resources = min_t(u8, sp->responder_resources,
> - sc->ib.dev->attrs.max_qp_rd_atom);
> + sp->responder_resources = min3(sp->responder_resources,
> + sc->ib.dev->attrs.max_qp_rd_atom,
> + U8_MAX);
>   	smbdirect_log_rdma_mr(sc, SMBDIRECT_LOG_INFO,
>   		"responder_resources=%d\n",
>   		sp->responder_resources);
> diff --git a/fs/smb/smbdirect/connection.c b/fs/smb/smbdirect/connection.c
> index 8adf58097534..690acb84e1b5 100644
> --- a/fs/smb/smbdirect/connection.c
> +++ b/fs/smb/smbdirect/connection.c
> @@ -287,7 +287,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   	    qp_cap.max_send_wr > sc->ib.dev->attrs.max_qp_wr) {
>   		pr_err("Possible CQE overrun: max_send_wr %d\n",
>   		       qp_cap.max_send_wr);
> - pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
> + pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_cqe,
> @@ -302,7 +302,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   	     max_send_wr >= sc->ib.dev->attrs.max_qp_wr)) {
>   		pr_err("Possible CQE overrun: rdma_send_wr %d + max_send_wr %d = %d\n",
>   		       rdma_send_wr, qp_cap.max_send_wr, max_send_wr);
> - pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
> + pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_cqe,
> @@ -316,7 +316,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   	    qp_cap.max_recv_wr > sc->ib.dev->attrs.max_qp_wr) {
>   		pr_err("Possible CQE overrun: max_recv_wr %d\n",
>   		       qp_cap.max_recv_wr);
> - pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
> + pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_cqe,
> @@ -328,7 +328,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
>   
>   	if (qp_cap.max_send_sge > sc->ib.dev->attrs.max_send_sge ||
>   	    qp_cap.max_recv_sge > sc->ib.dev->attrs.max_recv_sge) {
> - pr_err("device %.*s max_send_sge/max_recv_sge = %d/%d too small\n",
> + pr_err("device %.*s max_send_sge/max_recv_sge = %u/%u too small\n",
>   		       IB_DEVICE_NAME_MAX,
>   		       sc->ib.dev->name,
>   		       sc->ib.dev->attrs.max_send_sge,

Acked-by: Stefan Metzmacher <metze@samba.org> for the smbdirect changes.

Thanks!
metze


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38C1C54E71
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xz4Zcy3wg7L8EA60dL5kL3syhAWL+nrdXMPY6Ck3yHQ=; b=edPHV0k5v0bW9EBegZ+N8yDe26
	qDHkL8B0i1QEs0SzaujxhNXD6RJ1BXSvoK79irt30pibVZYrR8ZX2PZ5/u+44TMHC0bE//z/jJkn2
	RQWbiMpY0YxYOZGbnIlVIRS4ND3HZ7uLxO24/O9wDVSUlWmFTpNrWYF2KFqt7LfiIYWmoqJRD455r
	QdWY6NY9uxCkUpnZeQ10sVOjVPHtawOY573r1RqqnclVhDGbWqYK+LSpq/p5Tj+8LFaJqqvdHYlks
	caw4ok9P8xBA9t5C1kb+A3vJI78GqCHobJvCzrJgZARkCWVAjL0gLjkY/xzg6YU0CLOzZ5eL6V9u/
	1p+v7hnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHRw3-0000000Dpi9-0fub;
	Tue, 20 May 2025 18:43:31 +0000
Received: from omta036.useast.a.cloudfilter.net ([44.202.169.35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHRvZ-0000000DpYO-46lQ
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 18:43:04 +0000
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id HN2lujLqtzZPaHRvNuTtYN; Tue, 20 May 2025 18:42:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HRvMuRk5d0jHiHRvNuxJAM; Tue, 20 May 2025 18:42:49 +0000
X-Authority-Analysis: v=2.4 cv=Jsn3rt4C c=1 sm=1 tr=0 ts=682ccd29
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=TLs6ZzWtG3X6MRFYV_cA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xz4Zcy3wg7L8EA60dL5kL3syhAWL+nrdXMPY6Ck3yHQ=; b=YIoakkFv4seIF+yMGlaRLcNGrI
	l3l0xC027wrcy0Qg+FT8igN3CCT7GJUa/qMLf8xi2TDRXKH8GSvMfMMMDt2x7Cc8U4cB9kyDWsaaU
	MizEPCYURIAfdYqGeccbzAQXl9Qv/GvybwRkQOPDSDYKUD3of3B39KwCHx0J06/WUiXs/gdfMDUiq
	X4gNH4WfLxr1xoF1fCMN7K4XglqZYZkB5pqxMWpZsViH0Ylw6E/0h8uxZFjLu9r/5qtIKvt4caWKa
	frijC9r8UNTA0WM7FLnFNDcxW1WMAtQqy3zng8yzsfSx3JaGWzxZl66xycKol6tqg2et8fEhSy1Em
	okewS4tw==;
Received: from [177.238.17.151] (port=7880 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHRvK-00000001Zig-0gAj;
	Tue, 20 May 2025 13:42:46 -0500
Message-ID: <34aa97a5-745f-4207-8869-be846a42b8ce@embeddedor.com>
Date: Tue, 20 May 2025 12:42:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: core: Convert inet_addr_is_any() to
 sockaddr_storage
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Simon Horman <horms@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Maurizio Lombardi <mlombard@redhat.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Eric Biggers <ebiggers@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250520173437.make.907-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520173437.make.907-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uHRvK-00000001Zig-0gAj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:7880
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGMXqP09Eslo7T/NV8FxCk4ZXW1YJRhh71NrPayWgk+MuDZyswTu5bxIDEdDioSzoX/luVd9QNSRnTCroq617ijkOoxEiF3SYnXEWV9f7l073hJPpVI0
 OtMQBPKqxMxGk9IsbRAKfs1yWE1WQ6WNmBIhUTU0YRi7UC1ja/DrWVZVvZLogOPTeDhv+GmpvN4GnsGLmLlEoYg5GKEy7lLFHuA9GU89qqr9OcwFcdKvA3kP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_114302_142094_F328B743 
X-CRM114-Status: GOOD (  15.33  )
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



On 20/05/25 11:34, Kees Cook wrote:
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
>   include/linux/inet.h                | 2 +-
>   drivers/nvme/target/rdma.c          | 2 +-
>   drivers/nvme/target/tcp.c           | 2 +-
>   drivers/target/iscsi/iscsi_target.c | 2 +-
>   net/core/utils.c                    | 8 ++++----
>   5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/inet.h b/include/linux/inet.h
> index bd8276e96e60..9158772f3559 100644
> --- a/include/linux/inet.h
> +++ b/include/linux/inet.h
> @@ -55,6 +55,6 @@ extern int in6_pton(const char *src, int srclen, u8 *dst, int delim, const char
>   
>   extern int inet_pton_with_scope(struct net *net, unsigned short af,
>   		const char *src, const char *port, struct sockaddr_storage *addr);
> -extern bool inet_addr_is_any(struct sockaddr *addr);
> +bool inet_addr_is_any(struct sockaddr_storage *addr);
>   
>   #endif	/* _LINUX_INET_H */
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 2a4536ef6184..79a5aad2e9d0 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1999,7 +1999,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>   	struct nvmet_rdma_port *port = nport->priv;
>   	struct rdma_cm_id *cm_id = port->cm_id;
>   
> -	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
> +	if (inet_addr_is_any(&cm_id->route.addr.src_addr)) {
>   		struct nvmet_rdma_rsp *rsp =
>   			container_of(req, struct nvmet_rdma_rsp, req);
>   		struct rdma_cm_id *req_cm_id = rsp->queue->cm_id;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 12a5cb8641ca..5cd1cf74f8ff 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2194,7 +2194,7 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
>   {
>   	struct nvmet_tcp_port *port = nport->priv;
>   
> -	if (inet_addr_is_any((struct sockaddr *)&port->addr)) {
> +	if (inet_addr_is_any(&port->addr)) {
>   		struct nvmet_tcp_cmd *cmd =
>   			container_of(req, struct nvmet_tcp_cmd, req);
>   		struct nvmet_tcp_queue *queue = cmd->queue;
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 620ba6e0ab07..a2dde08c8a62 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -3419,7 +3419,7 @@ iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
>   					}
>   				}
>   
> -				if (inet_addr_is_any((struct sockaddr *)&np->np_sockaddr))
> +				if (inet_addr_is_any(&np->np_sockaddr))
>   					sockaddr = &conn->local_sockaddr;
>   				else
>   					sockaddr = &np->np_sockaddr;
> diff --git a/net/core/utils.c b/net/core/utils.c
> index 27f4cffaae05..e47feeaa5a49 100644
> --- a/net/core/utils.c
> +++ b/net/core/utils.c
> @@ -399,9 +399,9 @@ int inet_pton_with_scope(struct net *net, __kernel_sa_family_t af,
>   }
>   EXPORT_SYMBOL(inet_pton_with_scope);
>   
> -bool inet_addr_is_any(struct sockaddr *addr)
> +bool inet_addr_is_any(struct sockaddr_storage *addr)
>   {
> -	if (addr->sa_family == AF_INET6) {
> +	if (addr->ss_family == AF_INET6) {
>   		struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)addr;
>   		const struct sockaddr_in6 in6_any =
>   			{ .sin6_addr = IN6ADDR_ANY_INIT };
> @@ -409,13 +409,13 @@ bool inet_addr_is_any(struct sockaddr *addr)
>   		if (!memcmp(in6->sin6_addr.s6_addr,
>   			    in6_any.sin6_addr.s6_addr, 16))
>   			return true;
> -	} else if (addr->sa_family == AF_INET) {
> +	} else if (addr->ss_family == AF_INET) {
>   		struct sockaddr_in *in = (struct sockaddr_in *)addr;
>   
>   		if (in->sin_addr.s_addr == htonl(INADDR_ANY))
>   			return true;
>   	} else {
> -		pr_warn("unexpected address family %u\n", addr->sa_family);
> +		pr_warn("unexpected address family %u\n", addr->ss_family);
>   	}
>   
>   	return false;



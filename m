Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCDFCE7A81
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Sep 2023 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BH6KQp0bhlj8HA3rXvIBa/OP3apN1qfWs28l283xDRg=; b=uFRA3Y+Icl09ZkWGnUW+gYw9P5
	59iPQdwOEFSe4f/qeCjsD+v+xARLdGB6IZi3KvvxF1hLRu+l5L8VSjUlJxSQAUgMwYwHYbNkah8cU
	YafIIRHNREOFptITXj1KE4dqymudIhWIlpRnMasEJEqLrfV6Lz2sGYrwV0DqRfxvQo0UX42zPxknI
	EKmcFDEwwcEmQ/ZteaONljZMULaGTheHc20p0d672ZmxOoWlCVydwRqOYLcOf5BFN9wcpsaQHLNly
	IrU37V/LnftIEdX/eS/hBCL5i4RzvzPO6T53lJa/IPGCFq+xrZW9B1o5J7g74tKV0IsRrO/oVIocO
	Ik4b/rEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjpGN-009xbj-0O;
	Fri, 22 Sep 2023 23:08:43 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjpGI-009xaq-19
	for linux-nvme@lists.infradead.org;
	Fri, 22 Sep 2023 23:08:39 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so1119833b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 22 Sep 2023 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695424116; x=1696028916; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH6KQp0bhlj8HA3rXvIBa/OP3apN1qfWs28l283xDRg=;
        b=UrXkij6//Yfrv1sEGigxDHiAWbVzgtge+ITAfmMsUjCWSUJNCqsfDijX/4KZ+MPgsq
         74uV05dO3cxkMTM3WHwDNhK48MxKk9ir8bY7UhVYVZozbIOh6b4xGQoUIQiR5Nr1ZPQZ
         BKB8vtbIy0HoahXgNuUE9WXmfXEU7BMZFb1i3EsnaEiomLi8kTNNTctxl1UUJTWuc/sK
         b4NMciIg29nL1+Qjgits8zq4dCGXUTMHJv10hH4S9116U85Aq9VyJ707AY9yCqHpbhbx
         fsnu+r/xqoSYAFY4UyLlIEGksM1BJIbLVaSqIPGO6Yzy91wA0VeWyERp/x3n0YLFLvjj
         g8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695424116; x=1696028916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BH6KQp0bhlj8HA3rXvIBa/OP3apN1qfWs28l283xDRg=;
        b=F3PNT3fF0JXY+DzfzBjN9Yn+G2IjoBavRuRABxdRaYc44hbiQe9nmos7naeiVk87dj
         pYwE1lQbc1Jj8iJr+bFRqkL9a7XjBhfBPYTFWhzvN3v+1Vu7uOnIM2EN8LCTjowObdRs
         dSI+qUykpB3GPtR5zHBc/2NoP8gR3WIwpzhE1F8fnLU1Rm4G5ZlZRN/0wWIKBvqTUEeX
         sQiTNNiO7uoZ9vlwCCMBPQpQDg01wjRyM3W3z+pWju2h/u6TbZ99XyAni8kZOWfGKkWw
         pdMxKWbbXPUrGY/HoTXMShxv+Qs2z01CqQsHOSEENCaxOHDyst+QrIW4s5qRc+CkSQAM
         C2xA==
X-Gm-Message-State: AOJu0Yy/V8LbjQCZn/KjaX59Mi4dOi2gMJxRv1kcn7J8jBGghiR0hckX
	yNo5MUksdw22CC/demwWI2g=
X-Google-Smtp-Source: AGHT+IHmYl3bCs7WXJAZ49JfpXURr+OKwVbh6i7ammq3G2Y5NVBY3MEXZ+0gDX7Vsl4hWt0OIGsFvA==
X-Received: by 2002:a05:6a00:1508:b0:690:b7a1:ac51 with SMTP id q8-20020a056a00150800b00690b7a1ac51mr851791pfu.31.1695424115970;
        Fri, 22 Sep 2023 16:08:35 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f20-20020a63f114000000b005703a63836esm3652638pgi.57.2023.09.22.16.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 16:08:35 -0700 (PDT)
Message-ID: <635234b9-6ad9-4d5f-891e-4c76fbea8d63@gmail.com>
Date: Fri, 22 Sep 2023 16:08:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvmet: View subsystem connections on nvmeof target
Content-Language: en-US
To: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>,
 linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, hch@lst.de, sagi@grimberg.me, antoine.damhet@shadow.tech,
 valentin.brice@shadow.tech
References: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
 <20230920141205.26637-2-redouane.boufenghour@shadow.tech>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230920141205.26637-2-redouane.boufenghour@shadow.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_160838_399266_D8B78BFB 
X-CRM114-Status: GOOD (  29.95  )
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

On 9/20/2023 7:12 AM, Redouane BOUFENGHOUR wrote:
> We add a new entry in the tcp and rdma factories to retrieve the peer
> address of a ctrl.
> 
> The functions nvmet_rdma_disc_peer_addr and nvmet_tcp_disc_peer_addr return
> a snprintf of size NVMF_TRADDR_SIZE with the address connected to the ctlrs
> 
> which is then displayed in a subsys attribute attr_connected_ctrls on RO

The "peertraddr" term is odd. On the host side we have "host traddr" for 
the address information for the host side of the connection to the 
controller. I'd prefer to use host traddr over the peer traddr name.

as for the patches:
- I'm not a fan of dstaddr passed between common/transport layers and 
transports "assuming" they know the length via a compile time define. 
I'd prefer being explicit and having the dstaddr buffer length passed 
around as well.

- Are there cases where the address field is more than a single traddr 
value ?  For example, do you need to know host IP address and port # ? 
You can leave it up to the transport to fill in whatever data 
constitutes an "address" which if the max length of the destbuffer is 
known, makes that easier.

-- james



> 
> Co-developed-by: Valentin BRICE <valentin.brice@shadow.tech>
> Signed-off-by: Valentin BRICE <valentin.brice@shadow.tech>
> Co-developed-by: Antoine DAMHET <antoine.damhet@shadow.tech>
> Signed-off-by: Antoine DAMHET <antoine.damhet@shadow.tech>
> Co-developed-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
> Signed-off-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
> ---
>   drivers/nvme/target/configfs.c | 30 ++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c     |  7 +++++++
>   drivers/nvme/target/nvmet.h    |  2 ++
>   drivers/nvme/target/rdma.c     | 10 ++++++++++
>   drivers/nvme/target/tcp.c      | 13 +++++++++++++
>   5 files changed, 62 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 907143870da5..6cbbe71244dd 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1426,6 +1426,35 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
>   
> +static ssize_t nvmet_subsys_attr_connected_ctrls_show(
> +	struct config_item *item, char *page)
> +{
> +	ssize_t len, ret;
> +	int peer;
> +	char dstaddr[NVMF_TRADDR_SIZE];
> +	struct nvmet_subsys *subsys;
> +	struct nvmet_ctrl *ctrl;
> +
> +	subsys = to_subsys(item);
> +	len = 0;
> +
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		peer = get_peer_traddr(ctrl, ctrl->sqs[0], dstaddr);
> +		if (peer < 0)
> +			snprintf(dstaddr, NVMF_TRADDR_SIZE, "unknown");
> +		ret = snprintf(page + len, PAGE_SIZE - len,
> +			       "hostnqn: %s; peer_addr: %s\n",
> +			       ctrl->hostnqn, dstaddr);
> +		if (ret >= PAGE_SIZE - len) {
> +			sprintf(page + PAGE_SIZE - 14, "\n[truncated]");
> +			return PAGE_SIZE;
> +		}
> +		len += ret;
> +	}
> +	return len;
> +}
> +CONFIGFS_ATTR_RO(nvmet_subsys_, attr_connected_ctrls);
> +
>   static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_allow_any_host,
>   	&nvmet_subsys_attr_attr_version,
> @@ -1436,6 +1465,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_qid_max,
>   	&nvmet_subsys_attr_attr_ieee_oui,
>   	&nvmet_subsys_attr_attr_firmware,
> +	&nvmet_subsys_attr_attr_connected_ctrls,
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_subsys_attr_attr_pi_enable,
>   #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3935165048e7..ba5997a14675 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1629,6 +1629,13 @@ static void nvmet_subsys_free(struct kref *ref)
>   	kfree(subsys);
>   }
>   
> +int get_peer_traddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, char *dstaddr)
> +{
> +	if (ctrl->ops->disc_peertraddr == NULL)
> +		return -EOPNOTSUPP;
> +	return ctrl->ops->disc_peertraddr(sq, ctrl->port, dstaddr);
> +}
> +
>   void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
>   {
>   	struct nvmet_ctrl *ctrl;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 8cfd60f3b564..60ea2391a957 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -341,6 +341,8 @@ struct nvmet_fabrics_ops {
>   	void (*discovery_chg)(struct nvmet_port *port);
>   	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
>   	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
> +	int (*disc_peertraddr)(struct nvmet_sq *nvme_sq,
> +			       struct nvmet_port *port, char *dstaddr);
>   };
>   
>   #define NVMET_MAX_INLINE_BIOVEC	8
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 4597bca43a6d..395554a77fc1 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1992,6 +1992,15 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>   		memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
>   	}
>   }
> +int nvmet_rdma_disc_peer_addr(struct nvmet_sq *nvme_sq,
> +			      struct nvmet_port *nport, char *dstaddr)
> +{
> +	struct nvmet_rdma_queue *queue =
> +		container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
> +
> +	snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
> +		 (struct sockaddr *)&queue->cm_id->route.addr.dst_addr);
> +}
>   
>   static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
>   {
> @@ -2015,6 +2024,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
>   	.queue_response		= nvmet_rdma_queue_response,
>   	.delete_ctrl		= nvmet_rdma_delete_ctrl,
>   	.disc_traddr		= nvmet_rdma_disc_port_addr,
> +	.disc_peertraddr        = nvmet_rdma_disc_peer_addr,
>   	.get_mdts		= nvmet_rdma_get_mdts,
>   	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
>   };
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 868aa4de2e4c..ae454c176fac 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1871,6 +1871,18 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
>   	}
>   }
>   
> +int nvmet_tcp_disc_peer_addr(struct nvmet_sq *sq,
> +			     struct nvmet_port *nport, char *dstaddr)
> +{
> +	struct nvmet_tcp_queue *queue =
> +		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
> +
> +	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
> +		return -EINVAL;
> +	return snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
> +			 (struct sockaddr *)&queue->sockaddr_peer);
> +}
> +
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_TCP,
> @@ -1881,6 +1893,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.delete_ctrl		= nvmet_tcp_delete_ctrl,
>   	.install_queue		= nvmet_tcp_install_queue,
>   	.disc_traddr		= nvmet_tcp_disc_port_addr,
> +	.disc_peertraddr        = nvmet_tcp_disc_peer_addr,
>   };
>   
>   static int __init nvmet_tcp_init(void)



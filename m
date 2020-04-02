Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF0FC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 17:06:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72D6206F6
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TvKvJ9DP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zadara-com.20150623.gappssmtp.com header.i=@zadara-com.20150623.gappssmtp.com header.b="hWM22CHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72D6206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zadara.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w+b5jJn4R+u8AThz0rnVfH4yh5JmEBVY2Ab4tSBQviI=; b=TvKvJ9DPBtyfEL
	BpDJCq38NRS5lLb+Yy7xNHODlde1q5kfRVDQ4Pca7+SGHo4PV2Y/arRAzBkttC9Ua9xHblVsDNMkI
	A9faDQGfZTv/Cpaxdus/JULY/ycGpm/ItNqck8+D6byyRvQI/nxBfrd6BfhORAs+i6ySAFIc8umd6
	u267bUegxwwpcyoOSvUzeZ+F9xCKeWIj/Zi9iOo8iME8wPFONdXdIzRpLDx4RzuQnCXaH+/uZ7wrc
	TVb8tEgGDpxcWkYtHaF7ZD02NBJOW1mRa9jPQX8DYYc9+D0jWygkD/agkzjCDspnD6pUqd+V67MN/
	m+A2PUGAPK9KKvbdlJsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK3IL-000824-RO; Thu, 02 Apr 2020 17:06:21 +0000
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK3II-0007zr-Ji
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 17:06:20 +0000
Received: by mail-il1-x143.google.com with SMTP id a6so4353450ilr.4
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zadara-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WxLkYHlzSt3HFVpn/h1R1qYI1uglk2DapDqJYstFnhA=;
 b=hWM22CHMmcO/vMJIlKSJJqfgMiTGw91LArP5HZJPZIVAJxt9Loqabh3UsEoy4tXdjS
 yv6BjEaWfiy4fpMerufcmlKlmRlEsl6y69z1reK8UE17Y7hLruA9Q5FRZhDireYJlxmd
 P/XuD2LMOOQHG2C8oizi2K2cAvQ8q2XkhajpWbPH8lBZ+onHSgEEK9+5ZKTWtQr4Dm6A
 vHoQZ0/EsUid6/X+0wylhTDOeNBiaB/EBDG/0bfsAIE2dXlasMGjbjEwzB/iyrWS3f5r
 zYRQoJfRGFQU1YIL+vD0evtIM8QVGDdFV9pQ/3WYoq76MBNR/eytxjAq40MYPM5FOPhh
 hjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WxLkYHlzSt3HFVpn/h1R1qYI1uglk2DapDqJYstFnhA=;
 b=P0aZhfLG5urPzu1kURXF5vJBAwD+6v1xGT0+lj/5kvdzx6qdXzBycDyT+JWLNy10KO
 564+INyB6HZUwWpHweGMwcpk4+mLQk7smlEovRjLq25WeyXbn6PhFeJzhVV+I4zFiYTx
 78lt1p4Ef5NRfOxejeNJhj3tcUM4PyzPy8PlRvxdWPQB4nNietDMT33c2/Cq1Xg1aB9G
 KMJZ7/snAKqV7LhnhwmRycfAm2BpM+b3+X7uyzk1NS+DfyapFTeeIWEj2iPlEkkYdpKm
 pfuBLl1t3g+Oqq2XoiLb5+B2UgOo+R3DiTHlJG2/vivQJjrnc9SsFjnLXId7zxdh+WZf
 6Cgg==
X-Gm-Message-State: AGi0PuYyak4cbkvaJ/asyCGUyMmDP3MdQylgIpJRw2m2f+HZCMdZxDvn
 Aej1VcA+4llZ1WKcJO+rblsN/3uyCBtFlZySFgef3w==
X-Google-Smtp-Source: APiQypLLJN9hMdDtmcz4S/bpb0jYNv7OiE0B3eMHW27UgG12ZVaEay81QCd7qZOmSG1xfVip293JdFaAzFr6P2ZTbJk=
X-Received: by 2002:a92:d2c2:: with SMTP id w2mr4574311ilg.167.1585847177285; 
 Thu, 02 Apr 2020 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200402154853.14108-1-sagi@grimberg.me>
In-Reply-To: <20200402154853.14108-1-sagi@grimberg.me>
From: Alex Lyakas <alex@zadara.com>
Date: Thu, 2 Apr 2020 20:06:04 +0300
Message-ID: <CAOcd+r20vq+9y1A5Xxir=s4SV-0wOzGTqbUekKUDLT=Fi3Vu3Q@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-rdma: fix bonding failover possible NULL deref
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_100618_652394_883CDD6F 
X-CRM114-Status: GOOD (  24.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 2, 2020 at 6:48 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> RDMA_CM_EVENT_ADDR_CHANGE event occur in the case of bonding failover
> on normal as well as on listening cm_ids. Hence this event will
> immediately trigger a NULL dereference trying to disconnect a queue
> for a cm_id that actually belongs to the port.
>
> To fix this we provide a different handler for the listener cm_ids
> that will defer a work to disable+(re)enable the port which essentially
> destroys and setups another listener cm_id
>
> Reported-by: Alex Lyakas <alex@zadara.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - Fix nvmet_rdma_find_get_device wrong cm_id->context dereference
>
>  drivers/nvme/target/rdma.c | 175 +++++++++++++++++++++++++------------
>  1 file changed, 119 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 9e1b8c61f54e..fd71cfe5c5d6 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -105,6 +105,13 @@ struct nvmet_rdma_queue {
>         struct list_head        queue_list;
>  };
>
> +struct nvmet_rdma_port {
> +       struct nvmet_port       *nport;
> +       struct sockaddr_storage addr;
> +       struct rdma_cm_id       *cm_id;
> +       struct delayed_work     repair_work;
> +};
> +
>  struct nvmet_rdma_device {
>         struct ib_device        *device;
>         struct ib_pd            *pd;
> @@ -917,7 +924,8 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>  static struct nvmet_rdma_device *
>  nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>  {
> -       struct nvmet_port *port = cm_id->context;
> +       struct nvmet_rdma_port *port = cm_id->context;
> +       struct nvmet_port *nport = port->nport;
>         struct nvmet_rdma_device *ndev;
>         int inline_page_count;
>         int inline_sge_count;
> @@ -934,17 +942,17 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>         if (!ndev)
>                 goto out_err;
>
> -       inline_page_count = num_pages(port->inline_data_size);
> +       inline_page_count = num_pages(nport->inline_data_size);
>         inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
>                                 cm_id->device->attrs.max_recv_sge) - 1;
>         if (inline_page_count > inline_sge_count) {
>                 pr_warn("inline_data_size %d cannot be supported by device %s. Reducing to %lu.\n",
> -                       port->inline_data_size, cm_id->device->name,
> +                       nport->inline_data_size, cm_id->device->name,
>                         inline_sge_count * PAGE_SIZE);
> -               port->inline_data_size = inline_sge_count * PAGE_SIZE;
> +               nport->inline_data_size = inline_sge_count * PAGE_SIZE;
>                 inline_page_count = inline_sge_count;
>         }
> -       ndev->inline_data_size = port->inline_data_size;
> +       ndev->inline_data_size = nport->inline_data_size;
>         ndev->inline_page_count = inline_page_count;
>         ndev->device = cm_id->device;
>         kref_init(&ndev->ref);
> @@ -1272,6 +1280,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
>  static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>                 struct rdma_cm_event *event)
>  {
> +       struct nvmet_rdma_port *port = cm_id->context;
>         struct nvmet_rdma_device *ndev;
>         struct nvmet_rdma_queue *queue;
>         int ret = -EINVAL;
> @@ -1287,7 +1296,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>                 ret = -ENOMEM;
>                 goto put_device;
>         }
> -       queue->port = cm_id->context;
> +       queue->port = port->nport;
>
>         if (queue->host_qid == 0) {
>                 /* Let inflight controller teardown complete */
> @@ -1412,7 +1421,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
>  static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
>                 struct nvmet_rdma_queue *queue)
>  {
> -       struct nvmet_port *port;
> +       struct nvmet_rdma_port *port;
>
>         if (queue) {
>                 /*
> @@ -1431,7 +1440,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
>          * cm_id destroy. use atomic xchg to make sure
>          * we don't compete with remove_port.
>          */
> -       if (xchg(&port->priv, NULL) != cm_id)
> +       if (xchg(&port->cm_id, NULL) != cm_id)
>                 return 0;
>
>         /*
> @@ -1462,6 +1471,13 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
>                 nvmet_rdma_queue_established(queue);
>                 break;
>         case RDMA_CM_EVENT_ADDR_CHANGE:
> +               if (!queue) {
> +                       struct nvmet_rdma_port *port = cm_id->context;
> +
> +                       schedule_delayed_work(&port->repair_work, 0);
> +                       break;
> +               }
> +               /* FALLTHROUGH */
>         case RDMA_CM_EVENT_DISCONNECTED:
>         case RDMA_CM_EVENT_TIMEWAIT_EXIT:
>                 nvmet_rdma_queue_disconnect(queue);
> @@ -1504,42 +1520,19 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
>         mutex_unlock(&nvmet_rdma_queue_mutex);
>  }
>
> -static int nvmet_rdma_add_port(struct nvmet_port *port)
> +static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
>  {
> -       struct rdma_cm_id *cm_id;
> -       struct sockaddr_storage addr = { };
> -       __kernel_sa_family_t af;
> -       int ret;
> +       struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
>
> -       switch (port->disc_addr.adrfam) {
> -       case NVMF_ADDR_FAMILY_IP4:
> -               af = AF_INET;
> -               break;
> -       case NVMF_ADDR_FAMILY_IP6:
> -               af = AF_INET6;
> -               break;
> -       default:
> -               pr_err("address family %d not supported\n",
> -                               port->disc_addr.adrfam);
> -               return -EINVAL;
> -       }
> -
> -       if (port->inline_data_size < 0) {
> -               port->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
> -       } else if (port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
> -               pr_warn("inline_data_size %u is too large, reducing to %u\n",
> -                       port->inline_data_size,
> -                       NVMET_RDMA_MAX_INLINE_DATA_SIZE);
> -               port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
> -       }
> +       if (cm_id)
> +               rdma_destroy_id(cm_id);
> +}
>
> -       ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
> -                       port->disc_addr.trsvcid, &addr);
> -       if (ret) {
> -               pr_err("malformed ip/port passed: %s:%s\n",
> -                       port->disc_addr.traddr, port->disc_addr.trsvcid);
> -               return ret;
> -       }
> +static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
> +{
> +       struct sockaddr *addr = (struct sockaddr *)&port->addr;
> +       struct rdma_cm_id *cm_id;
> +       int ret;
>
>         cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
>                         RDMA_PS_TCP, IB_QPT_RC);
> @@ -1558,23 +1551,19 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
>                 goto out_destroy_id;
>         }
>
> -       ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
> +       ret = rdma_bind_addr(cm_id, addr);
>         if (ret) {
> -               pr_err("binding CM ID to %pISpcs failed (%d)\n",
> -                       (struct sockaddr *)&addr, ret);
> +               pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
>                 goto out_destroy_id;
>         }
>
>         ret = rdma_listen(cm_id, 128);
>         if (ret) {
> -               pr_err("listening to %pISpcs failed (%d)\n",
> -                       (struct sockaddr *)&addr, ret);
> +               pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
>                 goto out_destroy_id;
>         }
>
> -       pr_info("enabling port %d (%pISpcs)\n",
> -               le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
> -       port->priv = cm_id;
> +       port->cm_id = cm_id;
>         return 0;
>
>  out_destroy_id:
> @@ -1582,18 +1571,92 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
>         return ret;
>  }
>
> -static void nvmet_rdma_remove_port(struct nvmet_port *port)
> +static void nvmet_rdma_repair_port_work(struct work_struct *w)
>  {
> -       struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
> +       struct nvmet_rdma_port *port = container_of(to_delayed_work(w),
> +                       struct nvmet_rdma_port, repair_work);
> +       int ret;
>
> -       if (cm_id)
> -               rdma_destroy_id(cm_id);
> +       nvmet_rdma_disable_port(port);
> +       ret = nvmet_rdma_enable_port(port);
> +       if (ret)
> +               schedule_delayed_work(&port->repair_work, 5 * HZ);
> +}
> +
> +static int nvmet_rdma_add_port(struct nvmet_port *nport)
> +{
> +       struct nvmet_rdma_port *port;
> +       __kernel_sa_family_t af;
> +       int ret;
> +
> +       port = kzalloc(sizeof(*port), GFP_KERNEL);
> +       if (!port)
> +               return -ENOMEM;
> +
> +       nport->priv = port;
> +       port->nport = nport;
> +       INIT_DELAYED_WORK(&port->repair_work, nvmet_rdma_repair_port_work);
> +
> +       switch (nport->disc_addr.adrfam) {
> +       case NVMF_ADDR_FAMILY_IP4:
> +               af = AF_INET;
> +               break;
> +       case NVMF_ADDR_FAMILY_IP6:
> +               af = AF_INET6;
> +               break;
> +       default:
> +               pr_err("address family %d not supported\n",
> +                               nport->disc_addr.adrfam);
> +               ret = -EINVAL;
> +               goto out_free_port;
> +       }
> +
> +       if (nport->inline_data_size < 0) {
> +               nport->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
> +       } else if (nport->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
> +               pr_warn("inline_data_size %u is too large, reducing to %u\n",
> +                       nport->inline_data_size,
> +                       NVMET_RDMA_MAX_INLINE_DATA_SIZE);
> +               nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
> +       }
> +
> +       ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
> +                       nport->disc_addr.trsvcid, &port->addr);
> +       if (ret) {
> +               pr_err("malformed ip/port passed: %s:%s\n",
> +                       nport->disc_addr.traddr, nport->disc_addr.trsvcid);
> +               goto out_free_port;
> +       }
> +
> +       ret = nvmet_rdma_enable_port(port);
> +       if(ret)
> +               goto out_free_port;
> +
> +       pr_info("enabling port %d (%pISpcs)\n",
> +               le16_to_cpu(nport->disc_addr.portid),
> +               (struct sockaddr *)&port->addr);
> +
> +       return 0;
> +
> +out_free_port:
> +       kfree(port);
> +       return ret;
> +}
> +
> +static void nvmet_rdma_remove_port(struct nvmet_port *nport)
> +{
> +       struct nvmet_rdma_port *port = nport->priv;
> +
> +       cancel_delayed_work_sync(&port->repair_work);
> +       nvmet_rdma_disable_port(port);
> +       kfree(port);
>  }
>
>  static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
> -               struct nvmet_port *port, char *traddr)
> +               struct nvmet_port *nport, char *traddr)
>  {
> -       struct rdma_cm_id *cm_id = port->priv;
> +       struct nvmet_rdma_port *port = nport->priv;
> +       struct rdma_cm_id *cm_id = port->cm_id;
>
>         if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
>                 struct nvmet_rdma_rsp *rsp =
> @@ -1603,7 +1666,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>
>                 sprintf(traddr, "%pISc", addr);
>         } else {
> -               memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
> +               memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
>         }
>  }
>
> --
> 2.20.1
>
This patch is identical to what I tested.

Tested-by: Alex Lyakas <alex@zadara.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

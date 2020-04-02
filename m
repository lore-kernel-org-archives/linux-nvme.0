Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D3C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 09:13:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4003320719
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 09:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eId+aGwj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zadara-com.20150623.gappssmtp.com header.i=@zadara-com.20150623.gappssmtp.com header.b="rK2sIIQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4003320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zadara.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AjSy4rygO6XN5Qrl/2LMmHTPPRZ+sNtzFkKfOrDsYuI=; b=eId+aGwjx12N1kx2wrAbWE3CK
	aWjvipMyLlZvSB0WpaPGIb6qDpxw0MjZss7prieossJauYyim4bV+WF31JtI5IMvSADOAaawIXaZh
	wMYQ614+I0aJ40DRsG/znS5qRTQqtwzA6bX5tspMtqI5hZ/kaZd1IZOfa1cfJDkSEnGOkGS9ii/z4
	d165dZ/p680OV7OrWInkkm0OQPtFOvm8qMSq0AG2iiGY80Gx+jp9urEmO4lCBM5Esg0t+sHFtxMEb
	Ya+/ww5yqx2nQqDq9+DmfZxBbU5YJunLRueJSGSFvwuqz9E3EwIfhnNp5iCOATDdCNsvJqBPVZqt9
	68/sz3BuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJvuj-0005m7-85; Thu, 02 Apr 2020 09:13:29 +0000
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJvug-0005ld-AY
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 09:13:28 +0000
Received: by mail-il1-x143.google.com with SMTP id x16so2847924ilp.12
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zadara-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XlngLn0BfqDkAY280egTjip47daQjhCT/ykB1Z3hdu8=;
 b=rK2sIIQ6CqHc2P5ZruHrS6rP4UBkRbTqvUqgZER3JATyuaOJFi+Zu/DdF11DNLbVe/
 jZhnzWxoySver8dCxgRAZ5klJfcOZEnumBdkWAoSDBINq9llyLhDdD5wNGFIFJlVOVnp
 5YGW06TvCZy2v769CFT5V4KYciPPom0dH13IgvNtJJbb+Jgd1IAkUTYj+oSZVXh3Sgr9
 1dHEOH5QgeFViCUluhcmHU/sRF8ZMsjcnJsY83KJSxp0lfovpNZAdq9DC+DErO+QAWP/
 d6vGi22DAxkd3A2MycqDHrvIjxHzvJnxwhzbeijvvh5Jy4yoiFaeczbq5i+QWHWrtznt
 l0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XlngLn0BfqDkAY280egTjip47daQjhCT/ykB1Z3hdu8=;
 b=MUvalzQP/snOmjMQ8WKPsq0eo85Qfvf+XJ75QQ1EflNfB7CjP1p2nr45drWgB6/81+
 ySj2XG5/jF5ceAegUYsoN4MrDfqB1iKppybzrfe0QuyE0GWc+D7c9mXEcEA/zfpguHBY
 EahpDQOncdL77TWvB/7JFbQtDi9PDldaD2Vk5QaNY/+Gy9HyT0+4r80nB6xcleP65Nyu
 pMfOM1sp9TkVAnfKuqZRH9/AFLQtUnuVErqPosvoMkP9I3wF9/EinkdESHaZhDPNSFLP
 YJ13lQ4fIkbu/mvE77+41M+jvxiUJUuW/yLW2BaGFhG/qpiQsn+8CVvNbOkFhy0Bo7Cd
 VFaw==
X-Gm-Message-State: AGi0PuY5N/cud3rJy7s0m2esxCr1PtXbf95T1KjXgxwWVTSR3XoIQ4KG
 BWc+ZAvAHFrygzz6fjWuu12lH3S4S0Ijuy53dSK3vg==
X-Google-Smtp-Source: APiQypL6M+/dfpg2zoqfTgi22p/wBHxhCUKwLHEamB2Wfa1ehscLdUb/CSZKokqutbVutH8pXDpVA04N28Yr6CAWM0c=
X-Received: by 2002:a92:d2c2:: with SMTP id w2mr2387473ilg.167.1585818804457; 
 Thu, 02 Apr 2020 02:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
 <66ACE500178B47D6B39F23FE98D22363@alyakaslap>
 <b6443a7c-4be6-3dbc-0535-a8ded3261c50@mellanox.com>
 <8ab1fa5e-2d67-5128-93b5-2f32704869e4@grimberg.me>
 <28046c97-c271-dff4-5252-4b5668c7bfb7@grimberg.me>
 <B3E9005C4E4645628157970AE2A385C4@alyakaslap>
 <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
 <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>
 <5fee46b0-0516-766a-5b1a-7114a164c9ae@grimberg.me>
 <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
 <5f439f61-338f-4f37-2b13-d3b743c32409@grimberg.me>
In-Reply-To: <5f439f61-338f-4f37-2b13-d3b743c32409@grimberg.me>
From: Alex Lyakas <alex@zadara.com>
Date: Thu, 2 Apr 2020 12:13:12 +0300
Message-ID: <CAOcd+r2JSYfL66a6yLO6KDTFHo3XcNW=4mZnqAw_Wz-wQ1=ULQ@mail.gmail.com>
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
To: Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="00000000000085c76205a24b36ee"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_021326_431644_3706752D 
X-CRM114-Status: GOOD (  29.36  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, tomwu@mellanox.com,
 Israel Rukshin <israelr@mellanox.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, Max Gurtovoy <maxg@mellanox.com>
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--00000000000085c76205a24b36ee
Content-Type: text/plain; charset="UTF-8"

Hi Sagi,

On Tue, Mar 31, 2020 at 3:21 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Hey Alex,
>
> >>> Alex, Max? did you retest this?
> >>
> >> Raising this from the ashes...
> >>
> >> Alex, did you test this patch?
> >
> > Raising from the ashes!
> >
> > In short: this patch fixes the issue!
>
> Thanks for following up..
>
> >
> > More details:
> >
> > This patch doesn't apply on kernel 5.2. Moreover, I believe this patch
> > is incomplete, because nvmet_rdma_find_get_device() needs to be fixed
> > to treat cm_id->context as "struct nvmet_rdma_port" and not as "struct
> > nvmet_port".
>
> Does patch [1] apply on kernel 5.2?
>
> > However, since we are working with kernel modules from Mellanox OFED,
> > I tried applying this patch on OFED 4.7. I discovered that it already
> > has almost everything this patch introduces. Like "struct
> > nvmet_rdma_port" and the refactoring of nvmet_rdma_add_port into
> > nvmet_rdma_enable_port, and nvmet_rdma_remove_port to
> > nvmet_rdma_disable_port. I ended up with this patch [1].
> >
> > Tested bond failover, and cm_id is destroyed and re-created as expected [2]
> >
> > Israel, Max and other Mellanox folks: can we have this fix in OFED 4.9?
> >
>
> For MOFED issues you can follow-up with Max and Israel offline. If you
> can test upstream or even 5.2 stable that would be beneficial as I can
> add your Tested-by tag.
>
This patch did not apply to latest 5.2 (5.2.21). All of 10 hunks
failed. I applied it manually, and also handled cm_id->context in
nvmet_rdma_find_get_device as I mentioned earlier. I am attaching the
patch that I tested on kernel 5.2.21 (target side). I confirm that
this patch fixes the bond failover issue.

Tested-by: Alex Lyakas <alex@zadara.com>

Max, will this help to deliver this fix upstream, so that we can get
it in MOFED 4.9?

Thanks,
Alex.



> Thanks.
>
> [1]:
> --
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Wed Jul 3 15:33:01 2019 -0700
>
>      nvmet-rdma: fix bonding failover possible NULL deref
>
>      RDMA_CM_EVENT_ADDR_CHANGE event occur in the case of bonding failover
>      on normal as well as on listening cm_ids. Hence this event will
>      immediately trigger a NULL dereference trying to disconnect a queue
>      for a cm_id that actually belongs to the port.
>
>      To fix this we provide a different handler for the listener cm_ids
>      that will defer a work to disable+(re)enable the port which essentially
>      destroys and setups another listener cm_id
>
>      Reported-by: Alex Lyakas <alex@zadara.com>
>      Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 9e1b8c61f54e..8dac89b7aa12 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -105,6 +105,13 @@ struct nvmet_rdma_queue {
>          struct list_head        queue_list;
>   };
>
> +struct nvmet_rdma_port {
> +       struct nvmet_port       *nport;
> +       struct sockaddr_storage addr;
> +       struct rdma_cm_id       *cm_id;
> +       struct delayed_work     repair_work;
> +};
> +
>   struct nvmet_rdma_device {
>          struct ib_device        *device;
>          struct ib_pd            *pd;
> @@ -1272,6 +1279,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id
> *cm_id,
>   static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>                  struct rdma_cm_event *event)
>   {
> +       struct nvmet_rdma_port *port = cm_id->context;
>          struct nvmet_rdma_device *ndev;
>          struct nvmet_rdma_queue *queue;
>          int ret = -EINVAL;
> @@ -1287,7 +1295,7 @@ static int nvmet_rdma_queue_connect(struct
> rdma_cm_id *cm_id,
>                  ret = -ENOMEM;
>                  goto put_device;
>          }
> -       queue->port = cm_id->context;
> +       queue->port = port->nport;
>
>          if (queue->host_qid == 0) {
>                  /* Let inflight controller teardown complete */
> @@ -1412,7 +1420,7 @@ static void nvmet_rdma_queue_connect_fail(struct
> rdma_cm_id *cm_id,
>   static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
>                  struct nvmet_rdma_queue *queue)
>   {
> -       struct nvmet_port *port;
> +       struct nvmet_rdma_port *port;
>
>          if (queue) {
>                  /*
> @@ -1431,7 +1439,7 @@ static int nvmet_rdma_device_removal(struct
> rdma_cm_id *cm_id,
>           * cm_id destroy. use atomic xchg to make sure
>           * we don't compete with remove_port.
>           */
> -       if (xchg(&port->priv, NULL) != cm_id)
> +       if (xchg(&port->cm_id, NULL) != cm_id)
>                  return 0;
>
>          /*
> @@ -1462,6 +1470,13 @@ static int nvmet_rdma_cm_handler(struct
> rdma_cm_id *cm_id,
>                  nvmet_rdma_queue_established(queue);
>                  break;
>          case RDMA_CM_EVENT_ADDR_CHANGE:
> +               if (!queue) {
> +                       struct nvmet_rdma_port *port = cm_id->context;
> +
> +                       schedule_delayed_work(&port->repair_work, 0);
> +                       break;
> +               }
> +               /* FALLTHROUGH */
>          case RDMA_CM_EVENT_DISCONNECTED:
>          case RDMA_CM_EVENT_TIMEWAIT_EXIT:
>                  nvmet_rdma_queue_disconnect(queue);
> @@ -1504,42 +1519,19 @@ static void nvmet_rdma_delete_ctrl(struct
> nvmet_ctrl *ctrl)
>          mutex_unlock(&nvmet_rdma_queue_mutex);
>   }
>
> -static int nvmet_rdma_add_port(struct nvmet_port *port)
> +static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
>   {
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
> -               port->inline_data_size =
> NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
> -       } else if (port->inline_data_size >
> NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
> -               pr_warn("inline_data_size %u is too large, reducing to
> %u\n",
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
>          cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
>                          RDMA_PS_TCP, IB_QPT_RC);
> @@ -1558,23 +1550,19 @@ static int nvmet_rdma_add_port(struct nvmet_port
> *port)
>                  goto out_destroy_id;
>          }
>
> -       ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
> +       ret = rdma_bind_addr(cm_id, addr);
>          if (ret) {
> -               pr_err("binding CM ID to %pISpcs failed (%d)\n",
> -                       (struct sockaddr *)&addr, ret);
> +               pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
>                  goto out_destroy_id;
>          }
>
>          ret = rdma_listen(cm_id, 128);
>          if (ret) {
> -               pr_err("listening to %pISpcs failed (%d)\n",
> -                       (struct sockaddr *)&addr, ret);
> +               pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
>                  goto out_destroy_id;
>          }
>
> -       pr_info("enabling port %d (%pISpcs)\n",
> -               le16_to_cpu(port->disc_addr.portid), (struct sockaddr
> *)&addr);
> -       port->priv = cm_id;
> +       port->cm_id = cm_id;
>          return 0;
>
>   out_destroy_id:
> @@ -1582,18 +1570,92 @@ static int nvmet_rdma_add_port(struct nvmet_port
> *port)
>          return ret;
>   }
>
> -static void nvmet_rdma_remove_port(struct nvmet_port *port)
> +static void nvmet_rdma_repair_port_work(struct work_struct *w)
>   {
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
> +               nport->inline_data_size =
> NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
> +       } else if (nport->inline_data_size >
> NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
> +               pr_warn("inline_data_size %u is too large, reducing to
> %u\n",
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
>   }
>
>   static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
> -               struct nvmet_port *port, char *traddr)
> +               struct nvmet_port *nport, char *traddr)
>   {
> -       struct rdma_cm_id *cm_id = port->priv;
> +       struct nvmet_rdma_port *port = nport->priv;
> +       struct rdma_cm_id *cm_id = port->cm_id;
>
>          if (inet_addr_is_any((struct sockaddr
> *)&cm_id->route.addr.src_addr)) {
>                  struct nvmet_rdma_rsp *rsp =
> @@ -1603,7 +1665,7 @@ static void nvmet_rdma_disc_port_addr(struct
> nvmet_req *req,
>
>                  sprintf(traddr, "%pISc", addr);
>          } else {
> -               memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
> +               memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
>          }
>   }
> --

--00000000000085c76205a24b36ee
Content-Type: application/octet-stream; 
	name="0001-nvmet-rdma-fix-bonding-failover-possible-NULL-deref.5.2.patch"
Content-Disposition: attachment; 
	filename="0001-nvmet-rdma-fix-bonding-failover-possible-NULL-deref.5.2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8ijhku20>
X-Attachment-Id: f_k8ijhku20

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jIGIvZHJpdmVycy9udm1lL3Rh
cmdldC9yZG1hLmMKaW5kZXggMzZkOTA2YS4uZWJlN2M0MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
dm1lL3RhcmdldC9yZG1hLmMKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMKQEAgLTEw
Miw2ICsxMDIsMTMgQEAgc3RydWN0IG52bWV0X3JkbWFfcXVldWUgewogCXN0cnVjdCBsaXN0X2hl
YWQJcXVldWVfbGlzdDsKIH07CiAKK3N0cnVjdCBudm1ldF9yZG1hX3BvcnQgeworCXN0cnVjdCBu
dm1ldF9wb3J0ICAgICAgICpucG9ydDsKKwlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBhZGRyOwor
CXN0cnVjdCByZG1hX2NtX2lkICAgICAgICpjbV9pZDsKKwlzdHJ1Y3QgZGVsYXllZF93b3JrICAg
ICByZXBhaXJfd29yazsKK307CisKIHN0cnVjdCBudm1ldF9yZG1hX2RldmljZSB7CiAJc3RydWN0
IGliX2RldmljZQkqZGV2aWNlOwogCXN0cnVjdCBpYl9wZAkJKnBkOwpAQCAtOTE0LDcgKzkyMSw4
IEBAIHN0YXRpYyB2b2lkIG52bWV0X3JkbWFfZnJlZV9kZXYoc3RydWN0IGtyZWYgKnJlZikKIHN0
YXRpYyBzdHJ1Y3QgbnZtZXRfcmRtYV9kZXZpY2UgKgogbnZtZXRfcmRtYV9maW5kX2dldF9kZXZp
Y2Uoc3RydWN0IHJkbWFfY21faWQgKmNtX2lkKQogewotCXN0cnVjdCBudm1ldF9wb3J0ICpwb3J0
ID0gY21faWQtPmNvbnRleHQ7CisJc3RydWN0IG52bWV0X3JkbWFfcG9ydCAqcG9ydCA9IGNtX2lk
LT5jb250ZXh0OworCXN0cnVjdCBudm1ldF9wb3J0ICpucG9ydCA9IHBvcnQtPm5wb3J0OwogCXN0
cnVjdCBudm1ldF9yZG1hX2RldmljZSAqbmRldjsKIAlpbnQgaW5saW5lX3BhZ2VfY291bnQ7CiAJ
aW50IGlubGluZV9zZ2VfY291bnQ7CkBAIC05MzEsMTcgKzkzOSwxNyBAQCBzdGF0aWMgdm9pZCBu
dm1ldF9yZG1hX2ZyZWVfZGV2KHN0cnVjdCBrcmVmICpyZWYpCiAJaWYgKCFuZGV2KQogCQlnb3Rv
IG91dF9lcnI7CiAKLQlpbmxpbmVfcGFnZV9jb3VudCA9IG51bV9wYWdlcyhwb3J0LT5pbmxpbmVf
ZGF0YV9zaXplKTsKKwlpbmxpbmVfcGFnZV9jb3VudCA9IG51bV9wYWdlcyhucG9ydC0+aW5saW5l
X2RhdGFfc2l6ZSk7CiAJaW5saW5lX3NnZV9jb3VudCA9IG1heChjbV9pZC0+ZGV2aWNlLT5hdHRy
cy5tYXhfc2dlX3JkLAogCQkJCWNtX2lkLT5kZXZpY2UtPmF0dHJzLm1heF9yZWN2X3NnZSkgLSAx
OwogCWlmIChpbmxpbmVfcGFnZV9jb3VudCA+IGlubGluZV9zZ2VfY291bnQpIHsKIAkJcHJfd2Fy
bigiaW5saW5lX2RhdGFfc2l6ZSAlZCBjYW5ub3QgYmUgc3VwcG9ydGVkIGJ5IGRldmljZSAlcy4g
UmVkdWNpbmcgdG8gJWx1LlxuIiwKLQkJCXBvcnQtPmlubGluZV9kYXRhX3NpemUsIGNtX2lkLT5k
ZXZpY2UtPm5hbWUsCisJCQlucG9ydC0+aW5saW5lX2RhdGFfc2l6ZSwgY21faWQtPmRldmljZS0+
bmFtZSwKIAkJCWlubGluZV9zZ2VfY291bnQgKiBQQUdFX1NJWkUpOwotCQlwb3J0LT5pbmxpbmVf
ZGF0YV9zaXplID0gaW5saW5lX3NnZV9jb3VudCAqIFBBR0VfU0laRTsKKwkJbnBvcnQtPmlubGlu
ZV9kYXRhX3NpemUgPSBpbmxpbmVfc2dlX2NvdW50ICogUEFHRV9TSVpFOwogCQlpbmxpbmVfcGFn
ZV9jb3VudCA9IGlubGluZV9zZ2VfY291bnQ7CiAJfQotCW5kZXYtPmlubGluZV9kYXRhX3NpemUg
PSBwb3J0LT5pbmxpbmVfZGF0YV9zaXplOworCW5kZXYtPmlubGluZV9kYXRhX3NpemUgPSBucG9y
dC0+aW5saW5lX2RhdGFfc2l6ZTsKIAluZGV2LT5pbmxpbmVfcGFnZV9jb3VudCA9IGlubGluZV9w
YWdlX2NvdW50OwogCW5kZXYtPmRldmljZSA9IGNtX2lkLT5kZXZpY2U7CiAJa3JlZl9pbml0KCZu
ZGV2LT5yZWYpOwpAQCAtMTI2Nyw2ICsxMjc1LDcgQEAgc3RhdGljIGludCBudm1ldF9yZG1hX2Nt
X2FjY2VwdChzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQsCiBzdGF0aWMgaW50IG52bWV0X3JkbWFf
cXVldWVfY29ubmVjdChzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQsCiAJCXN0cnVjdCByZG1hX2Nt
X2V2ZW50ICpldmVudCkKIHsKKwlzdHJ1Y3QgbnZtZXRfcmRtYV9wb3J0ICpwb3J0ID0gY21faWQt
PmNvbnRleHQ7CiAJc3RydWN0IG52bWV0X3JkbWFfZGV2aWNlICpuZGV2OwogCXN0cnVjdCBudm1l
dF9yZG1hX3F1ZXVlICpxdWV1ZTsKIAlpbnQgcmV0ID0gLUVJTlZBTDsKQEAgLTEyODIsNyArMTI5
MSw3IEBAIHN0YXRpYyBpbnQgbnZtZXRfcmRtYV9xdWV1ZV9jb25uZWN0KHN0cnVjdCByZG1hX2Nt
X2lkICpjbV9pZCwKIAkJcmV0ID0gLUVOT01FTTsKIAkJZ290byBwdXRfZGV2aWNlOwogCX0KLQlx
dWV1ZS0+cG9ydCA9IGNtX2lkLT5jb250ZXh0OworCXF1ZXVlLT5wb3J0ID0gcG9ydC0+bnBvcnQ7
CiAKIAlpZiAocXVldWUtPmhvc3RfcWlkID09IDApIHsKIAkJLyogTGV0IGluZmxpZ2h0IGNvbnRy
b2xsZXIgdGVhcmRvd24gY29tcGxldGUgKi8KQEAgLTE0MDcsNyArMTQxNiw3IEBAIHN0YXRpYyB2
b2lkIG52bWV0X3JkbWFfcXVldWVfY29ubmVjdF9mYWlsKHN0cnVjdCByZG1hX2NtX2lkICpjbV9p
ZCwKIHN0YXRpYyBpbnQgbnZtZXRfcmRtYV9kZXZpY2VfcmVtb3ZhbChzdHJ1Y3QgcmRtYV9jbV9p
ZCAqY21faWQsCiAJCXN0cnVjdCBudm1ldF9yZG1hX3F1ZXVlICpxdWV1ZSkKIHsKLQlzdHJ1Y3Qg
bnZtZXRfcG9ydCAqcG9ydDsKKwlzdHJ1Y3QgbnZtZXRfcmRtYV9wb3J0ICpwb3J0OwogCiAJaWYg
KHF1ZXVlKSB7CiAJCS8qCkBAIC0xNDI2LDcgKzE0MzUsNyBAQCBzdGF0aWMgaW50IG52bWV0X3Jk
bWFfZGV2aWNlX3JlbW92YWwoc3RydWN0IHJkbWFfY21faWQgKmNtX2lkLAogCSAqIGNtX2lkIGRl
c3Ryb3kuIHVzZSBhdG9taWMgeGNoZyB0byBtYWtlIHN1cmUKIAkgKiB3ZSBkb24ndCBjb21wZXRl
IHdpdGggcmVtb3ZlX3BvcnQuCiAJICovCi0JaWYgKHhjaGcoJnBvcnQtPnByaXYsIE5VTEwpICE9
IGNtX2lkKQorCWlmICh4Y2hnKCZwb3J0LT5jbV9pZCwgTlVMTCkgIT0gY21faWQpCiAJCXJldHVy
biAwOwogCiAJLyoKQEAgLTE0NTcsNiArMTQ2NiwxMyBAQCBzdGF0aWMgaW50IG52bWV0X3JkbWFf
Y21faGFuZGxlcihzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQsCiAJCW52bWV0X3JkbWFfcXVldWVf
ZXN0YWJsaXNoZWQocXVldWUpOwogCQlicmVhazsKIAljYXNlIFJETUFfQ01fRVZFTlRfQUREUl9D
SEFOR0U6CisJCWlmICghcXVldWUpIHsKKwkJCXN0cnVjdCBudm1ldF9yZG1hX3BvcnQgKnBvcnQg
PSBjbV9pZC0+Y29udGV4dDsKKworCQkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZwb3J0LT5yZXBh
aXJfd29yaywgMCk7CisJCQlicmVhazsKKwkJfQorCQkvKiBGQUxMVEhST1VHSCAqLwogCWNhc2Ug
UkRNQV9DTV9FVkVOVF9ESVNDT05ORUNURUQ6CiAJY2FzZSBSRE1BX0NNX0VWRU5UX1RJTUVXQUlU
X0VYSVQ6CiAJCW52bWV0X3JkbWFfcXVldWVfZGlzY29ubmVjdChxdWV1ZSk7CkBAIC0xNDk5LDQy
ICsxNTE1LDE5IEBAIHN0YXRpYyB2b2lkIG52bWV0X3JkbWFfZGVsZXRlX2N0cmwoc3RydWN0IG52
bWV0X2N0cmwgKmN0cmwpCiAJbXV0ZXhfdW5sb2NrKCZudm1ldF9yZG1hX3F1ZXVlX211dGV4KTsK
IH0KIAotc3RhdGljIGludCBudm1ldF9yZG1hX2FkZF9wb3J0KHN0cnVjdCBudm1ldF9wb3J0ICpw
b3J0KQorc3RhdGljIHZvaWQgbnZtZXRfcmRtYV9kaXNhYmxlX3BvcnQoc3RydWN0IG52bWV0X3Jk
bWFfcG9ydCAqcG9ydCkKIHsKLQlzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQ7Ci0Jc3RydWN0IHNv
Y2thZGRyX3N0b3JhZ2UgYWRkciA9IHsgfTsKLQlfX2tlcm5lbF9zYV9mYW1pbHlfdCBhZjsKLQlp
bnQgcmV0OwotCi0Jc3dpdGNoIChwb3J0LT5kaXNjX2FkZHIuYWRyZmFtKSB7Ci0JY2FzZSBOVk1G
X0FERFJfRkFNSUxZX0lQNDoKLQkJYWYgPSBBRl9JTkVUOwotCQlicmVhazsKLQljYXNlIE5WTUZf
QUREUl9GQU1JTFlfSVA2OgotCQlhZiA9IEFGX0lORVQ2OwotCQlicmVhazsKLQlkZWZhdWx0Ogot
CQlwcl9lcnIoImFkZHJlc3MgZmFtaWx5ICVkIG5vdCBzdXBwb3J0ZWRcbiIsCi0JCQkJcG9ydC0+
ZGlzY19hZGRyLmFkcmZhbSk7Ci0JCXJldHVybiAtRUlOVkFMOwotCX0KKwlzdHJ1Y3QgcmRtYV9j
bV9pZCAqY21faWQgPSB4Y2hnKCZwb3J0LT5jbV9pZCwgTlVMTCk7CiAKLQlpZiAocG9ydC0+aW5s
aW5lX2RhdGFfc2l6ZSA8IDApIHsKLQkJcG9ydC0+aW5saW5lX2RhdGFfc2l6ZSA9IE5WTUVUX1JE
TUFfREVGQVVMVF9JTkxJTkVfREFUQV9TSVpFOwotCX0gZWxzZSBpZiAocG9ydC0+aW5saW5lX2Rh
dGFfc2l6ZSA+IE5WTUVUX1JETUFfTUFYX0lOTElORV9EQVRBX1NJWkUpIHsKLQkJcHJfd2Fybigi
aW5saW5lX2RhdGFfc2l6ZSAldSBpcyB0b28gbGFyZ2UsIHJlZHVjaW5nIHRvICV1XG4iLAotCQkJ
cG9ydC0+aW5saW5lX2RhdGFfc2l6ZSwKLQkJCU5WTUVUX1JETUFfTUFYX0lOTElORV9EQVRBX1NJ
WkUpOwotCQlwb3J0LT5pbmxpbmVfZGF0YV9zaXplID0gTlZNRVRfUkRNQV9NQVhfSU5MSU5FX0RB
VEFfU0laRTsKLQl9CisJaWYgKGNtX2lkKQorCQlyZG1hX2Rlc3Ryb3lfaWQoY21faWQpOworfQog
Ci0JcmV0ID0gaW5ldF9wdG9uX3dpdGhfc2NvcGUoJmluaXRfbmV0LCBhZiwgcG9ydC0+ZGlzY19h
ZGRyLnRyYWRkciwKLQkJCXBvcnQtPmRpc2NfYWRkci50cnN2Y2lkLCAmYWRkcik7Ci0JaWYgKHJl
dCkgewotCQlwcl9lcnIoIm1hbGZvcm1lZCBpcC9wb3J0IHBhc3NlZDogJXM6JXNcbiIsCi0JCQlw
b3J0LT5kaXNjX2FkZHIudHJhZGRyLCBwb3J0LT5kaXNjX2FkZHIudHJzdmNpZCk7Ci0JCXJldHVy
biByZXQ7Ci0JfQorc3RhdGljIGludCBudm1ldF9yZG1hX2VuYWJsZV9wb3J0KHN0cnVjdCBudm1l
dF9yZG1hX3BvcnQgKnBvcnQpCit7CisJc3RydWN0IHNvY2thZGRyICphZGRyID0gKHN0cnVjdCBz
b2NrYWRkciAqKSZwb3J0LT5hZGRyOworCXN0cnVjdCByZG1hX2NtX2lkICpjbV9pZDsKKwlpbnQg
cmV0OwogCiAJY21faWQgPSByZG1hX2NyZWF0ZV9pZCgmaW5pdF9uZXQsIG52bWV0X3JkbWFfY21f
aGFuZGxlciwgcG9ydCwKIAkJCVJETUFfUFNfVENQLCBJQl9RUFRfUkMpOwpAQCAtMTU1MywyMyAr
MTU0NiwxOSBAQCBzdGF0aWMgaW50IG52bWV0X3JkbWFfYWRkX3BvcnQoc3RydWN0IG52bWV0X3Bv
cnQgKnBvcnQpCiAJCWdvdG8gb3V0X2Rlc3Ryb3lfaWQ7CiAJfQogCi0JcmV0ID0gcmRtYV9iaW5k
X2FkZHIoY21faWQsIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcik7CisJcmV0ID0gcmRtYV9iaW5k
X2FkZHIoY21faWQsIGFkZHIpOwogCWlmIChyZXQpIHsKLQkJcHJfZXJyKCJiaW5kaW5nIENNIElE
IHRvICVwSVNwY3MgZmFpbGVkICglZClcbiIsCi0JCQkoc3RydWN0IHNvY2thZGRyICopJmFkZHIs
IHJldCk7CisJCXByX2VycigiYmluZGluZyBDTSBJRCB0byAlcElTcGNzIGZhaWxlZCAoJWQpXG4i
LCBhZGRyLCByZXQpOwogCQlnb3RvIG91dF9kZXN0cm95X2lkOwogCX0KIAogCXJldCA9IHJkbWFf
bGlzdGVuKGNtX2lkLCAxMjgpOwogCWlmIChyZXQpIHsKLQkJcHJfZXJyKCJsaXN0ZW5pbmcgdG8g
JXBJU3BjcyBmYWlsZWQgKCVkKVxuIiwKLQkJCShzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgcmV0
KTsKKwkJcHJfZXJyKCJsaXN0ZW5pbmcgdG8gJXBJU3BjcyBmYWlsZWQgKCVkKVxuIiwgYWRkciwg
cmV0KTsKIAkJZ290byBvdXRfZGVzdHJveV9pZDsKIAl9CiAKLQlwcl9pbmZvKCJlbmFibGluZyBw
b3J0ICVkICglcElTcGNzKVxuIiwKLQkJbGUxNl90b19jcHUocG9ydC0+ZGlzY19hZGRyLnBvcnRp
ZCksIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcik7Ci0JcG9ydC0+cHJpdiA9IGNtX2lkOworCXBv
cnQtPmNtX2lkID0gY21faWQ7CiAJcmV0dXJuIDA7CiAKIG91dF9kZXN0cm95X2lkOgpAQCAtMTU3
NywxOCArMTU2Niw5MiBAQCBzdGF0aWMgaW50IG52bWV0X3JkbWFfYWRkX3BvcnQoc3RydWN0IG52
bWV0X3BvcnQgKnBvcnQpCiAJcmV0dXJuIHJldDsKIH0KIAotc3RhdGljIHZvaWQgbnZtZXRfcmRt
YV9yZW1vdmVfcG9ydChzdHJ1Y3QgbnZtZXRfcG9ydCAqcG9ydCkKK3N0YXRpYyB2b2lkIG52bWV0
X3JkbWFfcmVwYWlyX3BvcnRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpCiB7Ci0Jc3RydWN0
IHJkbWFfY21faWQgKmNtX2lkID0geGNoZygmcG9ydC0+cHJpdiwgTlVMTCk7CisJc3RydWN0IG52
bWV0X3JkbWFfcG9ydCAqcG9ydCA9IGNvbnRhaW5lcl9vZih0b19kZWxheWVkX3dvcmsodyksCisJ
CQkJCXN0cnVjdCBudm1ldF9yZG1hX3BvcnQsIHJlcGFpcl93b3JrKTsKKwlpbnQgcmV0OwogCi0J
aWYgKGNtX2lkKQotCQlyZG1hX2Rlc3Ryb3lfaWQoY21faWQpOworCW52bWV0X3JkbWFfZGlzYWJs
ZV9wb3J0KHBvcnQpOworCXJldCA9IG52bWV0X3JkbWFfZW5hYmxlX3BvcnQocG9ydCk7CisJaWYg
KHJldCkKKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZwb3J0LT5yZXBhaXJfd29yaywgNSAqIEha
KTsKK30KKworc3RhdGljIGludCBudm1ldF9yZG1hX2FkZF9wb3J0KHN0cnVjdCBudm1ldF9wb3J0
ICpucG9ydCkKK3sKKwlzdHJ1Y3QgbnZtZXRfcmRtYV9wb3J0ICpwb3J0OworCV9fa2VybmVsX3Nh
X2ZhbWlseV90IGFmOworCWludCByZXQ7CisKKwlwb3J0ID0ga3phbGxvYyhzaXplb2YoKnBvcnQp
LCBHRlBfS0VSTkVMKTsKKwlpZiAoIXBvcnQpCisJCXJldHVybiAtRU5PTUVNOworCisJbnBvcnQt
PnByaXYgPSBwb3J0OworCXBvcnQtPm5wb3J0ID0gbnBvcnQ7CisJSU5JVF9ERUxBWUVEX1dPUkso
JnBvcnQtPnJlcGFpcl93b3JrLCBudm1ldF9yZG1hX3JlcGFpcl9wb3J0X3dvcmspOworCisJc3dp
dGNoIChucG9ydC0+ZGlzY19hZGRyLmFkcmZhbSkgeworCQljYXNlIE5WTUZfQUREUl9GQU1JTFlf
SVA0OgorCQkJYWYgPSBBRl9JTkVUOworCQkJYnJlYWs7CisJCWNhc2UgTlZNRl9BRERSX0ZBTUlM
WV9JUDY6CisJCQlhZiA9IEFGX0lORVQ2OworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQlwcl9l
cnIoImFkZHJlc3MgZmFtaWx5ICVkIG5vdCBzdXBwb3J0ZWRcbiIsCisJCQkJCQkJbnBvcnQtPmRp
c2NfYWRkci5hZHJmYW0pOworCQkJcmV0ID0gLUVJTlZBTDsKKwkJCWdvdG8gb3V0X2ZyZWVfcG9y
dDsKKwkJfQorCisJCWlmIChucG9ydC0+aW5saW5lX2RhdGFfc2l6ZSA8IDApIHsKKwkJCW5wb3J0
LT5pbmxpbmVfZGF0YV9zaXplID0gTlZNRVRfUkRNQV9ERUZBVUxUX0lOTElORV9EQVRBX1NJWkU7
CisJCX0gZWxzZSBpZiAobnBvcnQtPmlubGluZV9kYXRhX3NpemUgPiBOVk1FVF9SRE1BX01BWF9J
TkxJTkVfREFUQV9TSVpFKSB7CisJCQlwcl93YXJuKCJpbmxpbmVfZGF0YV9zaXplICV1IGlzIHRv
byBsYXJnZSwgcmVkdWNpbmcgdG8gJXVcbiIsCisJCQkJCW5wb3J0LT5pbmxpbmVfZGF0YV9zaXpl
LAorCQkJCQlOVk1FVF9SRE1BX01BWF9JTkxJTkVfREFUQV9TSVpFKTsKKwkJCW5wb3J0LT5pbmxp
bmVfZGF0YV9zaXplID0gTlZNRVRfUkRNQV9NQVhfSU5MSU5FX0RBVEFfU0laRTsKKwkJfQorCisJ
CXJldCA9IGluZXRfcHRvbl93aXRoX3Njb3BlKCZpbml0X25ldCwgYWYsIG5wb3J0LT5kaXNjX2Fk
ZHIudHJhZGRyLAorCQkJCQkJbnBvcnQtPmRpc2NfYWRkci50cnN2Y2lkLCAmcG9ydC0+YWRkcik7
CisJCWlmIChyZXQpIHsKKwkJCXByX2VycigibWFsZm9ybWVkIGlwL3BvcnQgcGFzc2VkOiAlczol
c1xuIiwKKwkJCQkJbnBvcnQtPmRpc2NfYWRkci50cmFkZHIsIG5wb3J0LT5kaXNjX2FkZHIudHJz
dmNpZCk7CisJCQlnb3RvIG91dF9mcmVlX3BvcnQ7CisJCX0KKworCQlyZXQgPSBudm1ldF9yZG1h
X2VuYWJsZV9wb3J0KHBvcnQpOworCQlpZihyZXQpCisJCQlnb3RvIG91dF9mcmVlX3BvcnQ7CisK
KwkJcHJfaW5mbygiZW5hYmxpbmcgcG9ydCAlZCAoJXBJU3BjcylcbiIsCisJCQkJbGUxNl90b19j
cHUobnBvcnQtPmRpc2NfYWRkci5wb3J0aWQpLAorCQkJCShzdHJ1Y3Qgc29ja2FkZHIgKikmcG9y
dC0+YWRkcik7CisKKwkJcmV0dXJuIDA7CisKK291dF9mcmVlX3BvcnQ6CisJCWtmcmVlKHBvcnQp
OworCQlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgdm9pZCBudm1ldF9yZG1hX3JlbW92ZV9wb3J0
KHN0cnVjdCBudm1ldF9wb3J0ICpucG9ydCkKK3sKKwlzdHJ1Y3QgbnZtZXRfcmRtYV9wb3J0ICpw
b3J0ID0gbnBvcnQtPnByaXY7CisKKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnBvcnQtPnJl
cGFpcl93b3JrKTsKKwludm1ldF9yZG1hX2Rpc2FibGVfcG9ydChwb3J0KTsKKwlrZnJlZShwb3J0
KTsKIH0KIAogc3RhdGljIHZvaWQgbnZtZXRfcmRtYV9kaXNjX3BvcnRfYWRkcihzdHJ1Y3QgbnZt
ZXRfcmVxICpyZXEsCi0JCXN0cnVjdCBudm1ldF9wb3J0ICpwb3J0LCBjaGFyICp0cmFkZHIpCisJ
CXN0cnVjdCBudm1ldF9wb3J0ICpucG9ydCwgY2hhciAqdHJhZGRyKQogewotCXN0cnVjdCByZG1h
X2NtX2lkICpjbV9pZCA9IHBvcnQtPnByaXY7CisJc3RydWN0IG52bWV0X3JkbWFfcG9ydCAqcG9y
dCA9IG5wb3J0LT5wcml2OworCXN0cnVjdCByZG1hX2NtX2lkICpjbV9pZCA9IHBvcnQtPmNtX2lk
OwogCiAJaWYgKGluZXRfYWRkcl9pc19hbnkoKHN0cnVjdCBzb2NrYWRkciAqKSZjbV9pZC0+cm91
dGUuYWRkci5zcmNfYWRkcikpIHsKIAkJc3RydWN0IG52bWV0X3JkbWFfcnNwICpyc3AgPQpAQCAt
MTU5OCw3ICsxNjYxLDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfcmRtYV9kaXNjX3BvcnRfYWRkcihz
dHJ1Y3QgbnZtZXRfcmVxICpyZXEsCiAKIAkJc3ByaW50Zih0cmFkZHIsICIlcElTYyIsIGFkZHIp
OwogCX0gZWxzZSB7Ci0JCW1lbWNweSh0cmFkZHIsIHBvcnQtPmRpc2NfYWRkci50cmFkZHIsIE5W
TUZfVFJBRERSX1NJWkUpOworCQltZW1jcHkodHJhZGRyLCBucG9ydC0+ZGlzY19hZGRyLnRyYWRk
ciwgTlZNRl9UUkFERFJfU0laRSk7CiAJfQogfQogCg==
--00000000000085c76205a24b36ee
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--00000000000085c76205a24b36ee--


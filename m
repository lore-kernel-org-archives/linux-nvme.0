Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18754C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 00:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6186206F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 00:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F0IyktWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6186206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SqnkCe+zTo9SQOwdqr46pQGWCBg4vNyNca7800Dq8+4=; b=F0IyktWxN8HUYAimPhHX2gw+A
	GlGPq5ZRLOIFHgej5/FoNE9ksQRykn86TqKAacgeiHJDtKhvyYVtN6JE0L257VNpXF4A1d7TFGPfC
	zDWyAnIp8mgQXfHKYYCVy963MmGhca3P3dRTUMhcfyGjeGwHDUjfceE3Z3tehUPZqOSQGmPaH2HZc
	GGB2VUZ+oe80wbBvrQHwI1Nt53UfgZzMpuD8J93+0Zc0+dzx9rR7Gaaqjlw7jrga8aentpPG4yQaA
	3n3yM9et2+NKVOvWzS3zzEo4mjnRddIgXGIzWjP58zSryS9oq8/z+tCLGIA0gwY8XPBlO72qifU93
	h9lxHnTrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJ4ex-0000aO-Sp; Tue, 31 Mar 2020 00:21:39 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJ4ev-0000Zq-03
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 00:21:38 +0000
Received: by mail-pl1-f196.google.com with SMTP id e1so7420327plt.9
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 17:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IBD1zv+VwoMpzzZCZ+mLT+H97SjaIu0EGZcIMb0vaj8=;
 b=eoJSVh2PMOBPlyU7C/6N+V3gJ0IO+DdiE+7Ru5W/XTCO6hIW2L8DPT0oaNVWdXGw5+
 Z0cFI9Ac/TzlVm6AhzNTCCZv07kftOOvxqPJ+FD5h+C/eAababiqwblvq4qyfoZ+hnUn
 fTPtEX+Bxdfh+/iBugWrVh8Po9cPxJwiNdfnPCfJUF8g6om2+1o3iBzd/wDusnBFa3J7
 zzRU6ptZIdO6BpXKbEdVRJvBxbjTFnRYiiATQe/2JSDkJA5BtwykQSqbanCXL9ONW0hU
 qvqnuM+KYSMXzUlqD7NODXn/dGHMSxiaheTZJ/GNjKZIMCAPkU1BIJIcVnyk4aR38dXe
 iUnQ==
X-Gm-Message-State: AGi0PuYVktXJMu7BJkyX0SVtKHzx6560oK3dYUvHAjJFGk2zFXV15A/v
 Wsk8cYR8pQeoNMx7C1QdHa8=
X-Google-Smtp-Source: APiQypIx22oi9vyzW/AmZhBJwfH3AdFIQgGvey5lpNqC2jSOhu1CqGceCIzn42WeCfwFXTUd3T/eOw==
X-Received: by 2002:a17:90b:1944:: with SMTP id
 nk4mr757485pjb.70.1585614094173; 
 Mon, 30 Mar 2020 17:21:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b015:431e:549a:54d?
 ([2601:647:4802:9070:b015:431e:549a:54d])
 by smtp.gmail.com with ESMTPSA id x3sm10995594pfp.167.2020.03.30.17.21.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2020 17:21:33 -0700 (PDT)
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
To: Alex Lyakas <alex@zadara.com>
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f439f61-338f-4f37-2b13-d3b743c32409@grimberg.me>
Date: Mon, 30 Mar 2020 17:21:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_172137_040837_D5DD5573 
X-CRM114-Status: GOOD (  26.50  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Alex,

>>> Alex, Max? did you retest this?
>>
>> Raising this from the ashes...
>>
>> Alex, did you test this patch?
> 
> Raising from the ashes!
> 
> In short: this patch fixes the issue!

Thanks for following up..

> 
> More details:
> 
> This patch doesn't apply on kernel 5.2. Moreover, I believe this patch
> is incomplete, because nvmet_rdma_find_get_device() needs to be fixed
> to treat cm_id->context as "struct nvmet_rdma_port" and not as "struct
> nvmet_port".

Does patch [1] apply on kernel 5.2?

> However, since we are working with kernel modules from Mellanox OFED,
> I tried applying this patch on OFED 4.7. I discovered that it already
> has almost everything this patch introduces. Like "struct
> nvmet_rdma_port" and the refactoring of nvmet_rdma_add_port into
> nvmet_rdma_enable_port, and nvmet_rdma_remove_port to
> nvmet_rdma_disable_port. I ended up with this patch [1].
> 
> Tested bond failover, and cm_id is destroyed and re-created as expected [2]
> 
> Israel, Max and other Mellanox folks: can we have this fix in OFED 4.9?
> 

For MOFED issues you can follow-up with Max and Israel offline. If you
can test upstream or even 5.2 stable that would be beneficial as I can
add your Tested-by tag.

Thanks.

[1]:
--
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Wed Jul 3 15:33:01 2019 -0700

     nvmet-rdma: fix bonding failover possible NULL deref

     RDMA_CM_EVENT_ADDR_CHANGE event occur in the case of bonding failover
     on normal as well as on listening cm_ids. Hence this event will
     immediately trigger a NULL dereference trying to disconnect a queue
     for a cm_id that actually belongs to the port.

     To fix this we provide a different handler for the listener cm_ids
     that will defer a work to disable+(re)enable the port which essentially
     destroys and setups another listener cm_id

     Reported-by: Alex Lyakas <alex@zadara.com>
     Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9e1b8c61f54e..8dac89b7aa12 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -105,6 +105,13 @@ struct nvmet_rdma_queue {
         struct list_head        queue_list;
  };

+struct nvmet_rdma_port {
+       struct nvmet_port       *nport;
+       struct sockaddr_storage addr;
+       struct rdma_cm_id       *cm_id;
+       struct delayed_work     repair_work;
+};
+
  struct nvmet_rdma_device {
         struct ib_device        *device;
         struct ib_pd            *pd;
@@ -1272,6 +1279,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id 
*cm_id,
  static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
                 struct rdma_cm_event *event)
  {
+       struct nvmet_rdma_port *port = cm_id->context;
         struct nvmet_rdma_device *ndev;
         struct nvmet_rdma_queue *queue;
         int ret = -EINVAL;
@@ -1287,7 +1295,7 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,
                 ret = -ENOMEM;
                 goto put_device;
         }
-       queue->port = cm_id->context;
+       queue->port = port->nport;

         if (queue->host_qid == 0) {
                 /* Let inflight controller teardown complete */
@@ -1412,7 +1420,7 @@ static void nvmet_rdma_queue_connect_fail(struct 
rdma_cm_id *cm_id,
  static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
                 struct nvmet_rdma_queue *queue)
  {
-       struct nvmet_port *port;
+       struct nvmet_rdma_port *port;

         if (queue) {
                 /*
@@ -1431,7 +1439,7 @@ static int nvmet_rdma_device_removal(struct 
rdma_cm_id *cm_id,
          * cm_id destroy. use atomic xchg to make sure
          * we don't compete with remove_port.
          */
-       if (xchg(&port->priv, NULL) != cm_id)
+       if (xchg(&port->cm_id, NULL) != cm_id)
                 return 0;

         /*
@@ -1462,6 +1470,13 @@ static int nvmet_rdma_cm_handler(struct 
rdma_cm_id *cm_id,
                 nvmet_rdma_queue_established(queue);
                 break;
         case RDMA_CM_EVENT_ADDR_CHANGE:
+               if (!queue) {
+                       struct nvmet_rdma_port *port = cm_id->context;
+
+                       schedule_delayed_work(&port->repair_work, 0);
+                       break;
+               }
+               /* FALLTHROUGH */
         case RDMA_CM_EVENT_DISCONNECTED:
         case RDMA_CM_EVENT_TIMEWAIT_EXIT:
                 nvmet_rdma_queue_disconnect(queue);
@@ -1504,42 +1519,19 @@ static void nvmet_rdma_delete_ctrl(struct 
nvmet_ctrl *ctrl)
         mutex_unlock(&nvmet_rdma_queue_mutex);
  }

-static int nvmet_rdma_add_port(struct nvmet_port *port)
+static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
  {
-       struct rdma_cm_id *cm_id;
-       struct sockaddr_storage addr = { };
-       __kernel_sa_family_t af;
-       int ret;
+       struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);

-       switch (port->disc_addr.adrfam) {
-       case NVMF_ADDR_FAMILY_IP4:
-               af = AF_INET;
-               break;
-       case NVMF_ADDR_FAMILY_IP6:
-               af = AF_INET6;
-               break;
-       default:
-               pr_err("address family %d not supported\n",
-                               port->disc_addr.adrfam);
-               return -EINVAL;
-       }
-
-       if (port->inline_data_size < 0) {
-               port->inline_data_size = 
NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
-       } else if (port->inline_data_size > 
NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
-               pr_warn("inline_data_size %u is too large, reducing to 
%u\n",
-                       port->inline_data_size,
-                       NVMET_RDMA_MAX_INLINE_DATA_SIZE);
-               port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
-       }
+       if (cm_id)
+               rdma_destroy_id(cm_id);
+}

-       ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
-                       port->disc_addr.trsvcid, &addr);
-       if (ret) {
-               pr_err("malformed ip/port passed: %s:%s\n",
-                       port->disc_addr.traddr, port->disc_addr.trsvcid);
-               return ret;
-       }
+static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
+{
+       struct sockaddr *addr = (struct sockaddr *)&port->addr;
+       struct rdma_cm_id *cm_id;
+       int ret;

         cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
                         RDMA_PS_TCP, IB_QPT_RC);
@@ -1558,23 +1550,19 @@ static int nvmet_rdma_add_port(struct nvmet_port 
*port)
                 goto out_destroy_id;
         }

-       ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
+       ret = rdma_bind_addr(cm_id, addr);
         if (ret) {
-               pr_err("binding CM ID to %pISpcs failed (%d)\n",
-                       (struct sockaddr *)&addr, ret);
+               pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
                 goto out_destroy_id;
         }

         ret = rdma_listen(cm_id, 128);
         if (ret) {
-               pr_err("listening to %pISpcs failed (%d)\n",
-                       (struct sockaddr *)&addr, ret);
+               pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
                 goto out_destroy_id;
         }

-       pr_info("enabling port %d (%pISpcs)\n",
-               le16_to_cpu(port->disc_addr.portid), (struct sockaddr 
*)&addr);
-       port->priv = cm_id;
+       port->cm_id = cm_id;
         return 0;

  out_destroy_id:
@@ -1582,18 +1570,92 @@ static int nvmet_rdma_add_port(struct nvmet_port 
*port)
         return ret;
  }

-static void nvmet_rdma_remove_port(struct nvmet_port *port)
+static void nvmet_rdma_repair_port_work(struct work_struct *w)
  {
-       struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
+       struct nvmet_rdma_port *port = container_of(to_delayed_work(w),
+                       struct nvmet_rdma_port, repair_work);
+       int ret;

-       if (cm_id)
-               rdma_destroy_id(cm_id);
+       nvmet_rdma_disable_port(port);
+       ret = nvmet_rdma_enable_port(port);
+       if (ret)
+               schedule_delayed_work(&port->repair_work, 5 * HZ);
+}
+
+static int nvmet_rdma_add_port(struct nvmet_port *nport)
+{
+       struct nvmet_rdma_port *port;
+       __kernel_sa_family_t af;
+       int ret;
+
+       port = kzalloc(sizeof(*port), GFP_KERNEL);
+       if (!port)
+               return -ENOMEM;
+
+       nport->priv = port;
+       port->nport = nport;
+       INIT_DELAYED_WORK(&port->repair_work, nvmet_rdma_repair_port_work);
+
+       switch (nport->disc_addr.adrfam) {
+       case NVMF_ADDR_FAMILY_IP4:
+               af = AF_INET;
+               break;
+       case NVMF_ADDR_FAMILY_IP6:
+               af = AF_INET6;
+               break;
+       default:
+               pr_err("address family %d not supported\n",
+                               nport->disc_addr.adrfam);
+               ret = -EINVAL;
+               goto out_free_port;
+       }
+
+       if (nport->inline_data_size < 0) {
+               nport->inline_data_size = 
NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
+       } else if (nport->inline_data_size > 
NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
+               pr_warn("inline_data_size %u is too large, reducing to 
%u\n",
+                       nport->inline_data_size,
+                       NVMET_RDMA_MAX_INLINE_DATA_SIZE);
+               nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
+       }
+
+       ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
+                       nport->disc_addr.trsvcid, &port->addr);
+       if (ret) {
+               pr_err("malformed ip/port passed: %s:%s\n",
+                       nport->disc_addr.traddr, nport->disc_addr.trsvcid);
+               goto out_free_port;
+       }
+
+       ret = nvmet_rdma_enable_port(port);
+       if(ret)
+               goto out_free_port;
+
+       pr_info("enabling port %d (%pISpcs)\n",
+               le16_to_cpu(nport->disc_addr.portid),
+               (struct sockaddr *)&port->addr);
+
+       return 0;
+
+out_free_port:
+       kfree(port);
+       return ret;
+}
+
+static void nvmet_rdma_remove_port(struct nvmet_port *nport)
+{
+       struct nvmet_rdma_port *port = nport->priv;
+
+       cancel_delayed_work_sync(&port->repair_work);
+       nvmet_rdma_disable_port(port);
+       kfree(port);
  }

  static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
-               struct nvmet_port *port, char *traddr)
+               struct nvmet_port *nport, char *traddr)
  {
-       struct rdma_cm_id *cm_id = port->priv;
+       struct nvmet_rdma_port *port = nport->priv;
+       struct rdma_cm_id *cm_id = port->cm_id;

         if (inet_addr_is_any((struct sockaddr 
*)&cm_id->route.addr.src_addr)) {
                 struct nvmet_rdma_rsp *rsp =
@@ -1603,7 +1665,7 @@ static void nvmet_rdma_disc_port_addr(struct 
nvmet_req *req,

                 sprintf(traddr, "%pISc", addr);
         } else {
-               memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
+               memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
         }
  }
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2831FC43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 19:03:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57AC2072E
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 19:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sf3ANke3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zadara-com.20150623.gappssmtp.com header.i=@zadara-com.20150623.gappssmtp.com header.b="duDP2a3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57AC2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zadara.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yNUrA0F2EkiEMe/nqriWIbVJtxSjd+tffEU2+9+TodA=; b=Sf3ANke3RjwsF+
	S+X4J0LCuUQH5eapvDJ0LwFoKub7wqWuG38mRDXDnMU5CjNo9ptaDZL1gPGvqV1XLulwmLZAxK5Ck
	ByMUJyz3H8Bd26NfAH1MWxuM7bzHsynkxhtyPVRjvWsT07KliRdMm/+PE1s7aqsW32WM9/XScKHkr
	W/9o88AkAXMJICt7xlgliHufb48wVitVOErDxc0lyMO8//sVoGzQiQ9E1EbjK9T4VDc3k3X6lqlLB
	qfgoFULbDIdXn2snmVg3wNYmgkM5hI20u6ot2KfgJ9zjGtaakw8i6Y6NsBUhQfCwosc2E1z10fzmr
	kwFE0LQjb5G+E2pSMOlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIzgh-0000qE-F1; Mon, 30 Mar 2020 19:03:07 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIzgf-0000pf-5D
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 19:03:06 +0000
Received: by mail-io1-xd41.google.com with SMTP id r25so7163976ioc.11
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zadara-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BmYUn2f59rHWjTLqacX/nK0k1Ic03R+zRXSxF6xF2P4=;
 b=duDP2a3UDH9VjYp7XKgLZcVK8T0Xk67EOhoSfUNke2vS91lCqh0K9BEbs/b7rtib/c
 q58xnSTHKLQj/TW+zszowijZnuMIZgvTRYKQhH8C6mhfzNiNdnHb52MhlDTn37elbUhv
 b5Kteesl+d/mKG9A7t8MzhDEVLTjDfy6YmRxvmZdD67J4w2G7CMdxrFY9NwGfMP03rgo
 WS0acB2VkYNYqGaJsmtKHdpx37HQoMumEN02HZlrkAgxFzad4RWOK8DEeXzDpATsGdSl
 1PK36mVXAIAhLwYbOlhPs5ivIN/kLhN12SP0Klc+IP5TBLNJWzp3GFdG95keX9IgCIbS
 FrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BmYUn2f59rHWjTLqacX/nK0k1Ic03R+zRXSxF6xF2P4=;
 b=sKCZ+0BVk4JyAXrc/9fRFA1U9MMmclXjJwholxJliGdO6kYMDVYg6Q/mCH0IP2Fr/Z
 /9aTeJrTVYKe9ky9ZkBdOXO4IIDmEHgW1o3dfKHVHGSsFdu+XALnwKjUDYn1Ta//bt77
 fq+tq90o+jsA9hb65KBlf2DhPbgBMCOn4cLg2uGL1ieHZwE/6JYxmHeICHYOppPb+aWw
 tx7gsrC+IxGGloiNSh1+O0IF++oH3Wodcpwb3bJ1KRBI9mcrolQ8mFFlLtGMYE1NuQmW
 Cdxx9kssh0agE4zjG1qCR0875waFpc+uWwIiiqmHp00Y6W6I9SIJGJRGbX6WBQrK5yQp
 xkaA==
X-Gm-Message-State: ANhLgQ012fD/N1f8yfg9NlxeQQYT+r3rYV2Pqmf/XSULbytrFgG0ecvJ
 iBQAtKsYkueL/iccAqrTdTbKPZx0tqatRjBOt/jvcQ==
X-Google-Smtp-Source: ADFU+vtAtjVX5Y507ETNR+vuQOGPh39j1MD7iddFT0HvpwIPg5BX5RvTZ2xmItApyppbm8TugdzRCFkdtxpgZPMi8oo=
X-Received: by 2002:a6b:7419:: with SMTP id s25mr12034453iog.45.1585594984019; 
 Mon, 30 Mar 2020 12:03:04 -0700 (PDT)
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
In-Reply-To: <5fee46b0-0516-766a-5b1a-7114a164c9ae@grimberg.me>
From: Alex Lyakas <alex@zadara.com>
Date: Mon, 30 Mar 2020 22:02:52 +0300
Message-ID: <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_120305_255635_1620797D 
X-CRM114-Status: GOOD (  16.37  )
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
Cc: tomwu@mellanox.com, Max Gurtovoy <maxg@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Shlomi Nimrodi <shlomin@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

>
>
> >>> Hi Sagi,
> >>>
> >>> Which kernel this patch applies to?
> >>
> >> its based on the nvme tree, but it should apply cleanly on upstream
> >> 5.2...
> >
> > Alex, Max? did you retest this?
>
> Raising this from the ashes...
>
> Alex, did you test this patch?

Raising from the ashes!

In short: this patch fixes the issue!

More details:

This patch doesn't apply on kernel 5.2. Moreover, I believe this patch
is incomplete, because nvmet_rdma_find_get_device() needs to be fixed
to treat cm_id->context as "struct nvmet_rdma_port" and not as "struct
nvmet_port".

However, since we are working with kernel modules from Mellanox OFED,
I tried applying this patch on OFED 4.7. I discovered that it already
has almost everything this patch introduces. Like "struct
nvmet_rdma_port" and the refactoring of nvmet_rdma_add_port into
nvmet_rdma_enable_port, and nvmet_rdma_remove_port to
nvmet_rdma_disable_port. I ended up with this patch [1].

Tested bond failover, and cm_id is destroyed and re-created as expected [2]

Israel, Max and other Mellanox folks: can we have this fix in OFED 4.9?

Thanks,
Alex.


[1]
diff -ru mlnx-nvme-4.7-orig/target/rdma.c mlnx-nvme-4.7/target/rdma.c
--- mlnx-nvme-4.7-orig/target/rdma.c    2020-01-15 09:58:59.000000000 +0200
+++ mlnx-nvme-4.7/target/rdma.c    2020-03-30 20:49:49.932479383 +0300
@@ -191,6 +191,7 @@
                 struct nvmet_rdma_rsp *r);
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
                 struct nvmet_rdma_rsp *r);
+static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port);

 static const struct nvmet_fabrics_ops nvmet_rdma_ops;

@@ -1544,6 +1545,13 @@
         nvmet_rdma_queue_established(queue);
         break;
     case RDMA_CM_EVENT_ADDR_CHANGE:
+        if (!queue) {
+            struct nvmet_rdma_port *port = cm_id->context;
+
+            pr_warn("RDMA_CM_EVENT_ADDR_CHANGE: cm_id=%p schedule
enable_work\n", cm_id);
+            schedule_delayed_work(&port->enable_work, 0);
+            break;
+        }
     case RDMA_CM_EVENT_DISCONNECTED:
     case RDMA_CM_EVENT_TIMEWAIT_EXIT:
         nvmet_rdma_queue_disconnect(queue);
@@ -1598,6 +1606,8 @@
         return PTR_ERR(cm_id);
     }

+    pr_info("nvmet_rdma_enable_port: created cm_id=%p\n", cm_id);
+
     /*
      * Allow both IPv4 and IPv6 sockets to bind a single port
      * at the same time.
@@ -1620,7 +1630,7 @@
         goto out_destroy_id;
     }

-    port->cm_id = cm_id;
+    xchg(&port->cm_id, cm_id);
     if (cm_id->device)
         port->node_guid = cm_id->device->node_guid;

@@ -1640,6 +1650,7 @@
             struct nvmet_rdma_port, enable_work);
     int ret;

+    nvmet_rdma_disable_port(port);
     ret = nvmet_rdma_enable_port(port);
     if (ret)
         schedule_delayed_work(&port->enable_work, 5 * HZ);
@@ -1707,13 +1718,14 @@

 static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
 {
-    struct rdma_cm_id *cm_id = port->cm_id;
+    struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
     struct nvmet_port *nport = port->nport;

+    pr_info("nvmet_rdma_disable_port: cm_id=%p\n", cm_id);
+
     if (nport->offload && cm_id)
         nvmet_rdma_destroy_xrqs(nport);

-    port->cm_id = NULL;
     if (cm_id)
         rdma_destroy_id(cm_id);
 }


[2]
Mar 30 21:57:48.030761 qa3-sn2 kernel: [95220.661707] bebond: making
interface be10G2 the new active one
Mar 30 21:57:48.030789 qa3-sn2 kernel: [95220.662003] RDMA CM addr
change for ndev bebond used by id ffff966432c63000
Mar 30 21:57:48.030793 qa3-sn2 kernel: [95220.662007] RDMA CM addr
change for ndev bebond used by id ffff966a6ee85800
Mar 30 21:57:48.030817 qa3-sn2 kernel: [95220.662010] RDMA CM addr
change for ndev bebond used by id ffff966a6ee87400
Mar 30 21:57:48.030821 qa3-sn2 kernel: [95220.662012] RDMA CM addr
change for ndev bebond used by id ffff966a6ee85400
Mar 30 21:57:48.030824 qa3-sn2 kernel: [95220.662015] RDMA CM addr
change for ndev bebond used by id ffff966a6ee83c00
Mar 30 21:57:48.030827 qa3-sn2 kernel: [95220.662017] RDMA CM addr
change for ndev bebond used by id ffff966a6ee84c00
Mar 30 21:57:48.030829 qa3-sn2 kernel: [95220.662025] nvmet_rdma:
RDMA_CM_EVENT_ADDR_CHANGE: cm_id=ffff966432c63000 schedule enable_work
Mar 30 21:57:48.030832 qa3-sn2 kernel: [95220.662069] nvmet_rdma:
nvmet_rdma_disable_port: cm_id=ffff966432c63000
Mar 30 21:57:48.030834 qa3-sn2 kernel: [95220.662093] nvmet_rdma:
nvmet_rdma_enable_port: created cm_id=ffff96658fdab800
Mar 30 21:57:48.030837 qa3-sn2 kernel: [95220.662120] nvmet_rdma:
enabling port 1 (10.3.3.3:4420)
Mar 30 21:57:50.266755 qa3-sn2 kernel: [95222.897752] nvmet: creating
controller 1 for subsystem
nqn.2011-04.com.zadarastorage:volume-00000010 for NQN
iqn.2011-04.com.zadarastorage:2:vc-1.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

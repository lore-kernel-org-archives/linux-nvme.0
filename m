Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8625C2D0E8
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BED120714
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZysbhS9B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="b0CfbjUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BED120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nc5Sn8tQ79/eWC+ewK0HnkXxsOCWx2s1LsAB54iBD+w=; b=ZysbhS9BsEk8Cv
	pj9H5NU7HilAhJrjQqkq/krkAbAzCqZQtgQDFxN9/xGliS24Dz7tldo3tO25ZhdfjgEFL6lypl6ci
	kz/n/greJTC/8DPn+IluMaiMKZwY0wtu4skcinEcePDDZjL2BfF/2GqSNKRYV56p/Z57eF8NrsTTt
	Wc8/MEBT3tgHjSsNSE1wLL5TxBbHdEyArzwoPWaPHL+n7zIK7w0kz4jb/9C045qr2qn8fr03HqeFY
	xayOvh6RE5van+hCtvy35uiq06YmDA0PSVQUvKK0ssnXzuNubXtimdc7TqC3zRQxxB6PJYFjRzu4H
	sl9Ee4JFzPXeywsVWcyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJC4P-0001k3-T0; Tue, 31 Mar 2020 08:16:25 +0000
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJC4E-0001a9-0a
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 08:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr0utKFIWVzOF2jZAGHRrpDKipSujQwRtK+mwJK5/QlXpU2wFxO3sGa6xEXfjEyCM0Ta8JdD+Ox9lfNWTb0SsUum9ZvcYQOPas3CatfRwiOk0NMJ+KGkdFK2nxmioGxcAG04zOtarwkHotwKlMYlyy6vtkD4B+7D5ygX1Z417KwCnXkJjTBitIA7b6NUBqCdaUTZOjCUZ2t4hQlGM3vey1+n/Dm7FUVVd9weTu3SfPzrYpyfZP8HOOlWeWE8W6z0WXGJuGGt9oEuTjFVwFxO6mkcdVZQdB1U673xFqOwiW+J2NOoCM1nAzv4bgSigw8XxfQMICDov1wH0OjNI3QHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XtYMVpQCVhbp4HnfWKRFIjR7wvTxhc8PDJENt1ZYws=;
 b=K5GBeLX+w5YGbz1TW3lVtne9QfMP64x9gn6jeyeHnpOjn/wmGZbTc8DEc39N50bBLZRdqWMcikya93J/sjFsM3IrVH+zbhxXHjBuF0lqnbGikRbtX2ACEyTJxF5IajtD64MxDwnmFeN7swzmtyY6/d0LmKa5IFUR0eaEyd/17NM5VqHGbvoiNdFTbfLKrfLfuzvALoy09AOmQe/eNH30R4J19teDCMM0Go+UliTSooiosYPqWgXVYS4XjhUTBUe02Kd0C1hpb0zokbI78tRjjlqs55ycPdC5y5+kC9G1aDhhlG/Y6dMPIM1mzRsyGdTRl1G5Nk7HGn3evQHflHlQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XtYMVpQCVhbp4HnfWKRFIjR7wvTxhc8PDJENt1ZYws=;
 b=b0CfbjUhZzMgNsWV3thOaFoXeMCSi4Hw0DRo5OKbMZcS7w4dDk4lDsTpoybihgKeFgSuSq5PE6EEUhpFXTNzRE0nlCyWb/AQXO/o+iUSxWYS7y/MLvvq7sRGbI4LvjekuNynmMugYhtCnkBaFNQQ5Pw2Tr+J4Qu5++YS0owRaJM=
Received: from AM0PR0502MB3777.eurprd05.prod.outlook.com (52.133.47.23) by
 AM0PR0502MB3715.eurprd05.prod.outlook.com (52.133.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 08:16:09 +0000
Received: from AM0PR0502MB3777.eurprd05.prod.outlook.com
 ([fe80::65e6:5bf4:b844:8465]) by AM0PR0502MB3777.eurprd05.prod.outlook.com
 ([fe80::65e6:5bf4:b844:8465%3]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 08:16:09 +0000
From: Shlomi Nimrodi <shlomin@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Alex Lyakas <alex@zadara.com>
Subject: RE: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
Thread-Topic: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
Thread-Index: AQHVMZ7Ogx7dWH66H0uk966533Hhaaa5ffCAgA3xrYCAAZPIgIAAxKgAgBvgE4CARLtPAIE4xPMAgABZB4CAAISK4A==
Date: Tue, 31 Mar 2020 08:16:09 +0000
Message-ID: <AM0PR0502MB37775AC262BAE17527A9CC29D7C80@AM0PR0502MB3777.eurprd05.prod.outlook.com>
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
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shlomin@mellanox.com; 
x-originating-ip: [85.250.232.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04327a9a-8b8c-41b0-bf94-08d7d54bc4b8
x-ms-traffictypediagnostic: AM0PR0502MB3715:|AM0PR0502MB3715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0502MB37151719CAF54B6382EDA072D7C80@AM0PR0502MB3715.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR0502MB3777.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(33656002)(53546011)(478600001)(107886003)(81156014)(7696005)(8676002)(81166006)(6506007)(5660300002)(2906002)(66446008)(76116006)(54906003)(316002)(186003)(66556008)(71200400001)(66476007)(52536014)(4326008)(86362001)(8936002)(66946007)(110136005)(26005)(55016002)(9686003)(64756008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZiA63oTMTmT2iXWUe22rwE3fUBJu5sEgGS3W9y4+x2WTGMXzHaUkxZMUb3Gi3lJtQwyQ7weXO6IzFePGaNj0bT2LQvu4caHFr/yco4tHTxjciwBHiD4DPb77G9ODYFV73BoGRYcFVQAaKTkEpCWF0LxZLkVM3/o5Ao9EwpG8K7MhXJ4tVt2kTU4rKZekdF4tT3slxiCiVVwRunQ1Ay6yXbkFtlOwDAWWHJu7rRTZqAkKFPn4hO6MUmZsJnqu2rSo9+PcyY0KCSsLKUBsMSYJH/ejdP/uig2lOKyo70HRt+ysMBC1DQNN85PlCow7/JM0ca+JBaPU/Q1FE+dX+V3YvXoDvzOB67LzkLsnTM6oHKF6w4shItcnJpQAJe1IXOROGzWcFTga73xGqv39PIn9cMFRbJz+swzVHPQrXb1PKLvao4XD2jIMyuF3lPdHud80
x-ms-exchange-antispam-messagedata: AERReoXmP/g9jiYeDAg+248pf6AszGbZLHwmLfMVnCPKvPIt3deBoSZ0LIs7s5H1EMq1f8UUOR7Ms8y6Eh6Y9d8Ua076Mf7bYlkuC9bRUWxEFSOkE1ARTYMBwC474TmiqCxqqbjshlYU43/cbPdppw==
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04327a9a-8b8c-41b0-bf94-08d7d54bc4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 08:16:09.4790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tt1g4EnDWxXOA7lP/rVF2+E6gC5n7xd1l4yRwKCJxk4lNvlVOuCAOUIemd86kqTB8LBbgNCevRXEHwriWssvOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3715
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_011614_214607_A1B5E57C 
X-CRM114-Status: GOOD (  21.34  )
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
Cc: Tom Wu <tomwu@mellanox.com>, Nitzan Carmi <nitzanc@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

++

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Tuesday, March 31, 2020 03:22
To: Alex Lyakas <alex@zadara.com>
Cc: Tom Wu <tomwu@mellanox.com>; Max Gurtovoy <maxg@mellanox.com>; Israel Rukshin <israelr@mellanox.com>; linux-nvme <linux-nvme@lists.infradead.org>; Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during bond failover

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
> Tested bond failover, and cm_id is destroyed and re-created as 
> expected [2]
> 
> Israel, Max and other Mellanox folks: can we have this fix in OFED 4.9?
> 

For MOFED issues you can follow-up with Max and Israel offline. If you can test upstream or even 5.2 stable that would be beneficial as I can add your Tested-by tag.

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

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c index 9e1b8c61f54e..8dac89b7aa12 100644
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
@@ -1272,6 +1279,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
  static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
                 struct rdma_cm_event *event)
  {
+       struct nvmet_rdma_port *port = cm_id->context;
         struct nvmet_rdma_device *ndev;
         struct nvmet_rdma_queue *queue;
         int ret = -EINVAL;
@@ -1287,7 +1295,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
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

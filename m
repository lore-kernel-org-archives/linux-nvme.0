Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D0C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 21:07:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0371B20757
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gVfwMSBs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="oDp/wKX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0371B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LzmwJUF6rYptoaU70T0WmKE+5jfEtuPex6B4R4QlMWU=; b=gVfwMSBs//GDYUgdCQHoZdGNV
	a+gChbkM7iqghXk8CJkL7vogPw0aG1ESAHLU8BCHULoitvRBvIeX3fbZ4mFe2ZUFetdyj5e4u3jKd
	OgQEWs/KrSyVJd4KpbPNKpLk53HpFRu0Xf9UvRiTTzbfyemFcc+Y4l6vPchmlVSfpf9e0iCO0oY+S
	AY1BqtoWCby/mO10jfqXRRka7MnHy2iFwxzty8Tb0mkWCEaYZrSBeuehVB3dHLNjdGeGRXczfD27R
	a/xS95KKu5Au/WSWmBFSWG9aKTMRKlbeO7N9d1M6+ZN6o5e+lLx30xHHZBySLpsTCZ1EKGDsfVc9h
	UwRBpxMLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJ1cc-00005P-N6; Mon, 30 Mar 2020 21:07:02 +0000
Received: from mail-db8eur05on2072.outbound.protection.outlook.com
 ([40.107.20.72] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJ1cZ-0008Th-U4
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 21:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbjRuQMIjJZrTJdRTOKUsEhj2VBb7is2fbxwNQ1MuskykBE2N63TwSpPlCM8OlJMK+XFDuk/5k+2w7SP+h3diff0YlTvVk1GBsdvVVOD9usHxxwxuf6DRkkZTmN79KW3dlGa4BFHSkY+dgmEYskJPo2h7/wFjAuSvovxLPloTrAMJ98d3mQLK7Ova0rXW7ME3De1k0cPMvN8mMSqaDFYG7rodKrKxEIsV/eJIVis6YOObli53At5YMqtksCASj6fDmVZLSyW1gz1jLNDxtAwNzpADS5UyuE6uanNwWLzRn/YePyvselaGQFTQSkIz8jgfLypjhF1yu3K1gEWI7OYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDM5ko8bTEgMo3Uol3haC5sdvASLz6SsCL2NVHhAF4I=;
 b=EOk4DNh0jOi+EZmod7e2e0mOp7lgMrHhKm/4wWt58fA9W8nmKPeAWzjty1Re06emydMpyopVrhJ+MXhBCDQdPZqEj673t2eP9m9Jz3pXdElJ1ZaEaa9KkHfasTbbNPK6bvP7nIIg6IkPMX4H4RhJmpiyMpho3tnwYv1v8rDwOBpreZaVZNbOVPbH49a6qG+40QSsiVPyLayz/Qlf79JyLWbRLZDV89A6jUpz8VYsGF8dHkaJll20WNXvWEnohdp1775OLBGPqppkc4iAs+YpCIoQ8e2EPWYhA6OT4+fhQX/+JByzzDHNniYNmpSZxuW3Q4sJ4nz2i/hIST60/2VCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 193.47.165.251)
 smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=temperror action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDM5ko8bTEgMo3Uol3haC5sdvASLz6SsCL2NVHhAF4I=;
 b=oDp/wKX8IOEWub12ZcClHw6emwRCZAfzpOxJqeuBKTLZEST4V0va9/28C5f+oGqWHg9deJvI/qspdhFP8IOChAHEj5DyyjiA6X9+qcU/ETLa7EX7Yk/4xgQb17sp/r2jn0jVWtgTcdANyWmaJmXWN3Zr4IOvQ4kbsrzK+EfCPlA=
Received: from AM0PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:208:122::29)
 by AM4PR0501MB2660.eurprd05.prod.outlook.com (2603:10a6:200:66::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 21:06:54 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:122:cafe::73) by AM0PR04CA0016.outlook.office365.com
 (2603:10a6:208:122::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 21:06:54 +0000
Authentication-Results: spf=temperror (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=temperror action=none
 header.from=mellanox.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of mellanox.com: DNS Timeout)
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Mon, 30 Mar 2020 21:06:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 31 Mar 2020 00:06:51
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 31 Mar 2020 00:06:51 +0300
Received: from [172.27.0.23] (172.27.0.23) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 31 Mar 2020 00:06:26
 +0300
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
To: Alex Lyakas <alex@zadara.com>, Sagi Grimberg <sagi@grimberg.me>
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
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <61a09250-1675-689e-0ca3-4d39004520d9@mellanox.com>
Date: Tue, 31 Mar 2020 00:06:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [172.27.0.23]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(63350400001)(316002)(4326008)(36906005)(16576012)(2616005)(63370400001)(82740400003)(54906003)(53546011)(70586007)(47076004)(31686004)(110136005)(356004)(70206006)(31696002)(107886003)(2906002)(8936002)(81156014)(81166006)(36756003)(26005)(8676002)(336012)(5660300002)(478600001)(186003)(16526019)(86362001)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2686468c-cda7-4a14-1189-08d7d4ee4568
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2660:
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2660112EDBDADDE1B7952A68B6CB0@AM4PR0501MB2660.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsJwz8WlGFIRAINAIHC4sIxt/7rxIBg5cLYbiWt+WVRaaRSFfZCVrIVKc5pcbarr0yhSm5VpBCOc2P1z41iGgD2DzeaU5cLFRFoJ258rKYP/QAAQ0k9uY9Vie5/GcxqMcWVyckgIz7uAB70lgClPfbY9xpbHlJm/SYj6Prgn8hwbRSWPcY7gZ2g7LY6gTy47rk/u4t7k7T4t19P/DnzIFn6gzEubNH/X0mAtAJUmzZbW032f7ybXA5xLOmzRpMA1z5fvOualOra2a0CAaYzxOW9kLgeQYAKuJvesbBMLRodw0jjGV1UuafMLMJd4bfOk01Qo/ywKRcjCc1panviTT/Wey+G6NsRC+0aefW0Sok3s6goXdlSwXcFxvh4ohWPxyHx8mIr6vzo8lmG4bHRRNUpgp7H6BATvm9KUCf0IbzY8HHvOufMF/Zum0OqIpjr9h9Ve4lwmlPLVbLNZ3+BF2EhmeosNODT9fFac+IwLuGe7s6YUAkf57wATThACh50aGpvMu1anuaYPqjNWlDmScZ4dzWgWss4WqB+qoHItCmg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 21:06:52.4995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2686468c-cda7-4a14-1189-08d7d4ee4568
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2660
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_140659_976090_AA54F7AB 
X-CRM114-Status: GOOD (  20.54  )
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
Cc: tomwu@mellanox.com, Shlomi Nimrodi <shlomin@mellanox.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Israel Rukshin <israelr@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/30/2020 10:02 PM, Alex Lyakas wrote:
> Hi Sagi,
>
>>
>>>>> Hi Sagi,
>>>>>
>>>>> Which kernel this patch applies to?
>>>> its based on the nvme tree, but it should apply cleanly on upstream
>>>> 5.2...
>>> Alex, Max? did you retest this?
>> Raising this from the ashes...
>>
>> Alex, did you test this patch?
> Raising from the ashes!
>
> In short: this patch fixes the issue!
>
> More details:
>
> This patch doesn't apply on kernel 5.2. Moreover, I believe this patch
> is incomplete, because nvmet_rdma_find_get_device() needs to be fixed
> to treat cm_id->context as "struct nvmet_rdma_port" and not as "struct
> nvmet_port".
>
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

Alex,

We first need to fix this issue in upstream.

hopefully we can get to it soon.


>
> Thanks,
> Alex.
>
>
> [1]
> diff -ru mlnx-nvme-4.7-orig/target/rdma.c mlnx-nvme-4.7/target/rdma.c
> --- mlnx-nvme-4.7-orig/target/rdma.c    2020-01-15 09:58:59.000000000 +0200
> +++ mlnx-nvme-4.7/target/rdma.c    2020-03-30 20:49:49.932479383 +0300
> @@ -191,6 +191,7 @@
>                   struct nvmet_rdma_rsp *r);
>   static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>                   struct nvmet_rdma_rsp *r);
> +static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port);
>
>   static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>
> @@ -1544,6 +1545,13 @@
>           nvmet_rdma_queue_established(queue);
>           break;
>       case RDMA_CM_EVENT_ADDR_CHANGE:
> +        if (!queue) {
> +            struct nvmet_rdma_port *port = cm_id->context;
> +
> +            pr_warn("RDMA_CM_EVENT_ADDR_CHANGE: cm_id=%p schedule
> enable_work\n", cm_id);
> +            schedule_delayed_work(&port->enable_work, 0);
> +            break;
> +        }
>       case RDMA_CM_EVENT_DISCONNECTED:
>       case RDMA_CM_EVENT_TIMEWAIT_EXIT:
>           nvmet_rdma_queue_disconnect(queue);
> @@ -1598,6 +1606,8 @@
>           return PTR_ERR(cm_id);
>       }
>
> +    pr_info("nvmet_rdma_enable_port: created cm_id=%p\n", cm_id);
> +
>       /*
>        * Allow both IPv4 and IPv6 sockets to bind a single port
>        * at the same time.
> @@ -1620,7 +1630,7 @@
>           goto out_destroy_id;
>       }
>
> -    port->cm_id = cm_id;
> +    xchg(&port->cm_id, cm_id);
>       if (cm_id->device)
>           port->node_guid = cm_id->device->node_guid;
>
> @@ -1640,6 +1650,7 @@
>               struct nvmet_rdma_port, enable_work);
>       int ret;
>
> +    nvmet_rdma_disable_port(port);
>       ret = nvmet_rdma_enable_port(port);
>       if (ret)
>           schedule_delayed_work(&port->enable_work, 5 * HZ);
> @@ -1707,13 +1718,14 @@
>
>   static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
>   {
> -    struct rdma_cm_id *cm_id = port->cm_id;
> +    struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
>       struct nvmet_port *nport = port->nport;
>
> +    pr_info("nvmet_rdma_disable_port: cm_id=%p\n", cm_id);
> +
>       if (nport->offload && cm_id)
>           nvmet_rdma_destroy_xrqs(nport);
>
> -    port->cm_id = NULL;
>       if (cm_id)
>           rdma_destroy_id(cm_id);
>   }
>
>
> [2]
> Mar 30 21:57:48.030761 qa3-sn2 kernel: [95220.661707] bebond: making
> interface be10G2 the new active one
> Mar 30 21:57:48.030789 qa3-sn2 kernel: [95220.662003] RDMA CM addr
> change for ndev bebond used by id ffff966432c63000
> Mar 30 21:57:48.030793 qa3-sn2 kernel: [95220.662007] RDMA CM addr
> change for ndev bebond used by id ffff966a6ee85800
> Mar 30 21:57:48.030817 qa3-sn2 kernel: [95220.662010] RDMA CM addr
> change for ndev bebond used by id ffff966a6ee87400
> Mar 30 21:57:48.030821 qa3-sn2 kernel: [95220.662012] RDMA CM addr
> change for ndev bebond used by id ffff966a6ee85400
> Mar 30 21:57:48.030824 qa3-sn2 kernel: [95220.662015] RDMA CM addr
> change for ndev bebond used by id ffff966a6ee83c00
> Mar 30 21:57:48.030827 qa3-sn2 kernel: [95220.662017] RDMA CM addr
> change for ndev bebond used by id ffff966a6ee84c00
> Mar 30 21:57:48.030829 qa3-sn2 kernel: [95220.662025] nvmet_rdma:
> RDMA_CM_EVENT_ADDR_CHANGE: cm_id=ffff966432c63000 schedule enable_work
> Mar 30 21:57:48.030832 qa3-sn2 kernel: [95220.662069] nvmet_rdma:
> nvmet_rdma_disable_port: cm_id=ffff966432c63000
> Mar 30 21:57:48.030834 qa3-sn2 kernel: [95220.662093] nvmet_rdma:
> nvmet_rdma_enable_port: created cm_id=ffff96658fdab800
> Mar 30 21:57:48.030837 qa3-sn2 kernel: [95220.662120] nvmet_rdma:
> enabling port 1 (10.3.3.3:4420)
> Mar 30 21:57:50.266755 qa3-sn2 kernel: [95222.897752] nvmet: creating
> controller 1 for subsystem
> nqn.2011-04.com.zadarastorage:volume-00000010 for NQN
> iqn.2011-04.com.zadarastorage:2:vc-1.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

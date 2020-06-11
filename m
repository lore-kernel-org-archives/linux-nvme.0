Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B9C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EC620884
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PmCzQjA1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JXeYJbwE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xWnc5/Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EC620884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=j63GvfCfYJBFxcxtLR5YwderLw56t3lvhQzx7/4cUyM=; b=PmCzQjA1x1GiZZ
	fqHM65yMgJ+fuGdtRiNA3teZr44DIpyy0GDwfqzLz/40Tl6gfSarYILqmvM7mAXWzovkidyNmwxjM
	BvQIT4JS81HZl7fJnVFAmPrii3KpOvTrTt88uOEqpssQtwaq3PZpRtUJfD/S++/AFLPIzNs/RNn4o
	cRn/gHCxS5+PG/OgJxYXRApPLiol3F8HE+E6b/RimpbnxpZodoTJwlo81k16U8YOh5jce0yoJYE3h
	7iBLO2Qb7kLhkEyMqSr7matK3uC/59iqTYz/RtOZuZMhG0sQbDLcLixwlTvF1/wTwT6+GqvkeZk/l
	XdOcp2apYK4nD8iquWuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjWso-0002cv-GM; Thu, 11 Jun 2020 23:45:18 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjWsj-0002X3-3w
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 23:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591919114; x=1623455114;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cPTgLV5CC9NTl4nebD3xyo8aaz2Hwve8wWwj8P6Rj2A=;
 b=JXeYJbwE2P3QcyGh8jdXBbdYqHxpfm8wns95yeY+ctM1yEUZoiaw2iXL
 CuND0lkNSnCoKmcEXY7/74t0xdexAwMeYNFMc85nXz6xEKlbrOzUmn037
 ND0Ia/m0GxkgZ4mjOF+iWRl8e2igSHWmiPBsr0yciuum64mvBNgHsZ48I
 VkdjcbFc+udUWGy8yu0GaEbQaTzDHTOH1gmhjwRXe+U24oRO2KNSjjbG6
 uFOBrg9KiYzMgme1ssrLaCJeh/OyqJjRbvZAA8frjeWyyOfSNtI5jmSGg
 xZdth+t0XPLSmc96JFogqN0T2A4L2L47wUAfXXobNukxzCRBFb4ybryLa Q==;
IronPort-SDR: 0bNYIaWd2fCdD/22Ewy5GJjA9xefX5xy9Ot/QEpHuOqDGWjyNOADhzpUZLBL/PShcaUjaZq7c2
 Z8e8gQNiHDLY3R3wlO5CzEVy3VIEObkvFZ3Iz/wEkIY9Xop7fHpC/Usraddm99zTAghvSKf5+F
 YG8mWVtssSrk4jbEjO/iDPKLbYJJ6eJHVbKHxJ83E09LeJsVqM/4kt+qSjbtTgPOP4B+44SKDd
 WMIP0crMlkNHvPE79pBZqHR0zjJpZVUkgfvpGHcyO3oeOczXORjacFPCDbYFpM6wu86x8kYhMs
 Euk=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; d="scan'208";a="144102326"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:45:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVLdKv37OWf2Fev+B93bnOLtihliyKfU0rAE+wLwXPTSeAt2XhDgIpRog/1ECGo0jGMDgc5uXB4dCjr/viFEjKhJtFKFQmfvjlrAkbdldzCeSe21q01VhEjLiphsv73zgKvXQovzGdLQJ6IFYjQt5USFbkszCzTpk/v6wY+QRDvMh+QMuQIapzBTQclcmGyMSZ2QDk8jJ6KZakQcXJBlyUrsewZG+ohVALdBCvxElul3VSruAOkr80lVbN/NYU8HrP4XFlOJ8i8K3pFftA/tFXgBK8dbdBf2sVUhDuhdgUgPftVL73SnnNdDchssjVIlOmZwdBSIWmGAO4s3wTmhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEc40JkD51XLAAOw0tSEu2Dei9rEyk/UV18o8I14lqc=;
 b=OFlFU5wTKO2Eqp695WnerqOPOWot5RP7xeFZrgwgWm+JTB3EW0BOPL4tp2evK5y3wOfp50jbOIXBBKyKgWvpF2qmkicgi1Jx+3SHCipOoWqgSWi9nRthFvxVG6LT3FJN50YvDJJ0PhudGtD05iXjNbQA9j8URjx/KTfsQ3CnBq7AHPivTu89lrgvo4odAFnw2mRq9Nt7cvuO2z0J7auYA6naWGbsAy1aLuBvqXL+4+quwGr6bGrDOhGHu/SByjRvuE2IGSu9K30x+i2GBJtaX2BGXZ08nQ2zL+/V/vJpp6WzHiO4Z9jz8Jg8ERZOKpsy/VW7C/zqZ7k0rVjHPwQ9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEc40JkD51XLAAOw0tSEu2Dei9rEyk/UV18o8I14lqc=;
 b=xWnc5/QyCXKU0euFfkKmHXksp340IYf3QwDdRGbNfYkF2C4pBuga+j1C38qIx/ZWCFn+dtifdxFCP+6iywcQlHrPGhUhWB3Y+PdsrEdmpxjgab9KZ6oqLCdVtPLMt0Ow+R9dGY+7VYZ80FnljaoSYmdKKwW4JyqDvj6uYy3KNPg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Thu, 11 Jun
 2020 23:45:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:45:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v13 7/9] nvmet-passthru: Add passthru code to process
 commands
Thread-Topic: [PATCH v13 7/9] nvmet-passthru: Add passthru code to process
 commands
Thread-Index: AQHWKhRpuphoSoz88kOAfqTRprM+0g==
Date: Thu, 11 Jun 2020 23:45:10 +0000
Message-ID: <BYAPR04MB4965379CE8694F52D684993386800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-8-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4457c2b-e649-44cb-b625-08d80e617adc
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-microsoft-antispam-prvs: <BY5PR04MB7122ED35404176B527E391FA86800@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/oAlTREwX64c7RffJBYif0WBg6ldrIx8n1VBARMkA7at3TOnrKE+tpi1+L8duKeDNsIL+zZtD/JqKKwZP1Dp2xDpoCNVCNIbBuSntQxr4K7Av0PQJgpsJUi+ZP7zPgO2y3H7MqF5Pb+etDC/xZ8UkllN9Rz2QbR5DHn0rBbpbcseDeHGxT5a6YjWu9rBAlOuba3hdhNUlByt7T2l9FADMsAlwotCSwNB/LE1/nootc9Sk4Lf+tUIK5H9JW4aZSoJcHY1YFnN7lzqkHzAwx8iX02O0dtONIkyk+5Tqpo79chhen3DoMqq5y5uAi/dQwb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(66556008)(8676002)(8936002)(76116006)(66946007)(66476007)(64756008)(2906002)(66446008)(33656002)(86362001)(55016002)(83380400001)(186003)(26005)(6506007)(71200400001)(53546011)(9686003)(316002)(4326008)(7696005)(478600001)(54906003)(5660300002)(52536014)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nern+YkBdfYGsMDmmvmhOBG26z9YggaoeUUjPVHcRifgTikahnqHXdHtQfJVuhnyQLTAjvpIgJ/S+9QKDSAIePYvlY4Es11KJQjTqs6MLM0+rCt58qhKSjdSruWwpx1KJyu0FFcp5Jba9Rr9gZis0HTEd8j0EnMOiTVMItvA16VuuAA9kfPbUL8JltT7QH+qFJMU20qUOnWXFrj2uYLP2r1oEFcbIoU7hbve6aVXgey24CShLrHle76Vnwe1g1Axtsjciwb8Elyikdl5QdsYE61CUeczUgmPfrz2vZsmmZh/gNtUXa8T41neDaXi5mjODc58AMQ2jQdbynlTO3lrym+nFuh+beLqBM7wyL0xXaoErwTIqKhvZRWUNmSEDIA9zzksZ68GwKN2P63+jJr/xS8lkc35ePOmyZFoGYfDQyObivGHkGm5oPuxe1tmJnh1Wxgl27eZVW/qGx3Qu3qYsL0oiWXQUiuZh6IC6iFmHmo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4457c2b-e649-44cb-b625-08d80e617adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:45:10.6887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA96pe/ru1glYskqQwM9cMTKfuFJo0tHCkPutklJmlE3JhvaPNwenSO9kv1jvhp/xUfr+sybDlBDKJEo6dV45hTYcjE+/IxgJ75Z/m7wIDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_164513_244935_DD67DD59 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
> +
> +static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
> +{
> +	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
> +	struct nvme_ns *ns = NULL;
> +	struct request *rq = NULL;
> +	struct request_queue *q;
> +	u32 effects;
> +	u16 status;
> +	int ret;
> +
> +	if (likely(req->sq->qid != 0)) {
> +		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
> +
> +		ns = nvme_find_get_ns(ctrl, nsid);
> +		if (unlikely(!ns)) {
> +			pr_err("failed to get passthru ns nsid:%u\n", nsid);
> +			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +			goto fail_out;
> +		}
> +	}
> +
> +	if (ns)
> +		q = ns->queue;
> +	else
> +		q = ctrl->admin_q;

Is it possible to avoid explicit if.. else in fast path given that the
condition exists and we can take an advantage of that, how about
following ?

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 9e71fdfbdbb3..4f8e022d254c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -84,9 +84,9 @@ static int nvmet_passthru_map_sg(struct nvmet_req 
*req, struct request *rq)
  static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
  {
         struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
+       struct request_queue *q = ctrl->admin_q;
         struct nvme_ns *ns = NULL;
         struct request *rq = NULL;
-       struct request_queue *q;
         u32 effects;
         u16 status;
         int ret;
@@ -100,12 +100,8 @@ static void nvmet_passthru_execute_cmd(struct 
nvmet_req *req)
                         status = NVME_SC_INVALID_NS | NVME_SC_DNR;
                         goto fail_out;
                 }
-       }
-
-       if (ns)
                 q = ns->queue;
-       else
-               q = ctrl->admin_q;
+       }

         rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, 
NVME_QID_ANY);
         if (IS_ERR(rq)) {


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

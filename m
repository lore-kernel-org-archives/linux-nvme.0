Return-Path: <SRS0=bcs0=GC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131F2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 07:11:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DBE207C8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 07:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DBE207C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ig/XdntvlkMqDSmESEXHod4XcboiqWo+gBOFPonRX84=; b=poVgPEFj/llBbtY97I9CZ2RFb
	390IjbvdeWKZI7jPKL0+PjkA8QQCqn7jVTrOSqVfLeZiaOuQUwYRBWaOSMhj2KtiIrdjTc5uo/0TB
	z0d1+FPDBV7bg0bnBtrxSipTAgt1Jb2piAMojiftzfZjIcwomXT25ndrfOd9cCZq9Ba6W79dzvx0W
	kgjIV5J1I+7h6WLwjV371VVywassJUoXT2qq8VdLqA+r+KOZeiZDg7IJLk0fKqzYGlPZ6enJcBy6q
	oFmXArCYJe9XNvNYmjWAaKcV7gh8ymi1FuuTDpqkKdYGyQhQIMg4Gzi99kiYScQ99+5umocvkSHTK
	MSEVXiOAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kuVdP-0004lI-T1; Wed, 30 Dec 2020 07:11:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kuVdI-0004kU-Uu
 for Linux-nvme@lists.infradead.org; Wed, 30 Dec 2020 07:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609312256; x=1640848256;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=x8BISiVLm6v+TKS48FmpE0WD0r3vyfLixynYPCi5J08=;
 b=IEvHXKSqsbGuhf1FTtYaXkWgl1w/srg3UeWnXZ11ZhSDnDqtaVYiPbyL
 WxWXEG2nBiDrnjCOc9CeYBvQEbuSKFZXTTVATC/+mSES97RP7egjp+ykJ
 X+IKhoShEommG7V4bEAkzpHBDlMnOw+ewD1SR6NqR7otOIWQQ0UFu2Kmj
 yWfR4IiYGbctp96JVwG5VOYElSq4ewYTENvG1bVDO9PB5DiQ1y8Kb5Dr0
 61jKWJDWXJBIVDeSnhiaNF5S2id4LI1NFjH6jhMild04tXZlvMGKmM3z6
 jVVi5JMvtB2Iu1ODqqIfdwaGKKCWd6PzNksfNWIU1qDG7rHFj5ieGfrsD g==;
IronPort-SDR: qo/q3mD8WwQHKwsqTMmCfrZPIhaG+xMTP21hxa/dzJn7pXsmU3F7TvCYrO8IdzXaOPHLlR7+qT
 DdEKhwOHzS4jrzYdTqU2oo5dIrViqDE5+ysZ3enyeTvhrhhPbZ7nJSuSblTS9dwY4raqMCTSah
 rCkLa/RiLyVA5xNhpxN/9UR+EWn50CbpeRyNNXoDtH0fnte+tvTps6Fsua+xHhnP4+sqlJSaPq
 ay2ajtuzrA4NCRH7N1XuoLCdUwbFrIM2pB4T693opAtcDJKLbBFRpXheOMqikbuIuXQrb1j7ck
 3jk=
X-IronPort-AV: E=Sophos;i="5.78,460,1599494400"; d="scan'208";a="156295745"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2020 15:10:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esN3vAVK8NUPdJBBfeN/ef5zt0Wt67kW7Gcm2krsIJlyS9x57QWBHE8RJL/rPpDLYG+SBMtatlMq4p5uuPlZPIFkU3Wb+EGNcmr9kiz5GZlM9TanxDUfnriqllIVyrWl15e47KbqKFp6pnBZJIXIQgnQJZYe1H+UuX6UdQSADExBsHIl+JL82OtNFIPIhRtrzOi6lUzRNjV6z78D1mtO5HUxEbfWo5HjlAwt8X34NMfusXhUp8mDC1dvtkGSa/mC2ktn2nD+HXzBECQzBjCxCmgCfgaYNsTEy3yANabspxRTyGExZygemi2QKSHPmjTSvafbeeacDeZyQIn8bhpfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUipHshx4TWZ2VRUPeKQfzwOTGXrzz8EyM9fS2X9dcQ=;
 b=CXH+RxB8AY6UwxzlHMW99AN1Xmer2Kt28J+LK8eDV1yNs7JFOiq6tHVreP3y8gqMDjVVBVAz1ELcct4iieaWUvgPL9WdmiceSzOryVkr0SaMqWUrDADkcORfggF28pDWmh0t7IZJCblyfljJt9StjkJ6BvHSdP9qnwRf29gixS7MXqH/KRg/oXJqhGDdGv0Ht/6r2vMQmKsayrntGUNIvCEspHtSmHT/oeho+9fD5akytS5LHDiGY1FBnRBYgnbT+UR4XtYsl9xtDq5AS5GUxYNz/1vsOviE570sjZn9/6l1uSeWcD1NhwyPx/7dGHnnGDcKiDmIGe754fnJnVpT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUipHshx4TWZ2VRUPeKQfzwOTGXrzz8EyM9fS2X9dcQ=;
 b=HN5U4Tk07ORJViA9Vf4Q9rk+YrlMzXW+fb5cKTSSyjsYizAiP5kHHDx9kzJYZBmM3/U3yKIzHiNTKVLHbQRSBGBWbAexCKn+jHO1CULGwUyJy8kchMsy/M8zYQw0lxlfLRrYghCLkP5nnvKgfjD0BifqUHaZftZOuDEhyXU98uc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Wed, 30 Dec
 2020 07:10:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 07:10:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>, "Linux-nvme@lists.infradead.org"
 <Linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: unexport internal function symbols
Thread-Topic: [PATCH] nvme: unexport internal function symbols
Thread-Index: AQHW3D18NU2j2w1ccUqMPL+fs/YsMg==
Date: Wed, 30 Dec 2020 07:10:49 +0000
Message-ID: <BYAPR04MB496508D70A0F3121191C0C2886D70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201227103831.22319-1-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:29f7:6501:bf41:2460]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1e2ae54-bb74-4a06-f8df-08d8ac92096e
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB442409D50EE8279B5634E19786D70@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzJEHscCBY0qNCwk1oZnyXoa/loFx6F1AEUpez1CwpdeLluIlf/3qh+zFB1vuA+8oUGpXoXnfgsPdz7H2YobgnpuzlE4TbgV7223zzRTCAudgUkuQjr/u6h0YvXXDVmg9/NlEf6bTgV51MgE3y1qG17aFPEB1TWlpCJMzS6OeU10aFF0RzCrB8nNejCrAdhEtYBN6zJgin1p83vSB1soLoO7+8kIrh937Cz25E40sFisf0o9fj7gVkc2uffsQ2iqU5UYRdOV8LC4cEcyAmXX+gUtaJfjZIWrFBY0qVQQAODsAd0n9BSWVdYjsWnNtZQyUS6kVkfn5nhK/zAL0yaCNgH8y12ED6V/yRhA8QSrbp8ga7hw1aDXRpW02qkIOEG0DSwps4grz+I+V7WX2hJ2Gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(66946007)(5660300002)(8936002)(52536014)(2906002)(86362001)(8676002)(186003)(33656002)(9686003)(4326008)(53546011)(66446008)(83380400001)(71200400001)(6506007)(66556008)(66476007)(64756008)(7696005)(55016002)(54906003)(478600001)(76116006)(316002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Yo5JZwGCSrk0lrLhkkKLIPxCSR+ynpxsQv7qYL+PwhxXl51Z889nJd9CM/rP?=
 =?us-ascii?Q?3SpE4AcdfXgQR009kLslQuQAOhcdpcbPrVQFfDCsJ/Mqc3dBYPHw+eeiHkRo?=
 =?us-ascii?Q?sVBMsdlcjSkVg7tQTXm0OIt4eMdyqZVbMi+goFrUXtisl/DciC8wS/1PAXzv?=
 =?us-ascii?Q?+idGlYMtcCCvLVNyLS7IlsNqEiYz6aPf/XxUhz7U60j8A8RLDmNznlyuV5YC?=
 =?us-ascii?Q?NIdTllEBB036H9IpAR+v010FlHeMsfB2JoQGD2a7uzJir3TveDrpzCD8p6bC?=
 =?us-ascii?Q?lKdzbrxRSpnF0L1OcD5dsodI3V1hI/NAGRt1T7OO5LZbAC9F+iEGL9dAzqDC?=
 =?us-ascii?Q?ru1tg82yOUNjGRrJznqNUP/pk6zb1OlOzdKcBrY4BwI8oCHDVcr6dA86FqMY?=
 =?us-ascii?Q?OvkJHzIdDufa3qKanZwSz5nlHQagt7PKK9Eo/g745h6vkEWc/EXkKG2uRwAQ?=
 =?us-ascii?Q?bgkOMtAxRucaeiw9AFp3RZMQAAnAGv9uWqY0kdKnmK+KDhLim3g6bUF+sCIB?=
 =?us-ascii?Q?GnKWleTjvH5RpWLj++53E1kRDBZj0pAlOgdVRFLk1ZtaZ9CktfC6w3hBr9fJ?=
 =?us-ascii?Q?nHaicRUtirPx/2Sqt0IOnsvttweiziSLPJrXnk4GaV0GFh/++SWG69+Jf8b1?=
 =?us-ascii?Q?kR+gye5xBfLYfmqOQDwUiSd2EZzazYjxwJzfBy8S8yN2PYqfpLrBC1TSl+BZ?=
 =?us-ascii?Q?XhSJTQ0YSKdYVwX/mdFaOwpTsZJzQzN4Z23Y/B57lDmFmjX1aEf/hdHDycay?=
 =?us-ascii?Q?mxqOJvOiulPlQz1v2o+kES1R7P23Y1M2tNeP6lC+bRA0aOmeW1nJ9Ry/uToi?=
 =?us-ascii?Q?YEX4pMZGxGHqJyQHn3M9pJsUCptHp41G7YvrlRWxOvthiss2Bpgu/J7qeD7L?=
 =?us-ascii?Q?asL6vVCC0T09yOsnvkuAKMORTX+6ximDvrLRwog1lM2+5OtOGF/NkvKB03NO?=
 =?us-ascii?Q?CEIg2/XsYbEvhW685UvFAhqUqENBWo6VfDD+zDBFxL+6RzCJEVWN30ans/8E?=
 =?us-ascii?Q?D4M4d/QUgrIr3PU/8SV/HOPZDC8MUd8QKDutMpVNjnaAqFfuUNyUeQm6QF9W?=
 =?us-ascii?Q?7EyBYGxI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e2ae54-bb74-4a06-f8df-08d8ac92096e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 07:10:49.5367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0yREIuv/hBqgBLD/hxsKuS8QVE+e8rm8Y8d48cDEXITrrCNSK2BH4RnCLVbS426XvfRRhvgZDin4LGLwaHfpNiBSiXzMOGvTn2CuROy3xY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201230_021057_303906_3771052B 
X-CRM114-Status: GOOD (  17.22  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/27/20 2:46 AM, Minwoo Im wrote:
> Unexport symbols not taken from other side.  This patch also make those
> two functions as static functions:
>
>   nvme_reset_ctrl_sync
>   nvme_alloc_request_qid
>
> This patch has no functional changes.
change the commit log to :-


There are no callers for nvme_reset_ctrl_sync() and
nvme_alloc_request_qid()so that we keep the symbols exported.

Unexport those functions, mark them static and update the headerfile
respectively.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  drivers/nvme/host/core.c | 6 ++----
>  drivers/nvme/host/nvme.h | 3 ---
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ce1b61519441..70a63d7c1d02 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -179,7 +179,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
>  
> -int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
> +static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
>  {
>  	int ret;
>  
> @@ -192,7 +192,6 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(nvme_reset_ctrl_sync);
>  
>  static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -578,7 +577,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(nvme_alloc_request);
>  
> -struct request *nvme_alloc_request_qid(struct request_queue *q,
> +static struct request *nvme_alloc_request_qid(struct request_queue *q,
>  		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
>  {
>  	struct request *req;
> @@ -589,7 +588,6 @@ struct request *nvme_alloc_request_qid(struct request_queue *q,
>  		nvme_init_request(req, cmd);
>  	return req;
>  }
> -EXPORT_SYMBOL_GPL(nvme_alloc_request_qid);
>  
>  static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
>  {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7e49f61f81df..9c4fbfe44c00 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -610,8 +610,6 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
>  #define NVME_QID_ANY -1
>  struct request *nvme_alloc_request(struct request_queue *q,
>  		struct nvme_command *cmd, blk_mq_req_flags_t flags);
> -struct request *nvme_alloc_request_qid(struct request_queue *q,
> -		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
>  void nvme_cleanup_cmd(struct request *req);
>  blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>  		struct nvme_command *cmd);
> @@ -630,7 +628,6 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
> -int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
>  int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
>  int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>  



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

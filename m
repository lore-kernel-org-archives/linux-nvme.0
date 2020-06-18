Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2682C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 16:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A55204EA
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 16:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBJX/odp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZW6NqiK6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vr+6Wtku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A55204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eikW5Ha1eBf7HkivdTAqrmZH6RKAhZXAYdfSvsW2oN0=; b=sBJX/odpKPPJVV
	9H+HQZKo65iDNYxXdjm4LxI0n1T69lKEWAiQ7ISwgpOozAV4gb9QACIgv/vF6iiqgUo3o9zkV7Cs8
	v4/yeKIjOJR78axlthASG1kWCuQnZlg1ns9CtSestgRBYt2hzB7vUTraiqHssQC/fcujEmPYdA8h7
	1m3NctyD8f2RvBhIEY7BInrceXW1mR2ksAHomiMkYgDXRwn2jrxYE0CBV3IWGS8WFVP503OR60Yg/
	v0YnNy1jG/+UxyfNkacUZjN7u+Ot58zFRBvyFVTSMvo8C+3ZtAbtf2AhwJFcPQs5VO5ffQ3ZjE1/f
	w0JoRPLhzd2dCHcVo3mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlxCB-00073S-Vh; Thu, 18 Jun 2020 16:15:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlxCA-000737-09
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 16:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592496918; x=1624032918;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=T9Go1tBRFlbYxvoA/7ZPjgwNSoAgpX7j8vyD/TaDaRI=;
 b=ZW6NqiK6wBGne33S/DaywHRj//dk/eP7x8n5XhAFtq1YG8S9l8GX9QFi
 oh8hvgK3DizKSN03nmbG8JjMf1xDGJMd0fyEWE7pVNo5vdOwcc09q1FSW
 p7aeq7sapdW1YPmeiotZfoyXOLwIaNi8CEjgLZIbAD6x15xCtFT/J6DS8
 MxXcx2et5kPDBP92COz9O9ZdAq3l+r4Qcsm8YZflNkMvxsTXzhdAwPjrL
 NN0LEib3pxOFM/2X7QnOKqP5f/fMFFDiEe5+W+HOdEK615nABAkvWYgqS
 m62zbgwXFzhyvTlorU+hoONBqOK/KvrvCUNIco0WfpMEBOBeC8iGnKydE g==;
IronPort-SDR: zyBnpfmEbOaEJ5Fddq16jsRK5qrz2Vjw3COJHzsJED5qp/4o/9FPyNpJYy/Jo59qHXo21FhICR
 oxR/DhCh4vkZ/3zJiOVimobY0R5kviw2uV99WU8KRQzejSlLLDJXKmhrENmGjceGoNiURX3paE
 CuKuSus5c7m2ECxGNNmOypvzE+tmRpQg7f5m5rIXqB4mnb8G0/YaP2jvx+/tKdVsAutqyNLDis
 JWypwNNYMLC/l6dfVDKhv+eNW/MuYiASxwqpcFIhNtLHrFrSgT6udTrZLyHFeYA5nTE262B85A
 Isg=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; d="scan'208";a="141716865"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 00:15:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGdixEnlELd8IoLDrFUF7Hzjh7sQ4BZMaX1pM6Uz+xJWhPs/FKeXC9wwzq6aRKhKKwaN5Bp8ofZER1BdLwOXt0o72kqc1hVyOG0NCkzaQx/aQb5QM6YuCrimfXCucrORaeD6lTGFDOOS2+Ap81pq+h9kTiBc/34I2mm/3NBvYooHrEgsiaEavdX0GeBrawrYAFb3TTKnizIvI1Xqbl1lVvQK9ts98P90uKrGMISpTU+jbLUT5Suf2t6WJmUh2m1itzo0iKJym4fUVWRasn8mXqL3RlE/ZqYpvs/FRGo4t1iFl9y0lsn9kcZ+RUF8l/ieucvQjn4ACcuLSotvZ+3Aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xINXSwm8o0vv86rdNa50AYejYTYw/Lc+I6nkRl/HuwI=;
 b=Vtl1BFO8M+xw+B7wylUwo2HWuX1FeaHyWUZd6uYOc1dhOQKaxcNXBXvtPFpbEaywbBK9ybvOHsNmq3TFMrH8xQdvDexL+RbKEiGDNQiNluCd2vCqAUQHNLBZM6GsuduTug2K/CymV0qixlOfzFjepYMeQXujUH7Q+0fVBR8YRo2gPJUG5J4BRzfMefMZsnH4gaPIIH6q50uToAKUWlkP37QMlE4dTvbGAo5lbx/bWf7+lkwajobDFOyiOft3r8CFplKwmbEtyNCOcCgvB+zJv5w8Lp9RIZq51yNl7ePfrFXwr4r+qMCoRZchmj+iykyjjoFPtqPWxS6lFzo9kMg8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xINXSwm8o0vv86rdNa50AYejYTYw/Lc+I6nkRl/HuwI=;
 b=Vr+6Wtku4f4vroFLhD3mKC5cqNpG86i6y2dATA5tJmthSaLuAZ8PiFscnd9kq3M7Sf79IDVpLjzKGY/b46tNXnZ41CqPxescNwqXZecrQUNnSKVhGwCgTSEYFfs7yvrKowchcBo7yAba5FIBU3WhFp+kFSagffKbbBWrnU/k0TY=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB5941.namprd04.prod.outlook.com (2603:10b6:a03:109::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 16:15:13 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 16:15:12 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Topic: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Index: AQHWRX1ZbrDHfOtockWlJJLIW+DNgajejEuA
Date: Thu, 18 Jun 2020 16:15:12 +0000
Message-ID: <20200618161509.GA1059668@localhost.localdomain>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
 <20200618143241.1056800-2-niklas.cassel@wdc.com>
 <BYAPR04MB49657026BADC613CA83CB896869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49657026BADC613CA83CB896869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b289574f-8558-4e43-dec1-08d813a2c7bd
x-ms-traffictypediagnostic: BYAPR04MB5941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5941FF60DD91B08AD230B71DF29B0@BYAPR04MB5941.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+yT01u3OndbYplpfENVguyJ1yqT3MHR9+Y5iTzAixUESVldfG/jzX94x5a5tUcoU5dOQ4TABX7UeEbMdaYkWGtoCZGnp8cncOG5cxgWqoVUT4dd1N0psjrvdYdc22hdnJdm3de/05lxZdTsHBJcwSLTGkmpUfBlmHtUjHiFRQoQw8PMbZbRT3cgbYowu0iD0ZdOGQvR3CP4wZ3VF1SWIR4KUlpWxrOux95F7FBIKTsB7BFZrTr3Xv/FJi8AJCZNCg+T3J2QxvEBrbrza32HpEqrohevmzUzbrj8D5DIbwkk9oW5FzbbP9FZCogKjRYG6vRW9J3A9nbndIFqGpHrEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(8676002)(33656002)(4326008)(71200400001)(2906002)(186003)(26005)(1076003)(6862004)(54906003)(8936002)(66946007)(478600001)(9686003)(6512007)(83380400001)(76116006)(5660300002)(6486002)(6636002)(86362001)(316002)(66556008)(64756008)(6506007)(53546011)(66446008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yT68zkUVzeE8FzauvbeoJ+pJTCYDaB5pqPhY4gVAbuw4k0TAfR/mY78RqUW04wocow68T61JANbu2i3Iv+Qyn+RlKV7aG7a8LSetMyj/ppxs73qhJ3TRYzddsZREMVoRbMYQoOsjHxy6Nnxuj/hTmi4ErT4vAxTi6Xcy7qMLuqFF8rSb2KJcN4ST5g/8k5VohOE5Jaw5ltCn2LJTvlpj/EL+HkrtyW9nOxgSYDW7OkfRGjTMNeNVRRHO/bEMGfkEV/vxvRaD+fbH7KHeH2/clVpniiVseMLGi1PoMguRLzzYY7Ux6I/hYiOUNtVlKiX5azHvCeJdrB7VYgG79HeVl/5WqoZ1MovQ6ukbAoeQEaurCMgg4ukHFr/tcsr6jbg9jB7u8SidR8pW6vNW21wmIIcSbQavGmaAp+Bkk0oUgyx91dmZ8Hea45UOl75ia7yeNMq/Ur9wa50z1vuHniFyBYlJvL+wT67M17YEKr7zPlKLF6YYXTQyYbfa2L3P60B+
Content-ID: <D101818765E6DA4EBB16014F1B03607C@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b289574f-8558-4e43-dec1-08d813a2c7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 16:15:12.8910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YeCgsDZUJgTecSjR9SLjMy4aM2bG5cF5T5KUITCv0hCj6S9+E9sxH7oT6/9nKaBO3TLe4sTMrpiR8T/tw9YIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5941
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_091518_118465_75E15BDA 
X-CRM114-Status: GOOD (  22.74  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 18, 2020 at 03:23:21PM +0000, Chaitanya Kulkarni wrote:
> On 6/18/20 7:32 AM, Niklas Cassel wrote:
> >   drivers/nvme/target/rdma.c | 23 ++++++++++++-----------
> >   1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index 6731e0349480..85c6ff0b0e44 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -1535,19 +1535,20 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
> >   		struct nvmet_rdma_queue *queue,
> >   		struct rdma_conn_param *p)
> >   {
> > -	struct rdma_conn_param  param = { };
> > -	struct nvme_rdma_cm_rep priv = { };
> > +	struct rdma_conn_param  param = {
> > +		.rnr_retry_count = 7,
> > +		.flow_control = 1,
> > +		.initiator_depth = min_t(u8, p->initiator_depth,
> > +			queue->dev->device->attrs.max_qp_init_rd_atom),
> > +		.private_data = &priv,
> > +		.private_data_len = sizeof(priv),
> > +	};
> > +	struct nvme_rdma_cm_rep priv = {
> > +		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
> > +		.crqsize = cpu_to_le16(queue->recv_queue_size),
> > +	};
> >   	int ret = -ENOMEM;
> >   
> > -	param.rnr_retry_count = 7;
> > -	param.flow_control = 1;
> > -	param.initiator_depth = min_t(u8, p->initiator_depth,
> > -		queue->dev->device->attrs.max_qp_init_rd_atom);
> > -	param.private_data = &priv;
> > -	param.private_data_len = sizeof(priv);
> > -	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
> > -	priv.crqsize = cpu_to_le16(queue->recv_queue_size);
> > -
> >   	ret = rdma_accept(cm_id, &param);
> >   	if (ret)
> >   		pr_err("rdma_accept failed (error code = %d)\n", ret);
> > -- 2.26.2
> 
> What is the issue with existing code that we need this patch for ?
> 

Hello Chaitanya,

This is just a cleanup patch, no functional change intended.

It simply performs the initialization at declaration time, which is how we
usually initialize a subset of all fields.

This is also how it was originally done, but this was changed to a
non-standard way in order to workaround a compiler bug.

Since the compiler bug is no longer relevant, we can go back to the
standard way of doing things.

Performing initialization in a uniform way makes it easier to read and
comprehend the code, especially for people unfamiliar with it, since
it follows the same pattern used in other places of the kernel.

Just reading e.g. struct rdma_conn_param  param = { }; one assumes that
all fields will be zero initialized.. reading futher down in the function
you realize that this function actually does initialize the struct..
which causes a mental hiccup, so you need to do a mental pipeline flush
and go back and read the code from the beginning. This only happens with
patterns that deviate from the standard way of doing things.


Kind regards,
Niklas
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

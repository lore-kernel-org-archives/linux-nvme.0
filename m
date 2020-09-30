Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9FDC4727C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:22:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95872206F4
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QMMgRIH/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FpP5oSaV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l9yh0Ag3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95872206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TEjyTfPgyT5DRO+ozgBv6F9Q5Yd67OBvsxZbN0TznJ4=; b=QMMgRIH/7m1CrxH7p9uCyat0/
	auJNt9UyU4I8PJBDpRJgnyLe+CfxPCUcN3wGlOzZvlimtMqyaFAV+kJwgfqpVVlYJNzVAI1/ITtgM
	eP1ylPd54vOGLDcQItog/tPBd0AsJ8u4UAXebLdBP8OMoosE5RE0hyKk3EGCe7FIL4v23IyYfiaIA
	+6kwoss6MVumqogjzm9vb3u//3FkqvQoF/vF4sYTE+vFLP2s18IYrVu1W7EpNOSP5TYJnMt2E87nv
	0YDVLOciBSLtSn3iam76ShbUPLWLlQMdHTQTPo8P65JGubXK5Ef5Fef3BUI8Sf2M9pDwhuDsnj1vR
	LWPUTksew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNPtD-00033u-EV; Wed, 30 Sep 2020 00:22:35 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNPtA-00033V-8c
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 00:22:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601425352; x=1632961352;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=M8HGfLSLBfNGoFIsO5CQk/59xB5GFR/Fb+0jZI7oVxc=;
 b=FpP5oSaVoxf62HOAKqwVKeX4rc/pOL6AhFxd0wg4bqPLRsbNoFhXMQaT
 RsZlXvpMVqB/6BuqAnCTgqnz9DSAekEK7QkB5zH++qHc0yRD8HgD6nwYg
 TCIF5EeU+UmdEGIpcnco9YUXb6tbZyQpzakVNRmiYTF37JkP8BzVlj+Tf
 0OM6VOI0bV06EBEOcvji56W60mBsj02pSuwo02c7Zk8z3j1TZrRqA1YIV
 yUSDY+ZeVGMLBQVrSg6mm2OHJS5WdptKV76VqrYo5c01rZZG7ybePPhGt
 DmLtNsbtauB1VFYkbnTKJTymyAOOnx1F4adve1fBoecmSiHVObKto1+k2 Q==;
IronPort-SDR: OqGPYSLVfdwsuXJCi+uDdSBxrIM+OidgLKKUL3JsYyo1I9FCF1zRaZClUoG+Bfiq+Mjo6/8Blz
 ZHGjaGKDsKamVJ7hCFhKQ1fDF5+DTLz8VWFYgYo+9gZonSKAEBr+pJynHJ+8uWTr/5uXxPx2on
 mI5mVhOmQ3nlSgPMctqzPtSSEbO7sBxWzeMWUoBeWgVioizNBNtt6/EOl4P71ya+F0FZuDxduD
 KMLYGE+YN8AtpTj6d5Tg+v8RQSb4qbMlKmkDEQkAVAeefS9WxbybwIf1vmnDIeLAjvTHvxvW68
 ZjU=
X-IronPort-AV: E=Sophos;i="5.77,320,1596470400"; d="scan'208";a="148634187"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 08:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdmFj99Mzu6mIq5eZ9PpRjpCrAM1OE4WSgX3S2YD5OknGZAHsejmNtF0BpqLdtAnHko36KQ7p6NMQREuwJTva1aIOAfY+GHFIhe0fknym+zmFVlSoPLkNWuUKavO3vHNWKroFqEKyMgW4G98agpmK+sJvbU8Kq/P66sDXAbCfkAaYqN9/EbBSHk0HIoCKQoSC/zdbIBLA26t/PXVJK2Yxjg6jbCoDqbwaWs/BPkKjK0lPPrBeID0E0jU/5jur1N8CpyaXxdRRqf4NEc/N8NHtNcVmhy/6LofZ7X76QWpjEsN3qqsR9DCkU3KPfhHLS6lH7c4ZFtMWM9+wel/eSAG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmDakipGXDxAk3CByFjm2PL2r8iHOyFaFbMzcpDdyMo=;
 b=nX6wBA1MSS9+q6CgumqukCltamXYxnTOGBtUWcrKPnfSJAguzsaJARZUAkRkdXF8FfCV2i6mCi/imoi73oxw+exzCON47/FimXl/1CQv5UOqS48znHGS6oJ+kSUUbQmze/hEsJYSFcm6PmS3IM97hd162qAKKqxZsn4Lb6MqVT4Xv/BIR2T3GzE7FM9JKKw408LrAgppxKimzaIWjs9PWQ0pKEAmWvip+K4ZVwxmpoq+XH/JlEnITOzEQe/iHyC8d2WUbnd/qEyxLNV4YWzil9m2v9X1rX94AjCLuiZXpaIcpoWbNzulyMxW1ivFxe85Do+VVHlIRjM7Dsw2irFNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmDakipGXDxAk3CByFjm2PL2r8iHOyFaFbMzcpDdyMo=;
 b=l9yh0Ag3040xwopMaueDNIq3cKDuLxM9kso+IYBQZB04WxZp6WObHQiUSk3NxR+fEFmy+fee1uELjycG9P5KrGwYpuX1zJ6s0neeyBVKO4tSO9Y43jiwe/zOmEUk2AnTZjpDJnTFmsEba6I+jQz6Fh98BRjCkUcGljHDeQBpfqo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 00:22:28 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Wed, 30 Sep 2020
 00:22:28 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 18/20] nvme: move nvme_validate_ns
Thread-Topic: [PATCH 18/20] nvme: move nvme_validate_ns
Thread-Index: AQHWlZSyxXNyZY6tGketruXR1sjXWw==
Date: Wed, 30 Sep 2020 00:22:28 +0000
Message-ID: <BYAPR04MB49652C7EA9C2A45C8248A50286330@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a080c76-b326-486b-3daf-08d864d6ea2b
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6884C462C7C7FA9E45CB671586330@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zDoLFRjyE5+Q+Q0VxBSoKNp+h0WdV0VyJmyA85OHSd/B3S2LkkoqZF0RDF96INPv9uMWJLLboRLLdF2kaDP0P/MuR+WZt+pOUcznJ4Q3AmQi/38UCiZV65xF6KvtgYU9cqb1sj/1m6xc3qeTG85RsY67xN63Od+0NIVNnAPBiTwbdjkp38pzqxCIJbdbhAMvF34SuPsw+Kheo70d8OnoBZP6tnTN7y2iBRlURYZr4P8S7nHuQj7Bp0sEhbLooHR2Rz3GsMwG3vk0tGXJa8DNkpwdtk+plAAjedtvPZc/GNhIW40bWJp05hm9j47xQMrATFZZ2Rv3Jc5k7860IDMhLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(396003)(346002)(376002)(366004)(5660300002)(186003)(83380400001)(66476007)(66556008)(64756008)(66946007)(66446008)(55016002)(6506007)(53546011)(26005)(71200400001)(86362001)(76116006)(4326008)(8676002)(52536014)(8936002)(33656002)(110136005)(2906002)(54906003)(7696005)(478600001)(316002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5DZFS4xut5iJMbRj444s6nluRLDl7BMO5FGWKBmLkksRYE71s/YP1Tg8Bg/xg+ftmM1rCAXNgr/0x0OEFibeJli0m7iUcgNuUsNM+o5LxHlk/A5VJ5/pGQlQcdFuA140vJFJzkrUoUqlzv9oU+SnAEMi4KhuQ+0TLuOkvOSMbdfSlvX+09qRX9yHbLNDiVf/jANMdUAwiSdn5IELVX/ONngEkxEhPdIEj3ECvF4kV5xsklD/fsht2uEb+BeSGIZjYnkdklh/svJcE2r/3C5K+Ug+25m+W9KRDatjpAx3QpxtcjCzHmY97VIiiCdd+7XPP/diOBztFcdfgLeqDEmdoBY2LZgQ1SIbxppRqPa7bljH0mJ7BM8zkLDoGTcp/rlBpmAEBUc8bLW4iSVO4xCHOkbQoJawv/S8JTJxhnTlLneosFnWJXpwkEkX98l04Cuu2QGcc+6QB8AZOcu3NlIF6RWD0w3H2igFwgyXK8jLgjvhqZ0/Ayf+xYB55XHpmx+2uBk469+tr2G1RYqxEOOHdt1MC+ROjA4JfD6z29ZrOuYR0Do7qIQvP9ucq/SrCp4AEvACICAgWFyQYMzYFMMwikY+cHOUaw6G/PgZ8y1XvHy8Z9NiQBPnF/jubUHQ4pJN8wFAUqXtxE2w4rYNSiUDNw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a080c76-b326-486b-3daf-08d864d6ea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 00:22:28.5827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvWKp6GU4cfXIwJeQWLxK/nLeyz6iEvnuG1rC8uUh90NY8dmeCpsVEuUHlcgN7ahH1ILKdKnlkYdi+8E6YI6kv0BMn07ityNykUGS8hud6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_202232_523239_09E7D10D 
X-CRM114-Status: GOOD (  20.36  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> Move nvme_validate_ns just above its only remaining caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 74 ++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ad18c32b36e7b6..07309f6c14faab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2156,43 +2156,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	return ret;
>  }
>  
> -static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> -{
> -	struct nvme_ctrl *ctrl = ns->ctrl;
> -	struct nvme_id_ns *id;
> -	int ret = 0;
> -
> -	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> -		set_capacity(ns->disk, 0);
> -		return -ENODEV;
> -	}
> -
> -	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
> -	if (ret)
> -		goto out;
> -
> -	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> -		dev_err(ctrl->device,
> -			"identifiers changed for nsid %d\n", ns->head->ns_id);
> -		ret = -ENODEV;
> -		goto free_id;
> -	}
> -
> -	ret = nvme_update_ns_info(ns, id);
> -free_id:
> -	kfree(id);
> -out:
> -	/*
> -	 * Only fail the function if we got a fatal error back from the
> -	 * device, otherwise ignore the error and just move on.
> -	 */
> -	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> -		ret = 0;
> -	else if (ret > 0)
> -		ret = blk_status_to_errno(nvme_error_status(ret));
> -	return ret;
> -}
> -
>  static char nvme_pr_type(enum pr_type type)
>  {
>  	switch (type) {
> @@ -3973,6 +3936,43 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>  	}
>  }
>  
> +static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;

the ctrl variable only accessed twice and there is enough space for using

ns->ctrl so that we will not exceed the 80 char, consider removing that
and using

ns->ctrl ?

> +	struct nvme_id_ns *id;
> +	int ret = 0;
> +

no need to initialize ret it is getting overwritten nvme_identify_ns()
before

the first access or ret = -ENODEV and return ret on test_bit(NVME_NS_DEAD)

error case.

> +	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> +		set_capacity(ns->disk, 0);
> +		return -ENODEV;
> +	}
> +
> +	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
> +	if (ret)
> +		goto out;
> +
> +	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> +		dev_err(ctrl->device,
> +			"identifiers changed for nsid %d\n", ns->head->ns_id);
> +		ret = -ENODEV;
> +		goto free_id;
> +	}
> +
> +	ret = nvme_update_ns_info(ns, id);
> +free_id:
> +	kfree(id);
> +out:
> +	/*
> +	 * Only fail the function if we got a fatal error back from the
> +	 * device, otherwise ignore the error and just move on.
> +	 */
> +	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> +		ret = 0;
> +	else if (ret > 0)
> +		ret = blk_status_to_errno(nvme_error_status(ret));
> +	return ret;
> +}
> +
>  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns_ids ids = { };



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30759C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 15:23:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067B22075E
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 15:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ta2DX6xW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LcnfIMbO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XDYrv+2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067B22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0ppr5rI/lwYT72bQQHCMkgCKfzYHT2Rn96mtavVW61g=; b=Ta2DX6xWSHfzXt
	/wwTD7qfDAkB3rLpbG8IxyEC6QmDSyiEWNrm6ZPuXDp63uf8+jCG6Ec9TiC+ugxSKTbgu3RAQkJMm
	KoUxTim0kvxvlZsvhw3ramfn5H9vRgXLXP+9fEHqL2jCg8rXoB8aeKsU1MQuVw9NXmY+9J5uMBMeF
	aZ8Bg4/jlBLwmb+6whmeLCfKahZ4jrPhCB0/gA2kaaG1Qb063dhOLme8yfUJPR0OGNYFtPJoWilnR
	kxMuBVBrRu+POqZNk3XdoTXzxBHYunWJ/UN8lT1BT/hQ73jXvFXkCDAAqmBfynXb6uhiCMzEC93BK
	dvs2yRwB7LsfoNXoMa5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlwO4-0008Kg-R5; Thu, 18 Jun 2020 15:23:32 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlwO1-0008JV-2a
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 15:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592493809; x=1624029809;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PkHxP8yCC+XpZWfA3hJOcNoZlW7rdiT2lsFhBfxPXlE=;
 b=LcnfIMbON0FtVcFF9eF/7cT8+obRJjOr5kORG5l2ROn7osuyK74/N3qe
 deflQkxGH1bX/B6OVw67FzeZlijYqavYzt8aVCh/16sTrcEgisRzFKl8d
 SejwAYy30RgRKy079Pe2iMX2MKm3M+DRr3cCigtSM3vogKkhp+ZfDbY3I
 V3VSxzFOz4PYLFbSM+PgFUhNgmNxOOi+BDMzU01+lnX+TGy73x7ZV8/zg
 3txODdim5lfeIxnp06pYsyYj3yZtIIQ/K15V0m+FfUiKx76j1paKIkENj
 oD1XsYiW9tJlFwhxb0tggxdEeEKX04p9kzonhnQMM8qovWPXXidhW3AOA A==;
IronPort-SDR: wkAlW/CYAGF3U2lB9x6rrrvNWgNYq0CDxUW0xdbaVIYbx+M46HQPaccLcjO9XeebIkTxNT66xI
 okxgpTCWrmKczFm/ejwqYfKtFOIWfIlGbP6PB6g9cdRO2ZBsurpGc8iiftg4swCCbCHq2Tovoh
 IqYDzN/gv2q7oRccx/luA2zz2K74A59BPgWXdm7quQoXwzKDK7Js3YdOE+UNv4nZw+wP4b3TEr
 O1g7GCsKll83c0njc8gGldTG6BtwguHvb9uX6Jg4jRxh7s5kqvCLIy5/ec0LFjQvA7+jVz7tJC
 /Es=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; d="scan'208";a="141713018"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 23:23:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC2s7ghKSfEZLYg3gMswqjimdExoxnXKNY/wuw8s+5tjlHKoCWYlrtRnnXXnmDg2HUWIBofVyweeQA48O1VutJcxK8hhrBIXpbgzWUzWDgJFG77tGBLpJA/pqX77AG0wAyZRHNkuq6Lg0mR3ixskkjAfkRWl6vLFbX1ebGfsH9k9kSdmEthUi49Blq8NV6ok440Jop+pQpohn6FKV2f+hJf6I5tv5qU5huHs6z1dNyIOFqxu/d0OpQ5Y/Ne/LiGS2+mFJSGG4tom7ovUesZAatU45E78EW661THnUk2EyDGlZnerzgDbLUR/zhPP6q+HHx8vjbVb2K/C+Nh9w39DPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbAjMdmqOKCwsEWL6nQBXj1WTlUOLPY6dLdahLISmxc=;
 b=SzmXNj/dA90EOE5Z1yzpe8cHWvk8f4UIW9qYY05dw4qaoGcM4TnpfqmyFPiXT6T4Qh3n18TYefvo+y+C4p01rtVAn0ZBqsJFUi3YFKg3A/IS42ITAo1UD4F2a99hTc6r3sFat5FL+3lKlF4MEZsvCbHN9SAAjHVCjhWXiLLk+qHxtafbwPMFKECCcQe/QuZWfKyxKw893LYo+d23vSaLrH5a725OOBpYvkhYoLmGlie2oQ/Fd0APKdswnM2+2JI5AX0YivvGEN6MeV7YSURfHAwkSK8JCEOma06AmbFCbViPSb0Lnbt3cjW6f3jT2jpXIf6co0tt+ijRGDH31gbgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbAjMdmqOKCwsEWL6nQBXj1WTlUOLPY6dLdahLISmxc=;
 b=XDYrv+2lL1JKBYBriRhPKJTMMn5CSY7+WxUJWUPw+QxHkL4hLnbb4ZvQ6fLgKqHQ0CaT62eh6BFAuCmh0JatUzumAvv8aowUQc/8LTn59nlu5xs2JdcELAo0SaxtW6f0CfoLRD5WApVhtUt+1k4lUvWzM/UIfBYNlqu6tsqU28I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 15:23:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 15:23:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Topic: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Index: AQHWRX1ZyGByOih9fUSrbaAjQMq7Ig==
Date: Thu, 18 Jun 2020 15:23:21 +0000
Message-ID: <BYAPR04MB49657026BADC613CA83CB896869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
 <20200618143241.1056800-2-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b6de368-fbe5-4e59-d55e-08d8139b8922
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6552E4D7A1708EB53C904D39869B0@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oyiTMO0i2qUxQrwsKOI2qCjnYMVPofeK2e0rOuA4M7+11ZICLSCI1pQTcYU+iq1h9/UcGwvtoF9+T7uBkcgbBDtpKSDqEhS9u3ciThMbxbYVS5YwY1rM4P8EaxAqoUjHyr3vNcFVyROwEbwr/5WteMlAjMP4HH3DXyPvF/7Ih2w/tBOe8KEDJdzghmplEujb6N/P/8+9MY4O30UvXC/WEs0mCJ+hoqV2l5I2GluhvAP3ZbZVC2wgHelUd2aZyU1CiDs9+5CMuf3n7jLsFH/xFoNPLVx0pg5ZLcs0TW6iQYWE8xifm7MukEfdaszCPByvfOg1Bi0d89nGD1Ya2+aOzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(52536014)(2906002)(9686003)(26005)(55016002)(53546011)(4326008)(6506007)(478600001)(5660300002)(71200400001)(110136005)(7696005)(8936002)(86362001)(316002)(8676002)(66946007)(186003)(76116006)(66446008)(33656002)(66476007)(66556008)(83380400001)(54906003)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: w+j/+79LV7VvoevOLXCdlVw6al+UIomLMPITqipUvyoDsg9FSKo1qL6Hk61QerD8tDPIbUvj6SYLDqz27dH9UNAonODD1YE+RsTkFwDsyf3xILRXQAjfQaLsyKpK3qbcHd9WzJvPstTzzNwMMzoFG6ZINUeahcFYAwwKaSAcoLZ3QEPxKu8p60xs+apoROOoUXog4kWS8rRkw1CCUO3/TxyBHmrAw1q86BnmJYiOe6V1YTrPKDZbcP14ro3wQZxCKcFMEzUBRqABnly/DKruEsj1nJZiKq5C0VTNrcN7LDmkJwxCRFsCX+hG4jhFJkV4jeUyfv1OU6zIk3Bulvm/42WOWCDZOKhNyfEtxDN8DXvAWjVnEW0/ufHqG+bmNXqGtcKoh+QT/v850KRpDt92XaCQ6YdxXkVnZ98LK+Yc8THAO+emN6q/XJ15rPhjzmTaiFAOamQCatC/QJKnfSSEkO4g1nlAfnPsCrDNq6QhwQA=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6de368-fbe5-4e59-d55e-08d8139b8922
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:23:21.3285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtjSB1YIcqpHDAYyk2BPSWB0y8UJ+fR+iLKRxTUw5drAbNNN8Pdq5vBP5wWmDzxT/+SZa2Zr2o/E5hGgAYFffo994cZg3MojOtK/9gOhXrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_082329_249884_658C2CAA 
X-CRM114-Status: GOOD (  14.73  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/18/20 7:32 AM, Niklas Cassel wrote:
>   drivers/nvme/target/rdma.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 6731e0349480..85c6ff0b0e44 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1535,19 +1535,20 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
>   		struct nvmet_rdma_queue *queue,
>   		struct rdma_conn_param *p)
>   {
> -	struct rdma_conn_param  param = { };
> -	struct nvme_rdma_cm_rep priv = { };
> +	struct rdma_conn_param  param = {
> +		.rnr_retry_count = 7,
> +		.flow_control = 1,
> +		.initiator_depth = min_t(u8, p->initiator_depth,
> +			queue->dev->device->attrs.max_qp_init_rd_atom),
> +		.private_data = &priv,
> +		.private_data_len = sizeof(priv),
> +	};
> +	struct nvme_rdma_cm_rep priv = {
> +		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
> +		.crqsize = cpu_to_le16(queue->recv_queue_size),
> +	};
>   	int ret = -ENOMEM;
>   
> -	param.rnr_retry_count = 7;
> -	param.flow_control = 1;
> -	param.initiator_depth = min_t(u8, p->initiator_depth,
> -		queue->dev->device->attrs.max_qp_init_rd_atom);
> -	param.private_data = &priv;
> -	param.private_data_len = sizeof(priv);
> -	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
> -	priv.crqsize = cpu_to_le16(queue->recv_queue_size);
> -
>   	ret = rdma_accept(cm_id, &param);
>   	if (ret)
>   		pr_err("rdma_accept failed (error code = %d)\n", ret);
> -- 2.26.2

What is the issue with existing code that we need this patch for ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

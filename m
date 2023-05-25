Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539D5C77B7E
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imWg0nhnVn2rheG4g5c6ebWsb2ZibpYOTFzPYeik1FI=; b=jmBjiHulaOWX15GgHtZDriWwdk
	Syvf7YyFg4/F0d95w3EQw3AXP6FJ9GGjg9RDXj8GEYfulpmrUzr0ZXip0saMLlT3WtXREobsCivjy
	JWZfJ5jA6KobwVcrQtmDbbGn61tT0raO5xqKWa11f9Ar8YTyWSE21mMt+rzhVIr1xSSGUNGVcRqHa
	qJZAcc2uHGoEhRRMaTHcyifSIf+L8NHhkhZByfpTKzGOJ3UQrFh4CMF1M14BXzsoGvL0ERSzkhWHs
	HR4261hgaV1R1tIRPhJ2kWZdAoiyZ+5/VcGngFrtJ50x4J13ZX7Rx9mnmMj6eiKZKfeo7uYxoiLIV
	jj8BPd+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Ks8-000SNv-07;
	Thu, 25 May 2023 23:59:56 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Ks4-000SNJ-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 23:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685059192; x=1716595192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nmK5SeeBV3U/nrs78nV9d8MNZHSgC6cqkuhUJxPFX1Q=;
  b=pJr7B6sUt9p6IJweGFzjpvE5lsxH1flVNtI1gznTq8d98uMi9tLvX9AU
   ZBPTxZr5K7uyVZbmIgjMtnbAeTiPJTBkaJpEfHt6CN7X7nKmmU/70F5RD
   BwDYUmiGY3uVECnM1EPjpcQPW/iXyrdfwum9Jnn8IGKv6gIphsE/FCi9H
   BQzoDxxn1H9rn1Iit3LLDt6pu26Y0DXl1TclPLnuboquft8zcJLJMUFFn
   fMRUpbxmoHDMWeXXrff4wcHxClMa/YVjLaAzusq6rBAzHnDYJtTIRfZqV
   HQqg3IYBM64knH/fl0OUlgQ3skbVKuONTzPvi1Re0tGpBXzxU8XrtwbUd
   w==;
X-IronPort-AV: E=Sophos;i="6.00,192,1681142400"; 
   d="scan'208";a="229833999"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 07:59:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9/2qNyknvGxpwGKxlm0HsbAlK9GrhPYaHhgxX5tBpk/R0Fnw4TqZD4ueBpd3ElBP/mCAL/HNYrLXMf+0BMilOvhKSESuY30upd0MUuaCQsh8RJUB7fCXeJgoL5M6xcPqg8Zhuug5O+BxW7hv5W4Ftaetooa1biejY1iKmszQPChW1azaCe2sQg6AmKNj+0BfBYUQxquYPqEXWyQh6AL2DtQZmSeTvKywNeJJBrfyCH9OSkFGoG4NE5OCuIvOaz6m7AmFPVV7Feg+u7S63mFa7u8dGy1xgJyGJcy5rxDQZBBcKBfxKyU7zmCtr6Ekr3lFGr2PzEOnP3CrGjGEe3Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imWg0nhnVn2rheG4g5c6ebWsb2ZibpYOTFzPYeik1FI=;
 b=jsZov8Z7/hIjNck/bH8471irO1Rxs+9aQHi78no8EeIG7dJR/v20EhYMQA0Cj8lIaeLh4g2/zhbfkkpW8bEXyHVUypHJA1SBUIgYKFbslNwOZdKv1gtcjystoq3twZkfn7g9ZjTx8dnD6+3Kw1JruttfwmjSg7F9DejUE2Gw7/HnpH1qcJW/q5WmvDhtIyvHbbvJvFGfzUSkxA6IO5ruB8vo7Jv5hu17iadADjxZWQK7Z0WEeWSflVy2aAj8aiHyRQJLUvQwQemBc4wwtd9d4FLHOIfG16xmVmNVoAd3Z/pyOb0oVA621TKKvaMIWfvQRTubvvQeGPsxJgT418MyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imWg0nhnVn2rheG4g5c6ebWsb2ZibpYOTFzPYeik1FI=;
 b=YfZUHCXK/mQkqYwgI/RB3yYAuuO2juXD7txcFG52S0R6XsV2vIsrjOq+bVdpToLuafomXUAUApa0nsTv26XmLCHEatk+topCZ7NCr+DW8vTo4Iv1yOvlwDX/2+aH+EXeTkKGQXg7qqocZNsK6Qb6U0fQIiqVkMTaN5/uwTCpaqg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6573.namprd04.prod.outlook.com (2603:10b6:5:209::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17; Thu, 25 May 2023 23:59:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 23:59:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 00/11] nvme testsuite runtime optimization
Thread-Topic: [PATCH blktests v4 00/11] nvme testsuite runtime optimization
Thread-Index: AQHZj2T0F9RslLxwdkCWzwHoKJpJJA==
Date: Thu, 25 May 2023 23:59:34 +0000
Message-ID: <5vldctv46u2ozc3zhm2bxju57zbbeo4jhdxgodircy2m7j7rnc@gqt323aeyaa4>
References: <20230511140953.17609-1-dwagner@suse.de>
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6573:EE_
x-ms-office365-filtering-correlation-id: 56a3fff5-0781-4768-45a8-08db5d7c16b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6sE4nWBh25wM/Yy5mq+kTbnqqg7x61fQl4rlPH6lp1M7KedW9SSvQF4lo661PpW/+73DrPUE4piNviT9d50eCD/w5owl+OaUsNxPAjPQS5HOd1xiF2trnBAzsDq3NKeuysL3Bb89gwD4PS3kyd7+9+unAkIea7+1D2B8RuWH+pKMVXrlAjA2w2Ctlj7z8ZqK0KJ7lUzo1beZsbTir5hvPExeMtQ8IqaxS4bFlbM0FeqLz+2SLawDAF7Iq1rEyxvM4eXDtegNa4V4baCire86NTux2s511s9DE30oaded0N+YLSdWuD3VPS7pEp/1h68+Kh69od2hP33cVMsfWrK2zTcoatifEY/yJOp2A76Vupq13pP+FNAN0PmNwkpNy48m0+Spqf83En+CLtraR5z75xY/tXJcziVv/LgmvTdBb5olD3WczqZiOtYym9R9k+L6f/mI+1osx2suxjvJzzxf8U/au3KQ4gmKMfx0NrJAarZfyhVBa3LDNawA9aF4JBKIo9lrIFCB1wEdJcBXMHoCuRnk1vrWU5yQr3cZEauSjzLtrEIaohR8GWR6SKiik2FkZQN8ZecrN0/+ppxAOxHz+z6t4MZod7bZC1hLxjO0hIqZ/sgWfas405/Yoh3pRBd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(66446008)(64756008)(66476007)(91956017)(76116006)(66946007)(86362001)(478600001)(41300700001)(6486002)(83380400001)(66556008)(9686003)(6506007)(6512007)(38100700002)(316002)(71200400001)(26005)(5660300002)(122000001)(38070700005)(33716001)(8936002)(44832011)(6916009)(2906002)(4744005)(8676002)(54906003)(4326008)(82960400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jkRpo48vk2/HzFzUnuEYqqPcsXF1RoRXwDnJfkXRGNQyK6Qc0OQ+QFMujmVf?=
 =?us-ascii?Q?G0FeUB7kHnHikxazP/qsYAVRNqZ7/Dlj6FY1PNTKOpPqRF69WGelrqwvHcWv?=
 =?us-ascii?Q?T9OeFQVKJGX6keS7QcpgiyaCcP4cRpJOPr73ZcgqPUyhBjdE8lgZ4J6GK9L/?=
 =?us-ascii?Q?+/ZJa3cXCXgWXEYe88uAifCbdLxRN8adm97aL/ZGth4+R2xAA+ZJobGE/sqP?=
 =?us-ascii?Q?QG9PqVPXeRziRQ2t9o4hUGiOS7ipcQP7/8lA/wmbQ3NDZdgyy5mCZZvbKPtA?=
 =?us-ascii?Q?kobO1XtO+NxXGBNlMw6KtLg3uQ452Icj4ykEbIX/IxzgUGRKV5Jxcc3Yc6CW?=
 =?us-ascii?Q?+0GHKrlfpwr5/AyGSrefMYaVQCbJGPipK3Rv20ai9au1RikO7KEoOu4cLNhh?=
 =?us-ascii?Q?Pr+Ox/fnZF6SqsvkHk1+qHWHoTpzRuA65FTg4E5xE1NlAjF48vVmZEMG4BK8?=
 =?us-ascii?Q?gsPZCQLL6DJ8ol1/8Cu3mMRkmwzykwH0AMmUm8XVYRJFAlnI2xRCAYBQHkOX?=
 =?us-ascii?Q?/vHCWEQeOG0sitdPzx63+x1cBB9c45Feu2jZ/nWeAGEC09hO65kAiGGGZwjp?=
 =?us-ascii?Q?xdnlebzFt6Rp8qMeGAXJdCE7vFKKUVSSmmUEjV3z/iQIyh4kUg7wKYtnI9co?=
 =?us-ascii?Q?kWl29fERUrtllvmiA+wjlm7h3daqIeDL7nXEBhGR0eX4XTk4kKL138e28o0J?=
 =?us-ascii?Q?zsoExE7yM8YCE1QrePfEvtG6pd9K5BmPrfWgRUKl7PeT+HIeapweoj+0RgeH?=
 =?us-ascii?Q?QzSXI3A4P0hlHiUTn3jf6nJ1Jflq9GZq9pKOlXy+StZ7xHb2oJGjesDVHSmN?=
 =?us-ascii?Q?ZfIPwR3PUl6zgvyyn1w5eON9lFvCVhmdIn+7QDABUjjeU4u14joYTs8hJJDK?=
 =?us-ascii?Q?7JR4Vx/JBSHKYJ6zoRplol350jBM2ox83UhuvxLBsimm68xZ8jbxuj80akME?=
 =?us-ascii?Q?g+gDxPFxYVI/Hnp05C/ZBO6E30OCtAg+C9OqY6YMLRjxYRDz/iqULGAnpAxy?=
 =?us-ascii?Q?LPmGhjPY1Z8S8/HMt0fubz4x+LV/KxGYTa4TjoMmCSVL3KvMfawyNlXWMfYM?=
 =?us-ascii?Q?QUBmI54btPYUM7YSewsEYt9PX+XBTT72Q6FRFMgdVoWSQ+ZIYc4l5YKSmTXB?=
 =?us-ascii?Q?kWrEMXa6+FwR+k8+Q2y1WoaTtFwgdx3/YB8eL/J4qN0odWO9vsMtvKkX4oWc?=
 =?us-ascii?Q?+uhRpR+zzgVdpnn2E4n4DZjC4WgSbORjRfn+TApaSU7Doa3dUpdT2IrIANao?=
 =?us-ascii?Q?P1Rw2WGGkVe4YgIegWrrPIAvJXYri5wY/iazb2LTZgZcAJP9d8CUdcx5zzPF?=
 =?us-ascii?Q?vXsIlwcCIJaCoLfYPlluMyUfbDUgXZMVqhv5RcGVXR6Gr/sDcSb5zl6GIbQT?=
 =?us-ascii?Q?SZx4m4UFQgz7ts8H9qAkWWaKwiFiGPdtDQ4EXaOUS3q0EMQerIyKonmC5VO+?=
 =?us-ascii?Q?qrZlQxhmFase8zh5mftta0QUMi+uyeUcpxgFDlclFAA3+TjJ4W5zH9WXV3ag?=
 =?us-ascii?Q?dA7ItlTKoDBWolD9QhPGqaGeAPt5lG+EHIl0Z5dY5OX1xUT6Ky2nTO87WNct?=
 =?us-ascii?Q?G5bjo1xJ+utSCpxzy5Jw5g61Vb35lX3HQY6gRP8lWOz+xOtNhJAxChqejnMH?=
 =?us-ascii?Q?A7FMdPeIMawfYSSmlj2Zm60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D694096B04ABE64A89ECC439F9C8C266@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jc4tjr+4tNE0ZkxW6Ug/B3ZtkJHB0FT+xNJIOrErv2dhhKbV4LH9/nNN++8/6zz/fOUN5YlKleLNc0RU/EzwILmoz2vGRl7tpqOOKpWlqGw2ChWGCTdCse5cwgf6qCF3JW0V3lscVugClCQV2V8uPbqRQTV9Pjq4Qu52bVTunq5r+gf+GFzO7W2TnpC3dEpde5/LeLWK2qh7Vp5ADqz/KCFWQVQfw2o96+YvaQuR3sJnaws9Ot9ZQoyXNJ/w46PTOHa/TrFgJGbkhnpeFoDvwhyp3GGKqGjskExSFfN1GMzXY9jhFQd8R3szSWZq/wwfFF/CZe8fLoCafYnvrHXt9SuZ2yLFuQgoTFjlB21jbBqRWmlUm2JinOKPBo0hx0JbB8d2cKe/69gmD2xP7k0kdsjfr1SA3EISWdAHK7NNFcdM5XZshfqlKOCq+/kSjlnDGB6jtD4B8SOFgraSYZChsbKdcG7rMgkk9o5O4jo2RwbZLPljNu4aKvbyKn0eQ0Xyonvf4dYUpdkojzNOm6yyZuPjvU70UEdAzWWtSpqFQk6s8ZRkBZbrEopMezPcWVns3khQx0Hph0/1K2/TKEnxnHMQTNLIdISPigeXAmkH7B7Gh95o9Hby6FC81GA11mTJi/i2r+AMaXQ1w3dWcWOmWPN+9D5K459YpvukDTVzPf9GNFHNg94Zlic3nBngxG3pr2ckjDkRrJCcFjPCsfZ/01jPqXobOywcmIDuJ5wltJGnjHyk7v8tAQswkLkkCu68R5tAS3UArQIbAlmDxIK9r8nk2G0RAjmzyjZPhfT2c6N5oS054oEgQC8+dlqMsIh8R9Z8g3rwNaKqM+GCEixe1xg1vPsZG7mZHOHDZEErqypBjAm0aA2c2jEfhIB4D7G2MLrCU+1agErvtUIiHiFSPVHCTQAijKRfYuu1JjV7g/M=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a3fff5-0781-4768-45a8-08db5d7c16b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 23:59:34.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhj8xm9fct/BP8vQlxMYEx0+5fzA/FnpX2wgYzoLSst3mhgtNczvY/GBB2c8Sxvo7ncFz4sVv/A5FD5BxeRobM593TWIbD1VqwNtGbD7PHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6573
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_165952_687342_016F93A5 
X-CRM114-Status: GOOD (  11.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On May 11, 2023 / 16:09, Daniel Wagner wrote:
> I've updated the series with the comments from the last round. =20
>=20
> changes
> v4:
>   - renamed test
>   - updated commit messages
>   - fixed whitespace damage
>   - fixed ShellCheck reports
>   - dropped 'limit number of random jobs'
>   - fio runtime 'invinity' changed to 1d
>   - fixed typo and updated documentation
>   - added tags

I've applied this v4 series. Thanks!=


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CCDF53D78
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVEfjwsVIVeZw9kHtykiUzjZh+mqiVsE7WW1mOtR7Ng=; b=VfyXbWqgKjx633H6+Z3nwL99hE
	u+Cid9XRatmwpi56iDrPP5V4aCbvlQxNkiyC//NXjnBbZfKCADYA6hsFkbd+jjsfV0rtnULbIERvD
	fS82J9FWa8I4orA0hjZjXu3/D0yRBQnuj52afQhqOixeBd/AO4v9Kvvao/XlC9dtXufRNZjG1P35y
	p5oh/tYhQVSTpBFWb1qMNBFb7GE2BKg4fuCZ2Mkx9KUcKsYV6H5Wh/ggnCSGqLcvTTxo8tYR3F4Jc
	9zCMZQ1VLYFZX7jWtVFRBJ56pOR9cwFKBEY2sf3L9LTEypmIsmBk3jPeCYKvvudFClkR2RzrmbYmu
	JBvqrfbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BdN-00000004YKS-1Z2h;
	Mon, 16 Mar 2026 17:21:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BdL-00000004YIJ-3Kjg
	for linux-nvme@bombadil.infradead.org;
	Mon, 16 Mar 2026 17:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=kVEfjwsVIVeZw9kHtykiUzjZh+mqiVsE7WW1mOtR7Ng=; b=UtZ63njgSfugsehCmDiVxKgyQa
	7rcjXWtLPtUOdiX+iFdS4Eku/Heiq0itf9JonwsHTnAG5ztqXtuPeVzLGy9DKGmcc7eImGJjXtpem
	6U6uPuyQ8N31HDu2cvak36PgFQeTsqynta2R9Kca1RaOGPXqASGytKjrRdpYuic4Ny/I0p6fiLtgb
	utZQtQjibBO2K8t2kCU3luvIWuHpiJ6vj4NNBhi/zrKh6S/riAkJL6FXR7BdtmPFBb+6FxQpuXNlk
	ecyp8QU6nSC8r1urt/zi05WUqhUEOH5vitNARD21gDw3li/XIu/FAmLVkCLidGVrZmP+gOQSIU8rV
	ki9aDHPg==;
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BdH-00000007JeP-1TTe
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 17:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCQJQkEfDTYmpkOf9i2yqbRMfStacH12MltYOpRDVNTeKLo0eIYeZ9OwjXlQ1J22Z+eEzOFR3fMK3Olxz/4cWpzeCljQrMUJmENPGSPavZSrMA/p7qIqWxhlRWPBUDubrWRluLZTauxYtdLjXXIcidZk5nFvKcqzPwYjKhEQu7YcCO6n8+b0fumWmiCOkMzoX2Yaf1uwqCVFXjN+c/xKMIqy9RdVMH2QS5BLb96tMxeUonrsUD/O9dQdp7WhObr1FqDSMCRNlCvfjh085eaullOWh6kKEhJCCts+pcGcSBSlFTf4JNZYPvwvSV/+XxkJdcpCHaHjn/pHRBt9Pyg9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVEfjwsVIVeZw9kHtykiUzjZh+mqiVsE7WW1mOtR7Ng=;
 b=QdTWzNBpV11aiwREv+j3F9d5sywHyGduRbyu5Pg3xKC/JI43P2ol5w5amX0K6q0Mg20OJaMFYHhRwVbazfeJDH/k2rzNyL0EXHbxNT1xd65kZm22mRPzwYlZOJdhu9TSAZO8YNvDJLTOKpIcTBmO4/x7Wu11IwIQbJMG8oEMpmjP3bfzexZVwTeH7ECxSAzjXds5c7k3aZwzcF6nThCOHVciExhalplt0F9cENjdPsT0a0+UNpLj5VNPikI9veZ+PbRlkC6gQs5aS7ol5pNs6jhmXR0KLplL6lzRBdUoOpYawGrubc/jxhIX/eb5xm+KmFYVv2wqDw4l7DTpZ+mN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVEfjwsVIVeZw9kHtykiUzjZh+mqiVsE7WW1mOtR7Ng=;
 b=U/rykYmYZEk+DJ1CQYCDki/SPAJXmKrXgLVe/ekeGHIsFQibI10soz2DOpL/syn3Gmc6pryWXO778P1oiYiPyKkaz1G2Og7SiMzia6Y4gcvMGQ1WPZ5OojbhaHIZ9ILjZTgmPUBtKFlJrwtq3DiGK5u/f8g6QkK1eo/bjA0GQmdlmVms8Bgk+jQzJZRqxiODm80FmHPs+WcEwFuixsyVmErEcsVQt/ljeGvWjxOcu/H5yNvCt1FNZE76urGwnXr2btwB9pJyenYb8cbVxC5OGj9ANr1ZS9ET67VI9m+CpsI9OG7Zirc8tm4+k/E5VhQZ2BlyxUVfDPwGVkei/Yk4BA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 17:21:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 17:21:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>, Daniel Wagner
	<dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: libnvme API review
Thread-Topic: libnvme API review
Thread-Index: AQHctS968RvzN5F/7EehG5FhJJkQz7WxSm6AgAAd0wA=
Date: Mon, 16 Mar 2026 17:21:25 +0000
Message-ID: <a0179550-3210-47e2-918c-323ee5bbd7f6@nvidia.com>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5938:EE_
x-ms-office365-filtering-correlation-id: 384ec823-a206-409a-c40f-08de83807394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: gk7lka/17yQBcbq5JiFJI+PrsLuozDRTaFRvFoEInICOXFfkQhFHclqrbUg87Vc50n+3trE3of8AmJdJFTtHziw4sjZS0qiapUE2c8uK9m0c6LxJMgyiLmcvvEN585NHM0uDizYeydOkA7joVpEV3L14WwMZCh78jH4AArxf3ABhMJnHVAHNfYGU01rYE/+yEolI9MVVr+YichjPMUO5X6Sh07Zo5mqgrSi4tO91+gxEieExejnyii4R+tPFTeG1fRe0EROee87oiy1z/OSUH8OJljo+vytHReAeU09Abj88zOXeGtmv0rVpiK7aS2YubpvZR/0xdc8Z5k91MP5GY1OeYF+UeKEDS833YGYgq5AGk67YyenVeLCBUDE6h6vD/Vuvf4iVz/Vsr59eT1/u/FfHGKbqq0A/CcRR/2Bdd61pTPzr4t1XvhT3R2EomFgsyc6libNHAfEEC5wWWwDHVjUuwbCHjPmTO4/9wPsQGf3HGYLzkKyK5e66BuCNRs4Nw7EGK0xuQ+/vplB4iSEYi+h7/nNg9aIf8gZqSf2GqFP9q0bpWf4NX9NWVYEwOGHOFTl0jaQElxj/fqFyBgxbpEmMoUiN3LMOly8zsCPacEmSNHdiDDKp9RaKLJqnsJEJRIEP3sIugLozzcttU2bSJm3Ogd2IZcTe4funuMvQbHHIrSf9QnNHbAvsfv1t8AXa7djLBoaFjWCM+l7Gcfh4ax6IsLpsIZvLA3jZj8DcoIlIWdBEmgdLR1qNYPhWiWWyiZN2jFz/AOmIiA9005GVReIhfWseHOOrNfwpChTu8TQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3JkbWdib2N4Vm5WUXBHVDBSSEw4TlVCbWpvbjNic0tvSExySXpOSWlyYXhT?=
 =?utf-8?B?ZkVjbFY0VStzckl2K1FNREJ6UXVSVStxRnZxMzhMdUlDWUZUc09kSVZ6dSs2?=
 =?utf-8?B?ejhLL1dBTktNb08yeFpaTytyandRR1lzcklXcUlrL3MvbGhncmZPQzlnM1Qx?=
 =?utf-8?B?ZjAwRFNnV29sU1E1MXozREIwUGRKemVydE0zd3JEeEhQUnhveTFnb1IwdlJr?=
 =?utf-8?B?Wi9JZDJQN1VWa1hQRzd1ZnJ6TkZ3Ky82YS81RlBhUU5NWmlJc2FMT3JpdGZI?=
 =?utf-8?B?YUlsTWdvaFU1UDFsTUlaNG84R0FnTDFNWS83ZktTS2lvSldrWXNUWEc2R284?=
 =?utf-8?B?VDdheUtWcURHMTNTcndkNzdhOWtvZWRJVlhBM0szVmFiRlp4Qzc4a2NkT1lL?=
 =?utf-8?B?WHpXWWpkSk9OUHJJdmRjeHQxSHFEdHBvOXc4bjQ3OFhtcUorazZwWno0N3lx?=
 =?utf-8?B?ellhY09lSytpSkkvMTVXOXV6R3k1WkhzejhWL0JRRXdBQmRQNGxaZi9xM25j?=
 =?utf-8?B?b2NxYXhXQkY3WnZxcXhZUmJhT3dnd1c2T0FOUWFZSDNsa25RLzlDUVFJMG5O?=
 =?utf-8?B?c0RUcHlBbXRWYjhBc1lwZHpuRDlKUm9LUzhIaEdXby9nbnduUkNnTE5EMFpV?=
 =?utf-8?B?dEZiejFjRjBmclRIRkhVc2R0Z09nZ2ZKeExPRVg2Zk15ejhNM1ROcWVmNllT?=
 =?utf-8?B?dHRCMHJ4VnNwRk5ldWQ3RGpCeGZsQW5jQUdNaEFaRWlOY3V3Z3FTbFVHaHBx?=
 =?utf-8?B?RTN0ekQrMW9wYzBjeldvcnJmS3ZBS2pSa0puZkx4dGt5WFdrV210YTBZYjYr?=
 =?utf-8?B?WXFWZG1xQzJBK3RRdDk0aWhPWjVzcVBUZEhja1VzNTZ5c1VvMnN3YXFlM0xk?=
 =?utf-8?B?MXppM1pqd1Z3TTljb1I2VUtRMVpFcTRHNFg5SHMrclVYVmo4RE5LUStqVGdi?=
 =?utf-8?B?OGgrYUhVKzZsamcybDlubWpYbDRPWVRIZXNGSUNzK3F0UUZmbC8zR3ZKTFh4?=
 =?utf-8?B?b1FVekhOcWR6aXBwN3ZIbkVnVDRGY2U5ZEZMcktZL29RMldhekI2ODdxSDV4?=
 =?utf-8?B?Unl3NTJlOUZsaVQrTDU5dkJDV2tBYStZS21qTTREdHdUVys4NTJ2M2o0Qnd1?=
 =?utf-8?B?ZkxtN0VISTlxSkxsSzZGTnlXTFIxK0JoTmZwM0ZxdThmN09Wa3hJdnZuRWg1?=
 =?utf-8?B?ak8va29aR2pLSnl1VS9OaEJlajJPaVRQZm1pajd4TTk2d2NuMXpCK1BrV1N0?=
 =?utf-8?B?S2crNko4a2wwUGMvQkRzT240WlV0aVJkQnRLTkRTR1hLQzZURkpTWksvTjlQ?=
 =?utf-8?B?R3FMYUpLZjNzR0lNdk11WVc1Zi9pNlNVVERjeUUxRUdwalVPelV5ZTJUVFBH?=
 =?utf-8?B?MllWQytWdytUbWp6R1RzQ0dKQWJ4WDNML3RvcFV2TWxXV1dhUW1wdHgwbFlH?=
 =?utf-8?B?VEQrTDZXUE4wUVpFQTgzbXNrczBMVGFUODdZb3VUUHBRWlBTenBVZld0dCtm?=
 =?utf-8?B?RTk2K0M5R3lQYXNhb3JqeWxkV0dER1djYWJ1R2FHTXVBWmFaZVRpenlzUXF1?=
 =?utf-8?B?V3pvcHpxY3VFTlpxQzBoSzJSRjREblRoOHJBOGtnZ2JMb1RSNm44bmRXMjRQ?=
 =?utf-8?B?cGV3RTkwYUo4SnlXVjlZLytGOGx0NUdnRkNZQmxTNkpjbVZvbnpndnRSY21z?=
 =?utf-8?B?eEUzUjl6NG5CM00vUFM3aUgyRGM0WVdXeE1JMXpiRTlaNngvMHg0MGI3ZHRI?=
 =?utf-8?B?UGdKKzFzWERDOUpzV3N4SkVxUWNtRENFc2hpZEphQlpKZVNJZGVvRFdnVEgv?=
 =?utf-8?B?UlhaY1I3b25zSWdpY3cyUi9QS2VidUJIK0RzdjV0Y1RTL1UzK25xeDZvNEds?=
 =?utf-8?B?Nk5Rd0FJZjl5Wkl2M3orUTBIcUNNVmplNEhXekRzRms2Wm5EOHArOEhZb28w?=
 =?utf-8?B?UjNibjRET1plQ1Q3M0pxbDFJRGpZYkNndnljc2tJb0ZZVnZ0VkhwK3BQd1k3?=
 =?utf-8?B?V1NzRFVQODJ4UURZKzVMTUhjeHRuWmIrTk9sTyt1R3ZSUHpMRk8zajJuREly?=
 =?utf-8?B?SEhBY1F5OGNTRVRZQWxCdmltOGY5eFkxU2tRQWdKN1ZMNnFkc2UwcVR3SUYx?=
 =?utf-8?B?VWhTSTMwVjQ3ME5PYkhYMXd0QzJQSUdLQTZ5OWJnMHNEUEN3ZmlYMWhoa0s2?=
 =?utf-8?B?QjZPQkRaVDl0UGlabTREQ0pTODZkclRrR3hveU1DWTBvSnh2M3FuU3RERExi?=
 =?utf-8?B?MXhEWmlXZlNDTlp3ekdybFVKdldXTEtlbVZTeEdxRWl1ckRZMk1RL0hGUzB1?=
 =?utf-8?B?ZnZxOEI2RTRaNXJPVFlWZy9ZNzdBWjNqWUJVbndWdEt6anM4d0I4K1pCMksw?=
 =?utf-8?Q?gM4Ax+l0ZGQLREUsffZn+cXDt4C0Ui9kOwfFsc8hF2fBs?=
x-ms-exchange-antispam-messagedata-1: WUbbRYzpIBnOfg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A7DC4466187FB4CB49D190B2908E5EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384ec823-a206-409a-c40f-08de83807394
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:21:25.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xPDAX2S6CNsX8CpSpjgRChscnKKRp5KEuxV1AfslQSyqnLISHX7CFbL6F0wjuwTfI+DCFCpk048YUhmG2NBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_172135_506011_E8B75B25 
X-CRM114-Status: GOOD (  26.02  )
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

T24gMy8xNi8yNiA4OjM0IEFNLCBCYWxsYXJkLCBDdXJ0aXMgQyAoSFBFIFN0b3JhZ2UpIHdyb3Rl
Og0KPiBEYW5pZWwsDQo+DQo+IEl0IGxvb2tzIGxpa2UgdGhlc2UgcHJvcG9zZWQgY2hhbmdlcyBh
cmUgaW50ZW5kZWQgdG8gYWxpZ24gYmV0dGVyIHdpdGggdGhlIHRlcm1zDQo+IGluIGNvbW1vbiB1
c2Ugb3IgaW4gdGhlIE5WTWUgc3BlY2lmaWNhdGlvbnMuICBUaGF0IG1heSBiZSBhIHNpZGUgZWZm
ZWN0IG9mIHRoZQ0KPiBsaWJyYXJ5IGF1dGhvcnMgZ2VuZXJhbGx5IHVzaW5nIHRoYXQgdG8gY3Jl
YXRlIG5hbWVzIHJhdGhlciB0aGFuIGJlaW5nIHRoZSBnb2FsDQo+IHNpbmNlIHlvdSByZWZlciB0
byBsaWJyYXJ5IGNvbnNpc3RlbmN5IGFzIHRoZSBnb2FsLg0KPg0KPiBXaXRoIHNwZWMgYW5kIGNv
bW1vbiB1c2UgaW4gbWluZCwgb25lIHByb3Bvc2VkIGNoYW5nZWQganVtcGVkIG91dCBhdCBtZToN
Cj4gfCBgbnZtZV9zdWJzeXN0ZW1fcmVzZXRgICAgICAgIHwgYG52bWVfcmVzZXRfc3Vic3lzdGVt
YCB8DQo+DQo+IFRoZSB0ZXJtIGluIHRoZSBOVk1lIHNwZWNpZmljYXRpb25zIGlzICJzdWJzeXN0
ZW0gcmVzZXQiIGFuZCB0aGF0IHRlcm0gaXMgdXNlZA0KPiBtYW55IHRpbWVzIGJ1dCBJIGRvbid0
IHNlZSBhbnkgdXNlIG9mICJyZXNldCBzdWJzeXN0ZW0iLiBNb3N0IGNvbW1vbiB1c2UgYnkNCj4g
dGhvc2Ugd2VsbCB2ZXJzZWQgaW4gdGhlIHRlY2hub2xvZ3kgYWxzbyBpcyAic3Vic3lzdGVtIHJl
c2V0IiB0aG91Z2ggSSBoYXZlDQo+IHNlZW4gInJlc2V0IHN1YnN5c3RlbSIgdXNlZCBwcmV0dHkg
ZnJlcXVlbnRseSBieSBwZW9wbGUgd2hvIGFyZW4ndCBkZWVwIGluDQo+IHRoZSBOVk1lIHNwZWNz
Lg0KPg0KPiBJIGRvbid0IGtub3cgd2hldGhlciB0aGVyZSBpcyBhICdiZXN0JyBmb3IgdGhpcyB0
ZXJtLiBHZW5lcmFsIHNvZnR3YXJlIGRldmVsb3BlcnMNCj4gbWlnaHQgcHJlZmVyICJyZXNldCBz
dWJzeXN0ZW0iIGJ1dCBtYXBwaW5nIHRvIHRoZSBzcGVjcyB3aWxsIGJlIGVhc2llciB3aXRoDQo+
ICJzdWJzeXN0ZW0gcmVzZXQiLg0KPg0KPiBDdXJ0aXMgQmFsbGFyZA0KPiBIZXdsZXR0IFBhY2th
cmQgRW50ZXJwcmlzZQ0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBM
aW51eC1udm1lIDxsaW51eC1udm1lLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZz4gT24gQmVo
YWxmIE9mIERhbmllbCBXYWduZXINCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNiwgMjAyNiA0OjI3
IEFNDQo+IFRvOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IEtlaXRo
IEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlh
a0BudmlkaWEuY29tPg0KPiBDYzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IGxpYm52bWUgQVBJIHJldmlldw0KPg0KPiBIaSwNCj4NCj4gRm9yIHRoZSB1cGNvbWlu
ZyB2My4wIHJlbGVhc2Ugb2YgbnZtZS1jbGkgYW5kIGxpYm52bWUsIEkgd291bGQgbGlrZSB0bw0K
PiBnZXQgc29tZSBmZWVkYmFjayBvbiB0aGUgbmFtaW5nIHNjaGVtZSB1c2VkIGluIHRoZSBsaWJu
dm1lIGZ1bmN0aW9uIEFQSS4NCj4NCj4gVGhlIGdvYWwgaXMgdG8gaW1wcm92ZSBjb25zaXN0ZW5j
eSBhY3Jvc3MgdGhlIGxpYnJhcnkuIEJlbG93IGlzIGEgdGFibGUNCj4gY29tcGFyaW5nIHRoZSBj
dXJyZW50IG5hbWVzIHdpdGggdGhlIHN1Z2dlc3RlZCBuZXcgbmFtZXMuDQo+DQo+IEZ1bmN0aW9u
cyBhcmUgZ3JvdXBlZCBieSBjb21tb24gcHJlZml4ZXM6DQo+DQo+IC0gR2VuZXJpYyB0b3AtbGV2
ZWwgZnVuY3Rpb25zIHVzZSB0aGUgbnZtZV8gcHJlZml4Lg0KPiAtIE9iamVjdC1zcGVjaWZpYyBm
dW5jdGlvbnMgdXNlIHRoZSBvYmplY3QgdHlwZSBhcyBhDQo+ICAgIHByZWZpeCAoZS5nLiwgbnZt
ZV9uc18pLg0KPg0KPiBUaGUgcHJlZml4IGlzIHR5cGljYWxseSBmb2xsb3dlZCBieSBhIHZlcmIs
IHN1Y2ggYXMgbnZtZV9jcmVhdGVfY3RybC4NCj4NCj4gV0RZVD8NCj4NCj4gVGhhbmtzLA0KPiBE
YW5pZWwNCj4NCihJJ20gYXZvaWRpbmcgdG9wIHBvc3RpbmcgZm9yIGtlcm5lbCBtYWlsaW5nIGxp
c3RzLikNCg0KIEZyb20gbXkgZXhwZXJpZW5jZSwgaXQgYWx3YXlzIGhlbHBzIHRvIGtlZXAgdGhl
IG5hbWluZyBhbGlnbmVkIHdpdGggdGhlDQpzcGVjaWZpY2F0aW9uLg0KDQpXZSBvZnRlbiBuZWVk
IHRvIHNlYXJjaCBmb3IgdGhlIHNhbWUgdGVybXMgaW4gdGhlIGNvZGUgYW5kIGluIHRoZSBzcGVj
LA0Kc28gdXNpbmcgY29uc2lzdGVudCBuYW1pbmcgbWFrZXMgdGhhdCBwcm9jZXNzIG11Y2ggZWFz
aWVyLg0KDQotY2sNCg0KDQoNCg0KDQo=


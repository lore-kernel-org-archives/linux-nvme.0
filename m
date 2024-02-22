Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F53AC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eR1oDbqfxPnI0VjWyQ9Xy+00wzRGaDh1TCphmKTnH3s=; b=S2t066Ai/OHNxz8y2EAqoVZu1b
	N1JvhxAGKzE1YcxGX5NQIMwFJ2Yb6erg1uitnaNYbujzEqYKF5epfycp21J2olHar5OUBe8xeyJwO
	chTlY5yXH358RwgzDHTmhr5OdOp73zyCCTpg87KC9NFLBled8ZFiMUSC/tiiwywBe68jupon6enxP
	YsRs+SysLrpwLU+BZenO3PpQTjgkfD3bpZngbzU+km/DKaIGtAtPcn7vCg27yg9kppDoGY9Kwu5pD
	08RGaLwJz67Pr+Iy9+psxvnhVqMOprvzZiR9Fp6iaOv0UfINCrQ9ZsTW4FYnEqFoiib2F5RtwOEpZ
	bvWRdtQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcz6c-00000003HFr-3j6M;
	Thu, 22 Feb 2024 02:46:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcz6Z-00000003HDr-2ccH
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 02:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708569995; x=1740105995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eR1oDbqfxPnI0VjWyQ9Xy+00wzRGaDh1TCphmKTnH3s=;
  b=Mv8z5w003ubM84QBPs2qPMHxLZAQFjY4znIy5PXrF525NXmUJNcusSaq
   lyxiqYXOUid42ZRCv00vZl1x8xpcNjMsmHOJKTa9aQYJuJvKCfjzZV12d
   MUywAVPZ3htFyS0KBaoWB7HcsIrkYVgs9KDUvh3TwZKLzr7PAwd5VlKaf
   EQ2jktHIzZlfOi7FJduwMAwCDtPUbfrZXxWuabDSNpuGNEarNg+YM39h+
   cklx6iju4/2nGdwOShYk3Gp3TfZR3exvdPfXMUu4D1zt4l9Zc2w5lKFxM
   sdb6XWPvh7eSLRfPi2Hf0BNCjCGZ8Dl7Z2RVlRlNx8CptujjQ+RdlEG3S
   g==;
X-CSE-ConnectionGUID: Fqb3sVlsRcOtWBP1SC/0ug==
X-CSE-MsgGUID: tTYXK5HlQbWhSo8ard0pyQ==
X-IronPort-AV: E=Sophos;i="6.06,177,1705334400"; 
   d="scan'208";a="9873977"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2024 10:46:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKX5TveuqMkd5zNdXFK6Yd3P7cPTAdJJTengf8ZF3wkfd0VuIsUK3qROx7/Yin7k6A6M9+6PzSN3r3PVlxZ3g1ZoP6v4hNAQpDWeTpibLQsVqE7U9e1tbr0uBIWFaeiwoZuQnk53hxLzlbl5KaRGZr5zrY/am6jzLjNIBwMwmMfYU9UjRvrdc/rW2hUAsKkXjFUh9/gcJmhT0kaDgi+8ORv8USiD97x54nR13q2B9a8ZLI/w+UlXAuGf9ZBxqa7LwUVKfxXWxsqnJ9LVWsHII87Cnxrh5uleIxekwunKgYd+baSsrgjDMQxWRVOyCjchBTQyVW6TkT5weX8E3yUwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR1oDbqfxPnI0VjWyQ9Xy+00wzRGaDh1TCphmKTnH3s=;
 b=Ztm0yiNhTsa6sys9Qr3vDrlJqvLNiiMj2Ch01C3VvbgAWxT2XL4NzhcMmUGcleQ7KqEIZsmz7lsDO0N8QKvqSKFEd+G5s+mePTir6/E3inqkdLAWZG/IeQYO9zS7IIdmhUNOfjqCliSDcTIHWs/id8ZJc8PqD7HYy++Cs5p4szdCusj4kF58RNf3tG/IozpZdkC7u+KU34VdxftPCa6ro2F1+CcvfL1XTqW92zgNQ8eK6RKhgt3c7plchnBTzzhxYUbUxUjLShx0LY9MSLcA1JleseXCNy+SIlNCxEnrnNXD/juqX8Mcga33Pdhupf5LotY/NpMIEr+SjOH7AgfBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR1oDbqfxPnI0VjWyQ9Xy+00wzRGaDh1TCphmKTnH3s=;
 b=LCiAXUGSHDJzwUurP3/qhZe3/a/x3UuIhCZs6nlRx0RxAjyeFUvx1yJ/FvaXoZIQr//1pLd5oBTeMoBhFoFQioqo/TGAOfKlyg0Q/RX1UBlXwhKsWKE1T8ZmDUXw2/1+MrLDEew/qlpXA/y+a5dsPvoGdJG/68IRlLNDIYkr0wk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7696.namprd04.prod.outlook.com (2603:10b6:a03:326::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 02:46:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 02:46:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests v1] nvme/029: reserve hugepages for lager
 allocations
Thread-Topic: [PATCH blktests v1] nvme/029: reserve hugepages for lager
 allocations
Thread-Index: AQHaZJm9i7Z/bODUT06C81iyAUhvzrEVqXWA
Date: Thu, 22 Feb 2024 02:46:28 +0000
Message-ID: <welch4foon42wuf7yq4t5wwmhr3nuc3234hdgnxpqqphb3knhd@i55tlldbwwdf>
References: <20240221074353.27646-1-dwagner@suse.de>
In-Reply-To: <20240221074353.27646-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7696:EE_
x-ms-office365-filtering-correlation-id: bb8372a7-e8a2-47ec-281e-08dc33507845
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAvLtCw96oAjGuOHsGjS7m0HF9Q/T7bap2z1JZ69lUl4h7d7RN/Gl0Ek9QNTPcyp6NSuXnrRDdqNj3DA4pN6YICdp9rHmuo8I2YBdOme1o6E9wAILxeJX6+3GfGl5WhON83RZzrLHv3oSRwteVY1WGhRxj5STUaE9kwERFDBFv+MI2xBX2E53ji+ebhmEfcahRJYbZJpX/++qnmWHAtDp6k49ZIh86uhsig4eQlohkyq8Ym5pk4tklHqCe5WsgpPkDVUF/Jpn2qNDYd72LHIfza70AJvoJB0dCH8vjlIg1hNcRIdqz1liS9R56Bi4KbVvhOWzGA2B+iz718bChEgkMNcLmqbsZ5RIdKyrPsx9AF7Iey211m3J4KQR+ur6p3FWvJE0zcf+pToJNkN0jEAkKauu0KAkr+y89B5zL5Qj/tLqCgjIbMXEA8953hVGERa+zaNXKnvT1l3pihijJYoUTpRxlyaelmXC/OCDbLSXPf7N8PyhSviJ6AfgSLGms9XpAglxB4IXiSK8bnSRxq+pbZZO2JCOnJa4CQSgTghL7ZsWIEjjm3PlrVwzmn8KJnF06sK2pgFwF460upSjZW/vVHnGY4HXzDN/ojgEpxk330=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1MYYoh//DsgaTmlVIiDK2c2RfEfu1WLEWbTuNJym0OoD/Z9X1cUu6/YW7wur?=
 =?us-ascii?Q?xxn1mOq+qcDkvVXq6TcvXbYt4x3yYafOLtyPvO/jIyHy7VtR3xTScD+8jRzY?=
 =?us-ascii?Q?EGZdd16magMVxEBUfyzK0Ix5a+WFF50fFSXA0zk/aDbZP8ch70R0mOt+MO6l?=
 =?us-ascii?Q?fK77KazLhWEH/BQrE9Ryta/uEQT4SpKXxal6rRqs6eOjyRuxztmGkmUvDvFY?=
 =?us-ascii?Q?Ikxu2CliGaT8Cs2IM1gPaRXpCvhpjETOhdVQIoyh5m6hvZvmepZMTKEO9HXG?=
 =?us-ascii?Q?v2+9tdwnXFJwtIWvJH1pk5EIPT7O4AmaTv+JWWD+DzUCmpHa4ysKXulfCI7u?=
 =?us-ascii?Q?/B4Ff2YPJqT85IUsIyZ5Nw8x/JkyHQVooilFTkZ+NhMTeANsQgTJQyOZu4rK?=
 =?us-ascii?Q?P4H8hjLQDuNtBv/kjGR6DL4uU/MSIzYoYd6r1N1FKcNeTnx4bxS5t3CC6tuc?=
 =?us-ascii?Q?f9b/j+ePejOHAPWgIQW+aq/CKmHwaVDwlElZR8fHm1D3GmFY8Spgc3EnuksT?=
 =?us-ascii?Q?C0rdl885BFAUUdiIb6vX60ibQ1bcH/tU7sGvs3DGO7KK7Xfs9RIfhT82ZcJX?=
 =?us-ascii?Q?jmjDNMrW4BOAgSN8cteWn3L+qG3FFn6cYL5exEx+hO43eNTiZmHTdczumT7D?=
 =?us-ascii?Q?DctxuN8Jb6U2qJwyNZUihy5csPe6kW8bA1RQQaNfVMA5BQuLPFacrjuF8yur?=
 =?us-ascii?Q?xZ/+imlY/E01t/PPXTGSrV2LljqAX3tY5hy+kCRdy5Zy2lm2CUtcgEGzPgJf?=
 =?us-ascii?Q?X3X6aoAI7yRaQL427L67XWd1ib0QxyJQLnp2vMr3CnrF+Qekc1+dXXzIIF1/?=
 =?us-ascii?Q?A39IVpFCCZoYDHXOARLK5swdO54j534RwklBlkeCSuZvGtzGX3WhxxETS9G1?=
 =?us-ascii?Q?GHnsEahKtLlSZFiwrxfkyTtmG8OyYAJTeVd+HMHvc9y3Zhe17hEIbFydepwe?=
 =?us-ascii?Q?w5P+sjOr7tkytd1BJzTG2cVqiEZrLofWg11/VM+1i1cBwoJyZOYrgpulMxbQ?=
 =?us-ascii?Q?lYx32UBHNShWChlWDpf5/dEhEXpB8430ZRqJqx8jqdBDmWD/0LuOnH3ZGVtc?=
 =?us-ascii?Q?bFUftMXZpwY+i81DXt/1dDD2zDRoHMXqJb8zI6AVqJHAHWl9u2Q5NDCdwirt?=
 =?us-ascii?Q?Z1zYeYxfBoPxRwRDhm1smyg24P0FqfJtAvAk+hJN2YqrdDW4je/I3qfrabXc?=
 =?us-ascii?Q?8yTD/FjR2qoBW2rZop/vexjzyOGkbOkdUn77ub/YRfgw1GuBnaOutPLF9eSd?=
 =?us-ascii?Q?tKbV/nhc8LQOGZXE6F2Li2cMc5HmvBvWWxtLQ82PzIhxDiWvEYnOXeswTXAj?=
 =?us-ascii?Q?FqCwJNle0K0byD1+kggSAgqzrIETlNH/Xt2162nd2vyBX2SUCGQWfg/XIsCY?=
 =?us-ascii?Q?yncYsiUYbrGSMY1ucHVDbetpZcXokQkJGlX1U61SLzRVeP9/NRbnEXOtuCjI?=
 =?us-ascii?Q?UD9OFyjvuxlDQT75d4bfDw8+7EFbSTVIGMKjm7dIxCdCTXiOh4IR2seQFeF5?=
 =?us-ascii?Q?SBYCFTU3C3QGyuzyBA8QVbh9dx+mmH4kkUEb/Ahm5zTLVgkFFdBRBV7AU1jn?=
 =?us-ascii?Q?bjGZtq/9IPL3xED2Ez6NwO/1BbudhehBmyJYmHCPwalLmixLKwdY/rcUB1l5?=
 =?us-ascii?Q?/PlByubcrWo4cdCVAEc/R28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82B9637C0104F5488C37EB05E24476E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8hSG+fmsMCu3duqoPozYFVi6kmNeEwEErdIzRLnA0h9o9/ECc1BaIIZxE706QJ2bnLWO5XDm0hLJggKQsWmLWkK4ZA+DFdvZgnbAemY40HIR5AprZ+rRcGkA9SrMP5Eye0OEQ0xxO6gTsbjVowKAYVdUsY7ddQ693/JGYj9czjtatsWNDbwxCeNI9FTTaZ4uanQfONgcXM/w1QVNu1ZRsWmwXvSlKwW2LtrefoLySqIKzb5NgKJM4T+YBwXK2+I19YWXZ2vdUEjqsSQZWObXvoBSwT/Siva7/o2d3EjUn24vJcskOFKxtywNxAgdXl+hyBg2cuMqwgTxA63sHa6ce1rz5WVuhuaI+LiavGgA7W9i7r5eodHZBUao4gTSdcrYoJ5PNEXlS/JMzF/VG+uxI+tjuieIplSLhL0Un5F1Fh8xT1nmMQbDQJ+gGvxdK9E2Azbwoe1jaU+sE6/yITfDMX+KrH+JiYkBWZrdMsxDUDY2VoeRM/H2xcCa2jmCiC6yvlTWAL7TtOTTJiEyfEeH4j0UNFhQKYfriFuJhc1k8w1U7JVwpSQ3ROmFaOHAe51Lp4E1nKwuARUdYdheJboNh3TbcHVXQaUf3WK2JEQwfOrvPnnfF20juQropTfPh2ej
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8372a7-e8a2-47ec-281e-08dc33507845
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 02:46:28.7364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRjjffKL1NDG4GATZbXJhefxhddV0DA6IniNBYoMejHFaZwnDx8f0IsfyQkSB+wUmepRRbHDJOHIaROd6IBDgNcihebRh7+QpKThtp5uDIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7696
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_184635_776496_3F325A27 
X-CRM114-Status: GOOD (  13.44  )
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

On Feb 21, 2024 / 08:43, Daniel Wagner wrote:
> The test is issuing larger IO workload. This depends on being able to
> allocate larger chunks of linear memory. nvme-cli used to use libhugetlb
> to automatically allocate the HugeTLB pool. Though nvme-cli dropped the
> dependency on the library, thus the test should try to provision the
> system accordingly.
>=20
> Link: https://github.com/linux-nvme/nvme-cli/issues/2218
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Thanks, applied.

I note here that an opportunity is left to improve stability of nvme-cli li=
near
memory allocation in the test case as discussed [1].

[1] https://lore.kernel.org/linux-block/99bba6e6-1ae3-49d2-842b-680257cedba=
d@kernel.org/=


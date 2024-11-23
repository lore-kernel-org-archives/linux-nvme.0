Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3350CE6ADD5
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 07:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MoDmHmZgCKimHKT8YgdFZ6QgJySChUCr7zRzwsKp+Ww=; b=RKZY3q8SD0UhT/B+Bg4rlKT5Ox
	bd1+zleHKxhrhkSd/MW0gE2lYYrLrK8a3eM8n/nnHhgzYQEIXnx7yCKjSnEllA5yFmF7oaB1j0OTX
	QIlruGczLXbbddf6GBt22zLt3v2qSt6BTokMZnBf7JAJ1y2L23LR0sXnqQ1NYhgum2aSoXwRcf9K7
	hzXTEb6qdnpqyK7gm7JUnnxx0bwWkcw6fChP+QeJZ8CLfONkuljQ3LyLXwyH7RnGNF6EcOIP/FaA/
	iC3oFuE+W8mq3jtVLrd60kaojYJLjZAfMcLmzQtGfxzdQAYbg9vMUkdkT3YRWCXRYP2blPgUxBkWh
	JFlWNJsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEkzy-00000003v75-19wc;
	Sat, 23 Nov 2024 07:56:10 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEkzv-00000003v6X-0Cbj
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 07:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732348567; x=1763884567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MoDmHmZgCKimHKT8YgdFZ6QgJySChUCr7zRzwsKp+Ww=;
  b=KWydxTodiGDYI2vKtPdrRMGqyiF5goNnJ48hr9cqkmB/sJHixnBp1gWr
   +CnXZb4Vt580aDCqJOSKVZBCt2ywle+7gHzDSslQnx6g3RRXQRx229R0a
   c+OGEu3AUfEBUJNgfreRkyvOkKQ+v31TNwGoEjtzq3iAKHBUs68ZTUf8f
   4T3Bd+D6m1VzuXxzirbrz29ZHzehzGNoRNClvRy6KNn/wKyK6LK3ZHGvC
   4Bj59PaJRvQd/QLwJzVMRc8SFFbuJz0ll/lZSOIDwJAaCn48Vxk8NBu7i
   hFqjVb4uxPohi216U27cxg/fkxjL1V+p9DrGs90whIUtJp2pW/LheCHyJ
   w==;
X-CSE-ConnectionGUID: P/pcXZWDTWaJjUcfNlVEJQ==
X-CSE-MsgGUID: SQhQRuhTRvyq6R0E/xjvAw==
X-IronPort-AV: E=Sophos;i="6.12,178,1728921600"; 
   d="scan'208";a="31539270"
Received: from mail-westusazlp17012036.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.36])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2024 15:56:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJB/9jRyyYpDpwTcpzwZzzdIQWn7D8E/g1R6U2tYC4RDIX2LB2HVu9lmNcnSrlvNR2VEqMF5N+DbC395xbFMBB3zlx5JsR48b7NIwZkb0UiTFw8+KU6xkqjeaXceOcSHsgnJdunyIYGiJ2NRx8hN/zg3CaG53yfEZoP0Rg18lvJoO/4KQ96Tp05l+3dLEa8isoULW6Vs3Z0v7t85EAsILdP/QOWYjsRpOLIp/IKnMVR+COZRJ5WpuJvzzeK57Clj2SaJ/Ww9q3SCQPQyBNzciBx66CoUk8G88mqsZWanZxs4aGejKCLqoTCEkVPDM752DaSMEnkCRl/WW7Dv/9iIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoDmHmZgCKimHKT8YgdFZ6QgJySChUCr7zRzwsKp+Ww=;
 b=t/JDs7IJws7N6H/lkhsV+xNyYFjwRX7k9gwvozgyR9PwcpPvuDIVKsIP5uImvS307FJa16XA3RUUcfna0ADSdgFXKrGQCacLkicFW3lqFE2iaigP3F9nONOj8EoAQBC+/BsLe41wnhG+zWw/tppLBe3zTCh/EvDKip8mRYhqFDJ0VDHkmhbaRnMPKoQLK0E1zPb/Ptr8CnLVlhL0Reao7UxcekCLjqSJ7f8fgymu10a3PbHc4ASnh39KKg+p68qnLBLv/yta/C6Uxj1bgklFyAPaJ/f6UXLNKTejrCiM5CW1Pa7pfHkubZNfvVmg+B8XI2ToHNehTlvJ5fsdnD5L+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoDmHmZgCKimHKT8YgdFZ6QgJySChUCr7zRzwsKp+Ww=;
 b=knsy2fn5Z8kTUzDYmmg9GUa48Hf4ju3wW2jpuvvVbRMtxPVNUwRtbALVS8Mu0i+47CUVoAC+efD4941arOvlM1FuEY672jQE3tT1EGuuDQlr9P17bkgGE+T4sS+doZsWRmGoZ/9BPxLtr0SIilsFkwdR0uhsHi/CaXPElUjCLxM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6434.namprd04.prod.outlook.com (2603:10b6:408:d6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.27; Sat, 23 Nov 2024 07:55:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.018; Sat, 23 Nov 2024
 07:55:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Hannes Reinecke <hare@suse.de>, Daniel
 Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests] nvme: delete all namespaces in
 _remove_nvmet_subsystem()
Thread-Topic: [PATCH blktests] nvme: delete all namespaces in
 _remove_nvmet_subsystem()
Thread-Index: AQHbOzXlfg7VOAkExkSlP7/7+nJgubLEg9cA
Date: Sat, 23 Nov 2024 07:55:59 +0000
Message-ID: <63x7nishrd7vuijvjwplqp57ba4bpcqd3n3rnwlg5pgiyohl7g@twmxnsqtvdip>
References: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6434:EE_
x-ms-office365-filtering-correlation-id: 79c53d8a-39f0-4c10-6c51-08dd0b9444c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RgEPRLfPMfC+ZJpyFfkBJ1PF2E6Z7HLDVwsw6aZLZew08SziR2zWWRsJC7gI?=
 =?us-ascii?Q?89UyrU5ZfHgHq+MWT6OFyzX99zu8Ia+I32UgjO54LEqB8K2s/bbW5aKXnHJ6?=
 =?us-ascii?Q?wXPxZZsUHMrQCHFG/zt2K5B78PXWfVtgivjmX+zLdKHlBrBbnbVtc5r8S+gB?=
 =?us-ascii?Q?mevvWnrxNK6Y07kY9HDPPpWjxj1zeJLl214q1J28tr8Uae/8er8CGukmaOy1?=
 =?us-ascii?Q?xNEmDCwpUGDebcGfqndM7FWQ70w6dqeBebq/acHXoK80CurSO0gh+k71umsA?=
 =?us-ascii?Q?1njE3WuAm3Or/uX5jymt9T9MYl7TDuRPNI25l0v0QfZ8aQo69TWYcx1PbMlT?=
 =?us-ascii?Q?2amvGb0PAU0IP9N572gh75x8nFPkzAn72PgX0VQeXCu9syBpoTDXYPbMa6rN?=
 =?us-ascii?Q?GnTOr7gqSUYVJ4bWI0+jwhwYPZ61CM3kvtwr4dfoLr8mX4Fz4mcr4kjYlBiG?=
 =?us-ascii?Q?wQWnqWxKG2RSqM9AV6MlU04y07ahAQb2pgwr21GU7ADFD23aj+cGxRwjaEaw?=
 =?us-ascii?Q?GRXkvQy7lMgwaZ/frzthVmOyhQ3fSymmhBMvEvQKQEKWTzm4DVxU6vgbSGnl?=
 =?us-ascii?Q?vmzLEQb1H3HqA4NBVsUvQJ6gryCMhYaV+NZlNWKHY2+ho/ZRyphipec98rKY?=
 =?us-ascii?Q?VQMtDP8rpDzP+4TMXTY6+YSl9pJItogHVk9YEOxvNjFn9+l071sllKPKFtC6?=
 =?us-ascii?Q?309AtIXWgLnK81gYC5RQAJVXG+nsbi9uvTkAvMudUPiKJKCeRePIeY62874z?=
 =?us-ascii?Q?s1lj92xtE8jJ94VNId7+cU8IuNP4QO+HMRYLcIrYG+taxJNfCzTK+4VPUHV7?=
 =?us-ascii?Q?AvBnczM12fvK4IxY8nfGuhcGhpd6v4K/nCXg7WrIxJZ8scTiOMKfyfjeGiSV?=
 =?us-ascii?Q?PdrXyG80N4Gi8uCZaTirajjTwRs3wSPoDGerMBmhfu6vNV0FyriSyOIGF/aN?=
 =?us-ascii?Q?vhaWsX707O0QFlNoQGsEzXzrDLl14QNVOTD/dc+m66vmeVJoBG16iuhQXE0s?=
 =?us-ascii?Q?jq0FNHjz0KCJmQ66RRg8XZhbN/7iZOCv0+bjXnI1QpyTj0LLDTb3rv0F6tRt?=
 =?us-ascii?Q?RWJ3wiJgOpIaVYtr2FEHmapvw8J4TdfWwhl0fWF5WWTsUDH0m/lwgTqkZqut?=
 =?us-ascii?Q?dWhvHd81WPufAMVKwcs4v4YHqv69K1jACoy74JTeKu9wJWCOTQ2r2TFzOOI2?=
 =?us-ascii?Q?C2OwpGpRa/HfhvF14ftqObggxw1NlF89x7ev92yzUkdgAPVDTlV58yfSKZPu?=
 =?us-ascii?Q?+TPCuUQ2yLkJWD9DElSoLiGWDlpkLdF2ljKg7kfu0iJZNL+kUhw6F3JPZYxE?=
 =?us-ascii?Q?Bh3degB0tdRey+PBGGT4X8WqfFbat0coQQQ/f0bQtOa7DeZPptJMnzfvIwVT?=
 =?us-ascii?Q?JrXzZONsafcIjS02fqA7vykSgyMKv4BeDAmb6fltK4yn65qhNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aDQ+weMkdqk0hUan94JLkYpTLPoc9mHpWB0KzicG0r9eTsGvEdgykpWDVQnx?=
 =?us-ascii?Q?wVBlDjFSg7iumOMgyarKyJNEr6ebkDQSgUXpHnE/leINRrfkQOhEBZhkNwGc?=
 =?us-ascii?Q?jMfCMMKlyj7OCNA3KMDsui31yrN1svaA5W24LDdmMdfT08rxUxdF2gHczulM?=
 =?us-ascii?Q?STj99L7av/tXnvGc6n3MFqabJLgAzVwm0M/HdZlU8tiueKfysxtknbDS2mlr?=
 =?us-ascii?Q?XX6HH1f/9NcDYKlB8w3JmyCsultfcpcdGuiQgiRQgHuYeY8nuBEJb3juBzhn?=
 =?us-ascii?Q?iXvE+ToccJu86g7wDdiPAYZq1YZ8+diwV9PmT/OXMSIjMgF6Ek1lCzTHIglR?=
 =?us-ascii?Q?X0IdF/AHh/lVwQARxDfET6tB8YhUjDPx5TP86CBGz/Vc7fJ6QUOZtS2NggvC?=
 =?us-ascii?Q?uedren6d/x2W67lFSu+CO00Ihdlk8KQDbqETxKL4Yn48PyZyxiNaVQ5XZ4WZ?=
 =?us-ascii?Q?caoQPnqRC4qqW9OI52aC9KAKqmESZhVCDerfD02EJaqJdbw7kScuc2mJ3TdY?=
 =?us-ascii?Q?TYunpQ9g+R0oclsrWx8T6sbVOgW5PrCyaYNGYiRl3OTocDP+S5B36yI/ZesM?=
 =?us-ascii?Q?KYCmL4ExuPZCO8gTeD8XyCFdOLcwVzW+eDIX6djDtRNxwX3zHwIvRfjB7kCn?=
 =?us-ascii?Q?Ja9eN8fE6nIvTKv/JFEHIk5XQAe0g+32kZlZwqH3i9OvBfJZAD7urp03YBtS?=
 =?us-ascii?Q?F+5ZF/vHBloQm6qquyK/bCwdBGzfGHBzWaAlh3Fpt3+T26UsTFjVN7c8MQTw?=
 =?us-ascii?Q?k/gVmprDN1XgV8PeSsRYgh1Q+SqAXTLuikMpJbMt9cPo1wn7Cw+Bs5nzrnmW?=
 =?us-ascii?Q?LTui8ZLQXDm1LX1xeV0/3B9LOZrjwWY7r7v6GQiqOduhRx5q9+k7+N+5uma2?=
 =?us-ascii?Q?/WPhwLHlK0baeIC+zCHaoHwedlO0Xn1BLJm/0cE++iRGvmJTnD1MMgcOTHOD?=
 =?us-ascii?Q?bQKRapRBveEnticiFAq97iOlDPP1o1kWi8Zh2gwM2eD5JgQU2XGGqXz8ik9G?=
 =?us-ascii?Q?ydOeXkPSjATBZjRMtGaDPmUFEDbh0cnl67cN9YEf5NDudIdl4BbJP+Ljn5O9?=
 =?us-ascii?Q?YW7HpCLvGu5rM4L+TSKfthUkxgaNX5ywfapdHbouH6qwXc07rf+Jfvq1HBok?=
 =?us-ascii?Q?D4wrdd2cgGb64/sSK889b0AlSdGmCeGYgCZFcpFSmbULEyTS21ivx3NpWMJg?=
 =?us-ascii?Q?N+GlPjUm5Bu7YXK1gfJ5YKcBHOmiucpKtSWrU8hIa8nWT3SSeJTOuHJFlBzp?=
 =?us-ascii?Q?0fNWLDMN+MPLFOtbZG581v8BsnRbgCqq3rVPCiGN3dAfaWRI5Vt7d8nD9fbS?=
 =?us-ascii?Q?aXFVZPZ2GUiQutRFi1rAWkAXxbGKB1/6R6Kd+oL31uV8rjFWCu8+EEVY07pV?=
 =?us-ascii?Q?8LUtD3QcAoFRjTpc8Ijs32P8uM9F5WnZEZbYfO+noUCZrzyCS0/uv9Ceemhn?=
 =?us-ascii?Q?DDboeI2S3HNIHAvA4L8OfWus5SSGw5L0SfftF527PtXkAYRgqx+7PL2NJqn/?=
 =?us-ascii?Q?tNKidgIFD56FBCcIry7GjrAdi7PzvB+k8NUn9GGhS6w1uMAA4pEGuBpcUd+t?=
 =?us-ascii?Q?iMhp/Gl0isHB+OQfc4QXum93X+saBi1PzXQTyJPSuNkSqimyGoBRbaz3KjJl?=
 =?us-ascii?Q?HgJrhb8PJJDkCQP8HN7e2Fw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4289D3FD036B3A45B84EF084D79CCFE4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R5ACXPQ1UYWBS7l9dgu6roK22edWD4x6f/iRXazD0Jjb0rDZ1ILh1He2juoJU7jXlDJMPtTumZuymOwtRZcUdfncyUQ1g5ZJrCqE33gjSKKV9g109A7uqlSXdMHZdO3Fj826zeBg8wnBufmyJ/s2xBw0wKZ4pgTBRym7VL5r666NBi0YzUn0CifkaGyCoaGSXAiwNd3WX7AzKJfo5MkZMox3wwJikTrfD41ssKXQI9OzDSDhDSXd53iLs121sbe5R2W+8D7NeH9RtYGdysEWphcpANx2f8O3O9X//VHhefqApdSsSw3tWu4bTeCdki5HxyHa0KWjnvEWhIzatKCxZCcxrkv59qtTMLV+tb4K5HcL7I0yxFymq6bHdzp106CgfH34wv5QXnWQgFonZfjuOxvnSKyXTCIriKP9oVZQqUx0e/RvhIcALrFDBbNnGYonPXs80rek2Y/QgNno6qAZGW7WDn/pnON22LbxNEP+xqlHNcv2BD8zNEor5bLakWFxcYgIjsRB/e9KI01/dFiNFQDj3PBkNwnlsFIP1OFFjrE4dm1urf9D0bR6Dk+OWj6YUAKyovdlCJ14Oso6IaBw1/4B495QH9/I5GcPBMPqykVcxxqlxrNIUX/fRGB0T/hy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c53d8a-39f0-4c10-6c51-08dd0b9444c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2024 07:55:59.3346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWhLQzltu42NHWR4eArhRaDYnc9Fn605VUlfsMRSdKoCH6Vu2uQHQex4RPwOySzgYOyTyq8qT44CabCL+vXT2Vsgcfr+jBarIcgZuALQLrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6434
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_235607_180899_CA7E8F3E 
X-CRM114-Status: GOOD (  11.59  )
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

On Nov 20, 2024 / 19:20, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
>=20
> A subsystem might have more than one namespace, so delete all of them in
> _remove_nvmet_subsystem().
>=20
> This change was to be made before the commit 67e25d71bc58 ("nvme/052: do
> not create namespace when setting up the target"), which assumes that
> _remove_nvmet_subsystem() delets all namespaces. However, commit order
> was modified then the test case nvme/052 now fails without this commit.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: resolved conflicts]
> Fixes: 67e25d71bc58 ("nvme/052: do not create namespace when setting up t=
he target")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I have applied it. Thanks.=


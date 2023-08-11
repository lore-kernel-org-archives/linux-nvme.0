Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EBBC001B0
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 06:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzCYvdQrMeDO6W1RvFOkCB9mo/IsKqc94hgkqQCzOpw=; b=FftEMwZSQTmLgqM35JEy2W6o9F
	+jjW79k+QTU75O92+7xvnvsp+oQmn4I4zBIX3onCkSOgpbO7P4sVcerg8n+jlsmb6XuGVSk4t74uP
	eQUcgjRCLE3RsL0r9DCOK61kV2MsQ4whLhPBcvTMNrWTnry84Rua48E5GZV0coiKDI7IP64HqS6SO
	8b5fLFirMNBTC884z72+hZIVPc+3gGLC6lp6XcVbZQdXC7xUOuDrrG1yp+PyjHs9zl14Xlq57lHMX
	tb8jxfDnPq8Sqs+/w+83nz3WqOYajg+RI9iEQSF2gx14B9AErq/K2BBDJc7vTE7gWqGHnNlqJ9TY2
	jMmNKb1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qULEY-009Zer-1W;
	Fri, 11 Aug 2023 06:02:50 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qULEU-009ZdK-0g
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 06:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691733766; x=1723269766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zXuIGf8Q2Uz7Escv6ITDXK2Legtm/yW5RJBKiOIeFCk=;
  b=fAb8nRDWXHq2i2afmhN4IP168trd/nOh59pEUzHFGCpEbf3gznMmmGWd
   j0GjUAjQ5PmDB0XlFnyfTu+ffgjxQL+542gpb3RFcSfybdZ9riJUM0ezh
   +HkIo4UPfqXDHdfIP8TWIoSQK1lrmuAY48Zq8BvuZOw49ADRq9lz5rTfd
   /7FecFoEKkZwQ4PQJQlTPDwBrJSyvN1awRfzHk+sMUeMW3UoK6UGEdR+s
   V51zoj4MLQ7hOgZGygdkoPrj2WScV1zWVSq5TpgN+8An9bjZagDCAAycZ
   4ZJa2n1aVDFr1fSx79svlE+78Qo87gvwAQ/CPG/dFL0BrKcg2ToUR+613
   A==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="239019171"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 14:02:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqNakIVNnP5HgfXJ8tzaxHcMk+a+QAcHuWOOnrIRqwQ0YQXwF4lZSz611j/OnKfwXLIqiUpaYVkF2c02T31gJ89Q2NoPiCnhngXOl8LQuosxkznVGx66YNTBwATOprhT2sa/BLAFRTAiPwfNtaRtozsDJdSQHIpBxtBrgayKiKHWfA58vpPaLLtVyji8wuW3nitLz3qWEbmVga0A9s+p637YzZnzIFaIlMpIcTKyeOvzqv49usJ8CARTPXVgAFhgpOcYlpOAsIux6ZVwu11AkA6zVjVB4Hm1QkCQ/yKQqSl1bCtrDCqZfgWp7cESCsHJ/uafwXYp3RzNJ4jgxaNTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzCYvdQrMeDO6W1RvFOkCB9mo/IsKqc94hgkqQCzOpw=;
 b=Tlv4Iaitex4dSeIZeDNYFL3ZPaKIY7DqUwy5oD93mjByiksqB4h9fUr90X3i5dWflFRFX2/+J1J2rwud2oUhK+IdAoMvZZhHcRMGJXRqQLvVi8FUD9yR9LOxxTRz+M3RcjF8JgKVdlBOR8GhjoPaciDbdje2SnucW0izNpWiRlUD1BrrHxHFwRFxBi8nRFS+g29FMNriFqa6UkcynKixFlxcqSEUH3DnArf2EPENsgGbs6nUIOJau0AFLGmINMAgNjWr8HYBx6lybNg2BJKeJeznD0lgSbusBVXbw3X5b+LhbGxNOT9H367n+XkzEEjqbslK9vNZXr+wMUgI1BsoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzCYvdQrMeDO6W1RvFOkCB9mo/IsKqc94hgkqQCzOpw=;
 b=Lk9eg/rti2H/ofr/f2lmaGgbX6i0s2SEZ305CrEZRwFY6s+oUF2JI+L4PGmPjFMgpG+xRLs9nayvMKTkSK2uGmlQ8iV/QeaNhZ5uYLTTNmZ0YjcIlMTPCnFtXU/bFBTF3U6GzHecyT0DEbtI+eQM2Okr/dVFJ9PQGkITzGQV7Ss=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8716.namprd04.prod.outlook.com (2603:10b6:806:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:02:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:02:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes
 Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 05/12] nvme/{041,042,043,044,045,048}: Remove
 local variable hostnqn and hostid
Thread-Topic: [PATCH blktests v2 05/12] nvme/{041,042,043,044,045,048}: Remove
 local variable hostnqn and hostid
Thread-Index: AQHZy3uz1xpR6Nr34U2dUvx8v8aZKq/km7oA
Date: Fri, 11 Aug 2023 06:02:04 +0000
Message-ID: <lbjgs7ebcywpk2nyli37pgpco2xgbprq7jexm7oksv2dbrofam@u6gbtsmcqw3j>
References: <20230810111317.25273-1-dwagner@suse.de>
 <20230810111317.25273-6-dwagner@suse.de>
In-Reply-To: <20230810111317.25273-6-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8716:EE_
x-ms-office365-filtering-correlation-id: 65d7488a-c56a-4807-964e-08db9a307c86
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGGqDnEgOhb2DaykNir/kZO/iHXDI9JlAA0zEWbx2qrCwIPKE7lI7Uckn5yCnjQQQVvtGh/Qp9u9f2bLa55jpunp5hQzAxORFueq0tmowpVOtFSswwFVnDEDPbCAHkFA9A2dNXgdXGmgLzut4T5FTQ2zZVdyk6qfeTVHwb/52BELQ7rWkrZl1t5GvVqX9rYWNI456Da1mwlc/mZHt/z7gt1xGpeLuvB/dIKu/VwSX/hfI/dwaTcE0Gbcwg+kGJjn5AtLRo0YybKX0vVKWcJJJxUpeqxuwMUrSGnVMdIAFiMu1iADNbXRinXYEUQVPIIjUOnvV0UYC+oADJxcIjCX6Q9SdK7Etagvwka006qnrWYcZ0vsOipuq/S1WX65J5UDMfp/XMz3Ws5lMOeS2NU/GNCpn+TQ5nZWcVH0mSfHaRyMIzg6hIgA4sUlVfLgt2GonMvId5B6h/3QOuycPArLx50duB154YbWRJvYITi/826lAeSBODwpKnqvanDWTHX9tFYAl3Mnetbfc/ZkZ/w912lTpVFjEL2/rpawsLcEvy6cFaVZ2+RU9w7TEgLw9NQ9kmGTCEUJBFoquh7+W832OHlli5WPnNC0mjs0HteJGz9Kt+IuwAm4PuWIvmVasz2G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(1800799006)(186006)(83380400001)(38100700002)(54906003)(478600001)(91956017)(122000001)(86362001)(2906002)(9686003)(6512007)(82960400001)(71200400001)(7416002)(6486002)(66946007)(8936002)(38070700005)(44832011)(41300700001)(5660300002)(8676002)(66476007)(66446008)(66556008)(76116006)(64756008)(6916009)(316002)(4326008)(26005)(33716001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pvhW7MbiXSZB4Ir2aajpIs1CtGYuW/jektj3lGLdK354UVmixMK0vZA0/4lF?=
 =?us-ascii?Q?hzMqYYM/sVr6vVnIaPWJXtPYQlqNwYkHOG1ao/JZqvCAc5xUmFulidiDIR1T?=
 =?us-ascii?Q?M/jnGGdhMkXY17RP4IRaUtPAw87p8RL48Jqb2NoiKSLda3pRxH0nXc3AjdwL?=
 =?us-ascii?Q?CBm//u1d15s6ko5uTXaNUkgpwwP7oIRSrZ6fthttR/qzd0+VfU1vPHLtFZrI?=
 =?us-ascii?Q?81A7uWmlKVNKKluitVFWope/iUcGon+yCq6V7ibpIRMKHJxU0D/03bpa2GjB?=
 =?us-ascii?Q?i9Ixo8igYl/Jq6BTGxjCFZbxYeQo4/ubyOTWHIm/EqX53qA3YY+GCqYQs5bD?=
 =?us-ascii?Q?7El8cjhHY9JTqR8j9bKaYyWVsd6EqCKo2dZ+MK4Mq9WDadFgQgCeujsSin4d?=
 =?us-ascii?Q?dC1XvN6Gmq0DUBJA/5daJDcJjnbZBrd0DRaSDHtAbf1d599qMINed3MnqaDn?=
 =?us-ascii?Q?1l/4CXK6ecfGlkKjWFHJQCLOr26TXJiHIV0+vpzMkSgdTucU3NSyMnojT++R?=
 =?us-ascii?Q?f4hvmmFO97ffJVxcUE6fPuGj2OGi5NSmw1ucgaHnL7cjsY3RuCttVWm/Zrgo?=
 =?us-ascii?Q?zsrvOSA9UnX7t04R7eUXPiolRiIRkneGnFXBUGk9yuoRGCDTK4iu0fazbx4M?=
 =?us-ascii?Q?GNz5ZUHgRx/TaERpDj6N67ZCiGidtR07u8eV3rqPyZm+OJfIF2UR1wv+sGkC?=
 =?us-ascii?Q?vH28uPJGpf1xP5WI4uGmrQ62Nfabg55yTvq62zXrw93mAgeErBSKw9v0JDl6?=
 =?us-ascii?Q?QOfHVrBKAsN8in4aZP05RYKM/uThac5F9Mx82oTzYW2OtWFIUsihSRHWmRNH?=
 =?us-ascii?Q?f135YaS85cRu73cRN7aBjnh7MYzw2xpqDWrH0B7+vcXB6tR2pjPMecutgT3w?=
 =?us-ascii?Q?2RxckMtZ+Hmd3MRHMKgsdKOk+oiVJZy1XvIJVQdwCum0dJkMu9IqonySONg3?=
 =?us-ascii?Q?mQm+CAOUjZ8+7DLaZ5kV/AS/He+cWfCdbKg+xYTJZF1EwMwUoE6pMPsnRL/L?=
 =?us-ascii?Q?qXCRoo7qruCeUmo47/ZHrt8D+yYyMPRuISUPDMi6rPgE79MVVqdhkxFbwqyW?=
 =?us-ascii?Q?5odvlR6MLaI8w8UNnOxipcQx6BC/tuZmS6dcnnxE5m6H/SZWmBj4F1Jer62f?=
 =?us-ascii?Q?ittVCs3b5bqfZNr2Sc9IbruoBGtYaCwCBi3NU90pmwdvi9M16EJu2fYwVKmp?=
 =?us-ascii?Q?ZgKgrScJvVlSdb8cn1E3Dg4KZVaK/U5cVKt+ScLZWTEQWDzF8Se9fMFO4gv+?=
 =?us-ascii?Q?xq0Z8LuliE8Q9NkzYYHcvs6qaUQiEMSHqU6TWpO9KZDMU0FFRBRoB8hTguJn?=
 =?us-ascii?Q?2sWfQBKT4dUtsO9ApNQaEV3PNOB0Ctw8tbSzoRagy22KCEaoetPnN6VhJX5C?=
 =?us-ascii?Q?V4n5R9D7f1h0NPDoksnN/qmIHzDeejyDL3cIMe2Qw8p301vyQy7cTnuLXW4M?=
 =?us-ascii?Q?XaBtW23XwAFOWOhO7EXAGNODZfGnZwnT14EWhKntaiAUJPLTtjYpiyVtnl0e?=
 =?us-ascii?Q?hUAd/dx/2wLFDN1GAXboQ3b5KOX/z35HniWB3Ry0My8M3C3aWqk9uj4xuLhs?=
 =?us-ascii?Q?BvH7tCrOMP5FU7sQwRzcPULY2iBhdn5Mp2IFZkJqS2Mo6LhbAAVPMg7xR/5C?=
 =?us-ascii?Q?OCuAZh6krXDLd53/ZNXubTg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD85BD99EC11A6439E261581F645EF8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qtOaVytp+MDbjlO3DOQ0OhSpCY+SoRgCP4JqS0L7X4o0ehV945WZ+CG6lWss?=
 =?us-ascii?Q?KIBWayNenimo+D6TUCqkY1r3HJQFLVpH8MDGuRZPrprynesXtibeQLriYbVe?=
 =?us-ascii?Q?yAenrium9jq2Ar+5kUlFKvtrO7MndxVaPij2Kw6pThR7JwlRPYUbkHSRlGPX?=
 =?us-ascii?Q?rgNszMcYiiJcRfc/ZR7eKYxvejineVRzvDkvquinoY0HooO2NZv1umZ8HuUp?=
 =?us-ascii?Q?wdhlb6VPQVoJu9LsiGPHrfVEoUxp5ul3nEMSrfo6ck42xPD5IbJ1+2nuUTIz?=
 =?us-ascii?Q?ILENcvV0IESr1GTnuLh0PbSZQpepH1RsrqcR4JrcbQewAqLpyPpegPm7CvpK?=
 =?us-ascii?Q?hhK0j5IigFYPDxJAJ4zZg5TtQXEIKqSLz4mro0t7eADeS8miMXamMG2G1KGw?=
 =?us-ascii?Q?pMDEcbFKe+BTn5zTJz097V/g+1E0SeHKKEZLJK8/f1RGWKMSo2Vad2xt0gGl?=
 =?us-ascii?Q?VCJ+m7xRvjEcDZWEDlx4yoHO0MZ72iikmydLiTqBlW/rBGAD67KDwiaDw3sE?=
 =?us-ascii?Q?AEl1Y4E7USyXetxm9U0+Qqm+B8eWzhHm/tcoOIZjDbUHeBy0jDwYUl76FgEi?=
 =?us-ascii?Q?Db0Q7l3zBgQ/Og+KF668fIi0wiC7y4hDtoFp5JODlAoGTvkQQW1EjL9fTa74?=
 =?us-ascii?Q?haWz0yMD5J3+1VLT189i0DCJHUksADBSVxjgpCXGBjVQzCwYoLLFg/F4t7yP?=
 =?us-ascii?Q?nTxNekCdMPhgGRifOtBbKHstxeBRavQcZ0AYug4ld78ibU9ORsbgbE/3TmfH?=
 =?us-ascii?Q?4azDr96Em1CD/3fc3mjfoQ1AbmVnh6ouoqKtPbdL+Usp0YLIzOyJ2GH0DqCL?=
 =?us-ascii?Q?jXe+VCnNzl0q/WZUhOD/pO/djE0UUNpP2pHjvQGOKNu3QM5KOc1cFGvXb4mz?=
 =?us-ascii?Q?xl45/E8R4ShVRsQz8WAs2BaajqzNkrpkiCtXW+bfwgebmiWtoO3yfGOlOTiz?=
 =?us-ascii?Q?TtGSSzTsIi2IJCGQrinLow=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d7488a-c56a-4807-964e-08db9a307c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:02:04.0484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCXHPnGsEZbt7cQGVkE8wTqhriEnhDG+/HDxI1Spa4+8c+WYIdw1QQvetigp8r7xSMXoD+Gk/IHMUhhwFPN13l6FD5fqM7HeNo7RURhDdeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_230247_185796_32A3855E 
X-CRM114-Status: GOOD (  17.51  )
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

On Aug 10, 2023 / 13:13, Daniel Wagner wrote:
> Commit acc408477e85 ("nvme/{041,042,043,044,045,048}: Use default
> hostnqn and hostid") switched the test over to use the default
> hostnqn. It missed the change to remove the local variable and
> use the def_hostnqn/def_hostid directly.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
[...]
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 3dc543fd55d3..5569a7a58ad5 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -26,18 +26,13 @@ test() {
>  	_setup_nvmet
> =20
>  	local port
> -	local subsys_name=3D"blktests-subsystem-1"
> -	local hostid
> -	local hostnqn
>  	local file_path=3D"${TMPDIR}/img"
>  	local hash
>  	local dhgroup
>  	local hostkey
>  	local ctrldev
> =20
> -	hostid=3D"${def_hostid}"
> -	hostnqn=3D"${def_hostnqn}"
> -	hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
> +	hostkey=3D"$(nvme gen-dhchap-key -n ${def_hostnqn} 2> /dev/null)"

This part changes the -n option value from ${subsys_name} to ${def_hostnqn}=
.
According to "man nvme-gen-dhchap-key", this fix looks valid for me. It wou=
ld be
the better to note it in the commit message for clarification, even though =
it is
a minor fix.


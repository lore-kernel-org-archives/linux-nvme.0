Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A4EC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbduMTePrtd8wjWKBdSak+1vza2xj7UwLDNgBLCxT68=; b=p6N2yJ5SbJ1QO1mvVVytyH2TSd
	TyqjXxUr1+b0s+37zi50fuyU2VIp6ye5qiP9pmvOn1wR/QmOVgQGEwAFyHTaPvnGHRZq7rhUNvcb5
	z1nO/BiRBEopIQlYNk/vWVVdEy/9QGjieFUee2jFlOtIewHwNXET4gj0AlSCjS7h4XqQM9nifqUqL
	+ilosgXzIjLR3PSpFtrmkoHLR7NYUW0j/jOXZMwkM0nQ0+MwfHuLuGN4oEUWll3uUrA+UqchlI4I/
	+rjAn7lD4JRtWVtX2y/NCnFp4vst3ZrBoQV8nY4vUbI6osQHUSTtTJq4hg/7kSdNP1X5cL5sy9k59
	wirDt46g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXejj-0000000AHve-0na7;
	Wed, 07 Feb 2024 10:00:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXejg-0000000AHvG-2LuX
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 10:00:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707300056; x=1738836056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IRymzMjxRPSCyJsyTQllEh+ewlFntSJZxibpbipBHhQ=;
  b=dg5RNDzc7Fsz0UejgBYFnhBzlrseVgPa6qJzydlTSc7tvqTtbE5TJ/7e
   ZFQWih79ZPjctoTol5O24ktJlZumqqQFCqNoXfV+u6x4m085rlMapXJOF
   bxGhrCYjpCqMOgtcNKl08bAXXGuKro5EVDXMN6ZZJF0lcF/aC/sfpoWK2
   09/bkKYnQMxwsAAb8FDc023FtR7tQOwuS0GewXpbY+Q9Mg9eBrLtsEwxp
   7jnM1vkYPWpdmsjEKe4p70FLGPOqgQMrTLM4invZfk7+NwlrcmFdXRRJ8
   Fny2coq4mg2ph1+XgBoiXheo0GcTViz+JzUBisOyjM7XJGu9Kee8Msw5t
   Q==;
X-CSE-ConnectionGUID: HsZ29qT2TQS2IGX2EaxAcQ==
X-CSE-MsgGUID: EvlDvZxRSee2PaG1FaQ5EQ==
X-IronPort-AV: E=Sophos;i="6.05,250,1701100800"; 
   d="scan'208";a="8368996"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2024 18:00:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiL7c9Nt9ym8p0rSwtIoxUVyNSrHYhSBGNsFUShi145Pp3k5aOAaWSgmeOju3vqBJh9GIz9KORO15t9Wb3ADmFdpukMqJfNrq5f6KdDDjFXKVeMnMXsfb6MUhgZ6ycFEUWGQilUy70HEVnfrsV35R41wVadPDC2NoXaT+XoBCEdMrLG7+hx9NJjcDGmJSH2ooMZ4CawUPtR5XcOtZn9WHU9jbx4+rxP8jGvCxPLdDyRG3PitOibFnHvA4JG9WZBfNBwNzVbwpMLKJZdJ2HqjUM3JLaiGX60/IIxWrevpU6vpc7lOcEfkQdOf+4kI/iqHVjEE6IHgB1Z8nOUHNOJGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbduMTePrtd8wjWKBdSak+1vza2xj7UwLDNgBLCxT68=;
 b=hW8wnCUu1B0Am4vsYMVPSRicV2SsPoEkcrjIGxZRPNHjOB0JlMdoMQQUhiZe6DRm+3+Zzc1hC3xwNALojb6Rq04kA5yoQrJGUvgHlAbAu80ux9vdQxxdDig5U/5RWA796hs9YYUfk4C1Xar6PdnQu6KBAty2Bkoy2Y6dR7v8Re1QD80U6FuarMOI+XTEzWekqP5dxwx0mDzmTzILpbM3eayxLukLvpjvsURaNKwrmhYncH70vAr+rhR8EEAdnDttq9Gw9WvG9Pgpp6hgXsm6UpufG5VwoU/feXv4qEpGAO0Tjd58K+96nytmi3peyOKRvi1CHS1dv4uqXRmGphOKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbduMTePrtd8wjWKBdSak+1vza2xj7UwLDNgBLCxT68=;
 b=uLAq11CxUrJLl5XwH5Hn0j1CS3jM6qwBInaFkT2GfFTz61nCMOsNffh2GIYFAdo9ouoYziSo9lTEb4G6JHPwkJs9zUQedGACC/3ElrFGfzFRnry0kpSycO6V0SDyrjLu1X26d0aKZJ9uAMjNBy2hPW86JjiU1ywAZFgCOn8kCMA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7187.namprd04.prod.outlook.com (2603:10b6:303:67::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.37; Wed, 7 Feb 2024 10:00:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 10:00:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 4/5] nvme/rc: do not issue errors when
 disconnecting when using fc transport
Thread-Topic: [PATCH blktests v1 4/5] nvme/rc: do not issue errors when
 disconnecting when using fc transport
Thread-Index: AQHaWP7MJeog3ZNCekSBL3C1nIL3yLD+pw4A
Date: Wed, 7 Feb 2024 10:00:49 +0000
Message-ID: <4zvzcczi56f6t5idvga5xnf5cv3eflx2ri7pzjkp5tmh3qyrxy@bp32pgmt7cbh>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-5-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7187:EE_
x-ms-office365-filtering-correlation-id: f09c7d67-6466-4e95-d14e-08dc27c3a958
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2sP64Bah7NaSlE/U3Ib3WQeML5C5PUg8q841tRyf32e1aCtWwSjr2VdWe4p61XMl453hC+ryUSyC38BlEo29SkpaEIAPyw9Lcfuz8MVmyczKPr8XQ0LdmI+1xV+sOdgoBSj1WM0jflXhs5Y3f0Xt4IXbM/2y8am2fnKjSTQonoa0EG0J1oPTSjnpAAcZqlEgoUDCkQlTB/AaJjeyaCYw24X7M3bWghQTWL2YZR1tZAH5mg728tHUl87h+TrHYoiFIqTFcgeGApuuQbNk0XQdxFjjfbdCIcU7DQ//wPmQQ7XMTACBqV2oNOW+qV589jEEPDqdjmJMUL8g31PsRy3L7N1lFOipjDkwPNF7e4qTwQI2YlTtWToqq2WYLnrB1VjUHXDuZlC6FHf3ADeJ2MApSx+2uZaHzpq5MF165qEAg8pG8hL9fB6V8j3UK9qNn0r/wCL49hKocyQV/2SNxh20mX6cAJxNwlqP6yiCciFm6rS3Nj1NTCbSUFZUfz3rIWRF2WBXD95sC9l9d6QHywr4f7kV7ZFTga2Z63C/ZP1Ms9Am0iHtWgsC1pEfha4sbGX8pGM4HjvmAA49AaPqiRa4kLgVj0vFs9AK8uD+TEGjxD8anIXcAHaTR8JUjO6dbrN3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(66946007)(6486002)(76116006)(64756008)(54906003)(6916009)(66556008)(66446008)(6506007)(9686003)(6512007)(66476007)(478600001)(71200400001)(4326008)(8936002)(8676002)(316002)(38070700009)(122000001)(82960400001)(38100700002)(26005)(86362001)(41300700001)(83380400001)(5660300002)(2906002)(44832011)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wul5MSizV3qSu7lqRNVyEhuQ+f7A8xbzjJoaQNms9FWU/TBTgNmtVFoJHEq?=
 =?us-ascii?Q?bzy3Y8Yao/NPLLAKqYMXn6xQYXtzCKNnFyRNrF4Ym7R/ZNd7FOElcGpjjqZK?=
 =?us-ascii?Q?PdBDQKxp7AhGGZ/uGwo1RnPE7hE0XkXLBSd+tXNtOZ0CqW+VFs21pzX3rrv2?=
 =?us-ascii?Q?aVaB2DXKfGUVXDfnlsnR48QzJlYNOQ+XrFqf6BjLBc7Cs9TsKYhAhz0jbRfB?=
 =?us-ascii?Q?WWgDqyhUEuYum4ptoI0IdmjBGhI9XvynbwHPAhNtxj51OWsb1nARVODdR0mk?=
 =?us-ascii?Q?vkREGhe9c0sDZ8UGEY5XhObw3kKfgF7xhiTKV4YJwOViRAQlR+7KxndZqVYe?=
 =?us-ascii?Q?1/tYO9Wh7NbBsaKxmgqo9xN0dTQMmw8zGqzhEwTuB2a37vQzHZ0PsCdl/xLK?=
 =?us-ascii?Q?MxcRNM1aBipd1gNLGLQ+ybn2DJso6Eaw7WDKv+aTHZx+uFtDoHxaL/1yTLY9?=
 =?us-ascii?Q?kAnfPBT0v3CoXpoTRhacks4sxqClqFHAMRpOQXhyJwLyzDHfRIYklI+fgfBd?=
 =?us-ascii?Q?m2O3GiFXO1JAyZJkJSC+6GwfpTG9jklabO+WZV4MYVecMWhT7SQVb02zt+67?=
 =?us-ascii?Q?Zy9E6eqiXd1O3+B9PpXRHh71w91mu7aHn92Dyp40l8QqfYeiInudpimxf/MV?=
 =?us-ascii?Q?s5SjyFyeB6skti6WeMBnVEi4fZSAMLwiKz5ATrh/SCwk5XXcn7Wnd6u4phPl?=
 =?us-ascii?Q?+2qU6oWtwFRWLajRglDD1H/1eIZytugQStWv9yetKJopr5eQxcpx23P7B9Pq?=
 =?us-ascii?Q?oLdA0azKCIdlu9krOFrG9Shv/r4O/RfiR5oFFgYRUph4ytqUfpfJupYcoQXG?=
 =?us-ascii?Q?ocHOnDLlcMwHd5xO2LJZXGUKlKXvkb6yNGRcCHHgJhd0jIbanLprAaEeWFPf?=
 =?us-ascii?Q?uHgOvdtg4y0QPekaooxFJtbQ1u2au1bdW055pYHhwMHg+4TqCkJL3lfv6mc8?=
 =?us-ascii?Q?M0mrkPUYu5mEX7Xby3L4m2D1Ow4GWN+EiNJCtLmTshJri9BO7ko0RycglP3u?=
 =?us-ascii?Q?a/dLpRco7EMTLQJGXcM9p/2fz9+sUFbG/VXmTqy+9C50X3NgfoIMCAosgg0C?=
 =?us-ascii?Q?gCLtalQrtydMzRHms+qMRJvIUQ27oW6PHQYHfDCo1v2dNmexALbYWJuZ4AW+?=
 =?us-ascii?Q?c0zzQFdrvsVLDB+j3ucoKbLaRKs7RQuRvVASxVt2MfNELu9hhXBm1mcZNYNV?=
 =?us-ascii?Q?KQagGv08nFN2VY5KFW+8ygjbJXrbSIbCZdvWYFUcw+0M8d1c4cMmDsCQgefd?=
 =?us-ascii?Q?AN7noyzvtg1HhA+/QLwdv6UZDjPcRwa4EO1OzWm6gFaLtTxUT/6WZeclbysI?=
 =?us-ascii?Q?oYcYu88iBBt82h257VbkIMgGu5iyLVWJJZtEltrrdm0aQOhnmaAbcEKmt4Kx?=
 =?us-ascii?Q?480o56XkdEJ6qfqGjVnZ/3hI4l6AvrgiYMooqslm3pZcuqrjmZVTHnreRH+o?=
 =?us-ascii?Q?cA7ZfxJOt8chXlQ9hhJ0P8qoJgjskqzwUuDY1XExqZRq09BpwzBTnm5UjtnM?=
 =?us-ascii?Q?GvA+KiU2ZuyjScDkG3O5ejxwa7hbH1k9icWppkqxg7rcrpR/Ds+Gt7EY2sjE?=
 =?us-ascii?Q?zERIzEVXl+mU6LM6Ei2wOAn3HLxh6J0izBrK2HDWmQx+dvOcs2+QEM4DWHRl?=
 =?us-ascii?Q?x5Tv4Ghg3Rsf8Sj/BXMlZ0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F65C55652739624799486C14AD163847@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: StG5TA6IiPlrhqB7AcqsONV6xS8hfkCeNKcb2V7r6D7MTRMoxbkdwDRFulwLjJHoqTXRktc12wqRJ88CZqGHS+ijKss9ul9R8g+qAX9PlJXlz6V21x/xucnn8wwLIw+y7SHa+vIbpU3rWDzCRC75WixDlO0COUGmB89lVJeltXAihnePt/0ysuT2MrMp+dQ4GLTlHYr+NdDqJETo4fGoLJn2QK/OfnJFJnZsaV5i3k8hPgqGBhwj82Hso76LLvLNHiM/tItHo0MIeRV2t67kOB3D5QTP93zYmjxgZY5/VBIzaVitMo3QP2htHlguaiLLkZDXve6+NEqhi5MOoN0R7XQrfIngajH4iK52iq4fV+74OatdoPPwl2w9J/NsNWf4othYg8cj0xDaFbIG0lvm+f/d1BndQERtCPYYHk3FlMTUk59C1Vxp8aFIaI47Iym+9MO2JzxJVTJeriMG/ZEAIyJem7kI1YTo8MaR+LxoZ9ah3ctofZR3Ext/ZBtESDsxo15hEv0C2vbso0N5FgILlWTZfUDdxhp70YG2p/0Z/JI35PMx9p9xbQGU3DTbNMACx5Rm8uhHLmRE+y0gixpPfPaRj0pud5YIPFhwQ86lgIdTVAJ1u+6YKg7m1ApB52Ik
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09c7d67-6466-4e95-d14e-08dc27c3a958
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 10:00:49.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XW54etMAq1y6YMvVVB2348AHoiL31ICe9s6YXOwy43bS34RnTmiuQ+PLz7VlKMxRVKzGwfh2E2+0huAKg/R1dHQ6yMGfTJbPjf6tlM7sDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7187
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_020056_683650_E0297E2F 
X-CRM114-Status: GOOD (  19.28  )
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

On Feb 06, 2024 / 14:16, Daniel Wagner wrote:
> When running the tests with FC as transport and the udev auto connect
> enabled, discovery controllers are created and destroys while the tests

Same nit comment for "destroys".

> are running.
>=20
> The cleanup code expects that all devices are under blktetsts control,

Same spell comment on "blktetsts".

> but this isn't the case. Thus filter out disconnect failures as well.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index ca6a284a1e25..cdfc738d3aec 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -356,7 +356,7 @@ _cleanup_nvmet() {
>  			if [[ "$transport" !=3D "fc" ]]; then
>  				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>  			fi
> -			_nvme_disconnect_ctrl "${dev}"
> +			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
>  		fi
>  	done
> =20
> --=20
> 2.43.0
> =


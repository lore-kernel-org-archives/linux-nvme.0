Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F592C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GO0pVH2d2jVhcTqYjr0qom004ZewAqkk3LGX4KRUegw=; b=43FcL2m3EV8+wpq7CD5f/MI3Bx
	RTfH/z8WSVcyE6dPImlVPbFtGJoaRqEFs/D31yn5tegTLqQYo+fU4RyoSAuBzsB+ENVMlB2Ve8tRg
	MJGx6Q9BI16nps45oCL5Jm+00KlDA6lfXQvm8aEUmpukWuhFWrqsZLqw/x8hKOB/9m3pdiIW/NSUK
	cFgRp4tPjZiIuS7ZdphoyJrqT2kXko2Yt25+fjtxKdY2q75UZ/Zu51hMXMsdD35tgnmEQ//eW60r8
	Jkq6pMfQDjzkxc2zTNMqQq9TYzxezjUiFcfJ7TlYAwKCgKcaFyGIQcfjZjsgOy486WpfYEcvIs4fn
	a/0kz/uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEgrE-00ECut-N3; Fri, 22 Jul 2022 00:49:32 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEgr7-00ECr8-UX
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 00:49:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658450965; x=1689986965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GO0pVH2d2jVhcTqYjr0qom004ZewAqkk3LGX4KRUegw=;
  b=iSaAe8WuyWQmoHbxoQCGNzQ3r9OpuHfXkV2+DqKVF6L6VJERTmtdjP6L
   k4Dj5+5J7YbqFEuoVeKuoO0zk4RltwXNuiX7eqstabEZFEFS3ZWFx5o17
   0HTIzM+1JPL4KiUcDNBUSngZqXJjEOaSMD7XsAQtc0XAX+QwKL+LAoFfo
   /lWcXaXxVxQeYrUfAm5NW+iPQ+MyJqpmjD2Tw/kYG3BIE7ARbhjVLFttU
   itPhpQQT3uaP9+x8ZJUJzUBKeES9++yHkjyTYT6h/o3EDd3V/ZJX3es3g
   hLoafRFG0U15T/0RzSOpE7tAtuJcc25MFpzKG2bRvFlWEMDLEIbDUx0pF
   g==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="205169730"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 08:49:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk3fWI/9LwJzI25IJg2LfgDgERfr+q6AzEcOD5L0E3lywL0ejEEIskqRZK/Br2ouEvAgPdU2qnURgwxABmgWxVC3tYMWLRIIQcKBXx7/8MovwpWLuSl14MdRtCZgkTDp95DpNzZnhkZKtp0y24h2YToboK315XlQc9JnnSMzNJd9BD9x6uGFiEoGA6JNfew+ize4rN2T7Qzvd36lfuiLu+8UmJCpaXhpTDnaiPFfT5mrA4czb4bh/P381lCIUyd6P3taLbH0HsVIuDWppNNjoDMXwMPN39mmC3YzkzXU6x+E5fc+3+4DCxHeYYcKQ3YObJ3eTtWgv02mUf8jStHQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO0pVH2d2jVhcTqYjr0qom004ZewAqkk3LGX4KRUegw=;
 b=Tmqws+ThLz6s61/+3qdptjS79f1FzBnj8T89g82kt9kb+xVq6IFW7adCm0BRkmgwgStRJrsqCIORdKdUIWgoQn3s44wYHH62CMC6HE3tzSBIk0axUeUlgxJXYxqN7CM5Ar/kirRojG3Mtxrd2FWp1o+OwJnzzxRfR1aQwO3dfQnfGT7+LhfLC2xC+nQATIlsD59L5WpX/zfDWM/ByOzcXe1s53AUgsb2zjdFvoTCp11wwDqkMXaC14FORTnKsRZYaofcBlSmUEEn7Q7INYV0fwygbwEAw+0rSQQwgrHPpmb+nkBw+gYy2bKWvR0jwDjXljQFxmoEgURjk0c1WH3G8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO0pVH2d2jVhcTqYjr0qom004ZewAqkk3LGX4KRUegw=;
 b=Ql1jsD+8jIX+Z9zfC7985RhOaZTel9QlkhjmNR8/EVxO+/CdJ8d5lDPG74oF8s7+Qn4VyQrFVbrQ7NikbP6+UhYB92bg46XdtTQLHepBqI/obntWHxHXm5t0mWD9mUFX48hoyDqg/mMzMebP5nBtPEfNtZU5gqNqYFatwZF289g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4192.namprd04.prod.outlook.com (2603:10b6:805:3a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.22; Fri, 22 Jul 2022 00:49:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.024; Fri, 22 Jul 2022
 00:49:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: NVMe In-Band Authentication blktests status
Thread-Topic: NVMe In-Band Authentication blktests status
Thread-Index: AQHYmv7CoKmZfXV9NEWBBHTpa/U3ua2FQj6AgAABtQCABE/PgA==
Date: Fri, 22 Jul 2022 00:49:20 +0000
Message-ID: <20220722004919.lnkgqii3beh4ber2@shindev>
References: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
 <c96380c1-8d12-e67f-b9fd-0e5f55b05a4a@suse.de>
 <cd52b338-78b6-12ff-6af1-4bf477f924f6@nvidia.com>
In-Reply-To: <cd52b338-78b6-12ff-6af1-4bf477f924f6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf97b2b5-3ffc-457e-9205-08da6b7c036c
x-ms-traffictypediagnostic: SN6PR04MB4192:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  9sscLkeVufx8AwgV0BW/xSX5UgPUf8YeNGei54u38Oa82jVT7Sjc+iPGSZ2ika3/ftaU1rob4DbQPL7lPtKPLuqB6TWLIFzjQPWevPjd1G5FC3P2gGtjBpWRijatMOWFwhjL3/iXauI5lHYqp5t9qXkiVskVV8G3rhQC5nCpNB7tkmzRau5IHFVzWDsv5GJJv0LZen/HF8ebYkz6l3oB2FrsbRlb8tDSq2L81bJL8d5b40z+fT96Bn/dVKMguspeiFlHXPj9HfXTXrdnN2Z09/YoXPg/6UVLoaPSBqgcHJZajHtZmcJqzCnkZsP7bs8gbqqF/9kkiaE0A4HGhjvx6qVzhZi0fEx08NnyZ2JsL8nOGPzH50Z2s7ZVhrO21Gd2FVYgauFWUo+Lg3sfd9b1ahRONucspqE9r8wFu0Cph+fdz2r8JVrfhwtpMpWc7oOcIZwhjxBrc6BBpxFit8Fe/9r9NkgxsSvdEIVCqe0w11NTAX/xO02T1yHO7ZBEl71nBmp0Ic6lYGA/Y84K3KdBeLf7NFii1qGnAhbfGGbiqOn6z9OfBDqU/1iZGCgBWAgHgX3h333aopHU1PPo3WYG+8/CSMaV6A96OXJhketp+mX2l2/ucqq6wxizFo1FGSzyBEwfomIgDUVGjJJKXBA33kCuj02Zxgwgey4mzUkCU0TzTUl/64KGvLez1bIG/MRHAbHh9QXdTcFXZ/OSRo8WhgTaW1qsj8DoerJ4Tq+rw4EFdrqU5eNe+nqMkFEqh3mXmQ/KQWwAUyOm4KN/QoaBSCYhaJDDj74J8q4hjOZmCzYhOsdUGGFyM1q0tWm+CZFC
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(66446008)(4744005)(38100700002)(44832011)(66946007)(38070700005)(5660300002)(64756008)(66476007)(66556008)(8936002)(2906002)(8676002)(4326008)(6506007)(76116006)(86362001)(122000001)(33716001)(83380400001)(6512007)(41300700001)(82960400001)(186003)(71200400001)(6486002)(54906003)(316002)(91956017)(6916009)(1076003)(9686003)(53546011)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?gQ37gDppRgjWC+j5HVWPiM24qCUIF6k8IsGLjKVkJUVXH7lpS3N1wtPLsX55?=
 =?us-ascii?Q?IAAEYER2qaLbei35cQh7o43EYnYpwkQanmjs8bObJdpMGryOgx0RyZUIZShP?=
 =?us-ascii?Q?HSzL+M6QvLyv7yqEkRLeJ9dnBsKi9QNrTaIGYmmG+EoCoRhFJGhRPHNv6/v2?=
 =?us-ascii?Q?ynPITcCYty/UBLoHmJFkii3chwNyxQc7HFQSJeYMUHMndtmsroenDGBg0aF9?=
 =?us-ascii?Q?aPVeryyt4vNgV3zvT9o8LeCsWeeqqPIbtDMx5b3GIwDMpK0IbKdzZgSB5FLU?=
 =?us-ascii?Q?bFEHl0PhzhEW4KIJamgKFUP/Ok320F/wnRzOdpQ6FuapIVa0+hpJ0xsiP79b?=
 =?us-ascii?Q?SLtRlzCJPjz2Pv6qzkqMBLG47IpCPXd33FVOmYsSqhnsj6Tjf9d3ZMEPsUTy?=
 =?us-ascii?Q?oUiCczQtL51u1jMKwFljFFTiW+ARaRMuSpRXU6PckEFKYKqb1MKvTO8u6f2E?=
 =?us-ascii?Q?4/wPat/x9ZdHYuFKPxaRYDH+UEIxOaV+gLCPsyqTAgiF0V0sFaZ0bymXZwRq?=
 =?us-ascii?Q?hme8uY1JZOS9/DEYNorToF9xDGWXrlZ2k1438R/0DCH8Gs3EhvcpsaHxu1U0?=
 =?us-ascii?Q?HV+rWyijBvTHeHvFpPU3CGY57Toh50l9BbLAjZ/pIorlKenLiV6SJPJW//eD?=
 =?us-ascii?Q?DVYVzrIUMupIk58usQMU4uOBgwPugdYthaMlpB2YfiUkMIQneNW3pIg4lC6K?=
 =?us-ascii?Q?XrXn5fj0FyUX5LW/OKyIdZ3HOrHIiwaGf2iCx4weqDX6Ok7hcZyVTp8aWMcV?=
 =?us-ascii?Q?ogNturaFqZ2YWM37KPCm1PwJWH5wrpiivh78hYa7oyxD2X7jmJPpfU2AbIIR?=
 =?us-ascii?Q?KObL555d2Bjpj6LKk1mDNmWDhnwJmcKurWXjjKrmvITiRJnNxblH44PbhB98?=
 =?us-ascii?Q?zCK/rqnJ37ztKoFzUz7LFlwX/hOhy1COQf7fiiUW2sidLokZYJMBhUeUyk4x?=
 =?us-ascii?Q?D+s6t6YXMxKSk7DYCScPKa7AOOmGI3DfnADAUgux+Ajdk+gYvsg6exb0NGEa?=
 =?us-ascii?Q?01W7BlfW83hBIRiHJsi9SEK9nvx4GuIEelb857bIr8lUagR7qBlDrXdIavQC?=
 =?us-ascii?Q?5Rdl/hu622WfLt3rqAJ5Y1E6eUOoUNCfC+tS4prw5nnMYGLkxIltOkIk9jlV?=
 =?us-ascii?Q?LH+12SEJkQUQiXk01Wg1ppLhu4Lni7ONRJMtHcP6DkuDfkgyHuwUSa6PayWW?=
 =?us-ascii?Q?pRDgv7Ryak2GPgaQX3BvcW25HdLHa9R1VO+raggFNXHgisaK0Bbkily99Ufo?=
 =?us-ascii?Q?uuj9tdvp0XUPzrUfLhkXCJQ+gyAoFU1YU8hVU+4N3w96hwf5Mh/fKln/xw3M?=
 =?us-ascii?Q?pDs0Cwv4sLnes74k6PezvDgssvyWPZH3yql0UJK/3q1Rxi5P/7S/JscZO6s7?=
 =?us-ascii?Q?DXMlcCTPf/BtRTrxmg/jKGQ55dQyl2wxUL1yOnrs3ov7S60tg79NfAMHXQkl?=
 =?us-ascii?Q?gdm1C/nZWeFIxojVjnz9cs1XVPo3V6A22RoXihOkEJO9UZLHZGUufxpOKEyu?=
 =?us-ascii?Q?byeiJP19/QRdWzib7hlyU3D4SROEz4ae8KCONwp1YKZKBS2Zpz8cmpmg8TVO?=
 =?us-ascii?Q?TzPIwCrqIvtq3PV3MZNy/bXiUBOHyUzGOlyZ0g648occ60FqZkW8A+p1KktZ?=
 =?us-ascii?Q?IjVVR/HatrbFd659OIBPZv4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B8758E0C5661948930EEC1ED0A59B64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf97b2b5-3ffc-457e-9205-08da6b7c036c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 00:49:20.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nw/yCAzyiCAa0JQOuL2Zo6WlElEDnhVrTBK3kjje14W+1yZQf5YcpUjX9m8HI8W6mKSPcFAb+ynmNUhz9RlzMdpjP3c5rENd6rFtblPdkrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_174926_070060_A982280D 
X-CRM114-Status: GOOD (  19.14  )
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

On Jul 19, 2022 / 06:58, Chaitanya Kulkarni wrote:
> Shinichiro,
>=20
> On 7/18/22 23:52, Hannes Reinecke wrote:
> > On 7/19/22 01:33, Chaitanya Kulkarni wrote:
> >> Hi Hannes,
> >>
> >> I just cloned the latest blktests and seems like we don't have in-band
> >> auth testcases in the repo (correct me if I'm wrong). Any plans for th=
at
> >> to get in the repo ? as many are asking about the tests as code is
> >> upstream now so we can run on different transports.
> >>
> > I had sent a pull request; let me check what happened to that.
> >=20
> > Cheers,
> >=20
> > Hannes
> >=20
> >=20
>=20
> Please let me know if you need any help with merging Hannes's pull
> request.

FYI, the pull request has got merged.

--=20
Shin'ichiro Kawasaki=


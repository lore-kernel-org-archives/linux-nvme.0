Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29210EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 06:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALtr6klsGu6Vhb5c39ANEpOO70Qc0oRLq+HAtaPoZWs=; b=iplSF8JUF5JDU8ZhPikNf9m5gS
	NipMJevVKUAg7iH5HcyTKHriN2dyeBQFmZgDIAtQBPUaM5aKwDz1jZMqcVhIqSdbmErqJKafEJmeR
	tKYb3tH+ExHntmyLrU5OCWG0Jf8WUnkgtuVl0Eo1G4xWvIa7bkT9Zc+WzjeSqkMMSTDkRaDw0Y1Di
	B7Af9XHatRS8K8Yzfc1rGAPg9L5ulAlBSQcmZJwD4XEGHZZkRTPwiBD96p5FboszDoNZLqspwT9sg
	eP6BJFxhIdItbpepwDm3bIVOWbaBp3+idZdOBml9/pEBMHxPR4qArCFRsQhXV/vxF8I8th9ERfVd/
	1Ca0cvAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGDKC-009Urf-0C;
	Mon, 03 Jul 2023 06:46:16 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGDK9-009Uqx-0x
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 06:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688366774; x=1719902774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ALtr6klsGu6Vhb5c39ANEpOO70Qc0oRLq+HAtaPoZWs=;
  b=TyHHBGBPKcvaZKbmSHwaE2KtfO/Sll5bfEkUKM/bBht3ZoTu6Gsnwget
   qejPPfODXCV85H//llhHeRLttVD1UAIYGjh9I81bBFzF11rv8ywuK5o87
   oNo/GmSaV58AflZ4fg+XpJ0lVu8+KwWkxg11uVdzUtqIzilsXJtKGoH+Q
   rFse2P5CDmIQuLQbE6Fkg5U1CwcQUHIk87Ihmqnf7h7+F2gNaxwmmmT+7
   WCdgniEMWESdG+bd8zQvsMZAtdeQF6eqUhx5D1JiA9gkOzD3F1djhtwnt
   dux6+O+9PGsH6bUFbxH08l3Qu2Hrim9R7+A3+5kunnOVjHBV/CLQIs1Kp
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684771200"; 
   d="scan'208";a="236779449"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2023 14:46:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvUkQ0nLOTXD+A+DC1+VN0o25U4K47oVQ2rU51PjJEBQMe5CVwQG044pKvv4UIIWjnPmlZYd84HDS9yeXCxx8bKP2Xicq9rUmZXPPdr8uQ4fVpwnKgX6S0mn2s2bvG4GaXd0d/qKKDDOi+qWxtOLHPvr6KN6ac9AyVHqRUzFJkD5FQkGsLSwwzjoeywlmsmi1SQAfqjcLbbXcJ5IoXjioxDIS8nuOZy4In+6S0jlwBpVJmGZQA3JMxkWfMrHtAkVXWWxGAXBG98Zgtu9M+wWvIqYdJ2Tm0ckwemKQo+bif0PD+A6rWw4AyA1fbgosfxl+3//z1wLJWviteCHFAdHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALtr6klsGu6Vhb5c39ANEpOO70Qc0oRLq+HAtaPoZWs=;
 b=D6ojuwL67kl53KiZ95dKeS6AmTgMlLkwNyaiNGJf0wgEg8o4aqSnJLE+5UmJzF1Qpru1qtgrj7zJp4HSKAX67BbyzFEQArOm2AaItgyKPsN6G66eu7l+0C2d7U0XIdLML4GV2KkKrSvL/iqXKQqbY7D7V3a8X4CHPRba1EaLhBu0glHg/0uOfCX4Ghw5UpYKPfRImkO0KB6kX3zX1sKM/gSsGsAE1PaAHlS0eleNVvD0rseV6t8JXBTl8s5HUW5pYStCLSliq04fyL9uDRVbqBgL2z4FZ/ulRSHj2ToGmaKBavCtiPpkz+ClyAnxozQ3HXTPDSvqKUTHAwXr11kwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALtr6klsGu6Vhb5c39ANEpOO70Qc0oRLq+HAtaPoZWs=;
 b=MKcspT74v0Dbm0aApL8M4jCcoJwWakQTz05d84QsK6n1biDOcB+XhR0feF9Xs7ZpRyBWHFQqfsffVuwdSvKjF0fR50MoDiPk59d7uUPym0uZm1IvFlXmkbaYgdLersqZVPmYAC3YBeoI6Kmg8uCvUslOjvnXaVPjupRCIjNyRfo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8480.namprd04.prod.outlook.com (2603:10b6:806:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:46:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:46:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: nvme in-band authentication blktests - nvme/043
Thread-Topic: nvme in-band authentication blktests - nvme/043
Thread-Index: AQHZrXoKTDeFv5AJeUSZ49rXTD1+NQ==
Date: Mon, 3 Jul 2023 06:46:06 +0000
Message-ID: <bu5hjttqtlxm4dqs2zfacsmrargz7kxpawkh2kfgitihlibk2a@356kctyedf6i>
References: <eedfab08-e50c-0a51-5dd3-2861dcc02b4d@oracle.com>
In-Reply-To: <eedfab08-e50c-0a51-5dd3-2861dcc02b4d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8480:EE_
x-ms-office365-filtering-correlation-id: d86817a1-7873-4b86-de25-08db7b912d47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vS9g5V6qzc2FzVCyToCq++yOWNxO4imcdjo+UXpjP2+Lp0XNcEZgB+SkdMEiODHUSKdsjYl4TYzuWz7UZS/UbW7AL1o0uwffyQuKGWE4DOX7x4HAAC/qeP9ICX/5+owetPtBSMaSs6U+tEAHMQu8ZymLPaOojCU8pAHtmvLDHDQgyB/bKP8fiWuWIMvGFEtgJVBeO0sNR2D6XayAzOIKappLmpHKjP6Zz5P3lOvFG4uqldKo+T73Y1mqAKIsqieT1lidZw7LDqHN8av0Y/f4gwkHbFj+wEWOA0mqLtTryH3GpC2Zzrf4O55BIpPyHCqTKfytKTzxsfUtb7EteO7Mw1zxUHPjHatZxDv32g6zfRVsSAxly/9l6SvbOIKOsjz62fshCUGP6qnKJc1nMAVz9iHVsf5JcFAs/zKkU+WNuB3GH5Su/39y2PRsvov72lnUJEpnpYBe0dumpGr6suhkJnuHjRp8rpFkRTc9Zsd1q9wYn5UNB95/e17o3J4D5b7v2JUbObn71Um0L8MdBXL78Ye4Lyf6by1XGo/1ESuqJbjU+RYzNXzfVNWrjMmN9nxEBhaBX4DT5YMtiWTZbuskYUJdbn9m8OKRjudTEb89L8OkvikkQICswvqe3qmFF9p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(38070700005)(4744005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(33716001)(86362001)(186003)(82960400001)(478600001)(26005)(6512007)(6506007)(9686003)(71200400001)(6486002)(91956017)(122000001)(76116006)(316002)(4326008)(66476007)(6916009)(64756008)(66446008)(66556008)(66946007)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OROZG6i2KEEJKkKBt6/Ih74OTsgRhdiZRhByuWEOmf68bMNkcBAQBc5MyO?=
 =?iso-8859-1?Q?wdf7nWTumQ+57lsAkKwCkfvuT4qAHXbdK9A+UNoytwwH7Sl0aBQ/lWjcUA?=
 =?iso-8859-1?Q?Bm2CfsH0MqqZhGMaDkrXTj6Nle3UN4F0e1RUG61FqauWf2oHkWDzF9/N1S?=
 =?iso-8859-1?Q?gdkS8p9eS1szHrH4I5aK9k+/yCm97fVSKdFvnZKhCOG4Suu7YgyXhXmTkE?=
 =?iso-8859-1?Q?eguEadJr7hxh7OP+qUb8QDhGVE5Y3yMOAAtX/5Pwz6VK97iy2i30jqBhWk?=
 =?iso-8859-1?Q?Uv02BoHlGbaeC7NqVyo8GBVFsJEBfWNErQKtdzHVJT7n6JMxnrvd3fYyDA?=
 =?iso-8859-1?Q?laG0BsTn6VYIO/1M1g6RUaWsZSE2owOwPC4FCmUatL8ryqh+w5RSfCSGdB?=
 =?iso-8859-1?Q?MOjjY4kgyMElqJs46p1nZJKS+pv14aIqJE8iufBjY5x4cnO/fgySSsat++?=
 =?iso-8859-1?Q?C4KXDdxAKYn5EaCvInM/lMHOZ1S2UQUZtca1cpCjf6/Mx6fjVigb1fL9cy?=
 =?iso-8859-1?Q?12eUF3qt0MkTf/kp7vbxV+WSz10puOH3kmrz1mbffuigaSoH4C2A5dQW0g?=
 =?iso-8859-1?Q?3hT+uMgNi7fki9/At0SGLJwsM0FxGpjFXrEjKzQSGoYIh3cXjHAV0iDeP7?=
 =?iso-8859-1?Q?Wts8c9rIXxJZOLKRoXtNiix+ZAvi8niDc7HvHT24B9Ewp23fL8/dmLtXjw?=
 =?iso-8859-1?Q?pnlN7D4f2tsVY3igzE83tuPZ+Z/ZI3f2AZQCF+t96In1xcxc5yjQCjxwJQ?=
 =?iso-8859-1?Q?nLef+Y0qhDr7gqs8HdGyIQ4Bpzf36QtS6C7C+RohBGMOYXP0H+tOKxAl6t?=
 =?iso-8859-1?Q?g7BfA6YQZPuGu1kyhnFKCo+nYCYCeT5tMbhegpoK8fLYvP3XELBSwSf0Gu?=
 =?iso-8859-1?Q?SPKoNxi7voU6QJP1KVn8JNhR649MYC5Zpde4Mnlldi3V0B3PEqaTvCq7B3?=
 =?iso-8859-1?Q?JSQQ0DlPAJJpucnIU47qPNWDnksFK+ESxVLqxXU4cShtO0F6qB667Izs0Y?=
 =?iso-8859-1?Q?nLT7AOFJI67TNdf3pusvaEJ93LZp/wzc9kf4K6Ehe6fKYfawjRTG+ePZA0?=
 =?iso-8859-1?Q?ZVFMOVO1irNeXvddWYuu+4HLmWpRAdNPuF/6GAiw6Gb23MkbjDFxJ7FOB7?=
 =?iso-8859-1?Q?RLbw2QHcbEE2v8F7YFOqK5on5d5Z4h8ApgUNS4ilSa/zjtzVTcTSZTXnqh?=
 =?iso-8859-1?Q?Ky0bPwyknDMU/SuEfnoFxy2kiFGBaF8X7gpBsCceigUfInJmWoSPcu8hnS?=
 =?iso-8859-1?Q?slaDfU+Mtxq2eZkzQAVWqy7MHwxpgZiM3IEyFeiY6xtS8oznTLSf+E3YyC?=
 =?iso-8859-1?Q?VHx7ODry2W3VxmtTxz91+QcJJwd53sf99Vfn0NfaEYN8gycUdH5+Y723Gd?=
 =?iso-8859-1?Q?0M5fbuBGvJlkzpir5jqMvIJs8ZWK3pWT7J0DChEiWPj+wN/IciNFoeLj3T?=
 =?iso-8859-1?Q?XIhkSJ9PQ3jXYlCSxlHtUrmXcTffpCasJ0cwYrmMN4qTMQw0Tm6BJ36tBZ?=
 =?iso-8859-1?Q?Xtlr2pwJWM+Izcm1R6mMvYDlXaYEH/RskbTeYH4yUrliIbyoOzdisrsUTY?=
 =?iso-8859-1?Q?xYK5upqkWaV9CKbg7cV4yw7tKBn+dgHzbE9BDvxznmY+Va0R444QchzzDm?=
 =?iso-8859-1?Q?OL6jvmAf5JCbjAWTNn5k6P7vkeW5Q5mgDT0DRuoRqjZGXwZCR0eAJMc1k+?=
 =?iso-8859-1?Q?3jtB0UliKyNwg1Ho94Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <310CED7A861F3C4B97E4B9131BCA766D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 83Q73hEpqqS2wnBUU1ZTh1EgkBWuu2u7dmKTK5yfQW/2AnKJKzbLJBNzXzTTc/VB5yw9ZiSFdNjKllDIdyCUIu4BCC9a7QWK+eNHLcJTauocsWLjTD3kKnNw6skoW78yeZz/Ya7UfagCIfzYVg97sUasBurLraBKgJgwKVXhuoCXoHac01zrcue6ltS0wM94qOkp5qsYQ7IUWeuFqGf32HrbfT31PQK6Mrqk9KQ5lHADiFNAxlqxrUFTuKj7Ggqa1mBVUOtpt349n2EoD+uEKIa+jUL0nOIit+HVKmG6bQ3Eg9H4fmUyg42hgTp35rymhfanVpMAJM+rB9jeRp59ydpdIezT9YFmctoL6cwShjRhgCCrgtQ8hCMbvrBN9e5XQmsqlbdz2Gw9yFzN+oH193W+i71OUAifrwZ0QOi4cNUTtutp0h9TXyddqaK61s8lZka20+/2PA+g/Bg5uMdAdKnQpC7NBZKDdVD7N1TSxRtABZmZYZH4G3dAEJ93ixMXmUFPmTHNV02TwYMvJb95Pmflof9WSiuSoo+CE0r+ZuAgG8CFUfJLqI6MS7xl/B49puNxYk3mWnqnV/S4UdR8j8Tx32jQAt/M68miTsyqNIqiXvPhwLC/4bx0tdtMV9uy7+3DUbkZsMcMCpctBmgCCxrbqwpkjX9cSLhmQhiz91KtGWSAXkOSiTyMqJSdOLP7+z6v7rb5iHOw4e6/rIyAvEIiR70v9K2a02Gc7ZWG8uGpbjJDvZfQYh6rjaxb+FMaJjqRnLgyAzY+hhpiv0oAJtA+w9rH4JpJnYwKErBUj9FK2d9+4BLFt1k4vseT631D7PxP5H72iq6jPuu3FK0PoA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86817a1-7873-4b86-de25-08db7b912d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 06:46:06.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbnGKXrXVrMuklypfDILxJ/sKFZnJJa6VfyVZF632G+uXuJJlMdYLwbXh/y+FLQXZeC0KZ5PGnuZaESlG7XHd2H6VqIqktGv26JCj0w6JYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8480
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_234613_419635_F51FB619 
X-CRM114-Status: GOOD (  14.04  )
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

CC+: Hannes,

On Jun 29, 2023 / 12:24, alan.adamson@oracle.com wrote:
> I'm playing around with in-band authentication and using blktests to see =
how
> to setup it up and use it.=A0 In test nvme/043, a valid hostkey is never
> initialized and a NULL is being used to setup the target and to connect.=
=A0 Is
> this expected?=A0 The test with the NULL hostkey passes.=A0 I updated the=
 test
> to use a valid key and it also passes.
>=20
>=20
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index a030884..d5e0d4b 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -40,6 +40,8 @@ test() {
> =A0=A0=A0=A0=A0=A0=A0 fi
> =A0=A0=A0=A0=A0=A0=A0 hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid=
}"
>=20
> +=A0=A0=A0=A0=A0=A0 hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2>=
 /dev/null)"
> +
> =A0=A0=A0=A0=A0=A0=A0 _setup_nvmet
>=20
> =A0=A0=A0=A0=A0=A0=A0 truncate -s "${nvme_img_size}" "${file_path}"
>=20

Alan's question looks valid for me.

Hannes, may I ask your comment?=


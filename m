Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F159C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8rMuvxJ2bnizq9aioquG/m3pLugRayXM7NMN7dPTuY=; b=L3apDHUC/pO4orjcn6mWZFg9Wv
	Rwv5qX6WKl6TVdwePuQtirUO9y+7b2lTvMW0DDsw8c0bohpFSlsggU9GNkao18jYJUusNiorqoIRp
	q3PT68dqR1hQP+dY8QGN9zBC15gY1J3aWrERZPh56BtfJNg18h3veJV/HxrZFlmtY9+lWj/19ROWR
	ctPdrZBaYytTrlXcqOoehXkGbjEgrJr3q7KxjpJJe/vra/DXfXlG51x+UijMJkp2WXKpE6+6Ei8Jt
	/JoCj9wSpLR3MZiZwvELhqioKXp9aCnGGuLlPzVxyw2yZKVHkr1J01B/0puzHbxkJSvmsuNzldJ9t
	6LXtgDxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNPx5-00AGsk-1m;
	Wed, 10 Jan 2024 04:12:27 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNPx2-00AGsN-1k
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 04:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704859944; x=1736395944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V8rMuvxJ2bnizq9aioquG/m3pLugRayXM7NMN7dPTuY=;
  b=EoE4p6s9Ql8h1wXdj/Bv24icPAIxp7rV4wpukCEnta0EcQMScK0B6XP2
   Uto7fGctBaJZfJgbIRvUVWTIoDU6XlSmUq9pe3Pq4UdkmR3stA7B9N+Yb
   jxm95W2zZ+/9Qh31uQ3qa8dpD9c40BPqTu04mnVU/OvdKc/YrFKWNl8nT
   qQsSgp+eM0ZwQDCdlp+uXStzOaVE21HjEux8E7nAjBfYax0irLnlQ8MAq
   7nIKfjWhFagm4F6WCN5EH3VlDlDiEC1mC/cVAMMelSgPBItvV4VTyO39x
   /whzBlylamaXoPzJ97sCvt9QpJlmm6P2P9ANweM188NxVLgaFhF+kGl6p
   A==;
X-CSE-ConnectionGUID: iDjxSKXlT6ChHILQ+J+NBg==
X-CSE-MsgGUID: LalTqpwFQYeF8iS6i2Um9Q==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="6630615"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 12:12:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgqRJnbu37ImL3cPugImmT5IH46KBkcOT3uRJs2afaJmboJ8G+CyIiqDK/my0bG9JJaFHrM5gAP73rLU2AFQkNCLO2tR+sa8oXu57YAhXVpXecQHQ9BJT7FGRogR4SNraLhNAAAAb5q0Brp8jqxDXbWEoEo4eZGSDWkAxKoUO4RXmGhFEbjgCgHExU5jHt7oZYRkyRPmlAONciRBCwrRUodIl27ghIiKdKu7aOAB67W2whGRhQYJtoWFkOtaQ3LDQXc9K/OM9ImL9p1gskaaxsTm1sDECfLiQXO9wP5cO2G/QGbXPczxs2rPJJgxrNxjIcIVBofMf7k2YkIghjM3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8rMuvxJ2bnizq9aioquG/m3pLugRayXM7NMN7dPTuY=;
 b=jQen1T2ADBiVewPaAlsX0os757qzvaFDVN3ASY4tV49TUo/GKhJUAMnKzUGQW21IavoQJiiRxe1hSD+Q94bLU+7qm/we9hfxmPGZIYhTjCOm7PW0L19oCi0JfAO6l6N4weA6Vjpd+WFADDkomoStwjp7VVbKC/IXTkKvSAW/t00OGcN2dFreE4fDp9aqdyvbsKpZ1nB69mFsaofVcO+ahTtUJU07297nHW0nawzVubihleKyhtT0vbC4cLDCR44bDehVeQJbzDvJW96ODSbgtIpd9bsakSXgpxCzN8vytfpBM/myz+TTvipaEcc0N1ZVmdk945SUkZuCEtMoI2ATVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8rMuvxJ2bnizq9aioquG/m3pLugRayXM7NMN7dPTuY=;
 b=aQF0hOwhgqhjlAwNj6nGfF+Q5WDidGhQMF19mMO98aQdpTCXrhOarkDjZFXHwZyVcsqxRkdChKWU2lLXuhVP43FAZgdtoxSo6qGUYJyvZYvxsLzQCOJChavryCjRBkTy0LdBQ6bg452mu+HPpL7Duhdbf4WXZlsB9HWFDKCXeg0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8676.namprd04.prod.outlook.com (2603:10b6:806:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 04:12:16 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 04:12:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>, "hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCHv3 0/2] nvmet: avoid circular locking warning
Thread-Topic: [PATCHv3 0/2] nvmet: avoid circular locking warning
Thread-Index: AQHaQ3sxx7f5mGME7EOMJKhqCCpWww==
Date: Wed, 10 Jan 2024 04:12:16 +0000
Message-ID: <lg3wdiuk57fveobxy3vwttujrcbgq6zyggqhipntqdv467dxd5@7dl44oec25cu>
References: <20231208125321.165819-1-hare@kernel.org>
In-Reply-To: <20231208125321.165819-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8676:EE_
x-ms-office365-filtering-correlation-id: 042bea39-97fb-4d6a-5d65-08dc119254f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Ww+W/a3lmZLQh52Gy0w8ODf9mIvvRH7r6n74kYw5up92bDdqCkKyyi0UAPPeU3KB5RnGYZmi7qi94OaWV5/D5wYGufLkOL1Yz+caneWgIlAoOia5JpzXsrRuoxCZUk0eoKTeAVNlOfkxoKMHThjI8Iovm6fkjTYagbHmyMzBp9BjlsGG9R0J2se9MnDgoIreDSbeftt368pcZKnp3BGweNReD5DBQm2CBoR0/46cO3gDfyGrbjT3uSCnf5YH3NDMY5gHK1FHAsGZWOlDHKxQAT/1MmJ95JhFxzs/U0GPBYVgsWjnkTY1kYvlk6r4UU44AvCVIwf4N6DEjBJzDWNHZ8qjsNERd+LPQ34Luck8Q3zvRAeebwv9g+yNJUXN5d+sXViuZxtDvXTKfJES+cEiakQaWe7LrOegfJwl1iItYozhxvsThiK4pN3d2d/Vg53NRjibwcmdde6VfSux38bfGIQiixH6YrPV1OLXWngT18T6JtUc8f6RRY/UUC5uDKj0aqSICN62PfONijFxyeV9dK4C/CGmzRDNChdkgKtMFBJpIzFDtmsG4MNoyQr86+8XnEL6ZZuKqukNSlzJrjgUEAMRxq1n06a1VASvxXhn0TKxHcvAVHYuYJA4Y88lij8z/PYBZzlzXKg1vVos5035YSuPZ3DWO32TQSNLXDKlHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(4326008)(8936002)(8676002)(86362001)(5660300002)(44832011)(6486002)(66476007)(66446008)(64756008)(6916009)(54906003)(316002)(66556008)(66946007)(91956017)(76116006)(38070700009)(4744005)(2906002)(41300700001)(38100700002)(122000001)(9686003)(6512007)(71200400001)(478600001)(6506007)(82960400001)(83380400001)(26005)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G9B7yqza21og8toDnVyW35TClUt+2qkJHjrbbGZsiW4wqL1qzMxvICIaz6U0?=
 =?us-ascii?Q?6A6Uwt1WXFuW8KvimpVtrXtFs+fqMZlMTa0dH4h8g3hsr+GLNWZAyU7/I9i8?=
 =?us-ascii?Q?1tDoPA0FcVycoESXafbv6lu96X5kZ1ruLCAcE37W+bs8rmv8fx0xLBkgcOSI?=
 =?us-ascii?Q?4qDNYVNXtxoFsZnm228lHTmI4VrOcxSxyjfV20Ac6wWD0GJEq0ao4klInIC2?=
 =?us-ascii?Q?tZ1yJJlQI5TeD/fvLyzIUd/UFua21H1cUV+uaJFBrpxEU0Uqwg8X1uSl19sV?=
 =?us-ascii?Q?+2NkAcdgkdYgCoC0hzZsjsWcHyFSpmOJLGHcu4wO+Kj8jdXyKzxFxTTL1fIc?=
 =?us-ascii?Q?GLBp/wf3zWIyrVRLlRh9eduaRcVisnNAjfheFz/WIZAzC4si9rJRBJhuaOXU?=
 =?us-ascii?Q?ag2e8Q9J+6PyAXxQc61ZWryE5REZ+na4XpCopr8+oS5oddxfaMgQIo529YCS?=
 =?us-ascii?Q?8opBTKpxl4LPdIxJxUYxAxC1aQ/yxPkxn/+tr45iAkWtCgisU+joSssx+lCu?=
 =?us-ascii?Q?J0abEco3ajotDXbyc5rzPmdpgJhLFqoOT59HS9hkN8Zqpw0R/yMoE/ZgqgJZ?=
 =?us-ascii?Q?15ipYZHqQvwTywqrfapwiLcAsrlrYAhlEFPR9rhOJdImX74/TXPhdIOE254n?=
 =?us-ascii?Q?ujk9hZOn0aN9XwbWSm8HsJ1P+FfPmjAsakGDCDAwNXYNjlBYjX4cUYi5tzZn?=
 =?us-ascii?Q?XWT07qMgcWFpgGJUv2IoxjM8ojgiFeneclcysgXyfVbNNWqdeP2GlJJ29n34?=
 =?us-ascii?Q?zKA5Z5R3UHJufFUpzRQ5IyOXYkq4ZV0UXxhPTUM+nLFOZOGNHMJOFACOb8KC?=
 =?us-ascii?Q?cASjyhKVXdEVr9Jgic/cjjhtDZ3W8Gxq5tQdYoLnFeb15tqQdsy8HKU2Eavq?=
 =?us-ascii?Q?ApS4ARITpRctmy9FppkyZL+1aNxWeLto5KiuJQMZokSDHo916MuHzN9ESrKu?=
 =?us-ascii?Q?vUTIbbCqNImhkiuQpymnn6OXV9d0jfGr1uuXnjBoFk2k7fONWt1P1KSJ42mV?=
 =?us-ascii?Q?1IA1ObRJGHosGfe7OckSMiwLStalf4V5eegfxJ5+dKL2I8oMk/5jUQSushUk?=
 =?us-ascii?Q?F3E/uuK8BVhWb5H6Q0aDCtinXOkSKqY6MtsD8iCChLVpYSN3KTYYBNcEoYXJ?=
 =?us-ascii?Q?jannUUGDNmtGSM/JOTp/sf1roFY0hmXAfcPo/L8ru8tGaYwxfBHCBv/OKFl9?=
 =?us-ascii?Q?PY1hptROXb0It5BFVL2/k2gTKim7IdZ33LC3o09ChiIbr8IoeUaVsBjnhYjN?=
 =?us-ascii?Q?Lfgf0GdRvgNbTnrQh2oxyZx2SpuSHJvtgaD9t9GbCGe0xPU/33ZkxiUuQWku?=
 =?us-ascii?Q?XYDulVNCwXMX+2KMGfA84pBmVa4YdeC3DohCv0gFxoEXMxYyjeXobQ9v0LEs?=
 =?us-ascii?Q?stu/Z98OyjqaH96DrbtxaZldguWW40P7fAncrPhJEzpHAqX3EQxhivxbI5BO?=
 =?us-ascii?Q?vhO9oZAcz+RwAzb0MD3TVfb5NYmhuKjq1Hu//9myw5SA/yRd1z10nykurmCP?=
 =?us-ascii?Q?MUEK6n479mgw+tGtBgg/Ylk0bGNxqD7Atok40p6UcxQEf4RhnVZDX4rd4N9R?=
 =?us-ascii?Q?knwJF90p7HyXa3C/jaHtCt/2e4gHYVLUtckdQiNEpbjCIV39QVdvEb1ZzFKy?=
 =?us-ascii?Q?rdU0HY2g0X6BeU8RDgj06cM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BBD43B0559B134FB50F1EE7D7CE0D28@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: exI6FX/ZmNvubLNN7BvzZcqPTUApJCYFZDT8cNBxVI/fufNiZJLjzO08xNybbR6kaf7D+5o5L4DuEeUDtGUzK6DwJaNrz1BCPSIicui1AVor0QCZoSWM+gsHCoiLvpkad7MQmCrAr8K6hwGE/tgZB5TlzMjf7+a52LQK8FnmHuHcblS12nC9MlknG3ShqgvDu6/8XVdpg2//mzmlOvwIZtKT8H/CmUqenvVjA2PGKEBWKzjVfoY0nd89RGlvGjF5ZRVB9mrA6wC7DEkhowi5KTvcIzrgoiiq8vXoQxT8mhv4e4bbO5TObYYProcJ73ac9oyvCk1nyba3rXaflH67rHlBVStg4vGdZ7oYFJLm8m+5400OWjmb8qYW8PKNnYR158aUemPkhG2DB405PJ6/VVL/q+1SRTGB7IGe6cYlyHlyzFMqoptI3OnhtwLYDzsPHY4ijqSbNe7YbIIJ0BfW5YP19rsSdx5cs801KiA3WPCOYrIbqY7bX1BMWG5HmsHDm+C0PECkCJLUcIY+upiFC/NqxJF2tWAK7HnipiXcoQJphQeyFQhHvA4sLdb7PBgw7JTrt/aVUYE+0eMMT55m+Wp82KFjahkYEavNRMGyPg+2tZeh+y++N/P2JYhZXKEh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042bea39-97fb-4d6a-5d65-08dc119254f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 04:12:16.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOH8uH+S/AsBK7rErWro4krHtPEhE/d/WPhsJmgaS7reg1wtSboq5w3bu/M+PBl+poEbL/AfGH5iHqjfFzg7/Zy9qxQn8WW+NCDdhLLpCtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8676
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_201224_660585_55483144 
X-CRM114-Status: GOOD (  15.86  )
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

On Dec 08, 2023 / 13:53, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>=20
> nvmet-rdma and nvmet-tcp trigger a circular locking warning when
> tearing down; reason is a call to 'flush_workqueue' when creating
> a new controller which tries to cover for the fact that old controller
> instances might be in the process of tearing down.
> However, this is pure speculation as we don't know (and don't check)
> if there really _are_ controllers in shutdown.
> And even if there were, that should be short-lived, and would have been
> resolved by connecting just a tad later.
> So this patch returns 'controller busy' if we really find ourselves in th=
is
> situation, allowing the caller to reconnect later.

Keith,

Could you consider to upstream these patches for kernel v6.8-rcX? They fix
lockdep WARNs observed with blktests nvme test groups and rdma/tcp transpor=
t.=


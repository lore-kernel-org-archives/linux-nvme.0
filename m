Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB012C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBsoSDFcrGBX3Uksj7mZJgTPB8dF/9JA+3i4B26HsGg=; b=gcO8UleL+9pNEvFedWbokHsCeG
	uPC08TXcreWctkjbIUcIXRQCrYollpDtwtEq4B8E2Bwqdo4MNKVOQY3nF/35pFeY8xpVmRC85cjtx
	1ZYvPLZoyom2yQkc4l2lLjzjBnDTG5f+0+DCWV+cpjmNdXSpdvWDCqM8Btp0mdbGWL9KL0TavX0c8
	scJ27Bc8TiYWUoP4dWAXG201INLxwZJOKswt++EbhIjY+17wYpWIzRSxJ7hRxgBUtkSGxE6NFrBah
	cq83XYi35k6Lqv9joKdgugSmg/2ikObdoVnApAt+nPpXzXEj0rJNHAFbIlCiBg/o1b4Yjib839jg9
	AILC8xkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAhUi-00EoXX-HN; Mon, 11 Jul 2022 00:41:48 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAhUf-00EoUX-LZ
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 00:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657500105; x=1689036105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XBnvg/UpwkE2mMbKq4EUJUFc8kG8ln0rJ0RvnCKKyxk=;
  b=rcSqzoB4ShplQ/t91bdPq0p2ytpz8qEeskUQM7S0LM6RnJjh5c8iEyDt
   XIFBj5K0UbJ3aRj9RO/OSDm2aSRU/Ek/EIeKNEYU6vym5jROFjFj+pluv
   3MvZ282mRRpTcFXBlNW8zVoLoSAAHIvtmG4GOe/X5gNPt+H9BaOPjXS2E
   0ujoO8Rg6PLuM3yNSutU5H8GeaClKoA7151A4p0QOrmTYU8lKNyZiql1A
   j07a154gEd8maXt4fSE2XnHQIsdWk680zhCc6s2vyaNDXAezm3S7P1LKp
   j4gaqSNq37aiiixTJkCKhBmQOOOwUlFpDgH74PUEMZQDheaYLrW731pqm
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,261,1650902400"; 
   d="scan'208";a="205314553"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 08:41:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDcn5yiFnvgp5f+KftzmDqShoVAjWkKU6VEjMp9vVjAn2yYIXrlAkWr/CTxwSUTGu4mexcwgOrlB3o/6+t9yaDPg/KsSxjHnTh2Q7iyHRDVLtu5GI3WCIkBk71zgTl3sURpOTwhihRfzULliUl53Rhjow8Et55WiH8lFDYi5UFx1YmoAaZTCkLpmJQuSqb77rC/4tb51cPIwxkHVdR4XUQA4uyAXwcqI3g51YaGUBexl7cKKKjY7fGDUbWIDPOqk9ymOXnQCbsMZfJpM2RSI46/DNTB5l+a6O483I+GnQ6jTFsACFSxmyuGf5LIgoQ+dO1eBH12pYod+8SFZDjo22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBsoSDFcrGBX3Uksj7mZJgTPB8dF/9JA+3i4B26HsGg=;
 b=MGazgbTCQXoTv+VkXWqQ2/VVK25+Au2ir6pzuzfSmDYsBD11tqOFYN8tee1ih/O3lQODUbToLDXx2voC1u88jYYtFtLSdTfHda6JUE6K4nEzgO6oDL0n7XqensCTuJoQCNCESZBX2TUqkplNW5yMVkJdKVy5+6KOCIp35iOZH6zShEeexZSTd5e73kqu332EtFZk3SMWFT31dmY04rj1gYK2s93ux0JDV4mXL+RHg3nN18lhy7E2Yd5Ly3mE1cffEhBS889tuOk8lttEGvu5krJFdvOCKRXhsljMdcL2aQVrTesGUrb45orob4pB2WNtSHWkQJOSTrrFerOl4ELIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBsoSDFcrGBX3Uksj7mZJgTPB8dF/9JA+3i4B26HsGg=;
 b=pXo2dt70iekSz9XdVGGEqpQQnK3o6tJJZ3y8Vey8XGme/nm3w02UATjwAbtJqAriaK0fwIAs/4gzeWXa6F3PB0cVFhleFGtXSViRo5Kbp0Hr66zrlKt7sX/i5bxDpzAXZEBmgWiFTA6ebKSykiZKIiF/BMalTaWI1BRe2VAYdMU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB3948.namprd04.prod.outlook.com (2603:10b6:5:b8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Mon, 11 Jul 2022 00:41:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 00:41:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Topic: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Index: AQHYjJhcmIi7Uhy2h0O/p2K8uynWvK1pRLoAgA8f+gA=
Date: Mon, 11 Jul 2022 00:41:31 +0000
Message-ID: <20220711004124.ujr2r23zef7gp2ic@shindev>
References: <20220630154444.475600-1-sagi@grimberg.me>
 <dbb827f5-6202-eb09-dc32-d49d00d59cd1@nvidia.com>
In-Reply-To: <dbb827f5-6202-eb09-dc32-d49d00d59cd1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 072e8de1-4e2a-48d2-ec04-08da62d619ae
x-ms-traffictypediagnostic: DM6PR04MB3948:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  iTEpF9nb4qb9w6h5NveS7pUNC6QjzmHlXoeCqaCCrnNKzCXFv5E08dozRDJJVNoU0UrfSx/RRRqJw0KIehg4YhfXWyL8+wOvpg47HAOqUXpTEpkSNZxRhg9D6fbT3wpC0takV46bksPF7VwdyrPdR+BgQkPsx3HqK5keQXn0D2X9f81wQgsaIjow+M31o7F+LMQjcz7ZZXK3MWK2w0UiVMFHEDdEBsnaZkcl9rfjgLIOh8hOY9I+ENDRvBGxyg5gHYuDpT5pN3YmSXxZwwhwolgisyypG2ImojzSdk4SMwaZJbiwX3VOUDffaCXumOR2AwaJjZJALA8t5QgpI815rxy0ia3i8FIElTTDgI+auZtyBzIbk+2cB4dKGGvGRDseB0j6MFkuorSsFDJF/pBFbICYcJFbOQmQ7qA7Vv+RQkV6WGxpoZoMfV0v47JGaZI/UTt3qqb7kt1ut6xx4r52mcgBg6wWi9nqrAp4N/quSyug0Hmqefggi4p6qMVzGzfr8hwCXwPTIq0Rc4lgpDOT9NMYTsLHvIcQbCK5j+Aqff0UIfMi1+KzWZ6h+B9mcns2AgaDbDk9AiBnoPBhKF3jpfQzxiCFdh7nU2qbJB9tZO4vJ5/F2mb4AqHF4jtOvPUdoLemZNO7TiwJiPIWF5uRzSivB8Ulxc2msmNwmyPOsuFM2iN3ZjF0C6ToT6uNNjnNtsioRimPt46dDcGOv8NdLAjnnF6d6JPwpIg1Z1PjUH+XdYj5EMdb8KooK6u4RZiMyPxkge8VLR7Ru7YrAo/NY0sISSHaCoRbadWWe6nhRcYqNUzoQrJcmEFlMvfMe6N5
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(39860400002)(376002)(366004)(396003)(136003)(316002)(6916009)(54906003)(44832011)(76116006)(66946007)(4326008)(83380400001)(33716001)(8936002)(2906002)(91956017)(6666004)(41300700001)(478600001)(66556008)(66476007)(66446008)(64756008)(71200400001)(6486002)(5660300002)(8676002)(6506007)(1076003)(6512007)(26005)(9686003)(186003)(38070700005)(122000001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?xrEL3ABtp+a647nGaVpl5fEdbWvumk3j3EQt+qPjexYP6/3qvooSHL//A6PN?=
 =?us-ascii?Q?iCXJ7K5m6MfazDM0IW1a2Xoy331arxUZbCjDgz2oNGIctQBBxziJC2kk7Krw?=
 =?us-ascii?Q?cWZLSt9erAwoqQW3A9bZJ0nfxV3dPyLdR4TZV675F5z4smP2O4DqxoGBj/Mx?=
 =?us-ascii?Q?lNVbJgjhu3s9bz6uvjJYodrYILbpOfPRP7fLFsjh3/NQvqpA66fpUdD6A4by?=
 =?us-ascii?Q?msC2vXzxu3GBcBpwh939sTliUWiPxSGf6Jxz1cSh0W2vXpkrPFr4LfMKS5A5?=
 =?us-ascii?Q?SXr868lYUCaJ2aIdMRc6dDkjdliWauSFPLiyw+tomsIlV/a3ljRuj9gzBEUP?=
 =?us-ascii?Q?yUo/taNj4S+H2Yx/j+Id7VgQDD2PU0kNdsgiMr6NzNgfK4wlMIj5mP2C2RA+?=
 =?us-ascii?Q?DHHQsrQqctOdm3EgWFr85ifonAFN7N9kpdUHTJUyNv8Hr4I0qmhdc7ucyC/B?=
 =?us-ascii?Q?WqEpIoIwf8pL78cnxl0vvmeXNRuwfBfC9SkbATepIceVcyYcUdQUb1U6AY5h?=
 =?us-ascii?Q?6RiJzVMXg2V3hZFnISpIUONVHqBDjtsL66b3IJvLJgnC/NOomBNquWgaY2mO?=
 =?us-ascii?Q?R4q3Vh09/m41BSwttiHCmZSObV6/RVH/tfe3K+Ohu0Opgpu1QXVRHzIHKfRU?=
 =?us-ascii?Q?SgPgS4v2+qLUsTi02ctyIyexF7Izgvyt4thhOb5Wod9QIu4D/ffLLfpavxy/?=
 =?us-ascii?Q?tzWpwlUygw2WlcRx8wR4l7whD2RvbCEEnmSc/qenw4LuvXUAeMW/EaIpfMgo?=
 =?us-ascii?Q?dYQKqRoq9Z3JU6eAddlk9qPTNRaglb54oXU39WOrIY851FSs19BN13E51A2Q?=
 =?us-ascii?Q?PpNvfSen4dDC8rJkuGoKcX3MXk68cettjOjEVVJXRWhiDxqJ3SQbYIN9noBZ?=
 =?us-ascii?Q?rDhva8EkeVuGNB0DxwIqLAuPLuA1vG6D0dnVKzQhr10z4YupGgAv4p4vVTTd?=
 =?us-ascii?Q?QUjDOhbm14VVKsoCNBgcK72mUl8W2u+ptuRFV8nvNm/EFbb+sfHcxnqpvGjp?=
 =?us-ascii?Q?WozrkJT2JsJBhwbub3xHq4TX+tGrtzw8Q9475OiuCiGvfiY6d8BQo0qObf15?=
 =?us-ascii?Q?eAYM9W6Y2cDYABq0qqm7qNeDw/yCzjNjTdYt9yz/FmNQStdcXUqh0B+EzO/l?=
 =?us-ascii?Q?HT7m9kfS5h7JQ+PFhyOkfRXbjbMm3vbmsschiewvfbFH8XptJIEPsxh0YKpZ?=
 =?us-ascii?Q?1MPqye9kgKq6KttpAChboXtA1FelEpJykcz13P7Y25uqdtO7i0GjUHDTzY8b?=
 =?us-ascii?Q?lGPBAG+A+Oo3/yr/UkT0JHNuYeI2SplamTcDXAGlvRF0spGoYDzvZsrtW302?=
 =?us-ascii?Q?nJmThuC9a4A0k+JL1PFoATVdRypTXXFAIzywo39NuT7tKc8HoG7cGKBkyA4b?=
 =?us-ascii?Q?SQbb+tJ5M3KY6SPtjLhEODhBnHdGP3ppAjJmghpTyD83kY0M9pT/pcMP/Ann?=
 =?us-ascii?Q?Xb4gVrQOxUE04Sit+KtwXL4XH57uVNGNUtAoi9MIVfmnFrqA5NZa6yJMdEbB?=
 =?us-ascii?Q?A2nGV/M6m+OhRZSzYW/QgJ/5GBzoiQZsOBZ35ONfqLO8ZWMew/xoGlyy/P+I?=
 =?us-ascii?Q?3yYX3KADLSejyp450uX6BIkXNz5mvEIeropaYrmaVV/CY9VHXgcWAx7gDhgj?=
 =?us-ascii?Q?wHvr7nmpQOnA7SLydJJUFGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A718772CCAEA8C42862318FA5B1A4444@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072e8de1-4e2a-48d2-ec04-08da62d619ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 00:41:31.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzD4dIL0+JkUIKODm5bByUQsSPEwF1JweKknR29W3v+8Pr6c6IVNVHPoKg8IlkMbpdkYp4zGbsO5r8vsK8lAkUMe4R65JWS+sXTjmgYxQi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3948
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220710_174145_945577_6656882E 
X-CRM114-Status: GOOD (  18.87  )
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

On Jul 01, 2022 / 09:43, Chaitanya Kulkarni wrote:
> O
> > +
> > +	# do reset/remove operation
> > +	echo "resetting controller"
> > +	_nvme_reset_ctrl ${nvmedev}
> > +	sleep 1
> > +	echo "deleting controller"
> > +	_nvme_delete_ctrl ${nvmedev}
> > +
> > +	echo "stopping background fio"
> > +	{ kill $!; wait; } &> /dev/null
>=20
> do we really need to kill the fio process explicitly ?
> I think graceful termination of the traffic application should be
> a part of this test without explicitly killing the process.
>=20
> I ran the test with commenting above line it runs fine :-
>=20
> blktests (master) # git diff
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index d259784..0dce128 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -49,7 +49,7 @@ test() {
>          _nvme_delete_ctrl ${nvmedev}
>=20
>          echo "stopping background fio"
> -       { kill $!; wait; } &> /dev/null
> +#{ kill $!; wait; } &> /dev/null
>=20
>          _remove_nvmet_subsystem_from_port "${port}" "${subsys}"
>          _remove_nvmet_subsystem "${subsys}"
> blktests (master) # ./check nvme/040
> nvme/040 (test nvme fabrics controller reset/disconnect operation during=
=20
> I/O) [passed]
>      runtime  8.119s  ...  8.084s
> blktests (master) #
>=20
> -ck

Sagi, what do you think on this comment?

To keep this test case consistent with nvme/032, it would be the better to =
keep
the kill and wait. But we may not need to stick to it if it does better tes=
ting
without the kill and wait.

--=20
Shin'ichiro Kawasaki=


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2437DC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TKD9ar63EPn79KlCxesy47tiAvBQ/xo+TPvKEVKRrGQ=; b=Ir9ymEN8U+ZOoR1cLeiQUuESY7
	cunzByG9XyiylNOmA3M0cElNiIoi11OkyPDjBjkLT47ha8vKc3pfg9TegUSFUYC/r3zt9XQfo/lPv
	AtABXsb/QYQIa0S5K077EhEUi8MeiV2tA1HeU+Enhjod2ckVl1qLFS+ATin0llUDQqUVtD3XOcox6
	Hn5tAb7wWOPMqGnEDCH5pT9AbTfNwhtXM2N59T06bJJh2EInzagpxTxWmFmKRdFijcN3ff6h5NoDb
	0h8uXWDesXLhm2jnw0zOJS1eWwXO7lkNCCnOjLtUL4laZsXpBwbFiQc5/GMwaqvcT429q9cL/duqd
	8rmvewJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lN4-00HSqv-UR; Mon, 27 Jun 2022 09:49:31 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lN1-00HSnj-Eh
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 09:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656323367; x=1687859367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AYCigLXKFnHlq7NyXifbtN4txcYg4Wl9xo5E2+KYkqw=;
  b=dL3W/01yNRX/nuMGb3iTalvnzJyUnJZiEL6N6isC6cRc6+2uYWliXuzJ
   1lS3rAk/LNeoeLOpAtl//WxGQHTktLKHJ+47lBRaChnYDQRgVe9GREYb9
   N5Oc9iSfmtjDG3LLb9865kxzrX/fQw21y98iaW0MoKKRb0nCZA8dlfg35
   9n1gAcBa1iQ8G2mrvyiJ0bIwjALJ9sy8opPSaF/tHqVlhJ8ALffX8PGdO
   rTrxs4MH07HE9JSXWbpTrCiFjcGDOopT3KGmPb5FIknJG5himTHHiQ6Uw
   k3R9AKU9IlHcYF1/HHOOrzhSlHdCaYAMryUk3p1QTezo4kuACDphNgkJ2
   w==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650902400"; 
   d="scan'208";a="316291985"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2022 17:49:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBCotBH9TA0SmbvxQOtu1yHAotWg1lRU5RljZteorGobLq7vcF3bvLEtI+VtIwahYLaMkV60mf7RN1+XwAIva4Ylvdff02QIHqFRjyBTKq2mZmUKm5lR6rSJ2bSPVkahgx9Gr9CPyU4YnNSLi3Z+XqNWf1se1+yLx+cMztWHDDcLaSRQ6UVFfS0xbVtz0X81/z2/3Z6vRj10VroIB86sk95ijpxPnhgyUEuyIPobJ9gSpllGmAD6+hEUsTqZuylcLiOvJbmVOK3NftWTC5fmtiXO2f2F8/Yc6GFMbBIa7g9lQM5o+lwUhQbc/B1uQihtCmNLCp+W0KYyum/LQUZW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKD9ar63EPn79KlCxesy47tiAvBQ/xo+TPvKEVKRrGQ=;
 b=aM+xi6WQDMPOTd1rSvs+3Z1VuDGDFb/WF0dLe8x+gB75Vly3XgLG8ffLRwz4cvmJSudvRx//cssP5S7bC4ZH9bzH1rGiViiyTMZLcO1KIn8f8/CmLErN4mmfbcVmwnZnTv5495RIaLbuz7dTx+r0FNWcPEGI8QA8JSQ3Q1rsrFIjPt5183hHPhKbgXJf3P6UQyzt5iZM9bsuv4zdkLPYR3/g/eYy7unMZlUbrGUdrdiBe+cLi2fmyU6XNvmm25tj4WYKvsqcLZfIBKZN31b8dZ1g1hc/F/L+yKPwBlrtEQZha7qK/uIOiz/rZLCcChtZC6PqYXOCfiEGXKjYvQf92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKD9ar63EPn79KlCxesy47tiAvBQ/xo+TPvKEVKRrGQ=;
 b=IXNI75QthE10i4pTQ8oSCRvSlADEMVaF8ASjNLxmoead0fqSqtrnf6hO/2ZH3u5G0+0j8SCICF2eZtWLh2Bp3PZq9wa/oGq66FUfxOblQ0SvAQoOz5nu8fQgZeQsfuoRmI9GR48oXMs13BC7eLZ0vz0LCWucAXueaocZDvIJP68=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5986.namprd04.prod.outlook.com (2603:10b6:408:57::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Mon, 27 Jun 2022 09:49:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 09:49:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
	<hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add optional ipv6 test flavor
Thread-Topic: [PATCH] nvme: add optional ipv6 test flavor
Thread-Index: AQHYiWmIadXJX9HG+kWHyEk9vZlnQ61jA4SA
Date: Mon, 27 Jun 2022 09:49:19 +0000
Message-ID: <20220627094919.unuzjvlzlactvke6@shindev>
References: <20220626143208.84997-1-sagi@grimberg.me>
In-Reply-To: <20220626143208.84997-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4e48162-cc19-45f9-833e-08da58224ece
x-ms-traffictypediagnostic: BN8PR04MB5986:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  zz96G40hQoyD5GXEl7Pt4736pKkeLPKa8rsONrBb/MSu07x4yoJLI+3Cb3G/FW8CiI0l8SmZJaaM6NoDo5mFwVGTiYt+HO6NOWcelh3ewJhrItEWESq7botR29zrQIssfXuFkPK3Eg2FHoQfARRTCrzYZSxMCfwUXj1Jxmfkzqxr6EF3U8zu1+k6zfrdhz7DgGUdrKx4/6cjin2YZUriZ8pl5iWfzCw/V7FFhIIXzwk2PiwP4/iZJuk260ID/IUcSl8Czptr1fTPg2Lx4oxNl8YVaxHR9xcDVl4cOX4ARAEDRFCFFj9jxw4aVx5QaTM54NfA7pw6waZ7TmvGOwLejkABtBFiZfGyB8R0h+UcAFOfhjxHPR0YEAEFjHD3zl9jKTtv0u2RPh4Jir38SrrYNCVGiLdI75HG/O9+w41PEI4PO6cobad+9HJS3QAmFwjJK2xs5ehFVoqsCgPdlfP7cZF0cwTTt+I5MSgvUBf9i/Lh99JHN0Jl6W1EtKIW1kctfqkC03uYpmN2PYqtYi2ArgPsV5Z/7dnoH1Eq7GtAVyU9FqUWaCIpNT/C0ucEHiBrxWhpMaInMaYjd4ONHx4kxvZvNpe/XoAWaRvkj7Z4kMU2BKcbYYvNad1d2QfnnNTa+20NMVL8MCya2X7DgiqKMN5EqMMsAu8yLs2j/g9EBH2GWUOBsDsBewRvK7keul5xy4BSmDeODoDxnU9D6wACQDBF2xkAKkG5iLVnd0zxloDTca52Yck8sAw6EN8QryJR1vM6jIvvrxHj+zo3rbkPflB+j5QF9vto86Ld2Kgeh1w=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(4326008)(38100700002)(64756008)(66476007)(66556008)(83380400001)(66946007)(2906002)(66446008)(33716001)(8676002)(8936002)(1076003)(9686003)(122000001)(91956017)(76116006)(6916009)(316002)(71200400001)(54906003)(44832011)(5660300002)(38070700005)(478600001)(26005)(82960400001)(86362001)(186003)(6512007)(6506007)(41300700001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?tA+/lyWSRuuveMS9E0f60U8q5+j0HzwJgGDxROPblgFnG1ry2sv95iQFKtB1?=
 =?us-ascii?Q?Qooazj2/muLu65fOXyNG8tLDSoxXVSVDOpEOJkgS8GScge2IGsusqS5FAtQk?=
 =?us-ascii?Q?/RhHSrERESzt0sw2DcZhMt/s5Uo8lLgsAFO8toWcU1VxYetKr00481nszrJ2?=
 =?us-ascii?Q?9b8DiiorIm8HrDGxJa0h7SnWOWwdrDlT+UhaYkG9gd9xU8loPsvUJc7u4jP1?=
 =?us-ascii?Q?ur0KwsM4YzgH0lToS0S6XKO4iE3xXLm0ufYPohU0rWXYD3PZ3nfcVm/rUAsn?=
 =?us-ascii?Q?/yDPu+OOE4sLmDBzdqRc2fM5P3khVtXWcjDsH/GuoC3PwsQZTRc4RNhzH1+n?=
 =?us-ascii?Q?poHMGjFJHlj69RO+gSoyLf2JOWbKvnK09D8IfNRomZKjWWkIfjq/dn0HBHa4?=
 =?us-ascii?Q?oQfkWaKnpgucUZG5vQXg2/uWPOwjOoge0EOdBMUWpA6KE49bVTA+ILDOUxk+?=
 =?us-ascii?Q?MtEN8wrNdSt63XnfHWl9wx6WTnK4e5kVDtcvaw1Y2Vwnz3Db6YkZKsV3Cp0A?=
 =?us-ascii?Q?mGzjWr+xK7Qg6VdNHNVLJKxkQSMIG7Q+aO3MxLt7BkjW93IMLnyGs5a+w+tX?=
 =?us-ascii?Q?WCFT0o21qWcJVV278PdS0bEa665976aQf+nVzRBZZfIlETI8o/YEwMP6C/Z4?=
 =?us-ascii?Q?nG2uTPTL0OuenYC+pOwf52L8I1q0CfQxbgYXjIM6dI0AYupVzwAq/gGIUS7M?=
 =?us-ascii?Q?s64FpFiaRCpS6EVJ06Otzbqq2iHh55kuNKjKTyIQ/Bxe9hgZKPCB1oAykmvT?=
 =?us-ascii?Q?UFqAvqy7c5Wqt1sqHaUdRoRtdn4O3y08gPeY4Yd2BYxaNuGH1uWFgCxJj5XO?=
 =?us-ascii?Q?dPwmN8nqQun90lXvVrbFdYVW1ru9R15U2DPI9VNzPrzuq+CxbCzxq56p7+71?=
 =?us-ascii?Q?NbJM0Ooc9CNIrUMnXngB4Vj+asrpLRULvXi9xdxdlhwoHzUcdepElM4XKgrO?=
 =?us-ascii?Q?3tNQVOWc2ycHJBQHttIDduR7V7Mpmupy62HTxXPoWPRiqA3IOXt7+cXHXwrt?=
 =?us-ascii?Q?8yPNkUWUSBVOziJIfyKstebdByJwDjk4/JymupzTWUnhKEYVB0ae37PlDT+8?=
 =?us-ascii?Q?TB24AJvw9dzNGNvdWMDkH5aJi+Pjv8Yn2VUZV00WaKQadIoZsIjPxN+Rdo2c?=
 =?us-ascii?Q?+MHfLrAnNXxQEjz0HWLumDExvrnzby8BrlbVJ+kEpGvxdkX/jzPl/+LqEqeM?=
 =?us-ascii?Q?y0SaTnEWmLVwHy0RAaEGL9UhcrdpSRJICrSJ9Wr6c0KKBuZx/GWSx5bou9iP?=
 =?us-ascii?Q?3fqx5usYH0GtXwUMjvqNnBmV2/JK+zRtES2tYfvEDWnIE4S8s7kZSssTMvOK?=
 =?us-ascii?Q?ENM8EsCCvITBlfEuYTe8HjRXmqy0IUlNGdRXg5FIYgN27oLHHZ9OnJXweLGY?=
 =?us-ascii?Q?gfpPeWZ2sHUNQjcpKoCyKQ+RnEkm5Z0+p9JyQIcURYiQimX4Lbx+uf4H+AwO?=
 =?us-ascii?Q?Qm9baFQ2fpouCsOv4H8LDrxoZNAeA7PC/Xf+gSuOHPY1frJj0fyOz7Ri6wFR?=
 =?us-ascii?Q?GezWf4c4wfh+4jvWJT20nFDrttodwhxnHaS7pv5NW7p8rnl7PoXg0QQ1eKVS?=
 =?us-ascii?Q?S7fYShVakoqCAdVW53fwlcAavIEmEdDiG4zCnNyjbsrT1TzlQIMTmzFJAXOF?=
 =?us-ascii?Q?MvXNeE8IT1I47Wax7slkERk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6DF76A93659DE4498CD07F9E348A4B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e48162-cc19-45f9-833e-08da58224ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 09:49:20.0010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT9LsUPqsqqcnj/QIPIuO9v7zTlT77yv0CX2LZUnv1JIWT8Jzl1+Reo9Vg3CYf7GeF7Q1MYcSIQfg5eSDskdbullAtJl2X5vqfO51y6XpRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5986
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_024927_820130_99A4F72E 
X-CRM114-Status: GOOD (  26.18  )
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

Hi Sagi,

I tried to run nvme tests with nvme_adrfam=3Dipv6 and confirmed it works.
Please find my minor comments in line.

On Jun 26, 2022 / 17:32, Sagi Grimberg wrote:
> Allow Setting nvme_adrfam=3D[ipv4|ipv6] and running tests on either
> address family. Ignored for non IP transports.
>=20
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  common/multipath-over-rdma | 10 ++++++++++
>  tests/nvme/rc              | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 38 insertions(+), 3 deletions(-)
>=20
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index f9d7b9a236ce..4307ceb4aae1 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -74,6 +74,16 @@ get_ipv6_addr() {
>  		sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
>  }
> =20
> +# grab only the link local address
> +get_ipv6_ll_addr() {
> +	if [ ! -e "/sys/class/net/$1" ]; then
> +		echo "get_ipv6_addr(): $1 is not a network interface" 1>&2
> +	fi
> +	ll_addr=3D$(ip -6 -o addr show dev "$1" | grep "scope link" |
> +		sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p')
> +	echo "$ll_addr%$1"
> +}
> +
>  # Whether or not $1 is a number.
>  is_number() {
>  	[ "$1" -eq "0$1" ] 2>/dev/null
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 998b18164306..b36cc19ec3c1 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -38,6 +38,24 @@ _nvme_requires() {
>  		SKIP_REASON=3D"unsupported nvme_trtype=3D${nvme_trtype}"
>  		return 1
>  	esac
> +
> +	if [[ ! -z ${nvme_adrfam} ]]; then

Shellcheck complains about the line above:

$ make check
shellcheck -x -e SC2119 -f gcc check new common/* \
        tests/*/rc tests/*/[0-9]*[0-9]
tests/nvme/rc:42:8: note: Use -n instead of ! -z. [SC2236]
make: *** [Makefile:21: check] Error 1

> +		case ${nvme_adrfam} in
> +		ipv6)
> +			def_traddr=3D"::1"
> +			def_adrfam=3D"ipv6"
> +			;;
> +		ipv4)
> +			;; # was already set
> +		*)
> +			# ignore for non ip transports
> +			if [[ "${nvme_trtype}" =3D=3D "tcp" || "${nvme_trtype}" =3D=3D "rdma"=
 ]]; then

The line above exceeds the 80 characters per line limit. I suggest to make =
it
two lines splitting after the || operator.

I think the line below is ok to exceed the 80 chars to keep the string with=
in
one line.

> +				SKIP_REASON=3D"unsupported nvme_adrfam=3D${nvme_adrfam}"
> +				return 1
> +			fi
> +		esac
> +	fi
> +
>  	return 0
>  }
> =20
> @@ -148,9 +166,16 @@ _setup_nvmet() {
>  		start_soft_rdma
>  		for i in $(rdma_network_interfaces)
>  		do
> -			ipv4_addr=3D$(get_ipv4_addr "$i")
> -			if [ -n "${ipv4_addr}" ]; then
> -				def_traddr=3D${ipv4_addr}
> +			if [[ "${nvme_adrfam}" =3D=3D "ipv6" ]]; then
> +				ipv6_addr=3D$(get_ipv6_ll_addr "$i")
> +				if [ -n "${ipv6_addr}" ]; then

I don't care much but double brackets [[ ]] and single brackets [ ] are mix=
ed.
Double brackets are rather preferred within blktests.

> +					def_traddr=3D${ipv6_addr}
> +				fi
> +			else
> +				ipv4_addr=3D$(get_ipv4_addr "$i")
> +				if [ -n "${ipv4_addr}" ]; then
> +					def_traddr=3D${ipv4_addr}
> +				fi
>  			fi
>  		done
>  	fi
> --=20
> 2.34.1
>=20

--=20
Shin'ichiro Kawasaki=


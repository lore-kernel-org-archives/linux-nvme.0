Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1037DC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Neg+/tclaEyNqUeol+xVkKwT7HkY7vewcmQhr8UC/xc=; b=UFIiB0bgtKOJDKXgbCABrgUGsd
	YNWw1UCb0fOX8A8nhbwVhw0OnYHJtrOtsp0EM4O8Q1U/qzyCmB4Qitr4WCJu292JjJY7Nus3pg/Aa
	Ui2ASuRJF7Pq1e1QyI+tvGJvGTMIcpY2rnjfga3nsqM8DxlzMGgcZTClwJdUpZDsGvHYs7D6pG+UY
	JmIuAWdBhb+1Eau4cr9yirEFdY49xyIXkIWC+/nR6fuEjli4oK5gnJA9dV2BsHUGyQo0U+hce5qMb
	QykmeB1q9TVK2H8W9Wf77avtNjG9Fa8dWEfpfWgCKgcGJp6yC9i6CHKcHqOl6R8heH7DQydmE7mZi
	i8s8/2Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rck37-00000000Yk7-3DZE;
	Wed, 21 Feb 2024 10:42:01 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rck33-00000000YhH-15zn
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 10:41:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708512117; x=1740048117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=if8Hj4IY3a6Q0K8DO1vdEV6iL1NLezl/9sg+dL3HdSU=;
  b=Wr9Ye92uXaKuY9NqeH9+rVqG1uzQ/MsmnZXSj05xPCrTasITyghcuz5K
   9y1zWDcVtNcdGGbOE/zaibFMrhyIoptOBlBZ0B5AYuHJEXY7EkXGx+jXe
   6Qv89qNajW+OOBi7pYUKPbRspdJpWdOdKY8BfyxxSI/uFocIsFcCnLsB6
   vbTQ1X9jEbbiTnyYAAwFJjm8NlqHa1/3cQqP2PKNZE49br7YCcVrgSKEc
   nXniwguU6yh9X33Wsy0PcMoZ6rY4S2SmyRFYL62R4CCRJV3xFKWUgdGLv
   /J5WeKNexSvzq0UhY66jZAlVX4ol6mbABGeI70YZSoasxFxZRbShf2n88
   Q==;
X-CSE-ConnectionGUID: iPZ6GnA7QfmOWh1uGWr/Gg==
X-CSE-MsgGUID: +ieINPCITOqX3dcSl//Glw==
X-IronPort-AV: E=Sophos;i="6.06,175,1705334400"; 
   d="scan'208";a="9426108"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2024 18:41:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHOW6w+qfXsx4lkH2N8Nx5ynTHT0QWO4Q+rECvm+s7FNvaa+vYC/KVO+vMin3GCn5shhguPHB/A53wFVhmXVw11l5T3S8Ousgm7CDV2NjqkhJgdmCxuL5bWeOq0cgCBDu4NzNS2fGJ7VadFrOv3aAcZG4hrVg5NVstp+1qgDhTqxsaHvqIV6h7bp2GLzO+n8tmRhAX7p5gL3AtqG93OBXws/T13MyQHg0AMviWFq3ewxvbz1Id5RWfw5MMUZ+UGhZvyGEq1mWFWuHO0FHyc8yJCjD23eyFKNyYW78FBE1GnWtfFUyp7ayBk6tamodHucUCp63F6Xro0m20W8GuIyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Neg+/tclaEyNqUeol+xVkKwT7HkY7vewcmQhr8UC/xc=;
 b=UMqo5KQBijY1RjDvYse6pDeck40zwRcLYOA2VFTlBNAVpDFheUmgkjeHJCqHJxNWLTbGal/ZYTLYF9VaN4Qb/xG2EdcPq0308OapnkKNjtHLYExiIrVj37LPpFlZWTg/YPpMQorbJQ5vUbVVfccI0c3FFc/IxxiN6ZIrwAj4sRVPU4tdUIABSkxP12XUtZg8bXNXvkTKknD9+vvuupz/y+KVrFN1mO5vpDK2TIT7kiBLEl7/y3NZIGPNY7gwefwAVKN7O4AAlzstDnBx+AgtdzyrRM9kGKtVauNWxAQbkdD1pp40pCBIOdTvni5mdbz3qs+Vqilae4wpl1Xn+Hihug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Neg+/tclaEyNqUeol+xVkKwT7HkY7vewcmQhr8UC/xc=;
 b=smniM8BjKQbR907YLIo517slNpc0AvmW9orbWsVsWe9tiuqTDYJ9LCyUZ9qLPL+91/9oe1DrX3ttgf/h/3R1E+uCGXSlm+qFFr5TcEPF5gzAMVcfPAJ5jXuZTxVqCvJ6w1f53Co/Gv/XzLIkhlj5iIjtij2xY5i75nRVsa9JcsM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6949.namprd04.prod.outlook.com (2603:10b6:610:97::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Wed, 21 Feb 2024 10:41:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 10:41:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests V2 1/1] nvme: Add passthru error logging tests to
 nvme/039
Thread-Topic: [PATCH blktests V2 1/1] nvme: Add passthru error logging tests
 to nvme/039
Thread-Index: AQHaZFSnSYkN9HqKCU6PNOBrcUg0pbEUnH8A
Date: Wed, 21 Feb 2024 10:41:53 +0000
Message-ID: <emp34ucgyak4r7ajed3nrk4npbwgv5hyfovlv7mo434m2e7cq7@m4itoplxugis>
References: <20240220233042.2895330-1-alan.adamson@oracle.com>
 <20240220233042.2895330-2-alan.adamson@oracle.com>
In-Reply-To: <20240220233042.2895330-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6949:EE_
x-ms-office365-filtering-correlation-id: 90285d76-ebe3-4714-bff1-08dc32c9b7d8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJGBm4qGCdFiCfScfrwgZSdJwMAgUldlZ9adnNy4GI3rlA9a3wuJT42EtgeLQea5ns0O82ib9n3e0Sjr5RzWS+r2huwR8qCTaOeHv6vg91vgEjdXXx+hs2UyTY9JWw0lb4UksWmPZ/bCPCOAf3BSnsqvq6W31VV6Qm6Voyajj4cngjYP+kvEX7PCiVfhPOp1lgEMxRhgB1fe42elkKXwpcQ2YGFw3aiVLCXOvZ3iakNxDfm5HW00LdVcfMfVoC2vMO3oyPNW5rQuz1K3unJDTh+S/p1blu0BkEHTk6tNJrDEMBrjkLMNsfz+kxDcPIgICv1DgCi5QSNDpl4xsqqiE+vx2RXD1YvAVvQR0HtMyBWO4lOWjDbuWMhUyLUIruQCny5kgTKnFqhLAzSHoiCL0dbAi1mqu3ITiPXnYguD/LIa9SPkbgLENyTUNMlvInp0Wj1KVPVEpzAS+tpE2twGkd53caynDvauwZ3gg+S3Vn4mjdPsjA2f4wSppyr1hyNVntiatiYz9VjJs8Tyb3m+5FqK5Jewpr1isL2ru7g9vlKOJjr/Va1zGzaaBZCEy25VgCYhkordvN6T6MQjsg18HAHcEMOOUGoX24d14dpr1l5IOdBzT1T22ZKNIRAZn8Gq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2dwxzdMH4wc5TxtpivE5O5YLFqAwZq6oybfPBnPZU+2LXxEppAFxowGNFwx?=
 =?us-ascii?Q?aEHGdiLnIyRQ51L2c+5BjNtnaE20eQ6EB4Op1gIfo1igcIwCsc2K4nFprT64?=
 =?us-ascii?Q?F9lI5fkBDP4bVwTAMAuaXSXZd+RIJ45l6fJVHZ++P/DFfaAuhJVFaqiwohSN?=
 =?us-ascii?Q?BQcEqslXcj/JDFfdymb11R/1as93fWc7+0VD4uCaCz5Ox6l37JpghsoxEyrI?=
 =?us-ascii?Q?SHLFhOHapwWRxxMk6fC0r8hjS/XBb0mK1q/pkWHdNPT9d3U3Sn5BcOam+YKP?=
 =?us-ascii?Q?hi2PDdbEiG4cR3zl7Jic1RIrt25yXShdwsmIjIFB1eVIoKkkegXryVAH4ZqS?=
 =?us-ascii?Q?OGwVlrUUUKBbGczaDPGZpayZjaGi7SvjnQnEiHQRdBtbkBIY72hLLV3jrJrk?=
 =?us-ascii?Q?ifrDDth8NsYMgiB2fCs1IchS6GB4OCwUdCKyLdhwtnPQtm/BZ2vxnD+AjRJt?=
 =?us-ascii?Q?e70GcQnZZzo3ZwHsG1JTlXx8eWQrGdO5hVqASglmDMGi/Qa8N8fi3Ugh+8BS?=
 =?us-ascii?Q?9GYWIt+GTBKQpk5hxyu28P94smLPZQ8FzIGAmhM0rJ3uIsSmST+4ai5uU7M+?=
 =?us-ascii?Q?L4NYoyjJR3vCxqvCJn8h7QEsVdFfDZ1mk/Ol1UeQtT4WJLQnACp9ViNZWQ2F?=
 =?us-ascii?Q?mraI6ZpW3vEfxWT5lgIdN99zljxRO2q6fLL8YRlw7Lf17oFZ6Car4WUwOIs9?=
 =?us-ascii?Q?uLmsQBcxybsmZGU5l8b+ATSZ3lugUAN/mhXi6R2OcjaPu/Z/2cY1M1ag9a7g?=
 =?us-ascii?Q?pn37p9mVfvg23ELzrA6tggyPsI1gTojYUoH+UCDGExy3aSOGS04Y8p++M/I+?=
 =?us-ascii?Q?aBDgdk+FtRN9uQqBKZJzT06ZdZ8duUMMFlHz7wZW1QKqUk4k1hcTn1t+J8c1?=
 =?us-ascii?Q?eNJhrd3CU3+pOujxnUJ9CEEvnTzv+bzfxRWf2jn2/6H9Ds7fi3wFjK49lo0R?=
 =?us-ascii?Q?jsUG/+PRV++Yb99UFYyoUNK5aMByJWlbOcpk2CYJ9oVs2OZZx+UXZ2pVxWV6?=
 =?us-ascii?Q?9KF4Ngfht6rZdWtp3VxGYmxN+pP47OwVhhiz2D+/AlTtweXemTJl0L6rBeQi?=
 =?us-ascii?Q?UQ1aXP/B9MVxcPcABLKsd/XrLkEv+yTzgr924AI+ABQF98l2nrfRpxSTcA9A?=
 =?us-ascii?Q?n1/5u31pE/xxLp2wqWXEeAnvbCbmnAS4OTNFhUhUQdHkyCPnzx1nDLv3ts9A?=
 =?us-ascii?Q?o+DIrwce/HJx/EwqUmOAPccNs10bWoCVByyMzBuWmYZeDzcaD2q3t4ynM/bC?=
 =?us-ascii?Q?TT7aG4ePo2Rq9zTEnSaJl5SSLlfO/E5tWdAyy5LzDNdZmHzHDN8m8g0Q56Fc?=
 =?us-ascii?Q?hzdMlpgAFPqkXlw3LIa+X+OwVbqpELt9RRR2x+RHbTrgHPOVgJABfJpj1W7U?=
 =?us-ascii?Q?2YYhcV+cnuNE1d2rvak1n6XaysA3Y8Ww18kQWgMMY3UMMxZKQQ4NSxuck02+?=
 =?us-ascii?Q?iAglT9iK6e/2AZPS6oNRjy6dypxyxNDkaHCmGm4AHxbG5tr/iGc1T05Ll+l0?=
 =?us-ascii?Q?jyl26qUYqiUK5WJIiOCs0Fv0QtfrQU1m1Z9AedssujjJIODFzFTPKmNDE4al?=
 =?us-ascii?Q?thoPDF8FZvmvCBsYqxZMMNrgcKRh2nFAgi4GDnZsEvpWNYe2clc6a53qblrS?=
 =?us-ascii?Q?D3LpG1av8LTB0J/mVWNyM7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1D365DE9D9F294CB00A994D104CDDE5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: REM9zm2nFjsHd8+YeLh5OlBaW/vU2sMDaB1pkwNRnK0/jNnxsGbzapHgHcASBH/COJ4NOUXAq1r5GBxsHvXzO5ss9YCmRCwMCd4qENAyJCXd6mO9C2Rz2fJo3rscWS8qyHPOPOQVujmRFQCdDxYP29asHveb6fyqXa4hDzZ8Qguku1VRXVKYqaV04bcXqKY5Zy0nLg//TGb+USGKehXy0OulaTUOjI/Gxpi67bU9zbR4jWCLYhomXZ/YUH3qvu5At9wgQH7Fs4/IsIE/AzwrWj5sFRMj+cQZX6nvV61ga7KA62KFjaucFmQJ/aoSGBpI/vpFifSCWSm7bXI2FgE1dV50vNNvf2NhUJ3a5pgZlTsQtHsJQZ0FCS72tA0ZHelKjV7M09x6zA86u1ReJec1nC8+M6bOf0a8FYz63IQ3Tr1Jqva6Sy/UhHStGt8TgyDDbaD1ypWcrod9q2oxn5urI8ZOzlo0Qs/MU8B6uyzXyIbBMi/sq6yY1vUazj4+SenyL9IIpf9tXXHM+IVXpcUdmbIEFfZVFdgEQGBAp1l5Ou7be/A7N6PA+MkV07Rzpwq1N1EIvv4QBtIMI5pIz5FkFbdSLftIfSlpcTrAyA0mi3KbB8jbJ3lsOvUuBNRiDXsH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90285d76-ebe3-4714-bff1-08dc32c9b7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 10:41:53.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gezF/QUp+3GXFTdpvuVTKUO32qvbiEANf4c5FTF7L5lC047v+b3F6MnsHfTQnV3DKtX/oAGeWR9CfzPuMgpLCHd3rzHw7P27ufhXE2P/ezo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6949
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_024157_536946_ECCBFF9D 
X-CRM114-Status: GOOD (  16.52  )
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

Thanks for this v2. I confirmed nvme/039 passes with this patch on my test
system. Good.

On Feb 20, 2024 / 15:30, Alan Adamson wrote:
> Tests the ability to enable and disable error logging for passthru admin =
commands issued to
> the controller and passthru IO commands issued to a namespace.
>=20
> These tests will only run on 6.8.0 and greater kernels.

This v2 uses the kernel version as the condition to run passthru tests. But=
 I
think sysfs file check is much simpler and more accurate. Please see my com=
ment
below.

[...]

> diff --git a/tests/nvme/039 b/tests/nvme/039
> index 73b53d0b949c..38a866417db9 100755
> --- a/tests/nvme/039
> +++ b/tests/nvme/039

[...]

> @@ -155,6 +197,26 @@ test_device() {
>  	inject_invalid_status_on_read "${ns_dev}"
>  	inject_write_fault_on_write "${ns_dev}"
> =20
> +	if [ $RUN_PASSTHRU_TESTS -ne 0 ]; then

The line above can be:

       if [ -e "$TEST_DEV_SYSFS/passthru_err_log_enabled" ]; then

Then RUN_PASSTHRU_TESTS and check_kver680_for_passthru_tests() are not requ=
ired.=


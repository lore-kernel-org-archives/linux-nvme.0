Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4420C48286
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Feb 2024 02:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxJ+4oV25SrDKeM8T7lk3caZQ+iDwMXuia4g0YZvH6w=; b=y+ECS7V+4HjGWu/yx4A8unz63Y
	ZmVl6ku+BYtDMp3Tto15WzG6aYJxH9zLn2AitlIfdaqFhPHVwixMsGk0G96wt9qb77jdddGTQqBbc
	qwy+XVmYtFFTiNAUSG5a91uEf3t9TYD+DW9PW8vjbKq1i5mnE2zDamSDrDlpvgdEa2kyLt7YEYcb3
	JRoWXJe7Pj5fLQ+co7pnNnn7UMpzJXAvbF1RJnARxB3o5CB3f0jLcoMme0MiOlTJAfiY//Jbgcrx6
	eaENxrC+jpanlsS38myz5zF5DDRcZkhJ4J/mOwGVPE9YJtdXS0mULJHMtw/PcO8Ndg4O77e3vUU22
	1w6EF45Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVj5a-00000009rxe-0Pg8;
	Fri, 02 Feb 2024 02:15:34 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVj5X-00000009rxD-3LFD
	for linux-nvme@lists.infradead.org;
	Fri, 02 Feb 2024 02:15:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706840131; x=1738376131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jxJ+4oV25SrDKeM8T7lk3caZQ+iDwMXuia4g0YZvH6w=;
  b=rbqBu8+PhWuU9KewjvFbtjgqrLs0d9xTUZ1aAyd3BVDU5bGvLY2wcex1
   tuSVn+U7MEF+D/YK7SPAmCUvmxKwCe17fQTWVyiwH1naEhLHEUeLopca3
   Vq1rRJhSCCEZss787YKY3lPz5K0abXKvT1hsKIItvyBPxa8gajhHObvBs
   sCSz0qLnhSeWBDpxC+rmNFe1eZfnKW6kaL6huHjUsliBM6YYaw3Gdv6mO
   36Sum20lHMWbpb2i7WEjPjnPeaVHKsGecGa2rfBCAaeBV4OQoZYt2NAIR
   Pmaovo2jqLz/UuWlQZik+Wo+ns4FvxKfUYGzHnubWI+2UM5d1303mvdqe
   g==;
X-CSE-ConnectionGUID: HdokgxwsRoq/UNuslayx6w==
X-CSE-MsgGUID: YawEF+sXSoOLULhnno7lLw==
X-IronPort-AV: E=Sophos;i="6.05,236,1701100800"; 
   d="scan'208";a="8557866"
Received: from mail-eastusazlp17012018.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.18])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2024 10:15:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHXgRHYjErfbERSTZ/PwvKwUSNLTXxxpLaMvrquurbxJo6IeZU0ssSa2WBcYqVQLNMjUTqnA08efs+YvzteFLO1g2eaEimoc0XcFX85/YaWiYKv/X6UbDFrCjlHBbAuDh0/wLq9NYjuz6reULASKI+NZVWPQK2LCPy5e74rpI3zAVFsFE8xYMDW8syqh30AUSre1kmap+/VHCbcK7nIaXyhuanmAfxmo0bcydXe7/rK1FguWY7gx/D3M3PPwZQkvSena+l8oeI31zQpZiuHmsrDMWE2WrLfoKro4E3GUEath6KVQ/yq9CU6jz11AWW/nSIKpIo0S9/+N9mjGfEJt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxJ+4oV25SrDKeM8T7lk3caZQ+iDwMXuia4g0YZvH6w=;
 b=QOMJY9buqphcxewAKTPlChouyd9M/e5nVEmT2ks3g3flDbKOdpfLbARfNfBX/M4ZtnZvkq8GF/HAzYpbg/QGHsebF27llsNSLV593vBfium5JmICB5GH5IkEfl1TSrU1gF8e616dJnGVoTL2eADbxlQhAT8YLD4jpkJwLWwR+xvS8p6H5bXzF813X7ZjP5bhb818URbOnhitpkji8FN94qpXRPG+EpR7D+7fbJPwWQAcOw0cc4q/bYhbGayUoXRTTMBMPpPcJ8mjC0Euzh1nfebYyLu1iweGk8Tv5PbUXauKjUlMANIhPlJJtDGLnChoKLx6c5sfuX12KoAo5KotZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxJ+4oV25SrDKeM8T7lk3caZQ+iDwMXuia4g0YZvH6w=;
 b=Vx/CnD553G6JeY9/7sinKmUw0VILV0xkjVBEgXCSnziwTWpZJUuokA+eK0oT1mZ9CdaxfNo6mRndRFamDHVT9A6v9qv5nt2hsBIMso+iT2vTVHRpbN2KOR+fm8Cn5SYWpJonrOPn9uty2IM9WGnFvJzb+QPfSU9r+e3qyw4A7S0=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by DM6PR04MB7034.namprd04.prod.outlook.com (2603:10b6:5:24e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 02:15:20 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::fe0d:ba64:1907:5785]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::fe0d:ba64:1907:5785%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 02:15:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Kanchan Joshi <joshi.k@samsung.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests] nvme/046: change nvme io-passthru command option
 from -o to --opcode
Thread-Topic: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Thread-Index: AQHaUB5qlkgR44HzW0asAZgIuL0s9bD2WxmA
Date: Fri, 2 Feb 2024 02:15:20 +0000
Message-ID: <65u5ume25havefrkeayuqybwwlmxc62uk6vvogihajn663s2ii@czw5a25k64m5>
References: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|DM6PR04MB7034:EE_
x-ms-office365-filtering-correlation-id: 25c5b485-53d6-4cc6-d1f1-08dc2394cea6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSCLLdVaEBrUOwaN0Kgi7Mzox5J7F1OWWeRSheRdliJUaXYVoIIgYF+N9adE0weRZNn10QCAtGknW5+YO0D/YXWFB/zNlWFz3r4Xznx/abFv1FgaeuzRdrNqXTzWf+bWbCqlRqhZDf99qoay99d/IuMxenS9DvKjXoNWDQNSBfCDVQpEL1z7zKfVRgqNL6gr1LdhJLkqOz2QzKtFraOQ7C/T8PN5zoi49g0HANoC7QgsJ+SwZEL7LmKORET+WymHwFGR8GGtQfL9WLmlRqid1GdlYCy90zlepklNeom+0/Zr98tFG1m8C++5WFASROrYSdTymIr1vi6uyO7KN7vSl/DuAGk162ySfHwuxN6FF8Y4d2jG+uuVfFeXGCDS3rUwsxkWqeM44lPFa7EXroIJASMTsXPVqWbbovl94Tig+D+911OrNnp8nR6ikgvwfDtrlMFyNwVvnLfrDcoPsvUmAtsct6J9zsRs+VKM2JtDJ0kk6Cwo5BtIK47C+v8djr81UbdYbhGd4V0vJ1YiY2iH7gzxgWLMzUZr80hXbQSFRHCIzL2FsEwy5yr+Pz0R8dLIycX515htNSxjCHDtFxHXYsvT8FrcaSWRWsX+Zkff6bHqTff216pbQuPzsyiWByzY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6916009)(316002)(91956017)(76116006)(54906003)(8676002)(66946007)(64756008)(66556008)(66446008)(66476007)(4326008)(38070700009)(8936002)(6486002)(478600001)(86362001)(33716001)(5660300002)(41300700001)(4744005)(2906002)(44832011)(83380400001)(26005)(38100700002)(82960400001)(122000001)(6512007)(6506007)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T7nwOk5CPl31xLba+2DCvMredGvwhicO+oOdgKHluCC2/EmOcCQek318U3os?=
 =?us-ascii?Q?IW46rPnDcHb0umAxMI/nanoiLnTfYz9Gn1qwNsNaNT0ylMAtmFJun5rZ/0Ur?=
 =?us-ascii?Q?bIiwM8+N8MC+yjSBfFA299JZsBJfRVk9M1nt5n4lLyTYzggfcB++nDLfDGuF?=
 =?us-ascii?Q?cgEStvzEOnUteIpKU1EF5dQ36Nqh/2sXJQd/ptbEg4Qi0oa0ykhhpQ+pH5uc?=
 =?us-ascii?Q?wZF77Rf8HL7TagTwVjD56ttwgkFAq4y6LlmxrVsiERO0culaI4ecrIqgxnQY?=
 =?us-ascii?Q?G4CC6lCd2x5rlIBkFDdM9U9rdWlzJac8HPrX6hpuo0YHoZ9yifM7E35qAvoR?=
 =?us-ascii?Q?uzh1QkpRGxdeG7zAy2RQ0obER/tALrVy0T/4/eb1+hfpJ+y6D60wHV6fCweb?=
 =?us-ascii?Q?HagZVhaH5pOGlNEoOY1K+OS2CMJLSktQ4eGaKBc3zXvTfOnHObqcFwqOW2El?=
 =?us-ascii?Q?F+1ICXB+8qlZVgkjM5F9NCnn+fQ18kc3kZJoZeKm7eyYovM8MM1rlu99HDcw?=
 =?us-ascii?Q?fZGgiVxNfA7TsNpH2/DzDMzqul0XOtRG4VwsNme1Jl45ASf4DTBA3xNUVDUb?=
 =?us-ascii?Q?lfT7Xc4PwcFvPxRuHFuc6BHvcnVufh3gfuDmmHtfhFcb05NrXUDz6OeApw6j?=
 =?us-ascii?Q?+hFDbsmzGtbysxU1SSR1RqNdOniVE655wmU0XtwZw9QRLzqxCWsaFVYMn5xJ?=
 =?us-ascii?Q?AbmaXwAi40F/RWFSa/lSICoAgGAbNU9VWwfpzFgV3aXSfEq4m0I27u4EWwZ8?=
 =?us-ascii?Q?PNxsPnCYUZ5eejqoqqBkefYJ2ukJC7xUGwSaojDNZym1wgfiFdNoJU1s7YPg?=
 =?us-ascii?Q?+5IZJsDxfpZ2H/J1Slw6un5X0xDFG0+ovvsP4OnhEAgIOG5AOVJRfXXeS14R?=
 =?us-ascii?Q?XRTS0KI7eqc17cYRPigW9amcHdh3zriwrOfBLlfAjqO4InSq0NJbOCxvBLnQ?=
 =?us-ascii?Q?C6p1nSbnRWkrt5RkMSTo9doTkjGcRp3FgIqJlApmqA7NjpjO0+DC86uTuqcv?=
 =?us-ascii?Q?5xTyYGE+SmsQrEEcPe3hV9FcjPBAJMEtYu9ZrM/B8ilzouzhjyEMDFpSBpVt?=
 =?us-ascii?Q?I8nE4gv6nzvsWi7v3tIgfb7RLp17ScfQFB73MephvJjETiAq/Qtl1K9EfK/5?=
 =?us-ascii?Q?dKZ0jVHI6ic7MFi3jpi17DLNjoHThdTVSVSfAh8YkTsfbYxtaoVH+rns9sSC?=
 =?us-ascii?Q?OEzYOjIdfqddqNXZXjyDoE0Gk6F4lWRvhWYp56y4FWAGTcBkkN96Avg/EZ/v?=
 =?us-ascii?Q?nwOg7tLw8EVo1T0Kw5kFq28Mzj9FMotX7GYaZ30jEdwrxBx0bycBCusUGs46?=
 =?us-ascii?Q?Lf1eoAtYyPg8rZ8SUMNhaLHg4hjVPlXr6OBcZVL+3f0moBnCjfhqnv4Qzrgk?=
 =?us-ascii?Q?9aO8h7xcxp1o9OtdEvIAX9LeNcSUo+zG8piJHHjSO6+NQo2wUGS0fz5bm1Mm?=
 =?us-ascii?Q?Q193sD6NIbWPEEHkWYtCgmWuYZ0yyf1N9D5M05GBE3FTUd3rIouIQ/07lRn6?=
 =?us-ascii?Q?q39hqehtvwNRDxWXHE1cs8dQyfYUaHPaWd80dhN2Ll8tMMZD847VI80U0v+N?=
 =?us-ascii?Q?mMliDDedLHI5+5/0ejEygcR+KS/ngnG+0EQXENjVSxWlHQzHOXYFrEIzIShF?=
 =?us-ascii?Q?booXCU0iyw+dXJ2GtERUy10=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8172CDE50B738A41B8C3E25086629089@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pxTv3ywQjLhG2rJqBfXl13fi0S0KUlj/sC4SMFANEZLcRlYEWU4/4WgZSNWOHJQGTYGgA/TmsoLQwIU82Cp5O1v5EPBY6ljiIA7pzPpxHUP4zEjBQOF/Pj7NLD8ax9JAdYSO0xXnJ1hhpEAZw0GzC+XIQS5PJ3Wnvim01x7tfhbkjiKZ2LHbTQ7l5m4XbGJpfPwLbch51S+87hEyuY8SgRdSl3zYXB+oosE1QGPNB7eMqgV4RfX/oxxSpiSqCjzWqOtD1xpGQQrm8umYyCoUGPSXLFHl5AagPyYFcBtPVIqBkO05/XZt8pujMekqk+8ro0Zvf/aH6vOJw7eQ4YiNSIrLZk7JU0TnlZBY2VfgEnIZJvknR66i0Lhv48qeU3Kf1FbrG2F/AxwEbXIPRBJkuNRnsErkzNAB4NcZAPbJdNiQAx2AVpf8/nUAg+yR3rxb++CfIB7lceDLL4/BPzXpJS0EnwPpjIU8bhLvX4QTD16+4cayVb1ZMwBvWo9Ua5HcDaU/Bd5kn6ZUcDznFDPJPMI8vOanVeIebfc139dCHiXDF5k2sgBBcd93oL0NeFKI9JbC/aeHUs6KNlvVYJgzwZZ9/SujjcenChlHf6sOhD3ODRdtWpJ0W9ok02li7Xb0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5b485-53d6-4cc6-d1f1-08dc2394cea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 02:15:20.8488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZdQvcWAegOFxzUgHCGta/8ysEqTRhyKEuuz2SBufBnCUK5OLJwy8mNTUT3yHIMU6gvge7CqvWLelto0WF0TuCgWbjF9ug6PwZmgJmquFDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_181531_883698_58CB5DD5 
X-CRM114-Status: GOOD (  12.03  )
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

On Jan 26, 2024 / 15:10, Shin'ichiro Kawasaki wrote:
> A recent commit in nvme-cli v2.6 changed the single letter of the
> --opcode option from -o to -O. This caused the failure of nvme/046. To
> make the test case work regardless of the nvme-cli version, replace -o
> with --opcode.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I've applied the patch. Thanks for the reviews and discussions. I agre=
e
that the long options are the better in blktests scripts.=


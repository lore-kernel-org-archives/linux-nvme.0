Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901DC47DDF
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=; b=EiUVegfOH0XLhYlXt4FTsd7Ljb
	41yZbETODaAMNyvyyPvfyONGCXhUwoZ4zK4ndeG+PdI8nPTPQ0WHpUJSZ+YesrOLkMPksWXMg5eDf
	DjLDZgWW/5AUwB0KUyL0ss6YYmAgWhPfPIoGj6HLAAUONEMVvncIVu3RwKt2Z3EilMn6isxnVTJUp
	GwJWpK5JzgR9ncgKR2kLRm/LBYicRGD/9swEBQxZY/PfX8AXzAtjlX7JHCH7Q/7HCxjhuONmCpSQa
	98sS0EK+wx9WffPXwkGflTUrnke2/Q6Xi3Wa9MI/xs3D5UujpeGn0jR5X1zgOeOZDPfFdJdnApZdo
	kW3FfcmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVSrC-00000007Aee-3MA2;
	Thu, 01 Feb 2024 08:55:38 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVSrA-00000007Adh-0bBz
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 08:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706777736; x=1738313736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
  b=QFFAyNAdx5c9FYXke2rE9yr6dZvlmACCc/gLPVBF0Z5YnmjH/0E7durQ
   9bGBDptonhy81c7rWeA+CeE9oAC+mW+g6bxzQLDEmpJRSIbx3L1fwtTog
   TavsRZ5WaLWD24IRp633XyVmeO4SE07WjHxqj/KGWvefQGqzAAFSY165N
   d0S5pGP+5vPP8i7mnMcOUx2r8QupsZQkJlHLCalDx/mGqpzce2pQcBm7K
   bn/3u4+Yj3JPzZ4byLuvwo7iDnfT4sxBWpOA8xLrd6crVQtkGZ0hETFkk
   taY2JGs3EJbuEnyelcTssuO6eq8rw966NE9Bo86mqGC+dWC8IIRGJLJv4
   w==;
X-CSE-ConnectionGUID: BCFzFLBNR9iwONzhPiApQA==
X-CSE-MsgGUID: Fml6sF4pQOCfUO08jxh5nQ==
X-IronPort-AV: E=Sophos;i="6.05,234,1701100800"; 
   d="scan'208";a="8176233"
Received: from mail-eastus2azlp17012016.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.16])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2024 16:55:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Par0hiS6a2Wn4SMbhcSHYnQv7B6mXXqEVZ3uoURNUkeBcZ8apjQlEu3/HcGN/JkuMPk9Canmp+fqaugyMRzxpKblqPmMO+33hCNxpmtf3ZfiydQkdUVsyepOjfY6iFeqvTzoE2l0bnUZCQ00UGDC0d1Xnm08KJeYnZ3aKHakJpIv3ja1kgy+7yylRAg1Uhf1bieEHV6QoM7jVGxXmVI1uI232ruICw3MvfuQMG+3FrkNbUiHAIl4wuG+dgiLFqg1Y7CfkGoNHMWMDg2zYajyl523fGh2sSm691J18BJWT/omzyTVCxXaHbX0NijOP2vWVnzq0XnMdFnKiwG8GCd3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
 b=FId1OygdYQAKTtSfqaruR4P5yf5dkB/qAzjawnGnVAH8hxOPklbitUz/KWFUupo3cLPNXFT5Rj3Giz0ttQDnKOQ3OVvbHpQD70y5oKlubvl2uDiPpJTFlseJa6wobpvUFoNkxldCSMD7/Fg6knm08hw90kNdA7xLyIvFKViwOx17D2xL/psRHtUXIO1uKGLOFlNe3+FXbi4UitsKXr4EOJC2SBKzFccnG2YaTQAxmjizuayl6WMJ5vdgerWx3mlM8Zs5aTp/zcnXopLuH/m2yBG5zTUggjwsoUFj7CiT8t4FDKkVpdb6dTcUBB3+skmuQ6aqFzXfekwmBEkOLpbuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PKYfzpCmGiSf2Oq++9LrYB4xpzRwW7NzFbo+4mVoR8=;
 b=ARw502NFg7vP3zzjplwWykx2Ar8tGWxnGFcyoIvNyIhGZaz08FyitbH4dxHQ13K0toMZ2Cv1BxnVeaS3Qoz/E4ZnaSOZXZZrlzWZ+SST40Oi59u1jQ5hY3Xefepc6BdfTGi/CBlhSRgRRaffGmfMv8/jRk7itJFHTJFGjTWTIKM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6715.namprd04.prod.outlook.com (2603:10b6:5:24a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Thu, 1 Feb 2024 08:55:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 08:55:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests V4] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH blktests V4] nvme: add nvme pci timeout testcase
Thread-Index: AQHaU/9hyM3n/sf0lUiQ4wyQitoIgbD1MNEA
Date: Thu, 1 Feb 2024 08:55:31 +0000
Message-ID: <6c574jvl3l4qty22sbstj3fnholnd37mv7knti5lwraoo4m4b5@uxrdvhauac5x>
References: <20240131043811.12292-1-kch@nvidia.com>
In-Reply-To: <20240131043811.12292-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6715:EE_
x-ms-office365-filtering-correlation-id: 8a66b9c5-b3ed-4e65-4a60-08dc23038b7c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTAOJE0Pp2n98RSYAlGd0UZVQo+K1PfRdSbrSww/2NQKLtveYwP1aZBYfYUxuBjDEcAKyHG1KAK9ZZXo67Ty5k3hKiOMz6aG9M2uZ7FHni2whPpN0SjBrUPXgUFd5nNoZmuc8MhtNruXkg9hQ8LiVylITq2Afr1IiVA0FxV/SewvEImTVZquSmcHMuFSjWHE6KNb49hvwwMZTC3nwC57/vrFjqROkJY6DNv6JGEKWjK2ODnBBjlLwi+vrMatRgMMjcMcHfa3AMLQ99H9twfZu+RURrycR92bCR4Ev9/JrZ71fPwBhH8gtpjvWqcIjr523pDIZaqTyMKX5ge1QbOVnTrfarPa9SdZ0jnlKReQaUmgGjuTYuwlDcqcpt8v42TdANcE4Cydaox30e2/B4CVRKWBPSEPw0Hx5hn3Wo5YlmO/hUMPyujynoNr3CNSTtxydYwGje/zmne/aBxEr97GRay9iDyHGGeSesWRk7De46iGwIYz1ZZnfEve9ZnAGbezR9OSdWlxCy1/QDozluUdPjllRV23DPwI7Qv+Lg9YIvEti7Y1dXSFRBmOpezRD5EVLp4BsWl2c6y12zmLg3+dMc5xRfOcVjfVToQ0LVFGnRsZTCG+tUXJE/Vt8g33ZOWm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(66946007)(8936002)(4326008)(44832011)(8676002)(2906002)(76116006)(5660300002)(558084003)(86362001)(91956017)(66476007)(64756008)(54906003)(316002)(6512007)(38070700009)(66446008)(6916009)(38100700002)(66556008)(122000001)(71200400001)(6506007)(6486002)(478600001)(82960400001)(9686003)(33716001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W4Y5ztZa8p1lSCH6/YDqDUWVvt2zVf02gChonlvfkN/GT3DIzBvnX27moNKd?=
 =?us-ascii?Q?Ttu5pLBoUVSa9a6kmb4FlrfBbyalXAXmGFf36D/YrggMqQsaVg/InNXUrmHv?=
 =?us-ascii?Q?xEetfuwhD6KAH3KQyaZiSGBrybKwU7daGcMRpBI7wsgQ6hq60Xh3Is2XBY1K?=
 =?us-ascii?Q?WyxQXsRVfrp/5PIubwe71pTAQASYUCaT3IEChv08v8HXO6SUn31PgXaDbhtD?=
 =?us-ascii?Q?gQ4RJrsPAJ7ASN4pyovygK+LE2Wc17maWhRLP8PDcO3yB49aMOXjw7nYhrX1?=
 =?us-ascii?Q?XjcZ+VsUgAK1Tdaj0tFw2EI306RzFs1b9fJeMFHGCCXKG39vFG45WjY0Ezne?=
 =?us-ascii?Q?4SvX2YU3RnYF1rm9DGplgNPp/tkcQ8ahDUw0bjwIGye1tKJmItyFjsuQCV6D?=
 =?us-ascii?Q?aPvg5BzKCmq6KOQWstqG1k5oVtFclC3kYj5sLg4BIdmXEQRmVEp4S/X7CSLR?=
 =?us-ascii?Q?FgCgfLmRbj53/gpYvPzi2z9Md+ZuyJJsmYFoiu6nucsN4bbyU+CslfNF+23C?=
 =?us-ascii?Q?K6ttPosOTWm+QNWr8A00d77hgX6uOhEsXWSVp1BKbtSC0ySPI3DqcdtFSEOn?=
 =?us-ascii?Q?8HpjlIqnANx+WEpW58WDaQO+sg2I/18qjkWj7VFMjOvQX4AhirsBhtsR+SjZ?=
 =?us-ascii?Q?rQvjy6B8CeuugpgtxzqQZaK6gBffs2LNwJU4io5aoGOopDuTx68bwUdXKO1K?=
 =?us-ascii?Q?olZZ7g6K0aGpl355UTqM3JWHte2kzYZu2x43Xv2p5pFarCaPw9xR6UXmux+T?=
 =?us-ascii?Q?6wbQHxP1vCrJGjNEfAIKVMDiR8zXQfgOLhGkQB1Ab/zSEubIX8vwa3c0pQ9c?=
 =?us-ascii?Q?64pOeq/m/yGR2IX7qiMiYQ29VZdX5uqccxOpxqsLu77e1rn06PBM42JcYvSM?=
 =?us-ascii?Q?/19zwnTlWfOMB2SZUEV3nsUaUa0wCs23n/0nXtw2zOvhFXaREeiiv1I0FkEj?=
 =?us-ascii?Q?h33Ws9To/knim7YDagc3OaHe0PyWH2xtCL6sjOrTIMRgGZd7mmR7qiXKBbxK?=
 =?us-ascii?Q?EjgSAHrC+35kdeCKpFvCUR+rEuhb0zNJ2EWrLik3cMXqZv+SHKrKMKjweFih?=
 =?us-ascii?Q?ujyspGomLvcbhbuM1jfd1KTFclqtRJ2oty0Oyqu4ape1qBIsU7iK8fF7JAg+?=
 =?us-ascii?Q?uTbbFPWJlu3B9IyxZlVLh1z3nSdh5y9+I2yY5o21flACR/vTOZ0CgyCC0Rru?=
 =?us-ascii?Q?BJb4J1zwE1PACMSwTHE3p0Bk5lbkTQDjEcP9/b6wTZpb08YLU33zSpZX6705?=
 =?us-ascii?Q?PhN8cPho5ovxOlV20HMTfrYAqf4l5cT/XmK3KrdZj5bkZzgK62m5VsK/9+lS?=
 =?us-ascii?Q?Ej7eMqYX3SZinkgWE52uBpEl8KbhNXAbC7nenG99AEV83aHdBjz/BajGteql?=
 =?us-ascii?Q?HneXaYunEyWdIJ34Bilcf7RYVP6jd8P1fVBcck2l0B1x8P4zudamOeohwtbI?=
 =?us-ascii?Q?ubkx64kwoSAARu17vJJJKuwGDjRkUvOhUdRokKdhMgvYr3RdST4kXErmkfrN?=
 =?us-ascii?Q?3/YBgsK16tESqIcBFfEioUovZsYTj6OG4OjvA0fvGJw8AN9V6lQVfrU2KFIV?=
 =?us-ascii?Q?lTGxvk8VtF4cMJW3lErVzZP4wInmErE0dYWqaCHQsybFbK6CZDnA64sdanwj?=
 =?us-ascii?Q?2okgqFWGmkUPcqMr9sqhYrk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5429AC88F5E15C4FAE299965CC05EC73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VuTHhgKw5oK9iyI28ZjiTQ21TRS8IX73jt209EHuv/lQ9L+Bx5kqwjXVcDuWYrath5B9VzJsDUmeB0CaYSFVU9wIvaTesVFM75UovJcwTYHMuohs/HrT+9ru0iQfz7nJRkjZg0q6Xc9RMpIT/9OF6bVI+RIz7k/8FztSR4Q8Ba0XItjLMu0EtgKX4grrEXB3qXgtaTMwiay9kEWAjsqmSFa3aA+u7p2QVoAGDO7KueOZcxQ+Yk2WpJGj5BR2CvIPmbX1Ywnx/AWqFt/ywgPum/hOMu3Pb6XtOjnXa6ktPHweNo5deK/bEPBJmgPBuz4YnyVoxb+3fQnEWQ8jHHFgT9qosRM8QJazgMKLQkc9o1uwAjkarHLskIxYIY6pjN8xuQW4mkty/XUfly0EULpjcBptvSuXywhhGO8gBGHkRDd+EqriLg1uYYK5277DvQXZ77prioBDikYORnPlCWuvBX4mRk9Cgs35DfwqCdlabUgT8/ROy5uTHD9aa+AnxACOMtbVnxMLO1SWsJcGZW1WOMKjSWZk2XIntBcJ3OGpuMcEmeSxHYegL4n7Bw0mQczjj5fhsNnm3lh03T9Ijk4BBNe9ZlfemDMDi4GIvyBJplU/mthBZSmRNuuXXiLZgW9g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66b9c5-b3ed-4e65-4a60-08dc23038b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 08:55:31.1414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ng5So34gcGMiJ0t9S4q87Pu4HSb9YRpIbpoWB0B6Y0oRWrNWJ1EXPPRPsoM1CkxKKcXlgn953XlwPUFxmvzxsgOdxyspwwVs225BPlS9eMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6715
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_005536_256377_E4970AC2 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
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

On Jan 30, 2024 / 20:38, Chaitanya Kulkarni wrote:
> Trigger and test nvme-pci timeout with concurrent fio jobs.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

I've applied it. Thanks!=


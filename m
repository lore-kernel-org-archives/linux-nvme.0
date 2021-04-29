Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21656C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:22:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB27613CE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB27613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=N23f24bY2HMkRPiI6Pw2GA05rFOSDcOSMvvpcLLwNUQ=; b=Gs7OoBcniF1LiKAsxj/n7qT6K
	PPh0Yzswfg8rBCgbyFapZOJCK1BEQqxBsYoj6we/jnNItGpo4zDvOqnxF8lsf1bVGpPKOFSDMOPWd
	6AMRKk1fSGLOhtBz6MxxZ8t1Jv/WCRYqNdw/5z1PU//ekNfweNWQu1YOt5PgBgjRn8Cc3pABgoT/c
	5YipTJ6QDMWcAnifaykuPgV0OHP4mubUQSyJnefiiPgn6P0MG41AnVd+duXKzKDiTWgMkWxXppKfU
	Zg5yymh2I2MP6QFrzvvNk6np9U14qo4Xn9nLig3QACmzj4/AFBsUSpfMsQUFxR+RJdb76JHggVm0j
	1oCAw3JJA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcBIy-006ArU-Uj; Thu, 29 Apr 2021 18:22:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBIw-006Ar3-Pn
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 18:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=BaEvySmsBdAl6oTNPQXzUZKzOGHl1vHSBWYm+GLvpqw=; b=ZDqZOO0Nvq18GuMuW1g0G9IS8l
 VWH8E/k7JkIHMf3TU9s3FE7aHtZm/XMhgjlx6PLpmC0NEa8+peCinh0S40eBI9+YkEg0EwW2AQ+FP
 RAEN6UICst1HoZtw9he3on+EDc1QaK7yyX7HwXTNRbJYveGnCC2WvSkWSsv9Ral6lLpz/mQfuJ4V/
 b8eB3VeNnedSCFZ/LapAzjg1XCp03V5DKj7QcwtR5vipKltTt7uuv6h6khtWx2W17co4JA0zDsmuZ
 0Q/jLTUxmPXB3or8S+vDScRX1J/9MpAPGZJ/79ROz9m3z/Xq4pSK5D8ueYVdKUdNg4wAf5r3C2eMh
 jRAaxcvg==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBIu-000qhE-0M
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 18:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619720552; x=1651256552;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UTJ3+BjR5pRe6ij4ssvxEKuXzhLEEq7QfmmmEtYfqmc=;
 b=S00QhGX1V8fchlDEi6COecdn/Rb5wKMYq7ouAUDawlV2oueIgNzl6ArR
 YmiAhT3aiiuOMTYHCr7zeFz8XZ/ntlt8Pe+/X+GRp2+ulO4ImnjsulJJq
 isu21iPaNfcaexL00xhLgAGRU9TYjPsrvZqC4kK1p61EctviXJDmPIdKf
 DvALUnajOv/54wYROKdcMS/PnwagA9b216MRzqGBmdhDCEsT8PufEt0WA
 CBN/uEV35TjLVuX4teoHbe4X7Iin+YlbBznTbiZva7jt817EvfNC+1dwe
 2D25EGhlzWKYWBUD0nnXRwvyCEUoBj7XWZApbSqzelrqk9Yym8QDUQRqk A==;
IronPort-SDR: TssSOVoFPNcebluKxaMIxn0FBy2nLPNS5J1dC1CegLELdcnD+GKltdqxAEtr+kkg4J5lvBTInN
 fFnsm3EbVIij8Dmu9ZkrzSMIMypUtBJfUDnOW/9Xzd59vR3RW/munTv8zvjbUs4/8tybjkFH8K
 aATmUjX0s9uhyxpMTngRxYQIPWA3B8V7NzYKCavSRtu/G0rxzoQbSjTuaoUFflXwmbzL57cqLZ
 8eof/q1w/FPpDgXsCSFFD242VcpJzLpMpLvTRno68fkpazzgCnMixvgoiP9tvosle6WaSWMInB
 2Yc=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="270620281"
Received: from mail-dm6nam08lp2043.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 02:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N00fSk3fZnzLyGnz6saKUrVKc0Uj0Zx6wHOV9lAt7oFaNOzDJVeMlFtMuNRL7vtOhjXEddC8hVmcueY6Hw8PLvpji35QUIkrtFxgZzXUinN7h3rURFqIWOMpD3Chjr5QQjlP+lIFENe3wodrcw5gZYLk0ur6Mg5vnN43Naavs+hZRnGI6q7PcumhCDYa2f8IRRDTasuAtaS2VxBOOOusQ5PSSrshVbcNWeJ9W4rtWfdwRfxvy6kP0HteVagBHjYoaqKa8shIwS9cRitFPyC9s20LsXqp8jStiQPDMgrhlPPWt9W2vIhuR/ByPfTbhL9nG92St2HVBxPpF9erbqLv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaEvySmsBdAl6oTNPQXzUZKzOGHl1vHSBWYm+GLvpqw=;
 b=Vt5l/KER56s/E+CFDL2uEEJgJEUHp3T7TkVi8+x8eiU+wxvYWX4D9z9UjhmmVxLQZILCyV9NzVnFirLtAW9mb8S58ysuqBOkF42ZeJgts2CbhX8cdZPdKCItb04COmGfvQ92iPDEUQibCtIopT/iJ3qmEhsUmGBXC0Hp/Z9UT/y4mjD+vq3LnFpv0oVJTx13j/CVEXWB25KXPn4+sUuK6j84rxbpYxRfipk2sDuf8+fdiXRrM7JBJDqSjW+fQ+q52DQRzQFd1Qyfd2TFcWZ60VCTFketkAw7IjK28mfbiwzJoHoMHOoLq5J4UnggCEDUqX7Ym44pgV+eXbLk4svvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaEvySmsBdAl6oTNPQXzUZKzOGHl1vHSBWYm+GLvpqw=;
 b=cmVE1Y6piAJkGZHHfuVE+89xm6gwlmGD5jEuk+aO17SPD6YvTZbpHGDgfT+39sOI5Ki2qTNItDG4qt9NVthC8NOWHIwXK04paPaMhRBvPPbFfngfMfxlu5X2w46mBnNDyDq0I975mDY5H0N9ZVe8XWNHPJju+PQJ9pC2VCu3GW4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6961.namprd04.prod.outlook.com (2603:10b6:a03:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 18:22:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4065.030; Thu, 29 Apr 2021
 18:22:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Belanger, Martin" <martin.belanger@dell.com>, "Rao, Vinay"
 <Vinay.Rao@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>
CC: Christoph Hellwig <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPG0XeEN+DoD31UWTKCt6MGrgfw==
Date: Thu, 29 Apr 2021 18:22:20 +0000
Message-ID: <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4c99f41-19ad-4ab0-da0d-08d90b3bba14
x-ms-traffictypediagnostic: BY5PR04MB6961:
x-microsoft-antispam-prvs: <BY5PR04MB696160842B6683CA8A610AE2865F9@BY5PR04MB6961.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5Oe19yiaqZIxsTPF66WwwB8A+p+Jkoi8H5oxJMUAvOTyALnb38Hk+TxdAVagjpqlRo84GmJ+9pG7SspZGdFaixNDk7rlZ/zlCHUXPQJo/4xbYulZS/O2ouJB3ob9R/fFcYBQw1sy6S0zUD2b+Y58d0IEScdNVAzKdCa9jj8G0nPEtzLVr7g7qvE5hXfg3Qk3QRL/cTKAgQbugYZOAFeN2RjWUz7/wTfiqk4E1GZcSIxN3HL74QG4GayyHb8b9ls2lnatmL28g7p2kwV1QlSa3cVatUlEIzkclZUx2KJ2c4qAZKGrL5Q3HVBYeUgj4m0t6emTzHGqi9W9fMOTRSWNhGIPoCVksfGyYFHNPT7J8JUULcCQFCV/c7VQGoQcKQYtxPJ/rDzxUo6OK+KBx3jChkP2Jc7PdDZj/bUF8K8H1SIJdTzQ/NCktoKlPDMgBSJtKpg2uNBLMipGzlekZapdYWTGGYORvG0YU/uYq+QsfcdqOovnkMZlrBqor2yw/MSzJL25QT804R5Q6G4Ba6HYzhhneyhOR7Gz9QQeCLYunIyYo1SRffiJl4e0oOr52qhssOFGYf+V80Nzp84282b9hPYE2FR5Ta3TEbs9jeKzbI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(316002)(110136005)(66946007)(5660300002)(53546011)(6506007)(26005)(66446008)(54906003)(7696005)(4326008)(38100700002)(8936002)(55016002)(71200400001)(33656002)(64756008)(83380400001)(52536014)(9686003)(66476007)(66556008)(186003)(2906002)(122000001)(8676002)(76116006)(86362001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aDSRYdiFle/I+0bZYzOPTR8ZhVLm2uArgP6vFWX4vIGW75UlPaTuqiCV3oIj?=
 =?us-ascii?Q?FzCWF5bXXVjYbQP8N7BayQnADgo7aq1C5GtwqzehhZax5AgB47tI8g6Qs48J?=
 =?us-ascii?Q?GdIOn1gwTREESrGa+03DYBDzN50mR+2p4Vw7BNm8Q3lNMUK+TRFPxzU1nFk9?=
 =?us-ascii?Q?ERwE96ZK6o9IV4qVIB1JpqF4a0l74rdUrM58K1v9IgoPhci027r4Guk8hjsk?=
 =?us-ascii?Q?EUw8bIxPJ8IHugaOMQbH8QdxVkkdR/zDsCp09U+1WFqB46RwDofEpALGc/Oi?=
 =?us-ascii?Q?N1S/h9ckowXmehY0y97bYCoOkMoJ2xG4Hw4TqRKsIfvZf+SlQM6RIsaezVWP?=
 =?us-ascii?Q?V8MlglrkknLTV2sCBw2SIMcLPZQ8kF++LQI5bXrs5iGbcR3VgZVBJS/MrAkX?=
 =?us-ascii?Q?ILRqFkkw8Pwe1BkNJtli/Z5l0BWXAMOdrzE6yYuRf2gkCfgWI/bzaF8SiGB4?=
 =?us-ascii?Q?dsxQcXNbIKfoUL1Iho3d6F5XBlYW50cNBcPBDmrVNW9qqU6ufn6P7Kk64K9Q?=
 =?us-ascii?Q?6tDILCao9Tm1G7GMtQX3O6vEOmoLceHIEMKHKWQSuqp87NaAiaD2htWtQdhz?=
 =?us-ascii?Q?zrQrcNNsYOelDPJVe3Hn+lMW6mEMvUfcf/a8xeTU950XPes9x3HBtG85E2Rl?=
 =?us-ascii?Q?ZZgiKpRZf7Fn4E5p7hznkEuyHbDtcZ9oqSj0odiqaUOybUYvDKEqzXC1WaoO?=
 =?us-ascii?Q?Ur+QGKC2rjfN742rMChA3W7rAWmu0JKxqVz0+9MCAAk/VIDqOlWAs3QHo4Iq?=
 =?us-ascii?Q?XDWEJdFl/GrJ69pU8JTzvpwfwafprbF0Wd5ocjurpcg2wUibbyIppg7L9SYz?=
 =?us-ascii?Q?L9V6m1mu7RD4NDbJ1pGudiGSl0UX9fdpbR5LiWhqV/Br8walgsxtlpKnOz+r?=
 =?us-ascii?Q?l4tHhITDszVqb5RQsWgZd+vg8IxX2RB8f85QD+I3alp/rZn/s9yjAQd9XlLs?=
 =?us-ascii?Q?bmf4zbaSBtFTXC2uBEdW0R6lUUk90r65ro/VXmB3SwashmLU/ZnbmGaw2wHj?=
 =?us-ascii?Q?vVs9dVnf7bU+BLJkNZvcENk0VzTkXm3pdgtgiSTFlARQSrZb6EBvbCYizrLu?=
 =?us-ascii?Q?Xp6otTOx6Buf6oinBPRYZ1BMIVMBmfC1q5MA7a4AwyfKuhE6kvS5iuJovqlJ?=
 =?us-ascii?Q?yIVIFkOSLfZacX9OYxlUBct3vJZ9jQhTJ6k0Y6zLPsP4GsBYEyItBQZrsBhY?=
 =?us-ascii?Q?Me1qDqllsDhDbr1V3J1ZpgL0Ogg/dSQ3yb8WJV7fYd9WP5TDAg3clQdmI9qD?=
 =?us-ascii?Q?AHUgacKb/18m4mDuBu5s5DEmjwVxX4y9OvJ3A4aoKHLD3+oENtSaZLTKJytE?=
 =?us-ascii?Q?aqkb+3DcfdIUc54r/ZrFivhr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c99f41-19ad-4ab0-da0d-08d90b3bba14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 18:22:20.1561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDvj202Hjd7lSB0chc6TfWbqObLOX6KhAyuNmepGO0Uoe6mwoYsECK3UZjC0z8kgooz7Dq3CiMTePtdr7X1fT39HXDwXVYL5i1wm8G3vLgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6961
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_112224_139556_ED5C0FB2 
X-CRM114-Status: GOOD (  20.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/29/21 10:09, Belanger, Martin wrote:
> ++Vinay Rao, Stuart Hayes.
>
> ________________________________________
> From: Christoph Hellwig <hch@lst.de>
> Sent: Thursday, April 29, 2021 02:30
> To: Martin Belanger
> Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; Belanger, Martin; Belanger, Martin
> Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
>
>
> [EXTERNAL EMAIL]
>
> On Wed, Apr 28, 2021 at 04:18:25PM -0400, Martin Belanger wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> Generate uevent on NVMe Async Event Notifications for NS_CHANGED and ANA. Today
>> the uevent handler is not capturing on NVME_AER_NOTICE_NS_CHANGED
>> (Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).
> So the problem with these events is that they are only really useful
> to then issue the Get Log Page command for the corresponding log page.
> But reading the log page will clear the contents of the log page.  That
> is if userspace races to do this first it will completely mess up the
> funtionality in the kernel.
>
> This is a bit of an unfortunately design issue in the NVMe protocol.
>
> Maybe you can explain you use case in a little more detail so that we
> can figure out what we can do instead.

From the patch that I sent on the same topic to enforce a particular
behavior
either way, I remember that we've decided not to change the kernel code
for usespace.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

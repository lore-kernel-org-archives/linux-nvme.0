Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A529C636D3
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Weu6eeMmdYIZNEB/ojfxdfzrRU7hjjY8chD6JD9sDLE=; b=Uevg6lRnGtT4y7otDJNEYzxx89
	jb494UyOQqlExCvp069XNHPYscf8VYHs9puapOurHLvvblKraaE4zxFSYxsSZkK7iMCRtemfSFgc0
	/NIqcgaSLPX4gk6GVKbNAgjCfYXJgo9nbizVEHxg53obHgKpeRDq4Zd7oDnpkrztLKOchVDWxcFpn
	210V0nASVA+Yov2SrslIyk7csGUDaA189V5bvW9dM/zlBZCknV1bfWbLKHhqza6OsWIbHg9C95aoR
	hnWMXAcCBNeP/Usqnko/U5pKZA1C3ylDMX8wooLpphqVRzERFZ3LWhHvcgUzKqLgU+u95AdUw+I+I
	WRXJB06g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPt5g-00H6Pm-M6; Wed, 08 Feb 2023 22:39:00 +0000
Received: from mx07-001d1705.pphosted.com ([185.132.183.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPt5d-00H6OX-0Y
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 22:38:59 +0000
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318MZ2bc002664;
	Wed, 8 Feb 2023 22:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=Weu6eeMmdYIZNEB/ojfxdfzrRU7hjjY8chD6JD9sDLE=;
 b=arY240FU7/z9w4hFvCb98iYPVnDucQM8VMDTIlWcy7jHxi3r3TvYZSCc78AkBP8HXRdU
 85BrkdbRgry1v1I/qrTh2Ki6Rjk/kzJWjqaSbigYVmMTcz7XvvGTtz/YRAUoFjBo4Mrd
 kY45GOz9l2fB+BhmLjEbDyEZkKMB4J9Ft4bKFxWkvqV2UCDFCxLOfES/wncT8lHucxx4
 ZyyFCVnc9noPXnQVeYV+JQkRYmSHKjEMb3y11Aug8G5pMeKjK7gUZNBRXaldPqSiXSKv
 9mb2Zo5k1Xo0w/r5sxxUOGXRlk/rywScNcQCZWVbUn/uC88BuCfKy8dfP73UwuIkAw5E uw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nhcm0vx44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Feb 2023 22:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdsZchvywU8vQ1Mcu8nya+DnIl96R/aaDRyJPPsrjBXpQyBHe43AEaEFu49A8siN3NG1apTnBgVj8b5UVjV4rF4gWmq7u+ufK3V8DUHyvaBxXnf6l8n2qe2fLwYiUTQBQgCZFevZRaiH96Md1LL5oY7zg2ht/WLBwMalqR9k+7kL7HMEotsbi8VhBtgF41rjvRyecbbAKRkkL03MX+xfo6IlERLfaYtV7gCyBX1f8IvbBgl4L/OzmSrqe7GPNG7/9MPHpsobCN96+GeDspsg6pzRFOERol9caFl44V7kCuIM4BcmC7Ck7F1bZvv4Pc2jmATF73mx1ufhJUrDI5ADew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Weu6eeMmdYIZNEB/ojfxdfzrRU7hjjY8chD6JD9sDLE=;
 b=MBpECxL05FKHv3bR0J2Qe/Dk59oPDply0Z427BTOBjLG4BGlvQvxZTtu1KLIe2KxQES8iDoHMDBs5oEkz1pAwtBI0znKbwLlyXWFLl5ZCc2oeH9M8OY5F4n1RAVZAG2OalGDepZnG2eAd8cqzkUGsR5q1jP2m8oh+V6+kX1qvkHbg/aOsdE5ym5ZITpQtMQac8Xl73OaZ5RJEm1NH1kS6gsTP8CZfhtgi1U4mCXnNJNaOZFiAupfI49q2mEI3lfI9ebI1UDI9vHpLx4ygmRDDzOWnFv1O/D7QleBC17U8V2ipulP5r0420+N6X3ANQ96ARenLf1DPol2U4q3SpOJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by BLAPR13MB4642.namprd13.prod.outlook.com (2603:10b6:208:30d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 22:38:35 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 22:38:34 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
CC: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
        Christoph Hellwig
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Lewis,
 Nathaniel" <Nathaniel.Lewis@sony.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBwgAAQ4gCAAF+mkIAAAwkAgAEdYVCABGnaAIAAG+4AgAALJ4CAABkAAIAAgJNAgAB0rgCAACN/AIAAigeAgADHFoCAALIxAIAABSMAgABTDwA=
Date: Wed, 8 Feb 2023 22:38:34 +0000
Message-ID:  <BYAPR13MB2486D58DB73FCE8D13A947EC81D89@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de> <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
 <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
 <Y+IpsEd8kMoljOAa@cormorant.local>
 <BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y+NEe3OWshJeHsNB@cormorant.local>
 <BYAPR13MB248670C9FD77D33422E4368681D89@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y+PeRAFwUkig00cR@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y+PeRAFwUkig00cR@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|BLAPR13MB4642:EE_
x-ms-office365-filtering-correlation-id: 404b8050-b970-4d5b-8918-08db0a253692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8R/H42j7qTTVRidKAVPeWU1eFGc4kJ7Xkz21f//HFbq+rCzSOwNWZ2Qi6Io0vDNQAitOn9UQ9BWFvX+ckBPoIwaghvcQHiw+JzfPWTCaG/BP0DzPbq+w8jEq7VBhmw7BCW9/a0HM2uRmqUw1raPGOZsREpEHAPxZXJqjt66Lo76PJOAHZ5SO1Tog+gpb9lvl+9gMRah/ZzNdH5thyXG8QwNIOcUGqpyYqIZ9V7+IDDkgtlV2bQ5aJxRxniFvvQqC2UIBySqy0mvCpaFQnfyraPTPXLpW7ZAzuXeUVsBMvvQL4ocUsPK2Qh2Hhf03hKx8K+LpHLOGRLJTsBUoVbAdFwgLRBfvWj4JvAGERizmCTiCQ6YQiTg909Pj65qF3UwvLVXsiymQgYc6StnZikgnPjcNsNK87awSfzcHrckm1vjkqL4EIHrAMJNJIZTOROziu7KDlETD/yuLcB5GdraLwqUHFULhWlSsqvXJOIzhaq7QrIGLrtc3USE5+AAr4Ig1kuYksDk1Q+Xo+PYBVV4TCbr62iP0s/Q+CvIQs7J9pyHSUz3JuVH1UkYEEZXWg39SxutzmvVIiwKGAEC789WKQf3iXt37GxvhbkMZaMh0Wa5DpQvTC06zTOe+L66r0yDyEFrMUnWcN8sU1CF9aGdc2dIcVvqS+J2b1xgQbBEdv4SLlQY6X4kD/awDXNKkOeNqvqlCN6Xu/w6VwzpCEgIHxQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(5660300002)(2906002)(83380400001)(82960400001)(55016003)(38100700002)(38070700005)(76116006)(8676002)(122000001)(4326008)(66946007)(54906003)(110136005)(66476007)(8936002)(26005)(52536014)(64756008)(66556008)(41300700001)(186003)(66446008)(33656002)(9686003)(71200400001)(6506007)(7696005)(316002)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?kr8gXyrwKdF+/ajhxdHEk1cvK/cbSdlPemmbRUREYmW0rxunFWvmaqz+On+m?=
 =?us-ascii?Q?9hSW9KxrnSNPt8q/0vP4I8BgZU+IQ5pWGcC+y4UD/jAyIhnUGjgYZ1VI9nT3?=
 =?us-ascii?Q?q6KBYG8UOzGgC5Ih8SZlpMJE6Jtr7d+3ob4/WJyoPcXqRrco64bjoJbH+Wcy?=
 =?us-ascii?Q?JwvE++zHWfEeTAJ57ff2wScEMQS7nxHhBfJLDvJqlcH1A0W07X9/bDIQffyy?=
 =?us-ascii?Q?22eBUXR5NZCgW7J2MqB206JxEbDOA2/TzeiFH+uOOyw5YFti3TwZEx/kQucG?=
 =?us-ascii?Q?MshOIkIISf4CDwts2iFbwe4xtiY1VLZ/FBYVsXxyQr2MrhX/ItOW+k91Lbqs?=
 =?us-ascii?Q?2/n1J9nQGykaQnksIiJNDjPfMqVFbTslrx8+0Iyk9RdNeL1nhLTrg4fmZFTG?=
 =?us-ascii?Q?mVR2A1d+4uwSGHLfs2ZYa5cSNr5pRyNck1oc1iWDHmK0WaJgapzk71wz/Tl5?=
 =?us-ascii?Q?IWk/NFUHsJZzkNEQ1YSvHgG+ryiMSwj4hjsPDGoHMolRNBOFAnsaoOzR9Lpa?=
 =?us-ascii?Q?QtyF2kd88Gi86e9lVA5BYJ6yfVKxAqfmTuj0+0C/Rhzq7bRhdIcHshtzZelk?=
 =?us-ascii?Q?iFYkhvmUYFcvuQrR7sy+XKMOlvJpcX5pC0gfb+1X4gqosjUfF561fM7w2t/+?=
 =?us-ascii?Q?MgTgI/3riKFfZgYnYe8qToyXfNP8JS9+8UJ9jI0UTvS1mu+h0sl6qkDjpGHo?=
 =?us-ascii?Q?ASpF3Pp9XXzy9lFAS/dFrvUTSeFduDAY9duqy8cfQBc1MwHluqTcLJPoCK9i?=
 =?us-ascii?Q?oUyvfIJEiXbaqh7n01qHxJ8myZNc3uvr0fepzdrR073cWxfz7lgnCPf3Z8Lg?=
 =?us-ascii?Q?GrVStQ5gA1mROUOyevERfc2a+FsitIoA5Jkj/72qw8FErt6gXodsghTQ6Ris?=
 =?us-ascii?Q?szM6QSrUPhkcl9Vfix7j1/uZTz4NjuCHyg0l4jtrAOxRR1mtBTP+kRffM9NB?=
 =?us-ascii?Q?3Hn41bEMMnswHOynZId5adMpIkEUpb8kHg34K7NS6ASn6I8iBHmR7pA2uIHU?=
 =?us-ascii?Q?rSELP/KyX7/IYk211oW6AohfzIlHahpE7rEqbwM160Uz5CLFuFHJWkdnNYIx?=
 =?us-ascii?Q?4Cz0xXFgppQa6ppxiLMaOwRmESJ3UMQC9Dr0n+jC4AM0sMg+/i6zhnxCKHnV?=
 =?us-ascii?Q?gXJbPwWSHNSBcKmLRq4Qe5/4hGiF3ZG38xb8A2qqEnEQeIuSg+tme7u74LNc?=
 =?us-ascii?Q?CjkLkVmmseXIkbm9bL+gz9gz7gVbE32WBKVTb3vHTaWkQaJxdV/8F+Lj2mLC?=
 =?us-ascii?Q?IjkysLw5sp0Qc4UY1JIkOirnNVQLwPYLlLWE652nqPha2yFcihyu+0f2RGkw?=
 =?us-ascii?Q?Er19Mk4x0lrydbdQ5a2Y7laJ/Rk2HmVq+AytjqzS9aVBWE/Jup+4mkgEmr+X?=
 =?us-ascii?Q?4UVgeuRmoZtYZg1ZwCMEUuCfqyh+2vNSRK1Mklcm9SD8fh9t/W2uytwa2+7J?=
 =?us-ascii?Q?SmB1jr+klrOvViKd4x2t1Byv2kgvP6umcj0L8JtzHYW7KF2rg8tdt1rO37Fm?=
 =?us-ascii?Q?GHVRicr8mDgL25QN9zF4SBS97ChN8ik4CG/ze84s9cZQjRdPcWKMLYDY67TQ?=
 =?us-ascii?Q?qa7/MFfVMJ+G7rKHveeZ4Siz5pmV0zrVdokBMAA3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?07W1IeevUT/ZX5Vp1otjng+tR0L0zXy750r5HcYvioCWMVlskKjOCAKIh8nP?=
 =?us-ascii?Q?DIo2BIEInyfiKh/Po/OQXSqDAmv8xdhGDwjDAoE+xzZcPNewJ8p1EAhO/ISY?=
 =?us-ascii?Q?mo0ZBgKUFk5EkACD3AvF+unSr7DixWQad0vtqrqUFyT8Jr1C8ylW1iKMjoNJ?=
 =?us-ascii?Q?Dn1Rxw/pAYs/47R57hUi0ee1p4yIAusKQY33xcLDf3XV94tyY06J2Jy8fuap?=
 =?us-ascii?Q?UDxp7/MQU8UsnSFkQSawsj3VE4XqJShYuhJ7tBtyu5ns4er3Uo2sVgRzitJl?=
 =?us-ascii?Q?CMIGTYuT2kY0zTsPov6s8HIhh+J+Vs+zgRvEwWyQc54kysUxtxdqH/H0GUv2?=
 =?us-ascii?Q?EPUbhndLzKIMS5h9E48yQByJqqWPHFjgu2tW0InuEUxMHydrVkvT6JU9yr0w?=
 =?us-ascii?Q?nXeiI/XjyhSgmxrn8ieXUBsEk3lrb4xWNc9upWx4PWa0pc5ROWMavpFyBoFo?=
 =?us-ascii?Q?acRvhVFtEFuNqUloPbrttcl3YRMmaAIRX02C3qgKVyVsDQ7eETPnqvfeUhz3?=
 =?us-ascii?Q?cUxzWs7WT8hbuyGcIhllSOd79wB6Q8bc6zwb9XjhZuwZD2oqQ/3CVCu+mtgG?=
 =?us-ascii?Q?sEDR0RkY3sCDmrlfGvzcd07XvoU0DpNlQlATFFQ5EdyQ8r2qlcL5s2620KNi?=
 =?us-ascii?Q?WWmLOTtpvFH9egzXe1NqvFzacb+zDetomiRgrvWo5VUpeRnUzlOaW6AOOZC3?=
 =?us-ascii?Q?SB7XKhSKPgld20yOlHuWqduZMeOexueBhLzVMbQ3r0MuCbhKaYFSgtSzTcNX?=
 =?us-ascii?Q?b6O0nwfIdj+OCHJDM1b/BoYZwKiY6qAocNIJCtz4riw5Ba3KigwXia8ZUIc+?=
 =?us-ascii?Q?oVi7wi9xz4AYK7rZffFC3vxFiduPRKHtOTdpjP0vgpCzYV5Gaa7PKMsNMj3F?=
 =?us-ascii?Q?vFdpq5t5xSZpF347R4vAzhkcA5cXoBx9v1FqITnp6NauV3TJWmzrNix0dAoc?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404b8050-b970-4d5b-8918-08db0a253692
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 22:38:34.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hrx6MuLo1d51l+5GgrdtJQiYkIKi3zSI14AWcEclysw3WkcOJudnB4OZvcA/j0AAKtjtHf7aJHgXG495rzEXDTLgqvGay9p0bWRQYnKMPac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4642
X-Proofpoint-GUID: Z-kKi9fFXVRmLeKV5bbWCp13jQlYsrgb
X-Proofpoint-ORIG-GUID: Z-kKi9fFXVRmLeKV5bbWCp13jQlYsrgb
X-Sony-Outbound-GUID: Z-kKi9fFXVRmLeKV5bbWCp13jQlYsrgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_143857_377785_98C31057 
X-CRM114-Status: GOOD (  17.12  )
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

> Are you observing DPC events during the error injection recovery? I didn'=
t see any in the previous logs.

Correct there was no DPC triggered with error recovery.
I initially run into issue with NVMe device not being able to recover when =
DPC event got triggered, and by trying to narrow down what happened I figur=
ed that same effect can be caused by injecting fatal aer error via aer-inje=
ct.

> If you have DPC enabled, it really doesn't make sense to aer_inject on an=
ything downstream capable ports. Those types of errors would be contained b=
y the DPC hardware; the kernel will get a DPC event instead of an AER.

Understand these two scenarios should be investigated separately. I will re=
move DPC from the picture then.
I disabled DPC on my setup and removed kernel option. I run same experiment=
 and I got same results, however by playing with connection to NVMe drive I=
 was able to reproduce same result on KIOXIA.

That lead me to the conclusion that this error may be dependent not on NVMe=
 drive but on connection.
To prove that I got Samsung PM9A3 in M2 factor (previously my experiments w=
ere done on U2 devices connected via SlimSAS or Oculink), interestingly M2 =
factor PM9A3 is able to recover from such scenario, proof below:

```
pcieport 0000:80:03.3: aer_inject: Injecting errors 00000000/00040000 into =
device 0000:84:00.0
pcieport 0000:80:03.3: AER: Uncorrected (Fatal) error received: 0000:84:00.=
0
nvme 0000:84:00.0: AER: PCIe Bus Error: severity=3DUncorrected (Fatal), typ=
e=3DInaccessible, (Unregistered Agent ID)
pcieport 0000:80:03.3: AER: broadcast error_detected message
nvme nvme0: frozen state error detected, reset controller
pcieport 0000:80:03.3: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 0
#d0_delay =3D 100ms
pcieport 0000:80:03.3: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 100=
8
pcieport 0000:80:03.3: AER: Root Port link has been reset (0)
pcieport 0000:80:03.3: AER: broadcast slot_reset message
nvme nvme0: restart after slot reset
nvme 0000:84:00.0: restoring config space at offset 0x30 (was 0x0, writing =
0xbc200000)
nvme 0000:84:00.0: restoring config space at offset 0x10 (was 0x4, writing =
0xbc210004)
nvme 0000:84:00.0: restoring config space at offset 0x4 (was 0x100000, writ=
ing 0x100406)
pcieport 0000:80:03.3: AER: broadcast resume message
nvme 0000:84:00.0: saving config space at offset 0x0 (reading 0xa80a144d)
nvme 0000:84:00.0: saving config space at offset 0x4 (reading 0x100406)
nvme 0000:84:00.0: saving config space at offset 0x8 (reading 0x1080200)
nvme 0000:84:00.0: saving config space at offset 0xc (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x10 (reading 0xbc210004)
nvme 0000:84:00.0: saving config space at offset 0x14 (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x18 (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x1c (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x20 (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x24 (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x28 (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x2c (reading 0xa812144d)
nvme 0000:84:00.0: saving config space at offset 0x30 (reading 0xbc200000)
nvme 0000:84:00.0: saving config space at offset 0x34 (reading 0x40)
nvme 0000:84:00.0: saving config space at offset 0x38 (reading 0x0)
nvme 0000:84:00.0: saving config space at offset 0x3c (reading 0x1ff)
nvme nvme0: Shutdown timeout set to 8 seconds
nvme nvme0: 64/0/0 default/read/poll queues
pcieport 0000:80:03.3: AER: device recovery successful
```

So my current conclusion is that this is very likely Hardware related issue=
 not Driver/Software.
I will dig deeper into it but for this particular thread I think there is n=
ot much more we can do.


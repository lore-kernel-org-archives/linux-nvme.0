Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762F1C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7DK/DV2XqxeYDoUP8vXneG4xIeFIyEQ0r1OyeesbCXQ=; b=XVCxggJ3p697SvrQehm1vNgbBW
	e0mNJv47w+AP9T9jiJcc7b12BMhTDgrfupEu0bFUuXbWaLOiE+EiCpphKfTitJZjYDlqnRIGcqbMN
	BJdcYP47duFTw8KzqXW1PTXsHRH8tEHEjyFITIh/SsPJ+ZAJhOwtUhhOm104LuYe2FSxSnBh3c9rP
	FNcLCgX0ibzthnj9Vy9Ij4WHpELhqZ956lHSxtwsSdNH8u6U+1Qr6kcOZC+ZwnVLZQmSFn+Dx/ODs
	GsdhKVjvqq3WE8s73kdH/+PTWKe/RWrFk5KYfeH7qmpPmYhSju7KQDwpP+7sbni+TmNN2Y/uToStv
	KDj6Zytg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZJI-00585H-Ei; Mon, 30 Jan 2023 18:55:20 +0000
Received: from mx08-001d1705.pphosted.com ([185.183.30.70])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZJF-00583P-Nr
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 18:55:19 +0000
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UIoNpe019830;
	Mon, 30 Jan 2023 18:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=7DK/DV2XqxeYDoUP8vXneG4xIeFIyEQ0r1OyeesbCXQ=;
 b=OtR5aVO7HL8FGONVylSqgSuKA9DDep/V4GLNSLveW5UW4mpAwcy3wyqa+9EJ3C39tWq+
 BEw4SoIzXblQoyA6e7kTSPZi14bLdDy7XdVv2ZgQomDdmU2pK2rUMVqeVAEqd2stsJvG
 kbnEIo86vPo8moxIddIIMQLf/f7tRJy/1QOwE7kdKME7QJ/rRvSe8d0UHSNZhaInaoME
 lk0HWUF3vvci6DLe/UuLquDCzTv8erBXME/ftvtgkDXfx51szEmrulShEopqXGJqLuK6
 MhwofHN/S4cszCW8/tHlDDBPhYDIwT/yBd9Drb3M4yGrQkaXnarKiHuW7cJ+wHifFLiQ Jg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ncvp420we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jan 2023 18:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSdVebl+uTnkEFmAjeiusJUAJddVh4PpaRLMdaXu+sTdHnX7IqxujJJCkt119/FCs38zjeMdtrEEpRYmnNzWr9F4U5xD4PDuHBOdwbbHp1IMot63tLxL6znjuDcxtpkUZk/kS0UUkjOeIdvUThppaS9t6JRztktaejEpARjEVY527Jw2HzxV6X97Fka7637FDBpdlD+3s8VYHzy5dhwrVeAi98K7KiF76VJDynJIX9S3/4ETVgr2y6v7sMB1XlZ05kdVtHYQc7lznGNw35OWYJXeXbmzkQBz0u0igtGuXyRdd2fGcIcF0XGm+NIIe+9/yCD92aADeAw1norcekGX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DK/DV2XqxeYDoUP8vXneG4xIeFIyEQ0r1OyeesbCXQ=;
 b=gl9yDczacukBylMZmy4V83CdfZNtlnoVVLbsGGr+HmGcfi8oaOwEf1YzOpx6UwyLemmMBQLGseWwalQ1C/Thtn35OEryzVqKc3M7v0B3idoTpumIFCAcFj+tey8iYdJE93OlZut9VLljdF6u6jcU6KRGWg1ygRFN7M6/cmY2KkBCuwugH+YK4VMDcjy4JH6/QWAW+K5RFJcIIytBgIvMmeFrYtsn/osihiZLhPj8HgQeS19LkyuznLbi072f5ajNsAjZjhMMESQS7XblKBJy0RlugzhoNHgyUCAMxG/cw0lXyCU8FjGPS4vCdoqaZCjLpTY5DcVQ8BPUlMzW2idbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by DM6PR13MB3770.namprd13.prod.outlook.com (2603:10b6:5:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 18:54:32 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 18:54:32 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index: AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAAIdYA==
Date: Mon, 30 Jan 2023 18:54:32 +0000
Message-ID:  <BYAPR13MB2486CB1DFDB8EFC5A2502DA981D39@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|DM6PR13MB3770:EE_
x-ms-office365-filtering-correlation-id: 115d086c-20d7-4ce4-f5a8-08db02f36cbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  akgJ5y3deiprQmdripkOHZNuta2sHKwRh3irQ/7GFLce5bmRvQoSfdM9C/5LKUmnsCF6K/f9RRovo86fLWyRfIkMKWGhWV8RHK73fmCS7Z7heEHKEQqikOw9jGw/GgPrnvQHz5sEGKElxvFBJLrXw+edEi4Y24KQZfyzTqMgz+kJi6OJGhekpO3LGj+QkJLr2pUCqNikktl0HsUHgiVOKGq53Pzi7kPZhWUmVEkReqFkuOfapKWHOLJK9SubqKDDZwStk6ISbRQIVB7w2tcwoPrObz7VPkZH/gOR4vNBC2BBaI3iLRB0tVgWpx1OpE/D+TD0UeIW3ppJ9phefo6Wu8zPd8cgcmlWM8kJhIeG4tVsli9toKoSLr/igxBIk9hi538h/5aMY+A+siCUYVdswik2gZbFXaShProwAh5BsW/uEDzhFZrPf7HIpNeldx7ataLr5ggA9gc7IPOcKKHB5RnUkQpz5bGUpYiDNyyzooSJDAmdotESre+S/9F0A58pa2V62TfJntVSF1TcNLFXXkpiSBLLMcb3R1e0+0EeevlNP2jNQSBHw40z2Kj5S2r9T6ED8eYQHAHU6oMzLjLrwaff/17Vjq16jmM93jyQljYYSrIcz6O4MRKq+um+NTchoSaKFZDn06pbJWJkFHasRpdqA/wOT2+gR6ZD2oFVo5KNDXDt1OAnbmvmf233wvxkb5TZe/YR+crV7US9ax9qVrzm7pJh/hlT5NYnuuSWGOk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(66946007)(66476007)(64756008)(66556008)(76116006)(4326008)(82960400001)(38100700002)(71200400001)(54906003)(52536014)(86362001)(110136005)(55016003)(38070700005)(5660300002)(33656002)(316002)(2906002)(83380400001)(122000001)(8936002)(41300700001)(9686003)(26005)(478600001)(8676002)(53546011)(186003)(6506007)(66446008)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?ChxoSlEPvqiWP3mKpfI2jN1vBlP+ViAUEwsKwj8zLEMTMocE8zvjueuf8+G0?=
 =?us-ascii?Q?01WzZUwVSIX/pfnz8fuMqa3MGrX020jlBLT1KCg6c1nxSaewizrrUYBYWhXS?=
 =?us-ascii?Q?a5n9013/DXpguF8GFrZVPO6j5Y0aPJjbsMnzSzRPLRcPi8VdOqtvsp3LR+QI?=
 =?us-ascii?Q?W1m2FcY4Sc29/sfV00xvIFg0sdDHyE4WuIVAcz7YDFVeZTH+tYFY6R5Puz4+?=
 =?us-ascii?Q?BNR/i5dC3fDrLzPfH1CKLHxPYwYZGiNgEzh3pJe/gJxM5nvZ/xb2DONlb8v7?=
 =?us-ascii?Q?O1xTMKlEn61aSDd9OZhWQidmxGH1KsOavxsVOGdNhSFIBi42RzcO+A1uLYWG?=
 =?us-ascii?Q?1Nh+KEHjm6tOkTTosVz//8vWu42yxfIctpqZopmhfFIePzHH5J9pdmK+grJu?=
 =?us-ascii?Q?vD6gFnWUEPrmbRpeu7um7Uw5sOLLwUCL2O/f0Q7h99Pla5UEwWb1doiiRUbL?=
 =?us-ascii?Q?6VaOL1LXD7vot2qdxOVgo+iggTcVAvckschH5heHT0Mu1q8tObZbFjk4hevo?=
 =?us-ascii?Q?fnhdsYQpNnwB3vTo95tjGmgbWz6zwegjaciPre7htgl80NimAVCC5vymTSfs?=
 =?us-ascii?Q?Qm1KA/yHy+TGrAIUqS+G8GhOrYmqdkxRUkj47gbfaaonB62DztXg59jkRdTc?=
 =?us-ascii?Q?LPlf2SJUAhTByOq1ZdBI/tY8d8sTI+RrcVn5hfGxRLiOR7qFqrkQN062lbIn?=
 =?us-ascii?Q?WWIBGX67PkFlMqgBthYxk/UWd/L3HIHR4h73k47ZYKMmV+dvORmPgIdy9ZsB?=
 =?us-ascii?Q?VUynI3jhOky8ZKD5X7d6TEav8SNYXAsN02TzJDLkGt4/OaOPVfFCUFwZi0zC?=
 =?us-ascii?Q?Ovb6okAXid809X2egEui3rDr+4uYBxaLDJ8wmv33zZg3sVnn7yTJApmWOMMA?=
 =?us-ascii?Q?aGzhJLPba427Od9VBs+QphDhVeT5kaFU90kqZpjXA7R7neaGL3votd8SXCfD?=
 =?us-ascii?Q?3T7AfoYoY/2CKzKdTH/t3z43NN8Z852macvjf2N9NA7f+3O8GOUbXISSnc/i?=
 =?us-ascii?Q?BTCoVI06ZnVb4sln0yDFYAOn0kkscsSo47zs/SjEUuJ7zkz/MT1HxGKzx9pJ?=
 =?us-ascii?Q?9zQr4poqxxzj/OfW/Z901atOdluZuJAW8qz4bbVTpZLXBmhA45Dvk+aCcvY4?=
 =?us-ascii?Q?F1lTjqlRQIa0IWCGijucMjfVcY3QnLDyW2w6IbOU+Dizeop6vWcWOY/ntBNT?=
 =?us-ascii?Q?5nV0BIOW0XQS0AAsMKvaznvI5jYQHyd/eOlJlFaNksr+Zh5FuxODpzPA945T?=
 =?us-ascii?Q?g5MrMrP9gBj9HBs75eM12EV921RxLCOeBvV5homiCtk+Z+oNPX3Smap3qSqE?=
 =?us-ascii?Q?HhP68gfCGnRUOrzvNUGM/j5qUYURcanXnzPrOmFVdivvQAV9K8EJlYPAVeMJ?=
 =?us-ascii?Q?RzATZIW7JFC0Ok528nrqv2hottcSmFs0B7/n28GOMI25pVWLXLsL1b1Zq0Z5?=
 =?us-ascii?Q?iVSRYbWtbVL/TeWLmeccsYLyrdw4r9yE27e3Jf/utxseReNpRFlN1o5qiUJM?=
 =?us-ascii?Q?FnXd2Cm4Ua/QpWVjIV4qfe1qzcAzWPhLt03kjOSCqdtNUmjC2MZJmRhYJTkl?=
 =?us-ascii?Q?60RDBbn6BXF7cLyRrlihSaOcK4naRL4ssPNuelS1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	Tg/bnlg30/SQt206VQsOtpZ810id/SvY0uFpe+UKpa6jpb3QcE702ZJDhX0q25SiNosG1sMdxVuQrITNiou+BgCSxcLVWdGWpkEe6U7M5jidcSRyp0rZr6zRT4Mae8WsnfIdRlqC+W/WXNFSCEeke25qvUkOgtFyj5JFWbO1aUDl5GLcYbtAwR3BPD3IE+6QeTjcShn02r/1Eb7GQybXgIK7jrD3RvaqbIFXrEOZFhyi26HtXY89sq69uDDal5M8n5zJ1cavino3IIzQa2wxtx46B1huEm1YYfLCPbOAD3uPIszbT8dem1+l+mTAIOc6F+a28j4NWtsyPmJeMP0UrXCRZYEeyKCkfNHeJjoSsbHuRSMcvKHw6QCZpnbh9zLSTFGTLdKQcjZamAx1jACjF8aise4dQ6E53lOcfGiDdPksDll8Lm6LfNWVN0QWSKLtGiibX1wuEA7sd4la533oudDIXEYqtXmCE5riqUf0lwvWj6apfWQw8+co6yAB0x8aclD+6jm78lGPoTj7vH80doD/tDBB+JngiFaHKLfrIGVDAvvTAwYAJqGTG/MCdqXtnnL5B2ImDkD4b+MuZXi1jbW9m3QWR7KOoczkA/AL06/HKcfOS0I+QMSZ2RuOaMzqG/MAeKtQ7gzOeDFn4lGYEMEWmMVBv59nyIppqPx7/VIx9Ag2DOY2D11u4V13vNBpZCmXpPgNmz8zQH9RUsU0vezGp0sMIEoPesXbZabfuFnZipfeLiJdS01FzMuqNb7HBS28wvwdCSZfYCY3CJ1C+UxUkJjjx12ezkxT/1o95idpZjzthalpA5FOiWuybHHEmi4FqzWg4itsF6EKYzwe2sr+lSFktF8BYrnfjv6VP4y6KynHi4hnbARz5E5us4Nc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115d086c-20d7-4ce4-f5a8-08db02f36cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 18:54:32.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DxOOzP5Dibe1rToq27TIVOG2cRmv937z4b2ohozh/9y98IrW53fdIF9ir5IUzaoCxIj74DulUsDo0dZtsgHmV62z6fvNNa8f+XYm7+i/WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3770
X-Proofpoint-GUID: FKP10n6PKuN3ar2TYA1vwe0cm2ljrEZZ
X-Proofpoint-ORIG-GUID: FKP10n6PKuN3ar2TYA1vwe0cm2ljrEZZ
X-Sony-Outbound-GUID: FKP10n6PKuN3ar2TYA1vwe0cm2ljrEZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_105518_112263_FD22DBCC 
X-CRM114-Status: GOOD (  23.44  )
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

The issue was spotted on 5.10 LTS, I checked the sources and indeed sources=
 are before 387c72cd commit.
Let me update that and retest.

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Monday, January 30, 2023 10:43 AM
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me; linux-nvme@lists.infradead.org; Grochowski, Maciej <M=
aciej.Grochowski@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery

On Mon, Jan 30, 2023 at 11:35:36AM -0700, Keith Busch wrote:
> On Mon, Jan 30, 2023 at 11:14:49AM +0100, Christoph Hellwig wrote:
> > All I/O on a nvme controllers hangs after injecting a malformed TLP=20
> > error using aer-inject with an error file like:
> >=20
> > --- snip ---
> > AER
> > PCI_ID WWWW:XX.YY.Z
> > UNCOR_STATUS COMP_TIME
> > HEADER_LOG 0 1 2 3
> > --- snip ---
> >=20
> > This is because in this case the ->resume method will be called=20
> > after
> > ->error_injected and not ->slot_reset, leaving the controller in=20
> > ->disabled
> > state and the queue frozen.  Fix this by doing a controller reset to=20
> > resume as well.
>=20
> Why isn't slot_reset being called after error_detected? Driver should=20
> be returning "RESULT_NEEDS_RESET", which should have the pcie error=20
> handling always invoke the slot_reset callback.

Are you using an older kernel that doesn't have

  https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g=
it/torvalds/linux.git/commit?id=3D387c72cdd7fb6bef650fb078d0f6ae9682abf631_=
_;!!JmoZiZGBv3RvKRSx!40iIn65MdrKZ0SfOKFPZh2uzo1KyAjcza3Tj7fDDip143yds9jH361=
GQ09RcoZbiYiX0ot8uZYS5-Q2cGWE6$=20

?


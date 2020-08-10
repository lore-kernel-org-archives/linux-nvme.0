Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D3C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:13:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E122078D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W48Mu6kS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="IDr8Dzt1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="d/ZP0pjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E122078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a0uEssPyl07qcO5pSX5ySktka3atZpZtF42HUKcQkz4=; b=W48Mu6kSFTlMPyaePAdX6isJa
	NKqIIGkix7XbwIhh2SJoNx4EZdfwdDTLy4XMWGBmMP40YLVDgYn5Aj0q9A1JunBUl8TTjMv5v6n6K
	/uBckTYvTtwf/8hddYDp/gNrHInJ97X4HBcnmRknrHqzHgy3Waxlx4EnWaSDOBRgaRcz3a4TYI0qF
	ixh8W4I8HPQjPewSUu7BdxDxiqzHgVRJNj0iWLqO6IiLEZPnu5QMkl3uydzAtWBhCQVg32dNpvrvZ
	iO2Lq+Q1OB/3p3El+54XfErAsykplcolmF1V3tJWQhECCf3rBye8hkAjJuX1ymWiTYMCFbAVIJQGH
	DVJfxHijQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k59UP-0003FG-Ha; Mon, 10 Aug 2020 15:13:29 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k59UL-0003EL-RY
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 15:13:26 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07AFCjqI020565; Mon, 10 Aug 2020 11:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Eir9v/h/3E8DknEW5m/Ht9YohzMcryoY3SJoMuilSwc=;
 b=IDr8Dzt1CfJZ1XTB+jjbKqlLbYgv9dZtcHTHUMWorWNX/swSHglNrRKG2BiVmB0YH8KH
 bVSKfVyjPvRNObbEaWWC/p18Mir8L1Adw6knxkPD9uWOpvGoAlGVElio3vuhECpnNLhp
 kAk0FIbEHeb5+wK8/5DQsQYFo1mjP6tytJgY3IAscE91dWqiwhkzelQSOX+GnhuiIc6u
 5C28W0na4gXo5LyuIbIs9U8vsfeaQiCriYp1VSFbXx9oULwDvCa+TTdhE1zbMrD5BO25
 QoShqLml2mFn6XnR8Rcjqgb+x1At1jsHR9MRoxxy9u7OWWQIdMhrGd1iKgGWygkkoZGZ CQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 32srqbw1xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2020 11:13:18 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07AF4e4Y043910; Mon, 10 Aug 2020 11:13:18 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by mx0b-00154901.pphosted.com with ESMTP id 32u8jgg4x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2020 11:13:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnDEOgOXJk3kauvBllhBrlzOqJo94eu0OEEnDEz5FEvT1ryinxpjK7qMvEeIU+v7gjEj8CMk3EXg9uYDHeWOcwpkGe+rBXC2ZTWRxApBXnPYy+t5Jv0kEMD+xgZBi2U5Xq3myPQR3lRbeSa30VdanuHPWxAzO+t9nNGyT6Z8Y6vGBMvTAspzDWInprjJveKIR43FqcIzosVMK/wapwRxmE5eANVQpefi3MIS+mvDtE7S4fE6H//4q+An+OFFiYBsfiiNFcgWFa8tUZUbc0L1YeUCEefCO6Or1oytXQZsvsKwaRN422SX/GNRU/O3QdP/yGKo4od0Dkoz5uhbaPC0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eir9v/h/3E8DknEW5m/Ht9YohzMcryoY3SJoMuilSwc=;
 b=HFl97yn9w7DZG1wKrRGOrzypECBNp9FBlsWm8aM6h2YxurbOyqs4Z9PzeZ3/USMc8OMJ7ppPxioLj1ON2XMJmYoN2wx6zQBI4aev0g/PAOMLRLE9UUm6p8xvjixDP46HMHhHyoOrqEJz0gSfESDN3ErDuHaCmyPoEkHC9/Qz9hX2q+kmJVaQeRuiPU7K7qC1f7SeGwkkbgxcWy5ytom/6jv41dDpJ6AXwqxRKRxx5BvlDSVCZHJYiVb+KE9fcKAfjIv/pr7xQJh/np4SNJkesXL87m4pgezSNrM3Ye7CpNhPjX5+bXa4A3F02/SWkpwJcCVKJnAiLvWJ2nSMydBbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eir9v/h/3E8DknEW5m/Ht9YohzMcryoY3SJoMuilSwc=;
 b=d/ZP0pjJ3l+kN5PHCynyOsbNLe0T7mgSpDTbw+E9QD3LH1kxPKFfk+r0Q83nMnZs3F/f36Jd8owcI+amx/4vj6g5a8a+mK6mgmyjKrvA1C9WkmYHZ9sZgvd+zIxLfJqwprPDcZTHYYqA56GMh/taJGkBDgXxlJJzQr4x32/8Bqk=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB2446.namprd19.prod.outlook.com (2603:10b6:208:ab::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 15:13:16 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 15:13:16 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: RE: nvme reservation commands during controller reset
Thread-Topic: nvme reservation commands during controller reset
Thread-Index: AdZq9/uNS/3GoWeGS1CKT5X8UElmUQDb5YwAACr4CgAABP8VYA==
Date: Mon, 10 Aug 2020 15:13:16 +0000
Message-ID: <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6> <20200810124036.GA25070@infradead.org>
In-Reply-To: <20200810124036.GA25070@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-10T15:13:11.0975097Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=c9156bdf-bb3e-4a04-a51f-7c9944013429;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e132c31f-7135-4e89-16cb-08d83d3fe880
x-ms-traffictypediagnostic: MN2PR19MB2446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB2446819D8DE67E825E8BB9ECEE440@MN2PR19MB2446.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+1mEsv5O1hGfctH1ol46g08qDsojsEgNWIBissvHZOEcPsQcEUqIYGiCZDJky3puctTY/oe0178i910Vt353laFEZB8vXV3NyO2PmZYTR1s4jVXvatkoGFSPzccTcRqTd7rGI7u/vjlAMfmyC5HE8CzosBmYI+5tsPVfS2HzjVyRq1vPI2Mj1hY09Qjo8gP4Ra54hVgFav75RJEOClcSfIW1KfhPMIXS1chF1WBx9X8SouioVfSeKkWutSYxy8uMQt9HTHlJX6DkEpb5pQEgunT4A1L5BlAQYnYOXTr9xQ0IwNk4/WdL3GHjGmRs0YU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(55016002)(54906003)(110136005)(83380400001)(7696005)(8676002)(9686003)(26005)(33656002)(6506007)(4326008)(86362001)(53546011)(786003)(316002)(66446008)(186003)(71200400001)(478600001)(66476007)(76116006)(66556008)(64756008)(2906002)(5660300002)(8936002)(52536014)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: k1Oy0poL4MflIAGwpkLc0PIHI/KrawGoNTfCZtysFYMVfZsXdb1TV9e+GFiy+hZG5yIBqm2mrNGczYLoEN4zLhMWsgSCwL7ngZZ7VwmAQnEfWLiNSWTuAaHfcret0Lheao3cJPweJSFyCLF3pEbzJtHnlypGA5OFX0wph40GRRrO0DXGCiSpYB3nsYzQWsaQ0EIfXa0WReUhMnUCopQNohr+yu0XlseqLzm/fZVRMMUck/AMEjsr1wGMCCZf/LHfkpHs+l1GXuMoIfPg+qJ+SowihWh8/bufIh5dy2Stuveof8/7Dwqe6ZFg+tVQYh13t2dUaw8hkURbCfSZye9nB7EeuXBFayjTOI/aeOEeUafzisU3tirIVEiIIiDY88k5QCmMJJ3rmi/9pa3vhH1EYjcN6LnmHbx71wDsmnCGfE3yYwTDgA/iDljNJlcYzfnt9T9IJ8FC4BdIdKsIwkce3HzrQFxoRBnF9l7uUh+qQolfVVuwOgwi4Y+YYOq4vM8BJ1ZhrCmfwvC6Dc0IOsSwnNbLKXGZm6AHBZ/2TUqeU7TBu20MnVkGlSuVYGmmW7Bm4+lic9+2m5LeA0QkPPIsTLBan2Zkdzr+9wzIYvL2F7PPOO3EXsJJlzXVB9wsHVZIqEd0LTrPuoA+aDLSe/mOJg==
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e132c31f-7135-4e89-16cb-08d83d3fe880
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 15:13:16.4018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+3+uW9otN42CxvcoevFDCa9z3HfydyJDMaH+SF6icByw4JI6l5x91PdKERULCp9eJw16hvn3sZ9XYJY7+3Rtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2446
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-10_11:2020-08-06,
 2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 impostorscore=0
 mlxlogscore=877 priorityscore=1501 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100113
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=991
 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_111326_036386_E16AD391 
X-CRM114-Status: GOOD (  20.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We saw that in case of path error, nvme reservation cmds does not get error handling.
This is true via the blk layer as well as nvme-cli.

We are working on implementing nvmeof stack and 
this current behavior is blocking our host from running nvme reservation cmds during path error.

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Monday, August 10, 2020 3:41 PM
To: Keith Busch
Cc: Engel, Amit; Anner, Ran; linux-nvme@lists.infradead.org
Subject: Re: nvme reservation commands during controller reset


[EXTERNAL EMAIL] 

On Sun, Aug 09, 2020 at 10:10:16AM -0600, Keith Busch wrote:
> On Wed, Aug 05, 2020 at 07:14:22AM +0000, Engel, Amit wrote:
> > What is the reason for setting REQ_FAILFAST_DRIVER flag in nvme_alloc_request ?
> > The original intention was to mark only sync cmds as failfast ?
> 
> Special requests don't get generic error handling. The caller gets to 
> decide how to handle it.

Although I wonder if we want to allow to opt in into the normal retries, as for some cases that might actually make sense.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

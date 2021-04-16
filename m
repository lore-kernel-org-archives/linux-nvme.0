Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58640C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 00:41:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D60261132
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 00:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D60261132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KPlYsJvqmzerGnyqFfs4ljD7rqE0AFmBrMYXj8dQX8E=; b=FeFD501Wh2yn88DVW84CH9nZ9
	uZRYD2ywDUAjWkZsvANcqA4VcdxZiduI2qBORM5J0aeFtP2/HHk8IGyFYA6Io0cfyt+uO3LENKwaK
	TZsdddTaIOt2I3S6UbKeuar2mNglw/R8XoxVu4MdC5Rml79L1PWdQZhRLqb1p4hWcMfNwhgNVVhqL
	dBS6Mta03zYThLRuby3B3+zWu+IU2/cldkCJfHYCBBc3g+DFscxPKRQtcCICSQDXDng5P7ZRkjjcx
	vNZxnXfLqi+kFjhDfmZP/7m5KDe3vz0iVj8wB5/IA+o/6zDitgI+zU+vFTfsBVwVTQ5VHD7E/GWq1
	XXMlDBARg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXCXz-000GLv-IK; Fri, 16 Apr 2021 00:41:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXCXw-000GLN-Am
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 00:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=laFgG1E4Jl7XGIW1NjOgVNQ+PRm1rQT8JWzFBzDh+qc=; b=IGpmGJKTRBaiTHJ8aNY7eR6TZZ
 3l7AuGlYPDA2cQuzEoxY2PBujzkrSrClRwgazeSZh5W4fEtzniYa/ovLKXgdgPMqhMRmuu3VNzpIo
 K90MyoAQLhmyOWrzZkYqdtx4jWV5c4yAwLctEz1U+EUJdxB8rGbPcUx04deFtPQJnt6cLgtFGanNC
 Rh3Ig8Kvc3iTDd508/C+CE2jbvzL5Xk9gTn7saImyPcDQiBc1Yvf8cqQLWPxIMesiUNBrbFp5AbP/
 cvloPyUguCJk84KmKtxxf7l9iH8cNg+PgKQFs8UBOGMX8l3yyXGj94X/i7E10vYxM75x7rUewV1H0
 Z1HQog9A==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXCXs-0090NB-PG
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 00:41:18 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13G0bNuk024395; Thu, 15 Apr 2021 20:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=laFgG1E4Jl7XGIW1NjOgVNQ+PRm1rQT8JWzFBzDh+qc=;
 b=GRyRCJ1HLPsOnRBVK76s0pZ+1g/KmFozIX6pVaha2DU6zEtJ7cSbfUi2eM6j7fTFSFAz
 X7PUXV3mUuxq7q9RJ9omhlG3N59HKLPg6hOGWodzVvoLa1otTPwNB2VrTnHR+U38Z1yV
 yt6CXde3y0WfU/yDr2CXTBqXJYgh5Q1tDgs1E+AI4/UEwEUODBlBch+Eq6vwOzkYd9C7
 DoL9k0l1unk7Boyj50D3Cjln6k11NHiit7pCZWOlZ7/qMkEwZtJRrq7kAVFc7RY099V/
 HRH04aQN5vY4V03fqZbUYGKwZHb0U0zhGW+uwJJOXWW9+vZPQhQPcCyegPPA6UMXmIb4 Xw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37x9jqmmj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Apr 2021 20:41:05 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13FJQAvN158260; Thu, 15 Apr 2021 20:41:04 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-00154901.pphosted.com with ESMTP id 37wwu3rck2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Apr 2021 20:41:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1mPID51Bwb3OlKOOWmXr2L0g8y2sq6BzAowNTSk705UHQ/VoxW8HDZsGUjeKMcarnenxGXt9xdnq06bVnzEf8Fsy5FayBniG1+6ODIHcc3SLl81MUagdqRT2m7Ek6FyYh7iYfUVH2F4bmjGUAX83hu2zMn5M50OfyUIac9yDLlaOrpJM4q9+PCuQ5vPT5k4rW4kHU83wa4KOc27w1gc8W36EsgIWQtvazDseOnpBM1OU6F9nRtKq0NsOyrG8dAI1mHovY2PckU6ucY8qmJdW+fLXqnR+mU6Y5auHqLZNNdlm7LKB2NPuTJJQZDqsp/NoSV1qMcByogw/wpXZrGqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laFgG1E4Jl7XGIW1NjOgVNQ+PRm1rQT8JWzFBzDh+qc=;
 b=ARRSwhEazr4EBfg1e7f+yLur4R1hHMIx4ev+Bu7EdflPSLwki8SKQL9nNg/ILG6len+rAsW12L2ZgrvmXKAJp7kHNH/Lj+I2ytIq/SVPEYC4pHjoVfUhGJykBCljmSKYXunvPSplbXXX3G3nbml4jdMCGk7GUToa7zqCM2zskI9xD9XBH0Q7ge1e+aPVvPIEDE0QDdqbsJlcIxlU6aVSHtmLO0HC6TfhbznSxEdJvgJ0Y+MA5rliInBNgTgl0rNq3UClAxBtAd5iPVt4SZarwcM7M1novW5Zsxo2ONh+rQ1wvsRwW0WqAa0XiqbxvwLsaoEQY00DcguDDo52X9qQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3159.namprd19.prod.outlook.com (2603:10b6:a03:181::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 00:41:01 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 00:41:01 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: James Smart <jsmart2021@gmail.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Thread-Topic: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Thread-Index: AQHXMi3cXRd0eX/PLU64uVU3qFLVL6q2M0EAgAAaVrw=
Date: Fri, 16 Apr 2021 00:41:00 +0000
Message-ID: <SJ0PR19MB4544D7B102BC3A957B57A780F24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>,
 <f693d139-2a3d-a780-9e15-9ab130cdab3f@gmail.com>
In-Reply-To: <f693d139-2a3d-a780-9e15-9ab130cdab3f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-04-16T00:41:00.408Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a96fb14d-cad3-42fd-ecc0-08d900704ef0
x-ms-traffictypediagnostic: BY5PR19MB3159:
x-microsoft-antispam-prvs: <BY5PR19MB31594418E98C8550574A64BDF24C9@BY5PR19MB3159.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trHLNFlBohgU4C5MHTjKIXqObjkWlNMDcBuesTmPK8HPs7PU2fb4CPijXD3Cteez/Im+iG6QuNiz9XtW7EYqCwiB6AulFpwD5o+1B+dXaE6ntlfspIAfdjkKeBYdw4z1ENfUl9lc3UCUxUb742YhZfG5bHMQgnTza4tj94MA5+FuOlDIufSDXUxRzP7uznZBaCOAnzFcZdM7rDCDsg8cJ9QR8GfHEd2xSP8jIjL3j11c4+MMdA72B6QCGPv++7kat+BDsTNWR/YQAOoYausJuwbHsXtF19A4Iwrbswe1J63DBUTneYzshtjDQyyVvAOXM8K86pDQZ9nPxh2FYXmZvrposdPnjjiGtgBjcR6Q00TRAosZuE0UN3GqmHXY2cOYFqv7c9OE56WOgY8YShNtZ1ml7iIQtu4kCFvfswHqE4A7yGZanO78lxpNNM64kCOhSxusoZJUX482jksoTKZmN7CEoRtEXJwytTzi7Qqo9ZKLyt//GRqEODLSFzuhZiR/4NFn46G0iih2DQgTmMeJdypFxKkj2k90ZAzQj7Hn079fcfjj/Iqy350hDvili9UYJvwB/82FFPpex+YJd9Rv+AFUViMo2UpgmUhzHl58d8/s1Bz9j1Jt4hRd1lK2+kK0gXi2K9zDN+vdT46eI/h/X1v1MBK4McRAtNhDU8nhnly2+ibR+F8faCqc0WDrc62d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(71200400001)(33656002)(54906003)(316002)(26005)(38100700002)(2906002)(4326008)(9686003)(83380400001)(786003)(186003)(122000001)(55016002)(52536014)(66476007)(6506007)(66946007)(64756008)(66446008)(66556008)(110136005)(8676002)(478600001)(966005)(86362001)(5660300002)(8936002)(7696005)(91956017)(76116006)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PTU3VHZu3LFHNUVpOQW1CyhgpPq6c/C67n7Pr0ehULTmEk3jN7co6zuL6v+h?=
 =?us-ascii?Q?QzlTHvVCPNMuZPdZ9gC801ujyNF2ntjsLaHpMMEYLRSqeFhfzixkDcDUXzR6?=
 =?us-ascii?Q?8dix1coe+Yr48Fl3Qk9ayuBFXUrP3Fiva10fEF89k2R6E7X+10E4pqMkjXdE?=
 =?us-ascii?Q?cuDlO+lkrwajsQy4EFufpNy8Moevtn2FeT8XYb1i6ibycdx9F5NPp1c1Rzvz?=
 =?us-ascii?Q?MSKfFtwLMe/M+rulpqiW0kk+s+DUDlxnb/+6Q25FdQui7j4H0AX8u+6XZETy?=
 =?us-ascii?Q?p0wmtf1jrljwKstReK2uzijRxULolg6RBg2ZgtogpIO2g0V6LtTSDbErRneD?=
 =?us-ascii?Q?26YtDpc7YOvxy8aupxyDo6tyLIB0lg7a92fhQbMSQjD6PIsqeccGriSDUCmh?=
 =?us-ascii?Q?KzXlA67QuBo6F6GJfwyoJrF3v3Sci0k+yTq2lO0PpOznA6qKzsYPZqM/ByQz?=
 =?us-ascii?Q?jXuIERq6Vl7cJ15zVSBnd6scZHyRGsLCG4oqW6Ezl+NlS/rtfkX0NSPzhwol?=
 =?us-ascii?Q?okbQXU17ENgFJQDQwrMG724cQnPfDpYBg5F5ZR2xPSP0OsfnQXOKljyHxs9x?=
 =?us-ascii?Q?UdE7XUINzADpIocVdBhiUCefjHFDBr7bjZHcCAFSqA1Qmq5OTVlGEvhAOv1b?=
 =?us-ascii?Q?u0FtdNmeLPhWck3HZyXPM9u9xIZfzzC6McfLOKPfVoLFPvMQv7yMMySBOAwz?=
 =?us-ascii?Q?WHDwpwLMIl43YLDh1BQLgtZpOz56PFTOzwsYkm6t7Sd45mxdDIQ1YRPzOQtl?=
 =?us-ascii?Q?6k97flgDeUPmb/MMcQDfAHA7UvyvYqlmDD9a3hOJe+ecC7K7DGFNITPlaIie?=
 =?us-ascii?Q?ViE1Bnjl/FJkwLcsXzQfk1u2IhvvMsK12WrIgyuODJSHvwTt+TshrI/bnpLH?=
 =?us-ascii?Q?IrRBiTgjh8xstueGr6NCaWqH99es8JcmXGlowCC+H8xM+p6ySC8az+Kh/Nqx?=
 =?us-ascii?Q?6hTNsmuaTIA6PQ82h4Jwysg+EJthohCyYIb1Rr+EyUScnSV41OiXOSMlApMu?=
 =?us-ascii?Q?qZXFE73d4oVKNQnaxHMI/1iN5Y7ew5cM0LgIjWkgWVyA4XBEYhDqtEUROer3?=
 =?us-ascii?Q?qp6Axgk9uBbkWLQZfyo5eC7tfzP8HdOje5DG/ud+Xo7hEPKKwOy9YHDenGNn?=
 =?us-ascii?Q?UnrFUOKayJD/biCwSuuYQpv01vFYdw0nsUSAvd4DAt6MBBJZ+gQ8MeYRNjmY?=
 =?us-ascii?Q?xrLgrkJLKliElRrqxBTpKpFTBIUwneqzN40TsZhEekL1C9fqa77HrA7Bx+8Z?=
 =?us-ascii?Q?8igf4+W6CQeqn95DVcztcBeUxZKYHZUOJoU2R9YvFFG/smJFWCtubnQYKJ/T?=
 =?us-ascii?Q?FJJ4vrf8SJ3c8MgDdeLbl9iJ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96fb14d-cad3-42fd-ecc0-08d900704ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 00:41:00.9339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5zXcn3wp+MfcO3jwAX8f44ZGX9CTDhJk1uJxLATf1ujfuP63YUv5vIRqOqkEhVzoTNGHH0cGCkhTZZGTlJZ6OXY0vSgsHuwo76WGf1yZKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-11_01:2021-04-09,
 2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150114
X-Proofpoint-ORIG-GUID: Ps00y0BwQUYSxKeTn-85ZiixvYrUK4Ni
X-Proofpoint-GUID: Ps00y0BwQUYSxKeTn-85ZiixvYrUK4Ni
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_174117_014057_C98D21C7 
X-CRM114-Status: GOOD (  26.70  )
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

Re-sending in Plain Text mode.

Hi James,

With HOST_TRADDR, we use bind() to bind to an address just before invoking connect(). I also used to think that this was the way to force packets to be routed onto the interface matching the address used in the bind(). But that is not the case (I tested it). bind() does not control the routing of transmitted packets. The only thing that bind() does is to set the source address on the socket so that when a remote process queries the peer address (getpeername), it will see that address as the source address.

It's only a setsockopt() with SO_BINDTODEVICE that can force packets to go out on a specific interface (I tested that as well).

References:
https://codingrelic.geekhold.com/2009/10/code-snippet-sobindtodevice.html
https://www.javaer101.com/en/article/1866348.html
https://wiki.treck.com/Appendix_C:_Strong_End_System_Model_/_Weak_End_System_Model

Regards,
Martin

________________________________________
From: James Smart <jsmart2021@gmail.com>
Sent: Thursday, April 15, 2021 19:05
To: Martin Belanger; linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; Belanger, Martin
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)


[EXTERNAL EMAIL]

On 4/15/2021 12:28 PM, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
> In our application, we need a way to force TCP connections to go out a
> specific interface instead of letting Linux select the interface based
> on the routing tables. This patch adds the option 'host-triface' to allow
> specifying the interface to use. Note that corresponding changes to the
> nvme-cli utility will follow.
>
> Martin Belanger (1):
>    Add 'Transport Interface' (triface) option. This can be used to
>      specify the IP interface to use for the connection. The driver uses
>      that to set SO_BINDTODEVICE on the socket before connecting.
>
>   drivers/nvme/host/core.c    |  5 +++++
>   drivers/nvme/host/fabrics.c | 14 +++++++++++++
>   drivers/nvme/host/fabrics.h |  6 +++++-
>   drivers/nvme/host/tcp.c     | 41 ++++++++++++++++++++++++++++++++++---
>   4 files changed, 62 insertions(+), 4 deletions(-)
>

This wasn't able to be done via HOST_TRADDR ?

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

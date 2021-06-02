Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F55C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 12:43:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B09613B8
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 12:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B09613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bp0VpXF8FVssC92q6jdKfxAliVvLngX2kJbIGmUxhhs=; b=lhH9tJaFHwN+HX
	+O98pnuLJvt1Y2GnmCkYpFHfP76Zl11cb3riRcgGCGLj0/TIwt9TA62+Bi7olcXzdwt3QYyabk1C8
	c5XtNGF0Es1qmCnr4AwjWB/BcSFvzGzX/d3rPTbDo6mIcyE/KOHzIh1hW3FeM2soXQv+4S+3JoXOK
	js7RcuwBO6oH5Cjw2cIsoLz+c01r0Lw5zAlWrGkL0zIwXpTqk6TEMkXy0ByHEsc0tCUUsgkvnj3EU
	a1j0LKFf+QyvwcwpHr3paJR4FFeCQPQTNEcIEAGzFICBwCCZvTAuUGJqrM0kyXgGTvrGtZvqRXimR
	CU88TV7bL0FB9rS/ur1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loQDX-0049D1-TO; Wed, 02 Jun 2021 12:43:28 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loPzY-00446e-3W
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 12:29:01 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 152CQZ3N024485; Wed, 2 Jun 2021 08:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=gzlcxkcLhWM7ccVz9REuOMY5oFqW6Z+za/CoWsgT2I8=;
 b=TE7ED/ApS6U/0R6ZnKtruZcLmmotmntT/9POige9GlckJI263SNFMSL6fAJ2EDhs3MU8
 OfDXYA2gkeJndKyxgLgGQSiFEzHl8coTJn/0YrhC1nuEf64Qgy8zwqBZKKY73gsDpr7S
 Fsj3Cs1WwSQ3fvXSIwgLtyFYtBFsEt6dj+BQoQPFWwBzLyrAVW0hqoTC4mz6JmNS38vA
 tHjuj/x4Ixwdn3mxhRtMYSQ0A7UJ/eEzGKJ+WKF8zmJSJVeihWCJWmxwGB2Cs+y8elyK
 0SZCN4jsn5o/9nS0YQZwRCfTzrOSC9sA8bRLO3TNrYJws7pGV6UHUHPf9UIGAu74hc9j qw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 38x7ph8fem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jun 2021 08:28:51 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 152CC1ij018824; Wed, 2 Jun 2021 08:28:50 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by mx0b-00154901.pphosted.com with ESMTP id 38x90b8xmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jun 2021 08:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF814b1uD2kRasbTqIz9CrvhITPbGM/rTG1nWoFTNi98t4AjHp+a0mn24wfd9B7KJ3DdP5hU/XeCa6/xnIawHSFH4Na9z5nc7GLTebw6biwZllZtnH32g62FhJJTFndg2dvzyXYekQzgZ6/Rs+eco7Nb6u6i5znjvpcxmkA62ZuunEHbGdnBo91w+3qp9aYbBbE3E94V8wbGauX2LxnclkTHiHRmutMVKlUZPiXXwl2aGrdmm0Thh+YDx3nR0JlgfYrKpiNM77wTSOgM1zZo5ukvNn4BYSm7HK2jUaXy9/YqNv3oYKyzpem6mYFKK9CN7x7ykQ+ujrwF/WjIismGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzlcxkcLhWM7ccVz9REuOMY5oFqW6Z+za/CoWsgT2I8=;
 b=iUglPsmQxpsNW7jVaO+hFnmVb8wgz5T5NItY5DIxfwkMOI/7VE3OF12qQtPPEe0ZZ2jt2R4irAz6rfUHLI7/lSdqWccK88Cx1nVyjSs72sNTj/IxlN6Q/oN9C1OXgE+cD0jKcg28VFZfINnTu7d1bwHNsvRW17RrjXElyvnt8bwn242jhAfnbPes//ruYCjN2Ii1mUrcJYJDEIC02a0DqUurcOKemg7OZoXlaPd4ZuAwvcBeny9NRYP8kwia7aUGELgG4NmTx9TV8hgfwnpD46WcYs0YrWlb3/ldrgecDyDLsIs/16YIjTWc4ktGXf0FUn9gIHgJFHWP+i6J2Kovhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW3PR19MB4171.namprd19.prod.outlook.com (2603:10b6:303:45::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 12:28:46 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a5a4:b285:7ff:2a37]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a5a4:b285:7ff:2a37%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 12:28:46 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDgAm6yOg
Date: Wed, 2 Jun 2021 12:28:46 +0000
Message-ID: <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-01T17:50:56.2685299Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8ccf8f97-10e7-42a0-9918-ab5a3aed1ed3;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [188.120.129.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fa13c1d-27ef-4b1f-2014-08d925c1f7c0
x-ms-traffictypediagnostic: MW3PR19MB4171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR19MB41719CC6A1FACED04C32B9B6EE3D9@MW3PR19MB4171.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Dn0pQnXaLbWI299eHL3c71fCUaN/8hZ/mCfHHc99SGgo4xdgc6HerjSkbcTwPNXiNCIhlRxsSet6Cu/iE9cp316whA/XtEiX5vTyPQRF84WZgnRjx1BnIWzC2LZUkw4NFPy9AEa33KVW70ij42Xaqzb6nKkFdQNx1uq85nZBoQWX+LZ7k8lYielM/WPKw2gkUON/L2xXS8zXEFcbWAYGVPouTAng+SOZs13P9uMx8HUAIUaL/JXrsYA8xYiPiNlDvwg/P1VDRGQo0NpcNc1BUAiMAdvOH63JrJ3X5OsTTWhQBgNdSTBjFGxeJZ/ynU0JhUT/piIGikxu8zxKTq+EOddCYyi8SezrTPgrD51iA/o7wu8gN0m8Gwx2GE5E1HZijEFyNB41KuUjXW0hOwzL6vKzHkr7nIEShZDtKhBocdj264EhcAzD0gUWUIyn5gaDHxs5K8J2vIfnis8kL0BTuvqMfpA5N/H+yO3g8aE+3n+0awGs0FrOoi8TWJ2PPrWPiPdqRjFYaenoVOMyrp7lJfw/bTxx5WaVpDmNr6EmGjqnphY7Q46ITmw7freGY8NpgD1BfHFpqLJtrPjUCy2q8XfcKJZaJOtr1vKT3urQlY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(2906002)(107886003)(9686003)(26005)(186003)(76116006)(53546011)(6506007)(5660300002)(52536014)(66556008)(66476007)(122000001)(66446008)(64756008)(66946007)(38100700002)(786003)(316002)(4326008)(110136005)(54906003)(71200400001)(86362001)(55016002)(7696005)(8676002)(478600001)(83380400001)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?VUZiTWd4MFNVQUFyS1dhMnRTYjZoZEQySWg3ZGtZdHhJMkpqRlhhbGIx?=
 =?iso-2022-jp?B?ZTJDcEsramxvTUhNYkI1NjBndUV4YVlSVlM1STZpR1BBK0VBQ3l6ZEtN?=
 =?iso-2022-jp?B?OFluT0ZMNlNXRHl2U0JoVXVXZWtKU3NoZXVGZWhxNDlBU1VEc0tickcz?=
 =?iso-2022-jp?B?dEpJL2VHcGF5YmZwQ3ZCYno3N1pEMHAxdUpmdTJRWjQzdFc2cW1OVm4v?=
 =?iso-2022-jp?B?UzJKdmdSRXVjOXNVN2xLT2F3ZEhDNnlDcFIzWGxMRk9semczbzIyU0I5?=
 =?iso-2022-jp?B?SllhcHZEa2lRMjZFVDgySVVMOTUxUWhienFZREpYTjhDZnR0SDRlQXpX?=
 =?iso-2022-jp?B?WXZKV2x5VmhhOWFyZXBIbDV0OGoxL08xN2tXZDgvOVJZTVlrdXJtMTM3?=
 =?iso-2022-jp?B?SG9mSkdkSk9WZ1piVHhCV2h3QjlXaVdwUWE0TWhWWFhiTVFFRCtPa1ho?=
 =?iso-2022-jp?B?ZXNoOHNhNXNqamVpaXVpSExtd0xCdC93NDQyZ0RyTklFUEQzZno0NHJS?=
 =?iso-2022-jp?B?c2h1OVBlRUR2ZWxaeXYzcTVLZG1xS2g4TnY4K3VYWmsrUGRwOVZTMXBN?=
 =?iso-2022-jp?B?NUFQSlM0cmlWMDIwc3M1ZlBOS3NDVWIvd3NUUmVXTG82KzRCa0dJUFMv?=
 =?iso-2022-jp?B?TkVWdWt2K1JBNld0RTRHaXhGTmtydHhyMFpVSXRmRTRvTlh5aGo5Yjcx?=
 =?iso-2022-jp?B?YW8xdHRiY2dUbkI1UWtjSUtqa0w2bEdpeTQ5TDc0VEtNcU1oN2dpR2pr?=
 =?iso-2022-jp?B?d2ZZRzFMdEx1emg5NFhWWDBGaE0rZlk2Sm9OTjI5dTg0NWVRYTl0RUs1?=
 =?iso-2022-jp?B?QmhKNlVYMWkrbkJFbG9zd2tycldDcnpMRGtEOVBRRzFUNGtnNlN6QmdY?=
 =?iso-2022-jp?B?U1ZwNWFWRGFQRzhPT3Z6R0twcGFPaHUrUHpsT0FIanpvSXhGUC9wSVNK?=
 =?iso-2022-jp?B?b3JRQkFjUEpDV3UzTmFMeFpGRXlrSWxBMkZVdUNkaFZLaVhHcGh3cSt0?=
 =?iso-2022-jp?B?STJBbHFpb0d5SWdkMjM4cHo1THlvV1BvNVNiQU1JenRUY2pKQ1NVZDBW?=
 =?iso-2022-jp?B?bEpNMTRoVDZvdFJ0SEF6QTBobmsyS3VITGU1L2pYb0I1REJiMmdueVRr?=
 =?iso-2022-jp?B?QWFQYktDMUV3TzVEMVN5TkVjN2JRbzZhT0Q5RFVmUUUzeFU4Z2dZQjFv?=
 =?iso-2022-jp?B?RlAxZGxmYUU5alpaTzNFTXBIRzJnNDRpTEp1RC9iZVp4Zy82allTc0Uz?=
 =?iso-2022-jp?B?T29OOEticWRSUU5yOFV0T0x2QjR2TFRRUms4V1UwMG5sK2JvNjFOS1ZH?=
 =?iso-2022-jp?B?NTNCdzVBZEtOL2RKMEJ1RDBaNnFYdXJxKzErNWFMTkczcVEwdVBkdVNG?=
 =?iso-2022-jp?B?SFlRenNaMTY1SWxJVnlFQk5ra2hlVHY0dGpwdmNGa3dQUDE1TlFhemFX?=
 =?iso-2022-jp?B?Ukw0S0t6Ty9HQ0hMQWV5c1pqU1hQT2tJc3pFcG13QjFRVWYzb0MrWjYz?=
 =?iso-2022-jp?B?NTFmZCsrSER4RHFqOUlIMWtCV3hlaHdrd0lRMDM5eGRoU1VSbDNDeVBF?=
 =?iso-2022-jp?B?Y0JzOWdsN0Jzc1YzSHN2bFpxVW9TY1hiTzQrRlUzb01UV1pnZFRSSG50?=
 =?iso-2022-jp?B?YTkzdnhONVQyQlFubHd6N0NIUURGYUZDMm9SWkpQalh6TDY2NHRhQ3VD?=
 =?iso-2022-jp?B?NE9SWERQSEJ3ZVNLRkp5Znk4LzBwcXNJR1hYaWpjUlY4VjArcVliRk5l?=
 =?iso-2022-jp?B?WWZnekFhMXRXdnZGVjkxS2NlMkppMVFmaHp3Vy9zR0cybWZNS3Z4UGRm?=
 =?iso-2022-jp?B?VGJPT1FvZHl3Y1FEblgzQTc4QkZyaGRMb3VMajkwS1VTNmYvaG4vTlBy?=
 =?iso-2022-jp?B?dlhJaENjYWZMR1hNdzYwaFllOCt4bkdpZFJjVmdrc2pjekNBb2lOUDRy?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa13c1d-27ef-4b1f-2014-08d925c1f7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 12:28:46.3472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geypnhtwW3N8oSWXsiAtKJIbm5B/NP5SQTCM9V76xmuq82Pp9LzGATs3qP9Cf5GszCeIQT6yLQCfJI0DTxlgQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4171
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-02_07:2021-06-02,
 2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020079
X-Proofpoint-ORIG-GUID: NQoHns56lCUB0yFDOlEig3inw5iGSoCh
X-Proofpoint-GUID: NQoHns56lCUB0yFDOlEig3inw5iGSoCh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106020080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_052900_244334_7A639276 
X-CRM114-Status: GOOD (  16.82  )
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

A correction to the below analysis:
It seems like sock->sk is NULL and not queue->sock

As part of _nvme_tcp_stop_queue
kernel_sock_shutdown and nvme_tcp_restore_sock_calls are being called:
kernel_sock_shutdown leads to nvme_tcp_state_change which will trigger err_work (nvme_tcp_error_recovery_work)

As part of nvme_tcp_error_recovery_work, nvme_tcp_free_queue is being called which releases the socket (sock_release)

In our case, based on the below bt:
nvme_tcp_error_recovery_work is being triggered (and so sock_release) before nvme_tcp_restore_sock_calls , which end up with NULL dereference pointer at 'rwlock_t sk_callback_lock' ?

Can you please review and provide your inputs for this potential race ?

Thanks
Amit Engel

-----Original Message-----
From: Engel, Amit 
Sent: Tuesday, June 1, 2021 8:52 PM
To: linux-nvme@lists.infradead.org; sagi@grimberg.me
Cc: Engel, Amit
Subject: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at 0000000000000230

Hello,

We hit the below kernel panic “BUG: unable to handle kernel NULL pointer dereference at 0000000000000230”
when running with RHEL8.3 host. This happens after we reboot the target side application (when multiple ctrls/connections exist) Based on vmcore analysis it seems that when nvme_tcp_restore_sock_calls is called (from __nvme_tcp_stop_queue)
queue->sock is NULL

Are you familiar with such an issue ?

crash> bt
PID: 193053  TASK: ffff9491bdad17c0  CPU: 7   COMMAND: "kworker/u193:9"
 #0 [ffffb2e9cfdbbb70] machine_kexec at ffffffffb245bf3e
 #1 [ffffb2e9cfdbbbc8] __crash_kexec at ffffffffb256072d
 #2 [ffffb2e9cfdbbc90] crash_kexec at ffffffffb256160d
 #3 [ffffb2e9cfdbbca8] oops_end at ffffffffb2422d4d
 #4 [ffffb2e9cfdbbcc8] no_context at ffffffffb246ba9e
 #5 [ffffb2e9cfdbbd20] do_page_fault at ffffffffb246c5c2
 #6 [ffffb2e9cfdbbd50] page_fault at ffffffffb2e0122e
    [exception RIP: _raw_write_lock_bh+23]
    RIP: ffffffffb2cd6cc7  RSP: ffffb2e9cfdbbe00  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff94b2aefb4000  RCX: 0000000000000003
    RDX: 00000000000000ff  RSI: 00000000fffffe01  RDI: 0000000000000230
    RBP: ffff94923f793f40   R8: ffff9492ff1ea7f8   R9: 0000000000000000
    R10: 0000000000000000  R11: ffff9492ff1e8c64  R12: ffff94b2b7210338
    R13: 0000000000000000  R14: ffff94b27f7a4100  R15: ffff94b2b72110a0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffb2e9cfdbbe00] __nvme_tcp_stop_queue at ffffffffc02dc0aa [nvme_tcp]
 #8 [ffffb2e9cfdbbe18] nvme_tcp_start_queue at ffffffffc02dcd18 [nvme_tcp]
 #9 [ffffb2e9cfdbbe38] nvme_tcp_setup_ctrl at ffffffffc02df258 [nvme_tcp]
#10 [ffffb2e9cfdbbe80] nvme_tcp_reconnect_ctrl_work at ffffffffc02df4bf [nvme_tcp]
#11 [ffffb2e9cfdbbe98] process_one_work at ffffffffb24d3477
#12 [ffffb2e9cfdbbed8] worker_thread at ffffffffb24d3b40
#13 [ffffb2e9cfdbbf10] kthread at ffffffffb24d9502
#14 [ffffb2e9cfdbbf50] ret_from_fork at ffffffffb2e00255


crash> bt -l
PID: 193053  TASK: ffff9491bdad17c0  CPU: 7   COMMAND: "kworker/u193:9"
 #0 [ffffb2e9cfdbbb70] machine_kexec at ffffffffb245bf3e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/kernel/machine_kexec_64.c: 389
 #1 [ffffb2e9cfdbbbc8] __crash_kexec at ffffffffb256072d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/kernel/kexec_core.c: 956
 #2 [ffffb2e9cfdbbc90] crash_kexec at ffffffffb256160d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./include/linux/compiler.h: 219
 #3 [ffffb2e9cfdbbca8] oops_end at ffffffffb2422d4d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/kernel/dumpstack.c: 334
 #4 [ffffb2e9cfdbbcc8] no_context at ffffffffb246ba9e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/mm/fault.c: 773
 #5 [ffffb2e9cfdbbd20] do_page_fault at ffffffffb246c5c2
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/jump_label.h: 38
 #6 [ffffb2e9cfdbbd50] page_fault at ffffffffb2e0122e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/entry/entry_64.S: 1183
    [exception RIP: _raw_write_lock_bh+23]
    RIP: ffffffffb2cd6cc7  RSP: ffffb2e9cfdbbe00  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff94b2aefb4000  RCX: 0000000000000003
    RDX: 00000000000000ff  RSI: 00000000fffffe01  RDI: 0000000000000230
    RBP: ffff94923f793f40   R8: ffff9492ff1ea7f8   R9: 0000000000000000
    R10: 0000000000000000  R11: ffff9492ff1e8c64  R12: ffff94b2b7210338
    R13: 0000000000000000  R14: ffff94b27f7a4100  R15: ffff94b2b72110a0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/atomic.h: 194
 #7 [ffffb2e9cfdbbe00] __nvme_tcp_stop_queue at ffffffffc02dc0aa [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1486
 #8 [ffffb2e9cfdbbe18] nvme_tcp_start_queue at ffffffffc02dcd18 [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1525
 #9 [ffffb2e9cfdbbe38] nvme_tcp_setup_ctrl at ffffffffc02df258 [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1814
#10 [ffffb2e9cfdbbe80] nvme_tcp_reconnect_ctrl_work at ffffffffc02df4bf [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1962
#11 [ffffb2e9cfdbbe98] process_one_work at ffffffffb24d3477
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/jump_label.h: 38
#12 [ffffb2e9cfdbbed8] worker_thread at ffffffffb24d3b40
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./include/linux/compiler.h: 193
#13 [ffffb2e9cfdbbf10] kthread at ffffffffb24d9502
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/kernel/kthread.c: 280
#14 [ffffb2e9cfdbbf50] ret_from_fork at ffffffffb2e00255
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/entry/entry_64.S: 360

nvme/host/tcp.c
..snip
1481 static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
1482 {
1483 >-------struct socket *sock = queue->sock;
1484
1485 >-------write_lock_bh(&sock->sk->sk_callback_lock);
1486 >-------sock->sk->sk_user_data  = NULL;
1487 >-------sock->sk->sk_data_ready = queue->data_ready;
1488 >-------sock->sk->sk_state_change = queue->state_change;
1489 >-------sock->sk->sk_write_space  = queue->write_space;
1490 >-------write_unlock_bh(&sock->sk->sk_callback_lock);
1491 }
..snip


NULL pointer dereference at 0x230 → 560 decimal
crash> struct sock -o
struct sock {
   [0] struct sock_common __sk_common;
   …
   ...
   …
   [560] rwlock_t sk_callback_lock;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

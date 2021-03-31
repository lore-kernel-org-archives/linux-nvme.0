Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA5C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 13:28:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2889460238
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2889460238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HkaB3D9AVUbQxxOfQxzqa3w0CMocXtk/P2EvJjqY9JY=; b=AFMf1yGcCNInjGpwmnWay/mRL
	DY7LknyN2L0xi5qVJSLn37+BN7MR0gli9jmxX+9DdBOhNh+22VPcbEtxvNBeARojPWt7yvIEgwRGv
	zl6JKg05UYI7RBMtqi/VX0OmSem0vfTMaE0sbguRh7Uz9R4wDw+OEtG7H/zK52w3huUTT82OD5T6c
	PwFHMajUvrEtnzu7IE/A/V8xiC0PePO8/Nln8/1PALULRpg2MA/HrenUMXvWdOt3pja3pM6Ec9dTa
	ZDbjlJzW4CEDXg1SVd2dk7huyDg6Dfwpdr9LKkGqp00ZlA0gOe4odfjhKyEHtAMrl1FA+T+2QE9PQ
	rnwHs4fuw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRatJ-006fHQ-UO; Wed, 31 Mar 2021 13:28:14 +0000
Received: from [148.163.137.20] (helo=mx0b-00154904.pphosted.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRat2-006fFv-Nb
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 13:28:09 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12VDQSP3008449; Wed, 31 Mar 2021 09:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Llfn4v0KTi6ZrRTMpC+V/3SajkNt1BJ1zIkQ12daBtQ=;
 b=qhqCp6COJxlOXlQbnu9jDNb06v8lb29SmsjJwi23KQEWP1hp32HRui47VRF9sFx3W1a2
 zua73aqni2zL7FjoDgY6q1rv2eKok3lPBthP/7/NfEFltHEYXaTd7u7m4oVEwhSe8zdN
 7xH0drknFl0ww1XG91ip5Ab702/4sfC8R9pq0I2MgLLAleVpatfePr7pOZOh7bMtqAWe
 Fa5Cy4kIIlACKSeWuPDiSHBR3bsiDFtUuBp8nehR3valPM/sazoYPigw+b+OxrVE1reO
 ApT2Mw1iM+DryEY0eFndQVw5NbrY/eXqKUHITkZHXVjy3oMGswBqdzphoJI2h310ZLLE mQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37mamh2y0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Mar 2021 09:27:42 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12VDPf4O177421; Wed, 31 Mar 2021 09:27:42 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
 by mx0b-00154901.pphosted.com with ESMTP id 37macpucs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 09:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LztydnVtjQhYPUAL7lOZ54wQT51Wl+Eau5EepTfFXSWrLcGsDM8zekiz/Eoh6t0RgxnWrVSZA8vQIvGsN29Th1sqaJiBZ29BuUe4f9BkvXdrkLwHLqpjorpGeSL8DrIDjILtQil1Y2rFdQo6f+avIyFBPkQ9GxlRMQUuDXS8vAIjU9mvwKC313bJM7797QL/AnM6Ufdxs4F7ntl4PRZSIh/62G7tNLUpQxC6IEmGIOoMI7F+pG33CmgqQSNWbBS3qYozf451HFbYXvin15lbr3lI0XnwO0MF0amsP1h2RKtVkYw+tPI84u7M/QVanV76K/NOo8qUrpU8G74yvzH9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llfn4v0KTi6ZrRTMpC+V/3SajkNt1BJ1zIkQ12daBtQ=;
 b=QZg8qOTM8d4um8039e83UfrEvdt10NH4ZHdQm1qLxkIskG491jqY5WLZ7Ofl5LN+zx99Z7v3fdru+nVTxG+mB5a4QiCSQVvOOUSIKL9EDETCkBUACK3O2+fHQaSXb5lQVWhYFe750DghuH1l5wZlyLNwCYqIRDfWdqsIoLDTUs1U1E153PNHDRgd+6V8zqXw4VpjuPsc3Fh/0oUiYZA4i+B8bwzo4c2NZOb1AW2E78PXZlR6Ot5bZnYPdPE98S/kYAjZ4HBvJzI2tfhMmS/2CE4FvzoZGb8JqdcbZ1Iax8aLqOFIzxRF0LAuEoDD8MG6RNQ6qQ/4BNdIx3V4GUhmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB1355.namprd19.prod.outlook.com (2603:10b6:3:14c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 13:27:40 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 13:27:40 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXJg4ljd9fP2lGgEaubk2tJqCUwqqeEXFQ
Date: Wed, 31 Mar 2021 13:27:40 +0000
Message-ID: <DM6PR19MB40112E2D348A3FF80009BDBDEF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
In-Reply-To: <20210331091314.48925-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-31T13:27:37.1117917Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d603f8c5-a66d-4b32-9af3-d11097756712;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1109d2af-ab3b-4e4b-0786-08d8f448c22c
x-ms-traffictypediagnostic: DM5PR19MB1355:
x-microsoft-antispam-prvs: <DM5PR19MB1355DC0974937B5E7B9B8424EF7C9@DM5PR19MB1355.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/p2b6MnUfAMpdBkzgzcY2Q1pFFXtb7L2aqOdyxEoBNp/Dt+pQ7mv7Zdoc3ylPU2yoDQeoAAzAdmrmCMcyDaB9RhTgFQKqNKmr9HXOOMe6DmJV07p40ICQBpdO4jl/sX0srYnDSMOKT2svO96hqUF0TXpkyZ4t8T/9RqtBNkl/xW2HFXeSUcj8eElXDjb53aNGJHS+CfeWHVavy6NSng+J9JqaJDDKeK3ripURhDCaSvBk9XKfCwCXvfk6eB2rUd4Z3AL42i8UvbMwAim2TD0ShpXI+enMvoSNiMIdYLTGcKK8kCB/gCtsLcn/i3aF/YJ0LTnUHQo+mUeWZYEnYqiNoUK2zPgDfccTC1IvATh5w0/7Qgbq4fPbZKlRPE337599bTovU+hl3mA4aplb7kH/SmkjyT/Rwg/LOsKPX963M3DLmXdZBHiph4e/htKJZez6M38fgmebnoDBctoDhl///iALV50eUgF6FkZLQBuPTbeMfTTcFc6Q7T/7kdVXIMT153Ldek9LXJHkBz/pBFrQwVS2O3urjHzhAK637CMrIma5IlRmMOa67kbhd96ZTXZ+5Ou3mtfbC6H6JGoCx/JNrxGP0dTKbAjvJZhxJKc1ukonTgRIvcoWBJ5vX31WXkhC7w1IC3CZBKkh50L2kE0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(8936002)(6506007)(54906003)(76116006)(9686003)(66946007)(6916009)(7696005)(55016002)(33656002)(66476007)(64756008)(66556008)(66446008)(53546011)(4326008)(71200400001)(786003)(316002)(83380400001)(478600001)(86362001)(5660300002)(52536014)(26005)(186003)(8676002)(38100700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cFExWEg4NGtSSEZ3QTFBcWlZaVIvNUcxTmZxbmFBVUxUb1lpN1Axd3pVYlUw?=
 =?utf-8?B?UmlqQnMzYmh6RktFS0dNdC9NeTh1NlZ0VTJvQVViY3NNaU1ZdXI3a1ZDbXVs?=
 =?utf-8?B?dEdsTHdKM1BEV2FUS2FjNXBUbUlSS2hyYzltSnRheEVnYWlxa2VTK3BJeUE5?=
 =?utf-8?B?ZWd0bkxrVjA2TTdjbzhweWYzd1loZDAxRGdlWmNuUmRFQm5TclBZbzlLNFJV?=
 =?utf-8?B?dzE2MHU5Ui9Sb1dKaTB4NTJ1OUJZakpwWnNxYVVZaDU1cUx4S0dmcnd1VW5G?=
 =?utf-8?B?SUpvNnlHakw0VjZnanJ3MkVNcVVQMXFXYTF5S3E3VzgwUXFSUmgzRlc0V1p4?=
 =?utf-8?B?ZVYyakZ0WVNyQ3dmcDF2SVRnNU1wNG8wS2RiRzM4MVJVU1o2RUduTU43dW9y?=
 =?utf-8?B?TGFPSUk3QjdHUC9GY1B3M2IxRDNDdlJqUnlWYWpFNTZqT1FoY3JZQXZaUHBC?=
 =?utf-8?B?NUZlc0ZJRnJpQUtWNHVsSkp5SVNIWUtJNGVadEJsRmt2WWp4T3pRLyt6SnhT?=
 =?utf-8?B?QVJoQTcxa1JiYm9SNGpUb1ZCZGwwZUlyVzNhTjUxREdiczQrbER2SWpZbWJt?=
 =?utf-8?B?OWcyVVZ0endtOFdkOGpaclVIdE5KNnFzQW1QM1hRRFRIbGJ6aTFuRUZzRTVh?=
 =?utf-8?B?aDNyV2Q0NmxuSFV6MEkzOWxQSnRFRXVSb2VZQ3NDczRMcFkyVW5zNjNaQjd3?=
 =?utf-8?B?eFNiV0JFOGdtc3lYeU12eS8wczhLTVF0OS90OXcrVmZzVWs0MUp5bVNISjY2?=
 =?utf-8?B?cnN1cnBpc1BreFVmMldBV3VMaGNnRWRCQmN6eWdxcWRoT3FUNXN4TnBzazZm?=
 =?utf-8?B?K1kxQjVuYmtvdmVVczN0dW5xeUhMdkVXSHpiR2ozUFNnZCtKb3V6THBqYVVv?=
 =?utf-8?B?bWZwQmFBWTBPOGk3VWg0ZXdIaGdHSTZNODRocVdmVHQ5ZTRBVTU5UThGeDdP?=
 =?utf-8?B?WWpJSlQ5dXBHbFJ3Wk82RmhEaXk5Z21PbzJjanFCOWF4RDVZNERrUytCbFpm?=
 =?utf-8?B?a2lLMWxDaFM0cnNoSFhpT2I0YXgyYWxhNmErcmlyT3BJaDNURHI4RTBDeDFT?=
 =?utf-8?B?YXFGbmNVQW9sbzV1MVFaeTNZdlZJS0t3WDl1ZHhoQkp6V0VBeSt1OUhsRzJv?=
 =?utf-8?B?RlVZTGFyRzZvOU1VNENmeTFRRVFFM1czODhOTWxTRmw2MWNVdzh2bXRvUHZQ?=
 =?utf-8?B?N0dZWXNESTNQaGxxVkg3SlN0K0I5dlIxODlPTDZTS1dLNTZxdW5pYlp3UmNF?=
 =?utf-8?B?eTF6MG1wWmtXZDV3T0poVFU4cEsvOG5EVXZjc0RHdHFQL0NVTXdLQnVVWFJI?=
 =?utf-8?B?SmNRa3lsVkNyaXVHRmN4TjZHUEJoakg1ZFBnQXcrQitRRHJ6aW9wakxFRDRS?=
 =?utf-8?B?SGFwdnFVMGRTM21OWEFRY1Fyak9GMXY0Nk9qUCt2d01XTHRxSWt5eDZCeUIv?=
 =?utf-8?B?RXdTSmJxU0p1ZFZ2OFd6Qll6MHpiQncrQ284WWJnZlBoQi9yY25XL21tWXhU?=
 =?utf-8?B?Znd5QXhVMnlLaWJyQTRkOGZjb28wTEhFT01XZ3ZFSVl6UlRteW0yd0hlaHlr?=
 =?utf-8?B?c1JScmV5eG5QM2ZlODd5RldFaUtDQ005NHQvZkd2ellNVjdiMllPbVJJVHFD?=
 =?utf-8?B?SFg3djk5bXhSdko2Zlc1VUgrUEhuL3NLbjZsZFQ1eUJIL0tUT0o5UGliaGVr?=
 =?utf-8?B?YzZBdzZ4aEM1TzhTcEl0R1hrWFMzdkt1V0szRXpkalpxVitHazNRSmdKdk1z?=
 =?utf-8?Q?92VJ5jncEAERX9U7q5U4cffe0wkYnl4myDJjaK4?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1109d2af-ab3b-4e4b-0786-08d8f448c22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 13:27:40.4337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJmtUWrL3sEebixpDjXHpdodvna8Wk+bIgYEME24bRJCkd+6prtGn2o8jz4pSOGfE5ZnXoNsyMP6MJA62KqT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1355
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-31_03:2021-03-31,
 2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310098
X-Proofpoint-GUID: 2xVBmvPtnOnISaDhIndcRIKZfva8e8J7
X-Proofpoint-ORIG-GUID: 2xVBmvPtnOnISaDhIndcRIKZfva8e8J7
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_142807_595585_D55D0EB8 
X-CRM114-Status: GOOD (  23.69  )
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

Looks good to me.

Thanks,
Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Wednesday, 31 March 2021 12:13
To: houpu.main@gmail.com; Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

From: Elad Grupi <elad.grupi@dell.com>

In case there is an io that contains inline data and it goes to parsing error flow, command response will free command and iov before clearing the data on the socket buffer.
This will delay the command response until receive flow is completed.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Elad Grupi <elad.grupi@dell.com>
Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/tcp.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index d658c6e8263a..0759eef3f4da 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -525,11 +525,36 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	struct nvme_sgl_desc *sgl;
+	u32 len;
+
+	if (unlikely(cmd == queue->cmd)) {
+		sgl = &cmd->req.cmd->common.dptr.sgl;
+		len = le32_to_cpu(sgl->length);
+
+		/*
+		 * Wait for inline data before processing the response.
+		 * Avoid using helpers, this might happen before
+		 * nvmet_req_init is completed.
+		 */
+		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		    len && len < cmd->req.port->inline_data_size &&
+		    nvme_is_write(cmd->req.cmd))
+			return;
+	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);  }
 
+static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd) {
+	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_tcp_queue_response(&cmd->req);
+	else
+		cmd->req.execute(&cmd->req);
+}
+
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)  {
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue); @@ -961,7 +986,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(req->cmd->common.dptr.sgl.length));
 
 		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-		return -EAGAIN;
+		return 0;
 	}
 
 	ret = nvmet_tcp_map_data(queue->cmd);
@@ -1104,10 +1129,8 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		return 0;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len) {
-		cmd->req.execute(&cmd->req);
-	}
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
 
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
@@ -1144,9 +1167,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
+
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
--
2.28.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

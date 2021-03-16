Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17341C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:25:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929FC650DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929FC650DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dekFXWQxclfVyTuknAX7HQNwzD/IFOLyVwXB7Dv3gRA=; b=oUZb4ZoobySRnGiuzAxEL6CL6
	yq0zUXytJmA0tuCMvH/Cum1NnAjzXwQZu/lVPOS4PT9lFtRYxmUVvuAdse+VlfgR/uGspdUJxF2gI
	lWsiLGK+CUsv7k/v9H5M29u0dHViBNLVqS29PjK6taaByOf+a0HXH+YCQIzRdXRI8SAfMmyDcvNq8
	/jVG1bmG48YGz/y5JkkQlKqOHZ+tRykioZS6BCzjHo7g8IKNp0cSHFSnUezSszDaXrqLHe6iVue11
	4EoSKxIfdII8hnZ4QFvzmGupRCCCEI1OL8ccHqFZ6YVsiB9AGfH5YO1aayKjBoRX08dybOpN9UFfH
	tKf2eR6ww==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMBZ3-0013ey-Nf; Tue, 16 Mar 2021 15:24:57 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMBYy-0013e3-Nt
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:24:55 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFI8m8018213; Tue, 16 Mar 2021 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=hO2sMv4cIaXHrEVoOtFyZHbbYCUAIfzKr8QG/t3vJAs=;
 b=aq/gW8Fo/jdFDa25PyXmo713DF+BaZz4bwEhlRdWIadD7CGOdNBEgOkPfVkv13F5aBXd
 DH/mhKh5GveBTHA8POq2cOkHfQ3Vi6QjdNeNPYVzY5MNzDLw+i6/DdDNuuYN5kWG8vYv
 2/x55s6sNUbXrGr8MiDZ7jd3hYwzDCViADYLHbFW3KJQMBDzEjJM38sAajDwBiVMmCS+
 9jbidjEucpX4BfMZNYAWN1rKTY3YD/ywUGXLs5tP/QQux2Dndm/3onKwRI8na+ZQ9UzB
 PfmeAOE5JNV4sqFeXiGRunP509uBfoS5bJlyQcDVm7APyPjTaEgffo9oDT251gK+HieK hg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 378ru996rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 11:24:44 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFFw0g184770; Tue, 16 Mar 2021 11:24:43 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
 by mx0a-00154901.pphosted.com with ESMTP id 379ba23f44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Mar 2021 11:24:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsmYf2lL7CWjUTQb0jyZpH+YrKxTz9C17EB0Kp8tns0JVZCoq0n8h0kgC8xey4t2JPSRAOh/V+WJm9Gf4kN7d9pMIPT20wm+gY1v6dA9YxBvuxutUMNjjvtdpricavFQn03+pvplZqXC6wJ66SxVoN88euk5OKbbOc5hKTXWJoTakAd1F1D1uiucrf7SU9LRAhp7uejPX/sfU0dc/3vEB/FtLynYYITe75TMGqGr2BwN1NBHm1CwXfDnilA9jkQG+zm0Em6BRqyC4/dkQn7n1sE+gO+cRJZrxVxSIJpr5CmMt+Ivex/1BocjJnnoK29BqwRkV2R1vv3pMj1pe8JKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO2sMv4cIaXHrEVoOtFyZHbbYCUAIfzKr8QG/t3vJAs=;
 b=O9Dg93mcldJiPgY0FOQlCpcuiNsk8Zjv7vsMBy+r7dvm6586yLKvtfrPTHcd5A4+lPLU7mouYhZ4YCFYvT/sAHdTqlS1Srpao3vO+AQoToLhjIj4pchkX6XAtSFCmdvr95w/Qeu/SRtPUG/r07xx42DwHtwcDruTf6HLaOJAtoHQ9jAwUn0umqq+7U7plyemQ8raBdM9c+BEMGg/uPrq848TjW5zJXPvuB+3TbYwXdu+gbAsB6/gdREA4q2WxQIzY+/a5Gbfp5jzWpNCyVMqLHsfe7kYEtA9Ga4XCVJLHaTTtJ/FaCs6+cLgYO7Cnt1HHaw27MjWnn9MRVWsJ6QVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB1643.namprd19.prod.outlook.com (2603:10b6:3:143::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 15:24:41 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%8]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 15:24:41 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: RE: [PATCH] nvmet-tcp: Fix receive data digest calculation for
 multiple h2cdata PDUs
Thread-Topic: [PATCH] nvmet-tcp: Fix receive data digest calculation for
 multiple h2cdata PDUs
Thread-Index: AQHW+oCxe/2V259TvUG9tx023am4J6pjG21ggCNLEACAAJVjkA==
Date: Tue, 16 Mar 2021 15:24:40 +0000
Message-ID: <DM6PR19MB4011D41013081DD8919D05C9EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210203230001.18797-1-sagi@grimberg.me>
 <DM6PR19MB40112D4524285D2D496F2186EF829@DM6PR19MB4011.namprd19.prod.outlook.com>
 <d15f0cd8-e780-80bb-ad65-a9963ca09100@grimberg.me>
In-Reply-To: <d15f0cd8-e780-80bb-ad65-a9963ca09100@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-16T15:24:39.0432845Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a9bd72da-b909-45a1-9a90-a8c9ce424dd1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [87.70.20.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ba57bc-2f5c-44f8-ebfc-08d8e88f9e95
x-ms-traffictypediagnostic: DM5PR19MB1643:
x-microsoft-antispam-prvs: <DM5PR19MB1643340E9E973E64A35458C1EF6B9@DM5PR19MB1643.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMX2dZ/DegWuVDhL7cLFk2/GYP+Iikt+r/PJJ7KadKMVqx0gA5QOb/T1LhdhP/i7TPJdZX43uewQtba78UTOsfOW0lTbS3UJZzoyaiVAIt40qTMQPZ1/ExbXkT979mxVDhFDh9y5wspkMOBYBUmaSzzMmhPzwiB4Sj9c0e/x9uDNdy48dC9dAIL+FCQGKAVL1vxszjRxfFdLGGdKr8h8nnIgO3GlBjAGN56OqV+tdJadIwm2Hq2OrLKs9H0ExjXZlxUAoRWGBHAyAYW44qh9ji3F12m7mlDwkFEKseF0j4EukIBeZpbC28knhlFu8XnKf0YIo8z9uaB4AW7QjGXS71U82cQjUsQRWYYbI5zqUbXrDYfOPINv9jjMBOa8fx86jqtYrHgMdbiJVHEQOYsEDz6+wHJkZ6FgZH+DK/ryYSBjZx8qmdH8Bg2Podv6JpjTAzdha9lcbze2Bw3/2XO+oWM3eli2f3hVsZpq3/SZqIAezA5ebCPqxOwWbPvA1lIIpfm9NWOkMDvq+ldplxzRlej38/RL6ZAK92/MycD5c+RkirUC2+21T15Q/II0noUh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(66946007)(76116006)(26005)(66446008)(66556008)(64756008)(66476007)(7696005)(52536014)(5660300002)(8676002)(478600001)(186003)(2906002)(83380400001)(6506007)(53546011)(71200400001)(55016002)(8936002)(9686003)(4744005)(33656002)(786003)(86362001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?b2lva1JWM2VIV1FZSUlzbUwxUkwxeXh3ejB2MUdwSTVXbUpZenFOTnZ0THUw?=
 =?utf-8?B?QTRaMTJmYWxkOEZ0V2dIQXZHTWNNb0x5TExPQzZwK2VweldobG5IR1gzTVQv?=
 =?utf-8?B?UGUrUzZwUHAvL3pUYjN1WVp4bTA4R2lIOXNSeW1lc2tpaStpczRUU3phdHhE?=
 =?utf-8?B?VWRGZ0hzckVhakJSZ0RLNWlwUDdkN0toejQzYXhJbTZoUUppb0VYejFFdkhY?=
 =?utf-8?B?NEsrRDA3Q2I4U0RQVEF5eGhmYmkrNGJQOUxSTjhwQTkxaTRzRHlXSWpsUWZi?=
 =?utf-8?B?cGt5QkFlSUx6Si9EQTNUWmtyOHFvb1AraTE0dHBrem9TWG5oUU5BUjRpaFhB?=
 =?utf-8?B?ZTZOK0lXNXRqMVlNazRkMU5leDg2Sk15cjV3NGtpRWFTK2IzSk01ekg1U3pq?=
 =?utf-8?B?V3lnT0tLdmdQbzFPU21aVGxPZUNQcFdaVGFLRmZtUGRSYjcrUEl1QkJVei92?=
 =?utf-8?B?aFFkclllYmFFbXpBVis0UTQ0NDVWZ29jN3VHUVFpNkpFcTdMbVVGM3dsVVFr?=
 =?utf-8?B?bE5CVnM1Y2U5cmFTUHhqb3NETWlXblRxVW9nQ3RnbDQ4SmpxOFJ4dkl6MExQ?=
 =?utf-8?B?Q2JhMzVpUFdHRDhnTldPeHc5TmZxSGlXYjFmejBaU29kNEN2aDNpc1JidHIz?=
 =?utf-8?B?bUdXOXB3VnRQN1pzbkhhVUIxZFg1dG94NUNiU1hXWVRNcDRnWmJlaENhR0NJ?=
 =?utf-8?B?allxOU55RlpsRFhkQlRjQmtyUVlpaUgyQVVMSU5hSzFZL2FPakxEYXZWd3dE?=
 =?utf-8?B?VGl2MC95cE94UHcxeVV4OHdmczU0SURKandsYk9Gd2FodHcwV2tBZ3krSEJx?=
 =?utf-8?B?YzNVRXhlQURSL1h6Yld2ZXlvd3NqYWhCeHdMRVBIdGorUG1rNHZEdVhpUW4w?=
 =?utf-8?B?RCtPRTlWOWVXRndBQWhwcHRkcVBzZjd5Z3VVVEIrKzhXOUZseGg4Q3FsZWEr?=
 =?utf-8?B?Zk96WlNHcWJXVlRlc0I1MUpuMmFDOHRCVk95a1AwQkpwNTZBM2FIcVBGdjFs?=
 =?utf-8?B?S0IzV0ZlcEQxUVFZVTA0TVRITk1Xb0hkNkw5NEpFN0ZvZnNxVklnUU1obm9j?=
 =?utf-8?B?ZG9LUEh0bUdKcExLMklWbldhR09YSGMyMjd3KzlOWXJSa0swOTRvRklaaHVz?=
 =?utf-8?B?MzNUU3lReWdyMXBnTXh5d2hnT3JsN0pGb0xpZzZvb0lhVUVZSWxQamttY2Vv?=
 =?utf-8?B?QTdkRXRGVlg4UzhlcTBqTXRZazRobVdCMC9hb0RQQkJ1L0JWYjlRS0h5MkNW?=
 =?utf-8?B?VzNCRU12WkNYcUNrK2ZUYnVyOFBIa3ZoVDl3dDhoK0JhR3IwMnBod2pqSExG?=
 =?utf-8?B?eE9Tb1YycStXU0FPTjV6N3hOS3pJR2J3a0pSNkRCOG1aclpZcVhWUGlkK1Va?=
 =?utf-8?B?MjNDa09VWTlzbVV5ODRONEtQcm5qWkx0VVl5V3JQTGVOblBwMldhQ3BsNy9q?=
 =?utf-8?B?bTF2cWQ0Zy9leWtwSUZVcG1SOEVEQ1lUa0dvMUJwZmNNbU1Cc1cvUGRXNW1a?=
 =?utf-8?B?Y09OK3lBTGpoRnpyMk9yOU11MEZ3YXcraFFlbmgwTGN3VUxCYWhELytpOCtR?=
 =?utf-8?B?cURXdE9uQjVaL3F0STA4ODFUTnEzMCtTTWN5NjNqME0zNndqYnRPcXJFbmgz?=
 =?utf-8?B?SVNOb1AzOFhxanlnWUV5d0JwMWd0WTBNK1lhc0hodjRMeXlQVnJqdFBnRmVo?=
 =?utf-8?B?WHpHaXVNd1dROFBNN1pIcFk1Q0RDbjVMYlhjcE1iQUpLeG94aXZOVitFcnI1?=
 =?utf-8?Q?1q+DVLTfYaCBY964fc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ba57bc-2f5c-44f8-ebfc-08d8e88f9e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:24:41.0532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0dqcXmVenL+Z4P1lGhJz0/i3eBPAARNB7qYzXj+UbbBUd8aiAOpYT4O3Z0MKDH6zwrJ2I11dCrFAH1mGFimfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1643
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-16_05:2021-03-16,
 2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=959
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160104
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_152453_148718_B3BBBC10 
X-CRM114-Status: GOOD (  15.72  )
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

Sure. I will send new patch shortly.

Elad

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Tuesday, 16 March 2021 8:30
To: Grupi, Elad; linux-nvme@lists.infradead.org; Christoph Hellwig; Keith Busch; Chaitanya Kulkarni
Subject: Re: [PATCH] nvmet-tcp: Fix receive data digest calculation for multiple h2cdata PDUs


[EXTERNAL EMAIL] 


> Hi Sagi,

Hey Elad,

> Can you please explain why you avoid calling nvmet_tcp_unmap_pdu_iovec on data_digest PDU?
> I don't recall any other case that unmap is being called on good path.

You are correct. We need to either add unmap in the data_digest path here or when completing the data digest reception.. Probably better here.

Care to send a patch or should I?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

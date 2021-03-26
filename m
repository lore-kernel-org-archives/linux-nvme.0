Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5752BC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 13:33:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF73461A1E
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 13:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF73461A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CNruJaRbIEHT8TWYmp9y8lFQ5AFp1E3HVLgnX0QOarw=; b=RXCIjMQE2VjMIHrmtsHWnsUQP
	HL91F/rYy1MH0KO/sI/UmckL3wSw0gyCDjIwgLb0QyssyqInGjhQhx5lNAUvpVHbEHfs98+iFlO38
	V1uJgWHYJjq5MeD0XdFgWfr8XrcfhpSLcRDgz3JnBjjLHDayb97n0TiE6Ljrphizp9dgGZAHUmUTr
	jm51gz3wt6fj1QFP69LOayFZyfNPZF5EPJ9uFT31yKFWa5AemseY/wf8FR33sB6OLdxhU/FnN+la8
	WZNtkz8yaLQFrybpEj0bms9IB7/Wa6YPvXvi5qGbk90mIBCdOu7Rl3NgBDv/RdY2O2OZIwt/6yVkh
	D4FMxajSA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPmZp-003bWD-RO; Fri, 26 Mar 2021 13:32:37 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPmZk-003bVb-II
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 13:32:35 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12QDW7MV032034; Fri, 26 Mar 2021 09:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7GLpj2aiVbblWC9X+jVPwr8YX2FhK/0YDypMXkexMco=;
 b=RvK5Bi8q6ch01qYQx0OwSgGCIFEZCfWmFoGzLGsmQMiwSBBbNcuWTGP7QyNwI6iQX4rt
 ZJjPSCIcPjZ7Wm3lUfiQ9Gci/Dfhs7L4QSK+tEp+/F/oVk4uqdzWXPqdTgYxd1Ttmk0y
 0xmmyJQFcmNfmOmJ+oMdsmyhsL+AAbjA9CpTfkvGkl/jnm34YbsWZDYaA4ofG88Ocqg9
 LNwmrJIC5WL51JbyDpXKIyeeyMXuZjh3nquTF7tJPRIY9zXCWRLu/J6oUWt0yETtAu5j
 T7eZclB6PLw5luKkpREEtSw80Uqp/yivB9XGaU2OF8oOIAs5t0ObLr8nw/bLEjCyfE/Q MQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37h12f2pww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Mar 2021 09:32:25 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12QDUuCE167110; Fri, 26 Mar 2021 09:32:25 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-00154901.pphosted.com with ESMTP id 37h14htu5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Mar 2021 09:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n13HmF8iA/qHX/oHvgrBOMdpT+p/PlelV7ZH/+nsZSnUpAhErkkAzkrCCnU7prYDVURNB7M7gFjwsu2kiBkzHP9OtGpdHJRusn2aTWM6Z03dqiNSh3iVPW72FcWjUVyTj8eYA1ORejbTQ42LNNbBKkbWU/Mt0aVjS1nOyZt74W5eXAmBqR5mHz/5b2bTm1tExnxHeCBTCXf1z+9CMqE+t1pU4JOjdDLvda4lKqeuSVadf5Ao9tbyaroPdqXgIn/HifAiTHwAmNAxokzaKcv2mjq4rAQMU6mOWyxhT46xWbY0inVoz4X2QPci+D+L3stCPfwaG6IRSnslUnV6fAZU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GLpj2aiVbblWC9X+jVPwr8YX2FhK/0YDypMXkexMco=;
 b=XQDpNdeJVVBoTNU58e8J/SqcYsgfcusZxFN0XAhxInwhLgxKKnu6lDZtASfm1tBqoUE/gpVK1xGXqSAVcsememYYdPEASIToUtPJjXZAzG71cCB1YLTSmsqU5IkOy2hOnKY2Je5aZY1TzKjFVpBUsMvj+1NoYUS6btk//bWdoiztczQaHwIoe/LJ+osluZnzE5KO2yWv8QyMUXN9O39d+UQmRO4kuVpGZ7DGspk5ATP19IKXsecSSuc1RCpxtnAJnSlMWsBfKSBBkXRLdpD7F6l7AwFdx6WmwkWfULlTvTzM5GF3q7N3hAVpS4V7R6PG0zIA2BF9qax1suxR4MaNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 (2603:10b6:207:38::12) by BLAPR19MB4324.namprd19.prod.outlook.com
 (2603:10b6:208:27c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 13:32:23 +0000
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::60b0:a3ae:37b2:2e25]) by BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::60b0:a3ae:37b2:2e25%7]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 13:32:23 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
CC: James Smart <jsmart2021@gmail.com>
Subject: RE: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH1WeSduPwBPbw0yAK6Yfbm2yC6qWSbAA
Date: Fri, 26 Mar 2021 13:32:23 +0000
Message-ID: <BL0PR1901MB2020C91B6489355411A00578EE619@BL0PR1901MB2020.namprd19.prod.outlook.com>
References: <20210322195717.13094-1-amit.engel@dell.com>
In-Reply-To: <20210322195717.13094-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-26T13:32:18.1151501Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=36f82c51-e71b-4c31-aff6-abe6c6a2bc19;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [5.102.204.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f96be181-a6ce-4b6a-6f80-08d8f05b96cb
x-ms-traffictypediagnostic: BLAPR19MB4324:
x-microsoft-antispam-prvs: <BLAPR19MB432433EE3A592443BBBB682EEE619@BLAPR19MB4324.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwKywfFQBZDSzOrAzC7LB8MrYXH/zASmmufGJyeSVvlNlDsguVVQFamhhlVX0rGX7Lu+D2r5ja5tgqJmtPezexf/wOsYMVgC8uerzjB1OkAaL6uNz7qsQ7i9aUC5j7Kv+NeVZ6gPtbHwEdEfVrszazE3lA/19E8wVEGk555TFJeOm0pLl7SbV+vV/CVux972QCt5JoslZl4KARjb0tYZWZFeCuAvk2KxfMgJXZ1GRkTUYvlfs6J23yF4GcYGJODZYbvOL77tj1ygF04Btx88aJIm/ZZOgM0sAgS/ozx0998LErSdruo/kUpw3x/Vacv9k7qjPmkGRSnCqcKKHy4d5Y8B4ov/GWxlwiaVVNRV58929WxwFULRUd5aneAVaZJg2h617Rz9fX8vBjxuMUu91+PtLhpIdWvlgqSTj0yvZN1FMSUG7Su/hBo8cZECN7zUtO0tYWfeSaHs/8eZRPSZvRaTqc32JJltqZ1KjNfODVFvpAveXKkusq8YzsmO0+UZ5csTAz9647Aex1Z5MzzD3fE3U5y9t0SG9Fx7TSUq2nZl70C7n+NiOF5DXDDcN1CIsQcsj29H+4BdiIyz6/rcxFiAdmAMzgmre1e1X/whcJXWhDNtncdCK50XQFGAzovibbbuiQj3494DP0TzX4KgYrLL7Eawi2vBAKv7QfEj9kE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2020.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(64756008)(66446008)(7696005)(66946007)(66556008)(38100700001)(2906002)(9686003)(8936002)(55016002)(110136005)(33656002)(53546011)(52536014)(5660300002)(66476007)(4326008)(86362001)(6506007)(26005)(186003)(316002)(76116006)(478600001)(83380400001)(786003)(71200400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1BIwKPHEXgUlj46Cf1o+xEBFoB8KSiX2A16pOH3lrML9EBQb02oa6zD8dBPJ?=
 =?us-ascii?Q?RVyRcpM74UeDvAXS49nYLCyVlENYeCjSqfsyx8be7LrOP2/oQNN9ivx3HCdA?=
 =?us-ascii?Q?ejz1Uq6/cWVZBQ/oDdAjvM4Y7fly0LT4TmUQjI3foT2Yh0ztclVeg9SO+ybe?=
 =?us-ascii?Q?wmTl1XSxyW8X9g7ql8B0cRl0qohkQ/Qh0terwmYtbofNRxHjrH5tC3ZsYjGi?=
 =?us-ascii?Q?ZexBvSSqcYZ3Exs7eO/pajk56C5JOuOrdzOROBQRfc2+nZziuyIy/jPyjpNI?=
 =?us-ascii?Q?KILYgjqBQD3hnl5/zB4DxRjEAvWCsNj3xFTjIpzo+/Pl11RxVooYDkTpF0XH?=
 =?us-ascii?Q?A0r+Brnh2PM7Cy5EmB0oMhKbCf9odtjjEiBWp65KGgDhH9LkOS2/yPpVAz4g?=
 =?us-ascii?Q?FV8GBmqfkrwUS5yBmdGyU6a0i27cj71v26WBFwjzczW0MvPcA1UZ5/d32Ts2?=
 =?us-ascii?Q?aDBOj8zy+STUqRj2gKCp8VBPsk4XtM+T4S/erYRaYGEtjYahHpCEDeW2dXWC?=
 =?us-ascii?Q?weDD9usCWR42BM71MyaEr35/Kf7yA6ILbEV3dtjUpkQ3xvWSkyM097KpKVCc?=
 =?us-ascii?Q?lJcD2RJLymhbA7/Pk1/+CTW+GaypZXhwaSBBL9s2D8TxJpyLVVg05H++upAX?=
 =?us-ascii?Q?G1APCuPSFFb8+x6COUkGao5kwewUmeVEvAVQ4+8VP4CG8WK7tYpnvUK2Mzqw?=
 =?us-ascii?Q?IqY+hpF0rtXDGLGKlF6NH4xhkpQIGYeYoQhpa/4QkxXhpjNQxX510pBt6q6C?=
 =?us-ascii?Q?9wWQ1DBNPsrixJ7bfTkNAEs4Hafz3SFzHvynd8Nkvyn3XSyuuNUtQKAMii35?=
 =?us-ascii?Q?NJ96oUWtzozCoaBAAkZ3+eeQrr87+hM1UtyGfZRDVuQ1JQjrKvGNRlwsAfPp?=
 =?us-ascii?Q?ly1t8jV5rKDxoPTQzURGw/fBpKlfxz65KngXHK4l7mIc8uBkwni2q/8z5X4S?=
 =?us-ascii?Q?598EPNoUfpGhQBIYUEz1gue7l3dW55UnUajj0Flj3MfRhaF0Nb8JD0sGYdSa?=
 =?us-ascii?Q?BwL6nsHQQ7kVSdKUWhpz/pap8qXqJY3wZ0FNq2rjEO0npuG7xwCkOnq9qTrz?=
 =?us-ascii?Q?5X8Z3IcUZG49tK9IkU0La+zLnnNFO+9FMBExV2aceOnCVCpgYKC2otLXK/B+?=
 =?us-ascii?Q?Rmxmkvcvc+MVydUM0aCVmXs7cTA9YUPhO7Td7sd+mgQVIWMBT3+p0D5KtpAB?=
 =?us-ascii?Q?0D5ATqODjf8cvucg1qWbjzlnK5q11BUJuiRUTNC9c7VXI4m/kHLn79NofbXR?=
 =?us-ascii?Q?IgkSVBn8EE/5btdrV2rEqpbLEZrkOtgpyDI9hC3GNiDntNKy1LHmEpnEQia6?=
 =?us-ascii?Q?6Hlx/I5N3szcPasmCIgXOSU5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2020.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96be181-a6ce-4b6a-6f80-08d8f05b96cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 13:32:23.4120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbeEtbE9OnwVMzIA818KGbXaFpErgqmx6uYdPewoFmM8OKFCoO+edmKz9BEMM4p1YIm0SiqOd9lSKg4/gYW/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4324
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-26_06:2021-03-26,
 2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260102
X-Proofpoint-ORIG-GUID: gvM32m0Z7R7mc6L9yiNLOt0wCvn_70cq
X-Proofpoint-GUID: gvM32m0Z7R7mc6L9yiNLOt0wCvn_70cq
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_133232_972822_F7A18EEB 
X-CRM114-Status: GOOD (  22.59  )
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

Hi, are we OK with this patch? please let me know if there is anything that is missing/required

Thanks
Amit E

-----Original Message-----
From: Engel, Amit <Amit.Engel@Dell.com> 
Sent: Monday, March 22, 2021 9:57 PM
To: linux-nvme@lists.infradead.org; james.smart@broadcom.com; Chaitanya.Kulkarni@wdc.com
Cc: Engel, Amit; James Smart
Subject: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport

From: Amit Engel <amit.engel@dell.com>

Once a host is already created,
avoid allocate additional hostports that will be thrown away.
add an helper function to handle host search.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fc.c | 77 ++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c index d375745fc4ed..cfde3376b8ee 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1020,61 +1020,76 @@ nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
 	nvmet_fc_hostport_put(hostport);
 }
 
+static struct nvmet_fc_hostport *
+nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void 
+*hosthandle) {
+	struct nvmet_fc_hostport *host;
+
+	lockdep_assert_held(&tgtport->lock);
+
+	list_for_each_entry(host, &tgtport->host_list, host_list) {
+		if (host->hosthandle == hosthandle && !host->invalid) {
+			if (nvmet_fc_hostport_get(host))
+				return (host);
+		}
+	}
+
+	return NULL;
+}
+
 static struct nvmet_fc_hostport *
 nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)  {
-	struct nvmet_fc_hostport *newhost, *host, *match = NULL;
+	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/* take reference for what will be the newly allocated hostport */
+	/*
+	 * take reference for what will be the newly allocated hostport if
+	 * we end up using a new allocation
+	 */
 	if (!nvmet_fc_tgtport_get(tgtport))
 		return ERR_PTR(-EINVAL);
 
+	spin_lock_irqsave(&tgtport->lock, flags);
+	match = nvmet_fc_match_hostport(tgtport, hosthandle);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	if (match) {
+		/* no new allocation - release reference */
+		nvmet_fc_tgtport_put(tgtport);
+		return match;
+	}
+
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
 	if (!newhost) {
-		spin_lock_irqsave(&tgtport->lock, flags);
-		list_for_each_entry(host, &tgtport->host_list, host_list) {
-			if (host->hosthandle == hosthandle && !host->invalid) {
-				if (nvmet_fc_hostport_get(host)) {
-					match = host;
-					break;
-				}
-			}
-		}
-		spin_unlock_irqrestore(&tgtport->lock, flags);
-		/* no allocation - release reference */
+		/* no new allocation - release reference */
 		nvmet_fc_tgtport_put(tgtport);
-		return (match) ? match : ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	newhost->tgtport = tgtport;
-	newhost->hosthandle = hosthandle;
-	INIT_LIST_HEAD(&newhost->host_list);
-	kref_init(&newhost->ref);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(host, &tgtport->host_list, host_list) {
-		if (host->hosthandle == hosthandle && !host->invalid) {
-			if (nvmet_fc_hostport_get(host)) {
-				match = host;
-				break;
-			}
-		}
-	}
+	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	if (match) {
+		/* new allocation not needed */
 		kfree(newhost);
-		newhost = NULL;
-		/* releasing allocation - release reference */
+		newhost = match;
+		/* no new allocation - release reference */
 		nvmet_fc_tgtport_put(tgtport);
-	} else
+	} else {
+		newhost->tgtport = tgtport;
+		newhost->hosthandle = hosthandle;
+		INIT_LIST_HEAD(&newhost->host_list);
+		kref_init(&newhost->ref);
+
 		list_add_tail(&newhost->host_list, &tgtport->host_list);
+	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	return (match) ? match : newhost;
+	return newhost;
 }
 
 static void
--
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

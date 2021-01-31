Return-Path: <SRS0=pTPU=HC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B5CC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 15:48:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2696764E0E
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 15:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2696764E0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GlakNEpCs2QGfDQBiR3U5HPB9h0ucEDPGaaKakeD4og=; b=N6x24QewCRYNboqFPDYkSF8Zyl
	cFnUMJj2Az5YSSi9xzOYVyuTbwTldNG2adI1+kosaSX2gVJxNlG3eM0fIJxRbDLXQ7dZyV3tVqah+
	bgOfRMtLoGpx4wOLjHVaKnyhqpmWURJE2veoLRRMTb3tr7xwuhFXgq8JVHPRw+Qq4V3Y/Q74j7pr8
	+nqR1rnk8EWtFtkjh+TTJ9+pVjjXZuim+puEme8+BdNbeltglfQKQMo4R0/z5N5962penQrKxY5DR
	/1Ev4Hsi7cdmB0wm3kIaritrFA/Sh9DX8mjE3x3pmSqd0PMu9sBJF/SqravNfvbkWGWMEYESlyWwm
	XZSj9Uog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Exx-000522-6l; Sun, 31 Jan 2021 15:48:45 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Exu-00051H-LQ
 for linux-nvme@lists.infradead.org; Sun, 31 Jan 2021 15:48:43 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10VFc1LS022418; Sun, 31 Jan 2021 10:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=nOmhmS2q/C2yL/GeJ0gu6Vgr3MEPM0YJf5MdROUhrSE=;
 b=s1Fyp2PFZLwex0JGrQvOm1XZcBL6lZQn+/zxoJhuoYRDS3MnMok3Vr6D/swNOVI6FMgn
 0lK+uUoaukzSJZeFD+LUvtR7ohUHE6hdXOgHDQEC3DAB/DYo4BFIUkFk9CWxvMu+et95
 HVWXaQhXWpBImpJIzwDD0qa92GhIaohU/QLHrVBrAPvNkD0ZzTffIJxAkqmJrfb6YJ9/
 D1sPKTIxcC8BnwMeUTKN1ESMgVtoEUjiNrNBshluW5AxYNyEn4tOJa3OOEGZePkISPKn
 uvVTdd/wndyy4tuUnHJzoJX0yzlFXHiPSqKhIaq6wQGCpDl8Wclt6ggPJZfpIQcPNzyW Fw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 36d4bqhybj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 31 Jan 2021 10:48:40 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10VFfUKJ121104; Sun, 31 Jan 2021 10:48:39 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by mx0b-00154901.pphosted.com with ESMTP id 36dnt2kr8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 31 Jan 2021 10:48:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCwLSxjxWMj+X1fyKB6C06ArRJkUOu+tWebhPB+fpORXljmkd+9+h2jkT7g23G/wmgkvFSTwIfDOM7zbEvLkkuxNmuPPALTg8h3MmprCD99deQmsp2KIgCKr9OuxBOKZgG4C/1MpvwfwvQnK95sYGz47zv+kTMfTNAvBta59ViiHzNoyOXNpKshbfewPipg+0oXMa1721beoKQBAa2IhVggsNqwSWOOWyDU3huBtdA7nzodN/QAhzb0ZdsR8hkA9IE8Br+3CvZ6U7ae3ahEQmvahRUdwAvrn03jxW9vduWnK4154ZgD6uJCrduU891mP6qggwPdQVd+gcXtIo0doHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOmhmS2q/C2yL/GeJ0gu6Vgr3MEPM0YJf5MdROUhrSE=;
 b=SI+cqxPJ6GOKXYmYUZkd0mX0CGvZuQjTG4Ydt9I3F6krAMP5XwE24Ok/QzPvXY4CeCZQrvBwdzva73REXmCyO2GqlgMPa/CTZsoJdTfAMNBq9vOe6IFYven+tw1B/kMz+iHZDnL7ABnm3uIqTyb/d+eb/+Dbk6YYEMf2Yi6qEhHDrnBuebmhMI/OLZZYzPha7wZP14iWyJVtnvY/tXOFKPR96QKMJjmsHkTOpqAyRDJFf3fVvy/D9jkDCmVBmr2O8a7FdAxtCVQxeocl4lQP1t2bejbxTLvp4CUNOCmNOulvBk5IqEhpLhNCzGTiVPFaM+9Nb5zWh40s4q3uK/7k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB4327.namprd19.prod.outlook.com (2603:10b6:5:2b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sun, 31 Jan
 2021 15:48:38 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 15:48:38 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KomKNIAgADakqCAAJ7gAIAABJXggAHRIICAAh/SYIAWZecQ
Date: Sun, 31 Jan 2021 15:48:38 +0000
Message-ID: <DM6PR19MB401175FEE24AD30B1289DA3EEFB79@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
 <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
 <f5b8dbc2-7960-894e-47ea-b18665536e70@grimberg.me>
 <DM6PR19MB4011A4116FAB37BEC28BBC91EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
 <6459e22f-f2f2-9183-0862-654bcc5e90eb@grimberg.me>
 <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-17T09:46:51.9559312Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=58469963-4dc2-4484-bb01-6ef8e94a7820;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c361880-792c-43cf-1cd6-08d8c5ffad16
x-ms-traffictypediagnostic: DM6PR19MB4327:
x-microsoft-antispam-prvs: <DM6PR19MB43276A6611CEE1B35ED67D1BEFB79@DM6PR19MB4327.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcrbDaxFSbbC1HVo1ZfOdkUQPbj3smSuj+Qq3E4bYkDcdtc3g0tmLznWo6Wb24Rt1JuhdyaUGLE1juDm0+WpHByy4KaUgSFzjbC340V/VWSO5oH6JguYYO9S52d8DchEyr6R0tf6Lynr2k+Q9ErIJcm3zS4XmJq6Kr/NSusu7h3BPoWGRNO7z0PFR3f73P7wep+GCXOfrWLqu/O+aMLzdtpnqXQ134RMAM1cEQSZs1dOMhtXHJgsohxBYGqzOsyIrDi+YoEpmM3tdysKYCebMzTTSc1clsbEjqGKp5MM1KUU7C8Yt/JuR+6ZZNwwqCt+/Zd9IbUk0mNzW9nR0LmWu8JX/VwZ6gC3Y5TwTwnuOygr7HxNf+uq29KSs/5p8tDNrkYGVk0WGXbW9U0OD+xMW9hZBKcdpUyoMUTnctMOm8BSSy1XK2pCwbYu/FXCHVmg20Ow1LB76EErw1JXrVbcThTQbvL+ea624EKsYtZAuYQ3taH5ADXs26veaGMcWVExFiygbBTt3ZqkP+Lh8zTuKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(66476007)(52536014)(5660300002)(83380400001)(55016002)(66556008)(66446008)(64756008)(9686003)(66946007)(86362001)(33656002)(76116006)(110136005)(26005)(7696005)(186003)(2906002)(786003)(316002)(478600001)(8676002)(8936002)(71200400001)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVlHR01QT2hNREtGT0RhaVhHQy9RTVhMeUZPbzNPeVpPN2JPUWN6dWFXcWtF?=
 =?utf-8?B?RFVKRTZPV2trY094WjJHZldHT2EzOWpJZXF3cm5HL0FFZk5Dem9teDUzUEd3?=
 =?utf-8?B?TnFzY0s4MmZQNm5OTGNWanlTbW1JQm5MKy9Ud3hlWGtkcURKRUc4YXpNak9R?=
 =?utf-8?B?ZXYxT0x6UEtiVGYyUk1qc3ZRcUxwN3JjKzdUdWthN0E4bWZzOE50ZnczZkhr?=
 =?utf-8?B?TVRiSWR4TTYwemlLSldUbTQwNmNtYWxjd2xzZXNCWFVOZzlJWFJ4MUMybFVs?=
 =?utf-8?B?endDc0pqWXNDRDJzWjd6L2V2Y0ZiZnFTWHYxdjB4M2oyMnk1dmYwbzIvWng4?=
 =?utf-8?B?RFYzSlZLTnZ3UjRESXVlNjJydG9wTlN2WnF5cVF6S2ErSG9SMm5wVENPczNN?=
 =?utf-8?B?eGRsOWdmUEYrVitHaE5BZUpydmFMUGFwUUtOejBoZFk0Q0hHQ3NnY1dQRjNE?=
 =?utf-8?B?dGRrQkUvc050SERZVEprc2FKb2UrMVd1UExlc1I2MmQ1bzJEUFF6NkRlVU5p?=
 =?utf-8?B?WlBwNjRyc0UxUjJENVhjbFBnd0QwMTVPTzZCUjBsdyttZXBIdndDclBpbHlP?=
 =?utf-8?B?aFk2NDQxMVgvbzU2N1RveHZvQW1WSk56UXcvcHJiWnR0dWR4Zy9JZ1lXUS8x?=
 =?utf-8?B?ZkhiUHYvTU1Qd0pHQ0JVNkxKLzlkNXFBdGxnR1lGckxSeGlYWTBNQVcyOWJi?=
 =?utf-8?B?SXFTMXE3ZmRldFVBQzNSMEt2RXRoSHZBbUZPcHpkcit6dzM5WXR4d1RROHNa?=
 =?utf-8?B?QkRJUlJqSHpvOEwyV3R5bVhNaDNmRDVSTFdaKy9TTlQ1T204UnQvanl2UGJB?=
 =?utf-8?B?YVYxbGdYWW82cDhIb0lrUElaaUZoMnllekxYc29taDRjdlp6NGpvOEpWbjZp?=
 =?utf-8?B?aytFeWJvUWoyL09Cd1BBTVc3M2J0T29yeFpLZTNSb1QrWXg0NS9ZOEJQcnJn?=
 =?utf-8?B?d3VrNEtQdmlDcDVxVENoSUxQKzZwb055WDRNcVdpdStBaCtGZFliMzVzalk2?=
 =?utf-8?B?aTF0WnpRVzcrbnFIU1VHeWxyVGl4VDBkRHVKejlFVXZ2SkRoMmtsSmIva24y?=
 =?utf-8?B?enJocCs2cEhNSEZIamRtQmppdnp3c3JaZkpSdWpjMU1Tdll2Q0JZTjRBN3dk?=
 =?utf-8?B?bDN5ZGkrdTR4L2pLR0xlcGlzRERZWjNuL1JHbWcrellHRWFBRXRSZ1ZIM2J2?=
 =?utf-8?B?MjRJU3JhcmZjd1JPL25BK004ZFdWVmZ5cGVWU0RSUmt4REs4L1NoblZ5alY4?=
 =?utf-8?B?S0xSc25XTjFmaU9KVSt6SmtFRUlyUDB2ZVY1WkN5TWE1aHFSUTQxeFN5ckIv?=
 =?utf-8?B?R0RFVUpINTZobC80TDFvMDFUZytGU1oxSEFqSHRodXo2bnppYzlacmV2bXNx?=
 =?utf-8?B?eG52a29uUFQ1RllOMHdUUmdLMmNiWG5MVCtQbHFGOHVmcW9oLzRNRTd6aEJm?=
 =?utf-8?Q?hfIEd7w4?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c361880-792c-43cf-1cd6-08d8c5ffad16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 15:48:38.2681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeLJNE71SJcgIuVYKo3ET9nMghWADZNnch+xqdlKrIzy74NDM0CShKg6943w9gA3VYPMR7ZB8lsP4C82ZktVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4327
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-01-31_04:2021-01-29,
 2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310090
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_104842_920640_4AB6F7B3 
X-CRM114-Status: GOOD (  13.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Any update about this issue?

-----Original Message-----
From: Grupi, Elad 
Sent: Sunday, 17 January 2021 11:47
To: Sagi Grimberg; linux-nvme@lists.infradead.org
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error

Yes, it was reproduced with the validity check of resv1 field of connect command.

Jan 17 09:43:36 FNM00183301763-A kernel: nvmet_tcp: failed cmd 000000006fe9c801 id 0 opcode 127, data_len: 1024                                                                                                                                          
Jan 17 09:43:36 FNM00183301763-A kernel: general protection fault: 0000 [#1] SMP NOPTI                                                                                                                                                                   
Jan 17 09:43:36 FNM00183301763-A kernel: CPU: 10 PID: 615 Comm: kworker/10:1H Kdump: loaded Tainted: P           OE     4.19.158-coreos-r9999.188fe4a1ba192d57eaaa3462db70e1d9 #1                                                                        
Jan 17 09:43:36 FNM00183301763-A kernel: Hardware name: EMC 900-532-002/110-551-910C-01, BIOS 20.12 11/12/2020                                                                                                                                           
Jan 17 09:43:36 FNM00183301763-A kernel: Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]                                                                                                                                                           
Jan 17 09:43:36 FNM00183301763-A kernel: RIP: 0010:memcpy_erms+0x6/0x10                                                                                                                                                                                  
Jan 17 09:43:36 FNM00183301763-A kernel: Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe         
Jan 17 09:43:36 FNM00183301763-A kernel: RSP: 0018:ffffc90007bc3c70 EFLAGS: 00010206 Jan 17 09:43:36 FNM00183301763-A kernel: RAX: 34e40d75735a3225 RBX: 0000000000000400 RCX: 0000000000000400 Jan 17 09:43:36 FNM00183301763-A kernel: RDX: 0000000000000400 RSI: ffff8887f03368ca RDI: 34e40d75735a3225 Jan 17 09:43:36 FNM00183301763-A kernel: RBP: ffff88884ead9d60 R08: ffff8888b53e0530 R09: ffff889789776b4c Jan 17 09:43:36 FNM00183301763-A kernel: R10: ffff8897897766c8 R11: ffff8887f03368ca R12: 0000000000000400 Jan 17 09:43:36 FNM00183301763-A kernel: R13: 0000000000000400 R14: ffff8887f0336cca R15: 0000000000000000 Jan 17 09:43:36 FNM00183301763-A kernel: FS:  0000000000000000(0000) GS:ffff8897dfe80000(0000) knlGS:0000000000000000 Jan 17 09:43:36 FNM00183301763-A kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Jan 17 09:43:36 FNM00183301763-A kernel: CR2: 00007f592924d890 CR3: 000000000220a002 CR4: 00000000007606e0 Jan 17 09:43:36 FNM00183301763-A kernel: DR0: 0000000000000000
  DR1: 0000000000000000 DR2: 0000000000000000 Jan 17 09:43:36 FNM00183301763-A kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 Jan 17 09:43:36 FNM00183301763-A kernel: PKRU: 55555554 Jan 17 09:43:36 FNM00183301763-A kernel: Call Trace:
Jan 17 09:43:36 FNM00183301763-A kernel:  _copy_to_iter+0x333/0x3d0 Jan 17 09:43:36 FNM00183301763-A kernel:  ? tcp_write_xmit+0x403/0xfe0 Jan 17 09:43:36 FNM00183301763-A kernel:  skb_copy_datagram_iter+0x7b/0x260 Jan 17 09:43:36 FNM00183301763-A kernel:  tcp_recvmsg+0x238/0xc90 Jan 17 09:43:36 FNM00183301763-A kernel:  ? tcp_sendpage_locked+0x44/0x60 Jan 17 09:43:36 FNM00183301763-A kernel:  ? __local_bh_enable_ip+0x60/0x70 Jan 17 09:43:36 FNM00183301763-A kernel:  ? tcp_sendpage+0x41/0x50 Jan 17 09:43:36 FNM00183301763-A kernel:  inet_recvmsg+0x5b/0xd0 Jan 17 09:43:36 FNM00183301763-A kernel:  nvmet_tcp_io_work+0x116/0xb40 [nvmet_tcp] Jan 17 09:43:36 FNM00183301763-A kernel:  process_one_work+0x206/0x400 Jan 17 09:43:36 FNM00183301763-A kernel:  worker_thread+0x2d/0x3e0 Jan 17 09:43:36 FNM00183301763-A kernel:  ? process_one_work+0x400/0x400 Jan 17 09:43:36 FNM00183301763-A kernel:  kthread+0x112/0x130 Jan 17 09:43:36 FNM00183301763-A kernel:  ? kthread_bind+0x20/0x20 Jan 17 09:43
 :36 FNM00183301763-A kernel:  ret_from_fork+0x1f/0x40


-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me>
Sent: Saturday, 16 January 2021 3:19
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 


>> This was a silly typo, did you check if it addressed your issue when you applied the needed change?
> 
> Yes. We applied the needed change before testing your patch, but still had kernel panic on recv flow when we had unread inline data on the socket.


Can you share the stack trace?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

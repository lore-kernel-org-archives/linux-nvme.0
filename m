Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC5C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 11:54:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0262310E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 11:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0262310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qkwnmyFdT7gNwK0LZCrgYZPj9V/gvtCb7rKB/zWva0=; b=F1CV4fppkwvjaka+K2n5F4cVhE
	tSxA0NV7vjq+S39P0UkWgJv4UcnejO9izdc+daRva9qFu4IUmSs8tdm5L6ukZ50Qmbjgn+uCQdRvi
	uEDSnlxtz9OmtOWnHKtmv9B3Iq5ulaLBf43EiFJppyYhuMjtY5oauYf8Si6mEDH+yeP8HVEDIpk+G
	EGILr2ZIGDoKo+tsGmGUgNfO3wAuFuOd0XYQ8igr06c61bJZ2JcUH/bFwVJzlMzW9BANy/SRI+MqZ
	EiqjzLtBtczd3wmlB7sfJrseycqcQXZrCDtvD7MmmGNlzDczcpkMWzwp4x3FvQhaCnkOTO6ILZENE
	J0TB3tXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l01D6-00054v-I5; Thu, 14 Jan 2021 11:54:40 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l01D3-000543-5g
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 11:54:38 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10EBpm0l004871; Thu, 14 Jan 2021 06:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=OTDTjNDlWA6nSH+u+OBEJoogscPYgI3JxgFEjpVMasU=;
 b=qho8A3gfcYLygbwFc1bsnUy6dOFD8QRPdFOEgdTDY3UVXtyR3fzBISgC+sQWWfWEK2kN
 1kAPw3e/ct/9vwjtuEIcbMJP+dkbbqlcUOOdeGsRIA5sK/Tv6KWzCVrtWgAKJlsqAlnz
 klrXUv1V76Flh+sQmdSHLSnYMSYGAXy5bHWAtE3iVCzCiJKiwOkOD6dmF7OkaxlTVlMU
 RWXCPu8DVuqqrKfGolZ7V3GLOyfxJcaY7utabA3hQR76pU6JVILWTQxQGL17J/vC1dBA
 TZEs1PRHbGYoOOlmoWtIH9iSu8Xv4zAtbLaL/utCZGTx1lEz71m4ObEIfJRIngseLMMa RA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 361fybeyw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 06:54:34 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10EBsUX9163756; Thu, 14 Jan 2021 06:54:33 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx0b-00154901.pphosted.com with ESMTP id 362kne15sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jan 2021 06:54:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0J6bh/DLyJT0eCbElWxGDXcnkPuxgcaHrGVnspakF5aKFCSxsDpQRuBG33i1S3J3pe1doSMYEzkp4VxgowuSooIgLOnSj0YllONO9nMERJxfAKGZUdV8mUKrTfHJbqHHt74GsywoTgmo9D29YgNE/GEFvjhtCmUfZ3cFwhIOtIqYV19hjWTpmH4ViM3qW2kyBIjX6+kQkAtWxseHjcttQrqxf+rr2MPm/qbgGTEknf9lOgjUmzpNxjlGbGoxp93JlNHsaf1SdBFpDdg741nc1UwaVM1eDk+qTXVgQJJj3ZBX7u0W535R+oLmfdIe3ELrqQGwQISg2C0AZtTxG6Qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTDTjNDlWA6nSH+u+OBEJoogscPYgI3JxgFEjpVMasU=;
 b=E/11KSS/HWdtCkghE6TfxwDez5D7CjhnfOV4HOHFJsnxlTWguu7ktyxW9LmANcTGHltMVYtse8jWX3fR2jJVyCiTIaUfgDpQS0BLyEnR+Ha8VhGGwd9gXl48u7eZaAOlW9w+dyUCwBPBi7nPBVgqDLi7NQ1iuwQFnJXAGgpKTQbC3S7BktYhvTLrcpEjXyGWKFpQE0GCAkWLU8zt9ZfaFb0rMA2E1JjrhpMJ19q+Z5qhdkCjxR0X7OoecBwAlnn+KLkePnLrVs7yu9UHFueSyNq3+y895svRfUE1pewJYtuuCP5QjWa5B8TVLnXF7cTmWZcZnvgCRJanEweqErwjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTDTjNDlWA6nSH+u+OBEJoogscPYgI3JxgFEjpVMasU=;
 b=pG1SR2+iWuMxUawzC4oWAOZ0hk2wZufokFyj0Ejh0woH3hg8xXfTz+L+nGJb9vGeGo22V6G3uFCO2MfNjYMY5+Fljf4E7Nka06R54F90wG8edkzuMAfl6m0YoJxqCgebhgNQqDDZnwLIeaw002kG8dcdDT9Gz2pwGV4eKPblN1Y=
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB3162.namprd19.prod.outlook.com (2603:10b6:5:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 14 Jan
 2021 11:51:05 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 11:51:05 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KomKNIAgADakqA=
Date: Thu, 14 Jan 2021 11:51:05 +0000
Message-ID: <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
In-Reply-To: <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-14T11:51:01.6075850Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=0705b098-3b8a-409d-983f-3bb036b2467d;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35a3b62a-e827-4bd3-d222-08d8b882ac8a
x-ms-traffictypediagnostic: DM6PR19MB3162:
x-microsoft-antispam-prvs: <DM6PR19MB3162E5769FBC7F56C2A31541EFA80@DM6PR19MB3162.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ukSJpNiQZQCBNRMFwxoqZ7ebOkJZW6fSFwiDMQMAFUFWkqs93E6W8uYYx3bxc6u/ScyS3cWVVMwgZp9wAALVujjfNpcuQKiZDbK2Ylbll9B9Il8VVi4ivWp8REC0xzSw9hTYCMEewivUO8eHYUCfkzFq/64dpGiks1nY23dpV6iHJ127Ao4//LzPR0H1gJYuaj1i/wAY+XrcKqrgHNLbuSQhzB7c3wycTqHtbu0MOTRQdxiJ8ZXQL9OYHgt+jruVOcoORWdDLCBq9tNSBSFqbdT6Qz+ATs3diyhX5v2dQxi/UOH2VEHPtudDbo7COr2eEt2fhJ5I+CwEdRxqEYMpMETuCreSPNbx9BEd5gYvDE/F0EdzbIZqPX+zMx+aJ14soFCkX2nbNkNmaX6EYzc4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(66946007)(66476007)(66556008)(66446008)(64756008)(52536014)(33656002)(71200400001)(2906002)(7696005)(8936002)(76116006)(5660300002)(53546011)(786003)(55016002)(83380400001)(110136005)(86362001)(8676002)(186003)(316002)(26005)(9686003)(6506007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bFFmNHo0N0hIaHVkL29DVThmWkZNSzM5OFNyOXhMemg3am9CQlZiaFpPVVpq?=
 =?utf-8?B?VnY4ckZWdXdQbDlmR0YzZEhhb1VCK2Q0dWZ6SGZNQ0I0Y0tKYVJiakNCYjR3?=
 =?utf-8?B?UU5lbVdBemRSVGdvYVAwSkM1MElUUis4L3E1SHNsMytKSHFycHJvRlR3VVlv?=
 =?utf-8?B?VkprWEpVU0JZaTlWWUtqajBoWEoydnFLQkE2anJXUjE0Qnl4QXJYZzFybVJZ?=
 =?utf-8?B?SGRGazhscUVsRlF1Nkk4WlJEYjFEUFZYaXU1cW5SOFNLcHBaUVVDd1pyMVl1?=
 =?utf-8?B?QnV3TjZiQ3NSQWhyYysvQngvUEVzclRMMFdNOTVJdWVxZ0lDRmNEemZlWURk?=
 =?utf-8?B?MGtNNzdzY1hiQ3BwRzRqSk85ZVRDdDNzZGppRlp0QVZLS1hxb05pZ2Y5b0k5?=
 =?utf-8?B?dDhmV2FjM2RFVmFaZmhOMWtnSWkvVnhQaEZjVUN2V2JJYVhnS2JKUHZrb0ky?=
 =?utf-8?B?ZWJGcnc4WkcyMVM0dTlLd3BPdjFtNG1wbitNeXUyZ3BCU2pFRnNFVk1SbXFj?=
 =?utf-8?B?TTFqaXRVUW0wY1ZPMTlvcWhaN3YycGUxV084UTVJR0Q2aVJzZ1grUk9WQlF0?=
 =?utf-8?B?V0F4Ri96Q3VKZmhPbGY3TnVYTmgwRzBBQ2gwYTRGVisxVllLdUQrWS9KQksv?=
 =?utf-8?B?NWN3WHU4ZENhRG5KNTAxZ0RoSFg1dFRrNDFtVldyWlJtS0lJS2VqZmFZR0o1?=
 =?utf-8?B?M2VzV1ppckg5ZWJFaU5mZkpvZjZaeFBzcTNtb3ZCYVMzVmhZbHk2QzAvUG02?=
 =?utf-8?B?V1NCK3lrR3IrU0RRckZkQXcySG5qQnN2VWE0MGZkb3ZmQkd0V3B3K3ovU3FE?=
 =?utf-8?B?UmkrUC9tbDhJNnhPU3NvRzB4N0xuREdvTUZEc053SXJxS1BYY3oyKzNPdnR1?=
 =?utf-8?B?dGppZDZsOHF5TnNaZE5IS3hNa0JrMlhqelk4L0dmRWZhbitVYjc5RDBIUHM0?=
 =?utf-8?B?MjI3UFB5V0NNZ292dnkwOEd1dXNyQzlIcTdqd2RGTTlkYnZsV3QvODJUNURE?=
 =?utf-8?B?STFXSFBwdTJxNHNodnlnRDN6VXdTSVJPUXhMemRwdm5QNUl4Rmt6Y3A1R1RI?=
 =?utf-8?B?QmczMzlCSTJyWkdhRlJtbCtIME0vcHZvemdqRE8wc1RxbmNvZDczQk03MUVC?=
 =?utf-8?B?eFVzK2EzMXJ5TlMzbVZYVWQyVU1FaXpjRk1OMFVCd3Fxd0ZjZW5pWjRSM2JM?=
 =?utf-8?B?eFFTcFhIZE9rWFVKOUxQRDM1L1NnR2oxdmdSVElvUlo5RndIWnlUbmFsY3Ez?=
 =?utf-8?B?cFNVWEdqS3J6UDU5dlJjRGpuZWVpa3V2SlZOSEtxd2FabHdia2VyYkxLY3ZG?=
 =?utf-8?Q?oIbwQrp4YQy/I=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a3b62a-e827-4bd3-d222-08d8b882ac8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 11:51:05.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZVv7imjWyR6/vCrQvelj0PgsBG2KuxJSTnbZaWsb58fuEHG1ctSE8qExB2vmHDPB+rMQQz38vlvJP6KcxN6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3162
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_04:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140070
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_065437_345880_AFC7B9BF 
X-CRM114-Status: GOOD (  28.18  )
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

Thank you Sagi,

I will submit a new patch with a comment as requested.
The patch you sent did not solve that issue, I submitted some comments on the relevant thread.

Elad

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Thursday, 14 January 2021 0:47
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

Hey Elad,

> From: Elad Grupi <elad.grupi@dell.com>
> 
>      In case there is an io that contains inline data and it goes to
>      parsing error flow, command response will free command and iov
>      before clearing the data on the socket buffer.
>      This will delay the command response until receive flow is completed.
> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index d535080b781f..dea94da4c9ba 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -146,6 +146,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
>   		nvmet_setup_c2h_data_pdu(queue->snd_cmd);
>   	else if (nvmet_tcp_need_data_in(queue->snd_cmd))
>   		nvmet_setup_r2t_pdu(queue->snd_cmd);
> -	else
> +	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
> +			nvmet_tcp_has_inline_data(queue->snd_cmd)) {

This deserves a comment I think.

Did you get a chance to look into what I sent you guys?

> +		nvmet_tcp_queue_response(&queue->snd_cmd->req);
> +		queue->snd_cmd = NULL;
> +	} else
>   		nvmet_setup_response_pdu(queue->snd_cmd);
>   
>   	return queue->snd_cmd;
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

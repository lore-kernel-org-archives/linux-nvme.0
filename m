Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4313C48BE8
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 10:41:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B585E611CE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 10:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B585E611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4p/hrgNc0CmyM+7ooDtC0/z2r6i/YUzRiStpXQV6f8Y=; b=fBpaaAXjdnUY8n
	zjLikngqFvv4MsIW5urZ5x/u2KHq6TmDcn4bAhgH5/TN6fEgH8tzrfKYa6j6sLHvlfa5+/mgG6W+p
	Vhlea7L1cDlgqe1/bYQjsxFqZY+7o+iRKH3D6U5x6fl2HyhnzstywsNAnx+pXepLJei8frKfwEMAA
	61aWy+xCpcWWcS6mMhFSMTson6kNm172PrEM5gPYfEBfVCqlQh+wTxAFpOhyyrCsdcpsoZ1yJnlTM
	6DWQDEvt+pSqbV67xKJokMfVm2mtYsVSD0nTunkZfcrz4+qD5tUGPQdnY398MvdBFlUiu0WtGEKIi
	+pCD1dtw4PSF70lv1Cpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltSzM-005s9P-9y; Wed, 16 Jun 2021 10:41:40 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltSwW-005qn9-9i
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 10:38:45 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GAQuwX014980; Wed, 16 Jun 2021 06:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jIs8WO/CnqC2vkVOEdVMWTWgCxjBescEQ7migXjYuvY=;
 b=YqHHB1zwQ45asGwan0gYX4xl1vtL6SqUVYiI/b3DdunSod07Kw5RMgZ35cof6hVSdPbQ
 meFkzbNfW4OJAiqIdZ3qxHfv5n7KTnIq4BbJiw9VAPYJ/WltPVL+ndHAJxMCuCnnmASk
 t7Bxok+SMN83U2a/OR8REg2tYzSKQckhxMY3hlJRz/vZJiqC5k6fFo73AXyjZz5N/qSI
 buexdnLhvHz1KyG4oUTHMVunQ8Ad9rvb+KoVkFhsj+/xhhuzrSn94iLct5SiWl2abECJ
 lM/L8zkAm5/aGd7uwCVLXmok+Hiv4wwq6Ew6WmJIbYY+m2F5Sw7vdRi0ho5K8jRlQPwT mg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 397buf8wh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jun 2021 06:38:29 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GAOn9U136106; Wed, 16 Jun 2021 06:38:29 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-00154901.pphosted.com with ESMTP id 3971js3rnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 06:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koyUIZ5pgYMv80COIgOmpJ977KOIixxfLf+RIkrLYjU5LMCyQmRZEwd6fFf6nEC94YbAPooGrglVfq2Ij51yfeDodNSBCDxvvGKH0pw/bKcx3zin+UbYwj/Phd8H18KLzJpvzmbpDIXuIwQRb32MHi6jvy1UBit7GsMOoRKT+QfxOHZsuisaeI9cnGrLnfXFW2U2tqUa9VGBY7CgOjX12uNTGTv4gT6y0t1ubDBkBRhpCtEyVUF7G+0nVD44vwesOjwT3qBSaNDKdwNXq4wglhWjJNxqUK7AkIqbUNVZL3Brc93aW/A3H2d6gOJIo1GhCGyJ+Q4/ScuOcHmEx6BmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIs8WO/CnqC2vkVOEdVMWTWgCxjBescEQ7migXjYuvY=;
 b=liMNNR7evSSE7P4Em6rcPrhVMFmikW5T1Xg3ZCkjGX8J6ZpvRHniKBDKqY8JxtP0QuMS6Rczu+uEl59ZsaATiaMcqvsFQWIoSkE0ecSco1QC1sv4wnC1yGOmsUMgOsoyeaDMv/pDZ8ydEKzTNT6Hwf+gWQYwFoGV/SYaWy0il8jRl0fNw16ifXThrcg8P4MPGPjkXjXjwiS3kVO7Q8+/vulGexCnI07NECTmrDSmH9PkBiY+5NjFM8Uq4BkvA2yJRsBrMVN0Kf7lUJJ2eJxrI+gdVOBpbwPpsndo/S0OGOliBuvXTvYn/I/9L9fA2p+qASvvJuAKnpPYoHLTDRZtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB2935.namprd19.prod.outlook.com (2603:10b6:a03:b5::33)
 by BY5PR19MB3143.namprd19.prod.outlook.com (2603:10b6:a03:181::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 10:38:26 +0000
Received: from BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca]) by BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::2843:ac16:7f75:35ca%4]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 10:38:26 +0000
From: "Rao, Vinay" <Vinay.Rao@dell.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "Belanger, Martin"
 <Martin.Belanger@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrMhECQgAC8igCABBgqgIBFZJKA
Date: Wed, 16 Jun 2021 10:38:26 +0000
Message-ID: <BYAPR19MB29356113F0A06BA4925EEF838F0F9@BYAPR19MB2935.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
In-Reply-To: <20210503065235.GB32627@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=vinay.rao@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-16T10:38:23.7522356Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a6aa03d7-0130-4702-a8ca-fd464e893ced;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=dell.com;
x-originating-ip: [2405:201:a003:d124:f449:7f8:ad7f:c8f1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00817e7b-9afc-4a90-bf07-08d930b2dff5
x-ms-traffictypediagnostic: BY5PR19MB3143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB314323F037F09880F7B7D0548F0F9@BY5PR19MB3143.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzTErwbkRVlwx0eyo6bIcpYu70BXCHftcc0NgYv21k4/oFLaHOG1zyoKob89vAQdvmuZl3jJUuy6ncAVGWkjUP1pwx68WlscE3TN2HlRMz2oqezzb5etLI6P8hp1tRBMITG0uHqHvIkn5R4DdRZS7v2DBX/DKEd2EebMyoTHyJ2/dU+meS3XGKprr6F8sez2xsTCfev6WmQAo1unlGDaPQJPacm7ticvVJEu5gjOdzjVJ8vp/AUw3PPuGEZEA25YIaznKIjrSzF1y5eGq2XKp1/TvXyIUpg4W2VwVlAwZnqDS2XvnATvOTp32WSeF0OG8kafGfj9+8pdKAKo+23vkqkYCw92ezCqsIGWRz6mscOATTgvPFhIoYI7gWKSQnFBsOkSsxZsb0u6jpn2Gwp6xIae/OcEvLNRC7v8SykkwngAvQ1h1p9BQzU+8qUkBmE8NWeJq6VS9vIVQymSCeT4F/v5Yl69i/a6rdU+Ip9zVEJ41KRnKuzRZ4FJL+75nrKhkM9GrsJr7RUpFgkUKwlsZb5468q+Il03b7J/+KlLSCLhtwwVsYGbjByKR4c4DmaB1jXji6HvCjboLlOETZLjDZpbNyjUmLP/IWKWPqeVwyQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR19MB2935.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(66946007)(52536014)(55016002)(66556008)(38100700002)(66446008)(76116006)(64756008)(186003)(66476007)(786003)(54906003)(122000001)(5660300002)(53546011)(86362001)(8676002)(9686003)(71200400001)(6506007)(110136005)(478600001)(316002)(7696005)(8936002)(83380400001)(2906002)(33656002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?itbPwSMYltg7FxvXFxznGx+LjYyUSRtb8k4lynlZgGA6vA/JAxYW9IlRYfBA?=
 =?us-ascii?Q?curX3K9zU6b/w6OWdJmDlPaTFAze1ZUweq2k/6a6GMX505DcF0u+D5EfOeUG?=
 =?us-ascii?Q?GUrM/OefC5x/tw7ReOmsBC07oBdFLchz/ag+Ts8D81iRdLiy27061D7Ch11K?=
 =?us-ascii?Q?DdJ7uE7eD+69/Mt6E8QNV3xbg5zInGZQV/NH+XcRS9B/d588GVebhCrOFTvn?=
 =?us-ascii?Q?jYF1lyYngdCs6EaZYmPVykWVvxbzZc3IWdBDgFCmYTKYlrCJR3OLfDtdx239?=
 =?us-ascii?Q?JjqRvluXZXpxBcVuf4aYwYrArDloGmDXkBENxYgNxRueuOruiqC7GxrVVTJ3?=
 =?us-ascii?Q?VTfpq3cO+fFZ849H7rDrT9wjAXplzgP2BSXkNRsLZIyc0GWVxhFgs7HB2nPd?=
 =?us-ascii?Q?YXv2lHO47Ex1oEhXnast+ZSKHtg2gkpdGpq8EOV3J5aScf9zpimZB16Yu4Ex?=
 =?us-ascii?Q?eHknPvgUS08Kzy2xddpWubrh4HP2JXQzUBdOZIdve6yY9KW4n04RxgKrO+DQ?=
 =?us-ascii?Q?W2Ov/Zvhsu1fYcOZja/J/uzlaefGej4qtkliVn9xJUzTRxAkhRnpZ1tBBE1U?=
 =?us-ascii?Q?uRGawoQrPou69XS1jqqr6768snijC+FBY7QyD2ddvop2xEY6Y6c127VImgIU?=
 =?us-ascii?Q?/PhXZtSvXsZzVYKZOcWTcL96liC8liJK9DPoicvUrZIoOG9fj3DQ8M19C0KU?=
 =?us-ascii?Q?52E4+olPcaZ1QFkWGBH64PAPfFIG++WGSCTW1Zo3iIOvpwslWan9Yp7P3qc0?=
 =?us-ascii?Q?TxOGXcqAChDf6RHgqoKEiYjSCOMTcgJ2dfOUTaiWFRt89WeOPqkuqXSQisQ3?=
 =?us-ascii?Q?ivxAf6z/zQSlWZ+QKmnVL4zgnE+YKMohQc8/IwCdncfRUcdD2FKvTxLYIjZW?=
 =?us-ascii?Q?UIGspxTDnGEmK5yT2jrRF1pE6uxRU5oYc5pgXthnyLi1cyVz7bmKNp6a1Rnh?=
 =?us-ascii?Q?1w9yugwXaXuII9F8qrnL5APOSTC0pigNUroWcwnXWW9zz3a+KCi5CLDrNBNq?=
 =?us-ascii?Q?M5FyZbtSZlhb9O2Pug1YlsgtaCwaeHYjN+meAbWqIkRXQceXl8x8ZJJxv7IG?=
 =?us-ascii?Q?89eMNbl1uvZw+b8Ej0yvL+Lggv0nnWonTGprJzb8K0v69KHaXQ1gS+lqs0dh?=
 =?us-ascii?Q?m63ncjcnF074rZVV8r3S8fp0zsBmMw6x8Go2pu+NeZfldmQKmy23y0UCDxdD?=
 =?us-ascii?Q?W4LAlB0C5P/GyPNi9aWQ7oiKyIthi1JINXEFED39bJzBlI/4gcRcn2XrhBqi?=
 =?us-ascii?Q?lnqWY1fO6xUihpclu+dyLB7/Lm85F9RvWRbd9Xa1JhvReVkodyvgKiUD+PNd?=
 =?us-ascii?Q?q17tYatwm87xmTdJu1CsxeuOXAMttfkMgvZ4EdRm8E1upRKIdQNTqRu+zNZ3?=
 =?us-ascii?Q?FFS/U1Iamxolcy3KcB+b4eKAMHDn?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB2935.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00817e7b-9afc-4a90-bf07-08d930b2dff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 10:38:26.8032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqjDNffLApFpmth4W9HBWXOLzm+9R+hVVFAy2dkTNX2T9124JJABw/F++/fXIEJdDavWiIIgd3msNMm1Sj8i+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-16_07:2021-06-15,
 2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=950 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160060
X-Proofpoint-GUID: aey5YLCaqA8-RJ4FFHj-bQVDyzxqMj4B
X-Proofpoint-ORIG-GUID: aey5YLCaqA8-RJ4FFHj-bQVDyzxqMj4B
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106160060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_033844_445826_220F3448 
X-CRM114-Status: GOOD (  27.89  )
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



-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Monday, May 3, 2021 12:23 PM
To: Keith Busch
Cc: Rao, Vinay; Chaitanya Kulkarni; Belanger, Martin; Hayes, Stuart; Tarikere, Madhu; Christoph Hellwig; Martin Belanger; linux-nvme@lists.infradead.org; axboe@fb.com; sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs


[EXTERNAL EMAIL] 

On Fri, Apr 30, 2021 at 09:21:04AM -0700, Keith Busch wrote:
> On Fri, Apr 30, 2021 at 05:14:55AM +0000, Rao, Vinay wrote:
> > + Madhu
> > 
> > Hi Chaitanya,
> > 
> > Some of the AEN's like ANA state change and Name Space attribute change events are of interest outside the NVME driver. 
> > 
> > It would be good to consider these events to be propagated up to user space. I am not yet convinced on how propagating this above to user space is problematic.
> 
> The namespace attribute change event pairs with the Changed Namespace 
> List log, and reading that log will change the result for a subsequent 
> reader. User space racing with the kernel on a log access when there 
> are read side effects creates non-deterministic behavior, and that is 
> problematic.

The only way I could think of making this work is by:

forcing the RAE bit on for all log pages that the kernel cares about, and only delivering the uevent on controllers that actually do support the RAE bit (IIRC it got added in 1.3, but I'd have to check).

>> Just wanted to check if there is any plan to implement the code change of forcing the RAE bit for all log pages that the kernel cares about is taken up?  Can you please let us know what the plan is to address the problem. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

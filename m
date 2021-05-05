Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B02C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:41:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4735D613C1
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4735D613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xSOXSkRBBaItfGp65Gv3RCcMBzo3GImAWiEt+LwDYwY=; b=Mi8yEKCBgH3hj3+oNgLENdnD4
	+l3vLhNSZOXreC5C+y7TddScTtTdfgMnHrOkaRoPtULRrTkFScNjw9+B1/jJ0UvuHeRRGGztz/mdu
	DlZ9IJA5spkw9+C3qkZw29m6GsZjQp2/fzE8fuLyf8T2W0QBBYtJNaP1a6KVZk9ww5LoUokO5zTSH
	0uOe3HdiS7NIlOsBJWyzexD1YZFX74by5dBLwSaGWUf4Vx7ZB1hKLob2vXOj476Y9TXNOBDaV0biV
	NkMVV2f8vHkyXrNFMBAimQ4EfNbS/4jBNOt/kBnsXmgMFmmtuCN/fEqZvArUJohdrg84pPEC7eETk
	hzxPn6VuA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leMSQ-0024O6-RK; Wed, 05 May 2021 18:41:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leMSO-0024Nd-95
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 18:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=GV9Ve/w1oNI5jb9TLKEwkJhowBQFTyiU692Uofl9iIY=; b=RpdKkFmpPvCJsZQhPlbTXbopIF
 d2PnvK8RkEvlkfjKBZYXmi/87ujYea3JxEkRXT7fT/gX3pse1mf2pjWYly/AucPvp6yiVwIllEJKl
 M6K9W1RAxDinjxINKOPxoXrKVLx3D5JTFTQMO48OpT2qH1JlF7Hy67tBbyCZBP7v6166X2ejpGIjD
 +qZIrJERWjc/TwEM2ybY5Q0/eU0XaK/lckav9fWnCVLw3Oi/GkUVaWKDe/V1E+tUNYTRzE8xi+DkW
 BLqwRAWKrUpd02xfXY8XH95gIjpBOWw/2FPuvKnDAzLYiMVaTV8zwHrxqu1SAObJMBBbZXpVJhhjT
 7Sqd5TSg==;
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leMSK-0059mW-MJ
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 18:41:10 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145IXurP033133;
 Wed, 5 May 2021 18:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GV9Ve/w1oNI5jb9TLKEwkJhowBQFTyiU692Uofl9iIY=;
 b=0ERK9OlNImDhWOjuEongvHr7Tk2kLBJVVumvH/gk6WPW9WLoboswxCW523u9cq3i21ZO
 U31fbuhW70YjjeKNF1+33QTo4k2v5pWojM0f/Ieu+vmnsnWD1lf7u0IB6PR3NC+H9BV5
 sBblio42iMCzpBOnGhubjpIQNEgY9+aK/O34CVYkXECJy55Sd7ri717VMFmhD8LU/dBw
 P2Z6+2nVC4b9ZAzOrg/3R09mTuCaia/AMuo9vasy3Waxf10ZYhQlNGam2WbFctfa8qdz
 GFkWx9KwB/1Z9poAr6ceIpgdpsJmLZ1UvXRrKFT6DF6eL8RaACvgx1iu8FIm8qfC28Re Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 38beetjte6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 May 2021 18:40:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145IZRPY166982;
 Wed, 5 May 2021 18:40:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by aserp3030.oracle.com with ESMTP id 38bewr6euc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 May 2021 18:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTU7DnGsf+UIBAKJTzscE/lrS53ciRkKIxeV0vXv1FULfuVSz+6JcmwyyxPDneMn/aUW2QACy9AR4ZGDDfQhWKI/YweoxXc3PvOOCTBiM/ESxGFAsRJuGiCjutofbE3SMDEP4pZ3g86XttJ5Ru5lQuY98E9ayerUGY4wiACIn2Z35su/j/wzTYfMVWu87XOHBTROM7rt/HI7tZ1jZn6vhAnmIzp58Amd8o+8MH4quIObtl0vxlVpZ16uEVEvrK/HF9L0NXpO1d+oEudB/LKSGR4v7JMVHEUF7f2Ga5DuVJVyHjgZQeAPLalpGuSCZhyLMlgKWA5bwPm5nUFqMrfnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV9Ve/w1oNI5jb9TLKEwkJhowBQFTyiU692Uofl9iIY=;
 b=GAv21sdOF0ACZT8y0hw2sesuZn1xgC0xWhhkt8hM6z1K+XESLPsSQP6XquXgbYa5oasnIZDQQll4+1jQWQrHwNHgG2wZAaL7o/M6t6gU/rEPyyd+FiIsq5zJnndKFpEKdgy84dFcHQE/O9CF2X4rCFba0lHHIY14Pvd/vZGPdOZjvENJdXV+VDgKCSSkPX+kHzFLhNbieS4B+Iq/Fwl1InEUcTE86IcBvAxUKfQmF45SKtFocmv3b+bkXol1R79S/8PnFqdzcV46x59NJOU4PQ7c7BjVMgp2aA0iXn7oU3R5vLQ0mTcaQjOfMyAPfQvwtfO2AbE0uEEUHHsPpY18Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV9Ve/w1oNI5jb9TLKEwkJhowBQFTyiU692Uofl9iIY=;
 b=LlAgHtjs9pVmvJNk6FcO9zPezUXiV8VC3UqNeU9lf8YwYKtE9oZdYt6MpVGA9Sh5oykzMdiB+EfkxgD2qDgdqktjZUJD/uDJAaoESq8D9dsDc43MCa+cFBiNwBHO4HDokK7Hv7ljUlvFoWGUoGwtzx8PidJ3Yiyd8imYJUcBPPs=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 18:40:54 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::5863:301d:619f:97c1]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::5863:301d:619f:97c1%6]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 18:40:54 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG26dbipyKKgQXUmKwfMgG9mkE6qJKjcAgADGWgCAAAaogIAAHgKAgAASy4CAALnSAIAAjooAgAACPQCAAB8UAIAAAnSAgEnxVwA=
Date: Wed, 5 May 2021 18:40:54 +0000
Message-ID: <023A7AD6-3606-4C3A-8D16-5E65A55551F0@oracle.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
 <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
 <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [75.80.184.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e12f7ac4-be04-451f-aace-08d90ff550e3
x-ms-traffictypediagnostic: SJ0PR10MB4416:
x-microsoft-antispam-prvs: <SJ0PR10MB4416703429E6E84B3424EF32F4599@SJ0PR10MB4416.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3467M31T8fBCUjOSXA86p7hy2m4mhlSKHbG3TAUTcC15s2tKRAvyABS3BTUdNPcyilaHntsUnP+3A2AuFqKMcJiW+Z3WYN1bdtZe6BMy280XcCttZvqDBKRoEgZ0+rAAQ3Ena9OrH5SvNmo5Aqw6hvbISUfjXzJZ0P0nxD/lqvksL0N14CYYJ6d5BhiDwm7iM43umNyiTfTs2x/c4W8gX6gJ/RNwf1t8xsBwZyASIhM6OFKrhOFTUY/EjpL4YLoBBWDEUiY3nA7vz51suwri/pANyHLCy/ZMkXznciHIFtYDqE2Eruse69UzIYUgCKQhDiz5fByWUhYBzyOHLvfbjZOkrhJ5+ygFWIi3bjPuOs2/3Cr8uAEV3ywGbqb8sXEovIr8LoTpXwm10A0qLZ45DOMisiBQWBQQlUxzKC9d9/7V2EUWUygJ9rLF1uPeEX3QwrdsEgeGAw0se9nibYOeCByGuu5/2j9s1nEdJVADDJoqQdYQZz4mwcoR3nGvlN6pA9wCgwg1WaGnrSIenhNVcByGwVQfUckUucFY96gk8iB+LtqhAbu+UQT8EoOGoTvV5J/umNsXGLTVxtrZFDiSbxeG6/269eAls84g2HsHlk5gJ+EFOLEZFsjHrUJB8R/f2Fom4midmpHTaQbFbp+tfwNkUJWT+H5JBwesNS4TfFg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(44832011)(83380400001)(186003)(6506007)(36756003)(5660300002)(26005)(71200400001)(6916009)(2906002)(66946007)(4326008)(8676002)(53546011)(86362001)(122000001)(38100700002)(316002)(8936002)(6486002)(66476007)(66556008)(54906003)(64756008)(6512007)(76116006)(66446008)(2616005)(478600001)(33656002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZnRUd1NVSHlPSC9qT0p4bCtFalhLdTQ0QlRndFJaenFaMWw0STZRV210WjlL?=
 =?utf-8?B?R0lxZi9pSlJQS0dXajJEZDhOQU95cEcrdWsvSCt2RktENjRWUWo1blJHeHhU?=
 =?utf-8?B?a2s4YlRTYUtRZDVZUDBBWXdYN04yOTBvYW9TRWgxOFRxZVJTU2MzTHVZeCtF?=
 =?utf-8?B?SFNCVTFSa0NEdjlrLzIzY0F1ek5NTkJ0NlM2ODMxSTFJTkU0KzJjMVIra3Ew?=
 =?utf-8?B?bU1YSVJYZzFyeHhYUVI4R21GZ2hiblRZMUZiMHpDRnhpT0M3V1VsMnpjTndU?=
 =?utf-8?B?aE5tWDQ3NjltMkFWZklyaTdxUXFoWVR6ZWFVSW14bXNmNHZ2UWQ4MThQQVAw?=
 =?utf-8?B?aFRhMDVFNFhhWk9YZ0hlSkNFVEJndy9zL3JNVDJVSG9hREp1cHAwemtUZkNa?=
 =?utf-8?B?bDhOY2NCYmx5c2xyNjR6TW45TllFZ3Q0bFFBS2pEUTNqNjBYcnUycEhRLzVi?=
 =?utf-8?B?QU84cXN4WE9Tdk83bjNJbmI1Z3VBelRsVkV3RnR2OGFndFVoLzFSTkJ2WGk0?=
 =?utf-8?B?c1RUazRzazYxQjRQMklyMXZ0TTMzVmxXVG0velNiaGxQWUVNL2RjL2hjRkRz?=
 =?utf-8?B?VW1Pb0RFeUcyMnM0dmFmTTZNWHpYQlYvQVFLTzlob0V4U1IxVFFFV1FxeG9x?=
 =?utf-8?B?cVZPVlZ4dTZLU1NYbFA0V0svNklJTFhoVGo4bzBIS0ZvRGNnY1RhUVVJYnpR?=
 =?utf-8?B?QmR3dHczOExkc2ViYWZUWEFwL1pZL09OaVBOc1NLZG1DQkhRUytlbWdqMFlO?=
 =?utf-8?B?ZTlLaWcrbDJPekNuaG5XbGxKT20zRHNCSEM5Q1RKQVZJMy84R2JTMDUwc0xE?=
 =?utf-8?B?NG1lZFRoNUlQeVBXNGFlejRDZTlqTXh4bWdkZTMwUWE2YXZzY01YNDVwNGhX?=
 =?utf-8?B?d1MzTDR0eFVIcFdOZlI3Wi9KY2Q4Ylh6bXd2K3I1eWgxeCtQTSthVWViM3Er?=
 =?utf-8?B?bjNpRnViWHludlo3SkNUTXJta2t0OFV3aUwwRllubzF0QUcwUW1uWVJTaFVO?=
 =?utf-8?B?dUhSMS9rYkpNOGVpajN3Ny9CQ3pHUld4c3EwNVZVdmVHWFRsdU9ZM3hWZEgv?=
 =?utf-8?B?WDJLOTBtL2hRamJ5NUtjSXNzNWRac3JIdm55T2VyRVZFRlRoSlc1SDZlZ0dZ?=
 =?utf-8?B?OCttdkFVVEY0VTZ0VXg3eVpUT010a2NSaUM4V1hhdUZMZmVqWmRkdmJBTmMx?=
 =?utf-8?B?TzJhM1laclFRMXhFM3ZxVXB1a3pmZS84ejNPbXNOcWJwcG5veXNsTmNHZ0NJ?=
 =?utf-8?B?WG5yVmR4UjJteGl2NXRGbUR1YW9WY21GRyt5MkFtc2t4dHpJTE5nM3hCRjdJ?=
 =?utf-8?B?YXFLWW9MTXFaWGFCdUJBTWF4YW1ZM2ZoSk1lYUZGbXFLelNSUTIyZDVkWEoy?=
 =?utf-8?B?STRBN01oSWRrd0FCRlozZDZoQzE1aTdsRGZSSTNKazJYUkRVUUJQUVNCZ2k0?=
 =?utf-8?B?Qmt1N3pWM2hGbnU1MFJpWE1mTWRZRlAxcndvVDRvZG8yVjZEeUJXamliZVRX?=
 =?utf-8?B?Y2taaksvc2x3eElacmxyREt1ZGkwOEFDZy9QV3JVSGt6YzcwbFdlYVN5T2VT?=
 =?utf-8?B?QThZSUE5ZnFabFVwZ2dtZ0tKejhpeDRWd1hPenhsWHRWVEdraU1veFN5c1J5?=
 =?utf-8?B?STl0RTFjK3RuS0FhdHVOUzF4SW5wc0FwUG9TN2VxVkhoYXlVNzl0KzZsMzFS?=
 =?utf-8?B?Nzl5S004SCtIbDU2ZjhWVFFrOWtGQ2NFQXJ1ejVoT2hpN3g1Rnowa1c1Qndp?=
 =?utf-8?Q?wmLClCGGmrX3rlXar0hoCd7QwZbeFJhqT9ABO4t?=
x-ms-exchange-transport-forked: True
Content-ID: <7204CC8B4696D44DA4C358DDE58FC4B0@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12f7ac4-be04-451f-aace-08d90ff550e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 18:40:54.7629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: re5VLRbhTiOiRyrYrre/IeBEVkIe4rMYeIUmu7dgcQ0/Nc4LQ/LfLA8V5B/RT+hY4LuiLbreLWmezUwADquegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050129
X-Proofpoint-GUID: 1F7Z2Cwmq9EfjtTxo3ugG-CWxoeJS3Cy
X-Proofpoint-ORIG-GUID: 1F7Z2Cwmq9EfjtTxo3ugG-CWxoeJS3Cy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_114108_945712_9AED3F13 
X-CRM114-Status: GOOD (  30.17  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

UmVzZW5kaW5nIHRoaXMgZHVlIHRvIHNvbWUgZm9ybWF0dGluZyBpc3N1ZXMuDQoNCk5lZWQgdG8g
cmV2aXNpdCB0aGlzIGlzc3VlIGFnYWluLiAgSW4gdGhlIG9yaWdpbmFsIGNhc2Ugd2UgbmVlZGVk
IHRvIGdldCBhY2Nlc3MgdG8gdGhlIGNzdHMgcmVnaXN0ZXIuIFdlIHdlcmUgYWJsZSB0byBtb3Zl
IHRvIHVzaW5nIHRoZSDigJlzdGF0ZeKAmSBzeXNmcyBhdHRyaWJ1dGUuDQoNCldlIGFyZSBub3cg
Z2V0dGluZyBhIHNpbWlsYXIgcmVxdWVzdCBmcm9tIG91ciBtYW51ZmFjdHVyaW5nIHRlYW0uIFRo
ZXkgYXJlIHVzaW5nIG52bWUtY2xpIHNob3ctcmVncyB0byBhc3Npc3QgZGVidWcuIFRoZSDigJlz
dGF0ZeKAmSBhdHRyaWJ1dGUgaXMgbm90IHN1ZmZpY2llbnQgYW5kIHRoZXkgd2FudCB0byB1c2Ug
dGhlIHByb2R1Y3Rpb24gdmVyc2lvbiBvZiB0aGUga2VybmVsICh3aGljaCBlbmFibGVzIENPTkZJ
R19JT19TVFJJQ1RfREVWTUVNKSByYXRoZXIgdGhhbiBhIHNwZWNpYWwga2VybmVsLiBJZGVhbGx5
LCB3ZSB3b3VsZCB3YW50IG52bWUtY2xpIHNob3ctcmVncyB0byB3b3JrIHdoZXRoZXIgb3Igbm90
IENPTkZJR19JT19TVFJJQ1RfREVWTUVNIGlzIGNvbmZpZ3VyZWQuIE90aGVyIHRoYW4gZXhwb3J0
aW5nIHRoZSByZWdpc3RlcnMgdGhydSBzeXNmcyBhdHRyaWJ1dGVzLCBpcyB0aGVyZSBhbnkgb3Ro
ZXIgbWVjaGFuaXNtIHRvIGdldCBzaG93LXJlZ3MgdGhlIGRhdGEgaXQgbmVlZHM/DQoNCkFsYW4g
DQoNCj4gT24gTWFyIDE5LCAyMDIxLCBhdCAxMDozMCBBTSwgS2VpdGggQnVzY2ggPGtidXNjaEBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDA1OjIxOjIy
UE0gKzAwMDAsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gTWFyIDE5LCAy
MDIxLCBhdCA4OjMwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6DQo+
Pj4gDQo+Pj4gT24gU2F0LCBNYXIgMjAsIDIwMjEgYXQgMTI6MjI6MDhBTSArMDkwMCwgS2VpdGgg
QnVzY2ggd3JvdGU6DQo+Pj4+PiBJIHRoaW5rIHRoaXMgaXMgYSBob3JyaWJsZSBpZGVhLiAgVXNl
cnNwYWNlIGhhcyBubyBidXNpbmVzcyB0b3VjaGluZw0KPj4+Pj4gcmVnaXN0ZXJzIGV2ZW4gcmVh
ZC1vbmx5LiAgTU1JTyByZWFkcyBjYW4gaGF2ZSBzaWRlIGVmZmVjdHMgYXMgd2VsbCwNCj4+Pj4+
IGludGVudGlvbmFsIG9yIHVuaW50ZW50aW9uYWwsIGFuZCB3ZSBhbHNvIG9wZW4gdXAgYSB3aG9s
ZSBjYW4gb2Ygd29ybXMNCj4+Pj4+IG9mIG1pc21hdGNoZWQgbWVtb3J5IGF0dHJpYnV0ZXMuDQo+
Pj4+IA0KPj4+PiBJIHdhcyB0aGlua2luZyB0aGUgZHJpdmVyIHdvdWxkbid0IG9wdC1pbiBpZiB0
aGVyZSB3ZXJlIHJlYWQgc2lkZQ0KPj4+PiBlZmZlY3RzLCBidXQgeWVhaCwgaXQncyB0b28gZnJh
Z2lsZS4gSSB3aXRoZHJhdyB0aGUgc3VnZ2VzdGlvbi4NCj4+PiANCj4+PiBJJ2Qgc3RpbGwgbGlr
ZSB0byB1bmRlcnN0YW5kIHdoYXQgdmFsdWVzIGluIENTVFMgQWxhbiBjYXJlcyBhYm91dC4gIEkN
Cj4+PiBkb24ndCB0aGluayBqdXN0IGR1bXBpbmcgYSByZWdpc3RlciB3aXRoIHNvbWV3aGF0IGF3
a3dhcmQgZW5jb2RpbmdzDQo+Pj4gaXMgYSBnb29kIGlkZWEuDQo+PiANCj4+IFByaW1hcmlseSBS
ZWFkeSBhbmQgRmFpbGVkLiBJ4oCZbSByZWFjaGluZyBvdXQgdG8gdGhlIHJlcXVlc3RpbmcgdGVh
bSB0byBzZWUgaWYgdGhlIOKAmXN0YXRl4oCZIGF0dHJpYnV0ZSBpcyBzdWZmaWNpZW50Lg0KPj4g
DQo+PiBCYWNrIHRvIG52bWUtY2xpIHNob3ctcmVncywgZG8gd2UganVzdCBleHBlY3QgdGhpcyB0
byBhbHdheXMgZmFpbCBub3cgb3VyIHNob3VsZCB3ZSBiZSByZXR1cm5pbmcgZ29vZA0KPj4gdmFs
dWVzPw0KPiANCj4gRm9yIFBDSWUsIHRoYXQgc2hlbGwgY29tbWFuZCByZXR1cm5zIGdvb2QgdmFs
dWVzIG9ubHkgaWYgdGhlIGtlcm5lbA0KPiB3YXNuJ3QgY29tcGlsZWQgd2l0aCBDT05GSUdfSU9f
U1RSSUNUX0RFVk1FTS4gSWYgdGhlIGtlcm5lbCB3YXMgY29tcGlsZWQNCj4gd2l0aCB0aGF0IG9w
dGlvbiAobW9zdCBhcmUpLCB1c2VyIHNwYWNlIHdpbGwgbm90IGJlIGFibGUgdG8gYWNjZXNzIHRo
ZQ0KPiB2YWx1ZXMuDQo+IA0KPiBGYWJyaWNzIHNob3VsZCBhbHdheXMgd29yaywgdGhvdWdoLCBi
ZWNhdXNlIHdlIHJldHJpZXZlIENTVFMgdGhyb3VnaCBhbg0KPiBhZG1pbiBjb21tYW5kIHJhdGhl
ciB0aGFuIG1lbW9yeSBtYXBwZWQgSU8uDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK

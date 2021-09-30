Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B689C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 09:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565CB61278
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 09:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 565CB61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oXsFmOrfhwKF4aguavJotOVv/LUcfZEZT+cxnhn9oik=; b=iRbVKls7UZ1IDu
	yp23O2qa4o+WPNbw53Q++itOeGlP+A5nOyh4Aqv/red/4jxX5076FyIP0/DoLZc8SejuuIP43VyLs
	GX9q/VsaZ/vyNzyeP1ERANnHn5+3AZRZA0OvKuO/SwuhoUA0EAfFcLs9GK5IKLIXeo7R9RjFlzkn6
	Qf8EKIFu4YrfqoSoX/iFxYnR5hKEPh5YYIzb+i9EcP7+HdUjjM29Y6EtYa0sE10jrsA7yIXwT+TEM
	RRaRnE5tBsc3sZGjSIjprAaXBEscsv5bdn/GfsW8ESMsIpZvxIfLOfNbKbKRA2AQLP4UHIgsYxx8D
	qVjMI0ySypvsyMKS7L8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVsPj-00DZl9-P8; Thu, 30 Sep 2021 09:31:39 +0000
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com
 ([40.107.94.84] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVsPg-00DZjg-Jw
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 09:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNcWYhZBTOTnwmYvm1k8MHtOs4y/WQvlu9+y4/I97hI3FWw1UOJfCox/5AnQ1t6leEWLNRjhR4iShAdOCDCDsF4p0SQIIgT6300lIsZ7TKYB9Vg94edTtBFqxsC4tROIHfCEEG64qHiRB2HUynAfgLpTQWNEuPuBy8sgO0xqOBvJeBqsQkUmTGh/TLnhjeZrtoWjsxfVHUr3E6L4SIMJ1zwOR8u/3BhbNe6HK6Ah6hPKuBomKGGFfDQ3p4l09Yno1/8cidOqDGA7I3s/omn8ZkCpp0CaM5Sx6VVzTCeuLMjKOvrUkfZmwjBYdf9M8oOw5xbLk6oclhsiopP0VnKxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=R6QIjoEecWmJf5dc5qgE9d9gVrv+hDLFF0SG7cgBxnY=;
 b=aXcxuI0xTxev4wvO1zfVxU0lNllhl5EiIP4O/Nsf2FT1awI9F39n07mDgtDZI4SxoC7BVEL0Wug0BaxSs47OfF9sPPAYgG2OdYjnkNyhFeHPA9mQ+ALUlq7o0phzTy/D0TLB+BNScd9/XcDPxinnhdvvA/1KglGfFXcV6klOdzJ9CUNm3iFfn1haLINYt+nqwPIpt+z5WEgko87w3B1JhEDS2pDny9LKz7Yb/md1W0PrVufdF3Dgkyq2YBZW9o2Ikl24/Uo8SU4oRnjNqsoKvdGEfiwOlgWRj6/6q2eRHglQ/9jEm3KcjlCDa7SabMWF3dNwdp/FxUKj16aGe3npnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6QIjoEecWmJf5dc5qgE9d9gVrv+hDLFF0SG7cgBxnY=;
 b=sizS2ulD1TIlL9y67mFrQT+dPBGELKo4ApzfdxY9Xi6UQJbZXGt++HMSypLlzI3+0yUuUsaZ2ND2vXtpOc5gxcvbkqrGCXBoxw1dvVAAPx1Zy+ssBvTLPOnoqK+xNzIE3qsyURi7ok7bcBM0v+hMYCXA1IM7CHQwnpxrscSstzGBH71myfnp+qluY8FmKWSAqBdzcGNu85A+FVk6p9QjK8U38Z0csDtZXv2X15wuRY9nUIz9AJdpnhQADd5iblI8QJXXxdHO49f19tvpsP0eaRwcGR9OvseDbBqnaDKe8vgruFvzPRKi7kElUwkR+eGOKKtAdVKJndPX2G4lWqoY3Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1888.namprd12.prod.outlook.com (2603:10b6:300:112::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Thu, 30 Sep
 2021 09:31:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 09:31:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Topic: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Index: AQHXtcC9fdM+ebBBsEqJOm6MgbwFyau8JKmAgAAFJICAACacAA==
Date: Thu, 30 Sep 2021 09:31:34 +0000
Message-ID: <275d9ed4-597b-0c65-e22a-de7ee123f8aa@nvidia.com>
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
In-Reply-To: <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 137f5588-1ce7-488c-6456-08d983f51825
x-ms-traffictypediagnostic: MWHPR12MB1888:
x-microsoft-antispam-prvs: <MWHPR12MB1888191436142070ED44B11AA3AA9@MWHPR12MB1888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKY98Nc+/Edtsfeul2za/Ggd5em1+/eJ2Rz0GW2IsyktdxS2CHsoUL0qnjDinSoyqgABwllhsHEL3zxwSYoibuHZzmFzjqn3K9jdmmJamRd5miYv279B6LGPuxWK+gfwGYHSRIl8j86krELVYw4/eYu19c/128ZOfCeBlKJvF8aFA2ER6w7AYnIvy8Y4JbQRHol6k5C/tWfXZRV5nVA0Pz5XDjR9jvZevC5ZgQNG4N5U8OQ/5pYBojQWU0jTQySEA7Kop+IbcTN5FwndHiVobffZQIY1sAg4d5FIpC422omQstGJzRrkUX1g1UD/zzRNEarQsIdsZ+nn5GDO32GIJPrXnf5uKrprZu4Amc7OWRSfqVyQEEZP920BXNjeixXOpBkaFKnVjRu8bQSc/zUxHKnBnzG4CM+wA+BqTK+VDiFwY8opOfdcKQT/5YjYpzMmGP77waeqKo5n26y/hXVqy9VpQCcev7eTbPSM0T89pTr1Z9hwbOcvE9sAE1BKBnL6uUKETofoPe+eo2nPxUkYTE/e8Nj4iw+devIkfQYLaQQJoxMnOREqfU7mmBXSB4jyUjo6VUYyOJNRyhokc2qRdtHRI86bxLuJBqzAQVo6VwnMzRWxrR6rQeAuZ2sA/D0pGhppOuq7RLH1bOt3RRyGi93GNAq3xJitNK0kZkouvjvVmSJe/uBAjYsJv9eGOgxKIgNxbWRxIBIoyWgSzvZDQpTR+STxdlL3wy4O4z34FZnPMSlEe1ubR4+2pTlcsh/Jfz5G8lwN1EQe8y6ijT62yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(508600001)(6506007)(4326008)(4744005)(5660300002)(6916009)(122000001)(38100700002)(31686004)(86362001)(186003)(2616005)(64756008)(66446008)(66946007)(66556008)(71200400001)(6512007)(2906002)(76116006)(66476007)(91956017)(38070700005)(31696002)(8936002)(316002)(36756003)(6486002)(8676002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVUzVDEvSjJMMmlPc3hQK2lUZmp4WjQ1a0plekRNc3JndlZOUC9FNEwwODBr?=
 =?utf-8?B?U01hQTJuSDVjV1kxUWQ5MzlSWnJGRjhlWHkxQjk0UkYwaGhNVlFLOHUzV09S?=
 =?utf-8?B?dUN0aEFNbVNaQUFwTUxVbHNFM2dsWGVYSGVEQTJFQVM5cnVnZVRsNys1T0Vo?=
 =?utf-8?B?SjBJMldXYThuRytJVDM4YkFOY1VRYjlzRDVkT2l5cVVHbGIyQ2dnN1dLZVJ4?=
 =?utf-8?B?QUk0cGs5Y3h5bkVvd2hPNUJVZE9VMjBaYnd6WEV4L0thNlNhOGQxVERoWXlD?=
 =?utf-8?B?dmdUZngrN1ZXVEJRWkl0UGV1SzVxdjlSTlVydlgrS1dGbGRjQTZDY2RoQW9Y?=
 =?utf-8?B?b2JpZGliWGI4YmNTQXhFbGVHbi84anlmUmRRbWZMYjh2VTBVclJlVytYbE5y?=
 =?utf-8?B?VzFEd29ZcVFIYkwvcU1KQ1hiOHQwVGNXS1E0VWhmdnh4ZmRhN0luM1V3aGdL?=
 =?utf-8?B?a1g4RVFLMjh5dkFsRTdmOVhFZEE3QjN1QjJHc0RDOUdyOTVTWm5FU29Fa21Q?=
 =?utf-8?B?aytNTnIyQTdJampLQVF4VmxvR0dmYXJGOStLVFY2S3hnTU1kRGxkMHUvR3lG?=
 =?utf-8?B?RjR5Q3JneTVBRmtXbWN3WnMxTjhxNG5uZmpJb2NMNmh2T3FOczFVQVlFek0y?=
 =?utf-8?B?dGk2QXJtYWoyMGlZdnB5QU1QbEdqQmtncEMwazJpMnZGekwxd0FuejdBNjZG?=
 =?utf-8?B?cGVxT1NzV3g4ME5Tb3lRRUtEMDAyTWZvdnpGdTJYMHlEWGQ3SXRYSFZ0MVF0?=
 =?utf-8?B?UWpFcGRrTmNUOVh1b284RHNHWXhtZXk1Z016M1dEMzVhMWZkeDdxeTlucHV5?=
 =?utf-8?B?TzZhL0RrYUROL2hYalRDMGRWSTdlQVF4aWFlZk9EZHV6aU00dDJsQjE2S1hu?=
 =?utf-8?B?RmtUdjdZN1FtbXlhS1dsb1dlaUFSYzI5a1BPTm1kNGV3cjA4bXEydURLeG5r?=
 =?utf-8?B?OFphSFE0TmtjRThQa2NQaWwzZmtkT1dGT3QyLzZURGdYdnJQdHUybklKR0Uy?=
 =?utf-8?B?S1dQQmV5RUozRzdVYUpQNmJnR3JmeWI2WGNtVkFOTTFIdzVkc0ZUa3lhZThC?=
 =?utf-8?B?VVZCSGtuTHRUWUV1TDRPbmpFZUNDeHVzdmxtMkd6QU9obGNDamFROTIvV1dh?=
 =?utf-8?B?aytlckZWbk05cDZ6eXhydDlDMVVHK1lZUk80R01tckNkNHJsS1dhM244SW5D?=
 =?utf-8?B?UmJKQzJpOG1acm1yYTdBbFYwUGI4SHk3dGxVanJsSTZtMkg5SVhXdjRqUWFx?=
 =?utf-8?B?NU1PRTl4YUgwMk45aEptSWx3SmVQQXJUbTJ2MkRycDVIcHJpSUFOZFRrcngz?=
 =?utf-8?B?dEt4c1RsY1Z2MFM4Tm9oWUFzZ0xKR2Zjam4ramFsWDNUcWI5TFY0L2MzZGIv?=
 =?utf-8?B?YUhXMDRBUmN4bGE5ZEVyR0dSNXVZQVJ3aUp3Ri9HV3NaejgwRjh6MDVuSkJG?=
 =?utf-8?B?YU5ROHRtWkRBMHJyZnVsUGZ4ZGpSaHN1bUp5bTVGV2hud0tST0ZOVGR2Q2U1?=
 =?utf-8?B?cjQzZnkzSkUzVmxSN21JTEZaeFluejRrREIvWnptcldEY1RjY3V4a01JY1pv?=
 =?utf-8?B?SVNsSE9OYjJsaG9MazZVNEx4UXRNNWZIMmk3TUN2aVpWQVl4dUdsajB5V3F2?=
 =?utf-8?B?L1VoMHRSVmJLS1JFbytGQUphd2JZU1lmeStXSmdhZUFmVVM4SVdNM1cvMWlt?=
 =?utf-8?B?dmlhUDlYelUzbktqaExJcENvcWN3ekJza1NSV0QrZ0hDWGFnbTNUcEpTaWRU?=
 =?utf-8?Q?GzkUDFEaTE/B5tIWqc=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <AE5E29FAE22798448BF94040B4F48E49@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137f5588-1ce7-488c-6456-08d983f51825
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 09:31:34.4426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXElnRvrWkA0GCCO4HZD0wjqqgfX2eWxoKn+KQKzHZGE8BzZVLXKldV/ij7zLMGe53thPwVRL098+lKES85LMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1888
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_023136_695158_8FA3D442 
X-CRM114-Status: GOOD (  12.56  )
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

On 9/30/2021 12:13 AM, Yi Zhang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Sep 30, 2021 at 3:04 PM Chaitanya Kulkarni
> <chaitanyak@nvidia.com> wrote:
>>
>> On 9/29/21 10:59 PM, Yi Zhang wrote:
>>> Hello
>>>
>>> Below kmemleak was triggered with blktests nvme-tcp on latest
>>> 5.15.0-rc3, pls check it.
>>>
>>
>> Please share the test number and the frequency to reproduce this...
>>
> 
> Hi
> I'm running the full blktests nvme-tcp[1] and it's 100% reproduced.
> 
> [1]
> # nvme_trtype=tcp ./check nvme/
> 

It will run all the tests under nvme/,
without knowing which testcases is causing the problem it will be hard 
to help you...


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

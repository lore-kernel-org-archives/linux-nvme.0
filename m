Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64739C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 18:39:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AAC64EC0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 18:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AAC64EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cdj/tfIgJJ7G2DfXsMqulUD6wTm164yjpo1HgjDQRKA=; b=H7cpSWS43JUCGnoSq/FVZBs/zM
	DIDEm5yEXD3+lPGC1Ah7H0pRNLWeUYfBWPJa33R949P4GOOmfzdeiF5GRkEEjSLXPGQpubaqxjuNG
	ZxpVewU80ohIgTViamZpw8sZYxPhFeW0haQ2SiwONSmGG5FoIG9Micm0OxntarMMXWzoQhix+URJt
	aSfKwfov8s1m81ZZt12qORoN1QUrsUqfpVERL3kwVTj1Q33RQnCQ8TCAnPmKlXOa40upyEcLhwZvh
	b+CK1CKTwOfYCi4TbmrfVHPKPLamXuAQo2SuJHfBQQJVRK6eZV2TutP69YCktcO3qUIvYuQgP5UJj
	f/qiKl+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCoCB-0007zi-V9; Thu, 18 Feb 2021 18:38:36 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCoC8-0007xt-5B
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 18:38:33 +0000
IronPort-SDR: 0cu/mfhFJ8lffzojvBobv9fWWEMOTgGxgtG5ElktqCfKpFoLYvnukQFPz9Supsl+shBxZxG6QI
 tqgSywteiK+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162754204"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="162754204"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 10:38:27 -0800
IronPort-SDR: 0pLr5f8kCShOjSdXSktxRBLYegssYd2qzIp8URNUHUwerBv+Ke6QmRqLCuBV7AwPynH4Nc2N7D
 YyNVt/WO4DMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="495682804"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2021 10:38:27 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 10:38:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 10:38:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Feb 2021 10:38:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Feb 2021 10:38:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHgz4PXySe+0OojsFMZbmC1bzMUp676vIDeRr/sTEkk5vHyAq2f/C1i5VarX2zEz2lybEe1PYj8Sp0VodjWC92nwVg+jvnBfGoqF3a1fYC/hZxlAooTJiRpvtbG8WpAG78ifDRq2LHd/KqGiKuxXqig0wqFX5BviG6lf6t19FNA/wCZZW8xsopaIcTBMg930p/9AGwF1Wcs1tB2cd928/CTAY8t7xcJTqdZG+4Z+pVhj5y8BCgX17m+8gkob/C5Y0/j9iACIgrs2ArDJqUsPSiTHbdYkmakokxTuycQIYCqEk0iyzfp+LuavLgsWsPUmD6coJbmVydOp6srcldTNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X07JhO8x6HVqlNy6of5TiHYM4hZ5Cl5L2R13rVTSE08=;
 b=UHfvBMpVZ5o/MsATjfXKvJg7ATQUbF8DiJi5zXQnSqIzbXr+wCDnNBrLgKQ6aKU0gSg05vgi+k5cKGHvR4iyZMXsIAWoMnlufvEVcRyoX4Wxipdgfp5eLdVNlNgdOlneJI6EsCwIQmyhfW5yTHQH3QTzJC1tFb2r2N6Zw8zIBDLErhxPyrl33icrUoPw1Lf1pFkV70nog8ZMuwuldnu0CVQiIIalRvSawx0784uoFnc7PsdY58tG4c7WjW+YUcIoByjJEUVLXXTx28ygxrC8H6oRniAP6ntM1Lv+UtSXXRWlhqvmZnBPaQX9YiDG7Z30S9HNKaiqnSf3dMff0ir74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X07JhO8x6HVqlNy6of5TiHYM4hZ5Cl5L2R13rVTSE08=;
 b=NTSFkl0TP1FECsIZ8b6kFgbJGUMbRcIhbBPAlrqbzs4cAUrSgZnxizm8zff/GPnPjS3F2TRJlBlECyfXa5s+Ul/hIOb/ypBKxQ5JJjDuibUqBU734UsFrlpoALYBhnzYfdAo378cltrWAMDmHd6cqP5VVBgB3g2pxsY64I+G6MI=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BY5PR11MB4212.namprd11.prod.outlook.com (2603:10b6:a03:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 18:38:25 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::ec7d:c69c:7718:9e82]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::ec7d:c69c:7718:9e82%7]) with mapi id 15.20.3846.035; Thu, 18 Feb 2021
 18:38:25 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet-tcp: enable optional queue idle period tracking
Thread-Topic: [PATCH] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: AdcAzwvEySZF244WSSimWeKKHvq25QDEQgCAAI1KICA=
Date: Thu, 18 Feb 2021 18:38:25 +0000
Message-ID: <BYAPR11MB28691FA273E729AF338745B7E5859@BYAPR11MB2869.namprd11.prod.outlook.com>
References: <BYAPR11MB286909CAA3A8721B46A02AFFE58C9@BYAPR11MB2869.namprd11.prod.outlook.com>
 <25dfb6d2-2519-0f30-529f-36dcb4263160@grimberg.me>
In-Reply-To: <25dfb6d2-2519-0f30-529f-36dcb4263160@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=intel.com;
x-originating-ip: [67.171.162.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd0d6648-3fb5-4959-ac8d-08d8d43c6085
x-ms-traffictypediagnostic: BY5PR11MB4212:
x-microsoft-antispam-prvs: <BY5PR11MB4212351ED0FDE5D17A3D7BBFE5859@BY5PR11MB4212.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WhYvkhd7CuRpB4VLFVr2ue3kQJp67v/lo9i+sjlKmezGesTDf/kzXtkUPeKKB6+8LxhoiMmsjzIuk28dmvtpeAyICcW9R+Rh1/sIc3u+bLlg3JlMjV9/FycPLovdHux/QScCgRM4jUXiMzcc+545+eb1uZqCl0NJ7sy2EAxvmyNW7XIhDiGJROxl6eZgMe6FarYrPFLmxs5ClT61yba/DgQByCiVm7Z7GUjmbcxILJqt1T9Nbtb+pdlFd4iOXj96a3oiusaw35ay7p9SSdSFXe2Gstb9cyDbCe3gC2kRwm0VpkYS5hnUEJGLrxDQ0wQg0+pcNz79EL1SnkofoPATLGIMo8WBpZdKTpRyLsoXdo8RWgBOmVlNa5/8bE1KOdCKKiZHmkJVJ6l9FK76A7Guct30LOwMQlU1XerzaocECi/SaduwJIeAp/M7rr6wywU3RNs7NEu4R7Rebo/iRZ+IuN+nhnlhX8yDqvTGoQ63Qc5d0noOCP8LXPQwVJNQTOiBuUqs57qLL10s+5zuu87uA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(33656002)(8676002)(5660300002)(7696005)(6506007)(316002)(110136005)(2906002)(52536014)(9686003)(76116006)(66946007)(66476007)(186003)(64756008)(66446008)(26005)(66556008)(55016002)(478600001)(86362001)(71200400001)(8936002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?M2U4NjZ4Mmp4WkZJbnhkWlRCVElaYVAxMFNMOVY2bFBPL3RZVHlYVW5JYmdJ?=
 =?utf-8?B?eGFqOEYzRVZOa3M4bzN0bi9zcTBLa09pdGtnenZCWFFyQkh6VUk0UWVNMEFL?=
 =?utf-8?B?OEppSmRaYnUxS3laODFLNW5qbWw3VVZoNHQ4SWI2VkkvOUozdTFRRDBpK2FX?=
 =?utf-8?B?SjNOY2FLREVKR011UVhNZ0JyZmNpT0V2YXpxQXRBM1lQOVc4R3lBY2hCTGVD?=
 =?utf-8?B?QzBsRGJRaDIwZFZQSHJnSDJpZS9pNHFyNGc2MDB1WU9abTFVcDFYWHVrV2xm?=
 =?utf-8?B?dkhPeTZLQXVkbUhzZ3F3c2ViZFV5SldSUVdSdHUwOFRZenlTaU9ITVczM0RL?=
 =?utf-8?B?VHJXbmtQS1p5RWFHcGZTSTdKbUhIRjlzNGVKVEtOT016N2xBSkd3TjI3eGdn?=
 =?utf-8?B?aWNDYzdDL0RXUGVidm4veWV5Q3NRZ1AycXBEMlJsR3ljQWpqQmk2bklrbUxk?=
 =?utf-8?B?czZ1anNiTExCNFU2M2JsTlJxVDBPM2lIQWE4bXl2RWV5NjY2NjhtaXp3cU5v?=
 =?utf-8?B?WGgwa09tb2IwZEhCSGJ2WWdKd2lZWGxjakxDSlJSR2lxS24wR3RLOHAxcm03?=
 =?utf-8?B?bFZjOGdQb3hQTW1LKzMzb3E2WDRBbVFYR2xDU1F2QkdpNnZrZWpQVDd2aHVE?=
 =?utf-8?B?TjdHaVRrQ05mQzIrdWQ2b0xHeHByK0ljSmxVQVBNVkpHUWg2enRDaEp0VkNW?=
 =?utf-8?B?NlBwZS83MndaVUY2cTJYODlvSmRnT3VJbUNQWUZ4N0hub0Q2K1Vabk5RQ1Bv?=
 =?utf-8?B?L3ZWZGZ4a2dxeDBNWUtmOUNBbDhVK1E3cnhzbHlSbmhzZTR2bFlqbWhNYmJk?=
 =?utf-8?B?MUhxaEJzSG1BZE4wQW9SNmpuZWw3eTMrRzNXdVNaeDQxQWZiRVg1NEUwRE8x?=
 =?utf-8?B?NzdQWEdmaHJOcUJ2NzVDSlJMaSttU2I2aGsxeE1STXFLWVkyMlBlS2NCZHIw?=
 =?utf-8?B?eGVhenBvTlBPU1Era3lHcUVFQnI1K0RWSCt5dXNvYXBKTWFqUjhwS2RLUVBn?=
 =?utf-8?B?eW1OemF5WUhMRFFtanVyeGt3alBQaE5tckd2VkNzcStQb3c3Qjc2S1lHSEhB?=
 =?utf-8?B?aDhJbktjWlZyQS9IVnFuMDJYYUZZVjdwQ1NqekJVUjcvUG1JNmQzdm5kZXRS?=
 =?utf-8?B?K3ZEcjBHNEt5eGY1MWY4S0pkbzBtNlV3VGJ6SUQxZVV6VzBGQmt4c0lDS2Ew?=
 =?utf-8?B?bnRSZThRNDRYYy8wS2RYQ0lyZlRMbnJsMU5GV0NNMGs1VVRORUl4SktibVdy?=
 =?utf-8?B?UzRyZVVpMWhEWURtS0ZRdzA5S21wTm9Uc3BadXFFTXkzM1lNR0tGeTg2aHEw?=
 =?utf-8?B?bS8wMGRVbzA4Y1FtakdtYm1IaUNPblhHT1EvQ1g0TWE5Q3IwYk9CSkgwMHBZ?=
 =?utf-8?B?cC9waC83SjJYRkdsejV0TkhjZU0zd0ZZL3hCaGNhWE5tbEdzMmM5enlqbFhU?=
 =?utf-8?B?UlBLNDBEb2RMVmlTc3RCakJvMEhIRkJDT3VIWi9uK2FobUJoZVljM1d2OXhT?=
 =?utf-8?B?UHlQZkE0MmhKanFJRnR1aHFXMmpDd1ptVWlaMExjakJIbWFyYnlPWEowQytl?=
 =?utf-8?B?OWFJTVNMZ1dZRVlMcjJ5bk03eERNSHZmTytIVFNVU0NqQlRLOVVsSzNtcEJw?=
 =?utf-8?B?bnFsUlA5SklCRTZiUG11U2ZOb2VmcVU1T05LZWJ3U0VVUHlReHVXRHpkUnBB?=
 =?utf-8?B?eThucDgxVFJ1UjN1UzdQemlRYk54VDN1SGFtNzE4OUxLbWU1dU5IaTNKUUF0?=
 =?utf-8?Q?GDvnaak0p6vpN82+Zmn9NsZdfOEHBjeRaUSnbdh?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0d6648-3fb5-4959-ac8d-08d8d43c6085
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 18:38:25.4045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmKjw/rOK7gnt3V7zQ+oXkibfGt0EED9rzjTclWdkhIG5Q6SO5XsdzEcClxtbK10dimhCx7TUHiUiw7MdWp3r2SeHRilg6svgRTFf8KJdig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4212
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_133832_535564_5118CE3B 
X-CRM114-Status: GOOD (  23.93  )
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

>> +/*
>> + * Define a time period (in msecs)

>Is this in msecs or usecs? Anyway I think it should be in the name as well.

Ah, yes, that should be usecs.  Will update the name (queue_idle_period_usecs)?

>> + * queue before determining it to be idle.  This optional module 
>> +behavior
>> + * can enable NIC solutions that support socket optimized packet 
>> +processing
>> + * using advanced interrupt moderation techniques.
>> + */
>> +static int queue_idle_period;
>> +module_param(queue_idle_period, int, 0644); 
>> +MODULE_PARM_DESC(queue_idle_period, "nvmet tcp io_work queue idle 
>> +time period");

>I think this should be called "queue_poll_period" maybe? because this is the period a queue will keep actively trying to read data from the socket regardless if there is any activity or not right?

>Or does this mean a different semantics with this?

The idea is to actively sample a queue until a cumulative period of time is experienced with no activity, the 'idle' period.  The starting time for the time period always reset if any activity during the current period is experienced.  The goal being to continually extend the sample period before being forced back into legacy interrupt mode.  So no, the time period was not intended to be a limit regardless of activity or not.

>> +
>>   #define NVMET_TCP_RECV_BUDGET		8
>>   #define NVMET_TCP_SEND_BUDGET		8
> >  #define NVMET_TCP_IO_WORK_BUDGET	64
>> @@ -96,6 +106,7 @@ struct nvmet_tcp_queue {
>>   	struct work_struct	io_work;
>>   	struct nvmet_cq		nvme_cq;
>>   	struct nvmet_sq		nvme_sq;
>> +	unsigned long           idle_period;

>poll_period?

So if you agree with my explanation above for the time period as the measurement of a 'idle' period of time with no activity, then I think keeping this as idle_period makes sense. Agree?

>> +	if (queue_idle_period) {
>> +		/* Assign the queue an idle period if not already set */
>> +		if (!queue->idle_period)
>> +			queue->idle_period =
>> +					usecs_to_jiffies(queue_idle_period);
>> +		idle_deadline = jiffies + queue->idle_period;

>Why do you need to keep a period time?

Because the io_work loop was written to exit on any iteration with no activity, assuming to provide for fairness with other queue workers that share the same core, the idle period of time must support many passes in and out of the work item for that queue by the kworker to preserve legacy behavior.  And only wanted to deduct the actual time while in the work item from the total time period, not any time that some other worker was taking on that shared core.

I suppose one could ignore this condition, but then the time allotted to a queue is less deterministic as the number of those sharing the core increases/changes.  During testing I didn't feel we could ignore this condition, what do you think?

>Why don't you just maintain queue->poll_start and just check if your past the queue_poll time addition:

>	if (queue_idle_period && queue->start_poll == 0)
>		queue->start_poll = jiffies;

>...
>[io_work loop]
>...

>	if (queue_poll_period) {
>		if (!time_after(jiffies, queue->start_poll +
>				usecs_to_jiffies(queue_poll_period)))
>			pending = true;
>		else
>			queue->start_poll = 0;
>	}

>Can this work?
If we were to not adjust or account for time while not in the work item, this logic might work.  And if we wanted to restart the idle period upon any activity, then in the 'if' case after setting pending=true would need to add check ' if (ops) then queue->start_poll = 0; '

>> +	}
>>   
>>   	do {
>>   		pending = false;
>> @@ -1222,8 +1263,30 @@ static void nvmet_tcp_io_work(struct 
>> work_struct *w)
>>   
>>   	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
>>   
>> +	/* If optional deadline mode active, determine if queue has reached its
>> +	 * idle process deadline limit.  Remaining deadline is calculated. Any ops
>> +	 * activity awards the queue a new deadline period.
>> +	 */

>Comments should stay consistent in style...

Got it.  assume the form above is OK?

>> +	if (queue_idle_period) {
>> +		/*
>> +		 * Clear to award active non-idle queue new period, or
>> +		 * reset for future queue activity after exit when idle reached.
>> +		 */
>> +		queue->idle_period = 0;
>> +		if (ops > 0) {
>> +			pending = true;

>What is this useful for?

This ensures that if there was any activity recorded during the total io_work loop, not just the last iteration, then the work item will be re-queued.  And because there was activity recorded then we need not process the current idle deadline because it will be renewed the next time into the work item with a new idle start period.  Maybe improved comment above this code required?

>> +		} else if (!time_after(jiffies, idle_deadline)) {
>> +			period_remaining = (long)(idle_deadline - jiffies);
>> +			if (period_remaining > 0) {
>> +				pending = true;
>> +				queue->idle_period = period_remaining;
>> +			}
>> +		}
>> +	}
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

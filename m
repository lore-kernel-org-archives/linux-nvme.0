Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29686C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:58:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FA7611C9
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FA7611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BG5G6N/Lss/fD47L8qOYPB/H9buAvNVw6mvtYvNvJzY=; b=MZ4eM0ylt+2ZdR
	J+mAGVwHXmDh6RMU97uY9/cwysi2ehFRfeSHMYzWQzQqHa/TTCtNWa2fuB1bHWjSP/uRI9svu/BVw
	LoRQxrq1jBTOxGgPorUe8m3wxe5cUYU+jSZAWR0M9593hNxG1PkWD3wEap0Ymu0nQIo1m7Cd3wjnA
	KqbKupGIOverjYTg+GGzO9xuh+D4N3720pTM/qSOyphZsnqTqNLOlzNTGvHaRkLZCdrBV8QLesfaD
	CbriSeSUAEn+neRcXq0LTdQdpCE8mp+LbEdJm70fC80hZTV3ckjz+DJbLQXIhuygimFMu6Px5wloZ
	BVBZA3RTY4DCfyLf0EMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmLDD-008jkT-NH; Thu, 27 May 2021 18:58:31 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmK36-008CJS-U2
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 17:44:02 +0000
IronPort-SDR: bh6UzNuvP6bKqy92e+oPSEZrcySiPJGdb94eHxzoTY0CRIKE6bl5GHBu6+dXaTYbbgzrqGmhpO
 8RoUIKm+r0Gg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="183132748"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; d="scan'208";a="183132748"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2021 10:43:56 -0700
IronPort-SDR: tZ4SPDOf0UeJXjCEMacapggP1dx6w7jKlxsbCpZyZlDqOgxyEjvjMQoNUyOMSnyAYvno+Fhw37
 5Ifl6di03v7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; d="scan'208";a="548222794"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 10:43:54 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 10:43:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 10:43:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 27 May 2021 10:43:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 27 May 2021 10:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTk7DMcDUjmhlUoKPCO5w6kz9hXaoNVD/oUhNbVlkJnJ9UG6g6XyAepBOeaYQSyTcpG9LC6b1urAk/xb4Bb94ap8QekwqNR44LxYORPmX+EKEnSMi8I5D2RswJUjEs10big0llHlmsoCJtIRlUHxV+Fd5VQ6PzKJKgpkAglJFb/yTy5BK0amnlM4jp1KHTxSydagQS4/GXqKw6cR3Tt/GrepYN0L6ZuMnMRJPQRY2H+Nhe/E5YwkQjcSOEx9ECOycHJNm7Z+6K435YQJ3vLQ2GGy2oM7joGEswmQK/lfFcBMpw9KLlLz7T2UKLYRU/8wjqPMwL7+YqjS3Ccyt3GynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKOVDjV0jjlXHZV2kK++uS5IQfNnzIKGbx04VNCDntc=;
 b=dOBkhbw+rq2tFXOSIyxsCdoZ+Af5wcG/6dv+yx8QNDAcNh1A+fLqMCt6IdTST7+rn4+r3N0yFlgI5UMRoxiYttesM1AxlXuaOh9XhspNEDxNVk30/FUj0Vhez2WwJEtISwid1fIQLZEUV+1/NETnsaAy+drBzd76V3q3Wl2Xq845+CIb+g0UmY03ds1q5+2N8vNYxpUzpCafzYMlirwG3dE0bL1WVjQuWrI78d2o1XHqBaNWmiV29DMIY05GFrB1qoxbCKVNDcTGbvSTDozBqkZPPJifip6Q22KnYv0Rb0DVGM/YK1excrm6ELvXY6a+sDF356tDdQSDbHIEFhWYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKOVDjV0jjlXHZV2kK++uS5IQfNnzIKGbx04VNCDntc=;
 b=fuHIwA60zR7dwlPNDY8pFd3eQYgzkdiKHAQaHs6H17qDM2S36BAD2Iv09PidfK4FYHELDzvhZ7rgrij2THWyR3qNHtwc+fPqp067ICHW9+QYmzlIKhBBDktCGfOeBHpQFrui7klWLTl4OCzbQpQx1vhG5mcrLZ3kbiHe5hFKtV8=
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by BYAPR11MB3735.namprd11.prod.outlook.com (2603:10b6:a03:b4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 17:43:50 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::9958:3f0a:9dff:ccc4]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::9958:3f0a:9dff:ccc4%6]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 17:43:49 +0000
From: "Walker, Benjamin" <benjamin.walker@intel.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Thread-Topic: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Thread-Index: AddQv97rUefW+8weSYm6BKNNw82QzABT1UAAAApu4wAAAVsMgAACdbmAAAx69QAAKWQS8A==
Date: Thu, 27 May 2021 17:43:49 +0000
Message-ID: <BYAPR11MB282487506792423203DCD350EF239@BYAPR11MB2824.namprd11.prod.outlook.com>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
 <YK5W7F5DD4grBZLB@infradead.org>
 <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
 <YK5wh91yAcOlu+3J@infradead.org>
 <638819e9-8d4f-7b00-41f3-75062e4c076d@nvidia.com>
In-Reply-To: <638819e9-8d4f-7b00-41f3-75062e4c076d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [70.190.226.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f151a835-1eb8-4ac1-8e97-08d92136fc9e
x-ms-traffictypediagnostic: BYAPR11MB3735:
x-microsoft-antispam-prvs: <BYAPR11MB37351F824EA0C8171A6E2947EF239@BYAPR11MB3735.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oS8K2H53SrgDOxnIhXPcn/eoAgeB9Ui5xKlKyf0AamR8PEEHl8trDGx8///FcZMAZyldZG9vBRKM1xySu2tPmoHZgLtvflBdWqZz0zRNyGX/rNnaeoRkYVTrGfWG1WzqwPL7ZBX72FC2uIAslCKh361N0wfcOxpvRxJ3PjxcijqyyVH50UwdyyKmMWX1JT7Y0ki8a1PanRdYe1c0ECIkEf4FTeEz0kXPXjwwpqGlnB8qn6xo6sj8rb/bhKPS2C7ou/wALLpFyqbvLBnzh7JP9pIeISfAE+Wi/7yj0A3xem1wkiKy2cVVoro8RzKwL3iiMPc4n0vGoBsGHMYRv/T8P6S2Hedc2vUFcahammzvI9/eUqcVFUu4CXLJhq46oqDPmOTQqNi/w1/0rsbTExoOEQT1cm4ECSIDMtcWWtjUxkWiA42XisJXEhNrSmaY0uM8RjrWpItXIRE7B0aTDCyKTY6DproYoyGMB+QIYUyNLmA6DlsdJW1uhAe4AXsLeWAxB9UpS3sMIGfWjQ84QucJ0vH8q5cVwiDa0eH2OitKwBAdNwtuPcMbIgmjnsw0P4jLNWJuD12WOrRXUZKU8NofQlwDJd3advLJvIqpd0R1IZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(86362001)(122000001)(8936002)(478600001)(38100700002)(33656002)(26005)(2906002)(4326008)(9686003)(186003)(54906003)(316002)(6506007)(53546011)(66476007)(66556008)(64756008)(66446008)(66946007)(7696005)(5660300002)(76116006)(8676002)(55016002)(71200400001)(110136005)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RDY3M1RST2krUjVmdnhLTFF1TVMyanRhWk1JUGUxWkFSdFUzeGhmK1B4MTJS?=
 =?utf-8?B?N1drb3dDa0RmSVBXOU1NZjJoR2JzZTVYMC9uOXV5MGhrSktxaUQ3T1NLU1Jj?=
 =?utf-8?B?V3VjKytUbEpKRWczTnBNcmp3TDZNZms4NEdHZWQ5TTYxWDVLVzZpMTZjMER5?=
 =?utf-8?B?SlpITUh1NWYxQ1JhQ0RQMEZRVlpnbWowd3JEd0ZvRC9BTVpnLzAzcFFyZGQ0?=
 =?utf-8?B?S002cXo3elh6aHlqWldTbnBveWlISjRHek56Z2d0NG9rYnBoWUhPaTBtRHNk?=
 =?utf-8?B?UlR2b1NkK2p1aFVNUnZWRUdpV2VzcXZDWW9pYlhxQUtFYlBJRkR6TnhMdUlh?=
 =?utf-8?B?OTYrN1J1cmE2T045Y3dwcUgvNURCRUJaWVBIYVF6ZzB6Z25oTTZqNk96SGFs?=
 =?utf-8?B?TS9ubE0yMkhqWnVvc1lRbzBQYXJCbjZwOTNPV3AveVk3djFsVHdjZ2Y1bHJq?=
 =?utf-8?B?ZzJ2ZFprSVFlbXZDNlZGVnZsSVdmSXBLU0g2ZkpyK2JBWnpKZm1jYmVaT2w3?=
 =?utf-8?B?Y1M2bzV2bFpmY2s2WkRsaFdtSXB4a3pyRXZDaVhnWnBWUEtaRWhIY05FcXN1?=
 =?utf-8?B?WkJDZThVOWZJdFY3U2lheXdXc0FhNG1wMDNVTlJ0WUhnY0ErdGhFRXJqc2xY?=
 =?utf-8?B?aTRQdXJsRzFaY1FWU1dYQW9rTXQ4Z2dRWjlDdWVNSXg4OVFwYWdPYXdZaEtR?=
 =?utf-8?B?aElpRjlzY0J6elhCaHFlRld5UGdwYkhxaVBVbktKYkxsNFIzZDFsYUpwOERM?=
 =?utf-8?B?cDArWTR0aXBoUDRCSE9CRWVYRlBISXlQL3BUUUIrSnlEUGhQUzZVNSt1RnZK?=
 =?utf-8?B?WHBIZU1uOXNQU2Y5eUsyaUNWZDEyVVRHTFF1YmpaUk53eXZCVXNNMUU2WWg4?=
 =?utf-8?B?bzUxV2JwVEE2SkNXb1E4VWFaQlA4UUo5cDBEM3NFajRWeC9aNDdjcUVrTzQw?=
 =?utf-8?B?SHJvTitHK3NBc3RrcUF6K2VVMEltWW1PKzlLU1RLakdpQXltR0p4ek82UzVm?=
 =?utf-8?B?SlZDYkdWZkRHcVR6ZmVhRTQvNEFEamwvem55Z0JVTjdSdi9IaWxFc1Y5T2s1?=
 =?utf-8?B?Z1NZTmVrdkZEc3ZTTWFYL0pDcVlHQUZ5ZFZ1KzM4YlRpd1h2SlowZjdESnA3?=
 =?utf-8?B?enlHVFBPRld2eWpTeHEyNjhSUFFRWS8yN25zbVBJcGdydU5IQUdjci9FeFJP?=
 =?utf-8?B?dHA1NGZtbHo2SFhBMGVXRUkySmxtRGVwOEFNeWZlZ2twYU5MUXpxcUw2VGcw?=
 =?utf-8?B?emFSdVMvNFZ3bXVkZVV5azByeWdMTVlVRTQyeHE0TVBaV0VtQkR2OVpWTkNa?=
 =?utf-8?B?RTY1aFprVjkvb0xBdlY0QThLdHhib05HZVNUdFBMdUg2eXU1Vy82Q1VIbnd0?=
 =?utf-8?B?YkwzbWhITXBuL1hRRmJYdjE0S0w1b3V5NXJMQ2hCTUhySlRlVzYzQ0ZYQnJS?=
 =?utf-8?B?dno5ZkdJaHpJemFuYkdvSzZGQzlqTXhLaXpoNkMzcVl3d1AxT0Jya2tUcm5K?=
 =?utf-8?B?NzNCOWZHUEY0MDU3UWsyd0ZlcWJTa1FPcDVXRXpTckJqNTRRWUhReGtCWjdQ?=
 =?utf-8?B?Qlk0dEN3LzE0NUJlM2lyaUZpNU42Rjdxamd2MjczSzdmamVuY2k5dXp6UStH?=
 =?utf-8?B?MjJSSEVyb2trOGRIdFYrK2V4NXNSeWZTNStBbFRpdHNVVkJySlJHT1dqUmpv?=
 =?utf-8?B?cmNRTHh6eXBFaTBvVHFvaDMvKzFVbXJBVlhRS0tKcVVoTUNXdEJXTGFFUitr?=
 =?utf-8?Q?LeJ5Yo+27QGFX1fTqZXp6xDLFpggtHCoC9O8TdB?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f151a835-1eb8-4ac1-8e97-08d92136fc9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 17:43:49.8856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/zAtMDk3F/e1Z1EKyXv1AYvDVhsDyewjlNogSq2Oh5lwqwAOsJoLucrYblNRF7RSbEn6hyPN9AoTVIngoaV1HLjn3uUlSpoxoG6f/mjd2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3735
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_104401_076709_7A064CF7 
X-CRM114-Status: GOOD (  25.07  )
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

> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>  
> On 5/26/2021 7:00 PM, Christoph Hellwig wrote:
> > On Wed, May 26, 2021 at 05:49:41PM +0300, Max Gurtovoy wrote:
> >>> We do need for_each_sg here indeed, but you also need to keep
> >>> incrementing sge for each loop iteration.  I think we can also drop
> >>> the scat local variable with just a single users and all the
> >>> renaming while we're at it.
> >> Is the above fixing the issue ?
> >>
> >> Seems like code refactoring to me, right ?
> > It fixes support for chained SGLs when using inline segments.  Not
> > sure if it fixes the original bug report, but the current code is broken.
> 
> ohh, I see the usage of sg_next is missing.
> 
> Well the original bug is for sure using inline chained SGLs but I thought it's using
> 2 sg_nents and NVME_INLINE_SG_CNT == 2.
> 
> maybe there is a split and the IO is using sg_nents == 3 ? and then we chain.
> 
> Let's wait for Ben's test report (Ben please make sure to fix Sagi's suggestion
> with Christoph's comment in your test).

This patch fixes the bug:

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37943dc4c2c1..6a3f7f6bd1ab 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1320,16 +1320,17 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
                int count)
 {
        struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-       struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
+      struct scatterlist *sgl, *scat = req->data_sgl.sg_table.sgl;
        struct ib_sge *sge = &req->sge[1];
        u32 len = 0;
        int i;

-       for (i = 0; i < count; i++, sgl++, sge++) {
+      for_each_sg(scat, sgl, count, i) {
                sge->addr = sg_dma_address(sgl);
                sge->length = sg_dma_len(sgl);
                sge->lkey = queue->device->pd->local_dma_lkey;
                len += sge->length;
+              sge++;
        }
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09724C4451B
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 05:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGdSp/rTzHN5Q+ySNFf9XK+D+Xqkhrjpw37uEMGmDX0=; b=BLudUARmX7ZrEuvPu5pKWdB9sm
	FmLlXSY8j50E28XMCkruvXAJ9obbMzqDMqcM/LiK+mWZTAqgEd/gO4XVqc3wlPE0vBo9QpmMqm3sE
	jjnprkKNk1E1mMUwDnbgCbKb5mGnzs78YDcfnNEvoP4JO/0YzRhrxS+zfw+KdWmiIgsoRRZkoTYF4
	bmhMWskXz+M2OQ6bAIaozUhulCqyj1yk5tDNe5s81ob/UYgVi0BCdGnIQSwg0Nyihh6/sSAM/JwIK
	uFY3MX43Mr44x4u3QsGT/nrWV5mObSoLbAOEO91i4ocb4aH02uK6onVIK60W41xdotr8N7/i3ZmiD
	GGXdtV1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlgUH-00000005rRe-2tn4;
	Mon, 20 Jul 2026 05:24:21 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlgUE-00000005rRA-1fhF
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 05:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784525058; x=1816061058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YGdSp/rTzHN5Q+ySNFf9XK+D+Xqkhrjpw37uEMGmDX0=;
  b=ZnAl/u/pxT5bbEpIgFzpDy5YCrzYZlec+iQ9tGSf7XKondGeR1Gys7qQ
   M8XdFow9Ck+QThGH9dZOAHcUp3+T6q8UMvBUsUFNILJRVzs8Qa48VEqb3
   iZpcRRJXF29QiblsrioF4MjrzZ7PqsuNMJtYWTRFsQ80vCQdSJFiyKLCL
   p9D65+klzNP/5Y4wsKWFFJRO80lhHTKtu/PTfML9+bIgsc1CJws7CXLRT
   VHJ7if02M/JwbLDODWxJFumwz+kKT4CAdvs/3pbWg9uG9c3+Sg7muuVpy
   35Bejaa5m6JX/3cR6bqUvwGjgbAyOLYWFWir6EG5j16nZ/uF3rvV1jMoU
   Q==;
X-CSE-ConnectionGUID: D9v1Jb6ySQSTpmT1BzuQDw==
X-CSE-MsgGUID: 08wZvtSNRw2gd9tFen9JIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84221532"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84221532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 22:24:15 -0700
X-CSE-ConnectionGUID: voW7m8RsSTy9RH8uW2KudQ==
X-CSE-MsgGUID: UZwCLXjnTeWsCONjSWdh1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="251008449"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 22:24:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 22:24:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 22:24:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 22:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F77t/txYE7PNCjbAVVhTDrnTf2NSGY7ynFRRA8ZLpQf9oIDUwfHHmeHZ0YDYqVJ0CRHZTh1PowjmZJ+wRpttBpj9pQiW+Ct8H+sFFabUJ8mKTA5RKLNtOwz/rYWiur7TiPYNbqckaNRadkf+ShM3xcMh78/aBp8uRdCbwwjrpHOJ4wJfuWixmv1UdEROYl136gugNWVGCgYNKw04YdCSuf4BzWnxs/jCJOh4AOCwj65OpRRH8rPOGenn7k2YSiarBxAlFVc9A+atK8eNPd8Ak1Pc4y6E300+wd4CZqPy3xhIJjQNI1DELfzOh2Q3KSX+Ai1m2LV1iL+qLEm6CRoxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGdSp/rTzHN5Q+ySNFf9XK+D+Xqkhrjpw37uEMGmDX0=;
 b=rKN8YXVa6sOXLLPsoLgWiPISfvGhfIz3H4II77jxMwU1XAcSMaup5FXsVaAbV84mhauEUMwd01j8BdkivU4qRv1NxxtEpgYppe8yW0ijK/OUHfqPfzW2rA7nLCxt+GjwDyOF2dtvIaPBMwGxtQesXrA8jikFlgbRUpRHW2f4Ic/1cl0C0+5ptnmUywfDxpT78SO4lrBGCUjP35s18O2IxK/QZH3benOS0uQUYa1SXqCShQTdLhKwodW6vfiw8RIlM+pHJHN62NUBKBcfhETd3ixfguY9G/nBcpjY29nWDN33FHCLmegwybiXS4baUWzwEFQtemWWihQm78hHBPuJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5375.namprd11.prod.outlook.com (2603:10b6:5:396::18)
 by DS4PPF708A6BB3E.namprd11.prod.outlook.com (2603:10b6:f:fc02::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 05:24:12 +0000
Received: from DM4PR11MB5375.namprd11.prod.outlook.com
 ([fe80::27b:9264:912a:a3b7]) by DM4PR11MB5375.namprd11.prod.outlook.com
 ([fe80::27b:9264:912a:a3b7%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 05:24:12 +0000
From: "Zeng, Jun1" <jun1.zeng@intel.com>
To: Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shevchenko,
 Andriy" <andriy.shevchenko@intel.com>, "Cao, Gang" <gang.cao@intel.com>,
	"Jin, Jun I" <jun.i.jin@intel.com>, "Hu, Yong" <yong.hu@intel.com>
Subject: RE: [PATCH v1 0/1] nvme-pci: adaptive interrupt coalescing
Thread-Topic: [PATCH v1 0/1] nvme-pci: adaptive interrupt coalescing
Thread-Index: AQHdFDEcdyKFvQX3ck2jQlqu8W/Fq7Zx9M8AgAPB1VA=
Date: Mon, 20 Jul 2026 05:24:12 +0000
Message-ID: <DM4PR11MB5375E80B504445BEDD869E95B7C32@DM4PR11MB5375.namprd11.prod.outlook.com>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <3c29b8cb-906c-4c48-89cf-59c676900616@acm.org>
In-Reply-To: <3c29b8cb-906c-4c48-89cf-59c676900616@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5375:EE_|DS4PPF708A6BB3E:EE_
x-ms-office365-filtering-correlation-id: 4935239d-8e71-43a8-9a02-08dee61f2232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: R5qZ+0ssdaeLmbQ4TLslKgFMSNhtBZomkio6VmRP+pzHPrewk8+pfb8GCyUqBQhhyHWFHaGaSZU+lOjeBID5ZDQHBwPAfVRiFSEglCgR0uiHE4d4nU4CMBBdKWEXftg0HJkys1kJ1lSfifesZrRnroR1Gk+WEyzwXWf5E7Lt0K9uVRJIwoA6AvyuG8U1sdVt2BDFwT8FO8v9XPEa7UUyUx9fv7gtCFpwhMeeJy1he+C3dgKc/usRk2uI+znU8MyL8tubGQ+Tqfkc3jbFejDplB124StBQySo6vOL5AtbBskm1zAlfiEsyPFq86GYkxivQbXY6fefs+N3RdyBRRPs26JVR2Lz+ErlDNju9sxsatjUCfzgFOewxk4vGCMCLKLanJo/5QISQ6Rk/pHqGyCmL+Nxe6/Ivf5rCE9j4IY9qgC2yGhWAMQ5tXjccPgYo5KT3JZnLCCve/GYCObA3J40Oc1fIcinXWuSZBUz71bHaisMtiv90YJ0wA3whI36LCJWLjZCNGUE4DgE+uif70OsFe8z+jBDH3fgUfKOgYIIWHrqIWWfqZLd9vs3RfnYzTUNji3LSY9mxzWzPAl9PQl0dPuZzZ6+PA02RLikUeHaja32cVbxno4yGZVoQtSNnTY99Tz6wH4SmVTSdtc0S9GQ6hfhYNcEpH8l/q0KW8oPWq2cUbtKXjT4QDHhR4ITQNMZTQMQAF+xhLT6ZzmD+yjT2rJc4f7005cOTP6VvNQj69I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3RjbmlVRnFiaXA0SmoxM3R2UUVzMHE4eEdJS0ROWFd3OVU4OGNpeWV4Y3V5?=
 =?utf-8?B?ZFVYK3BKT3FpVFo4bzhjaTRzcnhvU0JCNkRBNHA2NkZiV3VhTXJxTFNpWSt0?=
 =?utf-8?B?Z3Z5eUozMTlHU1FtdDZGWWdzUnFTYVVUVzgrVHdvWkh1c08xQVJhaHFyZE5s?=
 =?utf-8?B?UUpRRHM0YUxjN3JiRFY0VVl0TTQ5bk9xdDB0WlhIaFlHQ3R6UU1QRHNtdzVr?=
 =?utf-8?B?d0QrYTNFL0tjZTZXQmpacXBnSy9kblY3ZEJ6ZWovZGh4cERlQ1NvQ1JPU1FS?=
 =?utf-8?B?RkhaaUdhQmNrVWs0MTlmeW1yc1VibEt5V2xGc1BxcG9TUFRJeTJEOU9MdEJR?=
 =?utf-8?B?OUJxdnFQRTRGOTQyUUpTY20wR0Q4Mkg0c2NMNDZQYmFUbFVycWdBeW9vTGhx?=
 =?utf-8?B?OWJRclJTU0VQb09MVU5yRWJ0Q3VrTXhqdkZqS3oyZVorVHpPb3hac09kZ292?=
 =?utf-8?B?ci9vQVB2UFZGenZKS1daQk5sTUFTYkZrRU9MV0d4VWtnSGdlbEtrWVUvTXVl?=
 =?utf-8?B?cjZZZno2UG9aU2NHYjFPQlBmMG4rN0hETjJKZTdUVTFKekZ0b2JQSXl0bXRt?=
 =?utf-8?B?eXdOM1pMUndRclFQVGU0THNVdGRBWUNvOTdpNEgranF2YldGQW5vTmxQSmpL?=
 =?utf-8?B?S211SXdPL1A2RzFaZ3pSd3ZpdjR2YUJFRzh4UW80R3VtVUJrVmV6OE9NdU00?=
 =?utf-8?B?MUJiYlNDSkVHMm93OVBPam1OeEpjVjRtU3NOMndGR3FCTEpGenJnMTJWczFz?=
 =?utf-8?B?dEd3TVhkeThXWEhIeThMd1NQM0RWelhJenBHTWR5b0Q5MzJSblRIZCszeEdz?=
 =?utf-8?B?WC9DV2QxWjU1L3cyQURRRWZhV1RJdFJEYm5FeEVuMzZEaTVvU1FIek9mNHJT?=
 =?utf-8?B?WmJSMDhua2xLV2xGcWpoRVlXTFZndkdFQnp5N0QvWUVteW5RRWxLYUF5QTBD?=
 =?utf-8?B?UE83eWhxRHhqa3BXdlgza1RSV043UnJDbyt6dXdqVmdZZVpyWnpwOUFqMytO?=
 =?utf-8?B?K1lEK1pWQll5U0k2QW1OL2V2MHcwUnZjcDh6RDFYVjBSLy9VS1BoWitldW13?=
 =?utf-8?B?eHFaQmxZTUN6NmVQTlVpUHlPTkl6SWpNZXFSWlpoMUxDbGdxQldicEpTTmF0?=
 =?utf-8?B?V2NVRVFrNFpOOTkyL21uUGMybEErVVRNQzdJTUc5TWlvMUdjbVBjWFRWQjR2?=
 =?utf-8?B?RGtuL2JOMWZUdlZCNlBtazN1bDNVeTU4MjQyK21VdGtTWTlRTWtCUjdremlK?=
 =?utf-8?B?WTdDb3ZDNWVRcElBNXlFMWlIQi8ra2FOcXczRHpveW1XTjVENkxpQTg5aUlQ?=
 =?utf-8?B?M29KWTM3VnJPVTBKczR3UEw5ajZjVUp6SE1FWm4yMWQveDFFVVk4eHphcTgw?=
 =?utf-8?B?QTRmMFBJL3pQeWsvcUpnZUhuak9UcmN1ZlV2cTNySUtBYk9pYmZ1OFFGUTFC?=
 =?utf-8?B?a2xtcnFQY3oyYzY1NTFzTGszVzREY1NpbmQyc1Rmcms0QnczQnZZUE5OcGpX?=
 =?utf-8?B?M3ZiVlpIMGRrQlFHWWx1VEFJQVVOMEU2cDBaN2ZFVVN5U2RucG1SVWZkVzZ0?=
 =?utf-8?B?bXF5RmZrNlZ3alErSGVTNnVLSnZBTWRzaUpYa2dWbnovcGxwK1ZJdCsxckhq?=
 =?utf-8?B?ZlpCWm92ZkV2MkhoblpIazFnalMwczJtVzVxZmc1bFl6UXU2RWJRM0xsTUQw?=
 =?utf-8?B?djFha1F3U3l4RTdTcjk0ZkJkZHN3V3VvczVzOENLdFluSk5aSnZraVY4Q2F0?=
 =?utf-8?B?UzdRTGtCNndMZG0xZUFxdUF2MEpHOVdKZ0FqTEFUcUhoWFN1ZEVZNHR4Qncz?=
 =?utf-8?B?Wk10akpmNUYzUThjMnFRa2dTZE43Ui90NHZpNmtSNnlHS2JReDQ4cjVNMng1?=
 =?utf-8?B?bFVTdURuUW5Cc3ZkQ1FKVkxON2RVWUM3K2lTWG4yMmw1RTNjalFGVVlmTU5a?=
 =?utf-8?B?VEw2Mm9BcWhkUmt3UE52ekZjRGZkWkR6am1lZ0MvTVpvKzExZjk0bkVPOEFv?=
 =?utf-8?B?VWtWa2cyLy95UkovbHRJbzg3Mmd5NG10dFlORzJvOFJ3MllTVmtmT2s2bE4w?=
 =?utf-8?B?MDFZcXUyd1VmYml5VWovcGlrREZ4Y29aaUJWTmVzOS9oR1BzWUJCMEZXeUE4?=
 =?utf-8?B?NnFJRG1PWFBzTmtLcGZ1aE9wNXZwd3NqWDdTQXhoTTNuNkdzclZaWXJMbmkv?=
 =?utf-8?B?Rm5DdGtQNEhYNVRmVktCcnlscC9RKzBRRjFZb21USXNvMm1YVXlDU3hhcUhO?=
 =?utf-8?B?bjZ5ZFQ3TU53dkRqS04xME1UOXNpOG9DVm5XaGZJNXFZZ3ZPTWdBTUpxNDd1?=
 =?utf-8?Q?sdJIuJ1dl0LXrGYbKE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f+Z3uY3Zfphj1+zyDOEa9xruz7IwpM+gRbwu9YcaHwydRUbjG5lOyu3jxP7QNMihKbbY0VxJa1xk/kN6lWK7utRlNs73oEuPDO2e+U+SLOlsjqeEtDa5KtPqXJ44Z2dtehq4s8/1Mu/QnIhoGQvdmQWLAg4RBMuJYR6x7ptcI6afWEK5uhsNq2tJiSwyhI/4Xar7UFyQa7QI81deZGc2lNd7MWbSzxYvcotX9rDRtgg8vpJlFJuAp1qemOiV9rwgSiw4NfmFOVaQeAPVFymWllsLtUWHoqykMD8vUEolSg1tgZh2fdt7X4L/mvabzMR6fA91dUoTPnmeD37j3ca//Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4935239d-8e71-43a8-9a02-08dee61f2232
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 05:24:12.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Y6LcUSjT93g2N9jZkEv62nGtPZTazT0gb8zWocIBgmmI4XNIj799gLK3d+7/NQ0mUBgme6hZPfytAvX5rgxvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF708A6BB3E
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_222418_492072_F56D5568 
X-CRM114-Status: GOOD (  11.50  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiA+T24gNy8xNS8yNiAxMjo1NyBBTSwgSnVuIFplbmcgd3JvdGU6DQo+ID4gVGhlIElPUFMgZm9y
IHNtYWxsIElPIGNhbiBiZSBzaWduaWZpY2FudGx5IGltcHJvdmVkIHdoZW4gZW5hYmxpbmcgDQo+
ID4gaW50ZXJydXB0IGNvYWxlc2NpbmcgaW4gdGhpcyBjYXNlLiBIb3dldmVyLCBpbiBzb21lIGNh
c2VzIChlLmcuLCBiaWcgDQo+ID4gSU8gZm9yIGJhbmR3aWR0aCBvciBsYXRlbmN5LXNlbnNpdGl2
ZSB0ZXN0cyB3aXRoIHNtYWxsIElPIGFuZCBzbWFsbCANCj4gPiBxdWV1ZSBkZXB0aCksIGludGVy
cnVwdCBjb2FsZXNjaW5nIGhhcyBzaWRlIGVmZmVjdHMuDQo+ID4gDQo+ID4gU29sdXRpb24NCj4g
PiA9PT09PT09PQ0KPiA+IA0KPiA+IE1vbml0b3IgdGhlIElPUFMgYW5kIGF2ZXJhZ2UgcXVldWUg
ZGVwdGggb2YgaW5mbGlnaHQgSU8gcGVyaW9kaWNhbGx5IA0KPiA+IG9uIGVhY2ggTlZNZSBkcml2
ZSBhbmQgZW5hYmxlL2Rpc2FibGUgaW50ZXJydXB0IGNvYWxlc2NpbmcgDQo+ID4gYXV0b21hdGlj
YWxseSB3aXRob3V0IHVzZXIgaW50ZXJ2ZW50aW9uLiBUaGlzIGZlYXR1cmUgaXMgZW5hYmxlZCBi
eSANCj4gPiBkZWZhdWx0IGFuZCBjYW4gYmUgZGlzYWJsZWQvZW5hYmxlZCB0aHJvdWdoIGRlYnVn
ZnMgZHVyaW5nIHJ1bnRpbWUuDQoNCj4gQW4gYWxnb3JpdGhtIGxpa2UgdGhlIGFib3ZlIGNhbiBi
ZSBpbXBsZW1lbnRlZCBtb3JlIGVmZmljaWVudGx5IGluIE5WTWUgY29udHJvbGxlciBoYXJkd2Fy
ZSB0aGFuIGluIHNvZnR3YXJlLCBpc24ndCBpdD8NCg0KVGhlb3JldGljYWxseSwgdGhpcyBjYW4g
YmUgaW1wbGVtZW50ZWQgaW4gdGhlIE5WTWUgY29udHJvbGxlcidzIGZpcm13YXJlLCBidXQgd2Ug
aGF2ZSBubyBjb250cm9sIG92ZXIgdGhlIHN0cmF0ZWdpZXMgYW5kIGRlY2lzaW9ucyBvZiBOVk1l
IHZlbmRvcnMuIFdlIGFyZSBzaW1wbHkgbWFraW5nIHRoZSBiZXN0IHBvc3NpYmxlIG9wdGltaXph
dGlvbnMgYXQgdGhlIHNvZnR3YXJlIGxldmVsLg0KDQpCUiwNCkp1bg0K


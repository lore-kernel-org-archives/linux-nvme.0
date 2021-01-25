Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 17:51:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE7D22D04
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 17:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE7D22D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sKe+eneqkTrwJO/JQxESUxkmcbcwE6nfdWeOTMi6qcw=; b=17EKq7Mq7XGS5qnWDvntBxgVw
	iAVFZfOqoCm0usyuQhe/xFtMKuWm4gtpCZBto7EcvTJyACsGvwN83L45FVuIzkhZxEr97rZUXDqhm
	bWVOGqB8zgB8cTtz2Fh+QNg51HEwj/DElMaG3W0Fr60ZHsUlVMv5F/LsxAZ3qIIED2VmgENsF7tKT
	9h3SQ/adv0x0hXqA6fGCnVQuZVbyoK8vuR4zFnGf0mgWgAjNREKIzOHt14DIUnCcuLmm6FWn+uDGJ
	wY09XoJ2svJ3NkGXoiXOq4WAlOvphqgD9GFQ8FMMc82BSbPc78E6PsrgPYG1ttpO5surkoycWiUmX
	ykWEUqynA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l460a-0002AJ-Al; Mon, 25 Jan 2021 17:50:36 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l460W-00029Z-PN
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 17:50:34 +0000
IronPort-SDR: r7B2QnqI84YKmZpFiSPM+s2TSlFlHXqBhXfrDd1NgJlbq4lb0OVvhH/hYkeSqXZoVCtuzeFLOA
 ggQW1XrOqy0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177198933"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; d="scan'208";a="177198933"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 09:50:27 -0800
IronPort-SDR: 1012oc4VCWgqhgGYyH/mpL0cDvFhXfquZqpoTx1Kv7lrblBLb5hnHJF+leeb2gAJb54AKkFepF
 tWW5W6pyj9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; d="scan'208";a="368767800"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga002.jf.intel.com with ESMTP; 25 Jan 2021 09:50:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 Jan 2021 09:50:26 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 Jan 2021 09:50:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Jan 2021 09:50:25 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 25 Jan 2021 09:50:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYwC+u5EEbg4miDRbyyJTdp0SvxsJLerQttaCuuT8W+pKeUjkT7kS0deaJa2aBOSJnWi10Oz2q9Y+aj2iFP9DjNfyvGjZntkhmzbuVx+ag1reg6UgZ/ZeXOagrHftcea8OvFiQJSWajZeNV2LJyca9xIJhAP1nLKyG5wKZcjnt8cSEVRxnKsl31qrWf+3B8/aJIJr805zSxjG6r9v7nquPUMp7DdWxAXvmF0IMI1QNEAdpAgY6d7n3Gu88Qb1cMRL/gwvOGG8Kp1eNPjmPmYcTZ5o+nWBo8lTok4SHqzgjvrC8z2IsHpnrh73gWzc10PnaYfkZUZuI6frrChq0EH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1P/9Lh4puXBRDcaXiprWQ1zshdGnK1OXe7TaN3vHOI=;
 b=hvqFHzz5fvTdR9t8DyfPVLxiwNi5vdnQ9IzFmD835myrSVuneCgUEqt8a5NEOHtmNx3LoD1xqke7ZYE8Bm9pZozgY0lNEplJ+/D72i/xbaAREX/sBh9IwwGDnBKFsDpQuvga1m22KLJzqByhkdGPPqT24Os3FeG081E2HMHzeATEIvpLKdWkFMEPKnLhQq/1r+3KYpuTo1emNW2qFAAdS57iuI0yQ3FLWVL9fDFqBvT73zPW98mM5Z3ln70nBnqpPt1GkpOq42IdF77u6J2jHn/Ta7/4F/CiCIpmX+DkZQKDc77C7xdszIGx+vYSsK0sn3kP+I17elh09moFdGbQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1P/9Lh4puXBRDcaXiprWQ1zshdGnK1OXe7TaN3vHOI=;
 b=RmsLIV+jvjo45kPi9CROSKJuPSnopPoP95Xhga1Jp1T6xF3LKgbCSdow70ZD5w1b/dyxq5x2NZ3wJ594OJfzMUj/N2kcvGCB19AMcJfuqU7LNiI9WfduezpIwMc5LCGcWqMbGAIbykoWu5ty5oZ80z0xRvoZfgtcTDkWZsExV00=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 25 Jan
 2021 17:50:24 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9%5]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 17:50:24 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [RFC PATCH 0/2] nvmet-tcp: introduce idle poll option
Thread-Topic: [RFC PATCH 0/2] nvmet-tcp: introduce idle poll option
Thread-Index: AdbScj0Vb4b2xt6SSe+/1ioCxjs9IQXqd6wAAkhMCBA=
Date: Mon, 25 Jan 2021 17:50:24 +0000
Message-ID: <BYAPR11MB286948DC9BB8251F57A00D2CE5BD9@BYAPR11MB2869.namprd11.prod.outlook.com>
References: <BYAPR11MB2869A106FF8E7D7FEAD30EF1E5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
 <62cf6b4c-3b8b-db9f-f960-85efaf0896b6@grimberg.me>
In-Reply-To: <62cf6b4c-3b8b-db9f-f960-85efaf0896b6@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89c72440-b8e4-4d6b-a58a-08d8c159b134
x-ms-traffictypediagnostic: SJ0PR11MB5117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5117721B27E0AACE27A319EEE5BD9@SJ0PR11MB5117.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gE1vI0PcEqBQeXpdknFGcjX3ulWvr2YR8/IZGGpwWqYJ59hcI6nDRLAkaja73ipunB0I/0ZpwKg/ilyp2Sayck+npdzdAcWuaKYfmfzaqu//Uy23GYV/7K3scjm/xDj6j9pc6aaO7iDM76JAiQlhEw98NqGgM0f1cZKDMOUFS6p8zmUqu1ZEEJ6yCtpwZuZZvFpTXINhfw8+bNLgArAd4GmLyb7D15qNK6fLQPMTTGZYM3xIa/tMTbFWqqtpQ8qU/bRqiAcWYfmaBFQnha+KQQL6lt+oaDMBiu/S+58WIzTl6qka5tE+UV6S0OYBLOAel+ChHhs/10Efd0C9xQVZFHfaRRoxC8DiYyRyOWv1xC1Z+4T5kywCfpnISHh9x2JSUHWlICjQmSksgZXnlqYhYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(4326008)(6506007)(66946007)(86362001)(5660300002)(2906002)(26005)(8676002)(33656002)(9686003)(76116006)(8936002)(55016002)(54906003)(66446008)(52536014)(53546011)(186003)(71200400001)(478600001)(64756008)(66476007)(83380400001)(66556008)(110136005)(7696005)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?eURNK05ETE95TWQrZ3c1Z1cvT204SjY2OURBWGkyK3ZRN2pPOUhDSE9kSGJU?=
 =?utf-8?B?OEd5YlNOTUdWTDRVR3pyWFZXY1ZjTWVEdjlFTlhZS0s5cGpkSHppc0ZHU1pS?=
 =?utf-8?B?ajdQTE9rTkRMUWVrR0pYaUtCYXk0VTk0bFFoYmVVTkQrNno2MTg3b2FIM0Y2?=
 =?utf-8?B?aGZmcklrTFRQRXZaU0RUZSt2TXdqNjBSV1ZQdlVBZ1AvZ0hNZU5kWVRhYUhv?=
 =?utf-8?B?NlVoSVVROVQ5U3o4ejA4U2QxSW51dm1MNzZqVG1NYS9tbHJveUtWS1lYSm9F?=
 =?utf-8?B?clhsMys5cGJicnRyanJiUFI5SGtQaFVFZm9veW9SOHdrN1dZaU8rS01ORndL?=
 =?utf-8?B?TnhmU2xEN0JONzlmSXlHS3VYZ3FOTUVPWE9hY0dDQUpHS1JBNHFjUVVpOFRr?=
 =?utf-8?B?bmc1V1NrZ25EYzJKc1lWTmdaSlEwUS9yZjVtZTZYcGh0RWxhTmcyYUdqVVJ0?=
 =?utf-8?B?Snl0WVdqcUxVcTZDSzVHcTN5MWJ2bThlY2VnS21FRFg0cEIzOWNhUGxzV3ZY?=
 =?utf-8?B?R3RYUXhwVUJlaGtVRWtHTmRsYy80YTJLZ0wxMkJlSVphM2NEV0dRdXMvQmNT?=
 =?utf-8?B?YTJKbjdUTGRad0dFcXVka005WXQ3UWFxenhZUU10dnptNU9BQ3BXWWxsZlZW?=
 =?utf-8?B?ZkJTVHVIUWRPNFU2a2FYWlVyUUVyN3EvWlluaG1WazBsSEpaRzVpU2hHd2sz?=
 =?utf-8?B?TkZJbVk0aXhscEVibDdZcWFxMUJLaHZMRzBnRmtmQ25LM2s4NmZWS1g3T0Y0?=
 =?utf-8?B?c1JDS2p3Sld1TUN3RDhZc3dRK2ZjY0NlbXVGcWdxMTAzL2FZUkh3eGV1bktj?=
 =?utf-8?B?MmRSakpkZmwvcjhuWjRYYXZlVFJHNWRqcFRYeVpzWCtnRk8yQmZVVlFYVHFX?=
 =?utf-8?B?dnczZkpjY1hMWGROQUw3QVB6N29GampQZGtKZWtEY1FwY0Q5Q3BVUStJamlT?=
 =?utf-8?B?UzZWdFA3MW8zQWRwS0huNWhPRVcxYVhUYWRYdUZydVVIRVZYVUIrQXBQOU9J?=
 =?utf-8?B?bms3SityZUl4SnBaNEhXTXYzODJUb0dzU2lSVjFwZVpOQmtGbEROQ0hYZjk2?=
 =?utf-8?B?UGhMWmZRQmpNL2VJVVBmZmhlNWhLcXdTNlRHS29YVy9LYXVQVGpCbjVLcFZG?=
 =?utf-8?B?TzJMdDdLMzJtRTNFZ3lxbHVLYmluVUtRZzhqMjVJdlEyQTE5VmpsM3RtY3Bo?=
 =?utf-8?B?YU41SzR4bDc4T0VnMjBmeWJwZDM3VDBBeE05SXJDaVFjMFdWSzhUU0VGZzRD?=
 =?utf-8?B?b2wvNUE5TzZ2bDRrcW1hNEJVSUh0MmF0elV5RHlieU9ITFRqZFo1UU1ETklh?=
 =?utf-8?B?RGl5RHF3d3ZIZHJNTFI4bUV6S2NBWkVBVHlDUWVrL3ZORVh1ZlhWbUhQNkpj?=
 =?utf-8?B?c0lyRGJUeUg3ekIxSUkvc212cGo5bU5lakJTMWFYdTFGRzRXOURhWGRGTytw?=
 =?utf-8?Q?gnMfeXiK?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c72440-b8e4-4d6b-a58a-08d8c159b134
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 17:50:24.0523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4IUc61cWqOzYPKZhFLuhOA9EIud0TeuaSeDuNT81Y3hUHcT+H+jztTwS6STiIxhRWtuA/Y+UA/9H4iVYMkFqE+sAOxrjwwrfeOTYxB48ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_125033_155542_8926C2E7 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PkhleSBNYXJrLA0KDQpPbiAxMi8xNC8yMCA1OjExIFBNLCBXdW5kZXJsaWNoLCBNYXJrIHdyb3Rl
Og0KPj4gVGhpcyBSRkMgMiBwYXRjaCBzZXJpZXMgd2FzIGNyZWF0ZWQgYXMgYW4gYWx0ZXJuYXRp
dmUgc29sdXRpb24gdG8gdGhlIHByZXZpb3VzIHNlcmllcyBJIHN1Ym1pdHRlZCBiYWNrIG9uIDgv
MjcvMjAyMCBbbnZtZXRfdGNwOiBpbnRyb2R1Y2UgcG9sbCBncm91cHMgYW5kIHBvbGxpbmcgb3B0
aW1pemF0aW9uc10sIHdoZXJlIG9ubHkgdGhlIGZpcnN0IHBhdGNoIGluIHRoYXQgc2VyaWVzIHdh
cyBhY2NlcHRlZC4gIFRoaXMgc2VyaWVzIGlzIGdyZWF0bHkgc2ltcGxpZmllZCBmcm9tIHRoYXQg
cHJldmlvdXMgcGF0Y2ggc2VyaWVzIGluIHRoYXQgaXQgZG9lcyBub3QgZXhwbGljaXRseSBjcmVh
dGUgbWFuYWdlZC90cmFja2VkIHBvbGwgZ3JvdXBzLCB3aXRoIHRoZSBpb193b3JrKCkgZnVuY3Rp
b24gcHJvY2Vzc2luZyBvZiBhIHNpbmdsZSBxdWV1ZSBwcmVzZXJ2ZWQuICBUaGlzIHNpbXBsaWZp
ZWQgcGF0Y2ggc2VyaWVzIHJlbGllcyBvbiB0aGUgYWNjZXB0ZWQgbmV3IHF1ZXVlIGNvbnRleHQg
YXNzaWdubWVudCB0byBzb19pbmNvbWluZ19jcHUgdG8gbG9naWNhbGx5IG1haW50YWluIHNoYXJl
ZCBwcm9jZXNzaW5nIG9mIGEgbG9naWNhbCBncm91cCBvZiBxdWV1ZXMgb24gdGhlIHNhbWUgQ1BV
IGNvcmUuDQo+PiANCj4+IFdoYXQgdGhpcyBuZXcgcGF0Y2ggcGFpciBwcm92aWRlcyBpcyB0d29m
b2xkLiBGaXJzdCwgaXQgaW50cm9kdWNlcyBjaGFuZ2VzIGFuZCBhIG5ldyBudm1ldC10Y3AgbW9k
dWxlIG9wdGlvbiAnaWRsZV9wb2xsX3BlcmlvZCcgdGhhdCBlbmFibGVzIHRoZSBrd29ya2VyIGZv
ciBhIGdpdmVuIHF1ZXVlIHRvIHBlcnNpc3RlbnRseSBnZXQgcmUtcXVldWVkIHVudGlsIHRoZSBx
dWV1ZSBpcyBzZW5zZWQgYXMgYmVpbmcgJ2lkbGUnLiAgSWRsZSBiZWluZyBkZXRlcm1pbmVkIGFz
IGJlaW5nIHdoZW4gdGhlcmUgaXMgbm8gbmV3IHJlcXVlc3RzIG9yIHBlbmRpbmcgYmFja2VuZCBk
ZXZpY2UgY29tcGxldGlvbnMgZm9yIHRoZSBzcGVjaWZpZWQgJ2lkbGVfcG9sbF9wZXJpb2QnIGxl
bmd0aCBvZiB0aW1lLiAgQnkgYWxsb3dpbmcgdGhpcyB0eXBlIG9mIHBlcnNpc3RlbnQgcG9sbCBi
ZWhhdmlvciBpdCBpcyB0aGVuIHBvc3NpYmxlIHRvIGludHJvZHVjZSB0aGUgY2FwYWJpbGl0eSBj
b250YWluZWQgaW4gdGhlIHNlY29uZCBwYXRjaCBvZiB0aGUgc2V0LCB0aGlzIGJlaW5nIHRoZSBh
YmlsaXR5IHRvIGhhdmUgdGhlIGt3b3JrZXIgZGlyZWN0bHkgcG9sbCBhIGJhY2tlbmQgTlZNZSBk
ZXZpY2UgZm9yIGNvbXBsZXRpb25zIGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgdGhlIE5WTWUgZGV2
aWNlIHRvIGludGVycnVwdCBhbmQgcHVzaCBvdXQgY29tcGxldGlvbnMuDQo+PiANCj4+IFRoZSBk
YXRhIGJlbG93IHNob3dzIHRoYXQgdGhpcyBuZXcgcG9sbGluZyBvcHRpb24sIGFuZCByZW1vdmlu
ZyBvZiBOVk1lIGRldmljZSBpbnRlcnJ1cHRzLCBjYW4gaGF2ZSBhIGJlbmVmaXQgdG8gcGVyZm9y
bWFuY2UuICBCdXQgaXQgaXMgdW5kZXJzdG9vZCB0aGF0IHRoaXMgY2hhbmdlIHByb3RvdHlwZSBo
YXMgc29tZSBkcmF3YmFja3MsIG9uZSBzcGVjaWZpY2FsbHkgYmVpbmcgaG93IHRoZSBudm1ldC10
Y3AgbW9kdWxlIGlzIGJlaW5nIGFsbG93ZWQgdG8gZGlyZWN0bHkgY2FsbCB0aGUgbmV3bHkgaW50
cm9kdWNlZCBibG9jayBsYXllciBwb2xsIG9uY2UgZnVuY3Rpb24gd2hpY2ggY2FuIGJlIGNvbnNp
ZGVyZWQgYSBsYXllcmluZyB2aW9sYXRpb24uICBCdXQgaW4gaXQncyBjdXJyZW50IHN0YXRlIHRo
ZSBwYXRjaCBzZXJpZXMgYXQgbGVhc3QgaXMgYSBtZWFucyB0byBvcGVuIGRpc2N1c3Npb24gdG93
YXJkcyB0aGUgYmVuZWZpdHMgb2Ygd29ya2luZyB0b3dhcmRzIGVuYWJsaW5nIHN1Y2ggYSBwb2xs
aW5nIG1vZGVsLiAgSXMgaXQgYSBzb3VuZCBjb25jZXB0LCBidXQgYmVzdCBpbXBsZW1lbnRlZCBp
biB0aGUgbnZtZSB0YXJnZXQgY29yZSBsYXllciBpbnN0ZWFkPyAgTWF5YmUgbW92aW5nIGF3YXkg
ZnJvbSB1c2luZyBrd29ya2VycyBhbmQgaGF2aW5nIG1vcmUgZGVkaWNhdGVkIGNvcmUgc2Vydmlj
ZSB0YXNrcyBmb3IgbG9naWNhbCBxdWV1ZSBncm91cHM/DQo+PiANCj4+IFRoZSBmb2xsb3dpbmcg
dGVzdCBkYXRhIHdhcyBjb2xsZWN0ZWQgdXNpbmcgdGhlIGZvbGxvd2luZyBjb25maWc6DQo+PiAu
IEZJTyBpb191cmluZywgdXNpbmcgSElQUkkgb3B0aW9uDQo+PiAuIDQgRklPIGpvYnMsIGVhY2gg
ZGlyZWN0ZWQgYXQgMyBOVk1lIGRldmljZSBuYW1lc3BhY2VzLCBlYWNoIHdpdGggNCB0aHJlYWRz
IHBpbm5lZCB0byBpc29sYXRlZCBOVU1BIG5vZGUgQ1BVIGNsb3NlIHRvIE5JQyBmb3IgdG90YWwg
b2YgMTYgYWN0aXZlIHRocmVhZCBjb25uZWN0aW9ucy4NCj4+IC4gNEssIHJhbmRvbSByZWFkIEkv
TyBwYXR0ZXJuDQo+PiAuIFF1ZXVlIERlcHRoIDMyLCBCYXRjaCBzaXplIDgNCj4+IC4gSW5pdGlh
dG9yIE5JQyBIVyBxdWV1ZXMgc2V0IHRvIDUyIChudW1iZXIgb2YgbG9jYWwgTlVNQSBjb3Jlcyks
IEhXIHF1ZXVlIGFmZmluaXR5IHNldCB0byBsb2NhbCBOVU1BIGNvcmVzLg0KPj4gLiBUYXJnZXQg
TklDIEhXIHF1ZXVlcyBzZXQgdG8gOCAsIEhXIHF1ZXVlIGFmZmluaXR5IHNldCB0byBsb2NhbCBO
VU1BIGNvcmVzLg0KPj4gLiBJbml0aWF0b3IgdG8gVGFyZ2V0IGNvbm5lY3RlZCB1c2luZyAxIGRl
ZmF1bHQsIDMyIHBvbGwgcXVldWVzLg0KPj4gLiBXaGVuIHRlc3Rpbmcgd2l0aCAnaWRsZV9wb2xs
X3BlcmlvZCcgZW5hYmxlZCwgdG8gdGVzdCBwb2xsaW5nIE5WTWUgZGV2aWNlcywgdGhlIHRhcmdl
dCBOVk1lIG1vZHVsZSBsb2FkZWQgd2l0aCBtb2R1bGUgb3B0aW9uIHRvIGVuYWJsZSAxNiBwb2xs
IHF1ZXVlcy4NCj4+IC4gUGF0Y2hlcyB0ZXN0ZWQgYW5kIGRldmVsb3BlZCBvbiBsaW51eC1udm1l
IG52bWUtNS4xMCBicmFuY2guDQo+PiAuIEFsbCBtZWFzdXJlZCB0aW1lcyBpbiB1c2VjcyB1bmxl
c3Mgb3RoZXJ3aXNlIG5vdGVkLg0KPj4gLiBGZXdlciB0YXJnZXQgSFcgcXVldWVzIHZzLiBudW1i
ZXIgb2YgYWN0aXZlIGNvbm5lY3Rpb25zIHRvIG1lYXN1cmUgdGhlIGltcGFjdCBvZiB2aXJ0dWFs
IGdyb3VwaW5nIG9mIGNvbm5lY3Rpb24gcHJvY2Vzc2luZyBvbiBzaGFyZWQgdGFyZ2V0IGNvcmVz
Lg0KPj4gDQo+PiBCYXNlbGluZSAtIHBhdGNoZXMgbm90IGFwcGxpZWQNCj4+IElPUFMoaynCoCDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEF2ZyBMYXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgOTkuOTnCoMKgwqDCoCA5OS45MMKgwqDCoMKgIDk5LjAwwqDCoMKgwqAgU3RkZXbC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDb250ZXh0IFN3aXRjaMKgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVGd0LiBDUFUgVXRpbC4NCj4+IDE5MTDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI1Mi45MsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgNjg1wqDCoMKgwqDCoMKgwqAgNTc4wqDCoMKgwqDCoMKgwqAgDQo+
PiA1MDLCoMKgwqDCoMKgwqDCoCA5OC40NcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH4yMTVLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgDQo+PiA4MDEuMzcNCj4+IA0KPj4gUGF0Y2hlcyBhcHBsaWVk
IG9uIHRhcmdldCAtIG1vZHVsZSBvcHRpb24gJ2lkbGVfcG9sbF9wZXJpb2QnIG5vdCBzZXQuDQo+
PiAyMTUywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyMjMuMzHCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDY4NcKgwqDCoMKgwqDCoMKgIDYxMcKgwqDC
oMKgwqDCoMKgIA0KPj4gNDI0wqDCoMKgwqDCoMKgwqAgOTIuMTHCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB+MTIwS8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIA0KPj4gODgyLjE0DQo+PiANCj4+IFBh
dGNoZXMgYXBwbGllZCBvbiB0YXJnZXQgLSBtb2R1bGUgb3B0aW9uICdpZGxlX3BvbGxfcGVyaW9k
JyBzZXQgdG8gDQo+PiA3NTAwMDAgdXNlY3MuIChOVk1lIG1vZHVsZSBub3QgZW5hYmxpbmcgcG9s
bCBxdWV1ZXMpDQo+PiAyMjI3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAyMTYuNjXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDYyN8KgwqDCoMKgwqDC
oMKgIDU1M8KgwqDCoMKgwqDCoMKgIA0KPj4gMzg4wqDCoMKgwqDCoMKgwqAgNjkuNDjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB+MTAwLTQwMMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIA0KPj4gOTM0LjM1DQo+PiANCj4+
IFBhdGNoZXMgYXBwbGllZCBvbiB0YXJnZXQgLSBtb2R1bGUgb3B0aW9uICdpZGxlX3BvbGxfcGVy
aW9kJyBzZXQgdG8gNzUwMDAwIHVzZWNzLiBOVk1lIG1vZHVsZSBsb2FkZWQgZW5hYmxpbmcgMTYg
cG9sbCBxdWV1ZXMuDQo+PiAyNzc5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAxNjguNjDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDU0NcKgwqDCoMKg
wqDCoMKgIDQ3NMKgwqDCoMKgwqDCoMKgIA0KPj4gMzc1wqDCoMKgwqDCoMKgwqAgNTMuMjTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB+MTAwLTQwMMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIA0KPj4gODAyDQo+PiANCj4+
IFRoaXMgZGF0YSBzaG93cyB0aGF0IGFkZGluZyB0aGUgbmV3IGlkbGUgcG9sbCBvcHRpb24gZG9l
cyBub3QgaW1wYWN0IHBlcmZvcm1hbmNlIHdoZW4gbm90IHVzZWQuICBXaGVuIHVzZWQgd2l0aCB0
aGUgYWRkaXRpb24gb2YgZGlyZWN0IE5WTWUgZGV2aWNlIHBvbGxpbmcgZm9yIGNvbXBsZXRpb25z
LCB0aGVyZSBpcyBhIG5pY2UgcGVyZm9ybWFuY2UgYmVuZWZpdC4NCj4+IEl0IHdhcyBub3RlZCBk
dXJpbmcgdGVzdGluZyB0aGF0IGxvZ2ljYWwgZ3JvdXBpbmcgb2YgcXVldWVzIHRvIGNvcmVzIG9u
IHRoZSB0YXJnZXQgY2FuIHZhcnkgYXMgYSByZXN1bHQgb2YgUlNTIHdoaWNoIHdpbGwgb3Igd2l0
aG91dCB0aGlzIHBhdGNoIHNlcmllcyB3aGljaCBjYW4gdmFyeSB0aGUgcGVyZm9ybWFuY2UgYWNo
aWV2ZWQsIGJ1dCB3aGVuIHVzaW5nIHRoZSBwYXRjaCBzZXQgd2l0aCBkaXJlY3QgTlZNZSBkZXZp
Y2UgcG9sbGluZyB0aGVuIHRoZSBsb2dpY2FsIHF1ZXVlIGdyb3VwaW5nIHdhcyBtb3JlIGNvbnNp
c3RlbnQgYW5kIHBlcmZvcm1hbmNlIHZhcmllZCBsZXNzLg0KDQo+U28gaXQgZG9lcyBzZWVtIHRo
YXQgcG9sbGluZyB0aGUgYmFja2VuZCBkZXZpY2VzIGRvZXMgaGF2ZSBtZXJpdCwgYW5kIHRoZSBj
b21tYW5kIHRyYWNraW5nIGluZGljYXRvciBpZiB3ZSBzaG91bGQgcG9sbCB0aGUgYmFja2VuZCBk
ZXZpY2VzIGlzIGFuIGludGVyZXN0aW5nIGlkZWEuDQoNCj5Ib3dldmVyIHRoaXMgc2hvdWxkIHNv
bWV0aGluZyB0aGF0IHNob3VsZCByZWFsbHkgYmUgaGFuZGxlZCBieSBudm1ldCBjb3JlLiBXZSBj
b3VsZCBwb3RlbnRpYWxseSBhZGQgc29tZSBjb3VudGVycyB0byBudm1ldF9zcSBhbmQvb3IgbnZt
ZXRfY3EuDQoNCj5NeSBkaWZmaWN1bHR5IGlzIHRvIHVuZGVyc3RhbmQgaWYgd2UgY2FuIG1vdmUg
dGhlIEkvTyB0aHJlYWRzIGZyb20gdGhlIHRyYW5zcG9ydCBkcml2ZXJzIHRvIHRoZSBjb3JlLiBS
aWdodCBub3cgdGhlIEkvTyBjb250ZXh0cyBhcmUgcHJvdmlkZWQgYnkgZWl0aGVyIHRoZSB0cmFu
c3BvcnRzIG9yIHRoZSBiYWNrZW5kIGRldmljZXMuIElGRiB3ZSB3YW50IHRvIGV4cGxvcmUgdGhp
cyAoYW5kIGFzIEkgc2FpZCwgeW91IGNsZWFybHkgc2hvd2VkIGl0IGhhcyBtZXJpdCksIHdlIHdv
dWxkIG5lZWQgdG8gZXhwbG9yZSBpZiBtb3ZpbmcgdGhlIEkvTyBjb250ZXh0IGFuZCBidWlsZCB0
cmFuc3BvcnRfcG9sbC90cmFuc3BvcnRfd2FpdCBzb3J0IG9mIGludGVyZmFjZSBmb3IgdGhpcy4N
Cg0KSSBjYW4gdW5kZXJzdGFuZCB0aGUgYXJjaGl0ZWN0dXJhbCBkaXJlY3Rpb24gdGhhdCBzdWNo
IGEgcG9sbGluZyB0aHJlYWQgaXMgYmV0dGVyIHRvIGJlIHBlcmZvcm1lZCB3aXRoaW4gdGhlIGNv
cmUsIG15IGluaXRpYWwgZ29hbCBiZWluZyBpc29sYXRlZCB0byBkZW1vbnN0cmF0ZSBnb29kbmVz
cyB3aXRoaW4gVENQIGltcGxlbWVudGF0aW9uIGl0c2VsZiB3aXRoIGFzIG1pbmltYWwgY2hhbmdl
IGFzIHJlcXVpcmVkIGluIG90aGVyIGFyZWFzLiAgSSBob3BlIGEgbW92ZSB0byB0aGUgY29yZSBj
b3VsZCByZW1haW4gYW4gb3B0aW9uYWwgZmVhdHVyZSB0aGF0IG90aGVyIHRyYW5zcG9ydHMgd291
bGQgbm90IGJlIGV4cGVjdGVkLCBvciBmb3JjZWQsIHRvIGFjY2VwdC4gIFdvdWxkIHRoZSBiZXN0
IGFwcHJvYWNoIGluIG1vdmluZyB0byBhIGNvcmUgY2VudHJpYyBtb2RlbCBiZSB0byBmaXJzdCBp
bnRyb2R1Y2UgdGhlIGNvcmUgc3BlY2lmaWMgdGhyZWFkIGNvbnRleHQgb3B0aW9uLCB0aGVuIGZv
bGxvdyB0aGF0IHdpdGggdGhlIGNoYW5nZXMgdG8gYWxsb3cgbm9uLWJsb2NraW5nIGRldmljZSBw
b2xsaW5nIChhbmQgd2hhdGV2ZXIgcmVxdWVzdCB0cmFja2luZyBtYXkgc3RpbGwgYmUgcmVxdWly
ZWQpIGZyb20gc3VjaCB0aHJlYWQgY29udGV4dHM/DQoNClRoaXMgUkZDIHdvdWxkIGFsaWduIHdp
dGggdGhpcyBwaGFzZWQgYXBwcm9hY2gsIGdpdmVuIHRoYXQgdGhlIGZpcnN0IHBhcnQgaXMgdGFy
Z2V0ZWQgYXQgaW1wcm92ZW1lbnQgdG8gaW9fd29yaygpIHRocmVhZCB0byBiZXR0ZXIgc2Vydmlj
ZSB0cmFuc3BvcnQgaW50ZXJmYWNlcyB0aGF0IGJlbmVmaXQgZnJvbSBhIG1vcmUgYWN0aXZlIHBv
bGxlZCBtb2RlbC4gIFRoZW4gdGhlIHNlY29uZCBwYXJ0IHRoYXQgZm9jdXNlZCBvbiBlbmFibGlu
ZyB0aGUgYWJpbGl0eSB0byBoYXZlIG5vbi1ibG9ja2luZyBwb2xsZWQgYWNjZXNzIHRvIE5WTWUg
ZGV2aWNlIHBvbGwgcXVldWVzLg0KDQo+VGhpcyBjYW4gYmUgZG9uZSBmb3IgdGNwL3JkbWEgYW5k
IGxvb3AgZm9yIHN1cmUsIGJ1dCBJJ20gbm90IHN1cmUgd2hhdCB3ZSBjYW4gZG8gZm9yIEZDIChi
dXQgbWF5YmUgdGhpcyBpcyBwb3NzaWJsZSwgbmVlZCB0byBsb29rIGZ1cnRoZXIpLg0KDQo+QWRk
aW5nIENoYWl0YW55YSB3aG8gbG9va2VkIGludG8gZGV2aWNlIHBvbGxpbmcgaW4gdGhlIHBhc3Qg
dG8gZ2V0IGhpcyBmZWVkYmFjayBpZiB0aGlzIGlzIHNvbWV0aGluZyBpbnRlcmVzdGluZy4NCg0K
QWgsIHdvdWxkIGJlIGdyZWF0IHRvIGhlYXIgeW91ciB0aG91Z2h0cyBvbiB0aGlzIENoYWl0YW55
YSwgZ2l2ZW4geW91ciBleHBlcmllbmNlLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=

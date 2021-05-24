Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E413C2B9F7
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 00:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492986141C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 00:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492986141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VUw7Lm/tep6Ftczlp1zUWtbJ5F/Z1TqesWYKKgzhd4I=; b=bx4nXokTeGT9S1
	bcOLyw2ksi0ba5O6k9m5FF2HIhnKoQzgT2vvnMc69Xgmn+3FQ+BNjXjVC1uoBw1n+Gwralwsr033I
	eORAfYFeIUU9V1F8xTOenrGjDcjfXCSE8Uz8NpWYQv0tqYJlLn9sNv3SpjxOnY6Zj0ATJmVtsHH9P
	p+BJkFMqgwI3jj2SDq/DRGS3tvEjvIQ3mteF+/UwCgksb7N8MYqKmcRMv7y5YxxHykBAiAPsJzIwm
	apYGVT33WMIUU9q5J6/wpAMA/Fsr1GdPmTeoGrJqZ5ZkCqljhmIfdUXnMM0ISug+RuoBuZ3ZRXnep
	4H9Juz/n3vr2H9QA6KHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llL2D-002aG8-J8; Tue, 25 May 2021 00:35:02 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llEEO-001FVA-Ej
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 17:19:10 +0000
IronPort-SDR: h6B4vcEqj29yIg8rP0zjhKrZbcCFkqsvxnpfQm1XJvFrBSeBU3jc5aBVHQBud44DX5nVugTKG/
 EYfxZ05LP//g==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="202008079"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; d="scan'208";a="202008079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2021 10:19:04 -0700
IronPort-SDR: Yo2LZ4nXKF06yUtm/0KyyWFjqNDsxsouS3pc6V7y0ZOqXBGCj4ek8GiPD92NjQfAdIxUZmYJxP
 MIbksBKeZETA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; d="scan'208";a="442128855"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP; 24 May 2021 10:19:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 24 May 2021 10:19:03 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 24 May 2021 10:19:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 24 May 2021 10:19:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 24 May 2021 10:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDmzwfcb/Wf3NKmPa/z1dsh77SvsLPn7/jyxv6A3g4hjbCFTz5hFWHeapdfLdSWI9iyTYWnohfwzqLi6kNykY4jPzEVtmW1O7TyxocTCLJGIfcBoUMubeIwsyPRSA2vuhnFHRZrbdICQcxoXUIr3+4jlEeONYOhR60dZrG7cQ5TqqL5DNJIkYqbUwogU4mK3X9iYvjYHv7DldChhV655athu0tYGXbCBhUDTXNkHaqKH+R2888LqpjNjzMoUnw3yLMCcMyVZR08615iouY0s3dyF1Dp3rbA8yTVjbEK33pxpXn9q0NWz2thHY6iI+gJHJmJ0gm6HanoEJ/xg+pRv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cKXhHDse38XAdPt1i/FNbQHMH3B8+V4bN3iu9HVTN8=;
 b=FEkF7SmQWaLBpE3oDZwHqC7xnhEP0SP46JsHVPHWJjHZHrdnYpmfYjI+rs6q6TzqKjhcQe05EZriNHyX/DF27LjPhhyfDHbpLL4XsUtRQ3MxMNwn9+uPJGajHWmUz7GbfWUuhhcsz9EsdkRDaA6d30i405XbTEyCzrUSp/o5+esmQ/9a9LiVgGb+EO096NhbiD36XslTvn8M6YovjNqzclLULCmDxvRuRgioAO4vMsQSkb/dR2OpgpX40WnouRC/6J453L85sxQrncDndHAEFqDEeMgpUd6HgzgZ8E+e7LENdHXhHD0AonuvcfSTmMYEYOZSG5MdXJKHcvqsOLWOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cKXhHDse38XAdPt1i/FNbQHMH3B8+V4bN3iu9HVTN8=;
 b=WBe+q5H5gL8SqFxQsfdGvWwv2nZCqHD3/o4JvWpqJT8ItO5oz0wApF3h3tO5qq/ZwOoMIQwu1CHUUTkWh/bWyWT8aiyl7XDlnA4l83MXjXI8nhLfiK7Y15/58w+MkcNhXMoQoo0C0e4y09xFvc0m3NZiUTuxFcHsXvtyiKCBju0=
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 17:19:00 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::9958:3f0a:9dff:ccc4]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::9958:3f0a:9dff:ccc4%6]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 17:19:00 +0000
From: "Walker, Benjamin" <benjamin.walker@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [bug report] nvme sends invalid command capsule over rdma transport
 for 5KiB write when target supports MSDBD > 1
Thread-Topic: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Thread-Index: AddQv97rUefW+8weSYm6BKNNw82QzA==
Date: Mon, 24 May 2021 17:19:00 +0000
Message-ID: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [70.190.226.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7e2caec-714a-41f6-fcca-08d91ed805cd
x-ms-traffictypediagnostic: SJ0PR11MB5007:
x-microsoft-antispam-prvs: <SJ0PR11MB50071A8EDDA0E2C916B8A435EF269@SJ0PR11MB5007.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dAqcc1Yjik/UBQ8AQKj7MZG+xB0LBKRBTiSTHUmmkPjhCIqtxsFtvRwy3lQ9ipUV6YxWnnAHoF6Xg3/N0jEVtS3f/Vc0Is85Alok7Bkb32gk9/JUNbECLHuJlqRWSxA52yfCJqBKWH2ED51H9268+VYPtXwdO62fUBF5EpBVtRzWr8F6Rq/Q34V5jlm9Ytp7CBDQWleLpMIvzNFzEKY1i/NcDI4AU2NRYVFkw9OtyWC/CB4kXgs3bRqK9Uxox2DaxF4yUEKZ7KQLNZq+nBl5eXuowL/xHw2gPHnhyen8w21jErN3vCdLBs2vyAAoXKFfHMn45FDDvEOPYrXNTD1hSfxvqg5LNXvC6SBuxqwyUvTTeOogemVMBtt8BLFM7b38/ZM7bq0M7Z9SYuEvY7OIYSPuVcC8Mhadb/t29TvjDSYqQ4MOxiCh/tqZXI/Q9/Tkl/OZowqNJ9hh9yzHExsbqNjrAPOYItT2SJXC3yqiwXVVJtXlNJR2LJV7JV4HtnzoyyydmtURDKAFG583r/Fd6lwEkyP8/Q/1ASckCNxQVLsQXFA/HDP76T5B+i//3NOjFpd0wp5+X3tA/h6i1Q7Hz9+ErGi8k3/wJacEGjqYAI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(39860400002)(136003)(396003)(366004)(64756008)(6916009)(66946007)(6506007)(33656002)(5660300002)(66556008)(76116006)(26005)(66476007)(316002)(478600001)(55016002)(122000001)(38100700002)(71200400001)(7696005)(9686003)(4744005)(8936002)(86362001)(52536014)(66446008)(83380400001)(8676002)(186003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KXweSjr0Zot/hOqF1/ywV/JeoJBDm2bkZ7/17V/AUZBDfVhZ7H4pggCE7KNR?=
 =?us-ascii?Q?S9i6+9vzLkcGdIftAgxsMuwtt330HQs+gGSqB52RxKylG3aijOEBcwetsoTB?=
 =?us-ascii?Q?OPZAiYakCjsNdtWi+2IIrOWJUBFDXQMy2ssVaToOsk2fSUuXm4U6qhmsKA+J?=
 =?us-ascii?Q?i7qdCcF2cG1dGp4BIvp2RBsYMPReeD95wJQvf8v92r4dA9TeE4nZcz4Al9d9?=
 =?us-ascii?Q?MCXbT9/gYAEWE7QfVD38Vms3fnqCjRgqZg5/XxozgYloy4F7eBJ0tbz8+0as?=
 =?us-ascii?Q?IbY6XfDZoMcLH4Ldm3XVx73nxf06mPdnEPu7qOOy3JiutDmoP6XN8bxZ4v+G?=
 =?us-ascii?Q?DWMoi1QzTa+Difwe2GiRbQOnvfm4pUmNaLpVrgicomdU8+2kEdG0GoPohtJ5?=
 =?us-ascii?Q?p0iLiaZzjkxGx4qC/Uu6FuqZo+I/XpyjVhdpOpuDHJineeQ2mPrUl5lanbXs?=
 =?us-ascii?Q?TY/Kaz6VeC3T9KtkgfOcCLb//os8s8lKrW+iaVj2XFQFdNqH+kbz1AUDsxJb?=
 =?us-ascii?Q?n+PP/mOp5I37rozzWUX+xIHmysjMQZ5ULhbngWcmtOCVGfg+jcJekB4i6xVH?=
 =?us-ascii?Q?v5caNb8deEAJRV4uuCXqhcVzB/b6O7W9xVcnxkVy1/yXwJvqChFf7D+iDKAX?=
 =?us-ascii?Q?nb7Tp6jfhm3Kgjs8i0cJ1RIflnhNL0P0UNdjskok7YVzDeQsVn3gVAlbLplh?=
 =?us-ascii?Q?IoLloXrD12rCr+zfim1CgtZHey+jd2bBiwV9pByugut923ynxPGwF/KWWSh3?=
 =?us-ascii?Q?PmfQUr4lFbkziVqLIyUPcBy3kvB7SqM28mTbVoThL//1zo15fa/IRhKd1OS/?=
 =?us-ascii?Q?7Sf00Tlff8BH/X6Q5J56bNzgkKCkH6MMdCO29hWa0SPVgb7Zxo+78v5a3NM4?=
 =?us-ascii?Q?3TZ/x02m2xvbSIrJZU/eif2geBiooF89kcbZDuLXblCNFTQSPLMpNRvnj6sw?=
 =?us-ascii?Q?RsotOGw2thkDFrT6yWQh9oV5FV2amx9Ilgk4AdeBC/rN7LbAyZ9FYLuZ6F2m?=
 =?us-ascii?Q?7pTfBNpLHnb7yIYn2A4bhLLBqVr30/NqtjP6UIsnoksxl+sT2wxKRuFdTe05?=
 =?us-ascii?Q?cfgAe7Kgiw+WR5MayMalA6CHapxLfyycQZefP9p03BB3go+/rL5xFwNfmDYi?=
 =?us-ascii?Q?74sM1DmMagAaWcC1vs5UbNIG04Qur9Y4IKz3AJ+2uQIajOhJiUyQdgmI2At8?=
 =?us-ascii?Q?9pi3dlTe35IPkqW/aSNzgMqyG5RGeFRwlZXDeWvIbRpqRtyPVBi5jwGXgMQe?=
 =?us-ascii?Q?P5mB1cBc5HZ5+B19T1xPimu4lKkBtpGThxAApXmi4GfqvewhH30dy8Yrec6J?=
 =?us-ascii?Q?9ByCNsA086YcxkC0tiezyT47?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e2caec-714a-41f6-fcca-08d91ed805cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 17:19:00.7471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZvDrtubhQfeBt6nAeojsWb0Kl3GVhbSV5zKUv82Y24SwaC8Aia/6u8uObcqUN/INyVT4DlVPFoZPMOS6tASi2Flz3AR6QsUELNclaTHNts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_101908_645072_72F37FF2 
X-CRM114-Status: GOOD (  10.53  )
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

This bug was found using the iozone tool.

- Linux kernel initiator, SPDK target, RDMA (RoCEv2) transport
- iozone is performing a 5KiB write to a 512 byte block size nvme device
- The SPDK target has reported that it supports 4KiB of in-capsule data, MSDBD of 16 (number of SGL descriptors), and ICDOFF of 0.
- The Linux kernel sends an NVMe-oF capsule with a command that claims to have 5KiB of data in the command, but actually only has a single SGL element describing 4KiB of data in-capsule.
- The SPDK target correctly fails this I/O

This fails on at least 5.11 but worked prior to 5.4. A git bisect shows that this commit is responsible: 38e1800275d3af607e4df92ff49dc2cf442586a4

I believe the key is the use of MSDBD > 1 and in-capsule data support. This seems to trick the initiator into thinking it can do 5KiB in one command with two SGL elements, but then the initiator goes down the in-capsule data path and can only describe 4KiB that way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

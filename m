Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1395C47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 20:22:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A3C613B5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 20:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A3C613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zUi5GlfGSVAApI0EEqz9qoP6/7q28eljJWQFlD1qIM4=; b=ykYAfE4wePIU7W
	vzjjG85hIl1cWT1jIfH4Ijd5i4fY89pWnYAceMBl4xwrbHHB0qD2onWaz7m7Mc/fF9QbfB7t/ECBT
	eaYYoK09v0yMKOjD+Cgnpj3+7MQI00ug0bRoaVemtKmlEAtv7Cj+JOQiHEZMbtdRkHpufWPV4XXDF
	XhqEnGt99FcPF6e/lsXUlWS6AWd9CaHXSzqnHU29TZZJcvcyou/ZZ1DHvZ1OijUKL8W9S6atGIUDc
	ZWlKwlUq7rm8SWvJc+nU3o6Cs2MnGqbSF7Yd2P8lcplsBN+51jziigqIsKmS5nynGyH3QJAu+Tmyf
	zz/4vuG65qxg6qF9JhaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm02R-00HLxd-Pa; Wed, 26 May 2021 20:22:00 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llzDq-00GyQV-T3
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 19:29:44 +0000
IronPort-SDR: /ceI3/BazfALRmYmRzYfAfEyZDuZ6cNR3mL7qliwtVfzhQmAT/u7H2HxN75CeB5zIPioeHn7ov
 kjhHrEmm7Ubg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="199506316"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; d="scan'208";a="199506316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2021 12:29:38 -0700
IronPort-SDR: YLzA7i2BTWmK4DvAVzGudLvnt3TF+0d7uAQUZ3d88f19saFF1qgwmi5qDv4aR9vcj/QOrXpFBF
 crDe9V6Y1unQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; d="scan'208";a="547333613"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga004.jf.intel.com with ESMTP; 26 May 2021 12:29:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 26 May 2021 12:29:36 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 26 May 2021 12:29:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 26 May 2021 12:29:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 26 May 2021 12:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBdMSVbri3pxdllkJGSt8g7G1+jivPFDLW+U7E1ScwHM3oyCCkr5K8wvdRAjiNBYYyytCt4XPeIZtoVOdu/biu2y7KGnSBMUaYmDQWi0ISvwam3vz0mSJzc/ipLarOg2zsHr6q6Gr8H82ZUUM4PXR3n8J6w6HmGc1uNRugBHjugvFkpgktg3fXYwEnfhRBzMmZcyQVn2vhOlkVUjm5ARFfRxhg11OxHUxGB5n1tAY2fepTabA4xQA6eNBlk6uiiU61AgZMgEbKmWzWhyXfTacsi526FUyz3SiyD/+CjMszEDcWQjyCcL6sFWtucDdfCxVO2rS1M85nKlJmh+m9KzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvPMKmhKZ3VuPRl4WwqpkI7FN5uRCR6+rAmNsvcLV+A=;
 b=IMvR1lY2KrUindByX4TGiyn053vNfQam0WHlZwC0sJ62BTWT9kEV9iFOLPIDj8q25YvkKstjc37wXgiq0Tnv/6D3UhLdmWJqOHR6rB3d+trIjXoqnZFEcSqSJ5jzofQvaoRkCmDp7I8T5sHHyOQ4967pcid2wOxzpjgpnpkEMhrhgfryIVzmkWCGkg7ccng7HP1xHRgkycs9IQ9GTG8bXSaZwPRk1cqXmnCraEGEH15BkQvwoYegJ9uSxJ8cpWiNYsQYOB6E80D5wUb2EgudKfTgr490Yzn648Jln/OMabaP8UQjDRvwMj0SScacWRtXaYzW3dJYZtgYPVNOyJsKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvPMKmhKZ3VuPRl4WwqpkI7FN5uRCR6+rAmNsvcLV+A=;
 b=YYZmDxpbPrd5VhUPXHE/DMQ5bcwe83we9uD4DB2yUFE4/087237v1OYiPx7whfBhhZlgk2qAa8sTsSRAAHSK4cS9MXs+ktvkhfqpxbwNec26sLeKcBe0XrtvDMjAr5YsFmv9dC83EH/bYrsQKjXevgUrKY9I6S4sQACcT0taye4=
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by BYAPR11MB2709.namprd11.prod.outlook.com (2603:10b6:a02:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 19:29:12 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::9958:3f0a:9dff:ccc4]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::9958:3f0a:9dff:ccc4%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 19:29:12 +0000
From: "Walker, Benjamin" <benjamin.walker@intel.com>
To: Christoph Hellwig <hch@infradead.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Thread-Topic: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Thread-Index: AddQv97rUefW+8weSYm6BKNNw82QzABT1UAAAApu4wAAAVsMgAACdbmAAAchNAA=
Date: Wed, 26 May 2021 19:29:12 +0000
Message-ID: <BYAPR11MB28243491DCC2652BF5A419C7EF249@BYAPR11MB2824.namprd11.prod.outlook.com>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
 <YK5W7F5DD4grBZLB@infradead.org>
 <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
 <YK5wh91yAcOlu+3J@infradead.org>
In-Reply-To: <YK5wh91yAcOlu+3J@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [70.190.226.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8edd0b22-3efd-4ee7-a594-08d9207c8aba
x-ms-traffictypediagnostic: BYAPR11MB2709:
x-microsoft-antispam-prvs: <BYAPR11MB27090CB4F4AF42BDF1FB0769EF249@BYAPR11MB2709.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAQtSnYA+vrIU2JG8qmNRd+rLWs/yCfjhNefA/+IWEh1k9jLWQoqnJiNr9WrxiRz8WRVktsNsjNQY8KV/hklV+Xa1vRPVBmfRqkddefOHLqTP1sLhtXTln0ynbihI715vB8IGjF1qGdRwN/EVDACYevYH7Qwqek3LDbPJBSJzl3loXZMfOerdcPILqARvbMCeeRIqBJoG0Mrgh7g0c6sCLg0XCSgWZBnoMg4PdaUHKiyMDmi94cACTLwO1rR+kXQyw5kx4AJBsvXKXQ7qaDjM3gPUeNcSJI5+F1Z9oGF1bXxUKXAvQTmwdbHN/x0psdvO4zw3n69Zsrkm41iAaazizmkwWiXMNG8sy9miYUoVBGAv/xnuyDTChC9FrQx0JsrY8rOaihLuSY5COWHuG7Pm8yW4P99gwIhDYJX7Kozsuwh+qjAZ5Nj1PWSRBgWyQBajJg/TvH5VvVUk4HX1actCM9qbl1af4vgZKR83Aq+l9zUx+PJMPdd9A1jicGKByl+0PSpnf+AVxwfHeV8+rRym0wZIQu0ZWd63bS7Yv0RMZb6DyMItg/9iVrSDh7ZcDNOJZTWIQmQioVBtFQdgFiOA4Xk7ShMAz1bbBCSXXeQqn0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(39860400002)(346002)(396003)(366004)(186003)(26005)(2906002)(52536014)(66446008)(76116006)(64756008)(5660300002)(33656002)(66946007)(66476007)(66556008)(122000001)(83380400001)(110136005)(86362001)(6506007)(7696005)(54906003)(38100700002)(8676002)(9686003)(478600001)(4326008)(71200400001)(55016002)(316002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MPvv6Gh9mgxdT+lkaA7RNTBPh2riYRFx6OQrco/+pIgx5reS0+1VLwSjgZZV?=
 =?us-ascii?Q?gRzd/rCAovcxopg+2n3Rg6xEnHoD6Ct4a043eVgRZRr0vuVeeQZgTAKAHHJ6?=
 =?us-ascii?Q?DN2vCHuj1E+e0Ufn4G4WFbUafpqOd+HTN/9TiaLvqgbabrTaFOGtgekc5IpV?=
 =?us-ascii?Q?aGkRXTcF5OgsqM81ru3pwafAYefpHlLhKIdjtvif3ZL1H0GyKnbtKecjMv8K?=
 =?us-ascii?Q?L9G85hbcJwg+q1zg4kq29fkMKjVNuyynr0GA2vPF91Bz+8m8ergLPOXjed9H?=
 =?us-ascii?Q?LGpSIzbGQzEEftJcyUah11Bo0+he1YbiFwAT2UO3XadehOpVmGV6SVOZ27rc?=
 =?us-ascii?Q?540PPyL/RRmdPszHWtM/AOWCG9fNdE8nZ20jXkjf9+QwhiAefy0xQBGMJGlh?=
 =?us-ascii?Q?k/z7SZsiGoSfqFXVRw503O/CsWMGVfB+sW9Ra65FyqjemSRlsML6AH5wP1k5?=
 =?us-ascii?Q?iNp7clSMyvr4zLyGwMBR5pP1771P18xj8sG8EIiqux1WfXYVj9MdpjafBMox?=
 =?us-ascii?Q?1jBLhxuxPl9Yo/LHFea4HDe78guF7rnTqYF51g2DF/zPViotKTikd84StBoF?=
 =?us-ascii?Q?Tz5IOMax/gcOBJe4AngBn+M0dJ3WSNAIg74mZ0oj/JQkgfmM4huGJ0iTLEUc?=
 =?us-ascii?Q?20bRrrlQVrafgfY6KWuGd6oO5VEPF0Nz2Cav8UN2ZeGTzadAbISpWLVHaU2t?=
 =?us-ascii?Q?zmF/WIt72itEGk8XtYU/7NUYwRCgC57QDPZYzt88pSIWRlGxNUj4ZvujXTgj?=
 =?us-ascii?Q?4H8jl5LzahZSnn06ctPMCEEtAn9oOX0mH3K9lG/FfaempKqRsuTrCH29DNS/?=
 =?us-ascii?Q?BwKh3VJLFUlanIyHGUD6lzJzS63DwmFipSmVvTTLu6bliJdOu6MgQt21tY7o?=
 =?us-ascii?Q?uAAuMwJ1wBYUcuplA3FfeUAxJHgiYfg2Wbkv5FoBwBlf+31XBusZy+GtVkfz?=
 =?us-ascii?Q?ikhYVMj70yfgnOXOITLTuWaVoy/2KPsbk9EwS/UFM3GVuit3eWV5XkCV/x/k?=
 =?us-ascii?Q?v5QA5TRnGEYX4mjZ70c4oOWb0rBKM17zZiHtfUhfpfrqUvqIRU9xnU8wjaaS?=
 =?us-ascii?Q?E3oNwso91n98MGAuzr60lWP+e7j4zw8Vt92LOOA+7OrHYI4xMT/FNoaBe1Lk?=
 =?us-ascii?Q?3swdSgytbwt+2ubLOcOXyZE3KQY4/yYA4lL4HHDzfhoPRTwn/3ttGAR6p238?=
 =?us-ascii?Q?RtJYr4q5Duhos5zhdyS/2p5c2RmCyvFQOfhm9NFfLMavbCQ5OFpvKygZEa3h?=
 =?us-ascii?Q?HlATutvn9mwkC0MY880O70UzMi2sElkopN7Z2NGsFSc8EzjXLVPiY/h15ydT?=
 =?us-ascii?Q?ZQkRvnN7dl8enO+zmAD3HGOt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edd0b22-3efd-4ee7-a594-08d9207c8aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 19:29:12.3907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBe3squWCP14i7hieCG701x1NLYOAtjFApr3X1DSLYIKh8m+i1bo4PBG1wOjuAJZnLduKYBfMOpyARtr/d1OhLLVoa8IVtxYQp7y7Ftyh5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2709
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_122943_018210_BE340F55 
X-CRM114-Status: GOOD (  22.96  )
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

> From: Christoph Hellwig <hch@infradead.org>
 
> On Wed, May 26, 2021 at 05:49:41PM +0300, Max Gurtovoy wrote:
> > > We do need for_each_sg here indeed, but you also need to keep
> > > incrementing sge for each loop iteration.  I think we can also drop
> > > the scat local variable with just a single users and all the
> > > renaming while we're at it.
> >
> > Is the above fixing the issue ?
> >
> > Seems like code refactoring to me, right ?
> 
> It fixes support for chained SGLs when using inline segments.  Not sure if it fixes
> the original bug report, but the current code is broken.

I'll get this re-tested shortly, but I've spent some time on getting this to reproduce
and it is really easy to make it happen. Simply start the SPDK target,
create an RDMA transport (RoCEv2 is fine) with in-capsule data size of 8K and
add any kind of disk as a namespace (malloc works). Then connect to it from
the kernel initiator, create and mount a filesystem on it (I used xfs), generate
a large file and then write to it in 5k blocks using dd with the odirect flag. It
hits immediately. The command claims it is a write of 10 blocks, but the single
SGL element describes in-capsule data with length 4096.

It does not happen when:
1) The transport is TCP
2) The in-capsule data size is 4K

I'll apply the patch and re-test now.

Thanks,
Ben

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

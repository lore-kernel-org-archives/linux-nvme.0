Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2658C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 23:34:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C8661433
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 23:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C8661433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+cjg7LLiW9rlxB/8xQh9aAvSuDArea9YuwG5Tfs670k=; b=rZKIFthXY1CnR7OZ4jsBR7u7g
	SlLx2JtQYpBNku6T+oLm3JXtYwOAE1XzJgmD/syoEKgmJWLHHdmV15bf4vL/UwFicOHXZ4maxEk9+
	/JuPpneKxpIvdAGzOS4bSTwLyv8pKXG4VsVeNNVX6CHSEThqwdf/6zRXgbl2UCosGtcgHdRqskYx4
	3gLaG9jPSsDkC86RCgmF2P3QNIMhnBdgrIP6gDapqtjNW6rG11q32nFkMAhXi7VZ+eFkQq341sq5q
	+i8MaRP84dMR6teMno4Jyw3FeLXOojl0/HAiv0ZVKTn0DBOhsZ3Io5q2Jm1zRlpAKbLPdEaTWpoDy
	eVLuw+RbA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhKpg-006hWm-6F; Thu, 13 May 2021 23:33:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhKpZ-006hUY-Le
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 23:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=Wlv5W4VdafM/Mm6ohBzj164yJeAZ8XtkFtFFSsyoCcA=; b=R/RIyk1PHhm36B/wHOyqIgvfEI
 tJgQOoB4qVOMqGb48QqAUWoCswCdY8yccgRnxGZFN/5XZLi3Gpr69Tp3BTm6bibYos4Z/GqA+YcLo
 WCh8OPa0YfBayKv+ZP1qW6JqZNkXpSF4ZLQ8abifpWpsSxa7PbFSJZIIR23k2+KF5Ih/r5YwIkKK4
 +htM375FJe10Hd2vsR0a3J8nNz6+W+5X6hRC25NoOcCRb7LuiMkcJXvDxmX62GxyU2c536w88scBI
 u9HRow9y+6j+osJV/iSsAz9OReP7SB7TBzD3y+/ETikOhfKndBwSUpuwKiC7GHbumcv0PEOb6/wki
 IWS350lQ==;
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhKpW-00Bc7m-SA
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 23:33:24 +0000
IronPort-SDR: KuOmgdBAdt4Sed3CoqLZMfP4Z/gNyUddku1ZfofHM6HV3qLlh99rBsTN/2/kV580I2QkcejGHV
 fZaqSjwAMQlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="221081509"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="221081509"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 16:33:20 -0700
IronPort-SDR: uhAX+wW6jibQmyl0op0hHsOGbMj3ikKQaR+tFhaOoyShEMGbWJj6XUmeLIBfHlwY+HsmIhKT9n
 PpJ5QrCgr7mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="463502491"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by FMSMGA003.fm.intel.com with ESMTP; 13 May 2021 16:33:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 16:33:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 16:33:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 13 May 2021 16:33:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 13 May 2021 16:33:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js1y+AHrGpKX4K1iaG8XUD5UPF8dsbJT7Z5usmW7rFdFXXFnh8duN+NIlkSRMXVeaxyZQVDYZoMwygzyfQ1JzFd/aCiYIAlZ0dIyrAYJx1jKIHAaMOUSAUxSyN1avwrcQH5ztZITRvowKf9TCrf8dqwMmnJEj04OIHuf5/hR7xbzE73AUb6fbKdzqYZUAqTXkHl1MVH/wL0H3hjQczJic2r3UsuVrGHcFg17yVpt+2Va/qQingLL7SuBvLrdVEmEh5eMEsfJiSEANuPs4bdGXq7nXTL5G4IUOAs3adzmY2QJRXlQRmpJLjX0w70+CfnTRpb5wUg7bG+3iRSULvDRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlv5W4VdafM/Mm6ohBzj164yJeAZ8XtkFtFFSsyoCcA=;
 b=h7TgRRBZFJ+NJH4YZv7xUtAdw7WADb+Pbb+524mGX0nlOvjDJYARH4RQqh7j0TaAwPapYg9cr/E5L0F2wxRrkg54lrDFzaWRxt+GfSkX64JiJoYVKN5R0jg87ztkqAx9McS8WW71x7xGkntal8tk5BkfPSx90C6JRDEaKPBwZhjk31ghTvjZZw4w8Hbb/XKwTntAgqDX+0O71vQChRaiQRLigpJ51Hpd/e2+F7IGlInzL4YPHwJbbwmdcD9z4/9ykjb/Br4/7a/pgTTboxChouqg7CT0oPFNdJns8epVKLJNGEyGQlJHNMNTsbN31Lrwr6QdPmiyljTtXy1gKNJq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlv5W4VdafM/Mm6ohBzj164yJeAZ8XtkFtFFSsyoCcA=;
 b=USwK0VAnoTWKyJO9EAFm0TVycvrJLAqD66A/BMEWnSLUY8wBC++sn3Yws401OAc3h1aBJy3oFTsMDjeN0VujNCPXWtX6sE2clp/DFXeXygZ3o5GXFVPnNuTewT4F9M89cXXncPMuhARx0Tld7L8rrZ7nKgiFUHnr3FUqszFKz7Y=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB3576.namprd11.prod.outlook.com (2603:10b6:a03:b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Thu, 13 May
 2021 23:33:17 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::a901:868c:c785:c42f]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::a901:868c:c785:c42f%4]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 23:33:17 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Vasudevan, Anil"
 <anil.vasudevan@intel.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: switch block layer polling to a bio based model v3
Thread-Topic: switch block layer polling to a bio based model v3
Thread-Index: AQHXRzD50J68sHmFEU+0v6GEtxJJHariBs3A
Date: Thu, 13 May 2021 23:33:15 +0000
Message-ID: <BYAPR11MB2869290376F951F10558AF13E5519@BYAPR11MB2869.namprd11.prod.outlook.com>
References: <20210512131545.495160-1-hch@lst.de>
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [67.171.162.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02ceabbe-4c69-48e5-8e5d-08d916677c8d
x-ms-traffictypediagnostic: BYAPR11MB3576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB35765B8214E523EE39B83A50E5519@BYAPR11MB3576.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2Ojwf15KcqND45YNZIEamd/+/IZwwJrGH25t7z/6KS33qSa6G/yTdZP8BQULSVOWLpijOglgS4n6yl027/Ba52jCqrF7rnwXWZbBJZR6pAzwZFGAdrHZPRIqNrL9Kph8QUJ+p1yf0INBlo3rBoevell1ejv7RFqu9ESxw5v/N5/dvaLjRsyIMlH9WZHlMqPOYRO7pzwwMboYpn+th28+Ysx9GzwJJhviSF52r6Mge3YCCgnoGNYWfTy668P0X+yN1F7Gq23QmR3XFuJ2F7URPlLniuhsmePL2J8yEx8HGtbp6EHmc1x9PhWNw+3EpXpe0M8N0QfrinO6Elu3il7OYS7ywtIwjH2h11DVLcRxwouYLt6vlPCqwmGCG4nTDFz06PuFZeS41QpknBMsnD6rG5A/iE7LxgcsLz1QVnvm346KwmUh9KLSP1d6/evhbsxVdvsWfc2iUzXeLkmUHjLbSPcZRq+YVG6Pn6Upz+6xvFQwqsJUxlvxsbB5L5If5SworaLMvRT8D5bgwR5spiidXWXh89NG1E00jsfSJfgz3lPFfRynueLm/uRWnr+3FeG2qokjS3Ai0m+DjDyS1jWN1OHqJHR/0dOwqovH0zBvq8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(346002)(136003)(39860400002)(396003)(83380400001)(8676002)(9686003)(64756008)(71200400001)(66556008)(316002)(110136005)(55016002)(38100700002)(66946007)(66476007)(86362001)(66446008)(7416002)(478600001)(186003)(76116006)(33656002)(54906003)(8936002)(122000001)(4326008)(26005)(5660300002)(2906002)(7696005)(6506007)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r6QTVy2flsSYJBiEekHSI3/VRTt248bZIN+q3BOnMqe1/Yuk2TJ/bVR38rra?=
 =?us-ascii?Q?4+hkKz/Q6eKYcnA1cfQKTaKtH29kneW5bNqOpgBHXybmCdar/HVuZSLmJRTQ?=
 =?us-ascii?Q?E9WXVMJ80iW1yo3UCte0EC7Ku0e66hLKS7D922/rEuZKGwI0DJcgTK4ZfFno?=
 =?us-ascii?Q?KxqXaPq9pg7g/ogjr3dBZ4cT6TGHHho6rhkiKY3XV1ahI/3qQrK9kVau4b59?=
 =?us-ascii?Q?RQhqq3xNlrfAM9pB//GzpoDOaqS1fHukuWmJBNYty6UdLbqzUBt/+AYG2K2g?=
 =?us-ascii?Q?NvqYqGBNQkTDPbaZ2z/5nDqZnrB09pK17XxQc+Vz9n4U1uTUU0dsEdWptOa8?=
 =?us-ascii?Q?j0Eh/OCSL7Qil5lTGnJbYmge0DU6/fpkgsgL2WaHm/e1xZQVrlzrV5JWAOE4?=
 =?us-ascii?Q?39eAbydVLe33XGENKxucSy21Viaahs/K26dE4DNK65d8Usd+XJg0uZr5eCOz?=
 =?us-ascii?Q?iFn62mmBeBWbulz0kEJS6+4ZD7eUZHvOiS9KtWbPyX9TRb7/pHi4UmsBi5SF?=
 =?us-ascii?Q?NhuIjxm76PGGRc4m/VNNlW0M3crtXKGBcatNM850Yhb4OP2X53IQB1hR7kJi?=
 =?us-ascii?Q?8ttcNV6vmZx/i9w1DKLQC2zIPZRYFe+tU/CaN4HQ+vDVlDsCRTWsLczgpU9v?=
 =?us-ascii?Q?gZ7GdNcJU4JjjSFRI8+Jvqenr3qdEUjJbpr4ebkfGW0xcmbCoYirULV6Uiep?=
 =?us-ascii?Q?rGPjAmEz60H79cmlcgxL7sqxMn7wXdObeAyymQ/qbNehunIwHcnfnmDiVR1c?=
 =?us-ascii?Q?dcIb9A6blzdqgFFWTrvHXY636mndTQzCvpLKjLlaAjffb2MO7t31rXw/LkIX?=
 =?us-ascii?Q?ibUYLFbwMhuZwXoxhsUVLr2wjiVt0OjUcuWTjipuEoxuM+HZlQfI7ajniCio?=
 =?us-ascii?Q?72/Rw3NpsjoITsIVrU4L9gcrcQ/cUU0I9hqFnT3iEgqWkUnk1Yn4D6YvWkOP?=
 =?us-ascii?Q?tsPOOc7Lv1kw2rbVWXRVlvNuCdc9P4R9udlMRjIJEFVsoFdWX7wRQuMqcRtT?=
 =?us-ascii?Q?FRIsY1fJSCPAB1StUhZfw+MlYCG1c4K2vzBbCYDGSxPj3YDZc2uuQf6rl4kJ?=
 =?us-ascii?Q?9YykvWt62OVAFWLV7wanCCfeFNQIUiD16ZpxoG8Ben7mQ3Ma6HjdwuRwr58y?=
 =?us-ascii?Q?ylPIdnrtgPHVEbXl4sQoA1Ut47IsNc97eMREOQzctc/1EBEbCy3ErJXkbp38?=
 =?us-ascii?Q?+Vf4IEEDtpHdjmkeZjfXklvGdf0kQOGE4q89EwLG2c1YmljdoF0ukUpylcGM?=
 =?us-ascii?Q?MHkNJeGdTM9c7TyMva+Obn0VD+jTEQmfDvq9w5ysQNdP4RQo8sfRu+xRhwi9?=
 =?us-ascii?Q?b8w=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ceabbe-4c69-48e5-8e5d-08d916677c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 23:33:17.5960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bpu+51BTH4lMC11g47PT/ncU0gpf/E6PSbvjuYhV30UWCpclKtJ3q/q664OAFVAG/gM/MZeqPWtkG05yQRc6M1PGIIhlgxsL9kYZgTg974Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3576
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_163323_027450_F98C0A2A 
X-CRM114-Status: GOOD (  12.30  )
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

As a data point, tested V2 and this V3 patch series, applied to my test initiator
currently running 5.10 branch of linux-nvme.

All results via FIO using the following options:  --time_based --runtime=60 --thread
--rw=randread --refill_buffers --direct=1 --ioengine=io_uring --hipri --fixedbufs --bs=4k
--iodepth=32 --iodepth_batch_complete_min=1 --iodepth_batch_complete_max=32
--iodepth_batch=8 --group_reporting --gtod_reduce=0 --disable_lat=0 , 
with only the queue depth, batch size, and number of job threads varied as indicated.

Tests are directed towards one or more remote nvme optane devices.

All data reported as:
IOPS (k), Avg Lat (usec), stdev (usec), 99.99 clat (usec)

For reference, baseline performance on this branch, running without nvme multipathing enabled, while using 'hipri' polling option:
[1 thread, QD 1, Batch 1]
33.1, 29.21, 1.42, 54.52
[1 thread, QD 32, Batch 8]
268, 101.17, 14.87, 139
[16 thread, QD 32, Batch 8]
1965, 247.25, 28.28, 449

This branch with nvme multipathing enabled, V2 of the patch series applied:
[1 thread, QD 1, Batch 1]
33, 29.22, 1.56, 54.01
[1 thread, QD 32, Batch 8]
259, 104.38, 15.04, 141
[16 thread, QD32, Batch 8]
1905, 255.52, 30.97, 461

The same config as above for V2, but FIO results when not using 'hipri' polling option:
[1 thread, QD 1, Batch 1]
22.9k, 41.66, 3.78, 78.33
[1 thread, QD 32, Batch 8]
224k, 103.88, 28.41, 163
[16 thread, QD32, Batch 8]
1910k, 245.23, 66.30, 502

The same branch but with V3 of the patch series applied.  Again using the 'hipri' option:
[1 thread, QD 1, Batch 1]
33.2, 29.12, 1.35, 54.53
[1 thread, QD 32, Batch 8]
258, 104.55, 15.01, 141
[16 thread, QD32, Batch 8]
1914, 254.19, 30.00,  457

So the data shows that this patch series clearly enables the use of 'hipri' polling when
kernel configured with nvme multipathing, which was not previously supported.

There is not a significant difference in performance measured with and without
multipathing enabled, with either patch series for bio based polling.  And V2 and V3
reporting virtually the same performance as expected.

So I tip my hat to this patch series - cheers

Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

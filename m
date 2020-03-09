Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79BCC10F27
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 17:38:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0BB20828
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 17:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T2BaVTu3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TZseu0sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0BB20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MacOXN6zYPU1C432KcjTt8Z+IzWn8mPD3dbpqb7IoyQ=; b=T2BaVTu3fQVXoP
	1COoUBALHMYzoA7NA7GyEc/RWPw19qE68CBGYgvNG6TERwSkyEWFm1TwHGPGW7qO0eqasGm5hx3u4
	yxtjmdyhdKG7le6Sh+FxBtmQWYEqGBZzM5yOce+g2ibznubYzsQ774nQ6dFbX6ngpgbE80vUTlDKs
	T8Iwex7tkMBfYimT2CXtYxyCoMXtf7vB0C6/vs5tvRdhE4/V+sid9Ni+pa4K4EsKh8d6S1pd+EkgZ
	O70wOSCLpD5ynbonvSK3jcjNE9YRCLbcNXJ7WbsUR4lCRf3cwCq9sX5YIqtxNQpXQLt3ecKuq39Xw
	jOy+YlPhPGMJb7wi6TPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBMM6-0002pa-RH; Mon, 09 Mar 2020 17:38:18 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBMM4-0002p2-2h
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 17:38:17 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 10:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="260487289"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by orsmga002.jf.intel.com with ESMTP; 09 Mar 2020 10:38:13 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 10:38:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Mar 2020 10:38:12 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Mar 2020 10:38:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 10:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFKr5WoPr/i7uVvM5WTnq9BFDxp1xSs1QLGDeiJ/F7Bjgev2hDQgtgKfxL1Z25PVcMWH6/I3rFilIPB4JjRodVe1UqJMRwRsbgtsdHSv4d95caY1nXV42Xhqn8ShdSs12e5z24DesdRoZVQWzNldJLDkNhDpmdJrlOPQWJB25ugcGwX9W2mY7P55z5u3YgxyjiAUBkrtl6tihGZX0I8LuPbH/jeWTso/5LMb9f86kcTlOOXQn9Z1RjbUJaYuCGklpk6xPhtwYP9q1sz1SXg9mo3K7ppXbDrOO0HFZuvom/EOKeuQm9yUewtrC5KG0dqO0twJEer4eTFPYZJ9r46ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTlHJRdSSRDA0dGSXNBo/o7/j/Ql9bDr8K/9jMeT3V8=;
 b=gMommR0aQH35xRDWjV3l8a3OlwHnPqxbsx3OYa/HwJeHQdNj6MR0uf2XgwhPmITzhxLUhdW7LDLLde1mrUyF+EU8IrVovM0KLhYZgZcukGkxyil11t9+yC1dGI+HdPuNATbEtelPb0Gd5ezC3LKB/gBaxcLLjZa6AqybUrnApVfh1MYcPWqs/k2gdUA1E9jdLawVzM+yWIQiIoPxVO5qkDtEskMcQT893uEhpP15aY9m6vr/4j7OUAO9EDLPYqbq8lUcqQa01cOzbkfSb9YsNYV8XwhS/vpOHIEXZ3l1G2x0e2r3vCng0PNBfExCEu4pr4hUn9L9Hapz1cOgAAOa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTlHJRdSSRDA0dGSXNBo/o7/j/Ql9bDr8K/9jMeT3V8=;
 b=TZseu0sTLLQJza1uy0flXbcJFzGY0XbwS9bNxM2i41fYxVvG6Cg8TFYhYGcVa6Nkv2FvNFxWg0Np887b/BQRzBTq6PLLeK7UjHmbDxDVjs/eRLv34f7/j8DjC/T+VxOc3FvjaA2Olh+3Fi9MDUWo+mrcB64Q4o9e1AU4X8S+WYM=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9)
 by CY4PR11MB1672.namprd11.prod.outlook.com (2603:10b6:910:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 17:38:08 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc%12]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:38:07 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Sighting:  Use of 'disable_sqflow' option shows drastic reduced I/O
 rate for small Queue Depths
Thread-Topic: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
Thread-Index: AdX2NhFDclh5NKfkS2+/QawY6Q2CIw==
Date: Mon, 9 Mar 2020 17:38:07 +0000
Message-ID: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04250cc1-b522-4731-3442-08d7c450a15d
x-ms-traffictypediagnostic: CY4PR11MB1672:
x-microsoft-antispam-prvs: <CY4PR11MB1672734B8E15181ECB19EDA0E5FE0@CY4PR11MB1672.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(71200400001)(6916009)(7696005)(26005)(66556008)(54906003)(52536014)(64756008)(33656002)(6506007)(8936002)(5660300002)(316002)(76116006)(66476007)(66946007)(66446008)(81156014)(81166006)(8676002)(2906002)(55016002)(478600001)(9686003)(186003)(4326008)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR11MB1672;
 H:CY4PR11MB1351.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfaANSdQ+Wc8nOBZ+OYIVZPFSAUkr0ywD3QhOpvyujRvdSeFmgdhaIZJZ4lDFH0H9IRXbD7yXtW01JaphWiwoQXHJSsghvluYj7MAECGO7JZu7ApIqLo6yWB3I5bU4ed8+/6DT0HjMdFTmUwieparFaCBZFq+5s9VpzZxVCWfFDSQDx1ygC+uK+Y2MLlJKEnbExGLMs8T7e9miyt+s9aigsGl8leeumbj7WBF0KAmqqcan3SI3+lveKFUkbpryK8bz7Z24jyjbnUD3BENjK7r+90MWAGeiGMa14RDKrRCrvrQc0X3ClGAcdKaILlxpvYt+lCJwbRFJWB/XEzviG+/0wrotFEJT9hGLv6MvKcUs3LWePoiDBpsz+DLQV+MBdjlSKZ1afgTyO+dlJRiC+8D7CjiX0R3m3T/1jSdu/07Mz5CLzTLhmEdh1NlK/xdNfY
x-ms-exchange-antispam-messagedata: MTatMdvDqVtYInosLJqgfQjFOs7X87wG5X720kRLupq07gCsKIsJTQ07efcSgCJu+sElvyoE+vLF61WesDec/KkgjwbruwK6F8ZTvdHWwNojES739B8mvd+k20vyhlMltQYlvwITOer7TKr8muq5BQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04250cc1-b522-4731-3442-08d7c450a15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 17:38:07.6713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUGtq/Wm5ofr1obMhHhfAN1X444Cb+K8lbVtOJxW8zcGD1N8HbT4jSzjuHE4XDmhnmfwLiH0p9qKicfpGrfUm716jh9IK+jXEorkHKqRlG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1672
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_103816_232803_E1120649 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Recent attempt to use the 'disable_sqflow' connection option displayed greatly reduced I/O rate when queue depth of 1 or 2 used.
Verified this behavior with nvme branch 5.5-rc baseline with no other patches applied.

Test was using FIO, engine io_uring as follows:

fio --filename=/dev/nvme0n1 --time_based --runtime=20 --thread --rw=randrw --rwmixread=100 --refill_buffers --direct=1 --ioengine=io_uring --hipri --fixedbufs --bs=4k --iodepth=1 --numjobs=1 --group_reporting --gtod_reduce=0 --disable_lat=0 --name=cpu3 --cpus_allowed=3

Specifying a queue depth of 1, result is 4 IOPS.  A queue depth of 2, result is 9 IOPS.  Queue depth of 3 yields 54K IOPS.  Without using this option a queue depth of 1 will yield around 32K IOPS with all busy polling disabled.

Interestingly, noticed that with the following patches applied to the baseline branch, done to correct a different stability issue, I see the performance for queue depth of 2 change from 9 to ~27K IOPS.  Perf at queue depth of 1 remained at 4 IOPS.

- io-wq-re-add-io_wq_current_is_worker
- io_uring-ensure-workqueue-offload-grabs-ring-mutex
- io_uring-clear-req-result-always-before-issuing

The 'disable_sqflow' option was enabled via script echo operation (see below) to /dev/nvme-fabrics along with other connection options.  Verified via tcpdump trace that target received flag indication of this option and it's expected appropriate setting of SUCCESS flag in initiator received read data frames.

echo "transport=tcp,traddr=${TARGET},trsvcid=${PORT},nqn=${NQN}${EXTRA},nr_io_queues=${QUEUES},nr_poll_queues=${POLL_QUEUES},disable_sqflow" > /dev/nvme-fabrics

So, before I launch into root cause debug, thought a shout out would be good just in case I am incorrectly using or understanding the use of this option.  Maybe this is expected behavior?  Or hopefully someone else has already seen this, or can replicate this failure in their environment.

Cheers ---- Mark

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

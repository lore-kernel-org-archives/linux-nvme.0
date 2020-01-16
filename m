Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EACC33CB3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 00:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971A4222C3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 00:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jaF7VDMO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SxA7C6h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971A4222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F0JSyW5aUVVIBqF9418X+taSRRhszkSRxLCzAD58qnY=; b=jaF7VDMOzqgDXi
	wmVCm4vPvRk87fNO5x6cV4sbxCaAr3DDdQeTJRJjNljgXvaNRlAaK6Jrjba5ykF4zzFu5SSOuDvpT
	7C6InWI/LJ5l3kXEf861Qtci70sfMNVoUffA/OPZvpNHMp5TKRHXj8+S7pPEGyx61OkOq6dU+CxOQ
	emFpxKIib/poVtwxL/mrjBwqLo0W0W7dL3wcQl2u6GgXL8b8lZa40DP7E0nMbEJoBo5X72CBqAXYs
	9jd2LXEhKBnprINnIXUaOb+yUAgdHi5LjtW4EHdMznxml9HPb7NqFRVbMexz/LJKWJxTMzozykiv9
	64idNCIL/fKjBB0o8RNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irtJ5-0006Zj-Bo; Thu, 16 Jan 2020 00:46:43 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irtIv-0006SG-Cl
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 00:46:40 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 16:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; d="scan'208";a="255542245"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2020 16:46:29 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:11 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Jan 2020 16:46:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDlTCcnclV7M248GLnOi6dz2JxyfqE55Wl5Ag2ZOiN62bkiXnsx3l2MGHf8Z7JBlD2qw/F1ibthfbZBUsvUvy4w0x9R6noMFPLFGlDyxwDH3KrbNDz92QISi8K3+gOc/1a3sAl/sDLvSbrBs5FLLo8H/dCvJgNp9y+2vrw+qhUqyzG8FhfnJMDzvddTM8xZxUVtdBkrz0HrBF8JoPiruGQ2AarLGTWwSmlAPx5bkclKQ1qZiyR4Kim1pmSdYup4WW4q1f1o5MZB+4VMCQ/zqqr3dPa17LX80RqsOQfGJWMfXO+dhnuXlqtQNLETipMDIWh5TwpldUt/cFPQ26VZLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBLbW4wvzFhFuobAP29qv7zbzWQPoY+AdHQzsIgTEks=;
 b=SXnP2T4caTOrq/9QOVawBSUyBc7FcGVj1UizLJPoJsB0jZRXlLdoL065cJYrqc5gfpn+HQWpUzu0oeZs0oynOYl0EHJIgJk2DQnc4ouHV8xV3undaS7uBcDkdGbPKkHEBUHnklW0MzUcNkF6fZARcNU6LTmHGaGLP4BSJUxbrWuFmJ4dvt3UE1aecy3/Tqygu+vLTWXoCH6JaHrE86HxofmmvS+VVRKJ62o/fLhSTWcdh/hi4fZQmobddqDu1kCQgd7zds5ji3u+IIZGh6PzeH0XMuns+k+NTajnyWRRscCslOXhOtNNW5At7hv/UhsJy1lnDy6b9J5AjCJManYYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBLbW4wvzFhFuobAP29qv7zbzWQPoY+AdHQzsIgTEks=;
 b=SxA7C6h9F9V2Z68MqXwpV/dQjToT1J/EUvdd65ZqecYHJ8AzYWKw6bU2UZtoI3RfYtB1mulKB53Jo+wi0l7CtncjuYrfhLGfb1LRTV2B8zKTvL1Jx7RXYO2/YqiUbSsBrWt+R1CkxFHR/xbftDoTk6KVax/qHhsToz2jv5TndCs=
Received: from BYAPR11MB2712.namprd11.prod.outlook.com (52.135.223.141) by
 BYAPR11MB3526.namprd11.prod.outlook.com (20.177.225.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Thu, 16 Jan 2020 00:46:05 +0000
Received: from BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9]) by BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9%2]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 00:46:05 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/2] nvme-tcp: Set SO_PRIORITY for all sockets
Thread-Topic: [PATCH 0/2] nvme-tcp: Set SO_PRIORITY for all sockets
Thread-Index: AdXLyQAntA98GnBbQ8G4GAgjr8ICjg==
Date: Thu, 16 Jan 2020 00:46:05 +0000
Message-ID: <BYAPR11MB2712E7D933721CA54EB18365E5360@BYAPR11MB2712.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjQyMjMwYTktZmIxNy00YjI1LTlmYjItMTQ1M2RlOTAyZGNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZXJmZDE0RXkyNVNDejVveFwvMjVMK0VpdmQ5R1wvZmFJNFFNMmlcL0EzY3R3T3NrSEc4UHZEZUpDNHRDT3Z2Y01NTiJ9
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 239d18e3-021c-4fbc-69e7-08d79a1d7836
x-ms-traffictypediagnostic: BYAPR11MB3526:
x-microsoft-antispam-prvs: <BYAPR11MB3526B21F4CC191C4D87FCDFCE5360@BYAPR11MB3526.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(7696005)(33656002)(66946007)(26005)(86362001)(6506007)(316002)(66556008)(478600001)(71200400001)(6916009)(8676002)(186003)(81166006)(81156014)(9686003)(64756008)(8936002)(2906002)(5660300002)(52536014)(66446008)(76116006)(66476007)(4326008)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR11MB3526;
 H:BYAPR11MB2712.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvfcMjlRpUy5HJyRPgHGjsFjIz+BJqoyFl/NWt916TpnqOU/bFtHlX3IC7JvwBLatxhR5xZC7XnhSVtQHXqEfM1M/QfLgYMcrKbBYIfhJ3bD6rnE40YEF5C+u2H8Fxe7zNiYC82eCLed1jflb/jqwbI4FJwKXfqJ65ke6KWyS6Lt3VErss3lIc/ceBToDlCxp/y4d8maaiCe1FOuYhVcAh/J44oUeFnhccxQEIuTidgm1dqrYAM6PEvJCARzEUi+q87LdXZabi+AE2GZLWaViJG8dxsSCKIMQA6gPpw/IsP1X4t7YNjCn0U/Dj0s4YOuPEm+h89iNIDXV6zOPA2ygYlKpaWejMQegXLjc04g3owHhbhPOJUmWuVea+tiygn3R9n46p6ZOxOr2w78ISZJW0JXVBPtICszxnR1zJ7gPHGBW5XGbhTkc/xZlasLLQmB
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 239d18e3-021c-4fbc-69e7-08d79a1d7836
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:46:05.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxwVzJacMLLwTOptTi0+6vRahD/42VlKvBs5nVgjmO4tO4WL1At2ExcyJhpBhSECGLznolrfAZd4dYpVCzM3TFlCejGFKOP9oFAZbUZ5OMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3526
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200115_164633_514156_2962E9BE 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Host and target patch series to allow setting socket priority.
Enables ability to associate all sockets related to NVMf TCP
traffic to a priority group that will perform optimized
network processing for this traffic class. Maintain initial
default priority of zero, only setting socket priority when
module option set to non-zero value, when optimized
network processing conditions exist.

Basic performance measurements for io_uring, pvsync2, and libaio
show benefit of improved lower latency performance when enhanced
processing support is triggered via socket priority.

The data gathered using infradead branch nvme-5.5-rc.  Data shows
Existing OS baseline performance without patch applied to both host
and target,  performance when patch applied and priority value set but
no support for enhanced traffic processing exists,  and finally when
patch applied and some form of advanced traffic processing exists
such as symmetric queueing.

The patches were defined to allow for any priority value to be used
to support future flexibility to specify any unique value for optional
advanced network processing.  If having this flexibility is reviewed as
not beneficial to the community at this time, then the desired option
would be to set the default module priority to non-zero, to always
allow for advanced network traffic processing if possible.  But data
does show a slight performance dip when the priority is set when
there is no advanced network support available.

All data gathered using 48 I/O queues and 48 poll queues established
Between host and target.  Host busy_poll value set at 5000.  Target
busy_read value set at 60000.  Single Optane device used.

IO_URING:
Baseline:  No patches applied
QueueDepth/Batch    IOPS(K)    Avg. Latency(usec)    99.99(usec)
1/1    24.2    40.90    70.14
32/8  194    156.88   441

Patch added, priority=1, But enhanced processing not available:
1/1    22     43.16    77.31
32/8  222     137.89    277

Patch added, priority=1, enhanced NIC processing added
1/1    30.9    32.01    59.64
32/8   259     119.26    174

PVSYNC2:
Baseline:  No patches applied
1/1    24.3    40.85    80.38
32/8   24.3    40.84   73.21

Patch added, priority=1:
1/1    23.1    42.87    79.36
32/8   23.1    43     79.36

Patch added, priority=1, enhanced NIC processing added
1/1    31.3     31.69    62.20
32/8   31.3    31.63   62.20

LIBAIO:
Baseline:  No patches applied
1/1    26.2    37.67    77.31
32/8   139    220.10   807

Patch added, priority=1:
1/1    24.6    40    78.33
32/8   138    220.91   791

Patch added, priority=1, enhanced NIC processing added
1/1    28     34.03    69.12
32/8   278    90.77    139


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

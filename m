Return-Path: <SRS0=dfoZ=2V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CBC2D0C2
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Dec 2019 19:06:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8957206E0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Dec 2019 19:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n4cJNKD7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hnChKHCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8957206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p6C46fIb2u86wch1yt3W1+OELg0DqKjtwTgnc96usMQ=; b=n4cJNKD7sHThTG
	kXB+V6aaHaTRkbSVkbrP82x3p3uNeg5ZfVluR/BU9tKn39e7qb8XXpAxK/Isxy8rFbaTrZvg9WYDx
	QiCiBSgM0FVuydef4Yt/N6Uikl56kM2OK89JAokI9KJCvQWLLJzNODyVoKn/dEUKp3Hy1uCWV/CHP
	7pYQHEmtt771mkH+zMZn2pqaMSzWWG192obJqs7zx3Tod4FI0u2EJSFlEzobuccVUtBHZs1wtXN5Y
	0naj0ukOHTESUj/2Vt8yvvH0Gn8R6wK7eI8Uf96VLfIoUoSNJsNsre35MMqMY9kzVAKfFGm/BtKjG
	LynFAz4R5R88ACcHpt9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imMqK-0006hL-6W; Tue, 31 Dec 2019 19:06:12 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imMqF-0006h1-1i
 for linux-nvme@lists.infradead.org; Tue, 31 Dec 2019 19:06:09 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Dec 2019 11:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,380,1571727600"; d="scan'208";a="251781637"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by fmsmga002.fm.intel.com with ESMTP; 31 Dec 2019 11:06:04 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 11:06:02 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX160.amr.corp.intel.com (10.22.226.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 11:06:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 11:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuHZS4Ut6Mapz0LFsNq2ohACqR8FJ6C2UBk55hnlv6PLYCRcZm32JxKFxAU9IV/Q8BDJmaTPr70vjeOMF2x8lgOXjqa27y3KjhUAXQ80XorV8BuRXNMAx3n4lOjOEBUSdnKmYwL6jsthSn7HDgBYl0CQpH+WXV0o+QjCLoLSCxsKKlOvy2/LzFUiSwFa5hURXsRHWAXMcfxI4yizXHge2l7HVmJEUMnz9m3Hefw8qlCyonbB64z34RZohN4jUGNUhCi3kD0fA8/GU/UXoMI3SaYVPoo0al7FwLG4aAJ5RUihlUYHJI4DX+oM9VMz2vIEg7gnjA3qCtlzKBnSg5NcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+3W7THmqbXU9PUy0AYyAakFQQgzRES72CxmyODZsj8=;
 b=OvFMQ7dn6UCNIwPIDVyfBwDtNJhwLiVRW3wYbVVhOj+HjYwbQ7TqOkNNbjYbjULMRwGpW0IBziC5tgBVqXdu0S/h7eJHbU10vMd/gz8RXiWufPQQ/+mR4F4ygj5SPfdrgAtwB0iKP4PBsbLF1Oya8PA6kqrh+Smxpsp5VOvjeseJ9i9Zklf7Vx/Xy4aKU7exuhioxw3+4Rlg86J8jU1vLCLHQ9OL88ehhhdK+Ib2GRACmxupYKUNOiLJVdTcYbBwnDoCZ65/SAvYydBqomammLBu8D1i9HCwUL35XnezsUf5LlR4V9P8yY9BFJJyN1KwLuxNiaVEesbThZJtxwCiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+3W7THmqbXU9PUy0AYyAakFQQgzRES72CxmyODZsj8=;
 b=hnChKHCdP3UcedK/S5+P4hEY2QNveLc6pHjbAETRqSgtouKcXUrOsaJjAXflv+CBoZDpaSpNsQsTwSD3kljZawxpQU1Hx2LA132/+Eq1E01K3yC8+VaCDi0S09lvVC1BgPM/VmR+etmIqIKmUszSNZ/R4/hP7ipvzN5nUqWLl1A=
Received: from SN6PR11MB2669.namprd11.prod.outlook.com (52.135.90.153) by
 SN6PR11MB2944.namprd11.prod.outlook.com (52.135.124.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Tue, 31 Dec 2019 19:06:01 +0000
Received: from SN6PR11MB2669.namprd11.prod.outlook.com
 ([fe80::5db8:ff89:9146:d508]) by SN6PR11MB2669.namprd11.prod.outlook.com
 ([fe80::5db8:ff89:9146:d508%7]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 19:06:01 +0000
From: "Ober, Frank" <frank.ober@intel.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: Polled io for Linux kernel 5.x
Thread-Topic: Polled io for Linux kernel 5.x
Thread-Index: AdW2ohLJtbfHvfzMSqCNfckqZUjK2wADBvUAAAGTGCAAMbepgAIjiEog
Date: Tue, 31 Dec 2019 19:06:01 +0000
Message-ID: <SN6PR11MB26691B36D7AEF22393CC04F38B260@SN6PR11MB2669.namprd11.prod.outlook.com>
References: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
 <20191219205210.GA26490@redsun51.ssa.fujisawa.hgst.com>
 <SN6PR11MB2669F3546ADCCAEF1D8E50308B520@SN6PR11MB2669.namprd11.prod.outlook.com>
 <20191220212049.GA5582@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191220212049.GA5582@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGYxZjYwMzUtNjhkNy00MGFlLThjYTgtNjk2YmJkNTVmNjA0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUk8zV1ZDcFdwZEFyWHdJN09IK1BPdFVJV2I4UWJBaThzYmxDZGM1ZlwvTElGMmU2TWsydVpOMlg1NVNac3phRzgifQ==
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.ober@intel.com; 
x-originating-ip: [192.55.52.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5abf5fb1-592f-4fbe-4c44-08d78e247a29
x-ms-traffictypediagnostic: SN6PR11MB2944:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB29443DB03F9CCBA0BD1B7B718B260@SN6PR11MB2944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(13464003)(189003)(199004)(107886003)(9686003)(478600001)(4326008)(7696005)(26005)(53546011)(52536014)(6506007)(33656002)(8936002)(66476007)(54906003)(66946007)(186003)(55016002)(316002)(86362001)(66446008)(66556008)(64756008)(76116006)(6916009)(5660300002)(71200400001)(81166006)(81156014)(2906002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR11MB2944;
 H:SN6PR11MB2669.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juO6mXtRGbc8SjOY1VJP1vR0nkhW1ty7kElWKpdY9I4FKk8lIHYiRFIgnVADo9XgPJSnmVRLqqaDC3SK3y/v+aSzxX2jt/bc32UP7b0uVfYrV4pm1FuTSLftKRdCrUd3xrjbGk6les2oTdcoQj4h0G5P2liMurU1IqTtPS9WYYqKVcXatMQ8L8uz1dUYbGmZGioeOSH/OX7PmrKLqKSfa3qUSaXuHA6cafFGdJSH7BtJ8YIj20woX4ZaG4tVFx0kwqR55ukUMUG47qL3SoENVoX2uAbwU5hQt7vjXp3Z1XLefYD+lhrG51vpp7aKPQhH0q+F+fw2hhUM5lDYw8mbQLUd8cGfWlCI5eLsTA2qhCO/iLYXXecbRhb8CsePlgwOAjAgIMLKdxjgJypNphhvqgVy/6grihIDr57+TWNb4Azs8NdYD8ekFUSsVih5KwGooUUKNYX+VXL9E2q7+vsFNs0AIAAL92IgeH4/42AYmJ2rEhrSNuKIgNLQVpudlH9u
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abf5fb1-592f-4fbe-4c44-08d78e247a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 19:06:01.3329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2nFyA3UCBlkhYN4GAzypB4umxAuM9LUw/rM3l3J6apjWi7oR8CqYXqBdq2X9TzO3K9BFMktxe1iF1ezgNne1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2944
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191231_110607_131688_6EC71128 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Rajendiran,
 Swetha" <swetha.rajendiran@intel.com>, "Liang, Mark" <mark.liang@intel.com>,
 "Derrick, Jonathan" <jonathan.derrick@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith, so the performance results I see are very close between poll_queues and io_uring. I posted them below. Because I think this topic is pretty new to people.

Is there anything we need to tell the reader/user about poll_queues. What is important to usage? 

And can it be dynamic or do we have only at (module) startup the ability to define poll_queues?

My goal is to update the blog we built around testing Optane SSDs. Is there a possibility of creating an LWN article that will go deeper (into this change) to poll_queues?

What's interesting in the below data is that the clat time for io_uring is (lower) better but the performance in IOPS is not. Pvsync2 is the most efficient, by a small margin against the newer 3D XPoint device.
Thanks
Frank

Results: 
(kernel (el repo) - 5.4.1-1.el8.elrepo.x86_64
cpu - Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz  - pinned to run at 3.1
fio - fio-3.16-64-gfd988
Results of Gen2 Optane SSD with poll_queues(pvsync2) v io_uring/hipri
pvsync2 (poll queues)
fio-3.16-64-gfd988
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=552MiB/s][r=141k IOPS][eta 00m:00s]
rand-read-4k-qd1: (groupid=0, jobs=1): err= 0: pid=10309: Tue Dec 31 10:49:33 2019
  read: IOPS=141k, BW=552MiB/s (579MB/s)(64.7GiB/120001msec)
    clat (nsec): min=6548, max=186309, avg=6809.48, stdev=497.58
     lat (nsec): min=6572, max=186333, avg=6834.24, stdev=499.28
    clat percentiles (usec):
     |  1.0000th=[    7],  5.0000th=[    7], 10.0000th=[    7],
     | 20.0000th=[    7], 30.0000th=[    7], 40.0000th=[    7],
     | 50.0000th=[    7], 60.0000th=[    7], 70.0000th=[    7],
     | 80.0000th=[    7], 90.0000th=[    7], 95.0000th=[    8],
     | 99.0000th=[    8], 99.5000th=[    8], 99.9000th=[    9],
     | 99.9500th=[   10], 99.9900th=[   18], 99.9990th=[  117],
     | 99.9999th=[  163]
   bw (  KiB/s): min=563512, max=567392, per=100.00%, avg=565635.38, stdev=846.99, samples=239
   iops        : min=140878, max=141848, avg=141408.82, stdev=211.76, samples=239
  lat (usec)   : 10=99.97%, 20=0.03%, 50=0.01%, 100=0.01%, 250=0.01%
  cpu          : usr=6.28%, sys=93.55%, ctx=408, majf=0, minf=96
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=16969949,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=552MiB/s (579MB/s), 552MiB/s-552MiB/s (579MB/s-579MB/s), io=64.7GiB (69.5GB), run=120001-120001msec

Disk stats (read/write):
  nvme3n1: ios=16955008/0, merge=0/0, ticks=101477/0, in_queue=0, util=99.95%

io_uring:
fio-3.16-64-gfd988
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=538MiB/s][r=138k IOPS][eta 00m:00s]
rand-read-4k-qd1: (groupid=0, jobs=1): err= 0: pid=10797: Tue Dec 31 10:53:29 2019
  read: IOPS=138k, BW=539MiB/s (565MB/s)(63.1GiB/120001msec)
    slat (nsec): min=1029, max=161248, avg=1204.69, stdev=219.02
    clat (nsec): min=262, max=208952, avg=5735.42, stdev=469.73
     lat (nsec): min=6691, max=210136, avg=7008.54, stdev=516.99
    clat percentiles (usec):
     |  1.0000th=[    6],  5.0000th=[    6], 10.0000th=[    6],
     | 20.0000th=[    6], 30.0000th=[    6], 40.0000th=[    6],
     | 50.0000th=[    6], 60.0000th=[    6], 70.0000th=[    6],
     | 80.0000th=[    6], 90.0000th=[    6], 95.0000th=[    6],
     | 99.0000th=[    7], 99.5000th=[    7], 99.9000th=[    8],
     | 99.9500th=[    9], 99.9900th=[   10], 99.9990th=[   52],
     | 99.9999th=[  161]
   bw (  KiB/s): min=548208, max=554504, per=100.00%, avg=551620.30, stdev=984.77, samples=239
   iops        : min=137052, max=138626, avg=137905.07, stdev=246.17, samples=239
  lat (nsec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (usec)   : 2=0.01%, 4=0.01%, 10=99.98%, 20=0.01%, 50=0.01%
  lat (usec)   : 100=0.01%, 250=0.01%
  cpu          : usr=7.39%, sys=92.44%, ctx=408, majf=0, minf=93
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=16548899,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=539MiB/s (565MB/s), 539MiB/s-539MiB/s (565MB/s-565MB/s), io=63.1GiB (67.8GB), run=120001-120001msec

Disk stats (read/write):
  nvme3n1: ios=16534429/0, merge=0/0, ticks=100320/0, in_queue=0, util=99.95%

Happy New Year Keith!

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Friday, December 20, 2019 1:21 PM
To: Ober, Frank <frank.ober@intel.com>
Cc: linux-block@vger.kernel.org; linux-nvme@lists.infradead.org; Derrick, Jonathan <jonathan.derrick@intel.com>; Rajendiran, Swetha <swetha.rajendiran@intel.com>; Liang, Mark <mark.liang@intel.com>
Subject: Re: Polled io for Linux kernel 5.x

On Thu, Dec 19, 2019 at 09:59:14PM +0000, Ober, Frank wrote:
> Thanks Keith, it makes sense to reserve and set it up uniquely if you 
> can save hw interrupts. But why would io_uring then not need these 
> queues, because a stack trace I ran shows without the special queues I 
> am still entering bio_poll. With pvsync2 I can only do polled io with 
> the poll_queues?

Polling can happen only if you have polled queues, so io_uring is not accomplishing anything by calling iopoll. I don't see an immediately good way to pass that information up to io_uring, though.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

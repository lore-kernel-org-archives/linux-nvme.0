Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7EBC54ED1
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A0JWYIbEH/NYL7aOZF3IjSp/OFqflHP268A8ncf8XxA=; b=CivgIgNJUyqlC41JhcH68iMxDj
	oOKFlYEEvs37Y3+dhArXyqA0Nj30SI/QiumwsT4Nos/PIrVtYhjHXmIu+LIte2LThHEH2da/nRjRF
	l6qb0YmRxo8rMFeCBhqk5MFviNqCwcd6VT48XjutfHOTJK4IqCbln1L6KmS3Nv+RHOKKtLkKKja3a
	ocGpXi8WEAP8vVc6f5zFcDA5bmGxWL8dJglkCjWAI/lXVLMcS4Y3pt7tdF4dWEIy26nlog8jA1e2S
	4SmCWDxZQZLrhmMzQ/TZWzM5+PWVJGJ9oblcfXfoiIz24ROzY01dCEowIuWQk6bkBviSfMURd+pSc
	2DIKN7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uK5ph-0000000Buug-3hFp;
	Wed, 28 May 2025 01:43:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uK5pf-0000000BuuL-1GdV
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 01:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748396631; x=1779932631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NcIzGAK4/o2uLqIExQY9AB5PrGLhouh2NjjVPQH0Uds=;
  b=GYuiF1bhRPdTSo9QUJRMN6c+Tkm0r6Ofv8nW36mIFo2l8zaF4EmGtGPB
   nXRJIxh343zQZ0aJFSZnxzfqSq8smEpqseAtKgfntpKA/HeaS9lNXYi+H
   CAtd3xCvf42M8CnojhLE4xKaCaJzZwcn0d4kmlp4iWdSD4zGWsKDWTmAE
   js8uauCfo9SdTsxs5mXq0ELDsw6ACh1A1QmqUQBBvjpi90p03eSYIoXTV
   LodqroZIVMtgXAwivQIHm0eqxZvpfOB3ux0nJ9iyh4yshNy943puQ4Ddf
   FrHrmdvPxSEb+zFcU3a2rlG5n4BRqjTjS3ULAsimTUnIKOfvR9sDE11V8
   g==;
X-CSE-ConnectionGUID: voq2orgGTd6ih8VWdvRiJw==
X-CSE-MsgGUID: 8sWe6n5gRLSAi0zCGFnVXA==
X-IronPort-AV: E=Sophos;i="6.15,319,1739808000"; 
   d="scan'208";a="82710274"
Received: from mail-sn1nam02on2065.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.65])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2025 09:43:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rael1tvwlg1Xa9/voOn9Re24OOEy0FKPo1DOhZJLH/tbMF/Fbz+uBlQP9MkljMN0GAJGl2KTviUdvDDAofoO9+PDAJzfCpQkneDLFZ2pNEnd9rBUbQ+VCbGLdpmJFA9zE4CP1ttprXZ3cp1mDwaLPqvSNT0OiXJiC37KPfFYrf0RoijSle8HGFaU0ACfjllGiGRhQ/0+T5ZKXtQzp9wB0EXOV9h/eei4thpaUDH80bcJOfaxeJZJtD7Ypv/8rNTqTDblDOw/i+2ZW0MWJi65gJ77J2Sc2ry9NeoRMFbRprdBAR8it8ssG1y356P1b1lqckVKfC09zWOZ3pAWk88bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0JWYIbEH/NYL7aOZF3IjSp/OFqflHP268A8ncf8XxA=;
 b=e4PIBWqSKvJM7OU9NGz2cZ54O6Nn+z50RhhkpHl8Lxqr22EVMuNhGjNgG6Wt4YWiu1W0/zHwCZceJtuNlyclyCKGUUD+HRdoLgLVbKUNrd/tOA0xdKwVVZVRaeR6NVUitOXtqBe+qRibmcfMl04srMjILVxtP+62Ezau3RdK0uIZnXeC7JF3Ll39jUW5JBqZgp3rl8QhHxeOLzvoq4wWQVTcpE8DhRIKHn7sArHQNQoc0ye5I0K5/hD8/grr8Wr1DpmxISDUWZuZ92tDJsfuFMAu3yJLN5rdjJpprZc36eBrctHnS/3ZJ36iqepeoH55l13bgqBtv7BZWRrZZDBW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0JWYIbEH/NYL7aOZF3IjSp/OFqflHP268A8ncf8XxA=;
 b=Y8zWt9Z29yMNFi3dao+SNk0wtHrjSGMAO8D3nEr+6atBHbWBViQEADKENoVZ/dmsoxUczTHQFaW/dnjEF3CmxEdQyWeZlKCACx6n0JTuGN45OT7cYaWjcZp7Lky4ik+OLSKAmiRcGcjhz5i2xk+fMUNYqdrh1WNxJow+JjXevx4=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CH5PR04MB9522.namprd04.prod.outlook.com (2603:10b6:610:213::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 01:43:45 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 01:43:45 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAvfEACAAkIngIAAA8GAgAAZ552AAkkWAIAOmdwmgAAIp4CAAc92qoABUZQugAQlcwCAAikEo4ACYnMAgATwiwCAAAL/AIAQeg+AgAA+eMw=
Date: Wed, 28 May 2025 01:43:45 +0000
Message-ID: <BY5PR04MB6849D665ACF1F64022583047BC67A@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
 <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
 <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
 <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
 <ede69310-a640-489c-8922-24dd62cf6ea1@grimberg.me>
 <7f7e08be-4930-47e5-80df-91329c827915@grimberg.me>
In-Reply-To: <7f7e08be-4930-47e5-80df-91329c827915@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CH5PR04MB9522:EE_
x-ms-office365-filtering-correlation-id: 03fefcfe-8100-41dc-86fe-08dd9d8915ac
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ue/ezxlSJ7ZtmNwpWv7GIe+gyd6p1wAHms0p7jm/lcXYMCr50KGbgs/02g?=
 =?iso-8859-1?Q?YBi8irFd7IchtSiKGbP+1caBEz68gRgD2/LonKhzP6VBIAi+p7YfRqTpFv?=
 =?iso-8859-1?Q?hw4IjsSJKGoc55Hmvp7/aaiGt7FU4SlIJjtqL7pH77o69Wd7yBqe4APOk1?=
 =?iso-8859-1?Q?OQoviBKVZx6Q3Pne+Ka8yGcFuK/KNO+E85Kjb+TW33LWNCX82F9dVVO9aU?=
 =?iso-8859-1?Q?VxkPOFFXOlmmov8Y5UAsYKmQ/AqHg6+ZLbJx1+ZlI7oQsLehyCm5a2zn4t?=
 =?iso-8859-1?Q?wHopEvuFf2pF8fsUdQsuCuzCvNkVLu/2KvumBnq6KMjLEyyQPrcn8UJUOv?=
 =?iso-8859-1?Q?m4XDTxV/Y/gTvFWXYyJQzWNdvxJuO9Rzeva6UUBtlFKCsfdGSgW+F39TXZ?=
 =?iso-8859-1?Q?cfRqSc4xVdixldlAtwXmfKoO+FgvDgBUdJV+5TOHafLWOgsTOE2y/qb9BD?=
 =?iso-8859-1?Q?87QjAHDE+zAdYx40p13uMEX99tyrGZ5XZPybRbRdmCbk/K2qGer2o9wvZd?=
 =?iso-8859-1?Q?D2+4qfFbD3HC7AC1xnoTZ42tUlh3y90DO0PihCHL+FuALU9A3uYKnRCogK?=
 =?iso-8859-1?Q?UZiLDNS985LArIsv4VN0QEGd67OAw1i45Ld47qCLQOXzAsAm+4LyhARhmd?=
 =?iso-8859-1?Q?+5jeW7DR5v/kwr7czhRORqTRGO+TIntx8Q+X8CnUdtLYxE7nZyPSylbuiD?=
 =?iso-8859-1?Q?kgXnA6pH2a+porL+IbHxAuH046DYw60BL/bVkC9XK3L9NMnb2fPe+kfs1G?=
 =?iso-8859-1?Q?aShwnj4OfeV2ucc26/iKiATq/Jva8SJWUFdqhtxRVKqQwAlUYrtq9f3qgh?=
 =?iso-8859-1?Q?APwj9SvOdNvXkC8OEPm8MT38gVhSlP5Ip4U+gzNvtsM7DEL2brKalDYAtl?=
 =?iso-8859-1?Q?2mjF6g+EXD24Q9wOl2v9xwZ8wPB2qUms8m4ex/+2iAi9ZylMa6tGoBsY8U?=
 =?iso-8859-1?Q?qTKea+ivQ30H8/iDsP2luOgrDd3PqglE/EwDrW2JdoesI/vdyBXEZI1IEv?=
 =?iso-8859-1?Q?/Ppz6DAlQqwb8DZp4OpEKz3VPjL1Fz8MzW/i6kbGHoZHt37F1QKOoVfPKN?=
 =?iso-8859-1?Q?K5UG3tBrVcPR6GvF/T0f/PM6+ZnUdaXUzhDS3HXM+Dp1yAvfAK65y2+tyb?=
 =?iso-8859-1?Q?/t8brnEyAtMJq81bMk6Z9D93hXq1q6t/xe28BjgeSvJGqWzUHBMW6S8ALn?=
 =?iso-8859-1?Q?gRRII/YxDlEOOoAU5uWjeafj0GoWpyX6ogQAhmYD4CP3f5+GW6Kw6MMmxC?=
 =?iso-8859-1?Q?0IgdEyifVm/+qRO/2J8L0eSmTCPkqF4Fe5YxE2DFkdSnvuL8hsYlDtRWLM?=
 =?iso-8859-1?Q?bCQDQ99v55qFIYAMm9DghtL8j9wOGiKKwrQWyhqDHU876l71Qic1Mw5Os7?=
 =?iso-8859-1?Q?bI44hqtG3cQnlY7b2fr1SqwbnU3UvaM5wJXQlq+Nkri+Doulduao0ZV7dR?=
 =?iso-8859-1?Q?8zeNAo93gTzpuaEo+Ie86NmDgviJpKmh0eCPNYp0L+a+ICWlw+8hhMc6nY?=
 =?iso-8859-1?Q?x8fnUA81XtjrhbPze9G8DdJnFzeajzrDV08+LGZd+86ttdMs8ngMujNiOg?=
 =?iso-8859-1?Q?rNMZpME=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7J7RyUEvl8pcufJCm+jIr7KMMnRov674rDCSuxntUdySW/RfKZZ3LI3gXD?=
 =?iso-8859-1?Q?c5n3qv8D5yCeB1mVV8kRfj95UwCYKmVM8BhUxWl8GX4kuCHHZ9o3vU5BVS?=
 =?iso-8859-1?Q?Kwg80auXzVE7KyuF9kVMfwuSU1/JZlf9BDzp0TIJAxm4sYX2rWTJUBR3wx?=
 =?iso-8859-1?Q?ZsL+3f+PEqiFv0Snn2JYGRnw3ItbpUxv4CEvYV8hC03+WmtclMa1hZ6c1c?=
 =?iso-8859-1?Q?GkIHmSQFWkC9lUmsfM+YcJaqrOteXAkjut12z3YqE5b+1Bz6SFRtkaS7ah?=
 =?iso-8859-1?Q?UzDZ0b7wnhSshzCGXaOhKTrilddLH+PpFvRg6gULDJed51Vee6emu28Gcz?=
 =?iso-8859-1?Q?pCO3VBFKcrlvwlKUKiPL6XAmJQacZmaORJ2ZbXdBzcYJrvWfUlFyKRRq1j?=
 =?iso-8859-1?Q?1/rmMLSwJl0t0k25kT1XuNOnU0U2dVshTT5lf4v+KMX6KV2vDPVOnz/sGL?=
 =?iso-8859-1?Q?mODtNjdcPUHJoTgjyv61rTZH2INc9iuILHx8zHsGpWZ1r3ibxYLD3OFWbG?=
 =?iso-8859-1?Q?4GqeUCgkk8vS3jN4h7Ui1JGzcNNFNvO2nENKYklNzRlPddH2jZTnhnMZ5m?=
 =?iso-8859-1?Q?ga6VpTVoiJitimBTz1K6E8zXUagwkfRgWYYfBlv3sM5fV35CdJHcrqYW2C?=
 =?iso-8859-1?Q?8M1u65S4epdFviuZfd5cnPq6oR+Qv18hHT0hYUXHZbuZ5KdPWb4PxLKwD/?=
 =?iso-8859-1?Q?aXvtf6eHJH3R9pKYkkvM/TAY0CZbjvvrjWibfO5TrqXmKx85eqwXBVaznL?=
 =?iso-8859-1?Q?Fr61pbo81cuAq/LHk1+YUb4hqqsUKSrNfM2OWjrmYEo5DAyx454V92Qopr?=
 =?iso-8859-1?Q?pcpws0Myc4cocg4kCGxp5PbkeDw+QM8qav3LYXHp4yQBt0Emq8RghfB7IJ?=
 =?iso-8859-1?Q?ITW0Z0x2aqHRYhDQ+mYw3d2udmKvDohug47RUgbRFb6qc21EpSBK6UYBK3?=
 =?iso-8859-1?Q?e5N8lNnGxdepQMn4uVM2WaFupCXrky6k4a2l7Q4+zdFBiitbAkBdvp4LQv?=
 =?iso-8859-1?Q?yeqH+JqkzxKPCBEZNgeTMTOhuYpdVxUhfD8P5nwuzLNk4JBXXnxz0u4td0?=
 =?iso-8859-1?Q?vkdaiVOZu4kV7YGCGpmAN8GrJ1kZv2RNT7CyP0MIx5DUKUPD/THFXjSGqa?=
 =?iso-8859-1?Q?8tQwCWtEDydO02xehBvNqRTvu69peiddL++LO0xxILmwFMn1rZcn5bqgxX?=
 =?iso-8859-1?Q?yBoy4Brmr/86FidutF8MNBJBlhE6jGPjb6lArRbnhsuXPbp4F0BQkO4ngd?=
 =?iso-8859-1?Q?ioO1GgNol/g6X6dDJCnlwWjlNDWRpKKsivwJGuo0FmuN9fp26i6lkCU2bI?=
 =?iso-8859-1?Q?DT+5z3BrP+Ke9XXZV7zyPlpj/jEPDH0K91Yxs/A1pBxIYA0jA1yanJRum5?=
 =?iso-8859-1?Q?ZQMFdh2pYazYODgCySYnp2bIaRdBqFwmsDp1fqEMBvCV6sYxq2nTso/BR1?=
 =?iso-8859-1?Q?ahDputWWAVQIHgLIFb8VuFuB6xWDS5yklbBqzCglMb6nSMI+QwjtzRThSh?=
 =?iso-8859-1?Q?aQSoKPelg4F+CmsRkMTjpG/97Vpxkuni4GQh9t39776Bi99JiHmIuL8k/H?=
 =?iso-8859-1?Q?5XvuY7kzlyo9GRbERB4aiuyqNkcUPb9XX9fPfn+D6C8qt3RytYMk8WWZPS?=
 =?iso-8859-1?Q?SRSaTQIWcn3n/QZxVlWOgt9f5NXzQxLgor?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CdAsCLlIGZJ5yiwJGIdjvzo+oHm25/60kTJ1Fc1q9s2QWHcU3IADpeBZJeAkbJebmd06Tre9UWo5olW4BR1ffpVdleapkvt964rG/I97lXqO/2Pr7rHihz1XxvzbzoYjci0f6O+q/Py7yAkCY+oHbbB0VaWe/PSjSO8K8rnMFpL1WBEKR9TgNLyk8AMyIrHaIa6ElOhw2B1arotO7ohXV9bn3BJVAV274kDi4gn58d8d0qYaVe+2+zv2PztV1MLWcMKD7E5at5om5Dn4V3xXbq6+AgUm/nUxOb85cBaxl+YTE4AnMIQdyyNUkOmq7ovOCAugmd10SfTfkUg9ak3LemYwYdjV2Awn9FPa2ee9SDuiSa/3YXoEB4OQZVUZNJWC1cVu5MjCJ0WUHIeiY66Og3mGjJ811A5RbInOPpKklZ8w7+NB1zjrmaS/rSDDit8ShjVWdVmRmg6mi1c4u+4xCiT9pLOZ3onTu8f0rZhb9P8+lEXU/A5BEmqhyGetrxk7TsL7mlyFp9dQl1D7QSJOYx2zAuw2trLEMe0jL0Sj19YbT2V2spCU1rIcnD4UtHNmmJrHAcBQ+ymxZzd8SaOUWnGpMY5iGqYJdff9H/Ela1iwcfRtncKcp6GVb8YK4RD5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fefcfe-8100-41dc-86fe-08dd9d8915ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 01:43:45.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVCYZq4zzyaqIRv2tkwT4RWzrXYIx6qwZ0WriMWEnOuzQBmu1U1XN2AkzjFLxKzZaRjOa9pssq4151MCq829DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9522
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_184351_375762_7549A93B 
X-CRM114-Status: GOOD (  14.22  )
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

Hi Sagi,=0A=
=0A=
>On 27/05/2025 2:49, Sagi Grimberg wrote:=0A=
>>>=0A=
>>> We still need to hunt these down. I'm still puzzled why adding the=0A=
>>> WAKE_SENDER=0A=
>>> flag was able to make this issue disappear? I'll have another look at=
=0A=
>>> this patch.=0A=
>>>=0A=
>>> For now, I think we can go with this patchset, and then incrementally=
=0A=
>>> fix the remains.=0A=
>>=0A=
>> Kamaljit, can you check the following patch on top of the patchset=0A=
>> from Hannes that=0A=
>> gets a reproduction?=0A=
>>=0A=
>> --=0A=
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>> index 835e29014841..2f5f2fcfb078 100644=0A=
>> --- a/drivers/nvme/host/tcp.c=0A=
>> +++ b/drivers/nvme/host/tcp.c=0A=
>> @@ -1075,7 +1075,7 @@ static void nvme_tcp_write_space(struct sock *sk)=
=0A=
>>=0A=
>>         read_lock_bh(&sk->sk_callback_lock);=0A=
>>         queue =3D sk->sk_user_data;=0A=
>> -       if (likely(queue && sk_stream_is_writeable(sk))) {=0A=
>> +      if (likely(queue)) {=0A=
>>                 clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);=0A=
>>                 queue_work_on(queue->io_cpu, nvme_tcp_wq,=0A=
>> &queue->io_work);=0A=
>>         }=0A=
>> --=0A=
>>=0A=
>> This think this may be preventing the scheduling of io_work. But now=0A=
>> that io_work is=0A=
>> also ceasing based on sk_stream_is_writeable, we should probably still=
=0A=
>> schedule it.=0A=
>=0A=
>Kamaljit? Any info on this?=0A=
=0A=
Sorry for the delayed reply. We've been hitting one issue after another,=0A=
hence the delays. Hoping that by tomorrow I should have clean results with=
=0A=
a clear a-b comparison of only the changes you suggested.=0A=
=0A=
Thanks,=0A=
Kamaljit=


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10AD3943A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ViFuGnQRClp15nxUgalV4RixSyoqtr58UhCBZEW+Aw0=; b=kD9kyjqPwfei4+5a2kBs3S5AGo
	fYx5Ol8C4INm1MfWUTwM1oqi3wHj4fi0vz28+KsyQk7nijUJOWRxxbXwWoSslWjRZmaugu9CU6L1W
	Dc1zOoEzCf8N9kWdbARQpbsm44Ih6FyYH1qW10t+7C5eHdyCRN5W4mWxZqWpdug2unIufGNs4OE48
	X3RtrVvStkSo1hDhQdSK9KLpDLRVwclPVJ06T/EB1euiNX5jNz13282Q1EXVu2DPDPIOCT7UCvi7N
	QFiHNCBx8/K3OAo6Vm78WSYHZjhGgCGMBf0qsiONaiX9EzflMhDFTjryD5pJlbKu+HeV+eyFVvJXo
	/OaDYQzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iok-00000000GGx-0l8Q;
	Thu, 02 Apr 2026 14:14:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7zAu-0000000FpbH-0U46
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 17:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:In-Reply-To:Content-Type:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ViFuGnQRClp15nxUgalV4RixSyoqtr58UhCBZEW+Aw0=; b=JbcPhOOk9goz7BIJ7bySM2fSNt
	EehLLaKkYRKiflfSx+7B+CMCBZhx9HCybgDWdVToz3279kymGVMJTM5CiNqazqrJnYqLT4R+wsKDy
	SB02GgUNVOSsocLdWFrWzh5WqEoRJu0a3HpE2tx9uJFChn6dbswM6I2LEBxn05qyH6nqA7h6IiX/m
	NflUeO3BTUNZhV+PJrFoQM3WQK5S7VfJfQ9NV0kSCo9itfr4RtoRQCYlMOlgXDoD1D0Z2paoJPkdW
	i1xto+HgeQ8VGTj89qEdvK+sjVER3ZoeVH7PWwBJrM2v4E/7SvLyDnmGWBRPulVNr1RsVWQA6fLPh
	4jOiLMPw==;
Received: from mail-uksouthazon11022082.outbound.protection.outlook.com ([52.101.96.82] helo=LO0P265CU003.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7zAq-00000000z7Z-3kr5
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 17:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugGGjpI0kq/BoJf4ye4IP8ewSnQO1rcVZ0X1nFkoeQjWC4RWVeigakWPMK8ooLeX5uD9ImE4jI+D+ug0pjA+h/Mbf3xOnYdDc26P2ruoSEu6sV89fQWMV/oYJeMCPaHECSwmYpLHoaMQq+BuviMUi+g2YTlSsNe6tm6GXzvkl855PYHkEAaTNIhxwFOKxNU3+HkL8Ndh8oXau0LjZow8WwS0/pp8500G2CzqayMF8tcD7kKwcoEtzvZyC53ChCOmIIyUGRaVklEHA9kNEzFTdjhkeSun6OC3wxD8pgmwY7q2loiXj9Ox6l4qbgXnwOqx9h46uInIk5x9BETfPnjb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViFuGnQRClp15nxUgalV4RixSyoqtr58UhCBZEW+Aw0=;
 b=RfRADah3WuAgPm2mdUw+6pzkqiu+XIfcPo7GkqYdPVSeMY87XbUXgs7c4lmB9ubBraL/p055rJ/twOMjED7NTvcQhVruMfb+V9Zf0+f0+nFnIKea37sTHKU82P1fCzQqQPWJ3iq7HypM3CkaURIlvkOwTQamDue1R7ErIULAPFZdRi04X9ogfAGYvIirSVqFeZdYMwjGVeKWFA+jarEib1xJBZCcPI4fY7DVLHEJWFxLTfhy6kiz24ZkDh+9/ESeKNsLsXEsg6zVIMOp3MYIMwA97WpuCHGryRtaIoIuRFxY74MTSfLvI2XmEkyHwyOBiX0ov/q5cDwdpL0+UVRj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7367.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:37e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:16:06 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:16:06 +0000
Date: Wed, 1 Apr 2026 13:16:02 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mst@redhat.com, 
	aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 10/13] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <guielleeqpvy754g4453pqjzs2jo6yn6463oafoqct2bedl76l@wv2n7t7m24ag>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-11-atomlin@atomlin.com>
 <acxTI2CJlq3npMVa@kbusch-mbp>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="riyilwvjpctyspcu"
Content-Disposition: inline
In-Reply-To: <acxTI2CJlq3npMVa@kbusch-mbp>
X-ClientProxiedBy: BN0PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:408:ec::17) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: af501b52-6589-44c5-40b5-08de90125bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jb0mzuvxVS4Jy9029WVEuazu0iS90+cYwZi1oyRDavDeazD1+5aJkA5weKPpyrfqzrzmcMxBXaicd8nxja07d7YOMNkcZPxV5ebWdLR9DulCp7qhseoln3xQwfRctI50H6NPPV9Wr224O9eOTFv0H2R/7ilDJdpQE+uGa2Lc/1ZApfnf5MG1dnGSc6uAFp+6bNXP94q4RrUkvTLt+5YC22vy5OxetHH3BmPEaF4mUqPYorWGOodoe2nkmpneXoUBkXgZs4ZCfkIrC3FrgHzC6qW/fNw/30IzuUJ2jsd16nIS/rkqXNyyCUIzM+rN9tJ5r5p2/N/ORYrmsh6xAZv+DAu6c0QzVxqzVZbR3pSs0+SQA/YAB3tihoshwgf1MlVIY6EH3T8WXFOo+XuJSv8MpltALEE+xV0V+90Ll8rzcOT2N6sx/VZoMGPw0qUug1H6wtKBl20en2zMAsKhWHNXDnHstoHeAcripfmyRal19MxO4vjdXXUrHwYS2rkJde9wEvpNRNdfHelH321D4MjbC/sdpiVeBBkjr0LS5zQXF9TR1IKhkdsVVXTPWQ+UgYpZbhi5qsmAfhbwcc/otg+Uvt7ViADNGb+L0yRgezRpNSySkkik8fa8DW+UQJcPZRawI9xtUIFhg9GiT5AlBSyW+zECHFwBYgNf6tgA52ZqrMprWIBDVl900lFSdrVEjIRsw3NzP0NlE3NrUosrg3WvbIfiTt+yWz296ZoUZK/hMuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTd6TE1hTW9SNW90b0dKcHFybmFNZWMxODMyZFVVSk1ITEJKSnc4ZHJFMHVp?=
 =?utf-8?B?ZXUwZFlwakZEY2hrZ0Q0RDYyT2Jya1hWUHVyeDY1NDV3Sk5oTHovaWdGa2pP?=
 =?utf-8?B?aXQxOWZpdFM3Vzc0cWtycUptemU2MU9wZkJQYjdRUTFTbTlRYUwvWjgwYk0y?=
 =?utf-8?B?VDd3MWV2eDJpWEJQN3pLOGc0eTFOWFpEcCt5ZjhTcTkwa3ZPQ3Z4S2JYTTJo?=
 =?utf-8?B?WWhtZ2pKNWI0cU1KdWM1VDdOL1FwbUlKa3NYR1FjVkZtblorN043MlFKMUJl?=
 =?utf-8?B?NDRiNFJKTFZHdklVU0NBbTNMK3dDV3p2MklDRFMva1h0VFMySWNvelJ5Y2F4?=
 =?utf-8?B?TDlkblh5RXJCTkpUQnBqeGdJL3VqbkpMRlVYZmxRWTBXcFZDUE1tSlFlbzVO?=
 =?utf-8?B?dmhQOWp0bTRMSmxZQlZSSCtycEdGYWpaMXl2NE1aaWhnV2ZvWmNMdzR6b0d4?=
 =?utf-8?B?U3R5aGZLanJKeHZkMlVnR2JDbWg3T290ZVh3eTd6cmxUb1IyNjloQXBlYmJr?=
 =?utf-8?B?VVlQVGxWNHhhQkdmYWdDR1d0aEhjelNpRmYzWVRRYm42enpEU3pEMGJZMnVR?=
 =?utf-8?B?L1FaUVZlVXlaSTVaTlZNWVpvZWdlNGx5LytGN21hMnQvQktTT2xXREJHRitG?=
 =?utf-8?B?RGQvNmQzaTJKOFlDVTU1U3ZHdGdhY0tObEVHMkc2Z2tlZXI0eEFyTmNoOHh1?=
 =?utf-8?B?MjhTdmJmNmdBNWR1aEZ5QkY1cDNoRWRDOW5BY1hlVHplWTlrbmVVUWlleDls?=
 =?utf-8?B?ZnpQWHpMaTZ4RnVPblhUaHZldDdvZXRMQndmeE5OeGlUL0RkdGlnbTlOeXRJ?=
 =?utf-8?B?V0k2WE9rYUZQVFJSaitQeWw5U0FwU0JQdWxIOHNHaFg5MVdZOVVJUmJsdk1G?=
 =?utf-8?B?ZCtsWFZoMWxJSGg3VHFkeHJUeFRkZlQyZ09seGFHbXpwWVB1MGoybUN2OGE1?=
 =?utf-8?B?b0VoUHhRRUJ5UWlMOC8zSUZtLytsMERuRzVoUStHT003ODNTeFZuQVlxUjNl?=
 =?utf-8?B?SGZxTUxsV3o3ZndZS3R3RDZKa3c1WTdObGpYSkYrY0g5dzVoNDRyYVhqYlB6?=
 =?utf-8?B?SWd1a0tuRklNRTM3Q1Izb1pnTy96NDBoV29hOXhTVnhtMUdwY1dKWGFMQVN2?=
 =?utf-8?B?ald3V2FTWE1QcDNRcU1yNWYrL3BPNnU2aUxHdXNBbmdURHJ4MWFTR0s3U3JU?=
 =?utf-8?B?dUw3RmFSbnVoVjVKWGx5RnA2WFlzengxc2F1anZSODJQQVRlZHdWQ3FRbjM3?=
 =?utf-8?B?NDFrM1RSeU1iaGRTeGFpcWpTa3A1UlJ1RmRqOW1rM20yL05BYm1BS28vbUhJ?=
 =?utf-8?B?cVRWQzFmRDZ0b0NTbXg1bWNMdG5OdjZ3bHM1Q0pPblhueTI0MWdZQWRreWcr?=
 =?utf-8?B?VjNNMnhxZks0SmVtWXoxNHYzL21MOC80d2wrNHdjZVVPcWp3YnNmOUV6Qlg5?=
 =?utf-8?B?Qm9CTCs1R3o1b2NmTlBuZG9SbTRJcU5BaW5JMFdwY0xrZEFMQ0svT1lVSmtN?=
 =?utf-8?B?THZmeExRWHVBcVFESVh5N1NtdVJsS1VieTNYNHVFNnpQUURFeUFycWFtUWZM?=
 =?utf-8?B?bEVIVk03c1RFSktjcTdQMWJDbnRmMm5iWmE0VUlnK0dhUnZpSnRSMDh3OVRs?=
 =?utf-8?B?SU1qaWVidXN3UXE4QTY3QTd2M1BjMEhmNTVtemI0MFZmUEVzZ3lGOEFBcGpN?=
 =?utf-8?B?M09HRDdJQkZpQ2Z6WW9wVXcrU0dtYkpSeVRSR2tDdk11MUYrNmk0aVl0MVdR?=
 =?utf-8?B?QitMK0VheDRyVTJuSXRMaXVqSWZBUkloR29SZGpNU2xCczhLZ1l1SGJBZ04v?=
 =?utf-8?B?U0RjWjlzSXQzSlVON0ZDTGZmajVQRWNIaWdSMmszZUJZR0Q3aEx1VWQ5OXhw?=
 =?utf-8?B?MjdTaUVPVFBSaDBlZVFZVXRIWFJZZzJPSWJKWEFhNzFwTUhzQjBOdDNIai9v?=
 =?utf-8?B?N3B5cXcrSUxxeGRsZkR6NElqb1pnNGJLTVhIVzZuSVNhVDdFZEwrTkhMaGxn?=
 =?utf-8?B?VVVYbWRxMzhJYVdQRG4rTnFvRmlsVWZRZm1qMFJvUmdFUW00MTBOTmtGRkN3?=
 =?utf-8?B?WkFpb0tld3VYdnlwZ2d1S0lnbGxMbjA3R3IydFk2alFOM2xSSm94OGdIZTJD?=
 =?utf-8?B?RmZUWHh6ZVN0KzUvZVNnYWlEYkh1UGN0cmkvZmVXaE8xMzd5SFRrS0ZXL0hq?=
 =?utf-8?B?MXgza09Db2lvRmxwRDUrZ3ZDdE51b1VOckVldkNnc2hUT3dUZ3M3OEFrNTVL?=
 =?utf-8?B?cGpUN1B4ODUyaTFKYUNYL2hMOFFia3dTNkV4N1BNcW9ZT0JhV1QwL1JhNGNj?=
 =?utf-8?B?NjcrWkIxcm5Kak1vT0JENGEvZFZ3OUkzOEpzZExLTUNObllYY2plQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af501b52-6589-44c5-40b5-08de90125bba
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:16:05.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5qv7mWV4tMOxSF3k4hcLmIvzt/Jz2MBDC1crBt4Uwo5Id9C4Jtg3gACBSsrUKSCTXV7GQ2+8A1CrnOKvJ73Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7367
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_181613_004157_AE8C0659 
X-CRM114-Status: GOOD (  22.31  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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

--riyilwvjpctyspcu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 10/13] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 05:05:07PM -0600, Keith Busch wrote:
> > +static bool blk_mq_validate(struct blk_mq_queue_map *qmap,
> > +			    const struct cpumask *active_hctx)
> > +{
> > +	/*
> > +	 * Verify if the mapping is usable when housekeeping
> > +	 * configuration is enabled
> > +	 */
> > +
> > +	for (int queue =3D 0; queue < qmap->nr_queues; queue++) {
> > +		int cpu;

Hi Keith,

Thank you for taking the time to review and test.

> > +
> > +		if (cpumask_test_cpu(queue, active_hctx)) {
> > +			/*
> > +			 * This htcx has at least one online CPU thus it
>=20
> Typo, should say "hctx".

Acknowledged.

> > +			 * is able to serve any assigned isolated CPU.
> > +			 */
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * There is no housekeeping online CPU for this hctx, all
> > +		 * good as long as all non houskeeping CPUs are also
>=20
> Typo, "housekeeping".

Acknowledged.

> ...
>=20
> >  void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
> >  {
> > -	const struct cpumask *masks;
> > +	struct cpumask *masks __free(kfree) =3D NULL;
> > +	const struct cpumask *constraint;
> >  	unsigned int queue, cpu, nr_masks;
> > +	cpumask_var_t active_hctx;
> > =20
> > -	masks =3D group_cpus_evenly(qmap->nr_queues, &nr_masks);
> > -	if (!masks) {
> > -		for_each_possible_cpu(cpu)
> > -			qmap->mq_map[cpu] =3D qmap->queue_offset;
> > -		return;
> > -	}
> > +	if (!zalloc_cpumask_var(&active_hctx, GFP_KERNEL))
> > +		goto fallback;
> > +
> > +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
> > +		constraint =3D housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> > +	else
> > +		constraint =3D cpu_possible_mask;
> > +
> > +	/* Map CPUs to the hardware contexts (hctx) */
> > +	masks =3D group_mask_cpus_evenly(qmap->nr_queues, constraint, &nr_mas=
ks);
> > +	if (!masks)
> > +		goto free_fallback;
> > =20
> >  	for (queue =3D 0; queue < qmap->nr_queues; queue++) {
> > -		for_each_cpu(cpu, &masks[queue % nr_masks])
> > -			qmap->mq_map[cpu] =3D qmap->queue_offset + queue;
> > +		unsigned int idx =3D (qmap->queue_offset + queue) % nr_masks;
> > +
> > +		for_each_cpu(cpu, &masks[idx]) {
> > +			qmap->mq_map[cpu] =3D idx;
>=20
> I think there's something off with this when we have multiple queue maps.=
 The
> wrapping loses the offset when we've isolated CPUs, so I think the index =
would
> end up incorrect.
>=20
> Trying this series out when "nvme.poll_queues=3D2" with isolcpus set, I am
> getting a kernel panic:

To resolve this comprehensively, I have made the following adjustments:

    1.  qmap->mq_map now strictly stores the absolute hardware index
        (qmap->queue_offset + queue) across both the primary assignment
        loop and the unassigned CPU fallback loop.

    2.  The active_hctx cpumask now strictly tracks the relative index
        (queue) for the current map being processed, preventing
        out-of-bounds mask tracking.

    3.  The validation check within blk_mq_validate() has been updated to
        correctly compare the absolute index stored in mq_map against the
        offset-adjusted queue index.

I shall fold these corrections directly into the next series.


Best regards,
--=20
Aaron Tomlin

--riyilwvjpctyspcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmnNUs0ACgkQ4t6WWBnM
d9bwwRAArG+mD7cntRzDM5s4MrtIevTU2rwU42jGlmcZEycR87jgRV0kclgbslmd
VfNkfbl2nPqeG/GNRy4XIsIhWnP6LThpOMZGwD5R3EEiQssd0Jhllox6s7HjH3VS
/J0Um32Ds+Os2u2GZVUvRDZOO0GozMsxrQbSFFwFRFM/3uvk+vT1hfKIMrQx0w4w
wWGBkbS4rxCQN3ZY0zdWz0/3oZKNr7W+PanK8utQgmpphuejejW7QvL8ykCiAAof
R++nw7HdnQShHGjPMLJBiEshwSNeanEv/h3Wwz1A9WrhNua7xAF5+9/1wXlbjBmZ
QMUfNiPsqGDN2TJYEPsFBOCLQyhNfk+pVE2rSIV3sg7WE0pKaU2sUgYyXZeO4qrA
w9C7ZuQV08x4SegZiEGyNFN1OuMkvEDtDh+4moHmc1nKWuvEClvbKVw0G2e80qDe
I/w56G/dpKalUviPzJT1mc1kUh8pVrm3plEUf2ZEwb4ehfC4p8sLXctOacLKXEbU
WBm3soCXTvoVxaAyAsUDRzVoWT531SPxz0+YTvIIxNcx1PVXirFdW9RXXISKA1P7
YFrlqJM1Gq2zM3hgMRfBGN/UjiboWUw1vU9DkUmR4FzSyESWfazXG6EEkIwsd4kz
pXkhR+aJQDhoyvAuS1rBxK/jggzeMo9TwqRuWf9G7nHxoLPhfIw=
=cH5L
-----END PGP SIGNATURE-----

--riyilwvjpctyspcu--


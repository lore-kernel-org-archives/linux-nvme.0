Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 11:24:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7210060E9B
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 11:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7210060E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGJ8r6iBRg1sZw/RQsKjIc7CXbzhALdwAsnaGhsN/3Q=; b=lqYo4GeJgADtQFqEn3GnEKYfAG
	LVGC75KVNDCi68gypYJ/Sr1lxibzkNQtfYPm+4BaE9FwnWWFt/761kKV4h9zwUgaE8Rsx0Smpb84L
	1HIIaPsNqOc8MxiC/z9dGtq+MAiUf2NqF86hAudlvRehCDZ7FLyNx++BfxW2ys+AJ6yHS3DHCwtF3
	qzzZfUJVCkprlT7vCDPRKLLrFnOA8tPsgwLk4bpbULuzP4db7SXrWK/GqjkymQX8SZJ/eC4X/CTn/
	NTlUlDUGThYbImEvQXTWq8jQdr2ROXebxtl6t4llWuevEox/ADYsYQWpsUSO0xhE7pCBddIAuCKXJ
	WXN2xZ2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhrts-001W2m-FC; Tue, 02 Nov 2021 11:24:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhrtp-001W28-KQ
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 11:24:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1635852256; x=1667388256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KwfEjitxoGzpJs4ra33lkj2BCoREHseubtTRtKxfx+w=;
 b=BKyrPHITi65aJPn2Z80bsvrezxiqsE7CMGPmr2WmNVsyDg4LJGb61GJU
 4pZHcOdgwILxCugb+5Ub6Tw0+X40QSCHlcEQnj4K6XF+HP1LLUKCC3l/R
 m9ZsmSI0hIf+9cxIFA5cCrInahAMuOftCCN/ISLGmZd4KVo9L6/ABJt7n
 pLplzmuRKU8gtrxnKZNH3+IafgAUT4slX162E/IP6qNpV4nW9/QtL6RTb
 TMPp9AMUbSIR1L8cdM/0Sz67TLn3SpSz2I6bes4sbEik9q0nwUoR0tG5v
 kzJsb8+h70FMsKFZLFQaPPfkFPG9z2TeGR/ZCdMFEd4rhpgMo+YwZU4mz Q==;
X-IronPort-AV: E=Sophos;i="5.87,202,1631548800"; d="scan'208";a="184476961"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
 by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 19:24:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noAuSnKvM/mnoild7iZkHlG8xK6g8hjY/gvT2xsATwlig+iRdC4nOecs08Q+3Whn7Wc9F7AB5pO1KEaN92rV+aJACVWHhNLF1pU+XIr23HhD7b/mMwe36QlKDAK540GtxTWLSaB9SgLWuGxyS+yiE+W8qBTk1yCOhWk7siBPpYW8KhoJtsGLtFrAm9sjGF4fBDryxEmMdk497BAb5nNtzf3w3ky3lPQaEa+o/YgfuMeZEoVqhdlGTwny7ma8cwAWGQ+A2EixI8swyD+MRUO3CSzD3WCglY0EQsCnpby1b8gAFqsW2XWPZJe4z/y39KE1eu7AG7vHJoxZb189lLfnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGJ8r6iBRg1sZw/RQsKjIc7CXbzhALdwAsnaGhsN/3Q=;
 b=id8m3IFQxq0RxLq/rvAcuEoeQ3IeqZHEA/RwrGBC91kLNYJd61peLHlYYGtc+Va3IETkdXx9LShJhUHOjhXtsHNuUMEtWJBTwjE04f9p6/RlYagIw7Oz1astjhThnQnaA1k0/5W3L5IhR68jCRYH3Go7KC+PDtp9zA+R5xicTkylzfMbgo3CsavobOEQs/j/DxG1+/UcQn6HVGPxI2jwg1xQnoY/EWPB8iKiAwhBR2uhV0wJv7nurHrYxlTt6SdvqW7fUaZ3BesoRKClMg5O6wK4JhMwrOiD1DzmSQtfdLswwI4ZTuyYNe0OtpHWdaGG8agyYgU8qIbR2a6A5fFb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGJ8r6iBRg1sZw/RQsKjIc7CXbzhALdwAsnaGhsN/3Q=;
 b=bHRVEP2TD/1FQYmwpi22tEciA4mC4XCBhGOXZApRlTB1AVuzXBl/EbHCcCTdon4jHxZbw7qLaopOIy8no8z/dTUAu+QPwFO84vEe1xVHo2jmHTkcyFKTSRPLq0jbr246Q4xzXngtPGfSkJHzVCug2AoxqRfqjnY7s4bjXzrF+7o=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4453.namprd04.prod.outlook.com (2603:10b6:a03:59::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 11:24:07 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 11:24:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVqvunZKAgACtRQCAADgYAIAAFuyAgABPfACAAAmAAIAAHYsAgAAJ8gA=
Date: Tue, 2 Nov 2021 11:24:06 +0000
Message-ID: <20211102112406.jylx25xeazmcqzw4@shindev>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev> <YYC0ESdW1+B/dDTs@T590>
 <20211102082846.m632phnsaqnwtaec@shindev>
 <20211102090246.5own2pqinv3lw6qg@shindev> <YYEXfnqi+mgVv54X@T590>
In-Reply-To: <YYEXfnqi+mgVv54X@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ce0e96-d27f-407a-897c-08d99df348a0
x-ms-traffictypediagnostic: BYAPR04MB4453:
x-microsoft-antispam-prvs: <BYAPR04MB44534F747E98E976131ADDEBED8B9@BYAPR04MB4453.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRB49sULXtsMhEp6KQkDbKd4aYk2jcJPdGElMD5KVzYquzZnJhGiSvR7kuhgAIqQGB+PPlXsUsXZ6JDbOVwrxMhFbow89jk7BFLSw+lxTgjrskq8v6kI4ZSPruMW2qQZKaa8mhkuGzTFAVIKZbX3Vuzp12TDM2v1BDSI74pbI3bCtAYunAy6ggiEt+zZchK56Yw2F5T6nD7n/WyzP5PDqaYyB5bXLRaL9GvXA/BhmSKR+uTEdyYM/DL3JL82tsjp66oCsT3/jrjjN5KRNn64+yn9G5pL+0RiYUCH+lWozvWwjwurkrwxpQ1kaydyLryrc65ns6mDK13uRwL3NLY2quG9PVB3I9J9PsoxEZ6SVkHYkoj88QO47KswvHe7XqbhxRyzEkvAZtAp+j9xdhFeYLjnR6MI7j0L70jeTTbpxz8UL0fUc9WY3FQCn+SUZ+ixj1PSiuASd/xUw5rFsGR6Nqm6AP6HJ4u+pw1oat1LnPZRbxOdYRXnpWgYGQBheEQvF5fjS+S7xJ2W+2zPG+RWV5viqlnhNOwV3wyk/zDaJ6u4Q6SuvgJwbNYIzbSXJwYVFKFwwuvVARjfowN0xwfiTUDAqCdwSZNxJaL+HfBZjQ24mH2+c1PNE9H39WxsokSN1rPImMpankqqKv40kRCNdZEaxipNWRA4TMfnB6w+HGrmf5ElAZh3Z0Rb+fNmGv2JL+Z3A4SPwLSjc2RemoqPXv0/hKSyuYYOxuwDfGQhmvfMRKgdyZOc+KUxRs/LtmrL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR04MB7184.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(44832011)(83380400001)(38100700002)(5660300002)(82960400001)(122000001)(54906003)(8676002)(6486002)(71200400001)(33716001)(91956017)(508600001)(66446008)(1076003)(4326008)(6916009)(64756008)(53546011)(86362001)(6506007)(26005)(6512007)(8936002)(76116006)(9686003)(38070700005)(66946007)(66556008)(66476007)(186003)(316002)(2906002)(458404002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TalSdFaKXjwpx+vGvkWRo7y2qAAy/Uv2lA9pw44gENlfB7KuTx0DEkv0kkCt?=
 =?us-ascii?Q?xApo26cxOjmMOZX2lXUy0PAkITbtDtKrjGnwElunMRodeIiAcb+GSF2X+ctW?=
 =?us-ascii?Q?PeTmrTdYtE6y7z/A3r/rOC8EMrJp16etMBZ1rFjMi31d3sYjyfgr1LEPJfLc?=
 =?us-ascii?Q?qsn5NlPWd/pRwGhqPU8UUtSTvrLi6YxXBKmSAaomL+yrscUOeMaYelyJ5815?=
 =?us-ascii?Q?SJW5KkztE+1uGIZ3ntgD02/32EyWz+nhhlpeyvTG7dbL2SPuyqvulajfp7bJ?=
 =?us-ascii?Q?WnevVdxjN9gRhYaaUdMaLRLWU6O6Q3ap7POvlf/N84X4tdzQduugBrLoT60q?=
 =?us-ascii?Q?b95FcPfjlS95uMei+RzT1ZnMLq9vm6/39uDfZq/euiTM7fsab9ENAq9RaEPn?=
 =?us-ascii?Q?voAjVthT0rBXT4tHI65is3KJqDlThqSDBg62Re3FoQzgvsPb8jhmjEBFNGIv?=
 =?us-ascii?Q?kgUHzUXGL/v2NXSX+gejXKXS/Nx3ZFWmxDPhZofUKWj5XXPeuOtFQjcOxjdu?=
 =?us-ascii?Q?FKwJWfsVhQhXxvDFeOrDlX41ttznqQhRWq5d6b8YR0i57DLjVzoKj0ib6O3V?=
 =?us-ascii?Q?/hUZ/G80d+BVKRbH4sIDTDt5Skznjv3Y+RejHnHbo1/mLZZ3YNCT+/v+O5Z9?=
 =?us-ascii?Q?syu3Y8/SOKEXGPFPFacgsVWtSEoCFoLZUPDhFgwlIa80JrZg6FeeLeoiozRZ?=
 =?us-ascii?Q?B8OTLlEfN0lVamZevIAfOmphFpi9bkR6sA6BT6DPvbia7foJPD0FXqWHLHZ7?=
 =?us-ascii?Q?9+zTkC2+9ivzBWLAOA+TLzV7qwIbQYHKAUhYsp+WNDWQU3b8jR0iW+MObATg?=
 =?us-ascii?Q?MRPFnu83Ac9ohYuN+c1xD67W0041NNSnTR0krQ4+XaHJOmHTbODzFO8xbiv8?=
 =?us-ascii?Q?GMB5KqySrHakQTgK0/ne9Vxt+KnU3eP5YKOPrHxZ76STMGy/pWoxMLSsrwPh?=
 =?us-ascii?Q?rBFopJxOiugCSwsD0DizvYAyYHe6ZmTLCKp7ndD+t6G8P5vNNP7xuSflInpN?=
 =?us-ascii?Q?qR/yOv7AMx8YT2Qci7+kvpYmQCPpM9GK/3W26I2gwA6Rdo72I6b41uMpo1p0?=
 =?us-ascii?Q?Hxqv7RvcMeSQxRADhnbgZwVMYw6H1EQXW0ten3MMYyZm8rFmLzNIuz97CbNS?=
 =?us-ascii?Q?F4V3wH+J4paxDtNLc4cw5wtmJZbkujwQcsZgqV3L3ss9V9fDMxMFRDkWIugu?=
 =?us-ascii?Q?GQ8yPUszxSfc6HouaXQyPe1o0ZbhHlx8+vSYZOAapp2DJZpreuS197HMgwQa?=
 =?us-ascii?Q?bcjA3Cl00eWkH6WBf4zUfVnIpgOuU7Bp3NjfdpSOIkcaI9+BMx0ghIKb62tk?=
 =?us-ascii?Q?I37NHaajBrVTi/l56YDZmis3gPpb+Ch4Y5/Icr33ucMeUkQUSVMV+QtwzH9U?=
 =?us-ascii?Q?L+we2sw/DTul+BGyWGzdemI2yZb69aRlmK0HXlA268bwqIQFo29qienTIxlz?=
 =?us-ascii?Q?QmUTGB1iliej8oG96eg2D5NcmwGaiaM9eyvhlQoUWahUXI31OZqaodWuDud3?=
 =?us-ascii?Q?/nTSJBi1YvgVs2xRFh6iC882NGR3gYfP/BysPOi0KJoexF0qJIv9inhZEIqz?=
 =?us-ascii?Q?N/9LX00zAu3yIB/BFEmAU50frokdiH+WkCZ03EoRaPqhp7ZiflvDaJzXRC/u?=
 =?us-ascii?Q?/nHmlrEqYGQfN2BX+qctDzGJO3df1tJmLp1WSHQ6etPmJQ21QfYjr9ea5v8q?=
 =?us-ascii?Q?Ti/lNctIlvgWH/IhwlgaGF8yUjg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90D872D74CCCF7409B21AE1F4AED2A9A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ce0e96-d27f-407a-897c-08d99df348a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 11:24:06.8967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NV88+yqB4Jvj3UPQGEY3DZkSvZG9ZnFddFnPVjhJ+/p28pDPX8F8B8z3J/Qb0uOqRp3F8v3UcEIOpotFu6TaOZwkipgD6Errxzchf7EHej4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4453
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_042417_816506_E521FF03 
X-CRM114-Status: GOOD (  50.83  )
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

On Nov 02, 2021 / 18:48, Ming Lei wrote:
> On Tue, Nov 02, 2021 at 09:02:47AM +0000, Shinichiro Kawasaki wrote:
> > Let me add linux-nvme, Keith and Christoph to the CC list.
> >=20
> > --=20
> > Best Regards,
> > Shin'ichiro Kawasaki
> >=20
> >=20
> > On Nov 02, 2021 / 17:28, Shin'ichiro Kawasaki wrote:
> > > On Nov 02, 2021 / 11:44, Ming Lei wrote:
> > > > On Tue, Nov 02, 2021 at 02:22:15AM +0000, Shinichiro Kawasaki wrote=
:
> > > > > On Nov 01, 2021 / 17:01, Jens Axboe wrote:
> > > > > > On 11/1/21 6:41 AM, Jens Axboe wrote:
> > > > > > > On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
> > > > > > >> I tried the latest linux-block/for-next branch tip (git hash=
 b43fadb6631f and
> > > > > > >> observed a process hang during blktests block/005 run on a N=
VMe device.
> > > > > > >> Kernel message reported "INFO: task check:1224 blocked for m=
ore than 122
> > > > > > >> seconds." with call trace [1]. So far, the hang is 100% repr=
oducible with my
> > > > > > >> system. This hang is not observed with HDDs or null_blk devi=
ces.
> > > > > > >>
> > > > > > >> I bisected and found the commit 4f5022453acd ("nvme: wire up=
 completion batching
> > > > > > >> for the IRQ path") triggers the hang. When I revert this com=
mit from the
> > > > > > >> for-next branch tip, the hang disappears. The block/005 test=
 case does IO
> > > > > > >> scheduler switch during IO, and the completion path change b=
y the commit looks
> > > > > > >> affecting the scheduler switch. Comments for solution will b=
e appreciated.
> > > > > > >=20
> > > > > > > I'll take a look at this.
> > > > > >=20
> > > > > > I've tried running various things most of the day, and I cannot
> > > > > > reproduce this issue nor do I see what it could be. Even if req=
uests are
> > > > > > split between batched completion and one-by-one completion, it =
works
> > > > > > just fine for me. No special care needs to be taken for put_man=
y() on
> > > > > > the queue reference, as the wake_up() happens for the ref going=
 to zero.
> > > > > >=20
> > > > > > Tell me more about your setup. What does the runtimes of the te=
st look
> > > > > > like? Do you have all schedulers enabled? What kind of NVMe dev=
ice is
> > > > > > this?
> > > > >=20
> > > > > Thank you for spending your precious time. With the kernel withou=
t the hang,
> > > > > the test case completes around 20 seconds. When the hang happens,=
 the check
> > > > > script process stops at blk_mq_freeze_queue_wait() at scheduler c=
hange, and fio
> > > > > workload processes stop at __blkdev_direct_IO_simple(). The test =
case does not
> > > > > end, so I need to reboot the system for the next trial. While wai=
ting the test
> > > > > case completion, the kernel repeats the same INFO message every 2=
 minutes.
> > > > >=20
> > > > > Regarding the scheduler, I compiled the kernel with mq-deadline a=
nd kyber.
> > > > >=20
> > > > > The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name =
space and
> > > > > a regular name space, and the hang is observed with both name spa=
ces. I have
> > > > > not yet tried other NVME devices, so I will try them.
> > > > >=20
> > > > > >=20
> > > > > > FWIW, this is upstream now, so testing with Linus -git would be
> > > > > > preferable.
> > > > >=20
> > > > > I see. I have switched from linux-block for-next branch to the up=
stream branch
> > > > > of Linus. At git hash 879dbe9ffebc, and still the hang is observe=
d.
> > > >=20
> > > > Can you post the blk-mq debugfs log after the hang is triggered?
> > > >=20
> > > > (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -a=
H . {} \;)
> > >=20
> > > Thanks Ming. When I ran the command above, the grep command stopped w=
hen it
> > > opened tag related files in the debugfs tree. That grep command looke=
d hanking
> > > also. So I used the find command below instead to exclude the tag rel=
ated files.
> > >=20
> > > # find . -type f -not -name *tag* -exec grep -aH . {} \;
> > >=20
> > > Here I share the captured log.
> > >=20
>=20
> It is a bit odd since batching completion shouldn't be triggered in case
> of io sched, but blk_mq_end_request_batch() does not restart hctx, so
> maybe you can try the following patch:
>=20
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 07eb1412760b..4c0c9af9235e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -846,16 +846,20 @@ void blk_mq_end_request_batch(struct io_comp_batch =
*iob)
>  		rq_qos_done(rq->q, rq);
> =20
>  		if (nr_tags =3D=3D TAG_COMP_BATCH || cur_hctx !=3D rq->mq_hctx) {
> -			if (cur_hctx)
> +			if (cur_hctx) {
>  				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
> +				blk_mq_sched_restart(cur_hctx);
> +			}
>  			nr_tags =3D 0;
>  			cur_hctx =3D rq->mq_hctx;
>  		}
>  		tags[nr_tags++] =3D rq->tag;
>  	}
> =20
> -	if (nr_tags)
> +	if (nr_tags) {
>  		blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
> +		blk_mq_sched_restart(cur_hctx);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_end_request_batch);

Ming, thank you, but unfortunately, still I observe the hang with the patch
above.

--=20
Best Regards,
Shin'ichiro Kawasaki=


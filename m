Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5200EECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rjg8XbJkV0rOBP45VDSz6QGDB5WDcxkZ51ng6ibUikA=; b=DFXLeyHMK3M0wmAQpoUzeuMTGr
	HJ30mbs2sXXc4lJYHhdtlsWL6e1VEWdIiz8sVNVir+CrkVz8AmWsw9VFPsZUy6e8rP7dUAB1B0FIa
	8tAFoZGSERJaWtTGeuuK65k8bX0wpa8es3niQjCejKaUThy54tZdWt5wTx8mOLD6ACTGeUIy4GzD7
	P8Hem1c03hoUscZdzw8vpi1NnSL9wEg0PA4joCNns0XyZ2pxu6t7hy5TPOlF+XgUj+lJ8yA34PGsY
	kWpXrMuZVRNa+658oSaCw+yHT4J0KwcLjaKzmP7SNV51rqyIi+Qky0heuR4ONi6SwhSJqCVuob+Pi
	tENMIbbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRWBc-001BLV-5h; Fri, 26 Aug 2022 10:03:36 +0000
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRWBV-001B8S-GX
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 10:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661508210; x=1693044210;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Rjg8XbJkV0rOBP45VDSz6QGDB5WDcxkZ51ng6ibUikA=;
  b=ycWfKZl5UCSg7oSov9doFvP+0rxompxfP0qZOMOxPVcR6tSRk3oQ0s3W
   mrdUOT730tfycGoWkoBgDfZacDtxrG4jKXmbcDMGYgOo6r6nd7t12H523
   D7iDkyDga5Zx8AxgzL9MA/yOZbtUVid98TFyu6UmFtZxyWbZhb4aBYcFz
   plH7IkJAx/Gf2oBaMWmv1upG568SqZksBm79Bt2QctZ3UZVFAbxwo2OhE
   B89ahTMUwow2he4eW1nCbi8CqwzJ4wti5Qr7FQBumw6RALQ+Ysr3Ujzt7
   1B5AmDmPRxZkTru9Ae/Ns0QfKB6QuxfLIrMYMmNjz37NNFU6eprI2eySA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="63563758"
X-IronPort-AV: E=Sophos;i="5.93,265,1654527600"; 
   d="scan'208";a="63563758"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 19:03:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXHSje7k2NvlwWW1jqcfYFFpm6qbB9nyIXnjw0i4mapjoo2QRpMx2W3UAZroJeWWtPdffjoTHFtq7i2rXs7YV3WizsPHIrzlT1NUvtKBBvZZF95xmnS93kFrvIkSVk+IgwvUs5SBX8+anIpidrGT7kpcFsT3vgd3C9kWL37f8kjc54MlrtpzfNYS0F9MwYI6JMy9Lix44K54oPNoe4esd710eeLhJ3egJh1UvvbWr/Zl8GpSJ9URvvD1MJz2nJVgR7ChwKLlxr/mXx2NfcpvLSfW4Zd7CU33gtRT7O157h/UtCSyCMSpS/qqyvUudpW8UMTgHKd0hf6Ds5nuSUsMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjg8XbJkV0rOBP45VDSz6QGDB5WDcxkZ51ng6ibUikA=;
 b=LNYY4/LzZ8ob7mjuoOvK9KFqtcomoPapMn3n3YJTviYrdQgIZzZN/hfEdL8fGD2fIVr8hCOOKdlKgsd9kRlr3JNxwpZo58S5oAzyCKcmnv9A5Lx6vNt1oLy1pLl5QTVeY5xhCFarCbfFzxnBrpWJiy/iDX6Nr7e8hFtivb0vEsCyH1/VWrPkzgVmjoHrIwirjw9thf7jij1RldX2jlv0+D7NA8LKVUEoD8Y/FtTEss0T5uQlZBhDPmCjyQxz4j4Jv5mOnIDMm8ndt0PuvtzWd3/l7ojD5ASwXeYMZdfLhsToZahVI/mAcJTWlcqtjaQiBeuPWVSzkZe5JhZ45KGHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8201.jpnprd01.prod.outlook.com (2603:1096:604:164::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 10:03:19 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 10:03:19 +0000
From: "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>, RDMA mailing list
	<linux-rdma@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Topic: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Index: AQHX6LvFpcY61i1rak26VhnSnZTaj60we/uAgJBCJYCAAAeXgIABzusA
Date: Fri, 26 Aug 2022 10:03:18 +0000
Message-ID: <8bb6c1f4-d5c3-4eb6-0118-143b35f6e881@fujitsu.com>
References:  <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <a4490b74-146e-809c-c969-aebc5835e2e2@fujitsu.com>
 <a4412795-8079-025e-6d6c-ecf18cad2e4a@linux.dev>
In-Reply-To: <a4412795-8079-025e-6d6c-ecf18cad2e4a@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 760fea90-3b5e-4c11-fa33-08da874a33b2
x-ms-traffictypediagnostic: OSZPR01MB8201:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  kX4IUWHMPeb4tGm7A7rRoxodc+QVceTgVCtZs8YraYm0pKC8GwF3IorOTPNgaXCQj6UtUCgZhAsyv0/YMlwM8GJi/LGsjIHlN3KYYO0Y2L8r1rFk6ND1dNtHM9Bk37EToYpejPA09jz8E5RuTxGyouoZwYMO09UEsMBG7iCuIgevqSLxT7yjOB3rzGa5aet4EygnjlFSSxPMc+6QR67VxsIcfV5Lq0NCk+q8onwzTWRgbDskbaapVJgZfQxRWNpO8m+amlt6BdVo+yL48Ch3SdImUizFHSaHifgPXehbtp/xRx8jdC40ZXjtR8dsg1lYuIPU/RL9uyrtKGeW06/y7Bj5imJV8G2iWGq+mDBdhm1nM1aMNDJcNoQlk/irw9v0QOBujBtXm4rrJbbWOQyv7ZPvSutWlSRSvab235PdB6PMMKDloWuiWjga8tM3POJFoEJTalEcDuYuuwHJSTBQprhzelo/pNKrHz+2rrQkDywAaah76jikAgaJc/DIruxfmvhRIGMXmcIWJ2iMwC2Swvl7d7ox/V/9wOlgQQfYc5cMSjAvgmyCsaK2XW7ASJFSo77u04b8GnPl7Zbs3BMCVJEoKa1Av+OXttT6kkQNQ8qf8e1zQizu3TgDN57nsSzmXCOI47OEHw6tuACjyj5fgBKmCqTD/+M/naleXtC4/A94CPOcOaEskQ/nYLYu4hXlbxqUwIflRaMzPz3dv1v6zXNQmnKIWy32/WlSydPyabVQyRxCUYWD90RKzNrDT6r1GeNjwoR1aKHuqpKXHDnaSnNkekqBzftNmf7Pducg5qIbBk3E22fSr9PUo1BDfP/83nxX283tl+DH+J4R6/rYhnWRqyhnn+FctcvcykEebNxvqV5JyWEWg/4lp/hTphUvgmNuX4pMku5Z8kFwjoNMcw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(1590799006)(41300700001)(38070700005)(6506007)(71200400001)(6486002)(53546011)(186003)(26005)(83380400001)(1580799003)(6512007)(316002)(2906002)(2616005)(5660300002)(91956017)(66946007)(76116006)(31696002)(8936002)(966005)(38100700002)(478600001)(36756003)(64756008)(66556008)(8676002)(122000001)(66446008)(110136005)(82960400001)(66476007)(85182001)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MHJDTG13NkxuWTZiKzcvdEpMOG4yN2RwdDlFRFI0RFZhaC81Kzh3VXBlSWNa?=
 =?utf-8?B?K25LVUkxU1NqN2pVenJRWFJyWFB5M0JuOUk0N0hTTHcrb3J6MGp0cDkwQzFs?=
 =?utf-8?B?UW9zM2tSMkVQZGZzUG1zRGNhR0RsWTl1SndmWW9mMXoyTnJHenVSeGJCU1Vm?=
 =?utf-8?B?OHFsSmc1SSthR2NSYWNxSlBVOU1mdEJWcFY3RGFaaFg3emRsOGJrL1dscDh1?=
 =?utf-8?B?K2RiTjR1N1JOZE5RdWNIUXlBZDQzSEk3N1VFWWNoWWhXT1RMbFFGbDVDTUdo?=
 =?utf-8?B?WWtRa0UzajZkY3dtdldZY09QYU1XNDRGQU4rb0JJU1VsOGpRd0VoYkFLK0J6?=
 =?utf-8?B?Ri83Zm1DT2tDdlNJY0lzdHMvdlJYOFlka0VYUHk0MWQwQXhUWHlmSmt2bVFQ?=
 =?utf-8?B?NjVkbjRWSHQyTzE4WFU4TDhEVTVEQko2bkpWRlQ4TDVrbmk1QS9Zc3lDaVNC?=
 =?utf-8?B?anY4ckJCS3Q3c3VGY2w2cXlVVkkrSnR6OFJKdEhRQURZSVl0TDlWbk9KRVdW?=
 =?utf-8?B?aVBSdTdLQkNDWUp4WjhLWlY4citCLzY4cnA1SU9reGUvT2lGa3dLaGtWOWlk?=
 =?utf-8?B?UGV1UHpVckFIakZqcWpzSHFUT2hWMVpNZk13S2IzTDRIM2JFUHVna3FMK3BR?=
 =?utf-8?B?YSt2OGNqV2JsUVlVanFVNmZXeG9OKzMvcnk3RlM0NmdXRy92SDZUYjd3dmRp?=
 =?utf-8?B?Y2FBSzA1SDhDV2FjempRUElYN09Vc1ZIR0tzZ3hWbThoNjZjejRETzhHOHZJ?=
 =?utf-8?B?M0dWZ3pwQ1pETVM3N3E2dVJ6NEJwaWZUK2NNaEwzYjZKVmJjcWdyVnFqdnhq?=
 =?utf-8?B?ZWpyQWxoOU1WNzRaaHZYRGRyMGM1UlZHc1VueWw4VmJvZEJoNzhtKy9scS81?=
 =?utf-8?B?OVNUM3pIa1dmVGdwTkpxK3lmcFVmUGxsSUZHc3JyU1VsUnowalFiZExJNWNq?=
 =?utf-8?B?QWpFdXVUQXcrQ3hDMFA0QU5xc09vckFQZHZBQjErYUMydkpRMWJBM1hUUGpr?=
 =?utf-8?B?Y1lxZGY3SnNBVjIyaXZXdmhrYzhTZVp3bHNkWjhINVM2ekFNUDVZdUdnRlJl?=
 =?utf-8?B?Y1luQXNKTk9xanBOYUZTanZmQmdmS2xsTzgvVDBRV2lOc1JYVVZ2S0d5WGQ2?=
 =?utf-8?B?Ty9xNUU3QzdSd1ZVVytiamFyRHNWdzZkNlhibHc4dVB1b282bno1UFRqZEZn?=
 =?utf-8?B?VTFXeEFGVXlmcDFLOFdqU1R4aGVNTnEwSXAwVmozMHhsc20wQ0JrSkxZY2cz?=
 =?utf-8?B?WENFdmRRZ0tjOEdZUi9mV2R4Y1VMbWdTYlRqVWwzT1YrQWpQSklsUDdtRUhH?=
 =?utf-8?B?MmRXY0Erc1BzYW9YTXF2VTQydVJBN2JSSVJUVFhWbnZlYUVXY09QK01WMkFx?=
 =?utf-8?B?Tmpod3NJYkkyN3VkMGhoWEtKb29ydUxyT0dXY3N1Ynk5UmZkVzExVW5qOEEw?=
 =?utf-8?B?TWdhV0RRQlB1Q2hXS2t3Rm1iWEZsMGs5RU5mSVpabEFSMVR3bURzeTQvUU02?=
 =?utf-8?B?M2ozMVM4a29TQkhwc0hUcnRXYkNNRFQrMThuUTM0ajBlYjFKS0paTzB4ejg0?=
 =?utf-8?B?SzFvUnkwbFlJVEhHczc4VXN6VlBkbDI2MHFQL0VQNmRsTU5IcjFEUmV0RE1Z?=
 =?utf-8?B?bWo3aDYwQ081YVRDbkI2ZFZyK2hhQ0VxbnFCaGlZcmpjZkpSbHl4eG5kRk1W?=
 =?utf-8?B?OGFNMEZFK2lHLzlkNWI5d0k5U3dZQWEzMENTSUJLanVyQlpGRkJsZUNMSlAr?=
 =?utf-8?B?Q1lFZ1VCRVkvME1HZzlVSDNhUjF3Ym8yZS9hNlNpMW5nNDdkOTZvQy92alRl?=
 =?utf-8?B?OEEyVVp3ekN3ZTdUQ0hkUy80cXFTL2hMQ3VFaGxEVjFibEg3ck1yaFZZYmlK?=
 =?utf-8?B?T0lPelRzT1lIeElxbTNVT3ZFZ1BpR0ttb1l5YzdmZDVpdS96T1lBdmlsQ0lF?=
 =?utf-8?B?azdLM1RJMld6NVBTMzJkN1VXdDBuNjBHY00rVTJ4ckdBdUtXZE91bXVvb2gr?=
 =?utf-8?B?ZnNxMk1UTitmMjhpUmRCVWZlZUFzOTAwZnNxOVpNWkFhZHBCSk1URU5vcVJM?=
 =?utf-8?B?Q1h0WWhXaFZwMDVsejV6c3hJN3pLQ1Z4b3BsMGx3d0VIbWpGVjlmc05Fb1JQ?=
 =?utf-8?B?M2FuRGJPVkNjMXhyaHBTbkMzVVFmM1pCSDA0bnByMmJjekZTWFdBdzZDT0RR?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15BE67007B9DB4385BD83372B2BA91D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760fea90-3b5e-4c11-fa33-08da874a33b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 10:03:19.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIM2EJzjGWJ+Mg2k8nLyDt9r4vc3YDnxGgdA8Tb8i10RLbzWiRQ3G4KRvctgx3hgoBknkFu7C0NqlkSNmZ1luw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_030330_127039_984C6570 
X-CRM114-Status: GOOD (  23.58  )
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

T24gMjAyMi84LzI1IDE0OjI2LCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDgv
MjUvMjIgMTo1OSBQTSwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+PiBPbiAyMDIyLzUv
MjUgMTk6MDEsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4gaWlyYyB0aGlzIHdhcyByZXBvcnRl
ZCBiZWZvcmUsIGJhc2VkIG9uIG15IGFuYWx5c2lzIGxvY2tkZXAgaXMgZ2l2aW5nDQo+Pj4gYSBm
YWxzZSBhbGFybSBoZXJlLiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGlkX3ByaXYtPmhhbmRsZXJf
bXV0ZXggY2Fubm90DQo+Pj4gYmUgdGhlIHNhbWUgZm9yIGJvdGggY21faWQgdGhhdCBpcyBoYW5k
bGluZyB0aGUgY29ubmVjdCBhbmQgdGhlIGNtX2lkDQo+Pj4gdGhhdCBpcyBoYW5kbGluZyB0aGUg
cmRtYV9kZXN0cm95X2lkIGJlY2F1c2UgcmRtYV9kZXN0cm95X2lkIGNhbGwNCj4+PiBpcyBhbHdh
eXMgY2FsbGVkIG9uIGEgYWxyZWFkeSBkaXNjb25uZWN0ZWQgY21faWQsIHNvIHRoaXMgZGVhZGxv
Y2sNCj4+PiBsb2NrZGVwIGlzIGNvbXBsYWluaW5nIGFib3V0IGNhbm5vdCBoYXBwZW4uDQo+PiBI
aSBKYXNvbiwgQmFydCBhbmQgU2FnaSwNCj4+DQo+PiBJIGFsc28gdGhpbmsgaXQgaXMgYWN0dWFs
bHkgYSBmYWxzZSBwb3NpdGl2ZS7CoCBUaGUgY21faWQgaGFuZGxpbmcgdGhlDQo+PiBjb25uZWN0
aW9uIGFuZCB0aGUgY21faWQgY2FsbGluZyByZG1hX2Rlc3Ryb3lfaWQoKSBjYW5ub3QgYmUgdGhl
IHNhbWUNCj4+IG9uZSwgcmlnaHQ/DQo+IA0KPiBJIGFtIHdvbmRlcmluZyBpZiBpdCBpcyB0aGUg
c2FtZSBhcyB0aGUgdGhyZWFkLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
cmRtYS9DQU1HZmZFbTIyc1Atb0tLMEQ5PXZPdzc3bmJTMDVpd0c3TUMzRFRWQjBDeXpWRmh0WGdA
bWFpbC5nbWFpbC5jb20vIA0KDQpIaSBHdW9xaW5nLA0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJh
Y2suDQoNCkkgdGhpbmsgdGhleSBhcmUgdGhlIHNhbWUgZGVhZGxvY2sgaXNzdWUgKGkuZS4gQUIg
dnMgQkNBKS4gIFRoZSBvbmx5IA0KZGlmZmVyZW5jZSBpcyB0aGF0IHR3byBjb21iaW5hdGlvbnMg
b2YgbG9ja3MgY2F1c2VkIHRoZSBzYW1lIGlzc3VlLg0KDQpJdCBzZWVtcyB0aGF0IG9uZSBpZF9w
cml2LT5oYW5kbGVyX211dGV4IGlzIGxvY2tlZCBvbiB0aGUgbmV3LWNyZWF0ZWQgDQpjbV9pZCBh
bmQgdGhlIG90aGVyIGlkX3ByaXYtPmhhbmRsZXJfbXV0ZXggaXMgbG9ja2VkIG9uIHRoZSBkaXNj
b25uZWN0ZWQgDQpjbV9pZC4NCg0KPiANCj4gDQo+Pj4gSSdtIG5vdCBzdXJlIGhvdyB0byBzZXR0
bGUgdGhpcy4NCj4+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIHRvIHJlbW92ZSB0aGUgZmFs
c2UgcG9zaXRpdmUgYnkgcmVmYWN0b3JpbmcNCj4+IHRoZSByZWxhdGVkIFJETUEvQ00gY29kZS4g
U29ycnksIEkgZGlkbid0IGtub3cgaG93IHRvIGRvIGl0IGZvciBub3cuDQo+IA0KPiBUaGUgc2lt
cGxlc3Qgd2F5IGlzIHRvIGNhbGwgbG9ja2RlcF9vZmYgaW4gY2FzZSBpdCBpcyBmYWxzZSBhbGFy
bSB0byANCj4gYXZvaWQgdGhlDQo+IGRlYnVnZ2luZyBlZmZvcnQsIGJ1dCBub3QgZXZlcnlvbmUg
bGlrZXMgdGhlIGlkZWEuDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4wLXJjMi9DL2lkZW50L2xvY2tkZXBfb2ZmDQoNClRvIGJlIGhvbmVzdCwgSSBkb24ndCBsaWtl
IHRoZSBmaXggd2F5IGFzIHdlbGwuIEkgd29uZGVyIGlmIHdlIGNhbiBhdm9pZCANCnRoZSBmYWxz
ZSBwb3NpdGl2ZSBieSBjaGFuZ2luZyB0aGUgcmVsYXRlZCBSRE1BL0NNIGNvZGUuDQoNCkJlc3Qg
UmVnYXJkcywNClhpYW8gWWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+IEd1b3Fpbmc=


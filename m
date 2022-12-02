Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FBFC4321E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOMjbQiPtsZOWmJ5e76GUFLE0zgPK4YQft0ccfediZQ=; b=wpXmn4xE1585eGtpu41Fm1o3eP
	HkNrqAepzIdkdiJXaw/kPAK37JMYt9P3mkwhxunSbv6MCffZ91UjylStUETrEGTLpKtx+k7Ya12pl
	YJwQ+WmWOf7EyqNNdYb+mzs/kIOdljKqRz59aHjORTGNrJ0WV9oHxQ1AGIZlo9zS3dYRUfDwiHYAq
	oXGy6K2Jjo0XvLKbA7m0p7OW7KiDokioSvCbiQDFUnRxExZGy0FPaqJFOsN/lLTKpekyoBGYYMTF5
	tM7gYuhpdmHSBlaN8CniWyul7jmZAjM3PCDJzuud4lJPwB6PyrBZEWisT1ri+ju8N9gMMtgjtcAyn
	NH19xGEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p16lo-00GlFr-PK; Fri, 02 Dec 2022 14:12:04 +0000
Received: from mail-dm6nam11on2060b.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60b] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p16lh-00GlF6-PD
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 14:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6lwbFVAGFURXAdG3oK6YrlHyHTmNUwKxjQyp9XUJ6IripIr/LyudvTIOtjn6GvXk2cGMhE3BS8H755mPL0z6spJhi2xHSXbR09y5QGuPqHseor4Oyc1A5GptVxw97Xyc+Ri13nfNHbZEBJGwiWTk8F+Seu259gEnwKSi6DE6U0Kw0yKx1n7cHOXLRt5xl5mau+O/8mZygVCwBbZuflFRyeYwylxjg9fgGR7cDR2uFm6Vl8Vf3fL2dPAXYwofS1Tb66FZ7b76kTj823qjzIdIxlZ7kePV/Ll1EJTvcbWvGOezxzrzzJZcYeoxIYNovVGwqcJ9m+GE/KCWkj6J7BRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOMjbQiPtsZOWmJ5e76GUFLE0zgPK4YQft0ccfediZQ=;
 b=Ne5JM5lbH0wGsai6lxeUuwJA+eOS81R5EfzN3iUBqGxfB8kRatqPYHx1WBwrlGQdEb/7ZkSa3o9446p3NlLOkrjdTaDACLXTEV4Tz+2Kw8yEQfvkPODySfWIlsZoF/l+fiBZHvZN1FiHyeEnHu7/XGCAqwy8J44qAt2wiTC70pW6CrcGA5YS3d5mRnP2IwQZFxRi1Spj38RjDgnDDEhrxjjsyWCc51Wo/UQ7P96syaAhNhNnr3jaaDgGlk/0eaoL1CUGqhS/5O092askm1NKn74S/jQhN5UMsJyex8nxWku0Ft2xhn0V5ivAVBDytAwqOFOhHLWdHj8nXH3DJGYIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOMjbQiPtsZOWmJ5e76GUFLE0zgPK4YQft0ccfediZQ=;
 b=Os6owF83aWocOlmki93VfL2cunRxJHggAhxyDxS6+T+6JZ3WyTeirls35CkXRondSfICWMoSYVy3QBZFCWNMttdH0IrJB5KMtP3nrBRV9WZMFbRuM/5tdfjK62lzs5l5OtTtnImp9hn+D4nziSvjBYUp55QZLUqd7G/eT69GKGzNmO1Vpb7H+6vVtI+WiqX1S1R48LBsx55yEvjjJKNP9atF8yv7HiJWTR433inTCSnXrnkCp+283uI0N6/gv1AsC8tSmLc+x//H4Jq2r/K+rJ9r++T8QllhoeVaRG87LkBJREkq3a9Y5CSWv2cLqjequWFdGhTuZvDJsnCdZx6yOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 14:11:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 14:11:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dan Carpenter <error27@gmail.com>
CC: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] nvme-fc: improve memory usage in
 nvme_fc_rcv_ls_req()
Thread-Topic: [bug report] nvme-fc: improve memory usage in
 nvme_fc_rcv_ls_req()
Thread-Index: AQHZBjS6gI+hqvC8t0iuHe4VqACLc65ao6Ff
Date: Fri, 2 Dec 2022 14:11:50 +0000
Message-ID: <4E98047B-FA41-4A56-BF51-203D06CF5B87@nvidia.com>
References: <Y4nMNk+XvcAQDrmt@kili>
In-Reply-To: <Y4nMNk+XvcAQDrmt@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4284:EE_
x-ms-office365-filtering-correlation-id: 1f8cdf5a-2820-4694-65df-08dad46f282b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  9rv8DaLXPoGORlrPnIQB3rpjmK29lvW2VZtuElloc2eL4AjRHjfJg6uwST8j+kV97YCNIaSHLuwaftFY/8CsHDHUNZ101Vs5Vwgb2Nli3ao8SM8GYFThS21l1rlBM7h9iJtyCSY01P6adyQTIVrxatNYerzE879HlcqQnKdWHsrCYBcbT++8H8HMVTr40izhDhNzo+rq3+sQQJVcufGh7XJ2Pzs2KaQHZliz0m3gux13mv1DorpEaMbPRFGRdyMDts2YI2s5gVsLO6wzkVgZ4ck9ogCp7m+O+rKT7X2D3mNypz42DVcsDOcY5HW6PrR0x8cQvAAl6eJ80JEiDxV1L7kKvaCfuTpdD91dD0TuNZO0BCC01NZpyvGwbvCYBAHrZv3Pvxx+RQb1boLNPRNMYZWdyF5Kv+Up9WeY98CNJfwYi+1bgPlzc40kHdp6kevnbTkeID3BFWq8Q8QYGHeP64pXU5TbJ2nuvj+UaF7TVZuLiN3Tha4num0eN5z7bcfV+wYUbZzZSEe38mULn4PlknmZKdN8LYbqSG2HFImFuAmOEvuRjCtAgkcskkFAlbzsP7/g15opmv4P6eyMjbK/g6ZhA257qlTJGszWpa+RCv6VlLyr0JI0X0D+wHDRcfDzDwUlwlzDlpUgoC55E3Jmb4ojO8sHvZwUxbzFPc3iGw1x4G59JdW3g/9ph1nDzx7mL/3fjVvs5ktH/QoHHu1TXU8AFvuvKPhtPREpOwOfKUN3ZNcwm09DNniwFriHNHDB
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(86362001)(91956017)(36756003)(76116006)(186003)(33656002)(41300700001)(2616005)(5660300002)(66476007)(71200400001)(66446008)(8676002)(66556008)(54906003)(4326008)(64756008)(478600001)(6486002)(316002)(6506007)(66946007)(6512007)(53546011)(6916009)(38100700002)(122000001)(38070700005)(8936002)(2906002)(83380400001)(25903002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?S3QrSGQzSENHTkJDZWYxczhpR1AwSXZiZFBKblNXZS9ZMWNPa3l0anlqSEtE?=
 =?utf-8?B?dEVHeU9jVDVLTzV6ZFZYT2xOL3pSVkp4cUYxeXNXZENOcGdQMlRlNWtiSmdO?=
 =?utf-8?B?VkY3UU5BT3dtZkZ3Zmt2MUoxNjgvanVDRFFPT3BQdGZPdkl2L3NzdjdtNWZL?=
 =?utf-8?B?WHhYbEs3NldESUVVT20zdG9wSVRSNXgzSERveW9PRVU1VEtzazVCOXhFQlBq?=
 =?utf-8?B?ODcxRisxOTNtS2syUjFJampLeWxuRlkzY0tyUzJkOHE3NWNRZGp2aktIaytX?=
 =?utf-8?B?a0d5Nm16SElNVjJUNGlBcXduTDRIbHVFNGFVeEg5R0x6NnFsUi9JYXJCczI2?=
 =?utf-8?B?Y2NWclQ0d2JOMXNReTFKMnVKcUphRTBCdmVDUHRSY1VBTTVWSDFOejZvZUlP?=
 =?utf-8?B?eTVIT1NNRENFcXpzcnRZUjN0cFk5dnZBL0xlYjJyUmw1SE5BZVdDdGd1UzRi?=
 =?utf-8?B?bmZ5eS9BRHVsaUgyY25qNXVJZnlzS3J2UXV3T01RWjhPbDJMcFVRNW5jcDNJ?=
 =?utf-8?B?Q0RvTkxGT2RsV3lmU0FsdEZMRGhJSUhIUzNBUHhuTXM3VUxGR044aE1IUm5u?=
 =?utf-8?B?ZEluVG5YK2h3b0FsOFlLTEowUmJRQmVpLzIwZFNkT245V1YyMktZMUwyYm1q?=
 =?utf-8?B?MUNWRVY1aGV0R1QwTUhMaTFWQSsrbHlmWldEWVAwQnc5b1UvdnJYMzFqYk1z?=
 =?utf-8?B?ZWZUMlpFY01BbGVZaXZFOGhqRDQ2akpGa2VhSENqQnRjS3dvV0RqdnFZN2Rw?=
 =?utf-8?B?a0dNclJ4MTIzVTNwZjlvZ2NLNmIvYmx5WDZZcitsQ0M5WUVwb2xRMHBnL3A4?=
 =?utf-8?B?TCtCVFhMZlBDQVFzT3lrc0ZkL0pLUmRKZnM5VzY2OUFSM1ptL0FGOU9tSHF0?=
 =?utf-8?B?aC81ajFWS2E0Wm56U1RLQUxYaDhueGdTU1RvYjEyaWZMaDd6S1AvbllMaDds?=
 =?utf-8?B?dEJVeElVUDg0Zk9GM3piczJweFlBdm5UTHV4WDlkbmNFZnpoa2l2ZVRuZmJh?=
 =?utf-8?B?M3g2R3BqZmM0L05rZ1VnaUdZZ0NFazB1TlYxd0VoSTRsZmR6Mi9kSWkxazJH?=
 =?utf-8?B?OHhJV3JGZUdtRmtFTmdhYzJuL0JMWDdnYUJiS0tzREdVZ2FwVmU4L2U5ZEdT?=
 =?utf-8?B?SlVVdG9aKzNpV2RSSlhtNFkxdjRNMVNkU1g4NUtTTk54TXI3QVo2TFdDbFZT?=
 =?utf-8?B?WUluek92SE95ZEhFbTV6RWkyc1YzOWxBUFU0dGFJbGlKNVBlNllaeHVzU1Zj?=
 =?utf-8?B?V2dzWGNqVU9iTUlIZHJGcjh2WUVacWNURWtuaW1BTkJVQUtuWEpESnNUSVcv?=
 =?utf-8?B?ZW1ZajI1TnJXcnNjLzhuRzZka1RaNEc0QVdFelhFd2UzZDJLZnhjWWlGMkFU?=
 =?utf-8?B?K2tucmdOUlZBZ2c5dld3OGt6VXRLZHh5R1U4MWJQZFB2TC82eXJleXAzVnRT?=
 =?utf-8?B?YzBwdUVVRlE5S0ZuNHZsYk9uT2NibmNkeHROcmk2K1FWQ05SaGdnYTdDZUI5?=
 =?utf-8?B?a2x4YXBRR0tHQzJBMXpldVZSRlBpUTdQL3Q3WlRzM1RPWUY5WUdQekJHNHhx?=
 =?utf-8?B?NHhqaG5DSk1VSjBVcjZXdDAzeG9FclU2RSt4UTBUbkozeVRLbWQ5bnFodkNK?=
 =?utf-8?B?N05EUEdSRWl3Uk9vdlFXM1BuMnJJaUlhUzVQTTdhTWlyZC81OEphTkduanFs?=
 =?utf-8?B?QkRGSVdjTVVWdDJyOGI0UzQ3a21KZDFYVDNTbzhHaWdHS0c4ckxhazdscjBS?=
 =?utf-8?B?a0h4S3dvdktGUnhyZUJVaDBtbThGRUQ2anZzTy9yUytaa3FweldDVUJneWkv?=
 =?utf-8?B?RXQ3SXdjNUdjdlhXeEZPRklTOW9uK1h1QUtTYjFuZmo1UWdWUERyQTJoTEF0?=
 =?utf-8?B?aU1aNkpxQjJxUjU1T1NETE1WYUJKM1JCMUpscDdkNWt4MGhlempKTktyLzhC?=
 =?utf-8?B?L2huVVJ0OWthT0ljUmdCSXZqRUJjcVRDV1ROMDBoQk1jQWxGWkU3WGQraDkr?=
 =?utf-8?B?cFltQ3hjS1lWR0xIQ3dMYzE3U3NKb2U5TVlBN3l3VklvNHpkVC9mMmZHN09V?=
 =?utf-8?B?VGJxVGF6ZkVRdlBCN2FEVE9Ydk00aWJqOUYwTFE0Rk0zanBFOENaZ293OE5L?=
 =?utf-8?B?MjQ5QzZsQnpOVDNjRG93S3BMaE5lUE1QR09BRWtkZDNERXhzK01tN3g4SHg0?=
 =?utf-8?B?NnYwT2E2azh3T0dZbzVoYVZ0T1FKVTM3RVBJRmFOYWY2Z3JJNnFYRDVKNG9C?=
 =?utf-8?B?emkxWVB6MWFha0RGb0xkR3FmR1ZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8cdf5a-2820-4694-65df-08dad46f282b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 14:11:50.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/oMF390AXdpIqfmr1AVApUN6XexoStmsdlMivzc3b6CxuUSiusE7gza8pzl0QmxVirMfWmf+1HRjuR07DWXLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_061158_019870_782FB93E 
X-CRM114-Status: UNSURE (   9.98  )
X-CRM114-Notice: Please train this message.
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

DQo+IE9uIERlYyAyLCAyMDIyLCBhdCAxOjU5IEFNLCBEYW4gQ2FycGVudGVyIDxlcnJvcjI3QGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IZWxsbyBDaHJpc3RvcGhlIEpBSUxMRVQsDQo+IA0K
PiBUaGUgcGF0Y2ggY2YzZDAwODQwMTcwOiAibnZtZS1mYzogaW1wcm92ZSBtZW1vcnkgdXNhZ2Ug
aW4NCj4gbnZtZV9mY19yY3ZfbHNfcmVxKCkiIGZyb20gT2N0IDIsIDIwMjIsIGxlYWRzIHRvIHRo
ZSBmb2xsb3dpbmcgU21hdGNoDQo+IHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQo+IA0KPiBkcml2
ZXJzL252bWUvaG9zdC9mYy5jOjE3NTcgbnZtZV9mY19yY3ZfbHNfcmVxKCkgZXJyb3I6IHBvdGVu
dGlhbCBudWxsIGRlcmVmZXJlbmNlICdsc29wJy4gIChremFsbG9jIHJldHVybnMgbnVsbCkNCj4g
ZHJpdmVycy9udm1lL2hvc3QvZmMuYzoxNzU5IG52bWVfZmNfcmN2X2xzX3JlcSgpIHdhcm46IHZh
cmlhYmxlIGRlcmVmZXJlbmNlZCBiZWZvcmUgY2hlY2sgJ2xzb3AnIChzZWUgbGluZSAxNzU3KQ0K
PiANCj4gZHJpdmVycy9udm1lL2hvc3QvZmMuYw0KPiAgICAxNzQ3ICAgICAgICAgaWYgKGxzcmVx
YnVmX2xlbiA+IHNpemVvZih1bmlvbiBudm1lZmNfbHNfcmVxdWVzdHMpKSB7DQo+ICAgIDE3NDgg
ICAgICAgICAgICAgICAgIGRldl9pbmZvKGxwb3J0LT5kZXYsDQo+ICAgIDE3NDkgICAgICAgICAg
ICAgICAgICAgICAgICAgIlJDViAlcyBMUyBmYWlsZWQ6IHBheWxvYWQgdG9vIGxhcmdlXG4iLA0K
PiAgICAxNzUwICAgICAgICAgICAgICAgICAgICAgICAgICh3MC0+bHNfY21kIDw9IE5WTUVfRkNf
TEFTVF9MU19DTURfVkFMVUUpID8NCj4gICAgMTc1MSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG52bWVmY19sc19uYW1lc1t3MC0+bHNfY21kXSA6ICIiKTsNCj4gICAgMTc1MiAgICAg
ICAgICAgICAgICAgcmV0ID0gLUUyQklHOw0KPiAgICAxNzUzICAgICAgICAgICAgICAgICBnb3Rv
IG91dF9wdXQ7DQo+ICAgIDE3NTQgICAgICAgICB9DQo+ICAgIDE3NTUgDQo+ICAgIDE3NTYgICAg
ICAgICBsc29wID0ga3phbGxvYyhzaXplb2YoKmxzb3ApLCBHRlBfS0VSTkVMKTsNCj4gLS0+IDE3
NTcgICAgICAgICBsc29wLT5ycXN0YnVmID0ga3phbGxvYyhzaXplb2YoKmxzb3AtPnJxc3RidWYp
LCBHRlBfS0VSTkVMKTsNCj4gICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl4NCj4gDQo+ICAg
IDE3NTggICAgICAgICBsc29wLT5yc3BidWYgPSBremFsbG9jKHNpemVvZigqbHNvcC0+cnNwYnVm
KSwgR0ZQX0tFUk5FTCk7DQo+ICAgIDE3NTkgICAgICAgICBpZiAoIWxzb3AgfHwgIWxzb3AtPnJx
c3RidWYgfHwgIWxzb3AtPnJzcGJ1Zikgew0KPiAgICAgICAgICAgICAgICAgICAgICBeXl5eDQo+
IA0KPiAgICAxNzYwICAgICAgICAgICAgICAgICBkZXZfaW5mbyhscG9ydC0+ZGV2LA0KPiAgICAx
NzYxICAgICAgICAgICAgICAgICAgICAgICAgICJSQ1YgJXMgTFMgZmFpbGVkOiBObyBtZW1vcnlc
biIsDQo+ICAgIDE3NjIgICAgICAgICAgICAgICAgICAgICAgICAgKHcwLT5sc19jbWQgPD0gTlZN
RV9GQ19MQVNUX0xTX0NNRF9WQUxVRSkgPw0KPiAgICAxNzYzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbnZtZWZjX2xzX25hbWVzW3cwLT5sc19jbWRdIDogIiIpOw0KPiAgICAxNzY0
ICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiAgICAxNzY1ICAgICAgICAgICAgICAg
ICBnb3RvIG91dF9mcmVlOw0KPiAgICAxNzY2ICAgICAgICAgfQ0KPiAgICAxNzY3IA0KPiANCj4g
cmVnYXJkcywNCj4gZGFuIGNhcnBlbnRlcg0KPiANCg0KSSBhbHJlYWR5IHNlbnQgb3V0IGEgZml4
IG9uIE5WTWUgbWFpbGluZyBsaXN0IC4uLg0KDQotY2sNCg0KDQo=


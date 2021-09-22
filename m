Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A126C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 02:33:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D628D61178
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 02:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D628D61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CEZDpeiTYp2OiKp4Kig27H2drDvblGODd7CFEcQuNsQ=; b=sTQCCGbqCfMZLi
	VoX5zrym79ww70fEX9hQ5MklTCBGrpukPMjFT9eEvjhI4HBlNV6FHMl4yT7re0abYNHuPWhVkTlIn
	UM642ByS/9zkDP4oopd+e+blUZrQwBJNxyWAT8HwFYsLKD/qm8f3Fkq+Ye8tQ56P4d6K8ejQP90D7
	bdEs++K0XjzjQfGpI2qQiqRwLnirXdVGT1XfXpISmT/PNKNgnLtWEIc4wRy9wwdyRCJZabVFdYvBl
	OdZFKT0+jwAfeO+2rTi23pGuzI8QmZ9iA8ePDNZ64AlIn9T1v6WIIkcCnf+k2uNi4jSGuu5RO6sbv
	5NqfvMa/YAnTQZUju8QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSs4l-006cgD-OY; Wed, 22 Sep 2021 02:33:35 +0000
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSs4j-006cef-LZ
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 02:33:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw2LptaKyudcbqtg3nBuI6VQhQa+MbF6lvYGZ+WvbLAN09eHbwb29WDoE3/W1ikctaqelViL3ubSvF2rQ0HbQiFklot3NMZognI0PPlPJL2ALneBu3wMi1AiCdZY5de6HLzQCc5+Oukot4Uzzont7rhI4M5Remj+yDdGq/Znu/8XPjb7HfoKNR9UhQQyoj+UGW9sqvtZTkpQya8R1X8Vj6t/M5RnkahazaoCap9MUGVa26IcTDepLStbia4RB/j1y/RutjFlsQP4ZmkztVlw2QLaEkCXC5DbPOD1+HfJUJnL62O2DBEUEBcJUcyOQuejkfXXmy8eoCMw8GQzb1NC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Nj5CEyraYMgJ9/xXI8WQ3osf4FMRXDsS1UhTHOOHTBM=;
 b=NabHvEASVhQ5ZcS+xApLb1g2KO88KqkGvOq3IBOYcTokNPwyNMrRxdSozIhUeqkGuivRgcfYe8j3y+4p1MOTkRuZ5WCiKtq8bCdut2QDBx16ozwcUgfHxDG6TULFMRfmdLjdeqVRhnRJmhREAGNY2HQq9HGXEaSAM9OSeMRwmKBI3/rFvQINK8z8ff6p/1uRbKkJfa2D38vQ8BivgmWKG5aAWWoxtNamYuJCmyQotWPvYRNUGuk/gPxhH3HpY2ahr0kki/rJaQtrWz3L6xx5VVefVifJ4xeIVDm7DooGA7/BzOC4//cZNdCnGLh3ttF0ZKKTfgUY8eANC/sdvBRmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj5CEyraYMgJ9/xXI8WQ3osf4FMRXDsS1UhTHOOHTBM=;
 b=uBiqcy56Z2t2m1/OeCZhySsKjQ/dMRncQGYlz0Hb3/WTCa2ZbkhfYWB+n1FD1oTOccx+j0YbVyF3Tkc3jDSqx1rRyY5mserKzc9ohH41Sb0njPCiDdfmU9AfU2s4spG9UCGGV/U7nHUE9K6dMkQVL9/yqhQcp+eXx+OEAam6mkemzHKUrpdNQemRS23Ll7IThllEwJKVyo5DQJ/cx1AeYcA4vXg1TlUtowlXLEfDUfV0Juc70vUK1jav8N2Pc/Y1SE7GN6P3qW1lDaM+9n0JVZ+3VIez/lldzpZY4h5at67a/n0bq8oFjQFZrYaHL6MVZXIq4unw/GWuPjAYWzQ3pA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 02:33:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 02:33:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Thread-Topic: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Thread-Index: AQHXr1Vq6mywUOLpZEOhSJpv0bwHBauvVboA
Date: Wed, 22 Sep 2021 02:33:17 +0000
Message-ID: <157fac57-cbae-442f-86cc-dd06ee64e981@nvidia.com>
References: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
In-Reply-To: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50718a65-75d2-4dde-df7a-08d97d7155dc
x-ms-traffictypediagnostic: MWHPR1201MB0224:
x-microsoft-antispam-prvs: <MWHPR1201MB022484717D767BF744E3FE1EA3A29@MWHPR1201MB0224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0ega2o1gKsob4C9reEk63MQTMmM60auEtiDo8ROCFjSc+8et/DZKfCYYCfjSlQEH/BjV/th/lChsTHfSKPxQrepGH8OW9ui2kbJ1p4mGoyzdfLaRcrVEKdm/QltPZJ1sIAbUKK32R2t7y6qyhmJzJtmCdNXbejeNjICjrfAdgrCUPFJZdtVUNtrBAvkRRDO78ug7nfXY8AszW4YqPe05uEbxcAMaj8ACx51/O68RbIv/Lic81Mhrc0hOZKydXs7nnJsBDlYgBac/t86u18oQ+8wBKn7s3Tsq8GnVTvAI047ng3f54s0q9RSxBPxRhDM5GocYeBStrRgG0ADuhgOpvkYEyXLwpdcCAqbg075f3iSqRQybXgCwotWZdiMJKU6+kF6TfqWrQ+UnPR+UtSi5ZaVTLjIOOkhY7yK16qZjk7r8PC7iTz+Zy1E8nQ+8UJ49t+NkmFSPQTBCtvCRMchMpMDE6G7WyoSoWYY/vGVPOQ+0P9fftE4Ve8N3hkAvmH5uj0tc2niMoc6RaFlUvQ155PBaiIQAsEf848WYt4VgAOQgyRj92NrKAPGpUsXvDkwOKRAF2+3B1kvRxbknOLH/nz6UebWOOlGsGptyH5mU2mtphSG/X/W2mgJg0bdEMRFobuiAyP9GJOcK8GOzTbhOG+DBwJzGAB4RbidmnSSjUj4OiYY2osUmCsJkTIlB9/62GrhEyif0xPLpInG5V8p7l5U1C1MLzVtR7uvdsK1OF1tLaTaQupREW1ANxeDPq8/KazRk1VNWVJUtIBbLrcs6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(86362001)(186003)(110136005)(66556008)(26005)(8676002)(66946007)(38070700005)(6512007)(64756008)(66476007)(66446008)(2616005)(76116006)(6486002)(316002)(2906002)(71200400001)(4744005)(53546011)(6506007)(8936002)(31696002)(31686004)(508600001)(5660300002)(91956017)(38100700002)(122000001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUtwdWhaUi8yZEFCcElCc1N0cHdaT2xETFlIQmNJdWZXUGtiYmxDaGQ5SnJG?=
 =?utf-8?B?TXJvRWpqNm5pSUJtWHFDditmKzdNbFRxVjNua0pkZ21pZkdwTnYwazB3ZjN2?=
 =?utf-8?B?SmtSWDBOb0xlVGEyUUFTVnZqcDdISlRBL0IyUSs2WXo0TWYrQ3kvVWJMbmxS?=
 =?utf-8?B?U0NubVFQR0ttaCtmYlliU0dESklIYW8zRDNmL1BTOGVmUWMyNmpDaThxWDZI?=
 =?utf-8?B?SGxWNTMxUWN5K2hsemkxakJ2QzcyWCt2YUJzcmQxRnZ1T3FnREJOV1lSTW5i?=
 =?utf-8?B?bTlneldoQnV5VHE1VHpuZWtPbHZTSUZIRGYvT1Jlc3RtOTdsNFhiS3FHTnpm?=
 =?utf-8?B?M1BPMXFUclVkZmtzU3VLZjdZL24xQ2ZvVmdrRWVIMHFUd3pWQzF6emptenVk?=
 =?utf-8?B?RVZzMVcwdDhkQ1VQc3FjSlNqZHI5L3I2OFdRS1ZZZm5SM0pZaUh4Ry95aktC?=
 =?utf-8?B?bEc1Rno5TE9GMy8xT0MxaWtUVzBSQ3NSTW9yYUtEdFVzYVRMRDI0aFVtbnRN?=
 =?utf-8?B?M01pa2FXUXhaT0szY0locWdxMnNWS2tubXF0MVZ4SXlNM1NwRjhhSkFJMDJW?=
 =?utf-8?B?TERTb3dkNkMydTB0T2lOL25XeWtyeW1ITDdydE9sdUFrK2tXOFgxU3FRYktH?=
 =?utf-8?B?akdOZzJ2dk81cUQwQko1L1gzcGRUTkVpQlp4dm9leFFNUFhmRStxNS95V1FI?=
 =?utf-8?B?dTFpQUY0QndUZTVnM3Y4dklDWlJvZXhhVE1ldkRkRDZmV1ZIRk5zYTVRMGl1?=
 =?utf-8?B?UnBmQ2N6dnJ4dlUycTBTdTZ4SUJmSXYydm5tam9pZzlOcW5WYXhUbTZraC9S?=
 =?utf-8?B?ZzI4dXpBdTFvSm93dGNWT3owemRSTGgrYjk3QjJKZ1FsRXdScmtOUnd3WGds?=
 =?utf-8?B?RjFETnl6ZVNlaEN1Z3JMeVRnK1NPcTlrNTNQckYxajlkeWY0d0FhNTZsdWl4?=
 =?utf-8?B?NWg5NWc0dituUTdzK05lKzh5enBQOEVGeSt1OTZkZFRsWjVkaCt4U2R4MDFm?=
 =?utf-8?B?RE1kM25wVlJ3MjNTVUc5NFZCTWNCT1hZS2xYSFJWM1FsMHpqYmhiUUhIVjJy?=
 =?utf-8?B?eXQ1UWNnUTVBTkYxQUM1S1hya2tzUkpZNk14UjVuVGlMU0c5VXRZSDN0Mkcv?=
 =?utf-8?B?U1Q1aUlHL0tkZUtVMHZZaUhFUjJHSEU5UmVaTTlodnF2OVZKNUFBTmZwWFNZ?=
 =?utf-8?B?emlCMzQvVTVvWDdSUWNxYVovbEdSa1dQUUNVZ3ZvZDZWdGFWZ0NqRk1zMW9R?=
 =?utf-8?B?c0JlS0JyVlQ1eTFPc2paTkZtUjVBeVNrY3pUbFVjSkt1SUxoNjRlNmlUNzlR?=
 =?utf-8?B?VjFaUHhFL1dKWFprNnRGUGlsRTZsQ0RtYjV1UnRxNEpCTzhQSHM3WWQzUXBY?=
 =?utf-8?B?TmhwODlQRTd0M3hMWFQyQWtpNGp6VW9xSThTWVh5VG1mVnhRUG9XQXpJNFVI?=
 =?utf-8?B?RHNwZ0xaNHdxOVpIanEyMDAyOUs0cmg2Uml2YUZiZHdLa0NCMmEyak1ZT1Nt?=
 =?utf-8?B?SE9scnprKzFWU1BpdnNNY01uWkY0RUt0dXI0VjNWZEZYc1JIL0FYbFpXU3ZG?=
 =?utf-8?B?amF6UjgwK1Y2akpSbktpcXhMN0x0cmpJR0pOTmZYWjJvVkp6NkZvWWl6ZVJC?=
 =?utf-8?B?N3BHYjdZbHBHZk84ZTNBWERDL2tUcjh3M0w4OEJZRjQ2TVRtYVRTbUVtSkFC?=
 =?utf-8?B?ZFMrNy9RUm15emlDNG94dWlGZm9JYWxtS1hKMjh5a1JlWGRpR0VYdjlaZDh3?=
 =?utf-8?Q?a8c448RfWwUB9dfCKD4Fz9g/KKNqZXFBu3zZt+T?=
x-ms-exchange-transport-forked: True
Content-ID: <03EBC0221D5E5C48865C212DE0EF2995@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50718a65-75d2-4dde-df7a-08d97d7155dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 02:33:17.3501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdO1SdTflty3mRIZp36rqjy1azzKNO3y04sX1mcpxKBvrGssKLf+N+gRSLEaAQKpzc0kA35QgC2yWGb+11uZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_193333_750318_798375D6 
X-CRM114-Status: GOOD (  11.51  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8yMS8yMSA2OjU2IFBNLCBZaSBaaGFuZyB3cm90ZToNCj4gSGVsbG8NCj4gDQo+IEkgZm91
bmQgdGhpcyBpc3N1ZSBkdXJpbmcgdGhlIG52bWUgcmVtb3ZhbCB0ZXN0LCBJIGRpZCBzb21lIGRl
YnVnIGNvZGUNCj4gZm91bmQgaXQgd2FzIGZhaWxlZCBkdXJpbmcgbnZtZSAiQ1NUUyDigJMgQ29u
dHJvbGxlciBTdGF0dXMiIHJlYWQsIGNvdWxkDQo+IGFueW9uZSBoZWxwIGNoZWNrIGlmIHRoaXMg
aXMgb25lIEhXIG9yIFNXIGlzc3VlPw0KPiANCj4gDQoNCmFsc28gaWYgeW91IGNhbiBzcGVjaWZ5
IHRoZSBnaXQgcmVwbywgYnJhbmNoIGFuZCBnaXQgaGVhZCBpdCB3aWxsIGJlDQpncmVhdC4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

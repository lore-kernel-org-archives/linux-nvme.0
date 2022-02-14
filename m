Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02CDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B0yW/KPLuOCo3f3aPC7arsAynJNhRXrRVEx2zT+9C3M=; b=pDRmspm0QNKySXcAyvaIbqgGtM
	Wv23Y3fZvyYU830Pptu4SeEXfTVWp/QbaaedN/QeOtDNTjoJw4c0ix5C6kTGscK9f9EJujxSdJJAa
	86Gsa87m75WXfe18BcYDjwZ+86aQ2ExDnt2nmXZzAO1lu5QoBbC5LkVkVwPWf/P3qAdNP97fyPc4M
	LFXX39Sp9OAcYQaw8Kovwn18FLcL9YR83XrP4TGTvnzW2PUJUZKhJZASc4ijgfRoIr1/a7WiqJ5r/
	8Wszxt1Ng+6xfO8LV3gvXjF5/SDBBPmEdXDVgwVjGtGFi5z4sk6sNXq+W6EbvsUh8HURl+pyOcFIj
	cTrHMXKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZuO-00ExFV-7U; Mon, 14 Feb 2022 11:52:44 +0000
Received: from mail-bn8nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::629]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYy7-00Ecm2-8e
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osehj9cE1MdH+b+RDdsMAaGMuDLO8vEx/mCnROO3X3mdR6WLDlAABizJspihaK02khANe+mjrqFPh6h2Gxd0QEn9caF4Kq+ELMjoPZsD56Szs/fgmbQkEFmo8gLxg4pH/xUUn7cCoT6s4f7YZ6Mv1vyPuFtOOco8TzgR3TcQxy+DPwEc+8FDYP7XvOprG7OEFmkTdZD3FeoAyQDYqdDy+BvTUNOsYGlcgK0+VMKwNOyvleuw4CHm3KOU4oT2aUpFSk6NNFUXmjNHZ+Bgmfn2J2CutxaFoda6iXSdKD6wiCNpAFgol95X55w0p5y2S0uSqI4xt+M1pgaSuztsisJiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0yW/KPLuOCo3f3aPC7arsAynJNhRXrRVEx2zT+9C3M=;
 b=JuaG9l4ZkXZ0ArMnJe4lwYYuHJopA+f0HV8BMHMqGpyKuWnQMwKwBx6gFl1VrGH8E7a+n+p7IgKtk8C4BFeYjCCJczq5+o1NGZa8aD5qzMj2+7+PXK5Yh45bW/qLMmChfRIrVgtH8pBDCdmMAh94MTTdYJZ16k9kuQVleMW0CzwoQxg/5zBVGa3kVxESF5iVAyIVoKDNWN0ZykJ0150RGwNq8WDzIih+oo4U22iXgwr80utPDq4/zVnBG5i7vQvRrc27Kvfuc0fPbN4g8iRPOEUei8Eg6xFgru0Izf90vTMFEVZzYh4uhMAq5IldTPtvwzXrkmaEfnukk93Z0Wu9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0yW/KPLuOCo3f3aPC7arsAynJNhRXrRVEx2zT+9C3M=;
 b=bq3iRj6d78qh4J8QgTF2PbN1Hw4AfoBxN8oYm7wY6xWxDwLx78keb5/iprtDS0KKc7tOyCQOyDD0hQYuTRsHRSAMhKmLYoyu651A/iSCSZ8dp10XHqtKka2PP6bhvzxJkQinSjetuOgsPcBlkhFSO+8v3DNJlpGUS+YhLWZPytMq3gckZMUUeSht573ROaLe1GNHfyvKdjNWGVYHS7cd9hG0t4hoZL8RXAKVw1WdrY49fJfcrU2fAXJ/ogh0/sZ4qNyfxODPx31VdUt/4IYqj8+hPM40BtaFxQy1/iU6ItF5s3ozTrnKUlL6hrwQAarPJuGrGZuDoXNoSzxv6pfSiA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3760.namprd12.prod.outlook.com (2603:10b6:208:158::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:52:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 10:52:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/7] nvme-tcp: fix bogus request completion when failing
 to send AER
Thread-Topic: [PATCH 1/7] nvme-tcp: fix bogus request completion when failing
 to send AER
Thread-Index: AQHYIYSGDXgAp3UdokWO+qfrkqB3LKyS3t4A
Date: Mon, 14 Feb 2022 10:52:27 +0000
Message-ID: <6d0d9d72-40d0-46e0-87af-524f49e966a3@nvidia.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <20220214090732.479193-2-sagi@grimberg.me>
In-Reply-To: <20220214090732.479193-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 806406ab-561c-4530-a248-08d9efa81749
x-ms-traffictypediagnostic: MN2PR12MB3760:EE_
x-microsoft-antispam-prvs: <MN2PR12MB37604910DC0DF2DB2FA57966A3339@MN2PR12MB3760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eRUX10rsFi758sVAqe3y4QdX+4cVvz90qKyo825HQXga4xCmtB2H2Q4/As7yEZbefZQumXX32W1INFxuEQfRhywgiJeDo/xDyqfy8nVPFNlS6PM2JpILUdcH3g2eTusKxO46Mwa/nlMYDDzRMpE40DaDZ0vf0n0Z+qP9NWOvwuitZ8qWJIWVnL2OhsdWhnVdOKDeo0+mr9yYCZ0jeTBXJxHDrvi58gErcWHiM9KMTL7S98vhIcbBeXFL30w5Wc3Axr+K0oL+8muHWVaHwA3oxqRhFyJZKTd5iibdeu9Y7AJAv/JbY51hXQPpXAhUJf+WsH2DDPKyl4nzGIwaALbklmE/8J9HWPLKtL1KKEroeQNmIdl+cgPx2eQVDKqZPj+awakPF3eg9rlhuWUqaxP6y98qXp7bDlqkiIMVhy48nbUQ3XYbFPphaO+72WQoEaXnqtEKnssFTfVc9d9kCvtSoWtMKUlwg7bPqWGZvkEK/uRXT4Mr+BlJ0hW2ilgdKUUQ4ibNVljEf2PqtUt+SI0l/dHOpljRbQVlozW1Tz+RFPzPbSJFxIrl1PvNgJ0kZJxX2F5A9I/c+UVM1TYPS80P/RC+0RpogfNP0IASMLHYkfvQJZ/4mmOs+ryhknyDRh4bzAAKzovsE3wP4XJssELmMsseoiv5N3m8DKbWXxnmdMZPeW3rfLT2WSkLiFpxmpRqQ63bVQJ+dUekmgzmJFiWn+l4NoLiAbP18kfuw2bRhDABJQeMpP4k7J7nWtomXuYAaLVv+JCmT44ZcQrtHbFG22ywnRY2d0qgnm/kDt8MjAX1WCFftj90dvCAVlWyNd4cEZcr1x843sz1Rmo7DZ80yOPD+8MHY5h5fTmDsQKVX78=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(122000001)(64756008)(71200400001)(6506007)(36756003)(53546011)(2906002)(38100700002)(38070700005)(31686004)(8936002)(54906003)(6916009)(66476007)(4326008)(5660300002)(66446008)(66556008)(66946007)(91956017)(76116006)(31696002)(6486002)(508600001)(966005)(8676002)(186003)(83380400001)(2616005)(86362001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnNEcVhId3lqZE92RWdUUXNDRlBJNGdrSHEwWXBBaExsRE1GeWU4ZkY5RjNH?=
 =?utf-8?B?TVNOWWZkZm03dDJDMFI4RnhQT05QcEt1VEhZaXpRMEJSTk0reGJRSXVHRUQ0?=
 =?utf-8?B?aTFFTkdUNElrTWpuSWs1dkRoVkwrZC9BYzhzcjZiSzJ2M2hCM0pXeG1lOHNR?=
 =?utf-8?B?Y2IrWUpxd1lOa3pNd2U5NDZZZHkwTzhyWjNrRVpuVk9kdUs5YkxOcTNacnFo?=
 =?utf-8?B?Zy83MDE2Z2FrR3lKenNjaWJJZVBSOXlKT2dIZVpZbjFvT0QwMHhZNVdrKzZi?=
 =?utf-8?B?K3VFZlFVaHcxOUl4M2t6VDNFSE9WZG5IUmQ3TlFmQzhnN0tidzhvdHRON3ZP?=
 =?utf-8?B?dHBLMXkzUFNXL2Roa1BRZENFREtZbjNKTzMzREpUbEFUUzZSeGhSZUdQM1k1?=
 =?utf-8?B?SXBGc0VaY1NlWTRjWno5c2xOUUFjU3JrdW4zVHd6Rlk5VVo1ZTkvZDdrQTl1?=
 =?utf-8?B?VDVvNnl6QnBKTnJOTmw3YzBkZ25LeDU4WGpHTlhYd1RWVjFISWxYQW5mNXYv?=
 =?utf-8?B?UkV0bWVwS09TZityUjlOSVpvMVprYVRCN1BwSGM1bkczUlVkYTAvR25LcWZ2?=
 =?utf-8?B?SDNqdmQzNFVwL0R4RWs0SUdvS2FpT3BpUXNDY1dTQWRCTlZhaGE1V1FzZXY3?=
 =?utf-8?B?VytLODJUaGxNMVliOGw5V2twTGd0S0IveDJIbEJYREJHNEJwY3h2OVp3cnR0?=
 =?utf-8?B?VmlrdG5jOFJpbXhkZGRBRmNRbUpxN2MxNkhzclNqQVVsZHNZVk9ZVWl4SFVF?=
 =?utf-8?B?Q0JycmpjdkFEZWNlZ09RUUpGNEsvMGpZb2ZoMDk3aWpGejZCM2JLc3ovOFN1?=
 =?utf-8?B?UUMwejlxVUJzQ1lkM0UzRHZGTU5jU2lHWForUCt1SXI2QWJSL1BHM0l2ek51?=
 =?utf-8?B?VG52WUgxMThqZjhFZ1hGcks5dG9RS1Fsb3NzODJ6QnFkUTk0RHpWbU96Y3kz?=
 =?utf-8?B?OUNTVzBTLzF2MkMzaVY1R1BueXNhTWs3c2UyQllxR0VtcG04aDdvRWVWZGlu?=
 =?utf-8?B?bFlvQmdhWVZZZEdxRWQ4TDRMZERPWC9rVTR0U0RsSDR6cGlGa1U4WHpDK2Ur?=
 =?utf-8?B?WU5heWZQdDErNmowZ2F6QzBVby9uTUFUU1pvVERjTTZ4eUMvdFA1Vi9tdFBH?=
 =?utf-8?B?UlgycnRvUTIzWHRFZHhBbGVmZ3VCMmRKanBGdDY0RThLaFVOZy8zazYrSUFH?=
 =?utf-8?B?b0VISW1Dd0Yvc0dlN1V6SWlyZzAvYUthVjRnNElzbUwwcjV1K2kwYWFUMUVl?=
 =?utf-8?B?VzN6RlQ4NEJpeHVjUEJDWWNOTUIxMkFORjdKb1NyWXJyUlUrZEdqTXRpV0Q5?=
 =?utf-8?B?Q2N2aEd2ZVJvd3p6cjgwUEI4N1FGNWVWSlhKUG5tbElZV0FKVU8zMmVjNWFy?=
 =?utf-8?B?VmVyc0U5dktOb1JXL2ZnclpTcmp1WXZEcVk5WmFQajhjNlhqRU9SRzFSL0lj?=
 =?utf-8?B?TTd6ZzJHd1JFUmZBQ2RtTmNZOHZ2eVhMc2FOejJmK050aFV6RTdHMlNKWlgv?=
 =?utf-8?B?eDJnMUlOVzQ3ZXk1K1Y5dW1MekxiaUJhYlh5cGNqTUNVZUhSUVdpWnVwRVAz?=
 =?utf-8?B?WVlXZWY5VFYxQWUraXUwTDQzR1hsQmxnbTQxL28yYVhWZVBFSUREbGErZ21H?=
 =?utf-8?B?TUFkQXdjakMvZENNaU9OdUN4a2FSbXljVE0xWUJDSFo3WGx5Y1J1L0kvK09D?=
 =?utf-8?B?MWsvMzdXeXBqWDJiSnNuYmVraERTeU5ZcHI0SVpycnBUT0NIWXZqejVyNG5Z?=
 =?utf-8?B?anlxT2ViNS9sMW82Q3IwcndXQUpsTTJWNHU2TWdlcTdXVkQwbVdNeC9NMGRp?=
 =?utf-8?B?TFU4UkJuVHFqazhIRlBLUmR1b2k3OGYvS0JpOWFQUGU2ZzU1RFoyRWNyKzh2?=
 =?utf-8?B?VUVHYWQzVkE5TTBjL3RoeDZSeDAzd2NJTEZxUzVpbjI4Vk5xdDdCTWdoVmQ1?=
 =?utf-8?B?aTEzNDkxaVBFR1AzN0FnVHhudVlaaTAyTWt0ZEhLLzJFS3ZYWTdabC9CUmlj?=
 =?utf-8?B?WEhqNUNVZnY2ZG9vVkhjcmxpakl5dmEyeGVWUTJ0d2xxdm9aOCtpM2pyRzZB?=
 =?utf-8?B?TnhsdWRsL2o5ZU05WStsR0RjTHFZSmFzNjdLcXFwbm85b08vZnoyMDE5NU9L?=
 =?utf-8?B?WnZ4bDVMcVoyeUNsYW11eTY2aXZpbnJMOUZpQmFOZWJsQjJFdFJFQXpJTjF0?=
 =?utf-8?B?dmF6eHZ2SG9ENDRFN3IrM0VlUmRZR2dObEMzWGYwMld0WERORkhGY2VRZ3E4?=
 =?utf-8?B?ZFVWcEhRTEdxOURoUGcwVUFTS1dBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0091AC24795B7D4AB67A0A89E666470F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806406ab-561c-4530-a248-08d9efa81749
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:52:27.2631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GsxpA5Ktp79emnbF5vfaQ+CpgzwS92vlqx9IP/+XGMhW+y/wNxqaiYPjAZMgFl1lwSyvXXh0OhrntlnLK0iYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_025231_341399_694A04A8 
X-CRM114-Status: GOOD (  13.65  )
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

T24gMi8xNC8yMiAwMTowNywgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gQUVSIGlzIG5vdCBiYWNr
ZWQgYnkgYSByZWFsIHJlcXVlc3QsIGhlbmNlIHdlIHNob3VsZCBub3QgaW5jb3JyZWN0bHkNCj4g
YXNzdW1lIHRoYXQgd2hlbiBmYWlsaW5nIHRvIHNlbmQgYSBudm1lIGNvbW1hbmQsIGl0IGlzIGEg
bm9ybWFsIHJlcXVlc3QNCj4gYnV0IHJhdGhlciBjaGVjayBpZiB0aGlzIGlzIGFuIGFlciBhbmQg
aWYgc28gY29tcGxldGUgdGhlIGFlciAoc2ltaWxhcg0KPiB0byB0aGUgbm9ybWFsIGNvbXBsZXRp
b24gcGF0aCkuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQoNCkkgdGhpbmsgc2FtZSBw
YXRjaCBpcyBhbHJlYWR5IHByZXNlbnQgaW4gdGhlIG52bWUtNS4xNyBzZWUgWzFdOi0NCg0Kcm9v
dEBkZXYgbnZtZSAobnZtZS01LjE3KSAjIGdyZXAgInZvaWQgbnZtZV90Y3BfZmFpbF9yZXF1ZXN0
IiAtQSAxNSANCmhvc3QvdGNwLmMNCnN0YXRpYyB2b2lkIG52bWVfdGNwX2ZhaWxfcmVxdWVzdChz
dHJ1Y3QgbnZtZV90Y3BfcmVxdWVzdCAqcmVxKQ0Kew0KCWlmIChudm1lX3RjcF9hc3luY19yZXEo
cmVxKSkgew0KCQl1bmlvbiBudm1lX3Jlc3VsdCByZXMgPSB7fTsNCg0KCQludm1lX2NvbXBsZXRl
X2FzeW5jX2V2ZW50KCZyZXEtPnF1ZXVlLT5jdHJsLT5jdHJsLA0KCQkJCWNwdV90b19sZTE2KE5W
TUVfU0NfSE9TVF9QQVRIX0VSUk9SKSwgJnJlcyk7DQoJfSBlbHNlIHsNCgkJbnZtZV90Y3BfZW5k
X3JlcXVlc3QoYmxrX21xX3JxX2Zyb21fcGR1KHJlcSksDQoJCQkJTlZNRV9TQ19IT1NUX1BBVEhf
RVJST1IpOw0KCX0NCn0NCg0Kc3RhdGljIGludCBudm1lX3RjcF90cnlfc2VuZF9kYXRhKHN0cnVj
dCBudm1lX3RjcF9yZXF1ZXN0ICpyZXEpDQp7DQoJc3RydWN0IG52bWVfdGNwX3F1ZXVlICpxdWV1
ZSA9IHJlcS0+cXVldWU7DQoNCg0KDQpbMV0gDQpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9w
aXBlcm1haWwvbGludXgtbnZtZS8yMDIyLUZlYnJ1YXJ5LzAyOTgwMy5odG1sDQoNCmNvbW1pdCA2
MzU3MzgwN2IyN2UwZmFmODA2NWEyOGIxYmJlMWNiZmIyM2MwMTMwICh0YWc6IA0KbnZtZS01LjE3
LTIwMjItMDItMTAsIG9yaWdpbi9udm1lLTUuMTcpDQpBdXRob3I6IFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+DQpEYXRlOiAgIE1vbiBGZWIgNyAwMDo0MDoxMyAyMDIyICswMjAwDQoN
CiAgICAgbnZtZS10Y3A6IGZpeCBib2d1cyByZXF1ZXN0IGNvbXBsZXRpb24gd2hlbiBmYWlsaW5n
IHRvIHNlbmQgQUVSDQoNCiAgICAgQUVSIGlzIG5vdCBiYWNrZWQgYnkgYSByZWFsIHJlcXVlc3Qs
IGhlbmNlIHdlIHNob3VsZCBub3QgaW5jb3JyZWN0bHkNCiAgICAgYXNzdW1lIHRoYXQgd2hlbiBm
YWlsaW5nIHRvIHNlbmQgYSBudm1lIGNvbW1hbmQsIGl0IGlzIGEgbm9ybWFsIHJlcXVlc3QNCiAg
ICAgYnV0IHJhdGhlciBjaGVjayBpZiB0aGlzIGlzIGFuIGFlciBhbmQgaWYgc28gY29tcGxldGUg
dGhlIGFlciAoc2ltaWxhcg0KICAgICB0byB0aGUgbm9ybWFsIGNvbXBsZXRpb24gcGF0aCkuDQoN
CiAgICAgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCiAgICAgU2lnbmVkLW9mZi1ieTogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCiAgICAgUmV2aWV3ZWQtYnk6IEhhbm5lcyBS
ZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KICAgICBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCg0KDQotY2sNCg0KDQo=


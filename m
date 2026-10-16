Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB51BCCA463
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 03:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RkAbE81FKj0IL3j08s7KiScb2/8v7iKRJ3s4L/RPPxY=; b=Ib60PqhogEy9mTNOgbLl5djrju
	l+8hqnLUohV4qpi1rVs/DUM3y7ai+zDS5WiTnN0OjDdY0RWcxC1iRpfd0xWpznNGS6m4/+1MT8quL
	Ww2zVuKKbIN0qaZNVmnOCgMrUmOIyeVCiLEtsU7854IZt9pNMtfdgNq6yDuR3s+v6VUssCAJpCqP3
	+W2k/1qiomn15og8OA/+mU6V2bs5FlhH0pS77pBo8eL+Mcw8QM8eHsOC0e+TlN/LtARGY1LL31lZD
	LxYaKtqNrQV4tdI/DCFC2iG9kMy6JmU/TXx8SEfUmPKqoSbdYOng8EgOsXiY85GRqM0lU1+pEHmlu
	vj0/t5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYBm-00000001m5u-2oxs;
	Fri, 16 Oct 2026 03:00:58 +0000
Received: from mail-westcentralusazolkn19010040.outbound.protection.outlook.com ([52.103.7.40] helo=CY7PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYBk-00000001m5G-2kDb
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 03:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGHFdaPYozo0trQ77wHzb84yLKWUhpncIjGUGdYrBvY1nhmUAE2juf5J55iY3TZS0s/o8cbJA14GDACpRThh6bCn1LOMdtWWsuGPTrwsuglklT97k00MgCVce7bKmh4q3Aow52ZUMe4ytSsiESa9iG0Rrzu0+dBfYuqdwVJmUgwv5Ee5vGHyfRGUUTv49zX9ZZhtIP6ZJ9Lyxj2dq6g2B7jmFJSiCl82mBy2MlXd5M8zqRoBSIb6hwKYojTtX/O3KhmklfzG1r7nnBR8O17qVE0YwYcmiJaPAiRejRuMHu7Kaw+cmuxz5HuwM4WQ+yGMwq1yDU6/qbn/9Gf1P0f1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RkAbE81FKj0IL3j08s7KiScb2/8v7iKRJ3s4L/RPPxY=;
 b=q6U+m5az8vAEEvoibv6ztu4ViloX8nBh2q4GZEyDwPG284G2UpXo7aOewYvimiYIxKdTJqG0V0Bh7jVcpazdpy8OmIoBsBo56Y6AU0lpEHMI+uQqgzNcKe9MnUpbSC/y6rqvG0aDezEQXoEfZttXmUNufgw4wy+O7kzuRfvUpGn+zBUPHKZf39MuyWpXAuVvmlvbQ0ufMW4BFedBzxAt9r+YHQirBuasojcVWkmCQWOVwgssrMqDV8Lo8m3c3pHp7lyqvxXs291CofNwXEy9nVkMLg0kHDcyvHMi4HpbHAQrqYg/zSJgKyZppRyzKOMbWi+TBm4SsASurUgS7T4BFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkAbE81FKj0IL3j08s7KiScb2/8v7iKRJ3s4L/RPPxY=;
 b=i7un8bXgqx9N+FhAEAMITrEmarJQKV/j2lfpiL9S4wJysxSh/cj8Qo16s3ZdBEtsSrhTQKM04Pd5TiqAXFzJMrB2AW9aw8KCGZ/JA+3LGnChDI0Z83hWoVrTfOZKy1HjRyo4h8oZDd0XwQTxi509LpOHVpH+oqqAWcwMA3uxe7e5CJoAmc6kG6vUg6P2lKI/72Z/zhT5MSGkqurIj+Y+uZgNhvCKnNA5+hiIx46b7ijFpJidtijaoS0YT210y12k93Hicoge7h16YiJq8OVxAqJ7V0Wa5I4XZM5g6G0cuWDXl9nwjs+xaR5aU4V05WGRpGkmZdML4lgpxvzHSPLyzg==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH0PR05MB8573.namprd05.prod.outlook.com
 (2603:10b6:510:a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:00:50 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:00:50 +0000
From: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
Subject: [PATCH 0/4] nvme: make passthrough user copyback failure-safe
Thread-Topic: [PATCH 0/4] nvme: make passthrough user copyback failure-safe
Thread-Index: AQHdXRqMEJJRQPrr7Eq0hyZQxGZv0w==
Date: Fri, 16 Oct 2026 03:00:50 +0000
Message-ID: <cover.1792118770.git.x-professor@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH0PR05MB8573:EE_
x-ms-office365-filtering-correlation-id: 6052e501-c401-4d19-0fcd-08df2b31af5c
x-microsoft-antispam: BCL:0;ARA:14566002|24021099003|8060799015|19110799012|31061999003|25010399006|8062599012|8022599003|38102599003|15080799012|3071699003|19061999003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info: =?utf-8?B?Zy9nSndPUmJ4UjJxNHp2SmZDR3lMUWZDS1p2WmJ1ZFVHTDRobnM0S3hQR254?=
 =?utf-8?B?eTB5ZEF0RVhNUGU3VVBFYWgxOEN3WFl6SGZVNVJSbXVYckxGdmtlSHpsMEF6?=
 =?utf-8?B?eHIxU1BYc2dJV3p0aVd6TjNvK2cwMlFsV01LdlRzc0VHdENmWEZwOHFydVVQ?=
 =?utf-8?B?NlJCTXloTGs0QlFRQURWQWh0WXlsK1hCYlh0bkV0NlhYN0NPWkxyb3VGTDZ1?=
 =?utf-8?B?YXlvNmdlSjgvd3NtQkpZbmFuaE9lMTBrcXR4a0xRZUxUdEhuQ1Jici9VdGhO?=
 =?utf-8?B?OEE3aDRCbnJOYnAyOXdsSjJGKy9WYjdVUFM3dGRONStPR21kMmtlaEFDTVlp?=
 =?utf-8?B?eW5vQXRVclhMKzNWRUVZMDE0TFB3cnRJZlJ5QmFmZWFxMG1iZzY4MENTUjE4?=
 =?utf-8?B?MmRzZ1BPblZLR01oZUxjc05jRU03aUJ2Z3JJVjVUSDVWQWgxbUd3YTFYeWFJ?=
 =?utf-8?B?NWN6eHZiK1lsdHlVZ0x1cy9WZkV3MEVmQkV2YVFKRHlGQm5wcHhlMnB5L0lW?=
 =?utf-8?B?cnQ1YzRUTU1xRldibnJWbk01QXFEUERLNjhtZjF3Zm9WWDV2dlFRcTRTQ2ha?=
 =?utf-8?B?Zm92aGorNDdZRVlMQTlneWhmVjdYdW94NnhyTzl4dERFbi9wVVpOUzhTUzJO?=
 =?utf-8?B?MVpwY1dST2ttQmIxWmtBZEN6WlVhRmJHMjl1d0NnWHQ0T3A0dDJzb21uRzlU?=
 =?utf-8?B?K01oT0ZoamFXc1QyQXpDNDI3b0NscXVQUEhWM3AvRytqZTVXR1FIMzVUSVp0?=
 =?utf-8?B?TkJmcDVhamsyUjR0SmVKaHNCT01EQ3c1R0d5V3BST2ZVVEtJbzJDWldEQVhO?=
 =?utf-8?B?NWk1NCt5UVk1REVIbzZ3aWxPVTJ4N09oTWVMeG4wQ1oxSytKUmdDbmMrTmtw?=
 =?utf-8?B?RFdvS0t1enlyNldGTUd2YXJZUlhpcHVidklxNWYxYTFZU0diSGJzQjNKZlR3?=
 =?utf-8?B?RGxTTEwwWjRTRHlOTm5RR1hjbnNGcFlLcHJaMkg4QytqZzE2TTN1NEdoczQ3?=
 =?utf-8?B?VWlOcnNsbndjb2xCNTFFNFcyanFpQVgzSW1GeWd5dUwrbStjZWlXcSs2cnpm?=
 =?utf-8?B?VWFwN2Y1NlRpNUxCQ1p1RVFtMWtLUHRzSVlKSXVPRzhvUG9BUjNPTXEvOE8y?=
 =?utf-8?B?RGE1OEpralp2ejY2MU9xamdndDNqSVRFbGdtaXZrV2I1VmJrZlpzeWZ1Mk5U?=
 =?utf-8?B?ZFdLZFNHZHllQThSWWtQc1BIUVcwdm1LcVVLRFlTMlpiNXArNzBTZGFWT005?=
 =?utf-8?B?eE1ZYXl1T1ArUnhSb1FmcmRsVkVpUWZSSnlKOTlLUmx5SG41RkcvWnpXL1Az?=
 =?utf-8?B?dFphd3g1eVFUZTJTRGQ3RndjaXJlanZKNDAzTmc2aUdCdHdJR04xVzVqV1pX?=
 =?utf-8?B?WEQ2TnhsV2RmcXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhJcXZySWlJOGtHeVRVZGx4a0xHanY5bXlmNG1wNnpaeFRHZjdEU251cXE3?=
 =?utf-8?B?ekhidTlBYkI4aTJtdnIwVjJCMFUvU25CaGcyU0VjOVltNnE3NVJic29kL0xR?=
 =?utf-8?B?UE83Q1hXY0tmN2NzdGJPdHhuWWVRWWt1U2NLWmhEamludWlqYjVhWHFvRTN2?=
 =?utf-8?B?TEt5TjN6U2haMlBBRXJTMFlxWE0wbDExT2VqWE5rNUhlZVI1WU0yWUtwY3Aw?=
 =?utf-8?B?bjcyZ3gwRjBjNVhHdThWTy9SeVpLR3drVXR0d3VBTzN5dmtPU2NwcHBEY2xM?=
 =?utf-8?B?TVdnVEc3blJVcmJrb29tVE11L0xlN2hZKzFKNXhYTnErN05UdGJ3S2trWkNV?=
 =?utf-8?B?ZnVIalk5RnI0MVBOTW1nRm5qRDVJMzZpV20vMWZWa1B5S09lUE9JeGRSOTd6?=
 =?utf-8?B?TW1tWkRJM1BpdkV3b2FzQ09KL0Y3dGEyUXl4d3prWVVqczJkamlOZkU0K29N?=
 =?utf-8?B?Ym5Bb0tqekltTXJTNFE5MjYxOTJUYjlDbjJjalprWXp2ZUpnNDRwYXl4UDZj?=
 =?utf-8?B?dk5hVDZEUVF3TitsWXFuSWF2Q29IdjlySGFXNzJWc1VvME5LSnB6WThsSjVm?=
 =?utf-8?B?Y1RsRzFYOGU1Q2dRekZpTTlEeXR5RFd6ZFJMaDNhU2FncndrSGdDMWsvRE9V?=
 =?utf-8?B?UUFLUWpudDk0N2prMTFEbFhONjd5ZzZmVEg0MnZwV1NmbVU0STdkNXhaaUdl?=
 =?utf-8?B?MmJmbEQ2TU5FUm1INnQvNXNrNFBEdHR3bUl3MVZ2QnFlb2ZDaGdELzhKTkxN?=
 =?utf-8?B?b0tmaGk5NENUWjVtNXdyNXRsM1JBTWUwZzNzdVFrM0pHQnZIK3phdVZISHhM?=
 =?utf-8?B?MHpHV1dqSkRLRmNJWlhOd3BLVFN5czVKd2hLTnJVVEp4Z21CVE4rV3hid1I0?=
 =?utf-8?B?S3dvRHQvdEZwYUdEWFJta011dmdOOUs2RWdmU3RhY09menVhYkMrK0pmTXIr?=
 =?utf-8?B?QkdWd2hMY04vWEpsUDZGVnFrVWRJYWF0UzkyOVo1b3FzQ2wwS082eVdvYXh3?=
 =?utf-8?B?L3A4NUNxVUdiQkpObHRhM2hUUURGYXhVYjZOaHNEVnlUTElmN2JHR1pBbzBT?=
 =?utf-8?B?VzJRdXQzWmMwdWtOekVwNUV5MGgvdlQ1UWFZYUYvZlRSME5lY1dvNVIxSFk1?=
 =?utf-8?B?cHE2SDdkeHlpWENQbDhqTnJRS2lQb3hFNlJIV0ZGaGFsaVNnV0RPZjRPazRv?=
 =?utf-8?B?N3ZkdlRpeXV0WTA1Vm04OE02UTNRR3RaVVJLY0FMc3RGU1d0S3VqWkVURjdm?=
 =?utf-8?B?QlVBZzRpcFVuS291WHNFblVzVTJROHlJYTZzZkhGUGdDQ1RWTjhHZFpHNkRY?=
 =?utf-8?B?NVRzaG95TWx5bllESGthRHR6ZWZKbU03KzAvTFZldUxuV25oQi9EdlVJQ1RW?=
 =?utf-8?B?WVZvYTFSaDNRaWg4MmEybXJMZHRnM1ZsNHZtc3AxVCtEMUEyQ1lTSFA1YTkr?=
 =?utf-8?B?WGlUSVFJU2Q0c01PSERhaXlLZVlPMHFFaSthNnE3b05UMTJialFmREo1eU9v?=
 =?utf-8?B?Z1g2N3hNd1J6T2ZjL0FxbHNDQy8vdlc5cVJOOUoxaStMcGxRV0dMeFpqY2V0?=
 =?utf-8?B?dElRdUFTOEsvZjJxVWJBdEUzYS8yTS9mVFZIVmU3OXEzMzltMWx1eWc5SjBt?=
 =?utf-8?B?S0d2QmdpOTNEMHJPTnByNXd5VXBHbDQ1TkY4bjlhd1RMUFBVNDVtU1VYd1Fv?=
 =?utf-8?B?ckNZSnBybEEzamtmcEFiMmtncVlTOVo1aEZtQXo0MUxsbnRTUXhHZnVhc1Nu?=
 =?utf-8?B?MExZbEs1MnpsaHQ5YTB3REpmNFozRVp0ZmdPdk1zRWlZMW5IamxKZCtocWF6?=
 =?utf-8?B?OFRUZkwwd3Q1T2loU0pYaFZsbnFPWXhIQ2pyRUdwZGRxTHVQZWZUS1h0cUM1?=
 =?utf-8?Q?UZBe8LEv9Z08J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052e501-c401-4d19-0fcd-08df2b31af5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:00:50.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8573
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_200056_706355_79EAC456 
X-CRM114-Status: UNSURE (   8.46  )
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

TlZNZSBwYXNzdGhyb3VnaCBjb21wbGV0aW9uIGN1cnJlbnRseSBjYWxscyBibGtfcnFfdW5tYXBf
dXNlcigpIHdoaWxlCnRoZSBjb21wbGV0ZWQgcmVxdWVzdCBjYW4gc3RpbGwgb3duIGEgcXVldWUg
dGFnLiAgQSBjb3B5YmFjayBwYWdlIGZhdWx0CnRoYXQgbmVlZHMgSS9PIGZyb20gdGhlIHNhbWUg
bG93LWRlcHRoIG5hbWVzcGFjZSBjYW4gdGhlcmVmb3JlIHdhaXQgZm9yCnRoZSB0YWcgaGVsZCBi
eSB0aGUgcmVxdWVzdCBwZXJmb3JtaW5nIHRoZSBjb3B5YmFjay4gIFRoZSBzeW5jaHJvbm91cywK
dGFzay13b3JrLCBhbmQgbG9jYWwgSU9QT0xMIHBhdGhzIGFsc28gZGlzY2FyZCBjb3B5YmFjayBm
YWlsdXJlcy4KClJlbGVhc2UgdGhlIHJlcXVlc3QgYmVmb3JlIHN5bmNocm9ub3VzIGFuZCBsb2Nh
bC1JT1BPTEwgdXNlciBjb3B5YmFjaywKYW5kIHByb3BhZ2F0ZSBjb3B5YmFjayBmYWlsdXJlcyB0
aHJvdWdoIHRoZSBpb2N0bCBvciBpb191cmluZyBDUUUgd2hlbgp0aGVyZSBpcyBubyBlYXJsaWVy
IGNvbW1hbmQgZXJyb3IuICBLZWVwIG52bWVfcGFzc3RocnVfZW5kKCkgYmFzZWQgb24gdGhlCnJl
YWwgY29udHJvbGxlciByZXN1bHQgcmF0aGVyIHRoYW4gYSBsYXRlciB1c2Vyc3BhY2UtY29weSBl
cnJvci4KCldpdGggYW4gTlZNZSBJL08gcXVldWUgZGVwdGggb2YgdHdvLCBhIHNhbWUtbmFtZXNw
YWNlIGZpbGUtYmFja2VkCmRlc3RpbmF0aW9uIGh1bmcgYmV5b25kIDYwIHNlY29uZHMgYmVmb3Jl
IHBhdGNoIDEgYW5kIGNvbXBsZXRlZCBpbiAyMC8yMApydW5zIGFmdGVyd2FyZC4gIFVuYWxpZ25l
ZCBQUk9UX05PTkUgZGVzdGluYXRpb25zIHJldHVybmVkIGZhbHNlIHN1Y2Nlc3MKYmVmb3JlIHRo
ZSBlcnJvci1yZXBvcnRpbmcgY2hhbmdlcyBhbmQgLUVGQVVMVCBhZnRlcndhcmQuICBUaGUgbG9j
YWwKSU9QT0xMIHRlc3QgcmV0dXJuZWQgLUVGQVVMVCBmb3IgYWxsIDEsMjgwIGNvbW1hbmRzLCB3
aGlsZSB3cml0YWJsZQpjb250cm9scyBjb250aW51ZWQgdG8gc3VjY2VlZC4KClRoZSBzZXJpZXMg
cGFzc2VkIHNjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCwgZm9jdXNlZCBXPTEgYnVpbGRz
LAp0aGUgZnVsbCBiekltYWdlIGJ1aWxkIHVzZWQgZm9yIHRoZSB3aWRlciBhdWRpdCwgYW5kIFFF
TVUgZGlmZmVyZW50aWFsCnRlc3RzIG9uIHRoZSBhZmZlY3RlZCBjb21wbGV0aW9uIHBhdGhzLgoK
WWluZ2ppZSBXYW5nICg0KToKICBudm1lOiByZWxlYXNlIHBhc3N0aHJvdWdoIHJlc291cmNlcyBi
ZWZvcmUgdXNlciBjb3B5YmFjawogIG52bWU6IHJlcG9ydCBzeW5jaHJvbm91cyBwYXNzdGhyb3Vn
aCBjb3B5YmFjayBmYWlsdXJlcwogIG52bWU6IHJlcG9ydCBpb191cmluZyB0YXNrLXdvcmsgY29w
eWJhY2sgZmFpbHVyZXMKICBudm1lOiBoYXJkZW4gbG9jYWwgSU9QT0xMIHVzZXIgY29weWJhY2sK
CiBkcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jIHwgMjUgKysrKysrKysrKysrKysrKysrLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgoKYmFz
ZS1jb21taXQ6IDBmY2IwNWI3MjM0NGY0MDgwNmNiZTgxMGRlODg3MmYxNjk4YmYwNTMKLS0gCjIu
NDMuMAoK


Return-Path: <SRS0=u6WM=6K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA32C55191
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2020 10:04:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3FF2071C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2020 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aw2oW1n6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="qyvQPSyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3FF2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O469xr5cTuTf7CnimHwW3kj/DqpQWXuonxHiVxOoztY=; b=aw2oW1n6CHzjcRHTzVOxx0iGi
	WwYPUK9X0cWouKmw4LUWO5WpZoZkKplHHB2q6wSD6dwmE6okalSb/KH/ZsyP6Ytp1R/1IZHeD5Ssz
	f2ZQHOozEacjdpUCbSI+Iz+UDYD2iJJkZeCMjiWmDljUI/QR0bbF/URrlhlFnloSnzkhW+U6TZ73M
	x2sIT17qfaOvMxLIjnFU3Sq6gxCH5xmpnEdHqgTwyXS8kpWogYOTJDoi2mRNXnt/l1taLpJ8OUXnD
	ft6b2JMhmG1pA1eiYgErB27QDYQDC2bfRoALA0HvspcEei0o9a6pwX60lkjRm905aFnSYiypM46xS
	WnHKeEBpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSe9g-0000up-Qb; Sun, 26 Apr 2020 10:04:56 +0000
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSe9b-0000s4-V2
 for linux-nvme@lists.infradead.org; Sun, 26 Apr 2020 10:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/Ira7dE7Vm1MR438na6mDh1DhseAuyVVk6SXbXtlC0sHrTdoJA9huU8HVuQbBOg52H+ErF/b3YKrgzlvUUmVDgjkwsnXPur8a6JZ/GS6xuA/ZKNRxwAKTrV9CjPPLlGMR38oRQpXiIG4PZKLfuWYYNGC4fjrfbhG1dRwdGNrHOZTQe6/KiFnk+EJ52Ah9Xks5ap0dltB1t2yMOSOZI+I/o6gpg/s5MxiiVUekSusWsCYQFy7SK/CCRtkGWX+epp3JHg9L4+KNDx1yGk8iSWv4E5vnrYD1gyLHLrFkSKyaDvt4H88ahcde+iutnKyNMLPfwnUDgGuSaX5/IulL5s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt63y3Q6HUJigOhfm4SAdI+YU9zMghFP8U21LwNNvNs=;
 b=Dw5RUZt3UaalaTXrTB+yERXQPgKBxytJ1B1QsHW5MGtRwcK9W3F1DIafqx2jhjZE7ftTjYYnTmrEFsh++rXqHDPZhI9/i3CKRIiuqOXsbwqQ/R4t1q7cflhEgEE90G6UKYgFEBtiHP2XX1gWn/ZccNUkpXix7oe29rMorRzzUSBC1G3CoN2kK+Rg+d71A7PUMuyqXYY788SJEBqGvB6m/6nWQUcrrHSIxLLa/aW9cF97DDjblzYgaAMlxktoV/uARy2xm97AMH7ENBoq0S5W8cmaMK8Yk4hwBsRAdfj3edQwYQ8k60yobLv9PSGsFi/4/z0rY3U8eQgNMyOJ5ICG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt63y3Q6HUJigOhfm4SAdI+YU9zMghFP8U21LwNNvNs=;
 b=qyvQPSyrdcErGZDEsZG1kpvN6m+CFZVef67zGSqGJYWzCpcSDTKnbrMim8kFZP1/xMDp5dJh0Ob9DME/9TuO7SXOBXeYnzvTQIVGdn8cIN1hWUDmLnB9gsZOEoyY7YP75pWZbwzNaNpHeNt2xvYQLEanHtGFmWJLeiOebBuGHSk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 10:04:48 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 10:04:48 +0000
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
To: Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-10-maxg@mellanox.com> <20200421122030.GI26432@lst.de>
 <688ec4ba-78e8-0ba3-9ee9-3c19b3e7b0c6@mellanox.com>
 <20200424070930.GC24059@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <9e678a4b-814e-94c2-6405-51d5030839dd@mellanox.com>
Date: Sun, 26 Apr 2020 13:04:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200424070930.GC24059@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.7] (217.132.59.243) by
 AM0PR05CA0079.eurprd05.prod.outlook.com (2603:10a6:208:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 10:04:46 +0000
X-Originating-IP: [217.132.59.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19e9a858-cee1-4787-9d53-08d7e9c940ca
X-MS-TrafficTypeDiagnostic: AM0PR05MB6002:|AM0PR05MB6002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6002719915D6CF474F91FFF3B6AE0@AM0PR05MB6002.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(107886003)(6486002)(8936002)(8676002)(186003)(81156014)(86362001)(5660300002)(16576012)(316002)(2616005)(956004)(36756003)(31696002)(52116002)(4326008)(16526019)(53546011)(26005)(31686004)(2906002)(6916009)(66946007)(66556008)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FoKC+Vd2z+elrWj0uwanxsa8Pw+n2pitQQd2bQiIWPCJirfVpe/MhkHsOuoZ5cECbzNzhsOa6V+q9rcqkdBDB7pyu26Dhz0JT1CZbrQBF1Zt0OCd3Ei0LlfuqAj0MQNQoyNqkR2c9XXRYOQ8cTR+oTSSsFefdwnewKY6PFovuGa8NZnvgV3TaBxt5KbOdL9YWWehhMLlds68gBY1t1MD36L2PHAMZW0VUqDHOdThv3TQr5rme4j7D5oiw6/dWAcuIQ+3aiWBoKY/K157UXuHkxl6+OVc+iojrtO5kPdJExx7MRWgVp5ktn8j4YqqE8FqkBhxc+EzbqNbsKONmmm83xwiRVcRDjFKx716FiHPYtdD4u5L1FwaNlAJmb9PoHJBjokhqISn/WbNcfElqyjEWlYxq2g1T+hfi1YIm5+cYYHW0FdVj0HgfF5RjvUr+I1v
X-MS-Exchange-AntiSpam-MessageData: Dv4WZmIlsZKVCN3+cKEMvW0TI425DudO/K5QwqgwVd4XLG+D/05rlExe5lF2/UZilpxrIoxbf9v5Y5EHMbL5YQRH5UN/8FAlneEu7pcQeYCvo5QdQgPQgBPURTfkwIK9lSJkcQ/Sf3rYGXpe2v92byJWbszMHfXQmZDIjz/vScM1oGQ2vKbtXISTm1Nqm5b4wYJI4OW5KCvAEI6qABSUZFW/vJKIhan5Phb6wiOd1C9bBdtj2ReYtu5vXjDVcRTQ0rvtzaEJGYnTo+Q+uvZs6N+LsdRUbl1okOnKYPw2Kj5PAo2B7TgcSrS78RYka/mBh5xuxtNGUK7nMOGNB9XbYdxMMwbMNIqyGTqexYWekGrRGEeK92PpcO5LEXoKoXgHkC7Ql7JUktxMXGuvrWEO0/oMpckBKUSusJ2HIFGDBXLrnzmhvUf/bAmlFgeXKCOAcnY0xQ17NYto90mZyzsEp4oq7Sd+XQzfyng4UevmLYC4WAq3cAoU078vUS3ZwNlGj1rrqANMOQnKU4GGjzvBfNJn1V8WFr2fmdy0pBEYJySFL8AwjutZRcZk4vexituoYvJY8N169Fc9c8xSpIG2+732JQVRd9gR+gA81YqpKTiqNTvZCvcNEnMpd4RGel3nsdkaKVDhA2Umad0b9tfZbg1ztF9QPPMp3H/DUjhILMxbzOO7dkQpzch32/Znfhc4qd4/7zM2W17TKVO8+84LHaOZdJ3hN5KIvtcCfO0If8T5WhqqPHv41CxsBHE4fyIAWHowUjaKJbMTZ1SwWVReKrEU63ZBNxn5pQpmd900VLk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e9a858-cee1-4787-9d53-08d7e9c940ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:04:48.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl6k+lP6I+DPoRq02qy9ipseR+4xz8SLh9obuFVxDvAixYy65mUK6WRh0HuXWiBDeOOEUk2JDbF4tf9aECV4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200426_030452_013043_DF12F1B0 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDQvMjQvMjAyMCAxMDowOSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVGh1
LCBBcHIgMjMsIDIwMjAgYXQgMTI6MjI6MjdQTSArMDMwMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9yZG1hLmMKPj4+PiBpbmRleCBlMzhmOGY3Li4yM2NjNzdlIDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3Jk
bWEuYwo+Pj4+IEBAIC02Nyw2ICs2Nyw5IEBAIHN0cnVjdCBudm1lX3JkbWFfcmVxdWVzdCB7Cj4+
Pj4gICAgCXN0cnVjdCBpYl9jcWUJCXJlZ19jcWU7Cj4+Pj4gICAgCXN0cnVjdCBudm1lX3JkbWFf
cXVldWUgICpxdWV1ZTsKPj4+PiAgICAJc3RydWN0IG52bWVfcmRtYV9zZ2wJZGF0YV9zZ2w7Cj4+
Pj4gKwkvKiBNZXRhZGF0YSAoVDEwLVBJKSBzdXBwb3J0ICovCj4+Pj4gKwlzdHJ1Y3QgbnZtZV9y
ZG1hX3NnbAkqbWRfc2dsOwo+Pj4+ICsJYm9vbAkJCXVzZV9tZDsKPj4+IERvIHdlIG5lZWQgYSB1
c2VfbWQgZmxhZyB2cyBqdXN0IHVzaW5nIG1kX3NnbCBhcyBhIGJvb2xlYW4gYW5kL29yCj4+PiB1
c2luZyBibGtfaW50ZWdyaXR5X3JxPwo+PiBtZF9zZ2wgd2lsbCBiZSB1c2VkIGlmIHdlJ2xsIGdl
dCBhIGJsayByZXF1ZXN0IHdpdGggYmxrX2ludGVncml0eSAobWVtb3J5Cj4+IGRvbWFpbikuCj4+
Cj4+IHVzZV9tZCB3aWxsIGJlIHJlc3BvbnNpYmxlIGZvciB3aXJlIGRvbWFpbi4KPj4KPj4gc28g
aW5zdGVhZCBvZiB0aGlzIGJvb2wgd2UgY2FuIGNoZWNrIGluIGFueSBwbGFjZSAoYWZ0ZXIgcHJl
diBjb21taXQKPj4gY2hhbmdlcyk6Cj4+Cj4+ICIKPj4KPj4gaWYgKHF1ZXVlLT5waV9zdXBwb3J0
ICYmIG52bWVfbnNfaGFzX3BpKG5zKSkKPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXEtPnVzZV9tZCA9IGMuY29tbW9uLm9wY29kZSA9PSBudm1lX2NtZF93cml0ZSB8fAo+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjLmNvbW1vbi5vcGNvZGUgPT0gbnZtZV9jbWRfcmVhZDsKPj4KPj4gIgo+Pgo+PiBBbmQgdGhp
cyBpcyBsZXNzIHJlYWRhYmxlIElNTy4KPiBJdCB3b3VsZCBvYnZpb3VzbHkgaGF2ZSB0byBnbyBp
bnRvIGEgbGl0dGxlIGhlbHBlciwgYnV0IEkgcmVhbGx5IGhhdGUKPiBhZGRpbmcgbG90cyBvZiBs
aXR0bGUgZmllbGRzIGNhY2hpbmcgZWFzaWx5IGRlcml2ZWQgaW5mb3JtYXRpb24uICBUaGVyZQo+
IGFyZSBhIGZldyBleGNlcHRpb24sIGZvciBleGFtcGxlIGlmIHdlIHJlYWxseSBuZWVkIHRvIG5v
dCB0b3VjaCB0b28KPiBtYW55IGNhY2hlIGxpbmVzLiAgRG8geW91IGhhdmUgYSBnaXQgdHJlZSB3
aXRoIHlvdXIgY3VycmVudCBjb2RlPyAgVGhhdAo+IG1pZ2h0IGJlIGEgbGl0dGxlIGVhc2llciB0
byBmb2xsb3cgdGhhbiB0aGUgdmFyaW91cyBwYXRjaGVzLCBtYXliZQo+IEkgY2FuIHRoaW5rIG9m
IHNvbWV0aGluZyBiZXR0ZXIuCj4KPj4+PiArCWlmIChibGtfaW50ZWdyaXR5X3JxKHJxKSkgewo+
Pj4+ICsJCW1lbXNldChyZXEtPm1kX3NnbCwgMCwgc2l6ZW9mKHN0cnVjdCBudm1lX3JkbWFfc2ds
KSk7Cj4+PiBXaHkgZG8gd2UgbmVlZCB0aGlzIG1lbXNldD8KPj4ganVzdCBnb29kIHByYWN0aWNl
IHdlIHRvb2sgZnJvbSBkcml2ZXJzL3Njc2kvc2NzaV9saWIuYy4KPj4KPj4gSXQncyBub3QgYSBt
dXN0IGFuZCBJIGNhbiByZW1vdmUgaXQgaWYgbmVlZGVkIGFuZCB0ZXN0IGl0Lgo+IEkgdGhpbmsg
KGFuZCBwbGVhc2UgZG91YmxlIGNoZWNrKSB0aGF0IHdlIGluaXRpYWxpemUgYWxsIHRocmVlIGZp
ZWxkcwo+IGFueXdheSwgc28gdGhlIG1lbXNldCBzaG91bGQgbm90IGJlIG5lZWRlZC4KCnJpZ2h0
OgoKaWYgKGZpcnN0X2NodW5rICYmIG5lbnRzX2ZpcnN0X2NodW5rKSB7CiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5lbnRzIDw9IG5lbnRzX2ZpcnN0X2NodW5rKSB7Cip0YWJs
ZS0+bmVudHMgPSB0YWJsZS0+b3JpZ19uZW50cyogPSBuZW50czsKIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2dfaW5pdF90YWJsZSh0YWJsZS0+c2dsLCBu
ZW50cyk7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAwOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KIMKgwqDCoMKgwqDCoMKg
IH0KCmFuZCBhbHNvIGluIF9fc2dfYWxsb2NfdGFibGU6CgoqbWVtc2V0KHRhYmxlLCAwLCBzaXpl
b2YoKnRhYmxlKSk7KgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==

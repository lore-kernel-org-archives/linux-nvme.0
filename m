Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08827C3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 16:10:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA85420714
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 16:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n4SJmzrA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="h8xEIN48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA85420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SyxKOpgUzMr1HVjDPLQgHfkPnkpmMuZVOsy0SunsTqo=; b=n4SJmzrAhzK6yWY/+dn5upkII
	iZdUbUTwpmqUpQiAxEDWHU99W21yzC+330wRLdVe3tKFsZmqZJXZCDVDefaEpcDhi/4C3mygYA0/I
	Oa+h3UcDnTeTfbMP2Wmtfbnol+A9gHaUcpIXWEI95vYJ7bcv7QUu4e6Vfkxdor/CATL1oQfDYIFWc
	HKVAYx8pRkMIrRWGTLAPiq0McEH1vqtgKNDSv491N+V9fpHAXUC0o5Fm53tn348nvBnoQpXkl/Q+n
	dVEKraB+heP8U6hnKCgwD87kjIZyb0cQLghboHdh66pfdA1NppOkDrRZKs9mUD6f/L6u5TF5I8vcg
	6Y5/AO9UA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGPfD-0001dD-Ta; Mon, 23 Mar 2020 16:10:55 +0000
Received: from mail-db8eur05on2045.outbound.protection.outlook.com
 ([40.107.20.45] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGPfA-0001cW-MQ
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 16:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boWiJTSp3VTVmPJEuS/MICiy02VIMbvJJc5FEJUNB9OWadLVc/wqv5S2Pi+Xt55k2v6VSuBZgvdf+QVdK3JZpPvEuKTTUHDZBOpQvBEKa88FyYqQOUR0pBhMkNAtrS5DWKstR06pbtsIvcH2/IxU65BNRN9DTANogpq3/XkS9otCmj7hpZcPbfDOJcGlw76MrTJN18LjxhkYfc1k2Wz1bh4YEOuVh3MC2IRyISaOsGYkF9vEDfoxEyP8a0QDE9bkAiJSktDm3dkGWvuZjiQW/pjbS29SjPZExg58xGtxIRnCUNGiGqjBPCkW/nQbP7TC2PLtKT1uAaBHyzFFLcKG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es6xylU8JMrqrr40KURvjos+dhShLiPlZNrJeMrV6Og=;
 b=Bp3vE40vuLSFMWx/ZDTD/7qsMt13cvWbwrpzFKwF2ST9HIEBjVkGiFX6UOfsMO3sY/swE3rCOSGYXMo3rWGCXnO7OOvDhhLOwzo4uSQxFEcEm+rTrpz+jWVWElLx9lWfw/vlhSx8QVhxfdQCPhPLYofBvWGPul588Yrub1hHpQ9OBtwhW+rktDr4T3YzcButVdKcn26dd5MmMcj5+mRqH5hnnnH5leBUi5Dqty8BgZRj2DpcERGhHPOA9FdQz0xv6gq6iJFviAUbvhlV/ROmPNmbVE0/ziA0YOvHzlbvyyPA80pA8dkEPUmSHqa0e86TJyEp/OnMT98Z2oGIj03e3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es6xylU8JMrqrr40KURvjos+dhShLiPlZNrJeMrV6Og=;
 b=h8xEIN48jVJB6524L5L+gSttPZIE94FJN9WuB/g+GZp8tjhNoGgLRolUcbNU+CSSuIEYC6lGlBey968G+aXkLi/ucPDDsx/jY7P30jUqeO2o5/sK7t8e9PjYbcgxd5f45q0CfgBVGILXCvRdp2VbCi1aiNsTLPsJDy+5ovxboxQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com (52.133.45.151) by
 AM0PR0502MB3874.eurprd05.prod.outlook.com (52.133.45.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Mon, 23 Mar 2020 16:10:48 +0000
Received: from AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe]) by AM0PR0502MB3905.eurprd05.prod.outlook.com
 ([fe80::d0df:a78a:c082:95fe%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 16:10:47 +0000
Subject: Re: [PATCH 3/6] nvme: Fix ctrl use-after-free during sysfs deletion
To: Christoph Hellwig <hch@lst.de>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
 <1584899989-14623-4-git-send-email-israelr@mellanox.com>
 <20200323073200.GB30302@lst.de>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <61aa8efb-67ab-e5a5-8802-61bf30ffa994@mellanox.com>
Date: Mon, 23 Mar 2020 18:10:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200323073200.GB30302@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:200:89::34) To AM0PR0502MB3905.eurprd05.prod.outlook.com
 (2603:10a6:208:1b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.14.112] (79.182.214.72) by
 AM4PR0202CA0024.eurprd02.prod.outlook.com (2603:10a6:200:89::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Mon, 23 Mar 2020 16:10:25 +0000
X-Originating-IP: [79.182.214.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8eed43d1-6f80-48d1-4925-08d7cf44b31f
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3874:|AM0PR0502MB3874:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB387415EB96C3EF8DFE5D8576D7F00@AM0PR0502MB3874.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(81166006)(81156014)(8676002)(478600001)(8936002)(54906003)(316002)(4744005)(16576012)(31686004)(53546011)(186003)(26005)(16526019)(107886003)(52116002)(2616005)(66946007)(66476007)(956004)(66556008)(6486002)(5660300002)(6916009)(2906002)(31696002)(86362001)(4326008)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0502MB3874;
 H:AM0PR0502MB3905.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xMdLY9aY4G6iDhhOnw0D0nNKAYcYR8ADJHvroC17Yd5p9iRzXkj7QlpbjGaaeEEvpC/rKI4uRiW7CicNWAzZ3+TN3Y+Gbt7I4IJqJuUlo1jsE/mA7lEV4L1Qi6yIKZDCb+Ju0zCC6Wo3w5nvRrWcwArtVjeR4dnFrlQAcLPPKbqA1H1mysL8Jac2+LCarTC6+6G5eDpbsNuLnaLyer4xbAWv6qW9a0bCeO/oxnQFWl88jY0N8wwtAElW0OqrTO2OOaRaT7rQEmGK+/WoaCFSkPFoeWqFyESoZcvql+EU4GpZhcafeP7mpDwgAsYp53YiBCU0P+X3EK3j1rBmv+P0mWlFswOj7V6i2M3uTCwZwCwKsL2kYYcj0muC7EbbqTftTzV4H8hoO1ioavEJZc8JzfrlFs/+rFZRzvOGfX3IrVPLlDZca3es3MOxD01kQxt
X-MS-Exchange-AntiSpam-MessageData: kwA8Br6c0F+AKzjTI5/W1lB6wTY9XzeR2hnfvLHp0TT4oUsBcEmie6VO+IZyK6Bzraosam5KnT1XyCATVBDp8mlbRSS0FjOk3cBUrgrAfIVvAaSN/2p4xsiAc0W7HpzX3F6haB1ifYSarmemv51WpQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eed43d1-6f80-48d1-4925-08d7cf44b31f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 16:10:26.8570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGhX6ts4TRRrsGb4fUl/UpSH5008DI1nUOPx8RApjKnMrkM/qp7mhvtDUOyCe+YocJURGZQgRM/Y9wnkh/6qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3874
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_091052_791985_211B72E0 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux-nvme <linux-nvme@lists.infradead.org>,
 Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8yMy8yMDIwIDk6MzIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
Cj4+IEBAIC0xNzEsNyArMTcxLDYgQEAgc3RhdGljIHZvaWQgbnZtZV9kb19kZWxldGVfY3RybChz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+PiAgIAludm1lX3JlbW92ZV9uYW1lc3BhY2VzKGN0cmwp
Owo+PiAgIAljdHJsLT5vcHMtPmRlbGV0ZV9jdHJsKGN0cmwpOwo+PiAgIAludm1lX3VuaW5pdF9j
dHJsKGN0cmwpOwo+PiAtCW52bWVfcHV0X2N0cmwoY3RybCk7Cj4gQ2FuIHlvdSBwbGVhc2Ugc3Bs
aXQgdGhlIGNoYW5nZSB0byBjYWxsIG52bWVfcHV0X2N0cmwgZnJvbQo+IG52bWVfdW5pbml0X2N0
cmwgaW50byBhIHNlcGFyYXRlIGNsZWFudXAgcGF0Y2ggYWZ0ZXIgdGhpcyBvbmU/CgpTdXJlLCBJ
IGNhbiBzcGxpdCBpdC4KClRvIGRvIHRoYXQgSSBuZWVkIHRvIGFkZMKgIG52bWVfcHV0X2N0cmwo
KSBhdCBtb3N0IG9mIHRoZSBlcnJvciBmbG93cyAKbGlrZSB0aGlzOgoKQEAgLTIwNTQsNiArMjA1
Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZV9jdHJsIAoqbnZtZV9yZG1hX2NyZWF0ZV9jdHJsKHN0
cnVjdCBkZXZpY2UgKmRldiwKIMKgb3V0X3VuaW5pdF9jdHJsOgogwqDCoMKgwqDCoMKgwqAgbnZt
ZV91bmluaXRfY3RybCgmY3RybC0+Y3RybCk7CiDCoMKgwqDCoMKgwqDCoCBudm1lX3B1dF9jdHJs
KCZjdHJsLT5jdHJsKTsKK8KgwqDCoMKgwqDCoCBudm1lX3B1dF9jdHJsKCZjdHJsLT5jdHJsKTsK
IMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgPiAwKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IC1FSU87CiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUihyZXQpOwoKClRo
ZXJlIGFyZSBkb3VibGUgY2FsbHMgdG8gbnZtZV9wdXRfY3RybCgpIGF0IHRoZSBlcnJvciBmbG93
cyBhdCByZG1hLCAKdGNwLCBmYyBhbmQgbG9vcC4KCkkgd2lsbCByZW1vdmUgdGhvc2UgYXQgdGhl
IG5leHQgcGF0Y2guCgpJcyB0aGF0IE9LPwoKPgo+IFRoZSByZXN0IGxvb2tzIGdvb2QgdG8gbWUu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1u
dm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

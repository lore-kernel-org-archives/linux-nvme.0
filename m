Return-Path: <SRS0=UxdA=3Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BEC2D0DB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 17:18:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910B121739
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pk0wLC55";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CXPO5D2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910B121739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X70JCrtskBGpeA2NchFv8xtWVKQ7f5DDp1SvO+bLuLg=; b=Pk0wLC55lW3xxp/yQKgYQaXLT
	/x6CvmiLjX3VseBvroTl7b5nOwTeAbaYergVrRn862KnkQ4nSK1Cc6mGiR360mxvKf9wAorMNKZxT
	t15jEeFtlMtDaqE0tz+GXW/U3Eb1wU5uC3W3dLhSJL4K3Tvl9A3V5bWsFc9pBXRuEyG9JpDbMZaUp
	DUdLcaneBVH7vQup7FWoEQg5w8e/ZbxQBhvAKfVqLIKclAz66le/3jiL9Ii5HAFdEX4toqBz6GUdf
	YKTVimj2FF225nooqqX8ZbSwAKq6IcFmGsnlCPZawPNCT01cfXfu60WGHclnkwF1c1jPLAWt9Vf6b
	WltmH4fsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iw81N-0001a4-Fh; Mon, 27 Jan 2020 17:17:57 +0000
Received: from mail-am6eur05on2086.outbound.protection.outlook.com
 ([40.107.22.86] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iw81K-0001YT-7S
 for linux-nvme@lists.infradead.org; Mon, 27 Jan 2020 17:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXA+LxiDOCsi9Le8Fjqz+VJ1sV6+/1ufpOlHEOGHEfJlBCY1yb7tvLK/k26kdK0TJhOE0s8xTYeodD2wuDxiGlsV9AsMS4Ld3aN27gajVC/vWOXuUc10ffNmKtG4ZEPhRF6gnOdxhRm0MSRUnjpyHGZRYWrZZZQdR7YuLUehtVa4LJPse81n9Nx2Sx8N2q5zGojGPUsHEvk9AvJKRXEGO8CI/tVuq07GIcwlIq24YUoSKLe+96eNpdVW9ueQHLjiCYZ/o9kSDyaF8iMqa9hdRRmy1i+mNICFUWq2wjjHkB8+g0klvWAUAnCC5AGXvfNGbIhP/1KkQhD+xs/8G1alSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBGCsKcXjOQtuGXjff4Vq1TNlvwbbuLqmlcq1Rh2vgs=;
 b=RZuNbWhQF18re6MSquypqdyT1gbduRyt5oNqyrGUd/lLnm6gbCL3u6d6Tgc6wnSRN21dLIjNYvSY+LhoPb4xqomjOzSOhnQ9MOOg+HuJx1RP/7eh8fnD4e0tReuGoPGU79SuSB0IsaOXTkxZ8QoNHW+R3DrlLkkbgqcyxPavcl/23a+bm8skCPXUEKukE2MTTT9V+OoWKpr4+nNPl/DqjcBBagsk2Qwmm1jiZ7uZ0pg9il+WfBNB+7kowLQgwehn8awOIoHen3UCwDcaIbolBHlIuY4QJpONfvhpuTILOi+7kiCt/3P08nwBP0GhSJ6cNv5aWRLyZTu+XDfgagFLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBGCsKcXjOQtuGXjff4Vq1TNlvwbbuLqmlcq1Rh2vgs=;
 b=CXPO5D2tyjlmr4vRvt2HJNnG/Xj7eh2bQ3h9shY9DABy4GklDgySSHvfVbHyveAeKPIEPSbaLHr9SV7TBkF8nF1tFwbQ5otjh4VfJv8NcX2ng59ld3r/uKO9xtAKKQLPtD2bQ8w1AH+X0uwCDLc17+ekkFICo6ETC3f48dj7EYk=
Received: from AM6PR0502CA0048.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::25) by VI1PR0502MB3983.eurprd05.prod.outlook.com
 (2603:10a6:803:1a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Mon, 27 Jan
 2020 17:17:49 +0000
Received: from DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by AM6PR0502CA0048.outlook.office365.com
 (2603:10a6:20b:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Mon, 27 Jan 2020 17:17:49 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT055.mail.protection.outlook.com (10.152.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2665.18 via Frontend Transport; Mon, 27 Jan 2020 17:17:49 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 27 Jan 2020 19:17:48
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 27 Jan 2020 19:17:48 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 27 Jan 2020 19:17:30
 +0200
Subject: Re: [PATCH 13/15] nvmet: Add metadata/T10-PI support
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-15-maxg@mellanox.com> <yq1sgkpxqf5.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <99c92a01-be7b-fd47-3d28-b75e5372c3a6@mellanox.com>
Date: Mon, 27 Jan 2020 19:17:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <yq1sgkpxqf5.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(70586007)(336012)(8676002)(8936002)(478600001)(54906003)(2616005)(26005)(31686004)(356004)(316002)(31696002)(16576012)(86362001)(81156014)(4326008)(81166006)(36756003)(107886003)(53546011)(5660300002)(6916009)(186003)(16526019)(70206006)(2906002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0502MB3983; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f22520-d5fb-4134-e9ce-08d7a34cd5be
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3983:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB3983CD889CAE23F7F221DBE9B60B0@VI1PR0502MB3983.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02951C14DC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZiW4NWB6UW+nKxjpuTweL9uVWO3MT2zMNBB1O89V36bR3dXhGxc6b8qxfEGASLQqduZ8fsSdglLm+Wxtho4xwbAhH/VOwaNcobkV+jPs3lyxov3wKkN+/5ghLjsBaDzpATgXn9sHtjJ73V6s2vO9SPAOTXJKWbn1ThDLsOCB9f8dAx0of9RS9Xn7ylzaGLe4eRpS4jSjn3IgHK6gPQTzjfuTWg1GXho3qkUCInbBsk5LKLynwoDV2n8LaRThVI4P21CUcrD0IpxAzAJapgczSVdMmtIsSY3e8fcCb/BgMT6rGn5xwMjW3xCMCrsqmaIUbh1+qeD1Si5BVjCId6V2cdkaAkPIyFwkQhcY4rmZabXHNA2IVRPbX9TVs89VpXMukmS9N9e9kBKRBMjh3HqIBZJfKtDlSfbAui5KiVA5sMKaB9zbzq1v6FeyEPW3lafxsoHAxXCguhkgUH9I5CedRJa9m3yOjrnOJ2W6ZEB9uZWWgwETBArXjq8Ee2VOGbK
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 17:17:49.3313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f22520-d5fb-4134-e9ce-08d7a34cd5be
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3983
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200127_091754_505967_0A534D3E 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, vladimirk@mellanox.com,
 shlomin@mellanox.com, israelr@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDEvOS8yMDIwIDU6MjQgQU0sIE1hcnRpbiBLLiBQZXRlcnNlbiB3cm90ZToKPiBNYXgsCgoK
TWFydGluLAoKCj4KPj4gLQkvKiBubyBsaW1pdCBvbiBkYXRhIHRyYW5zZmVyIHNpemVzIGZvciBu
b3cgKi8KPj4gLQlpZC0+bWR0cyA9IDA7Cj4+ICsJLyogTGltaXQgTURUUyBmb3IgbWV0YWRhdGEg
Y2FwYWJsZSBjb250cm9sbGVycyAoYXNzdW1lIG1wc21pbiBpcyA0aykgKi8KPj4gKwlpZC0+bWR0
cyA9IGN0cmwtPnBpX3N1cHBvcnQgPyBpbG9nMihOVk1FVF9UMTBfUElfTUFYX0tCX1NaID4+IDIp
IDogMDsKPiBbLi4uXQo+Cj4+ICsjZGVmaW5lIE5WTUVUX1QxMF9QSV9NQVhfS0JfU1ogMTI4Cj4g
V2hlcmUgZG9lcyB0aGlzIGxpbWl0IGNvbWUgZnJvbT8KClRoaXMgaXMgY29taW5nIGZyb20gZmV3
IHJlYXNvbnM6CgoxLiBJbiB0aGUgY3VycmVudCBkcml2ZXIgaW1wbGVtZW50YXRpb24gb2YgdGhl
IGliX2NvcmUgKFJETUEpIHdlIGFyZSAKbGltaXRlZCB0byAxTUIgSU8gZm9yIFQxMC1ESUYgb2Zm
bG9hZCBzbyB3ZSBuZWVkIHRvIGxpbWl0IHRoZSBtZHRzIAphbnl3YXkuIEZvciB0aGF0LCBJIHdh
bnQgdG8gYWRkIGEgY3RybC0+b3BzLT5nZXRfY3RybF9tZHRzKGN0cmwpLgoKMi4gVGhlcmUgaXMg
c29tZSB1bmNsZWFyICh0byBtZSkgYmVoYXZpb3IgaW4gdGhlIGJsb2NrIGxheWVyIHJlZ2FyZGlu
ZyAKc3BsaXR0aW5nIGludGVncml0eSBiaW9zLiBXZSBnZXQgZ3VhcmQgZXJyb3Igb3ZlciB0aGUg
ZmFicmljIHRyYW5zYWN0aW9uIAppbiBjYXNlIHdlIG5lZWQgdG8gc3BsaXQgYSBiaW8gKHRoZSBl
cnJvciBpcyBhdCB0aGUgdGFyZ2V0IHNpZGUpLiBJJ20gCmRlYnVnZ2luZyBpdCBhbmQgZm91bmQg
cG90ZW50aWFsIGJ1ZyB0aGF0IEkgZml4ZWQgdXNpbmc6CgpAQCAtMzc4LDYgKzM3OCwxMiBAQCB2
b2lkIGJpb19pbnRlZ3JpdHlfYWR2YW5jZShzdHJ1Y3QgYmlvICpiaW8sIAp1bnNpZ25lZCBpbnQg
Ynl0ZXNfZG9uZSkKCiDCoMKgwqDCoMKgwqDCoCBiaXAtPmJpcF9pdGVyLmJpX3NlY3RvciArPSBi
eXRlc19kb25lID4+IDk7CiDCoMKgwqDCoMKgwqDCoCBidmVjX2l0ZXJfYWR2YW5jZShiaXAtPmJp
cF92ZWMsICZiaXAtPmJpcF9pdGVyLCBieXRlcyk7CisKK8KgwqDCoMKgwqDCoCBpZiAoc3BsaXQg
JiYgYmlwLT5iaXBfaXRlci5iaV9idmVjX2RvbmUpIHsKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYmlwLT5iaXBfdmVjW2JpcC0+YmlwX2l0ZXIuYmlfaWR4XS5idl9sZW4gLT0gCmJpcC0+
YmlwX2l0ZXIuYmlfYnZlY19kb25lOworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaXAt
PmJpcF92ZWNbYmlwLT5iaXBfaXRlci5iaV9pZHhdLmJ2X29mZnNldCArPSAKYmlwLT5iaXBfaXRl
ci5iaV9idmVjX2RvbmU7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJpcC0+YmlwX2l0
ZXIuYmlfYnZlY19kb25lID0gMDsKK8KgwqDCoMKgwqDCoCB9CiDCoH0KCmJ1dCB1bmZvcnR1bmF0
ZWx5IGl0IGhlbHBlZCBvbmx5IGlmIHdlIHNwbGl0IHRoZSBiaW8gb25jZS4gSW4gY2FzZSB3ZSAK
c3BsaXQgaXQgbW9yZSB0aGFuIG9uY2UsIHdlIGdldCB0byBndWFyZCBjaGVjayBlcnJvciBhZ2Fp
bi4KCm1heWJlIHlvdSBoYXZlIGFuIGlkZWEgaG93IHRvIG92ZXJjb21lIHRoaXMgPwoKCjMuIFRo
ZSBtYXhpbXVtX2ludGVncml0eV9zZWdtZW50cyA9IDEgZm9yIE5WTWUgZGV2aWNlcywgc28gd2Ug
Y2FuIHVzZSAKNDA5Ni84PTUxMiBpbnRlZ3JpdHkgc2VjdG9ycyBiZWZvcmUgcmVhY2hpbmcgdGhl
IGxpbWl0IG9mIAptYXhfaW50ZWdyaXR5X3NlZ21lbnRzLiBUaGlzIGxlYWRzIHRvIG1kdHM9NiAo
MjU2S0IpIGlmIHRoZSBicz01MTIgLiBJJ20gCmFmcmFpZCB0aGF0IHdlIG1pZ2h0IGhhdmUgaXNz
dWVzIHdpdGggdGhlIGZhY3QgdGhhdCB0aGUgdGFyZ2V0IHByb3Rfc2dsIAogPiAxIGFuZCB0aGUg
TlZNZSBkcml2ZXIgc2V0IG1heGltdW1faW50ZWdyaXR5X3NlZ21lbnRzID0gMS4KCgpUaGVyZWZv
cmUsIEkgc3VnZ2VzdCB0byBsaW1pdCB0aGUgbWR0cyBwZXIgdHJhbnNwb3J0IChhbmQgaW50ZXJu
YWxseSAKY2hlY2sgaWYgdGhpcyBjdHJsIGlzIHBpX2VuYWJsZWQpLgoKCkFsbCB0aGUgYWJvdmUg
aXMgaGFwcGVuaW5nIHdoZW4gdXNpbmcgc3VibWl0X2JpbyAtLT4gLi4uIC0tPiBiaW9fc3BsaXQg
CmZ1bmN0aW9uIHRoYXQgY2FsbCBiaW9fYWR2YW5jZSBhcyB3ZWxsICh0aGF0IGlzIGNhbGxlZCBm
cm9tIGNvbXBsZXRpb24gCmNvbnRleHQgYXMgd2VsbCkuIFRoaXMgcGF0aCBpcyBub3QgdXNlZCBp
biBsb2NhbCBOVk1lIElPLgoKSW4gdGhlIGxvY2FsIE5WTWUgSU8gKGUuZyB1c2luZyBGSU8gYXBw
bGljYXRpb24pLCB0aGVyZSBpcyBubyBjYWxsIHRvIApiaW9fc3BsaXQvYmlvX2FkdmFuY2UgaW4g
dGhlIHN1Ym1pc3Npb24gZmxvdywgYW5kIHRoZXJlIGlzIG9ubHkgb25lIGNhbGwgCnRvIGJpb19h
ZHZhbmNlIGluIHRoZSBjb21wbGV0aW9uIGZsb3cuCgoKLU1heC4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdAps
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

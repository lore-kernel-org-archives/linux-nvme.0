Return-Path: <SRS0=ACpZ=Y7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EAFC5DF60
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 12:03:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89CA2187F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 12:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XTEFYZMo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CyJ1btMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89CA2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IYtuYqlEtJ2ToiyYvZd7J7tny1su/xpky2QYd1e0Fso=; b=XTEFYZMou/OTLXl6hxahy+M78
	2WYOKbAJ16XYchPEFtizsbGVgqW4/hu99OyjyHx+xUjd9DB5M/pzrpWc1npBjVJ/snxh5mivcxUTV
	wjuJozll/ns7ukdS073aRDU5WaUhOlQpgxBxSIxJeJkJRf5AHvzZADjYfKsJ54X8kU/gotLbHIzzI
	AJO+u0PHgCqlSXih32A1to+SiV/nXZgP2TY2dUm5isuz0LvG+Pj4J042ZRPIHqIso47b1BN9l+7oZ
	lqMUU5XLSmsJu2A23WxGFo+stmyFV+KFZGpqcQYvUnnQnitgzywd7kItOYC1HClOWQBa3+7z83Iy4
	K+pVteekg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSgVy-0004f7-Lf; Thu, 07 Nov 2019 12:03:50 +0000
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSgVu-0004dx-Uo
 for linux-nvme@lists.infradead.org; Thu, 07 Nov 2019 12:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGBbv+smcmux25S/nwyuF/AZJySI6wfeiAlFgjBoB8SzrPqTIktfGimp4BWKyiuzYlwu27480/of10xsnyqNHZT61KiXWVlOcXrnkKTEdLZvgKsAxrxDB8hArwKH59OqgSRr0a+0asp6y3/FZbYf3/sVXDK4knMp0zlDJ6vDI8ESATAyl5XBG/U5XMxD28pdm7NeZmOdTJixQVRSV2wRYcBjGFrOq8o9BYfAm1fXVFfo7QEcTUfTAwoV7hIZWPaIpjLgwQGxuiyYvugkT5QKnEeOjExgXypm/UCipxJpnrbe6REhc4wPwdLUL5aULtTPXAisDodJ+4EZOWIVEzp73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBqTcaoNERqKCQCgKz3/3MK+HCCKXyZfX4iE3yr0zEw=;
 b=PV3i6xeh8t5WB6SqzMgYZKJodO8P244IyB+3TvCQtSL9OekR7brYjWxT14pvP99WTIcBr+Ngsu/Nzuy3cHz9xlwJg3WCFGufre6e0lUuwX97m1kp8SWxTVy1ekbjAKfhRFTL6Vpc7VSnGVXgwgQSU0q2hrmbrngXFYcLaGfaIv1Uw3cqJL2mHfD+Po57+bNrX6TMMtbbWbJhx5/t2UyMG/ZDSF2uSqeGA9+LGfZiydi3njG9/J0cs/PliTegS5t6/Xg3SpIK2QJS/yM21O0G19Mhw3TfOKoZR9wohE0+/MGCfBXInDBgAi4g2MMnOIicS5CLC6AqjBr89NANR6Dp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBqTcaoNERqKCQCgKz3/3MK+HCCKXyZfX4iE3yr0zEw=;
 b=CyJ1btMMg2EI9UB3PpdEFNgCIVtdPVIhTn3HvFS7Tslc/W6vMZwzvja8AckRDeO7K3tVwIvszS4D0hq249FwvuLHxS2PxAi9lnYTRayWlYxq59Z5RBgg4TEvNtvwMOsbdhTH8kKgvb1785J4i1Hfq3tQ1mJY7XD7ODModtUmSE0=
Received: from HE1PR05CA0132.eurprd05.prod.outlook.com (2603:10a6:7:28::19) by
 HE1PR05MB3324.eurprd05.prod.outlook.com (2603:10a6:7:37::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 12:03:41 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by HE1PR05CA0132.outlook.office365.com
 (2603:10a6:7:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.23 via Frontend
 Transport; Thu, 7 Nov 2019 12:03:41 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 12:03:40 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 7 Nov 2019 14:03:40
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 7 Nov 2019 14:03:40 +0200
Received: from [172.16.0.217] (172.16.0.217) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 7 Nov 2019 13:58:23
 +0200
Subject: Re: [PATCH] nvme-cli/fabrics: Add pi_enable param to connect cmd
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-2-maxg@mellanox.com> <yq15zjwza2y.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ed926da1-1466-edbd-6fa3-fb828bf455cc@mellanox.com>
Date: Thu, 7 Nov 2019 14:02:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq15zjwza2y.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.16.0.217]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(78124002)(189003)(199004)(2870700001)(65956001)(65806001)(16576012)(70586007)(58126008)(8936002)(4326008)(31696002)(70206006)(6246003)(86362001)(81166006)(356004)(5660300002)(6916009)(81156014)(126002)(2616005)(476003)(229853002)(11346002)(446003)(486006)(305945005)(2906002)(7736002)(76176011)(316002)(50466002)(478600001)(26005)(47776003)(6666004)(23676004)(336012)(8676002)(54906003)(6116002)(106002)(36756003)(186003)(3846002)(53546011)(2486003)(16526019)(31686004)(36906005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR05MB3324; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd92525b-8cf5-45b7-3957-08d7637a87ae
X-MS-TrafficTypeDiagnostic: HE1PR05MB3324:
X-Microsoft-Antispam-PRVS: <HE1PR05MB332447C09F694DA1B86E2193B6780@HE1PR05MB3324.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3EmtlC0TdykvZY+K97Qb/mNI2HolnB1SQbc4mLZpsML0RBQpSYhwWGgsuN5jFTkCrxGQKU67LCd9bl/zMoAjm/1p3RZczskfc3r6iTh1NMM/ktZef7Awac+ZX+4Fr5pqliweRCOdH8pykXydgtWNFBbDB2IDRaMZ7TxNk/gGxGY63RIVclQVcqqQnAbi5GevMeHkLMtxblbmMfe83k2YZa9tvocV+RcpV0kFlVBZzSr1dAsx1XIA/VOIFprZjbcQWZZJ/SRr0PoKLGz8i9zF4I1jfVn3sIuCQeN/XMgM0VmLfVYb31zk6LJFlBRKZVwfIbSrgNpnA5IR2UXMtpETDjsB7HZ1sUdczlJoCjGGt4ec9K//MBiBGGyrAAoxe+7NzieQXaIGSL2bIQ5urAMiZH7bWpfqE02x+o9oYT2DHYmHf9IW25gTxIdVa94hmbC
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 12:03:40.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92525b-8cf5-45b7-3957-08d7637a87ae
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3324
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_040347_048062_AE3F709C 
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDExLzcvMjAxOSA0OjM2IEFNLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3JvdGU6Cj4gSGkgTWF4
LAoKSGkgTWFydGluLAoKPgo+PiBBZGRlZCAncGlfZW5hYmxlJyB0byAnY29ubmVjdCcgY29tbWFu
ZCBzbyB1c2VycyBjYW4gZW5hYmxlIG1ldGFkYXRhCj4+IHN1cHBvcnQuCj4+Cj4+IHVzYWdlIGV4
YW1wbGVzOgo+PiBudm1lIGNvbm5lY3QgLS1waV9lbmFibGUgLS10cmFuc3BvcnQ9cmRtYSAtLXRy
YWRkcj0xMC4wLjEuMSAtLW5xbj10ZXN0LW52bWUKPj4gbnZtZSBjb25uZWN0IC1wIC10IHJkbWEg
LWEgMTAuMC4xLjEgLW4gdGVzdF9udm1lCj4gV2h5IGRvZXMgaXQgaGF2ZSB0byBiZSBleHBsaWNp
dGx5IGVuYWJsZWQ/IEkgY2FuIHVuZGVyc3RhbmQgd2h5IHlvdSdkCj4gd2FudCB0aGUgY2FwYWJp
bGl0eSB0byBkaXNhYmxlIFBJIGluIGNhc2UgeW91IGVuY291bnRlciBhIGJhZCB0YXJnZXQuCj4g
QnV0IGhhdmluZyB0byBvcHQtaW4gaXMgZGlmZmVyZW50IGZyb20gaG93IHRoZSByZXN0IG9mIHRo
ZSBibG9jawo+IGludGVncml0eSBjb2RlIHdvcmtzLiBJbiBTQ1NJLCBpZiBIQkEgYW5kIHRhcmdl
dCBhcmUgY2FwYWJsZSwgYm90aCBESVgKPiBhbmQgUEkgZW5hYmxlZCB1bmxlc3MgeW91IGV4cGxp
Y2l0bHkgZGlzYWJsZSB0aGVtLgoKSW4gU0NTSS9pU0VSIHNvbHV0aW9uICh0aGUgb25seSBzb2x1
dGlvbiBvdmVyIHRoZSBmYWJyaWMgaW4gTGludXgpIHRoZXJlIAppcyBhIG1vZHVsZSBwYXJhbSB0
byBlbmFibGUgdGhlIGluaXRpYXRvciBzaWRlLgoKSSBndWVzcyBpdCB3YXMgaW1wbGVtZW50ZWQg
dGhpcyB3YXkgc2luY2UgcGVvcGxlIGRvbid0IHdhbnQgdG8gbWVzcyAKd2l0aMKgIGlzY3NpLWRh
ZW1vbi4KClNvIGlTRVIgd2lsbCBjcmVhdGUgYSBzaWduYXR1cmUgcmVzb3VyY2VzIGZvciBldmVy
eSBjYXBhYmxlIGRldmljZSBhbmQgCmNvbm5lY3Rpb24gd2l0aG91dCBnaXZpbmcgdGhlIHVzZXIg
dGhlIHBvc3NpYmlsaXR5IHRvIGRpc3Rpbmd1aXNoIApiZXR3ZWVuIG5lZWRlZCBQSSBjb250cm9s
bGVycyBhbmQgdW4tbmVlZGVkIFBJIGNvbnRyb2xsZXJzLgoKV2UgZG9uJ3QgaGF2ZSBhIGZvcm1h
dCBjb21tYW5kIGluIHRoZSBmYWJyaWNzIHNvIHRoaXMgaXMgdGhlIGJlc3Qgb3B0aW9uIAp3ZSBj
YW4gdGhpbmsgb2YgZm9yIGFkZGluZyBmbGV4aWJpbGl0eSB0byB1c2Vycy4KCkkgc3Bva2Ugd2l0
aCBDaHJpc3RvcGggYWJvdXQgdGhlIG1vZHVsZSBwYXJhbSBwb3NzaWJpbGl0eSBhbmQgd2UgYm90
aCAKYWdyZWVkIGl0J3Mgbm90IHRoZSB3YXkgdG8gZ28uCgpMZXQgbWUga25vdyBpZiB5b3UgaGF2
ZSBhbiBpZGVhIHRoYXQgd2lsbCBlbmFibGUgZmxleGliaWxpdHkgdG8gdXNlcnMuCgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

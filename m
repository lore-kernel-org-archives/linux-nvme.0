Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC5EC3F2D7
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 22:59:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AE020801
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 22:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SlzfoFyL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="SEwBOMCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AE020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XeLS4UGD+HquKyD92uJpgmLzjb/POmFQJH5FT4rZj9s=; b=SlzfoFyLGqE/9XFIKiDL7UCbQ
	NeEnDX4EEYmkhjeyuakI383pEJsgUMUUZyIFwcQMJE43rDEc2nDI6fggtpV/AcDMTy//8DsKTgyR3
	KTJ2lKXhc1UNeQNPJaThYIcLWHLucy6c3/TpVYdxkdagTk6VH1KsQfRncReiNcqE7lVnPm+9bNeEm
	zLzKYyA/ECHze8yuzRjCr4nmdbbMtCvf9Ub2NBHTQVOG/CutVqAxQXX+WqXlKYjuS4cmaVigSS6+v
	VQCg5DmiV9PXSiduRcnwLhsJLff06ZMQDMsdqalzDkaCcqdgsAYHzTIhvaPca9q8Eunpfd28ti9Iw
	3d8SHWxtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9zSq-0004WJ-5m; Thu, 05 Mar 2020 22:59:36 +0000
Received: from mail-am6eur05on2072.outbound.protection.outlook.com
 ([40.107.22.72] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9zSl-0004VY-TH
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 22:59:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdAavn/rvjfyaX6mL5ubkWN7vPc3uFPR1JsepF4XQUuiM7M3uHn/hzw2Uchr0YqzwW5rOpZvWKoJ1j+QC11/hymbe8qgKs/YVuSoqsu5rQxXS8DnK0eAF/K6cA04TXYOmy0IcWtWKurC+IBnJijlpPToSUtso0V0gH+un8EknYNweMM/XH8xD4ZCDa0E7EOL613unUKdiVHD1UaQ7y9ep20XndZ4q0zMD1qW7ZDtakUquqNj889jnMDMvoZu282W0K21BZ53OS6Wq462I1nnrzE7BIi5M342aahiltV5hUsP8uRMD2p2w4hZUcNjAT1duuwFMqaZ6K1zH+maOlSxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kceMzJW4gCWMswe60GuvPD3TZ/SYqhmWyuvbQHqBxhU=;
 b=Er50MjX37Jdy1+NBmYvKOvGGIE4KgO/jWlt6hzmnZiFq+obzJkUPnfkw7uyOOBq1Do2XIbfuIGA33fEPg0sJBTGcEGaXRtb/sgknkpt0huuZfXYuleUbmP2noJddCBDlwKZFgJFrDK2b0mZEv52HREAMNAiX5q06Yi68mwC7ElaCKB2C5K8984Zrz2t5kUpPocaUai9SdceErrCry+Tp+Q2ocEyDlAu9uUh0F8ncIGuDxaiJd1ZF+r7yU+elcEYtpGk6wPjpJu0dCgVt39E2qps8ol/k2r5+EaYTMbatxo6CTpPGm1pP7Pu86dHkwvxWyTggPIl6gR/7OFNFPS8Jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kceMzJW4gCWMswe60GuvPD3TZ/SYqhmWyuvbQHqBxhU=;
 b=SEwBOMCDzdm+2LZekCtbslQ1fIvDTD6EUcNB1zsJ/N4ibiIYebbayGLHU60lMp7MRcEqRjLcLnlSVN0Pb2uPCONfr0HHC0SLMJR6U1gXRlVQLw31B4yzrkKwx43xuG4G2SV1Yp4TwA4+9QVSOWbH6rUCCylfrGKxvX1aIS1GjfI=
Received: from AM5PR0602CA0005.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::15) by VI1PR05MB4702.eurprd05.prod.outlook.com
 (2603:10a6:802:5b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 5 Mar
 2020 22:59:24 +0000
Received: from VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::52) by AM5PR0602CA0005.outlook.office365.com
 (2603:10a6:203:a3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Thu, 5 Mar 2020 22:59:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT015.mail.protection.outlook.com (10.152.18.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 22:59:23 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 6 Mar 2020 00:59:22
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 6 Mar 2020 00:59:22 +0200
Received: from [172.27.0.3] (172.27.0.3) by MTLCAS01.mtl.com (10.0.8.71) with
 Microsoft SMTP Server (TLS) id 14.3.468.0;
 Fri, 6 Mar 2020 00:59:01 +0200
Subject: Re: [PATCH V2 3/3] nvmet-rdma: allocate RW ctxs according to mdts
To: Sagi Grimberg <sagi@grimberg.me>, <jgg@mellanox.com>,
 <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <Chaitanya.Kulkarni@wdc.com>
References: <20200305095530.132858-1-maxg@mellanox.com>
 <20200305095530.132858-3-maxg@mellanox.com>
 <c776b5bc-8b7c-ce8a-19a8-4a0ec976d923@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5e905274-385e-58a6-6e1a-9da005a4af1e@mellanox.com>
Date: Fri, 6 Mar 2020 00:59:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c776b5bc-8b7c-ce8a-19a8-4a0ec976d923@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.0.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(4326008)(478600001)(53546011)(36756003)(2616005)(70206006)(5660300002)(336012)(26005)(70586007)(31686004)(16526019)(186003)(81156014)(81166006)(8936002)(8676002)(2906002)(86362001)(356004)(16576012)(31696002)(110136005)(54906003)(316002)(36906005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4702; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a0b0bd-1cfc-40b9-d81d-08d7c158d932
X-MS-TrafficTypeDiagnostic: VI1PR05MB4702:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4702DB26658735302FEEA26EB6E20@VI1PR05MB4702.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fM1Wgh9LV3jdcOY+xSBDeXUDjNkr978uQry57qj5PiBUWkggyZwhMD50DYTOYH5PoGG2/3C6N3lSGuuhvtIJsA9UrfW5l5mDlhCJoXeFt8N0v/6WXeZii3Tca72TwZV6LYs53pAAH3N8Q8xlko1P/6K8tk8nSL+wnpZyRWxrlSZBevUNZOZl+GDaOmGtOwrMoaeFs+qgVNayshQFZBdhDCXO6cuw36ac8S+0JkMKQtPavwiQY+WWSdcrYvFZWic8WUq9DWlBO6KFSA/oTFik+k0CeBxTyKxLcp1mXFfNNwq5VJmh/799SHytHWvCl7UqtRGYU6ZLKdK6jbQpInXP5KiZgOcnQuw3D0Qh/km8ytYL83FtFwFE2s+4/cnqzqzgiLG6tCGbkOxOglQbm8B/IK12cSrmrBdOfx/ruF0NGmzrj4L+6TCkdpFNBcz+wClE3k45hj4pVatO4dn2/t1FgPAMuB9LERJUKdprOFnFbE3rDiejGsiDSVy1bu0sUhjo
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 22:59:23.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a0b0bd-1cfc-40b9-d81d-08d7c158d932
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4702
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_145932_001392_F14551DA 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: krishna2@chelsio.com, bharat@chelsio.com, nirranjan@chelsio.com,
 bvanassche@acm.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvNS8yMDIwIDEwOjQ5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRt
YS5jCj4+IGluZGV4IGQxMmVmMGQuLmRhYWI2NTYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZt
ZS90YXJnZXQvcmRtYS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jCj4+IEBA
IC05NzYsNyArOTc2LDcgQEAgc3RhdGljIGludCBudm1ldF9yZG1hX2NyZWF0ZV9xdWV1ZV9pYihz
dHJ1Y3QgCj4+IG52bWV0X3JkbWFfcXVldWUgKnF1ZXVlKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IGliX3FwX2luaXRfYXR0ciBxcF9hdHRyOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBudm1l
dF9yZG1hX2RldmljZSAqbmRldiA9IHF1ZXVlLT5kZXY7Cj4+IC3CoMKgwqAgaW50IGNvbXBfdmVj
dG9yLCBucl9jcWUsIHJldCwgaTsKPj4gK8KgwqDCoCBpbnQgY29tcF92ZWN0b3IsIG5yX2NxZSwg
cmV0LCBpLCBmYWN0b3I7Cj4+IMKgIMKgwqDCoMKgwqAgLyoKPj4gwqDCoMKgwqDCoMKgICogU3By
ZWFkIHRoZSBpbyBxdWV1ZXMgYWNyb3NzIGNvbXBsZXRpb24gdmVjdG9ycywKPj4gQEAgLTEwMDks
NyArMTAwOSw5IEBAIHN0YXRpYyBpbnQgbnZtZXRfcmRtYV9jcmVhdGVfcXVldWVfaWIoc3RydWN0
IAo+PiBudm1ldF9yZG1hX3F1ZXVlICpxdWV1ZSkKPj4gwqDCoMKgwqDCoCBxcF9hdHRyLnFwX3R5
cGUgPSBJQl9RUFRfUkM7Cj4+IMKgwqDCoMKgwqAgLyogKzEgZm9yIGRyYWluICovCj4+IMKgwqDC
oMKgwqAgcXBfYXR0ci5jYXAubWF4X3NlbmRfd3IgPSBxdWV1ZS0+c2VuZF9xdWV1ZV9zaXplICsg
MTsKPj4gLcKgwqDCoCBxcF9hdHRyLmNhcC5tYXhfcmRtYV9jdHhzID0gcXVldWUtPnNlbmRfcXVl
dWVfc2l6ZTsKPj4gK8KgwqDCoCBmYWN0b3IgPSByZG1hX3J3X21yX2ZhY3RvcihuZGV2LT5kZXZp
Y2UsIHF1ZXVlLT5jbV9pZC0+cG9ydF9udW0sCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMSA8PCBOVk1FVF9SRE1BX01BWF9NRFRTKTsKPgo+IE1heWJlIEknbSBtaXNz
aW5nIHNvbWV0aGluZywgYnV0IGFyZW4ndCB5b3UgbWlzc2luZyB0aGUgbXBzbWluCj4gbXVsdGlw
bGllcj8geW91ciBtYXhwYWdlcyBpcyBub3QgKDEgPDwgOCkgYnV0IHJhdGhlciAoMSA8PCAyMCkg
aXNuJ3QgaXQ/Cgp3aHkgPwoKd2Ugc3VwcG9ydCAyNTYgcGFnZXMgd2l0aCA0S0Igc2l6ZSBlYWNo
IHRvIGdldCAxTUIgIm1kdHMiLgoKVGhlIGZhY3RvciBpcyBpbiB1bml0cyBvZiBSVyBhcGkgY29u
dGV4dCAodGhhdCBtaWdodCBsaW1pdCB0aGUgc2l6ZSBvZiAKdGhlIE1ScyBhY2NvcmRpbmcgdG8g
c29tZSBsb2dpYykuCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK

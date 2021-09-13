Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC14C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 14:17:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B4460FDA
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 14:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62B4460FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmQnMFg6oINGZWX7tsa4ycrJRUDwTsNJMpUBQHdm150=; b=Y4vOm6Dl31N//5vzTAUtqQjRbx
	caKdjr1bDuJrTUdIAhBnlA9zJCTNWtx5Fz8PlT8fDkN65gaIxn+xyAWefw+nm4fEkbLRqsvMfyBkr
	w2U6rQ5qI1DIj9CeuHhsEpFJgABE7r7M/OB+FbGysp+Zy2njbfQLfEnbXLBRjBZ/Z6Qs1R3BNHvz7
	odY8V2kWzU8XzilwqlLgVG100TbSoBsNGmo2h3K2miJIx2EUtHZ4g98fbg27pe2W06rPBSPjKfq9b
	qt1ph9rOR6NHfuFgYNWn2sinPaca2PPGwf9MpyypnMYC7GEJB9SwFuwKds2fKtQZWbwJz4pbcKS+N
	lGgem7JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPmlS-0022IO-PT; Mon, 13 Sep 2021 14:16:54 +0000
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com
 ([40.107.94.84] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPmlP-0022HV-NG
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 14:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq2OElHwdQgBQ21NQRkpxI5Aau+7I68e2KDVY8Iy90ctyjtEMbwz7PF8wKwxoKQ+D8oE+8W0QXBHUliouE2Rdw8GNn+FaxPDUy1E5m2DGnJhbR7OpthQrLetKaBo3DCkQO4juNaztS8jglJPaPwSKoC7GSej2DjD0ByBQ0NLXHoO6B2W1yPnP/ITIy5DYLVJeiJ5kStsX6BtspYbTNLJsVS6wZNdTeo1B+Q4pF0xRf+gfw5wppayvOW4taqB3CO6kEULIld3DqOMadvReP3Kp2VK/bsj1YPDp7WhnsPV+LcBJh+5KdCO7U0L18OdQVljmiefJK4cszWUyomcLRuMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zsWcGtH7CKzWDNNn5T/gYMhslYCAfLcgRl2A64aCyw8=;
 b=V7aIfgFhlHFSLN5TETSd8v1JEYrfY9Pz0DcnulSaLy716QItuSlzpSjEylHHBY7PhcsUCY2MpvhcJOqax4qgn8njCtAbbZnN+GXpum9bf5EOG5X48a6oE2uIHH/XnetTjKabFLQ7YQA1iRpUfKdzPWVKSTbOpcoeUNkDs5iRi1nvUC6f5QGst9fNy5fZxT9FR0deSsdJrfbNm3gYEHfAvg4ap8Kqjrj77rijadQaIDy3k9EgIsC0NOIa+Rd6dsY3D3ekXBtCGblcaw8j4HQCgebP5Nqufhs14ly38bNOhhGDe/qv86unSeT6tPTDYvLktsGXubUpmThRxcS/WmKg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsWcGtH7CKzWDNNn5T/gYMhslYCAfLcgRl2A64aCyw8=;
 b=Zjr0KI5Xo9nvVxBJEtGl1ANUTcx5mgjZ+C6wLBko8QxjgNuVBgsDWMUXS3AeMDjzrkkTpfdQvo1KdiIkaFIzsOuWZxKoaUn4gMSvchG9/HcYGy1AgelHK3WvawVwQlaUkIs3F2HH9j7VXgVC0hAotaCSAG+JOgohTriGwv8DXJ7lPkSrKU24xyNwvEf97cJVkCToZXYFOOjsdCbB1LfWCzoVs9Uzl8LeAnbV0ScG1XgCU12lIyT4jSMlWebHRM8CHzw7tkh7pCClIBZiFN3Xj6XKl8EIP+RtAXeUkuBLlR/lekDu/OTzbHp9kA+cyJmkm+N7l/OqKpnyL7Jz9jYXyA==
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Mon, 13 Sep
 2021 14:16:47 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c1) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 14:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 14:16:47 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 13 Sep
 2021 14:16:46 +0000
Received: from [172.27.12.36] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 13 Sep
 2021 14:16:44 +0000
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
To: liruozhu <liruozhu@huawei.com>, Christoph Hellwig <hch@infradead.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com> <YToUji9WujpL9vnt@infradead.org>
 <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
 <9aa78ab2-ef69-abf7-7fca-7f135553f429@huawei.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <6544d3f7-79bb-c16d-df6f-104fc6928c16@nvidia.com>
Date: Mon, 13 Sep 2021 17:16:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9aa78ab2-ef69-abf7-7fca-7f135553f429@huawei.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4749a6c0-fb87-473b-d910-08d976c11f5f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28694C503E7ED8A980E1A009DED99@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpagDP4CB/tV6tZYVIyMRZbzIQiN2lH1o0xwoE+GiH1T+7y/iAGUi2r4BKbqIWpYRjBBWEl5HZ9DiSXkLvPecdPng96HkzJGyJIQy5xSxDK8AGqsJ0JMwZeyvpeTYwGlDNaSTS9YImR7IQymYuVXdZwL2NZGdPursiCO9izgGlRrit2c3MVEF0y8XmWkkyurBhOHARqrB9F0t4Zlr6zxc4noO94T1+EDfkXPImcdwOoUg2SRObgX35BRX3hpX32cETRVFvuTvfqlKMLVucSf+3R27q2FxP8O6KjHcxrI8Gti7vRWeN9e7P7P8p6WPWzTuQ6pAqOW1ICJpCCfkQ7mrav7Ot4gdGfYC+CHCEWu6qP5YChoBGf2EHhlsWt8Sjr+wEtUoxh9weCGLunwf/fKtGTR4KI2jySxBQpS7WDcI7YmoqF5vlrB0c26fAPJoqj4pizDulhSiNkWMa4wP6IBhxm9BXDQrgBWYwi8hPjgGBQKMlnA3wOjzh4mlK9zW+QKPklsakVcRXpVPTw8QhkvJfFBc31qyoeh2JgBiamPiqi7arwuzNp/fvTXQMbzALn7w2CcpItUFNmJANo6KDt/iEvdrvektHpw/J5QhOSS4IcgfnyxGsC25+okYsva+osGpZgh675pz1WoOxd0CZZjFprhilkmZtnVi5cF9L1e2YPU+67fFPoJDRdKovxSiMROG/bLImumZ86hjbJyi3NJCduVMaXMuknwk0/g8hQcABPomNosfnkICP6l6HKhH6k15VQcGJveQJNQKNk5Wm14e/ebuaPNqikHn35kTHbn1pzz9r4lSiyVU5Sz2i3OnLPi
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(83380400001)(31686004)(4326008)(356005)(2906002)(7636003)(86362001)(82310400003)(966005)(426003)(5660300002)(8676002)(478600001)(70586007)(47076005)(8936002)(6666004)(336012)(186003)(16526019)(53546011)(36906005)(54906003)(110136005)(316002)(26005)(82740400003)(16576012)(36756003)(2616005)(36860700001)(70206006)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 14:16:47.4308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4749a6c0-fb87-473b-d910-08d976c11f5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_071651_807375_453EF25B 
X-CRM114-Status: GOOD (  20.15  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDkvMTMvMjAyMSA0OjQ5IEFNLCBsaXJ1b3podSB3cm90ZToKPiBIaSBhbGwsCj4KPiBJIHRl
c3RlZCB0aGUgdGVzdCBzY2VuYXJpbyBtZW50aW9uZWQgYnkgbWF4LCBhbmQgSSBoYXZlbid0IGZv
dW5kIGFueSAKPiBhYm5vcm1hbGl0eSBpbiB0aGUgaG9zdC4KPgo+IElmIHRoZXJlIGFyZSBvdGhl
ciBpbnRlcmVzdGluZyBzY2VuZXMgb3Igc3VnZ2VzdGlvbnMgZm9yIHBhdGNoLCBwbGVhc2UgCj4g
bGV0IG1lIGtub3cuCj4KPiBUaGFua3MuCgpUaGFua3MgZm9yIHRoZSB1cGRhdGUuCgpUaGUgY29k
ZSBsb29rcyBnb29kLAoKUmV2aWV3ZWQtYnk6IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRp
YS5jb20+Cgo+Cj4gT24gMjAyMS85LzEwIDE6MzIsIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4KPj4g
T24gOS85LzIwMjEgNTowNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+PiBUaGlzIGxv
b2tzIHJlYXNvbmFibGUgdG8gbWUuwqAgU2FnaSwgTWF4OiBhbnkgY29tbWVudHM/Cj4+Pgo+Pj4g
T24gTW9uLCBTZXAgMDYsIDIwMjEgYXQgMTE6NTE6MzRBTSArMDgwMCwgUnVvemh1IExpIHdyb3Rl
Ogo+Pj4+IFdlIHNob3VsZCBhbHdheXMgZGVzdHJveSBjbV9pZCBiZWZvcmUgZGVzdHJveSBxcCB0
byBhdm9pZCB0byBnZXQgY21hCj4+Pj4gZXZlbnQgYWZ0ZXIgcXAgd2FzIGRlc3Ryb3llZCwgd2hp
Y2ggbWF5IGxlYWQgdG8gdXNlIGFmdGVyIGZyZWUuCj4+Cj4+IERvIHlvdSByZWFsbHkgZW5jb3Vu
dGVyIHVzZS1hZnRlci1mcmVlID8KPj4KPj4gSSB0aGluayB0aGUgY29kZSBsb29rcyBjb3JyZWN0
IGJ1dCBmcm9tIGV4cGVyaWVuY2Ugd2l0aCBSRE1BLUNNIEkgCj4+IHdvdWxkIGxpa2UgdG8ga25v
dyB3aGljaCB0ZXN0cyBkaWQgeW91IHJ1biB3aXRoIHRoaXMgY29kZSA/Cj4+Cj4+IGludGVyZXN0
aW5nIHRlc3RzIGFyZTogcG9ydCB0b2dnbGluZyB3aXRoL3dpdGhvdXQgSU8sIHVubG9hZCAKPj4g
bWx4NS9vdGhlcl9yZG1hX2h3IGRyaXZlcnMgZHVyaW5nIGNvbm5lY3Rpb24gZXN0YWJsaXNobWVu
dCBvciBkdXJpbmcgCj4+IElPLCByZWJvb3QgdGFyZ2V0LCByZWJvb3QgdGFyZ2V0IGR1cmluZyBj
b25uZWN0aW9uIGVzdGFibGlzaG1lbnQsIAo+PiByZWJvb3QgdGFyZ2V0IGR1cmluZyBJTy4KPj4K
Pj4gVGhhbmtzLgo+Pgo+Pgo+Pj4+IEluIFJETUEgY29ubmVjdGlvbiBlc3RhYmxpc2htZW50IGVy
cm9yIGZsb3csIGRvbid0IGRlc3Ryb3kgcXAgaW4gY20KPj4+PiBldmVudCBoYW5kbGVyLkp1c3Qg
cmVwb3J0IGNtX2Vycm9yIHRvIHVwcGVyIGxldmVsLCBxcCB3aWxsIGJlIGRlc3Ryb3kKPj4+PiBp
biBudm1lX3JkbWFfYWxsb2NfcXVldWUoKSBhZnRlciBkZXN0cm95IGNtIGlkLgo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogUnVvemh1IExpIDxsaXJ1b3podUBodWF3ZWkuY29tPgo+Pj4+IC0tLQo+
Pj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyB8IDE2ICsrKy0tLS0tLS0tLS0tLS0KPj4+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPj4+
Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9yZG1hLmMKPj4+PiBpbmRleCBhNjg3MDRlMzkwODQuLjA0MmM1OTRiYzU3ZSAxMDA2
NDQKPj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4+PiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9yZG1hLmMKPj4+PiBAQCAtNjU2LDggKzY1Niw4IEBAIHN0YXRpYyB2b2lkIG52
bWVfcmRtYV9mcmVlX3F1ZXVlKHN0cnVjdCAKPj4+PiBudm1lX3JkbWFfcXVldWUgKnF1ZXVlKQo+
Pj4+IMKgwqDCoMKgwqAgaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoTlZNRV9SRE1BX1FfQUxMT0NB
VEVELCAmcXVldWUtPmZsYWdzKSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+
IMKgIC3CoMKgwqAgbnZtZV9yZG1hX2Rlc3Ryb3lfcXVldWVfaWIocXVldWUpOwo+Pj4+IMKgwqDC
oMKgwqAgcmRtYV9kZXN0cm95X2lkKHF1ZXVlLT5jbV9pZCk7Cj4+Pj4gK8KgwqDCoCBudm1lX3Jk
bWFfZGVzdHJveV9xdWV1ZV9pYihxdWV1ZSk7Cj4+Pj4gwqDCoMKgwqDCoCBtdXRleF9kZXN0cm95
KCZxdWV1ZS0+cXVldWVfbG9jayk7Cj4+Pj4gwqAgfQo+Pj4+IMKgIEBAIC0xODE1LDE0ICsxODE1
LDEwIEBAIHN0YXRpYyBpbnQgCj4+Pj4gbnZtZV9yZG1hX2Nvbm5fZXN0YWJsaXNoZWQoc3RydWN0
IG52bWVfcmRtYV9xdWV1ZSAqcXVldWUpCj4+Pj4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwg
cXVldWUtPnF1ZXVlX3NpemU7IGkrKykgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBu
dm1lX3JkbWFfcG9zdF9yZWN2KHF1ZXVlLCAmcXVldWUtPnJzcF9yaW5nW2ldKTsKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3Rv
IG91dF9kZXN0cm95X3F1ZXVlX2liOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4+Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+
PiAtCj4+Pj4gLW91dF9kZXN0cm95X3F1ZXVlX2liOgo+Pj4+IC3CoMKgwqAgbnZtZV9yZG1hX2Rl
c3Ryb3lfcXVldWVfaWIocXVldWUpOwo+Pj4+IC3CoMKgwqAgcmV0dXJuIHJldDsKPj4+PiDCoCB9
Cj4+Pj4gwqAgwqAgc3RhdGljIGludCBudm1lX3JkbWFfY29ubl9yZWplY3RlZChzdHJ1Y3QgbnZt
ZV9yZG1hX3F1ZXVlICpxdWV1ZSwKPj4+PiBAQCAtMTkxNiwxNCArMTkxMiwxMCBAQCBzdGF0aWMg
aW50IG52bWVfcmRtYV9yb3V0ZV9yZXNvbHZlZChzdHJ1Y3QgCj4+Pj4gbnZtZV9yZG1hX3F1ZXVl
ICpxdWV1ZSkKPj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2VycihjdHJsLT5jdHJsLmRldmljZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAicmRtYV9jb25uZWN0X2xvY2tlZCBmYWlsZWQgKCVkKS5cbiIsIHJldCk7Cj4+Pj4gLcKg
wqDCoMKgwqDCoMKgIGdvdG8gb3V0X2Rlc3Ryb3lfcXVldWVfaWI7Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7Cj4+Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4gwqAgwqDCoMKgwqDCoCByZXR1
cm4gMDsKPj4+PiAtCj4+Pj4gLW91dF9kZXN0cm95X3F1ZXVlX2liOgo+Pj4+IC3CoMKgwqAgbnZt
ZV9yZG1hX2Rlc3Ryb3lfcXVldWVfaWIocXVldWUpOwo+Pj4+IC3CoMKgwqAgcmV0dXJuIHJldDsK
Pj4+PiDCoCB9Cj4+Pj4gwqAgwqAgc3RhdGljIGludCBudm1lX3JkbWFfY21faGFuZGxlcihzdHJ1
Y3QgcmRtYV9jbV9pZCAqY21faWQsCj4+Pj4gQEAgLTE5NTQsOCArMTk0Niw2IEBAIHN0YXRpYyBp
bnQgbnZtZV9yZG1hX2NtX2hhbmRsZXIoc3RydWN0IAo+Pj4+IHJkbWFfY21faWQgKmNtX2lkLAo+
Pj4+IMKgwqDCoMKgwqAgY2FzZSBSRE1BX0NNX0VWRU5UX1JPVVRFX0VSUk9SOgo+Pj4+IMKgwqDC
oMKgwqAgY2FzZSBSRE1BX0NNX0VWRU5UX0NPTk5FQ1RfRVJST1I6Cj4+Pj4gwqDCoMKgwqDCoCBj
YXNlIFJETUFfQ01fRVZFTlRfVU5SRUFDSEFCTEU6Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIG52bWVf
cmRtYV9kZXN0cm95X3F1ZXVlX2liKHF1ZXVlKTsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgZmFsbHRo
cm91Z2g7Cj4+Pj4gwqDCoMKgwqDCoCBjYXNlIFJETUFfQ01fRVZFTlRfQUREUl9FUlJPUjoKPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2RiZyhxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkNNIGVycm9yIGV2ZW50ICVkXG4iLCBldi0+
ZXZlbnQpOwo+Pj4+IC0tIAo+Pj4+IDIuMTYuNAo+Pj4+Cj4+Pj4KPj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IExpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0Cj4+Pj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4+Pj4gaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCj4+PiAtLS1lbmQg
cXVvdGVkIHRleHQtLS0KPj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=

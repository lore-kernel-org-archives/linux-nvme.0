Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B745C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 10:53:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595AA613D8
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 10:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595AA613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Rq9v2mAZ9xJo75Ek1ptw+Xt2BTWsIK/l7hP3GkxMgg=; b=MqjhIffzYo/oQ5t4MMZXSux5hU
	fWRBc8RHoxnfLiS+I6B0azSTdb2zQpNvyGf5HZjCGZcqRm8I6oTFJS41ynRpTzvlJzCbArTH64azH
	zhwfBe/xFQFEJuD8zJlY2ur4xjLPjIi8Cn6kwH/egLa6ZWEYRhw740ZaMEtDwiVLgkO89TeeDpeEx
	wVi0RK8cxYBIpkzy0Sw+Jp5xqFKxHN0UKpaYneH2+Rl7U7PbVcLNHROttUdJj+TadX2Nuj2jx4pDr
	V2d6ewtTMwm3vU4AnoY4H63TCqPQw4VTUBT3rYXLXMwCdFySTiNjGWF1tevpWw/hZFuBdlOPDQzEW
	Wl0dmRkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lokyR-008BRU-28; Thu, 03 Jun 2021 10:53:15 +0000
Received: from mail-co1nam11on2067.outbound.protection.outlook.com
 ([40.107.220.67] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lokyL-008BQ9-Jq
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 10:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc/6m8yQEL/Dw14ziIzJNGVsxzCKLmYgcU+GKa+3c/A/9FwnKt94xNuXhLUDTsIROcA4LNcH4PO6gSMEe12vyVorbD2GHS7xwxeMpc8xTOAoQlA1NXg/o9yaEuh0+6yvxbHe1G9WK1kcC1IECWx4R5SyS1/Jjb3WeM71W1YKCd+3UFhXOw0HR4eIXHChJXAx671Owfay6nLUDRyz0WUOiEpMisHTZP+E6GtCgR8N3CUbMsa6L2w3ULOQQdZ4I/+K3O5bxS7Lbko1IA5Zgi76uRLlB49cMRwf7EMtlDRfb89X4vvepUcBxdP6aFOI8Hfw667KuD0+J0THO/eODnm/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifcF+1oKwZHIn+s3rLQCg4Qe6LYnZYYMgf1eTUfJeAY=;
 b=AuyM5r5Y5EkcG5AymY8UenPayrLi/svrQN0fkATXKC4CiHQoCQZej5Ee9zc7Db5gF02/ZgzFrawCsXU+1L1TEgyGqGwnSbr2LRcX+lzHFhPtxIiylJqXtnHVfMlR1rElL57VZhYnqYV8Yl/NOQr77pjSBHm5fc9+d3cKUhaBHBQcOA3X3FdEufyJqfzR0iTgP82VQ8nCBan/ksqMXtlLKl4476OpxT0LEKVooU5XHbnu3a9RUv+UNeesQgej0sgx4c9rzUpImK2JnNhTBYL5fBlBkn+cppetDMytHNxzKiF8A2bOOoWh1pmIW3U0VqD7AmFreKFXErngN9JeP769eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifcF+1oKwZHIn+s3rLQCg4Qe6LYnZYYMgf1eTUfJeAY=;
 b=Mk3s+ROq/q3SDC5uL240OW0kVtlO6+wieKKyWcPqom/Ei0kwDYe3wB/184wb2kJO4ShxqNyhMnIpimQmaXsh1TlQ1lcQeujIs5gjibZdUMeS2gaBzqqTX0fOjPiZ97v4CvGVXF5XcNeRhlQzSiU5MUAZ1nVwLPR8hAoj9C9bo8eheMM+3ETCLV7jyazWnGHqpr1fD2Tv2BEgfHSvjmKR/ggI40iA99z4MSEOfIaia174UAofJKKSBmOTtua/3FU+Q7MhpWaXaPNPKOCNSOBc9oLQE6vcAvU0wFejRXh5iI6OTxmk+RBfxk7q1lzR+8xWy+xWlEar1R3j2wxrXl/2uQ==
Received: from BN6PR19CA0116.namprd19.prod.outlook.com (2603:10b6:404:a0::30)
 by BN8PR12MB3635.namprd12.prod.outlook.com (2603:10b6:408:46::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 10:53:06 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::41) by BN6PR19CA0116.outlook.office365.com
 (2603:10b6:404:a0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 10:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 10:53:06 +0000
Received: from [172.27.14.209] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 10:53:02 +0000
Subject: Re: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
To: David Hildenbrand <david@redhat.com>, <linux-nvme@lists.infradead.org>,
 <dan.j.williams@intel.com>, <logang@deltatee.com>, <linux-mm@kvack.org>,
 <hch@lst.de>
CC: <sagi@grimberg.me>, <oren@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <akpm@linux-foundation.org>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-2-mgurtovoy@nvidia.com>
 <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <46524325-8e2a-9395-e0d0-7d559c753c67@nvidia.com>
Date: Thu, 3 Jun 2021 13:52:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e2e3b1-5947-4d61-9c9f-08d9267dc4d4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3635:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3635135CE9F54B099BDE9839DE3C9@BN8PR12MB3635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4FHQMuVvrnlje7lTo+7yUC+h9/v6NiiEJjTzsEBflaRv1uAOCmzTGWO8orInBmv4xu0K8p/iyohC3mftiaoQaaxKyr4c1GzdZ1acWHIpO4oG+B6BNK//qkwLKMciFTdpFPTWSoeiQ2xH/GN2lx1gAy56iLl0NVnbkw+Dj4NjYqKYuO5QhPQJswxS/FMjcRY7rSBaMF1ICLO34E/bnH9GllsG5ZZLsCEoXWjGg6SJgXEqkxSKMhiVecijoAMzGp3P7W+ID4u95CT1HX6iCreL2EDRZWrIVrQxYC57z4tp+njzAs246eSl3onbpxwr2ipYqmReHL6o6GsxhubIIYskGk80NqjJQbZoXSTgB8Wu1XZbmbb0aDgNMX+n6po2p+cySVb1G5zSeR1cR70utEM0yf0/EUDUT15A5i3tUAEdpe21680cc/mVL1TkLorDi1ZOaBn4UF6KO+m6rE9ve5iNxvmrfJak7CYxD7EJhwCBXWbiEsrIWaIYIBoEUI/iPnQ0WvAtdxerwrFZ3Q4GGtH2kWMnmbdMN2Aso4KE8g1yBYLFPuabraqhzfNBljR/wLrGrdvNMmGl2f38lvRe8D/0Xjhzso4CM3Ei83R6Al8Vq+fcgMeHgFNpRy/q4gyx6iRyl3fzcMmPzeIiV3GRESvpnrj99uf8Ux9MwzsGEGUBTGYUCzxg8tTkf4zSKl8EwffIwq/Yqz5EkTlc4jb2dc6MQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(82310400003)(426003)(53546011)(5660300002)(316002)(4326008)(36906005)(31696002)(82740400003)(47076005)(16576012)(36756003)(7636003)(356005)(110136005)(2616005)(8936002)(70586007)(478600001)(31686004)(336012)(70206006)(16526019)(2906002)(8676002)(6666004)(26005)(36860700001)(186003)(54906003)(86362001)(83380400001)(2101003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 10:53:06.2670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e2e3b1-5947-4d61-9c9f-08d9267dc4d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3635
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_035309_742430_5F2F1924 
X-CRM114-Status: GOOD (  21.47  )
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

Ck9uIDYvMi8yMDIxIDM6MTQgUE0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+IE9uIDAyLjA2
LjIxIDEzOjEwLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+IEhvdHBsdWdnZWQgbWVtb3J5IGhhcyBh
bGlnbm1ldCByZXN0cmljdGlvbnMuIEUuZywgaXQgZGlzYWxsb3dzIGFsbAo+PiBvcGVyYXRpb25z
IHNtYWxsZXIgdGhhbiBhIHN1Yi1zZWN0aW9uIGFuZCBvbmx5IGFsbG93IG9wZXJhdGlvbnMgc21h
bGxlcgo+PiB0aGFuIGEgc2VjdGlvbiBmb3IgU1BBUlNFTUVNX1ZNRU1NQVAuIEV4cG9ydCB0aGUg
YWxpZ25tZW50IHJlc3RyaWN0aW9ucwo+PiBmb3IgbWhwIHVzZXJzLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+PiAtLS0KPj4gwqAgaW5j
bHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oIHzCoCA1ICsrKysrCj4+IMKgIG1tL21lbW9yeV9o
b3RwbHVnLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzMgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTQg
ZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3Rw
bHVnLmggCj4+IGIvaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oCj4+IGluZGV4IDI4ZjMy
ZmQwMGZlOS4uYzU1YTkwNDliMTFlIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21lbW9y
eV9ob3RwbHVnLmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oCj4+IEBA
IC03Niw2ICs3Niw3IEBAIHN0cnVjdCBtaHBfcGFyYW1zIHsKPj4gwqAgwqAgYm9vbCBtaHBfcmFu
Z2VfYWxsb3dlZCh1NjQgc3RhcnQsIHU2NCBzaXplLCBib29sIG5lZWRfbWFwcGluZyk7Cj4+IMKg
IHN0cnVjdCByYW5nZSBtaHBfZ2V0X3BsdWdnYWJsZV9yYW5nZShib29sIG5lZWRfbWFwcGluZyk7
Cj4+ICt1bnNpZ25lZCBsb25nIG1ocF9nZXRfbWluX2FsaWduKHZvaWQpOwo+PiDCoCDCoCAvKgo+
PiDCoMKgICogWm9uZSByZXNpemluZyBmdW5jdGlvbnMKPj4gQEAgLTI0OCw2ICsyNDksMTAgQEAg
dm9pZCBtZW1faG90cGx1Z19kb25lKHZvaWQpOwo+PiDCoMKgwqDCoMKgIF9fX3BhZ2U7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gwqDCoCB9KQo+PiDCoCArc3RhdGljIGlubGlu
ZSB1bnNpZ25lZCBsb25nIG1ocF9nZXRfbWluX2FsaWduKHZvaWQpCj4+ICt7Cj4+ICvCoMKgwqAg
cmV0dXJuIDA7Cj4+ICt9Cj4+IMKgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgem9uZV9zcGFuX3Nl
cWJlZ2luKHN0cnVjdCB6b25lICp6b25lKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7
Cj4+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcu
Ywo+PiBpbmRleCA5ZTg2ZTllZTBhMTAuLjE2MWJiNjcwNGE5YiAxMDA2NDQKPj4gLS0tIGEvbW0v
bWVtb3J5X2hvdHBsdWcuYwo+PiArKysgYi9tbS9tZW1vcnlfaG90cGx1Zy5jCj4+IEBAIC0yNzAs
MjQgKzI3MCwyOSBAQCB2b2lkIF9faW5pdCAKPj4gcmVnaXN0ZXJfcGFnZV9ib290bWVtX2luZm9f
bm9kZShzdHJ1Y3QgcGdsaXN0X2RhdGEgKnBnZGF0KQo+PiDCoCB9Cj4+IMKgICNlbmRpZiAvKiBD
T05GSUdfSEFWRV9CT09UTUVNX0lORk9fTk9ERSAqLwo+PiDCoCArLyoKPj4gKyAqIERpc2FsbG93
IGFsbCBvcGVyYXRpb25zIHNtYWxsZXIgdGhhbiBhIHN1Yi1zZWN0aW9uIGFuZCBvbmx5Cj4+ICsg
KiBhbGxvdyBvcGVyYXRpb25zIHNtYWxsZXIgdGhhbiBhIHNlY3Rpb24gZm9yCj4+ICsgKiBTUEFS
U0VNRU1fVk1FTU1BUC4gTm90ZSB0aGF0IGNoZWNrX2hvdHBsdWdfbWVtb3J5X3JhbmdlKCkKPj4g
KyAqIGVuZm9yY2VzIGEgbGFyZ2VyIG1lbW9yeV9ibG9ja19zaXplX2J5dGVzKCkgZ3JhbnVsYXJp
dHkgZm9yCj4+ICsgKiBtZW1vcnkgdGhhdCB3aWxsIGJlIG1hcmtlZCBvbmxpbmUsIHNvIHRoaXMg
Y2hlY2sgc2hvdWxkIG9ubHkKPj4gKyAqIGZpcmUgZm9yIGRpcmVjdCBhcmNoX3thZGQscmVtb3Zl
fV9tZW1vcnkoKSB1c2VycyBvdXRzaWRlIG9mCj4+ICsgKiBhZGRfbWVtb3J5X3Jlc291cmNlKCku
Cj4+ICsgKi8KPj4gK3Vuc2lnbmVkIGxvbmcgbWhwX2dldF9taW5fYWxpZ24odm9pZCkKPj4gK3sK
Pj4gK8KgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVApKQo+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBBR0VTX1BFUl9TVUJTRUNUSU9OOwo+PiArwqDCoMKgIHJl
dHVybiBQQUdFU19QRVJfU0VDVElPTjsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKG1ocF9n
ZXRfbWluX2FsaWduKTsKPgo+IFdlIGhhdmUgdG8gbWFpbiBpbnRlcmZhY2VzIHRvICJob3RwbHVn
IiBtZW1vcnk6Cj4KPiBhKSBhZGRfbWVtb3J5KCkgYW5kIGZyaWVuZHMgZm9yIFN5c3RlbSBSQU0s
IHdoaWNoIGhhdmUgbWVtb3J5IGJsb2NrIAo+IGFsaWdubWVudCByZXF1aXJlbWVudHMuCj4KPiBi
KSBtZW1yZW1hcF9wYWdlcygpLCB3aGljaCBoYXMgdGhlIGFsaWduZW1udCByZXF1aXJlbWVudHMg
eW91IG1lbnRpb24gCj4gaGVyZS4KPgo+IEkgZmVlbCBsaWtlIHdoYXQgeW91IG5lZWQgd291bGQg
YmV0dGVyIGJlIGV4cG9zZWQgaW4gbW0vbWVtcmVtYXAuYywgCj4gZm9yIGV4YW1wbGUsIHZpYSAi
bWVtcmVtYXBfbWluX2FsaWdubWVudCIgc28gaXQgbWF0Y2hlcyB0aGUgCj4gIm1lbXJlbWFwX3Bh
Z2VzIiBzZW1hbnRpY3MuCj4KPiBBbmQgdGhlbiwgbWVtcmVtYXBfcGFnZXMoKSBpcyBvbmx5IGF2
YWlsYWJsZSB3aXRoIENPTkZJR19aT05FX0RFVklDRSwgCj4gd2hpY2ggZGVwZW5kcyBvbiBTUEFS
U0VNRU1fVk1FTU1BUC4gU28geW91J2xsIGFsd2F5cyBoYXZlIAo+IFBBR0VTX1BFUl9TVUJTRUNU
SU9OLgo+Cj4gSSBjYW4gYWxyZWFkeSBzcG90ICJtZW1yZW1hcF9jb21wYXRfYWxpZ24iLCBtYXli
ZSB5b3UgY2FuIHJldXNlIHRoYXQgCj4gb3IgaGFuZGxlIGl0IGFjY29yZGluZ2x5IGluIHRoZXJl
PwoKWWVzIEkgdGhpbmsgdGhhdCBzaW5jZSBzdWJzZWN0aW9uIGlzIGFsaWduZWQgdG8gUEFHRV9T
SVpFIEkgY2FuIGRvOgoKc2l6ZV90IHBjaV9wMnBkbWFfYWxpZ25fc2l6ZShzaXplX3Qgc2l6ZSkK
ewogwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBtaW5fYWxpZ247CgogwqDCoMKgwqDCoMKg
wqAgbWluX2FsaWduID0gbWVtcmVtYXBfY29tcGF0X2FsaWduKCk7CiDCoMKgwqDCoMKgwqDCoCBp
ZiAoIUlTX0FMSUdORUQoc2l6ZSwgbWluX2FsaWduKSkKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gQUxJR05fRE9XTihzaXplLCBtaW5fYWxpZ24pOwoKIMKgwqDCoMKgwqDC
oMKgIHJldHVybiBzaXplOwp9CgoKdGhvdWdodHMgPwoKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

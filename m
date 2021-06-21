Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5740C4743C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A16B6101D
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A16B6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	CC:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/Afxpn+sq4XLtxFa3TIaT7dHUvi0q0C0LavEgrpA5w=; b=PZIKKTfLI4+MbgY5xcJxTZAcDd
	+LcgMjzMThnAElopNMrouLilH+9Hu6N+hg3GQqpai91o5CsiqNLzRyGfRBS+ON6Q2P9JC5jtrLApB
	IM7Dhz/Y+xxDkKQWTY5XgILH4j64otwW8GqjOQvQxmT1jSRtrLLxRX7dPFMCJRp6Mo6/h+HTgfwrQ
	3Hdq8Rhs3HPF20a2GUhwmsNggh1DYS0gjtKKCVT7+HdMH0HjFSTjRKYCqWcqU79Zz4qCPtgD64mKn
	5xTQA8fgy71p2gPIQwhL0foS+7xIdiquuazy/QMl9uPtne5+VgDmOhDIjNvinknaORePy4IzSTvmS
	MZaydKwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvMWG-0042i8-3L; Mon, 21 Jun 2021 16:11:28 +0000
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com
 ([40.107.244.54] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvMWC-0042gH-9V
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 16:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip8B8+vx8lGVVmzuu2zXC1w6RPrN8Lc4PIckW1kwjia2qy4KAN3+WF1OxcNMRkpgyhdFgjYq7YJr7rVhQeSDv3QgC1Nh8nJDLhewTta9ddHL/tWd9sbpnDPmpQa2pDhV9eqgoagedmXoqaQI8GFQ7zJQSxb+qEexPDQghbhC6ip2fWAbtOpg2QVLdFbSst3u9m48lSv1x2L+s289ylTb2zTYksEsLxt/2soaZWPHB5jIvusZjMDc440hqLwTiupdXhWV3quJRjmdUNiZ2DpBwLSCb4MrJOFh1hxZhb7uJtfOGq8UbSS7qmuv2RXob+gNOv9BN5uIfz57m3rW08MsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+tEVUKfxYPKBYhwLIHzlT6yjHdYzrKc7CIilD+VVEA=;
 b=O/XANj2igSkdeeEheIJEvWnGxaJwRJNyl5uFYIlRjv1yzMuSeC16BJPiR610wT1MKjM5OzJTp+kx9dtPq7JNDhPymjn9pF41fhYbuKNRhzDJ8rx9KS1155GCHP7E9fwAING7dzQxDhkEImogMUhlAutRD639M+s65BAs6FhwmenN/BKS7dfwt4db7voTso3mb1p4XFhAxanXzjMtEG84fIAISnYLx0lfOSqXhvwVrQQTfC7i6pKn21FLwv2S8Ra2dWaMwIKukFyK9pa3K2jaley/wxKRR0GoJuDe5PR7hgU6tX73gN8gfiNS1KgsD9u7Fs7ZBeJhww+hDWZVI7gWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+tEVUKfxYPKBYhwLIHzlT6yjHdYzrKc7CIilD+VVEA=;
 b=IGnzTGakShcjDDwbJRTHI9r33GaiUGmpNMWjevEg8mpUCN7wKGj5A6WCcmpF+Se/6ow+7ccWsRhqRxqBxuunw42SHLM4j8wG/mB2bGkxmuOWB8pyuBjL//pZ8MiSRH9t6pPaUZV0BSZtHmWaGsABYb2iwLtq+ZDHPtsfPGtVI/qL30Dc0oyCV0YBK7UMeFpDpZy3h5oH9XOccKnKl3VfYXElFfd/MLm2wOZM/kaEwkCaYS0MNOykfuvEMjBaJ2OZc9tHnk5iT2eTN30eA4j+T6L3Qna7ymNvTTEpxPLFN/PGTlJURZooBm+M1Q8cS3AIeQmamY1Gv5hUq/gUt8DFOg==
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 16:11:19 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::a7) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 16:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 16:11:19 +0000
Received: from [172.27.15.67] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 16:11:15 +0000
Subject: Re: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: David Hildenbrand <david@redhat.com>, <linux-nvme@lists.infradead.org>,
 <dan.j.williams@intel.com>, <logang@deltatee.com>, <linux-mm@kvack.org>,
 <hch@lst.de>
CC: <sagi@grimberg.me>, <oren@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <akpm@linux-foundation.org>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-2-mgurtovoy@nvidia.com>
 <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
 <46524325-8e2a-9395-e0d0-7d559c753c67@nvidia.com>
Message-ID: <7a4acae5-b7f8-9312-8191-aece7270104f@nvidia.com>
Date: Mon, 21 Jun 2021 19:11:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <46524325-8e2a-9395-e0d0-7d559c753c67@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f7590c-9d11-454b-a5af-08d934cf346b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090803C222B0C58344D1A22DE0A9@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtqZqYdLRMeC7JPYSQCNMEVHax+7VQ5fbuLRzs1IdN9FuHIHcbKuOLNUPOr1NTvu+mRlmQon4LKwX8/kAYnH26MbEnh370aDV9T2dgCHwnlcR3dBLaAkFOFteuc7YjlIDZTRlk83VkeTFwEcUB5yDoYLxEdG4t1JuYKn2IRO5QM0DRdXRUQ8FTo2n9Tbpn0FM9DjEeAJy8EGT3fnKUHGmsNGv/cMIDjV5aHgEIFAaPIS1SH1oWxNOtfZ/M1uKO0yjEaLevrG02Hni0uy1xODVSi6kGOeRxrE2VxrsuEsn7PVa236DiF8KWMjvDD/HjCOIlL6yLE8EVrqqJtdOkEvUPnBMBHP3lxrNxeZTHvqzS3jA1vkkKdC9iha/+bUHxdl855fK+9O2/xZtpvazvuvPkpQW0m9qal2kKRTeyQTdOHlyj6IXqXvUOKUAFFaTuL2JTqNDEkEuNxPWkymkdEdxOd8UC4bAL7pX+1XEK1o6uPF5md5gEdoJotVU95EZxBY5RIWiZ9b38SoX8swCX9tueBs3ST/CbIjOQf3o/tM/bvo9UdgfHnpHWmEaWSvsB+LzfbvjV+vfs9BKP1vxlDHVmJOm4ojoaz9HV4PkszAXNFdz9KYcmEkoMMh338Nk2GpIeodF2mxOP2CuuDYmKN+a9U0yS8xuGwdNmlXCiht6xEwuq7kAP/8R3Bs+s+zq7yONEjYBPw5eQ7j45qtpJOEDJyBlb9ZdGfACTqbCF/6yYs8RIF1D6+/ZFZUv4tCfJgoGSMQsGcr2biiFUcr0GM4da0CC1YSXexUGP8Zvjd5hVhYHKNP2VjOo1EPDOdUSd8RAHYmQ7XXwBxtI4LuqWN1Ew==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(8676002)(426003)(47076005)(82310400003)(966005)(8936002)(31686004)(478600001)(53546011)(36756003)(26005)(16526019)(4326008)(356005)(7636003)(83380400001)(82740400003)(186003)(31696002)(16576012)(70206006)(316002)(6666004)(86362001)(110136005)(54906003)(70586007)(36906005)(2616005)(2906002)(336012)(36860700001)(5660300002)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:11:19.0861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f7590c-9d11-454b-a5af-08d934cf346b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_091124_399294_830A8741 
X-CRM114-Status: GOOD (  23.36  )
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

aGkgRGF2aWQsCgpkbyB3ZSBoYXZlIGEgY29uY2x1c2lvbiBmb3IgdGhpcyBzZXJpZXMgPwoKSXMg
dGhlIGJlbG93IHN1Z2dlc3Rpb24gYWNjZXB0ZWQgYnkgdGhlIG1haW50YWluZXJzID8KCkkgd291
bGQgbGlrZSB0byBzZW5kIGEgbmV3IHNlcmllcyBiZWZvcmUgY2xvc2luZyA1LjE0IG1lcmdlIHdp
bmRvdy4KCk9uIDYvMy8yMDIxIDE6NTIgUE0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPgo+IE9uIDYv
Mi8yMDIxIDM6MTQgUE0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+PiBPbiAwMi4wNi4yMSAx
MzoxMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Pj4gSG90cGx1Z2dlZCBtZW1vcnkgaGFzIGFsaWdu
bWV0IHJlc3RyaWN0aW9ucy4gRS5nLCBpdCBkaXNhbGxvd3MgYWxsCj4+PiBvcGVyYXRpb25zIHNt
YWxsZXIgdGhhbiBhIHN1Yi1zZWN0aW9uIGFuZCBvbmx5IGFsbG93IG9wZXJhdGlvbnMgc21hbGxl
cgo+Pj4gdGhhbiBhIHNlY3Rpb24gZm9yIFNQQVJTRU1FTV9WTUVNTUFQLiBFeHBvcnQgdGhlIGFs
aWdubWVudCByZXN0cmljdGlvbnMKPj4+IGZvciBtaHAgdXNlcnMuCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4gwqAg
aW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oIHzCoCA1ICsrKysrCj4+PiDCoCBtbS9tZW1v
cnlfaG90cGx1Zy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMzICsrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZW1v
cnlfaG90cGx1Zy5oIAo+Pj4gYi9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmgKPj4+IGlu
ZGV4IDI4ZjMyZmQwMGZlOS4uYzU1YTkwNDliMTFlIDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9tZW1vcnlfaG90cGx1Zy5oCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3Rw
bHVnLmgKPj4+IEBAIC03Niw2ICs3Niw3IEBAIHN0cnVjdCBtaHBfcGFyYW1zIHsKPj4+IMKgIMKg
IGJvb2wgbWhwX3JhbmdlX2FsbG93ZWQodTY0IHN0YXJ0LCB1NjQgc2l6ZSwgYm9vbCBuZWVkX21h
cHBpbmcpOwo+Pj4gwqAgc3RydWN0IHJhbmdlIG1ocF9nZXRfcGx1Z2dhYmxlX3JhbmdlKGJvb2wg
bmVlZF9tYXBwaW5nKTsKPj4+ICt1bnNpZ25lZCBsb25nIG1ocF9nZXRfbWluX2FsaWduKHZvaWQp
Owo+Pj4gwqAgwqAgLyoKPj4+IMKgwqAgKiBab25lIHJlc2l6aW5nIGZ1bmN0aW9ucwo+Pj4gQEAg
LTI0OCw2ICsyNDksMTAgQEAgdm9pZCBtZW1faG90cGx1Z19kb25lKHZvaWQpOwo+Pj4gwqDCoMKg
wqDCoCBfX19wYWdlO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+PiDCoMKgIH0p
Cj4+PiDCoCArc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG1ocF9nZXRfbWluX2FsaWduKHZv
aWQpCj4+PiArewo+Pj4gK8KgwqDCoCByZXR1cm4gMDsKPj4+ICt9Cj4+PiDCoCBzdGF0aWMgaW5s
aW5lIHVuc2lnbmVkIHpvbmVfc3Bhbl9zZXFiZWdpbihzdHJ1Y3Qgem9uZSAqem9uZSkKPj4+IMKg
IHsKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5X2hv
dHBsdWcuYyBiL21tL21lbW9yeV9ob3RwbHVnLmMKPj4+IGluZGV4IDllODZlOWVlMGExMC4uMTYx
YmI2NzA0YTliIDEwMDY0NAo+Pj4gLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYwo+Pj4gKysrIGIv
bW0vbWVtb3J5X2hvdHBsdWcuYwo+Pj4gQEAgLTI3MCwyNCArMjcwLDI5IEBAIHZvaWQgX19pbml0
IAo+Pj4gcmVnaXN0ZXJfcGFnZV9ib290bWVtX2luZm9fbm9kZShzdHJ1Y3QgcGdsaXN0X2RhdGEg
KnBnZGF0KQo+Pj4gwqAgfQo+Pj4gwqAgI2VuZGlmIC8qIENPTkZJR19IQVZFX0JPT1RNRU1fSU5G
T19OT0RFICovCj4+PiDCoCArLyoKPj4+ICsgKiBEaXNhbGxvdyBhbGwgb3BlcmF0aW9ucyBzbWFs
bGVyIHRoYW4gYSBzdWItc2VjdGlvbiBhbmQgb25seQo+Pj4gKyAqIGFsbG93IG9wZXJhdGlvbnMg
c21hbGxlciB0aGFuIGEgc2VjdGlvbiBmb3IKPj4+ICsgKiBTUEFSU0VNRU1fVk1FTU1BUC4gTm90
ZSB0aGF0IGNoZWNrX2hvdHBsdWdfbWVtb3J5X3JhbmdlKCkKPj4+ICsgKiBlbmZvcmNlcyBhIGxh
cmdlciBtZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcygpIGdyYW51bGFyaXR5IGZvcgo+Pj4gKyAqIG1l
bW9yeSB0aGF0IHdpbGwgYmUgbWFya2VkIG9ubGluZSwgc28gdGhpcyBjaGVjayBzaG91bGQgb25s
eQo+Pj4gKyAqIGZpcmUgZm9yIGRpcmVjdCBhcmNoX3thZGQscmVtb3ZlfV9tZW1vcnkoKSB1c2Vy
cyBvdXRzaWRlIG9mCj4+PiArICogYWRkX21lbW9yeV9yZXNvdXJjZSgpLgo+Pj4gKyAqLwo+Pj4g
K3Vuc2lnbmVkIGxvbmcgbWhwX2dldF9taW5fYWxpZ24odm9pZCkKPj4+ICt7Cj4+PiArwqDCoMKg
IGlmIChJU19FTkFCTEVEKENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUCkpCj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIFBBR0VTX1BFUl9TVUJTRUNUSU9OOwo+Pj4gK8KgwqDCoCByZXR1cm4gUEFH
RVNfUEVSX1NFQ1RJT047Cj4+PiArfQo+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKG1ocF9nZXRfbWlu
X2FsaWduKTsKPj4KPj4gV2UgaGF2ZSB0byBtYWluIGludGVyZmFjZXMgdG8gImhvdHBsdWciIG1l
bW9yeToKPj4KPj4gYSkgYWRkX21lbW9yeSgpIGFuZCBmcmllbmRzIGZvciBTeXN0ZW0gUkFNLCB3
aGljaCBoYXZlIG1lbW9yeSBibG9jayAKPj4gYWxpZ25tZW50IHJlcXVpcmVtZW50cy4KPj4KPj4g
YikgbWVtcmVtYXBfcGFnZXMoKSwgd2hpY2ggaGFzIHRoZSBhbGlnbmVtbnQgcmVxdWlyZW1lbnRz
IHlvdSBtZW50aW9uIAo+PiBoZXJlLgo+Pgo+PiBJIGZlZWwgbGlrZSB3aGF0IHlvdSBuZWVkIHdv
dWxkIGJldHRlciBiZSBleHBvc2VkIGluIG1tL21lbXJlbWFwLmMsIAo+PiBmb3IgZXhhbXBsZSwg
dmlhICJtZW1yZW1hcF9taW5fYWxpZ25tZW50IiBzbyBpdCBtYXRjaGVzIHRoZSAKPj4gIm1lbXJl
bWFwX3BhZ2VzIiBzZW1hbnRpY3MuCj4+Cj4+IEFuZCB0aGVuLCBtZW1yZW1hcF9wYWdlcygpIGlz
IG9ubHkgYXZhaWxhYmxlIHdpdGggQ09ORklHX1pPTkVfREVWSUNFLCAKPj4gd2hpY2ggZGVwZW5k
cyBvbiBTUEFSU0VNRU1fVk1FTU1BUC4gU28geW91J2xsIGFsd2F5cyBoYXZlIAo+PiBQQUdFU19Q
RVJfU1VCU0VDVElPTi4KPj4KPj4gSSBjYW4gYWxyZWFkeSBzcG90ICJtZW1yZW1hcF9jb21wYXRf
YWxpZ24iLCBtYXliZSB5b3UgY2FuIHJldXNlIHRoYXQgCj4+IG9yIGhhbmRsZSBpdCBhY2NvcmRp
bmdseSBpbiB0aGVyZT8KPgo+IFllcyBJIHRoaW5rIHRoYXQgc2luY2Ugc3Vic2VjdGlvbiBpcyBh
bGlnbmVkIHRvIFBBR0VfU0laRSBJIGNhbiBkbzoKPgo+IHNpemVfdCBwY2lfcDJwZG1hX2FsaWdu
X3NpemUoc2l6ZV90IHNpemUpCj4gewo+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbWlu
X2FsaWduOwo+Cj4gwqDCoMKgwqDCoMKgwqAgbWluX2FsaWduID0gbWVtcmVtYXBfY29tcGF0X2Fs
aWduKCk7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFJU19BTElHTkVEKHNpemUsIG1pbl9hbGlnbikp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBBTElHTl9ET1dOKHNpemUs
IG1pbl9hbGlnbik7Cj4KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc2l6ZTsKPiB9Cj4KPgo+IHRo
b3VnaHRzID8KPgo+Pgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBMaW51eC1udm1lIG1haWxpbmcgbGlzdAo+IExpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

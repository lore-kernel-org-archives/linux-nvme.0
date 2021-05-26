Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA9C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 11:20:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88312613BE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 11:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88312613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fvFyCtBQ/ZJQL/j+XiRRFTQ4a6SXDwgL5Dzr9hPDEe8=; b=TZL4H75d9sMzkYkS29r7g9fa9+
	EdxFy2/ZoAdfiMgQTohTq9/LM7iItq3vnia1yBVR63Lm4hSEQQhcmJ2Ifp9P8xnKDE6kAk8EUVZ8k
	NuJNrEgrOF8LBHIk2g/xAOfRPLqYskXsS8MyV6Wy9KIjYcbAK4dvJigmMbQqB0BCI9bhbNK0HozWO
	awFyoGFLbOaLzW6C9U/tNNHpRLzkDGsfnukBxTe5yp0s3FwIgSnQZHe2KV1LcRfpxCSX+YWH7zs58
	J1n71I3PeL4m0hcL/ETPlyH1GUEBBWtqI1Q+eJGsD0zDL/v1NYLCCAVnTNrb+Mei0XJCXmMnXwHq6
	Kr0mhZEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llraV-00DVFP-Ta; Wed, 26 May 2021 11:20:36 +0000
Received: from mail-dm6nam08on2077.outbound.protection.outlook.com
 ([40.107.102.77] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpnm-00CrMl-34
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 09:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es88Kbb4iuBowYApflOYvgVv6Xoyi7vsKViZGvesrO+ZFtGo+6vp3CG+UW+aJ3pf6gpVkSo8qw4N9SSHLFdRTSKEOTXTEgoeVDPJIa4+wMbG1s8cH/MFoCS7aKZ43aZbbLZt60HhWIO/4M/+TXpFfeHN9OgFHZl7eGkSj7ZlgRhM4msjrpKit1GLcRCqxZzjTP2mlJ9MY2MyzHj5gEpyiHTpAiyIBhvezoYfZS9xKEnneqQ88m3QlWsQ8msa+fFSw7St0tVmscYJfG7HhunTL6kIWCa0+SI6+S68p37vZZGsx1IYaPYmIwxNRwtttZSIHsqGRSJL2xHiRX0nC+GXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2UZNeqXKpFFTBKDHgkF4x8uzt4FvutD0nqR593qSAM=;
 b=lvO7xOIKa9dDnpdJq3T9Ei4W7l99sZbNeTh3GQ9bys+/1AVOXxnJlxfOMXeym1IYPSoG+cDVeOEFvQO4K9BtaNpavixvgaRgmy5zxfte377CHhKxK+RnNI2aeoH53RtT3PdjvgRetdOurOIuUxDgvz8XmqBgAaXEzAlE5FHmVRjaNllN15Q1ZYZvER/K1V+ZgnUkEyN/XaIX/67AiyAa8iXgaugmsF1U3M+EFpj46Xjgt4rh+ROo27OWDFq1gkkR1pcbHZ68XFxTpncVMNIUKXeosuPJwExZbTA69xNscU97gXIVw7C7VaImnCuM9lFcjSPMw4mv1YX9vApwwaQiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2UZNeqXKpFFTBKDHgkF4x8uzt4FvutD0nqR593qSAM=;
 b=gESOdDhJHtq3i4xRKjabNDKKDjicg444Gs/rCrybo5+CkACBG2TtRVASRYOdNI1tok5cXQMb6vXxJF5XMS6RRagDVh3os+EVDIfXlj0neMFfH5tDA+QvD4yKYokI2kSl+B1oA0BO9xz59/pAgGmmRZtoNjyVEEYTraNvRcUeuTAYsmuk4+OflCRIgGXFxb7Bmu35gdtdnOPd6XwMM2XKtOyW04Df4kTF0XfwZRwNAFqoTk8rENBfe9xS5cVN0/Tiz+U8xs8p+eUv1812JkeoNmhjAPFH38I68F/Fo7hlsSs0e2FovxlHLhlp05nBkAnrpWTkzUFgDAxHaXs995Cf+g==
Received: from BN6PR16CA0026.namprd16.prod.outlook.com (2603:10b6:405:14::12)
 by BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 09:26:06 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::d7) by BN6PR16CA0026.outlook.office365.com
 (2603:10b6:405:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 26 May 2021 09:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 09:26:06 +0000
Received: from [172.27.15.108] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 09:26:04 +0000
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
 <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
 <20210526003900.GA3704949@dhcp-10-100-145-180.wdc.com>
 <BYAPR04MB4965873E107F598F6BD95B1386249@BYAPR04MB4965.namprd04.prod.outlook.com>
 <2426b42f-b345-2689-3bd8-8a24d6670ac2@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <4c39bfc8-a249-0ed0-aa11-014d4bf3f6b8@nvidia.com>
Date: Wed, 26 May 2021 12:26:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2426b42f-b345-2689-3bd8-8a24d6670ac2@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72fb9a8d-13e6-443b-1b71-08d920284a55
X-MS-TrafficTypeDiagnostic: BYAPR12MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR12MB349498142F67624D641BA904DE249@BYAPR12MB3494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxAv+3gHpW4K+Q77KHU2GC7u7tKj8r+kzlu8vL6RRsAiHff96idKEjjnZ7KWpMFtBK0Sic2MuohrH4SOFuXRF3FhHJLWtMwKMU7clvaNLvOoioTe9+jFd2kJ9rz26KYW1ZHp6sIcprxUF7dnPFFS2Y17NewbqSYaLaUyFvE2AOlOSbRWEg2wHfrkXqMaH5up9kdibM5r3Cbdamj0eZHW06DAqBBhNEja0J5MbvIEemF3/dkgq5PlhMAdB6RzhT7iwoCvebFppCAgxS82mnkrZaSYCYsqTU0xoFGf7K5VowMM29WU/kc2owGhc0hVr40B6yRS6In9+4jgEWvowv5MhwShgxnZfmYOdw1xXueo72lNt5zEYJQx6dLXO0bjuvUtPgPp31T4w38dJ809zhk1rCvbdN9t+WyBI8Mw7tDr4UHTh30jxYcfVy+3ZR0uqLfdyKv5um52PwSiluLIgtbRjtXXtkSEgvWGG0nxzqiARLCaBgrKMMIHrqSzudLaim6p58gbP9IsNWAS/eZHi1k+S6hHThmLNOd2viiZXmkEWnbw4Ne/LxkBWSU2v4Nhq/ilKdy7fvCE03FyT4sFbGM3Eki4R+o/DSkRZk2/QG3LBPdch7aMZxibloldglKSwGmKOrgRZZokGpy4oWrHM2MvNIIIJAYNHvmZWpaa9ig0NQy2pvTthFp0ptWnTkVF4m/C
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(82310400003)(31686004)(70206006)(26005)(5660300002)(8676002)(36756003)(47076005)(186003)(36860700001)(4326008)(16526019)(70586007)(86362001)(31696002)(2906002)(2616005)(53546011)(426003)(110136005)(356005)(54906003)(336012)(83380400001)(16576012)(8936002)(478600001)(36906005)(316002)(82740400003)(7636003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 09:26:06.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fb9a8d-13e6-443b-1b71-08d920284a55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_022610_187734_8FEA5AA7 
X-CRM114-Status: GOOD (  31.74  )
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

Ck9uIDUvMjYvMjAyMSAxMTo0MSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4+IFRoZSBi
YWQgY29udHJvbGxlciBzaG91bGQgYmUgZml4ZWQuCj4+Pj4KPj4+PiBJbiB0aGUgcGFzdCwgSSd2
ZSBzZW50IHBhdGNoZXMgdGhhdCBjaGVjayB0aGF0IHNxaWQgbWF0Y2ggaW4gbnZtZSAKPj4+PiBj
cWUgdG8KPj4+PiBwcm90ZWN0IGZhdWx0eSBkcml2ZXMgdGhhdCBtaWdodCBzZW5kCj4+Pj4gdGhl
IGNvbXBsZXRpb24gb24gYSB3cm9uZyBtc2l4Lgo+Pj4+Cj4+Pj4gTXkgcGF0Y2ggd2Fzbid0IGFj
Y2VwdGVkIHNpbmNlIGl0IGFkZGVkIGFuIGFkZGl0aW9uYWwgImlmIiBpbiB0aGUgCj4+Pj4gZmFz
dCBwYXRoLgo+Pj4+Cj4+Pj4gTm93IHdlJ3JlIGFkZGluZyBtdWNoIG1vcmUgb3BlcmF0aW9uIGlu
IHRoZSBmYXN0IHBhdGggYmVjYXVzZSBvZiAKPj4+PiBidWdneSBjdHJsCj4+Pj4gPwo+Pj4gSSBz
aGFyZWQgdGhlIHNhbWUgcGVyZm9ybWFuY2UgY29uY2VybiBvbiB2MSBvbiB0aGlzIHNlcmllcy4g
SSBoYXZlbid0Cj4+PiBiZWVuIGFibGUgdG8gdGVzdCB0aGlzIG9uZSB5ZXQgKG9ubHkgaGF2ZSBl
bXVsYXRpb24gZm9yIHR3byBtb3JlIAo+Pj4gd2Vla3MpLgo+Pj4KPj4+IEhhbm5lcyBzYXlzIHRo
ZSBidWcgdGhpcyBjYXRjaGVzIGhhcHBlbnMgZnJlcXVlbnRseSBlbm91Z2ggb24gVENQLiAKPj4+
IElmIHdlCj4+PiBkb24ndCBjYXRjaCBpdCwgd2UgZ2V0IGtlcm5lbCBwYW5pYyBvciBjb3JydXB0
aW9uLCBzbyB3ZSBkZWZpbnRlbHkgCj4+PiBuZWVkIHRvCj4+PiBkbyBzb21ldGhpbmcuIFNhZ2kg
Y29ycmVjdGx5IG5vdGVkIHRoaXMgdHlwZSBvZiBidWcgaXMgbm90IHVuaXF1ZSB0byAKPj4+IFRD
UAo+Pj4gKG9yIGV2ZW4gTlZNZSwgZm9yIHRoYXQgbWF0dGVyKSwgYnV0IGlmIHRoZXJlIGlzIGEg
cGVyZm9ybWFuY2UgCj4+PiBpbXBhY3Qgb24KPj4+IFBDSSwgYW5kIG5vIG9uZSBzbyBmYXIgcmVw
b3J0cyBzdWNoIGFuIGlzc3VlLCBJIHdvdWxkIHN0aWxsIHJlY29tbWVuZAo+Pj4gdGhpcyB0eXBl
IG9mIG1pdGlnYXRpb24gYmUgaXNvbGF0ZWQgdG8gdHJhbnNwb3J0cyB0aGF0IGFjdHVhbGx5IG9i
c2VydmUKPj4+IGludmFsaWQgQ1FFcy4KPj4KPj4gUGxlYXNlIGRvIHRoYXQgaWYgcG9zc2libGUu
Cj4KPiBJIGRpc2FncmVlIHdpdGggdGhhdC4gVGhlIG9yaWdpbmFsIHJlcG9ydCB3YXMgYWJvdXQg
VENQLCBidXQgdGhhdCBpcwo+IHB1cmUgY29pbmNpZGVuY2UgYXMgZmFyIGFzIEknbSBjb25jZXJu
ZWQsIGFzIEkgaW5kaWNhdGVkIGJlZm9yZSB0aGVyZQo+IGlzIG5vdGhpbmcgVENQIHNwZWNpZmlj
IGFib3V0IHRoaXMuCj4KPiBUb2RheSB3ZSBkb24ndCBwcm90ZWN0IGFnYWluc3Qgc3VjaCBhIHNj
ZW5hcmlvLiBJIG9yaWdpbmFsbHkgZGlzbWlzc2VkCj4gdGhpcyBpc3N1ZSBhcyB3ZSBzaG91bGQg
cHJvYmFibHkgYWRkcmVzcyB0aGUgYSBidWdneSBjb250cm9sbGVyLCBidXQgYW4KPiBhcmd1bWVu
dCB3YXMgbWFkZSB0aGF0IGEgYnVnZ3kgY29udHJvbGxlciBzaG91bGQgbm90IGJlIGFibGUgdG8g
Y3Jhc2gKPiB0aGUga2VybmVsIGFuZCB3ZSBzaG91bGQgaGF2ZSBhIHNhZmUtZ3VhcmQgZm9yIGl0
LCB3aGljaCBpcyBhIHZhbGlkCj4gYXJndW1lbnQsIGJ1dCB0aGlzIGlzIG5vdCB0aGUgd29yc3Qg
dGhhdCBjYW4gaGFwcGVuLCB0aGlzIGNvdWxkIGhhdmUKPiBjYXVzZWQgYSBzaWxlbnQgZGF0YSBj
b3JydXB0aW9uIHdpdGggYSBzbGlnaHRseSBkaWZmZXJlbnQgdGltaW5nLiBTbwo+IGl0IHNlZW1z
IGFic29sdXRlbHkgYXBwcm9wcmlhdGUgdG8gbWUgY29uc2lkZXJpbmcgdGhlIHBvc3NpYmxlCj4g
Y29uc2VxdWVuY2VzLgo+Cj4gVGhlIHdheSBJIHNlZSBpdCwgd2Ugc2hvdWxkIGRlY2lkZSB3aGVy
ZSB3ZSBzdGFuZCBoZXJlLCBlaXRoZXIgd2UKPiBjb250aW51ZSB0byBpZ25vcmUgdGhpcyBwb3Nz
aWJsZSBwYW5pYy9kYXRhLWNvcnJ1cHRpb24gKHdoaWNoIEkKPiBwZXJzb25hbGx5IHRoaW5rIHdv
dWxkIGJlIHdyb25nKSwgb3Igd2UgYWRkcmVzcyBpdCwgYW5kIGlmIHdlIGRvLAo+IHdlIHNob3Vs
ZCBkbyBpdCBpbiB0aGUgY29ycmVjdCBwbGFjZSwgbm90IGxpbWl0IGl0IHRvIHRoZSBvYnNlcnZl
ZAo+IGNvbXBvbmVudC4KPgo+IEFzIGZvciB0aGUgcGVyZm9ybWFuY2UgY29uY2VybnMsIEknZCBi
ZSBzdXJwcmlzZWQgaWYgcGVyZm9ybWFuY2UgaXMKPiBub3RpY2VhYmx5IGltcGFjdGVkIGZyb20g
MiBhc3NpZ25tZW50cyBhbmQgMiBvcHRpbWl6ZWQgYnJhbmNoZXMuCj4gQWxzbyB0aGUgb3ZlcmFs
bCBudm1lX3JlcXVlc3QgZGlkIG5vdCBncm93IChzdGlsbCAzMi1ieXRlcywgaGFsZiBhCj4gY2Fj
aGVsaW5lKS4gQnV0IGxldCdzIHNlZSBpZiBtZWFzdXJlbWVudHMgcHJvdmUgb3RoZXJ3aXNlLi4u
CgpPZiBjb3Vyc2UgdGhhdCB0aGlzIHdpbGwgbm90IGhhdmUgYSBiaWcgaW1wYWN0LCBidXQgdGhp
cyBpcyBub3QgdGhlIHBvaW50LgoKVGhlIHBvaW50IGlzIHRoYXQgSSBkb24ndCB1bmRlcnN0YW5k
IHRoZSBzdGF0ZSBvZiBtaW5kLgoKd2h5IGRpZG4ndCB3ZSBkZWZlbmQgZnJvbSBidWdneSBjb250
cm9sbGVyIHdpdGggdGhlIGJlbG93IGNvZGUgKFdlIGhhZCBhIApidWcgaW4gb3VyIE5WTWUgU05B
UCBjb250cm9sbGVyIHRoYXQgY2F1c2VkIHRoaXMsIHNvIEkgZGVjaWRlZCB0byAKY29udHJpYnV0
ZSB0aGlzIGNhc2UgdXBzdHJlYW0pOgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3Bj
aS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKaW5kZXggNWEwYmY2YS4uYWI3ZmYzNCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3Qv
cGNpLmMKQEAgLTk4Myw2ICs5ODMsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIG52bWVfaGFuZGxl
X2NxZShzdHJ1Y3QgCm52bWVfcXVldWUgKm52bWVxLCB1MTYgaWR4KQogwqDCoMKgwqDCoMKgwqAg
dm9sYXRpbGUgc3RydWN0IG52bWVfY29tcGxldGlvbiAqY3FlID0gJm52bWVxLT5jcWVzW2lkeF07
CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcmVxdWVzdCAqcmVxOwoKK8KgwqDCoMKgwqDCoCBpZiAo
dW5saWtlbHkobGUxNl90b19jcHUoY3FlLT5zcV9pZCkgIT0gbnZtZXEtPnFpZCkpIHsKK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4obnZtZXEtPmRldi0+Y3RybC5kZXZpY2Us
CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJnb3QgY29t
cGxldGlvbiBvbiBzcWlkICVkIGluc3RlYWQgb2Ygc3FpZCAlZFxuIiwKK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXEtPnFpZCwgbGUxNl90b19jcHUo
Y3FlLT5zcV9pZCkpOworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47CivCoMKg
wqDCoMKgwqAgfQorCiDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoY3FlLT5jb21tYW5kX2lk
ID49IG52bWVxLT5xX2RlcHRoKSkgewogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dl93YXJuKG52bWVxLT5kZXYtPmN0cmwuZGV2aWNlLAogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiaW52YWxpZCBpZCAlZCBjb21wbGV0ZWQgb24gcXVldWUg
JWRcbiIsCgpBbmQgd2h5IHdlIHdhbnQgdG8gZGVmZW5kIGZyb20gYnVnZ3kgY29udHJvbGxlcnMg
dGhhdCBwZXJmb3JtIGRvdWJsZSAKY29tcGxldGlvbiA/CgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

Return-Path: <SRS0=rA+l=65=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59771C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 14:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293AD2076A
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 14:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jp9YR6Mv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ecLzY5xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293AD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n3mz324EcVM0fqO7L67ewwojNp7gtW6WUbY7JS+ZOf8=; b=jp9YR6MvvmlHLx/DZCtm0YkFV
	b/yU/B4Tx1duQJu/csiM8O86qn0r8FojfvR8mqOQaTDoogTCVtAg6j/IOoQs/i6iCHX7y/HSH7XdU
	5Eupz/+HgDYyDM14D96UuQ3QQP5S+E/6eyUQJqP+GhoBF/jw5/gqQWq/ZLcrmR6NsNRYY0ntaT6L3
	0xrTMc74W48Z0V9+hZkiBSw0LrYKlJ4CLOYXFQ4K7TI4KRTUXaISnv3K6n7/UOs3uOv8+xypnfmYI
	mCkrGkkmNaE9mw/bmPfqWnk3/pL+im10qFWIMWE7Npf/AqASuITp0dMEUr/EF82NbtlnLj4yzHNnR
	yVhWG5LAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZbg2-0008Fp-14; Fri, 15 May 2020 14:51:06 +0000
Received: from mail-db8eur05on2064.outbound.protection.outlook.com
 ([40.107.20.64] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZbfv-0008FC-Op
 for linux-nvme@lists.infradead.org; Fri, 15 May 2020 14:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFIDCk4u5VnSnyHEKtWxh9N1IXU5DcMtzIg1J2sa8GuO/jdHsz0dgSoO206w+I7OaISJt5oQugZDFb14OOPFqMJ356ggHZPGJm22jus0An8uiUBG5cTwWSP21PF11816oAGFR2MjoM200m93nEVhyMYj/wf80TEXbR3HHe/5dMGks85ObEqpo0ryW9S/FGEMfhHmDk6Bg4slmiRy/kqwT+wI5VpPZB9IA/yzXm9+QAhzzubGzUFGCRZsHD1boQ1c6sduQvX28FS7qyzqrT2nG3I9+aiVaQdNtDrjp2MWAQ8qjUav3RJRgDTwLXaNp862bhpjps/oHDstTG80h9e1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usJ47YxQTj6jeZhAoQmg0skKFc78uvDHVxjiq6375D0=;
 b=j7Xktb+pE0yO0RqLzwmMw90bf4M81IdbGzYPSDz4ZKpWZC/xTzoWV3uOi/IoBdM48CCcrADVx1Y6ewy1qak1EVexsuvKVQOOm3qzL204/G3M0CnphLMOhATpCtBdUaVAyz7yjm8IGVBB4DILhygLjTYKkwGlltmcLWLMFoY6gCJHFGUbdC7vTIe8zJZqVpuYMx5007YJR7IeED0kXC68wTKbJgCfD4Sy6PcE9LkVwNV63YwxzdSUWbrPrYw2I8oWBSeFtALIljvnr0vgk8yA6TdfvhARlnNAyKKTkcGXO2e6RailqI/m+x1/WNJQTqmDKRlhc/ChaqOWVuJaXynn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usJ47YxQTj6jeZhAoQmg0skKFc78uvDHVxjiq6375D0=;
 b=ecLzY5xhrwee5YmsqlNu7sBH1uxT/ty9+vPuuTZgcDLZ6ekJ0sgQSW8vu8XsjznIyxNTuEAj6xIH08T0vcN8pC80vjXYbpWqzqhjs6hvKbdJgUvBhgbJ4Rgpw99il0IfTKI9N5facSg3dqTz1oxaFbY3sEU4UBMHZzyh1XqCgZ0=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5956.eurprd05.prod.outlook.com (2603:10a6:208:12c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Fri, 15 May
 2020 14:50:52 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 14:50:52 +0000
Subject: Re: [PATCH 09/16] nvme-rdma: add metadata/T10-PI support
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-10-maxg@mellanox.com> <yq1r1vnw74v.fsf@oracle.com>
 <c7f3151e-a401-56f7-735f-476b01337b17@mellanox.com>
 <yq1o8qqta2l.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <4e4873ad-868a-ccd6-e4dd-456d2ad7f010@mellanox.com>
Date: Fri, 15 May 2020 17:50:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <yq1o8qqta2l.fsf@oracle.com>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::29) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM4P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26 via Frontend Transport; Fri, 15 May 2020 14:50:51 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edaadb4b-b996-4ff6-e98c-08d7f8df5d6f
X-MS-TrafficTypeDiagnostic: AM0PR05MB5956:|AM0PR05MB5956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB595618AFE4A302A01B679C85B6BD0@AM0PR05MB5956.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neRmeNkco4ec9gD9HDQjSd07Cz8AZRPx2C9m6jKqpPmK3Ie5YVOBJx4MpLDM2TtsFPfryZ5QsReIZAT8Irmz4G55IJmH5LZ+K9wY2UrRNajPnBtoNVb0QPRyQHfvv1e4Oo9cNNCTGD+yEnPZbGMs80pff5tsrWIcgq/pVhAlPJtV9tMYGZJvTmWd1Mp6xZVx/3LQfRrVF0D+QLNJZ/KRF8qRmuavtFo0ri2pfOEpRoKHF9B3e6MwCLII8bg4hzithACITVCumKqJ0ww/2VuV8Rr+7jJH7yk++7EwTy0CNyRiUH17Mivjggo8VK5MH2waxgVVckl9bEDSnO3wn3JO2Xgq7YF9f9HylTfCy1zCwNTll97CWmvK9DjwITBPxlhVtb/xL4NEEWmY+u12dPt4ujy6X+Jfzt9mtlOpzREkYldRk4JmjibPqKJMwUi+s1W2I5acp+MiakTeLD9AE1XUeE0zYpz9zR3NYhBR67ATd6CiTa0Sc90br+n6pqrOtgWD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(26005)(53546011)(2906002)(4326008)(107886003)(6916009)(8676002)(36756003)(478600001)(8936002)(186003)(6486002)(5660300002)(16526019)(16576012)(31686004)(86362001)(316002)(6666004)(66476007)(52116002)(2616005)(66946007)(956004)(66556008)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ayy8Db9HFgRA+83el/pnuFsA4m15oOTam1RayTbhN0t6kCrWQBAsMPUcwiyOk+1wFubHw0FoYhCgw6wufSUDQ7x7po55u1MJQv2QDuzJEkFrSTC4BmdWsOcZBVTl8rpILnIC+frMraNWEVEcp5oTZDyBIFdWNWVlMXdojZgaPDUCDA7tUFNT0pLuRmHkzqlkIzVrxuG62Ic+v79Xlocj1a9fi26bZHgcQpxtljqihEtSleSQlx9iNqoBBuI6pSq8jX4OMQZOla6IbD9ZYOx6INJOU1DgcqAVvaOgvKRFkRgVIywUW7jZJsDqTXUEf7vrQnhm5rMZcshrt1hQClnEOJrDjh6zEC1I4SqLjKTrbNniSL8U5ZvXpO4BGwHxgcPT7V+k4U8G/97hoBnQ0/81IoOeENvrclXgYo8uVHnoAiHY8wZoOYtdh2sB9jjQRdfiQBBVkTrYQBpsXqzpYSR8z2g6/Ll5RYbs6fV0Gggz5kXWOB4+Hpi8qcQwnyfwmYHX
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaadb4b-b996-4ff6-e98c-08d7f8df5d6f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 14:50:52.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy4Q1tmt5wmj9lPnfY56VkP8hXXI4gl1KJ2rNg4kn/xYY+c194e/Z2OUa6f3MP+CWAbMHAycwVdS7q5LI9X27g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5956
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200515_075059_883730_93DCEE3A 
X-CRM114-Status: GOOD (  18.11  )
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
 vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDUvMTUvMjAyMCAxOjQwIEFNLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3JvdGU6Cj4gSGkgTWF4
IQo+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9yZG1hLmMKPj4gaW5kZXggMDVkYmVkMy4uOWI5ZDExYiAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEu
Ywo+PiBAQCAtMTMzOCw5ICsxMzM4LDEwIEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9zZXRfc2ln
X2RvbWFpbihzdHJ1Y3QKPj4gYmxrX2ludGVncml0eSAqYmksCj4+ICAgICAgICAgIGRvbWFpbi0+
c2lnLmRpZi5yZWZfdGFnID0gbGUzMl90b19jcHUoY21kLT5ydy5yZWZ0YWcpOwo+PiAgICAgICAg
ICBkb21haW4tPnNpZy5kaWYuYXBwdGFnX2NoZWNrX21hc2sgPSAweGZmZmY7Cj4gQWxzbywgdGhp
cyBoYXMgbWUgd29uZGVyaW5nLiBOb3Qgc3VyZSBob3cgaXQgd29ya3MgaW4geW91ciBjYXNlPwo+
Cj4gVGhlcmUgYXJlIGJhc2ljYWxseSB0d28gbW9kZXMgb2Ygb3BlcmF0aW9uOgo+Cj4gICAxLiBU
aGUgYXBwIHRhZyBpcyBvcGFxdWUgc3RvcmFnZSBhbmQgbWF5IGJlIGRpZmZlcmVudCBmb3IgZWFj
aCBMQkEgaW4KPiAgICAgIHRoZSBJL08uIFRoZSBvbmx5IHRoaW5nIHRoZSBIQkEgc2hvdWxkIGRv
IGlzIHRvIGJ5cGFzcyBhbGwgUEkgY2hlY2tzCj4gICAgICBpZiB0aGUgYXBwIHRhZyB2YWx1ZSBm
b3IgYSBnaXZlbiBibG9jayBpcyAweGZmZmYgKGlmIGFwcF9lc2NhcGUgaXMKPiAgICAgIHRydWUp
Lgo+Cj4gICAyLiBUaGUgYXBwIHRhZywgb3IgcGFydCBvZiBpdCwgaXMgY29uc3RhbnQgZm9yIGFu
IGVudGlyZSBJL08uIEFuZCBmb3IKPiAgICAgIHRoYXQgbW9kZWwgb25lIHNwZWNpZmllcyB0aGUg
bWFzayBpZGVudGlmeWluZyB3aGljaCBiaXRzIGluIHRoZSBhcHAKPiAgICAgIHRhZyBzaG91bGQg
YmUgdmVyaWZpZWQgYWdhaW5zdCBhIGNvbnN0YW50IHZhbHVlLiBUaGUgSEJBIHNob3VsZAo+ICAg
ICAgc3RpbGwgYnlwYXNzIFBJIGNoZWNraW5nIGlmIHRoZSBhcHAgdGFnIHZhbHVlIGZvciBhIGdp
dmVuIGJsb2NrIGlzCj4gICAgICAweGZmZmYgYW5kIGFwcF9lc2NhcGUgaXMgdHJ1ZS4KPgo+IExp
bnV4IGJlbG9uZ3MgdG8gdGhlIHNjaG9vbCAjMSBvZiB0aGUgYXBwIHRhZyBiZWluZyBvcGFxdWUg
c3RvcmFnZS4gSSdtCj4gbm90IGVudGlyZWx5IHN1cmUgaG93IHRoYXQgd29ya3MgZ2l2ZW4gYXBw
dGFnX2NoZWNrX21hc2sgPSAweGZmZmYgd2hpY2gKPiBzb3VuZHMgdG8gbWUgbGlrZSB5b3Ugd2Fu
dCB0byB2ZXJpZnkgYWxsIGJpdHMgaW4gZWFjaCBhcHAgdGFnIGFnYWluc3QgYQo+IGNvbnN0YW50
IHZhbHVlLiBCdXQgeW91IGRvbid0IHNldCB0aGUgY29uc3RhbnQgdmFsdWUgdG8gY2hlY2sgYWdh
aW5zdC4KPiBXaGF0J3MgZ29pbmcgb24gdGhlcmU/CgpZb3UncmUgcmlnaHQuCgpJdCB3b3JrcyBz
aW5jZSBhcHB0YWcgaXMgYWx3YXlzIDAuCgpUaGlzIGNvZGUgd2FzIGJvcnJvd2VkIGZyb20gaVNF
Uiwgc28gSSBraW5kYSBhc3N1bWVkIGl0IHdvcmtzIHdlbGwuCgpUaGFua3MgZm9yIHRoaXMgcmV2
aWV3LgoKSSdsbCBmaXggaXQgZm9yIGlTRVIgVUxQIGFzIHdlbGwuCgo+Cj4+ICAgICAgICAgIGRv
bWFpbi0+c2lnLmRpZi5hcHBfZXNjYXBlID0gdHJ1ZTsKPj4gLSAgICAgICBkb21haW4tPnNpZy5k
aWYucmVmX2VzY2FwZSA9IHRydWU7Cj4+ICAgICAgICAgIGlmIChjb250cm9sICYgTlZNRV9SV19Q
UklORk9fUFJDSEtfUkVGKQo+PiAgICAgICAgICAgICAgICAgIGRvbWFpbi0+c2lnLmRpZi5yZWZf
cmVtYXAgPSB0cnVlOwo+PiArICAgICAgIGVsc2UKPj4gKyAgICAgICAgICAgICAgIGRvbWFpbi0+
c2lnLmRpZi5yZWZfZXNjYXBlID0gdHJ1ZTsKPj4gICB9Cj4gcmVmX2VzY2FwZSBzaG91bGQgcmVh
bGx5IG9ubHkgYmUgdHJ1ZSBpZiB0aGUgbmFtZXNwYWNlIGlzIGZvcm1hdHRlZCB3aXRoCj4gVHlw
ZSAzLiBXaGV0aGVyIHRoZSByZWYgdGFnIHNob3VsZCBiZSBjaGVja2VkIGlzIG9ydGhvZ29uYWwu
CgpXaWxsIHRoZSBiZWxsb3cgY292ZXIgdGhpcyBpc3N1ZToKCnN0YXRpYyB2b2lkIG52bWVfcmRt
YV9zZXRfc2lnX2RvbWFpbihzdHJ1Y3QgYmxrX2ludGVncml0eSAqYmksCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfY29tbWFuZCAqY21kLCBzdHJ1Y3QgaWJfc2ln
X2RvbWFpbiAqZG9tYWluLAogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUxNiBjb250
cm9sLCB1OCBwaV90eXBlKQp7CiDCoMKgwqDCoMKgwqDCoCBkb21haW4tPnNpZ190eXBlID0gSUJf
U0lHX1RZUEVfVDEwX0RJRjsKIMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5iZ190eXBl
ID0gSUJfVDEwRElGX0NSQzsKIMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5waV9pbnRl
cnZhbCA9IDEgPDwgYmktPmludGVydmFsX2V4cDsKIMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2ln
LmRpZi5yZWZfdGFnID0gbGUzMl90b19jcHUoY21kLT5ydy5yZWZ0YWcpOwogwqDCoMKgwqDCoMKg
wqAgaWYgKGNvbnRyb2wgJiBOVk1FX1JXX1BSSU5GT19QUkNIS19SRUYpCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZG9tYWluLT5zaWcuZGlmLnJlZl9yZW1hcCA9IHRydWU7CgogwqDC
oMKgwqDCoMKgwqAgZG9tYWluLT5zaWcuZGlmLmFwcF90YWcgPSBsZTE2X3RvX2NwdShjbWQtPnJ3
LmFwcHRhZyk7CiDCoMKgwqDCoMKgwqDCoCBkb21haW4tPnNpZy5kaWYuYXBwdGFnX2NoZWNrX21h
c2sgPSBsZTE2X3RvX2NwdShjbWQtPnJ3LmFwcG1hc2spOwogwqDCoMKgwqDCoMKgwqAgZG9tYWlu
LT5zaWcuZGlmLmFwcF9lc2NhcGUgPSB0cnVlOwogwqDCoMKgwqDCoMKgwqAgaWYgKHBpX3R5cGUg
PT0gTlZNRV9OU19EUFNfUElfVFlQRTMpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZG9tYWluLT5zaWcuZGlmLnJlZl9lc2NhcGUgPSB0cnVlOwp9CgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cmxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

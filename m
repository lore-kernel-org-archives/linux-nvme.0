Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2973C54FCB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 17:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EC720728
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 17:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cJLZJEHE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CjYxLb6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EC720728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nxa0T9JRxOOOPHq15dRY+u4uVrdfBiS8McclBJnVLUE=; b=cJLZJEHEMvIiB2k7kEmoFFMq7
	hFMwHGRaEqoGnMw+oUb7g7fDUrYErBIOiIvcEZie+dQsWX+na7Am10NjxvrZ3HJ7fi3lki6nXmfti
	qfRoInhEQuvbPruYATRS9xtHGpEbx/iO2iIgGCTPhTYhxQM2fFEKUv+lQXZE/EM84i5eEMNOdzVlN
	7qITXSgyUXxmfOhKTaP0PztM/+y/VhadI8PcmIGj2CIHvbxlAbP6W63nFGRjWQZHLX/pTDTXfa4bk
	PUpUjDXS+U8VMTLAn20Fq87XNCndRUWlYcUsNcPxVBbXIKrNMIWTlwr6QpQSLnpw+ALZo9xOas5V2
	z4WzZUVYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRfbU-0002Fq-BU; Thu, 23 Apr 2020 17:25:36 +0000
Received: from mail-eopbgr150042.outbound.protection.outlook.com
 ([40.107.15.42] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRfbR-0002Dk-IL
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 17:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpHIAbwAEWRNGBEtgmkPvjlZuWFjPS9hQO7gJcfDKE9MalMLwzRsqwjZe7IiM5NrEbNqDPrCSsaplHa78FHuurtRteUxhLjFX4i70YoJnMd42cCByee7SsOT8x55LsVdGxubCgmaKZOQjURvvUDC53+utHeZgv9d/1dLR4q0P/2+GqZCFGBsvEXH178rIk0XotnDGpfuKI4G4LlsROiqgBERQRe9ppbNuOTiu56TKHhDID2798KbmBpzmnaNRJ15CxgXo2uv8NtGmRYjQ9+8U5ZAKioGdB26F3dwt6p4071ATHX2MbvE+1hrWqt9HfnPcXdk+aUk5P2hoai3/CIEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULK2bfwWsSqrPzmu/DHztonew4eaPP9mK9InQNCVMM8=;
 b=HhVdrqpNmZyINFgS9HuMIhiA+c259+W3h8fY9fcN9NRwyODFFYZRGxdoTRR0R1knjiOy9Yr94BDyi/DLNU73ONsFeBl6nk6BSaJ0eYtvCPzw3YzqGxirOQ3Wn7Gm/g+w4DUrr3U2OoJJrnlgxUCwjsMKQdc4lCl/fLJr2ZIsuoWMMqB02grMufzPQ2Cq8GTAQjdFzkHL72WNrO6QYshI1yMoKLg2tpeeaaAnmYdP616IGcV5+xf+Tkg3dkRBR6syKbsFOWHyUFSR+AHXbMCvfULwvTMG0WtEtQdcB0VZ/1d3cexXpzDcirov/Evn2fnD89hwsltLBTistyVFvuFdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULK2bfwWsSqrPzmu/DHztonew4eaPP9mK9InQNCVMM8=;
 b=CjYxLb6XfiWuUqu/oEEOFSgHlh9eq9YNBs8vh91m6oU5qpfBgmrMdDWU/TvFvzIH6PdzTlsM/Gn10kioOt27eQ6AX4FwEi/1gMKDUlq0V+oc29kOU/e5UEIBLhkXX1LScaEr9k4l0ippHcpnQsiH5sbrNHL2OTXhxtYbi6LFRyQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6388.eurprd05.prod.outlook.com (2603:10a6:208:146::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 23 Apr
 2020 17:25:28 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 17:25:28 +0000
Subject: Re: [PATCH 15/17] nvmet: Add metadata support for block devices
To: Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-17-maxg@mellanox.com> <20200421153339.GF10837@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3992e1fd-efad-0679-7817-f004b40cdc76@mellanox.com>
Date: Thu, 23 Apr 2020 20:25:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421153339.GF10837@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 17:25:26 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efed7b26-4c67-4287-d70e-08d7e7ab512f
X-MS-TrafficTypeDiagnostic: AM0PR05MB6388:|AM0PR05MB6388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6388F957D3E02575A8D25838B6D30@AM0PR05MB6388.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(16526019)(186003)(4744005)(86362001)(478600001)(2906002)(2616005)(81156014)(4326008)(8936002)(956004)(26005)(53546011)(31686004)(8676002)(66946007)(31696002)(66476007)(316002)(36756003)(6916009)(6486002)(52116002)(107886003)(5660300002)(16576012)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKMNJaY1kUoH9IkR3a6MuBGj2m/RWQm4RBay/RuNKO9cDKug/t+rcHvza923dwHw8bY2c4954tuC3T+Lh3x8ApdsvcNTZaKp9fBoApUdsILRm+AgohQ8TkQLFTYmkDQth8GZj2JwdzaY56fuZj6m3BG5TTv+hmRTPSWbigFRfEFaPkGnzysH7HgDisTIsdZDGuxYnrSrKTtaZeALo/LU29V6gXE07ZPrWb3WuQK+4oHxkdD0aeYotZYo6802/IXZb2Mq7JBo6dLN6/AcEnL+bkSO6/YeCOOXqcPFbGD0Yzyvs29Orb2rJkUcrkViKmfA5plnncnYhvQ/+4cpK1bcM08nwXfxSYD9dx1S2iA9npxRJuEsOIUluvomlPqE7pTdgqQvhkwYnPw5bKBUyXabtoN8nRMa4SEPlYlETipuoUSLHQdROAP/1oXymOi11fa6
X-MS-Exchange-AntiSpam-MessageData: 6d6y1OHVtOjWEuAJ4KCfccO3NVtaksADRqO0dgdV93r/yBv7RFN4vzciz4ktk6g/KHdIzHoWCKAdIxtokbgXheRKy8ZrkyvgyI34POWC1Q5mVwLwAbOVZOcUa4R2bzAOlHU8p45m922Nv5G9nrmC4jShv5j0qOG+fnjDzBdeYkQ09ZQr6EqNghYAsvVXG2uuyXibf3lqGf3pj2hzn2gJ5bkWSdh6lUVaQUDqhUayVkq9fV42gthbaWtF7wP7hNM3fajmGA+1HSWASsr0Z6rv8JCD9vF1qGlOo8f65lozMcqSt+2kzT1tXnCftVfi7s+SlmBWrOow04k5eFlsMJ250U8Sefgabl+oG01niQnuND0+xlScl0HzMVfIVVbD2kKBKTCbDkAX12OOZlgQpNSYW/ZuuxaJ7Q52Uft8XuXvSAOJpLY3oreS4SfxH5u53HHK8IwUJ8LM4Y5U5dVI3UFFiS/orVoIYwP1vidQTSa4ZSwsNDAqszwQQspv+N6FRKx9Gmq3M8Okb1QPIJ4cvRbLiGre8TREmBhWXDZV1lY6kP95QxN2RReH6aXsodnXHj5TSb+OOKNP9PLvj39AwQmWv7wYgAAEGiEZLXdf1q8Bx/EpGmAcTmbVcp9fJuy4negu14Q2F6XrUWkXACJ2DV4gtUVuy+0ycEP0PomM0Ce7pIBMPgV9h/dkl/G82Ub3JVIV4GbHAHLa6trpfo0Ik4+Cgx6KH4cVeq2g43k9gZvgaLCSEnkpCFcYeoFht9YTTxJMdDnZjPhDk1x8rB0lsDLGZ7m+xL+iSirbR5RmulQncz/ppmscKB/YiTtHv8mS6AjI
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efed7b26-4c67-4287-d70e-08d7e7ab512f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 17:25:28.8585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL0dguBxhN3D/V0AB9oBe6PQXggptp/AFH5T2aY5+moIvABWD44sgSGThwRz9OGelDbH53Wudxm7KoeSI2uKpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6388
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_102533_667194_742756E1 
X-CRM114-Status: GOOD (  10.74  )
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

Ck9uIDQvMjEvMjAyMCA2OjMzIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmks
IE1hciAyNywgMjAyMCBhdCAwODoxNTo0M1BNICswMzAwLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+
IC0JaWYgKCFudm1ldF9jaGVja190cmFuc2Zlcl9sZW4ocmVxLCBudm1ldF9yd19kYXRhX2xlbihy
ZXEpKSkKPj4gKwlpZiAoIW52bWV0X2NoZWNrX3RyYW5zZmVyX2xlbihyZXEsCj4+ICsJCQkJICAg
ICAgbnZtZXRfcndfZGF0YV9sZW4ocmVxKSArIHJlcS0+bWRfbGVuKSkKPiBTaG91bGRuJ3Qgd2Ug
YWxzbyBjYWxjdWxhdGUgdGhlIGFjdHVhbCBtZXRhZGF0YSBsZW5ndGggb24gdGhlIGZseSBoZXJl
PwoKd2UgY2FsY3VsYXRlIGl0IGR1cmluZyBudm1ldF9pbml0X3JlcS4KCgo+Cj4+ICAgCWJsa19z
dGFydF9wbHVnKCZwbHVnKTsKPj4gKwlpZiAocmVxLT51c2VfbWQpCj4gQ2FuJ3Qgd2UgdXNlIGEg
bm9uLU5VTEwgcmVxLT5tZF9zZyBvciBub24tbnVsbCByZXEtPm1kX3NnX2NudCBhcyBhCj4gbWV0
YWRhdGEgc3VwcG9ydGVkIGluZGljYXRvciBhbmQgcmVtb3ZlIHRoZSB1c2VfbWQgZmxhZz8gIE1h
eWJlIHdyYXAKPiB0aGVtIGluIGEgaGVscGVyIGZ1bmN0aW9uIHRoYXQgYWxzbyBjaGVja3MgZm9y
IGJsayBpbnRlZ3JpdHkgc3VwcG9ydAo+IHVzaW5nIElTX0VOQUJMRUQgYW5kIHdlIGNhbiBza2lw
IHRoZSBzdHVicyBhcyB3ZWxsLgoKSSdsbCByZXBsYWNlIGl0IHdpdGg6CgpzdGF0aWMgaW5saW5l
IGJvb2wgbnZtZXRfcmVxX2hhc19waShzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCnsKIMKgwqDCoMKg
wqDCoMKgIHJldHVybiByZXEtPnNxLT5jdHJsLT5waV9zdXBwb3J0ICYmIG52bWV0X25zX2hhc19w
aShyZXEtPm5zKTsKfQoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK

Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1AAC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 09:40:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC38206C3
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 09:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tfaujCBv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="egjOpFTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC38206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y48CsZP/LY2zEqXZN6ynkWQyAHNsN4rMf4c6DOK8cv4=; b=tfaujCBvDOEhux81axKPfTFCZ
	ZpJj1deadaDbSYEVrQd7HvXzfTeDbeiAjuwBVaqkjHUUdnqn5AoAEyvcpwPdAQNdv0QLuqxe2DwUB
	7TUkGfeVS0IlKYEx23xeVAPqqIlLdG08VVEKeysIUMlTZ6ILMrJfHBXemaS8Ij6XlWV5CgXTXu6vh
	E6izfqoEAz86vEzcujKqyStqevTylErCanE9gdC/TExXhyF3J3QMa9MTgtiM9+CeYnCbazeLyWNGS
	GwilD5wJj6VRyTUyrdVHWyrU5I7g+QZeY8YnCmP9fy25K1WKaNnM+5kgADagSUuWSoKNgRJQqc93L
	hjVRk+yXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgmLw-0003fR-BT; Thu, 04 Jun 2020 09:40:00 +0000
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com
 ([40.107.21.62] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgmLu-0003eq-3q
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 09:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4KK/Nu/s76ll/Yh/IRvaQ9KwUgyX1ITSD9TJX/Qpye2H5+R6vfnPvc3/BeAZLfByCRYfXLRZpascBXUr4wmWs9l+VcsgLVG9/+M9EtNJeCmTnkGEjsvrhxqQlSpw1A0eIgcagEtgTUX+ZQmHbglhLCWAhnrYxXEhD2o89I+eKZuvh4WITwF9RMs6K2qs92Wvq/iPUlcb8cvTItoTXf9P6M/z3yAEVrEfqayMA1uInm3UI+NKz3K1SqNU2GjcNHb8s9aj4gVG3+5nq9JltjbawTMGrYERvDJyPk2YoGo9xoNSKWCaDCSRkqGUyflWuLTj7XdKiMBMQlHpmWiXcPGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I0kw5N46IrmxA/BLd07b5kSn8vi9W6GWaPRRAICpuI=;
 b=kABuDaYUPVhTHES6HwMzI9wt4nVX+aNzUT6iPgoJhIthN32rVBpEhKmnr1Y9iNYTS1UN4MMh8xVKtvvL64s3ULqEmIX4Operh4Tw3yHEMndVHORMoh8QdlXXgR/iI/FjIt3lrLBLMWyGix0z9ARzewHEKTpg4T+yQT32rBtWUlj8thTXuXh3uwoH+FO78ba5TSR9eMo2tm2Ilq2mDCad905AmSNXMYGnoOuK5naoPq446gw+exFHMC2dSVWqxL2X/fiu0fconwp6R7NzNor0J5lc7H92TEQkyXn+apQG+Ep52CjXRZYIWvsoJq7kGTXKdCRyjYQJJTqL7LiqdVeAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I0kw5N46IrmxA/BLd07b5kSn8vi9W6GWaPRRAICpuI=;
 b=egjOpFTi+rLb1Ol+WT+ssM5mmCMGxBw6bIHziJNqV/RRLBm9vb1OoyDmDPKBnKdJdbOHG+Wrz8bm2kBTrBgskWB90bbclHTDY0nCC5jlXrGn+6wbguwpuu0s4ng6TbnW21Ztda95qnngqPRoaU5aWRWy82NKVWCo8IiHf1b2cco=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4257.eurprd05.prod.outlook.com (2603:10a6:208:63::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 09:39:54 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 09:39:54 +0000
Subject: Re: [PATCH 1/5] nvme: introduce nvme-types header file
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-2-maxg@mellanox.com>
 <fe6b0f20-6fc9-9e77-b943-6f122bed9870@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <328aa2cb-776d-76b7-61b4-89fc0af5473c@mellanox.com>
Date: Thu, 4 Jun 2020 12:39:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <fe6b0f20-6fc9-9e77-b943-6f122bed9870@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0054.eurprd05.prod.outlook.com
 (2603:10a6:200:68::22) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM4PR0501CA0054.eurprd05.prod.outlook.com (2603:10a6:200:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 09:39:53 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aac4dc8d-9571-4e4c-fa4e-08d8086b3c9f
X-MS-TrafficTypeDiagnostic: AM0PR05MB4257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB42573F1A81C7BD1F6C8A78A4B6890@AM0PR05MB4257.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+aHqfgkHSIyEskbQQcNKxbduOxnFXN4tYd1D91HXlTb9ee4/SjGfbxqvJjzAfJ+BOBEf1mHiO4NomyJ3jRu00hEdujRhHxlQnmSL9AFBx3gspTEiRg3ie5WGioTOcOZNW6/QZ6GNDjDAIAOenHryW/v7UtBYCyMKwGCXw5HDJQPVVyHILOPGo2X6awgYCW/BAHXiqGGVNVGsLsDCLrnGEhrQs8ocgRUWBf8qT+8aO8rBJ59EBHfCn1dHsrNKrUTPZkVAKfHexk3lk9VaTa1DViXC1N9vCF4IJj96y/ufxdeq2oisfDQ7N8ASQHpBtGGJ9xAw0QBPcTkyi7cKOmd3niP8lKp349XMNe/7MyK9u5t4/pNwcI70AayVn2C24Rg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(5660300002)(186003)(16526019)(4744005)(86362001)(6486002)(53546011)(31686004)(52116002)(2906002)(31696002)(66476007)(4326008)(66556008)(66946007)(8936002)(956004)(16576012)(107886003)(316002)(26005)(2616005)(478600001)(36756003)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ee8VVNS2Iuot9aB+Yb+DL2vJy2sWzAQEKYehcmgFl0dpZFxuapN4aSmNh67670mY9urOG3lBOGoUyx/2MdKQ59GyGeZQB0ahf/9Retw0QogWdd4byPUhsE+Fe2i9XvJbvBRIXQU0Ud35pbDuiKuY1LlRce1rpSlBjFQ+iVFU0CRWYeBL89HGcuVvKL7Tw2c7y35jmG9qv6Y3Vcbi/1p8NgfMTtNPtxfalKyikslrqj1yB5GXITfmT2bmhf7dTIheODrzvLSjEB1wZLLqnPG9mnl4z349AsdLWV11rvtnlR2SE1cAQL9x45QFk+p5nV/GDgXiyD0VXsTDLVOkWhJyKYXOjZFHJivjkZsuO57Lz37PBhwngyysZYTDiKpuLY7VihDIbFMNqfUw7DAOlt8LwQVtTZ49GR8mO3dWaKXwvwKRg7gph0Y/HuVWOQjkoQ3wuTNmjERE2wf4tGiJgUWcisYYleJdZcvb/iIwjWdLHKnRhiFiPefsOOpfmwHd6ji/
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac4dc8d-9571-4e4c-fa4e-08d8086b3c9f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 09:39:54.6864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/9bRAzw1XhPQWnhkyobbf8SPrfho4NIg6vkbFdy0etSUCopKo1sFK6w7ef4wTX++K0anhf371hLPdmUTbID1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4257
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_023958_187925_0B761867 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDYvNC8yMDIwIDEyOjE4IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+PiArc3RydWN0IG52
bWVfdHlwZV9uYW1lX21hcCB7Cj4+ICvCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoCB0eXBlOwo+PiAr
wqDCoMKgIGNvbnN0IGNoYXLCoMKgwqAgKm5hbWU7Cj4+ICt9Owo+PiArCj4+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG52bWVfdHlwZV9uYW1lX21hcCBudm1lX3RyYW5zcG9ydFtdID0gewo+PiArwqDC
oMKgIHsgTlZNRl9UUlRZUEVfUkRNQSzCoMKgwqAgInJkbWEiIH0sCj4+ICvCoMKgwqAgeyBOVk1G
X1RSVFlQRV9GQyzCoMKgwqAgImZjIiB9LAo+PiArwqDCoMKgIHsgTlZNRl9UUlRZUEVfVENQLMKg
wqDCoCAidGNwIiB9LAo+PiArwqDCoMKgIHsgTlZNRl9UUlRZUEVfTE9PUCzCoMKgwqAgImxvb3Ai
IH0sCj4+ICt9Owo+PiArCj4+ICtzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKm52bWVfdHJ0eXBl
X3RvX25hbWUodTggdHlwZSkKPj4gK3sKPj4gK8KgwqDCoCBpbnQgaTsKPj4gKwo+PiArwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKG52bWVfdHJhbnNwb3J0KTsgaSsrKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAodHlwZSA9PSBudm1lX3RyYW5zcG9ydFtpXS50eXBlKQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbnZtZV90cmFuc3BvcnRbaV0ubmFtZTsKPj4gK8Kg
wqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gImludmFsaWQiOwo+Cj4gV2h5IGRvZXMgdGhp
cyBuZWVkIGEgbG9vcD8KPgo+IG1heWJlIGp1c3Q6Cj4gwqDCoMKgwqByZXR1cm4gKHR5cGUgPCBB
UlJBWV9TSVpFKG52bWVfdHJhbnNwb3J0KSAmJiBudm1lX3RyYW5zcG9ydFt0eXBlXSkgCj4gPyBu
dm1lX3RyYW5zcG9ydFtpXS5uYW1lIDogImludmFsaWQiOwo+Cj4gU2FtZSBmb3IgdGhlIHJlc3Qu
Li4gCgpJdCB3b24ndCB3b3JrIHNpbmNlIGkgIT0gdHlwZS4KCkkgZGlkbid0IGNoYW5nZSBsb2dp
YyBoZXJlLCBhbmQgbWFpbmx5IG1vdmVkIHRoZSB0YXJnZXQgbG9naWMgZm9yIAp0eXBlX25hbWUg
bWFwcGluZ3MgdG8gY29tbW9uIGNvZGUuCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK

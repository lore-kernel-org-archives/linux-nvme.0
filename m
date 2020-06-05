Return-Path: <SRS0=Oz+k=7S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AF9C433E1
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 23:00:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D85206A2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 23:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oLq1Akc7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PrBVMTZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D85206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cUzc8HJick7pEIE6eH4GgLqPK/uwEXY4wFfkwkQ61NM=; b=oLq1Akc7Emwu9TIY8cQiBaQVe
	3zCZB8Sh5fRzoTSSEZXRJIDHHEjzCSiL8A50zwl22sea1HZOecadoZvbkMZ2lMbywMpu0ZlJcbDDs
	migrbDAr8aq4Dln5ma43AZaIOdKJNGLOae5+6zhnU7t76qEEPnahqwG535KbpH7R9d30BOqnb+o+a
	kHMPdS6z9ntmTwvfFUvuo8eQQrFXbCF35gzd2d9DGyPPgR6GF+dFJrH90NiOSZ1Mx+c235i4jzaaW
	utC/ZVPeGxw1NYUIL/WtVxj+w2kq1l1xWRjdhQbDFwddfCQ8DZDNBlLQmsoQO6uzuX/aIfrSqRzJu
	sC4gHUI2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jhLJv-0002aA-R5; Fri, 05 Jun 2020 23:00:15 +0000
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhLJs-0001NP-CE
 for linux-nvme@lists.infradead.org; Fri, 05 Jun 2020 23:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0iIqVU50DqUYeKobQL2y8zU3IAbd0RQx7SR75+2EsvP4z+eBxooJZ4dYKPVbtD7GDkYtwFbB/cgHQiHMinag4HrZdQ7O8WWP6xSwwyQTHJ3K3yOYB/j2+nSQ+3YzUZ8b9f0XjaLq5KYYgMopAaKbalRsN7B7kE0HzLGc371uBG86oWqfYkHwaWdnVlTO7HBFBAj+XsXGFa0ok8zfyHDGmyRfsnO1PmjVwVVtzSW6tc7dxVBY+4rKsSb6f5TSziTPkmnGnzRQ4ByMXZ83vJ/3sTJIr00nISQqi7m0VLgOLfYZdVvYVghpKusm509eFSdOsta34HcCYUgdXgMaWIPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVY0LrnEL0Q6X5SMjcHjl/ioCusojnURiBuNvCMcq3c=;
 b=ShOJCAZXE31HE4WedtPw6bju1wkMVPx+XC7oQTEeHkWxK26IHRwtCguINjLWIBcfeoNHtCLno2rCBswuVgxj5bjVIxzKmi75rR+yAx0zqgqBvWOe+wwLkRp6hdBdJ4/ur9RxxHb2agN1c3wQ3zFeTJWHzpYQ+yzqlZaB9FDZKdC4W17krdyiUIiAXz9HxioZDl7HfVJLj5XZYYzmG75PSbwLos3SyxC3/8hYd7xbiFo7C/pYvzhmtZ9Rea7W363ciXW6NwIAVsIXZ7ZjcLp/68Z7lE8rZaX9JQsRX9tcDPDNIBVX9kjjixiu6jjA9Zm/xmsZoQprzyK0Vk85msTJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVY0LrnEL0Q6X5SMjcHjl/ioCusojnURiBuNvCMcq3c=;
 b=PrBVMTZeGqt9efkri7LvSJ4xihPqq08EBLQWqiDEKzieypMBPBU2OvARf+kOTDcPCX3pDPnNx7CII+cVvV7DuPDKXBCjw0sbd7ADwwe4TEnuJEYmmZm8vX8vGnBNUysxzyr9n+tYnKuY253P3HHgMKM0tCCIh8qfK/UWjC2xM7Q=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6660.eurprd05.prod.outlook.com (2603:10a6:20b:151::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 23:00:06 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3066.023; Fri, 5 Jun 2020
 23:00:06 +0000
Subject: Re: [PATCH 1/5] nvme: introduce nvme-types header file
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-2-maxg@mellanox.com>
 <fe6b0f20-6fc9-9e77-b943-6f122bed9870@grimberg.me>
 <328aa2cb-776d-76b7-61b4-89fc0af5473c@mellanox.com>
 <9ba5fbf0-e457-73be-cd30-dc0dd8f095d1@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <30bc86da-1777-76ca-deb9-c7133c993b0d@mellanox.com>
Date: Sat, 6 Jun 2020 02:00:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <9ba5fbf0-e457-73be-cd30-dc0dd8f095d1@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:200:89::30) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM4PR0202CA0020.eurprd02.prod.outlook.com (2603:10a6:200:89::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Fri, 5 Jun 2020 23:00:04 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01135ae1-63b8-42a9-8242-08d809a43011
X-MS-TrafficTypeDiagnostic: AM0PR05MB6660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6660D14B00E72B1943391F8FB6860@AM0PR05MB6660.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7log+2B1fuTWpDsRuXHY/J2WTJQjRgm6h/pFvII8/szX//UurqWtIP7xiAex2FzR8dvVUxn33U8yFo2x2iMja4NoufXCj8PKYLbHUzE7tDx3n6yHjy0ebuK4EPrdm1Q4bG+VUJb9XyCQBchevsD3PbDoTDDMgqbTqoLqD9S3Q8FTZkwt3iMWq1b1c8cS8NIh915jlT23hexESXVE3GwmicI3kax8KtXEfgyMvjuxZHMstwxkqcBfuzsN8EclzYAECAw8qwzXfbx3zW69aCKIm6pU5fbMO+Buirm9D2NlR7X1ro1fjQCNC6BQX8zP7EhsMSCw39EE39Sa7sdMK4jK+6p2VK9Z8UiAmXi9J40NdUUjIgxpxCPpjoxDKVKsSVN6itjOAF9Qae2hHQwD3o0HU/VGrnd+Omt1bj/Hg+sIq3q4xvNTfB8MOk2wwCX1ZGj8ZSLsdBG5obhRl89hKssKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(4326008)(966005)(86362001)(2616005)(53546011)(52116002)(8936002)(66476007)(66946007)(45080400002)(478600001)(31696002)(186003)(16526019)(26005)(6486002)(107886003)(956004)(8676002)(2906002)(31686004)(5660300002)(66556008)(6666004)(36756003)(316002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ocULuqSq5pOVWYynXu47sVsI+33fbfPpX2PNxfFmSdNLxr8FzSzRJLTJTxslxUK9s139uSPowEwHwMn63fZLhbjb4TYuC3AwiXwqvtV3GgIuH4/uelXExiuVdlsU/8SzIXVAGv+d1px1uAqVNQRyaF+32ZA92CImFxi9gf5/f3vkEYYKkkbzOfXluzzE6KSqH/MdB/5DmHL0WVshR61nT8ZgpRnK20lh+ApeHpswGYOtENzJerljDN4McOsFhWBDy3W0FijtQTsvVv5ln69UYJCsZEMDhmc5Mor/eUgdO3z7dHtOhmuIaovQ2g0Q0/H6EywNiNoBhMqIzdiWSKGCGfhc0F24iPFThXcGPaTkfGXlYaNgMh9lAoML2G294fIq9QqAySGOdx8ATjDO8QBR4+tVheGYsR3wW24k8FDbHyUZVx3bcSWQ+yK7T9YTkXgmFvkgUjhZKf3iYu+UlTNJsNpXqdRmGRlwZhYS2c9oRtcju4vJyMElI5ZWUOny18he
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01135ae1-63b8-42a9-8242-08d809a43011
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 23:00:06.1374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvnaHADGXj/HaoO3/TnkMBQaZTa9S7xo696K1jdNrFjO63PNRBpnRy6c+8ZrH/WMID4I3BuT50/8GzJwAq5nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6660
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200605_160012_472491_4EBCBB9D 
X-CRM114-Status: UNSURE (   9.17  )
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

Ck9uIDYvNS8yMDIwIDExOjAwIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+PiBXaHkgZG9l
cyB0aGlzIG5lZWQgYSBsb29wPwo+Pj4KPj4+IG1heWJlIGp1c3Q6Cj4+PiDCoMKgwqDCoHJldHVy
biAodHlwZSA8IEFSUkFZX1NJWkUobnZtZV90cmFuc3BvcnQpICYmIAo+Pj4gbnZtZV90cmFuc3Bv
cnRbdHlwZV0pID8gbnZtZV90cmFuc3BvcnRbaV0ubmFtZSA6ICJpbnZhbGlkIjsKPj4+Cj4+PiBT
YW1lIGZvciB0aGUgcmVzdC4uLiAKPj4KPj4gSXQgd29uJ3Qgd29yayBzaW5jZSBpICE9IHR5cGUu
Cj4KPiBZZWEsIHdvdWxkIGJlIG5pY2UgdG8gZml4IGl0IHNvIHdlIGRvbid0IG5lZWQgdGhlIGxv
b3AuCgpJJ20gbm90IHN1cmUgdGhhdCB3YXN0aW5nIG1lbW9yeSBvbiBhcnJheXMgdGhhdCBhcmUg
YmlnZ2VyIHRoYW4gbmVlZGVkIAppcyBiZXR0ZXIuCgpOVk1GX1RSVFlQRV9MT09QwqDCoMKgwqDC
oMKgwqAgPSAyNTQKCk5WTUZfQUREUl9GQU1JTFlfTE9PUMKgwqAgPSAyNTQKCkkgY2FuIGNyZWF0
ZSBpbmxpbmUgZnVuY3Rpb25zIHRoYXQgaGF2ZSBzd2l0Y2gvY2FzZSB0aGF0IHdpbGwgcmV0dXJu
IAp0eXBlX3RvX25hbWUvbmFtZV90b190eXBlIG1hcHBpbmdzIGluc3RlYWQgb2YgYXJyYXlzIChs
aWtlIHdlIGRvIGluIApudm1lLXJkbWEuaCkuCgppcyB0aGlzIGJldHRlciA/CgoKPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKPiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwczovL2V1
cjAzLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmxp
c3RzLmluZnJhZGVhZC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZsaW51eC1udm1lJmFtcDtk
YXRhPTAyJTdDMDElN0NtYXhnJTQwbWVsbGFub3guY29tJTdDODQ5Y2FkMGI5MjQyNDAwMGEwODgw
OGQ4MDkyNjkyYWQlN0NhNjUyOTcxYzdkMmU0ZDliYTZhNGQxNDkyNTZmNDYxYiU3QzAlN0MwJTdD
NjM3MjY5NDA4NTYwNDkzMjQyJmFtcDtzZGF0YT15NFBZakhCQ1dFem02UXpWSVAlMkZ5aGF0VERS
QVZZdnhNZnp0b3NJTjhwenclM0QmYW1wO3Jlc2VydmVkPTAgCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cmxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

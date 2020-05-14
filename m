Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A020C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:56:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72E3206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t3n0zzhq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="sd3SeYG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72E3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O2LLwtRHHK/AVyVkJ0FjuPseT68Me/Cp0hRgQ03tumU=; b=t3n0zzhq/rTti4ka8A9nxoGRf
	5N/XB94MgDjM6s7Ffzt093VA7ZZA/iTImautmErkD+Hdf1p44K2WyZ4SvpXLid6ovhAJDEzd6bkEU
	TUGzq4sSbT4OQh8J2/5S25KykSDeMM0oVwbgPlDY+e/SIiFvZVqYFVGwwoBr0fs89aq6MJgLodtdY
	+qWPrVOmrSUhbwb3yyjmVqstIIkxNPIhd8NPjztlMm6dJ/TQsw+SrOyvfYHxixJ/ruIrhiUKZgMb7
	D79CSC4gI4gcetYCqNBFLb+LzVC+Gq5iiNmSOcSGzux9EKGFDR15e2jJoEOxFKHlbwNexUQIGD71I
	apTd0layQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ9eo-0003fH-5I; Thu, 14 May 2020 08:55:58 +0000
Received: from mail-eopbgr140042.outbound.protection.outlook.com
 ([40.107.14.42] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ9el-0003eW-DI
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 08:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulx4CM0AVs8FX3ll/38KA3y3aT+jOtenF4SvNtWeIdbfjnixPd4nYxf8uKK8ZP/NUh+IJwIjFmMafnj/nkx4xYRKJ7oc1G0KRvHYlf/lq7wO+LssCIU84BR+F1ktPcMzqudBVrmhhyDdoRTrY0WSD4TVYyKXdxfqCxjwMZPF1+EIvX9QMqRFqDgMNFJGwCIJKFV8imMMPbY6QunPevWzHt8CNohT5nd0U51HHk6rGhjv/WvzXsHq/9QXIxPKuK6sR8S86J66VEGRli2AyHLehgtTtPSsxRCmn3HYpkUr/3eFKlfZSWJZ3zzJbpiolCVDZAu6Ki0KBbVXMxuXlaETKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUH1b4zkOA75TS5MWdSqSGzd+Rn75V5eFeP03JVV1NQ=;
 b=ffEu01lbVF/f/EL9GEupbBs4S1dqiMyg9B9K9VuoD+k/2MPwinua1VHnj5fdExMtDKdonY2CJy7YzVvIltdW4BVCFOUJaAJUA0Qhy7vnaZn7eAFLNIW02RaW5PZI/FAgqAeMwTJiBTFpARMHKpPuioa6PKp0awabIZ7zqH5nZiYq60wGRiQFDiItB8Ynf+PgdgXr+koGAenW8SWEvQeCzWn1ccN0pQWKYmsBEvxITcxGol8o/HWmWuSeOs4ZmXybVXV+gje0HWq5iqrq9APCUInsLVB8rxVZJ/40+IHZkBQrxqT+NOyucO59nhATxrYV1u3OeDMC0ovx9anNOVfvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUH1b4zkOA75TS5MWdSqSGzd+Rn75V5eFeP03JVV1NQ=;
 b=sd3SeYG5HMZ9JWAqhg+XFWZ8Dk8gDOSRTa/PCaDmngFIRkgWaJzYcUn1ENZvBRocVj6AxfSd+THNChfDD+OK+gBt4uEjCkqNs2bHtfWX6oOnjPCmvo5DVaTVL7tShiUkjdUcrT6dxTB+J2EWSwdS333R/zWwfhlviEKnXLwzGl0=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5747.eurprd05.prod.outlook.com (2603:10a6:208:113::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 14 May
 2020 08:55:46 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 08:55:46 +0000
Subject: Re: [PATCH 16/16] nvmet-rdma: add metadata/T10-PI support
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-17-maxg@mellanox.com> <yq1eernw6sz.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <73b899c4-0d29-059f-e704-5bf2c0c492b0@mellanox.com>
Date: Thu, 14 May 2020 11:55:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <yq1eernw6sz.fsf@oracle.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 08:55:44 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3473e6a0-e194-4310-be89-08d7f7e497b1
X-MS-TrafficTypeDiagnostic: AM0PR05MB5747:|AM0PR05MB5747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB57471BCE9159C3B8237E63A0B6BC0@AM0PR05MB5747.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47B1n+aaiuL63sFjLs/XSiinflBh4Lg6ZnMI4gnauRqhcYQ4bI8/6KJuKYITuKKv7RrAfHnJm8UiChTfloODYMA3w9/0+LC9W0r+IEJkjm6w6r8CLHQomzf1tOq6RDzCNhwj0BePrhYbNCTo0e4Y/3Z7iTg182p1H4q4RvDgbuMvq2sBxzAWUAjwD2zC4sKktqkSWwDpS5OiagyygPHAFbGbE69DJpNn+TeSwXFZYdnlFY232Ik9sNdig7uhYkJFlnLcu4puVMjfDsGr/o3cD91f5Fio9jc4i8LOzCJ2ibfC4XcnA2cjuSHFVebTuChpnn3r4YY8bRzHR/ogGjcb/SBT1wWftaC9GiFMEUtfLPLfP8vsIisdCJqTZPZns1tFQeZo1z7LeymaEKdjLNPjzO7rqgJQqMvvd9edk+5X9JLVrwc6ulD/ez5tW6o3bT2Q6mauVSWEWpw/3BKA+mBmPhEI+tkBcN+4iCJ+KQZNpjZfs7MTbcUT/fvD31eLpZlR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(66946007)(6916009)(2616005)(107886003)(86362001)(956004)(4326008)(52116002)(31696002)(8936002)(478600001)(16576012)(66476007)(31686004)(66556008)(8676002)(26005)(5660300002)(16526019)(316002)(36756003)(2906002)(186003)(53546011)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zCVmhIuiy4BFm+AcaAUqtKYPfpiGOYP8LWozyaa3FZkQnrx05HZc5FWoUqVBaZt3q7n8BzfjxT+XGhYREPEIkgld29wTPeXtcfPHcAMydd8v98rhPS5OAIND7JvZ/VHZdd9/AnNrLEjgbF3V8Se8CxzeojcYS4n038SAWw6zJyGIi5AeBBAoSVzhXWitFSzRFbzBVLmy7edJvg4jSUNqN/yRykbNXyrlilvE79//JmwzHnfoGAJoVu7AqTyaMio2h704tIdp5zLpy1IfSUoz5EeAV66SFlV2bTJilp7BwWUNfPynoA8eBqLSNR3/BzRNOge37uUrPUYciImm5VhV/Ih2bbdK3ShQ77kT2AO7PgbndCvPfsSvC+NSZipVi3HQgafmGfejbEJbkHYkRHY1XecVMW8p/B43zLzbNChURQK2kUfYy5G6vhqGmcX/+RmNTBu4t5JkWG/oTIBgbybtkT8+7yFFn5al6bQA31QxBQQr0L94bkI4NmD0HnNgIknE
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3473e6a0-e194-4310-be89-08d7f7e497b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 08:55:46.7535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKQ4DY8urcuuJnX71uE4rL1q7SSF6XjfxUeVMKJWBqmzWWDCk43VLZWQQmb46ENKAypgLwDdnnw8O5v8asoYqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5747
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_015555_456569_E8E37DC5 
X-CRM114-Status: GOOD (  10.81  )
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

Ck9uIDUvMTQvMjAyMCA2OjEwIEFNLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3JvdGU6Cj4gTWF4LAo+
Cj4+ICtzdGF0aWMgdm9pZCBudm1ldF9yZG1hX3NldF9zaWdfZG9tYWluKHN0cnVjdCBibGtfaW50
ZWdyaXR5ICpiaSwKPj4gKwkJc3RydWN0IG52bWVfY29tbWFuZCAqY21kLCBzdHJ1Y3QgaWJfc2ln
X2RvbWFpbiAqZG9tYWluLAo+PiArCQl1MTYgY29udHJvbCkKPj4gK3sKPj4gKwlkb21haW4tPnNp
Z190eXBlID0gSUJfU0lHX1RZUEVfVDEwX0RJRjsKPj4gKwlkb21haW4tPnNpZy5kaWYuYmdfdHlw
ZSA9IElCX1QxMERJRl9DUkM7Cj4+ICsJZG9tYWluLT5zaWcuZGlmLnBpX2ludGVydmFsID0gMSA8
PCBiaS0+aW50ZXJ2YWxfZXhwOwo+PiArCWRvbWFpbi0+c2lnLmRpZi5yZWZfdGFnID0gbGUzMl90
b19jcHUoY21kLT5ydy5yZWZ0YWcpOwo+PiArCWRvbWFpbi0+c2lnLmRpZi5hcHB0YWdfY2hlY2tf
bWFzayA9IDB4ZmZmZjsKPj4gKwlkb21haW4tPnNpZy5kaWYuYXBwX2VzY2FwZSA9IHRydWU7Cj4+
ICsJZG9tYWluLT5zaWcuZGlmLnJlZl9lc2NhcGUgPSB0cnVlOwo+PiArCWlmIChjb250cm9sICYg
TlZNRV9SV19QUklORk9fUFJDSEtfUkVGKQo+PiArCQlkb21haW4tPnNpZy5kaWYucmVmX3JlbWFw
ID0gdHJ1ZTsKPj4gK30KPiBTYW1lIGNvbW1lbnQgYXMgdGhlIGluaXRpYXRvciBzaWRlIHdydC4g
dGhlIHJlZiB0YWcgZXNjYXBlLgoKc2FtZSBmaXggYXMgd2VsbDoKCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL3RhcmdldC9yZG1hLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYwppbmRl
eCBlYzU5ZjY3Li5lMjZjZGQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEu
YworKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYwpAQCAtNTgxLDkgKzU4MSwxMCBAQCBz
dGF0aWMgdm9pZCBudm1ldF9yZG1hX3NldF9zaWdfZG9tYWluKHN0cnVjdCAKYmxrX2ludGVncml0
eSAqYmksCiDCoMKgwqDCoMKgwqDCoCBkb21haW4tPnNpZy5kaWYucmVmX3RhZyA9IGxlMzJfdG9f
Y3B1KGNtZC0+cncucmVmdGFnKTsKIMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5hcHB0
YWdfY2hlY2tfbWFzayA9IDB4ZmZmZjsKIMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5h
cHBfZXNjYXBlID0gdHJ1ZTsKLcKgwqDCoMKgwqDCoCBkb21haW4tPnNpZy5kaWYucmVmX2VzY2Fw
ZSA9IHRydWU7CiDCoMKgwqDCoMKgwqDCoCBpZiAoY29udHJvbCAmIE5WTUVfUldfUFJJTkZPX1BS
Q0hLX1JFRikKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkb21haW4tPnNpZy5kaWYu
cmVmX3JlbWFwID0gdHJ1ZTsKK8KgwqDCoMKgwqDCoCBlbHNlCivCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5yZWZfZXNjYXBlID0gdHJ1ZTsKIMKgfQoKCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D47C2BB1D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 18:43:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB2D20714
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FBOKvKNB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="sFOVPDTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB2D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DoRKS1xOxE4fDVk4HojLd0L3B64M4VsEeYq7kLMac1w=; b=FBOKvKNBLPDG+8
	SVZI3pK3QjMzaeftKmNvYh85BTE/TF0RlCcbFvkpDn/TGUbon0ZO7kItcpUI8Bx22Pm3D0pdwkfjQ
	RGvNR8GpGJ1lo2ktm+aB0gfvDtSH7U2Z754IK2mFEHvfTsZt6Ct46Pbb63yNj0Y7Ft88X5viIQw3k
	IHjoligZcHFnOHWjwsjlyOS+rFIATx6U3+pB+qupVc77EUtXYl6itJssi0PWqfLMRi5t5d2uN6hOx
	bSOIrIFZkNj8rpPy7bB3TLmV4qgXzfhq3AEBM5TMIn6WHBuiVoeSaruQPAJ7bWEdDq0rnsO1wCQwT
	929UtOWq5of/SHj4r9Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEHBt-0004Gq-KQ; Tue, 17 Mar 2020 18:43:49 +0000
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com
 ([40.107.21.40] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEHBr-0004G0-9y
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 18:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjsdQ9QGPaiSQ/N7DvA763Ag7fG7VM8kskQj52Ay8P/U7bZn6LrlrSppVLDCQcp1JMwHW9W331V0viD7ZZi8Sq0HnM7oXXmYzz3XzjNJBUPweuvrXcQd5K2xgvtCPEyc7a4vXqkBQtgaN/HYSrtI77Ra0vmIEfEm0x8P4al/bcRqAXm7a0NO6IZ8BaPSZQovaRp/fopwgeJK2/AcsRHw1xxT1iOPLX4y5mlyZPP86i41H4ij3lRIHy3iItvNL0PBuXym1NvAoQQOsyTTJr4TAVek6lUpEfwyWhdhfqqvfLgki2e0eXB0V7IgMVYurHRskwtVuljz6YmqNGi0XnQVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roXq8p0SuM/QyIp3uD0RkUTCceIM0ZkgSVK0rpZjuM0=;
 b=JDaqVshqvuic44ISp+rWljZCGwmTFyLk7bDfhoz94Y3jKH3Hp4FfP+ormNatHf6W++HOVc0E69y9pRWNNourC8rbMIvnFZWwaoUBieagTIQvftLhbDj6zFj4fkqyCbZrbwhvr1x9Lnhzwf0iDBTfqnn7EKwQIHU5zavF0+YzDCaij2Zx02yg0smCZ0LgzwQoNzC49whvMaSj00s2CLfD1OA7Yzk+cTtF61gsysVmbJeAregp/z85oc2421qOd6GbY936fc/YuoN8PhPq/dB8r6VVyKSwGtnpsjRzmEH+bc+3tMZuFTsyuQ3WP/NVzYsvfiah1dx9VrFh5qrZOdy8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roXq8p0SuM/QyIp3uD0RkUTCceIM0ZkgSVK0rpZjuM0=;
 b=sFOVPDTWoNwVVqrAStuFlamw3wka1tj1Xc3G1H7+5vAO9N8TPIOsQHl8RtUIZzURy4LizXxTfr6XAudW0KSjM9V9pGOfA8Yps4pol6q4MH0VC2FZSyW0XU+jq+8cjXxkn5Z9V5RYKLTEquYZG0i+w3EZH2YfEsOoV19TIlknLjg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5357.eurprd05.prod.outlook.com (20.178.12.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 18:43:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 18:43:43 +0000
Date: Tue, 17 Mar 2020 15:43:38 -0300
From: Jason Gunthorpe <jgg@mellanox.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Message-ID: <20200317184338.GY13183@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com>
 <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
 <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
Content-Disposition: inline
In-Reply-To: <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:208:51::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by
 BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 18:43:42 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)	(envelope-from
 <jgg@mellanox.com>)	id 1jEHBi-00019t-UY; Tue, 17 Mar 2020 15:43:38 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 920091ce-7e2b-4f13-acbf-08d7caa31e02
X-MS-TrafficTypeDiagnostic: VI1PR05MB5357:|VI1PR05MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB535771C249153891EE926D13CFF60@VI1PR05MB5357.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(2906002)(2616005)(33656002)(4326008)(9746002)(9786002)(6636002)(66946007)(478600001)(86362001)(66476007)(66556008)(1076003)(26005)(316002)(186003)(53546011)(36756003)(5660300002)(6862004)(8936002)(37006003)(8676002)(107886003)(52116002)(81156014)(81166006)(24400500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5357;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dUD/j5ZlLWRT2LwzdSQ9mgQ75nuuFVF+4PVSeMQcuVqr7Kfgw2cFYIvd16dgOtxO3LEfWMh5sLxCOnQOneep9vrfDkb0YqbbaaH6EJqQMWgH05g35JxJU4s3nr753CmjkGl9lMb1cashX+QpDrReTJa7VCPdyn0RgcJViT7nW89qx1jPRX1odQWNM5JDB9n9uWDI6YW2VGpAncdJo3rAr0sNSnDcQhKfBhIqCdsyce2cjMq7nTL4IEbjpz0vcFl5yykXjwZVEggFaeHi2aYTdttyjMipJYgdoSnLzAI4MQSme+kU3fz08ILWX2dI+xt5y6tSVlXprXyQ0FJZyAAHLlCsDi6o95fqe3po3CwsZPkKTm6wCxkyGfAbcja8k+VBDxXQYAuIKH1sMDzAOcCX9krt0jMz0GdTlEIUos9/prpbAG7okg/qEPkD5sgv5zd6d0qCCGdeswb1hs3NQTX9doU8nLiEJtjmrVrGHI6Vl3lCzzkuqBEDKBwZNrOHoVE
X-MS-Exchange-AntiSpam-MessageData: /I6Ba9szBRoXTkKBfe0EB37fbfPYzXkgAwPOtPHvoUe/HFo39ZJrad0Kqi7CPdcyLzN4/XDwbmxne7MwfKbMfkyGMADyzgXQe2FCjzPs6BFLQkrMndVd9v48QI6Wv5cxkf26YOe81vxA0OLCj3HtbQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920091ce-7e2b-4f13-acbf-08d7caa31e02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 18:43:43.0295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8rqfnrSwj62Ede//IM4mWCwWDCMJ2Dm1pkQ9u4m0aNMitRCTs9lQma4/puFClYPDod/u1NFwuJ8K12AdIMPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5357
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_114347_347969_9E74F2FD 
X-CRM114-Status: GOOD (  14.93  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@mellanox.com>,
 dledford@redhat.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBNYXIgMTcsIDIwMjAgYXQgMDg6MjQ6MzBQTSArMDIwMCwgTWF4IEd1cnRvdm95IHdy
b3RlOgo+IAo+IE9uIDMvMTcvMjAyMCA4OjEwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4g
PiBPbiBUdWUsIE1hciAxNywgMjAyMCBhdCAwNjozNzo1N1BNICswMjAwLCBNYXggR3VydG92b3kg
d3JvdGU6Cj4gPiAKPiA+ID4gPiA+ICsjaW5jbHVkZSA8cmRtYS9pYl92ZXJicy5oPgo+ID4gPiA+
ID4gKwo+ID4gPiA+ID4gK3N0cnVjdCBpYl9zcnEgKnJkbWFfc3JxX2dldChzdHJ1Y3QgaWJfcGQg
KnBkKTsKPiA+ID4gPiA+ICt2b2lkIHJkbWFfc3JxX3B1dChzdHJ1Y3QgaWJfcGQgKnBkLCBzdHJ1
Y3QgaWJfc3JxICpzcnEpOwo+ID4gPiA+IEF0IHRoZSBlbmQsIGl0IGlzIG5vdCBnZXQvcHV0IHNl
bWFudGljcyBidXQgbW9yZSBhZGQvcmVtb3ZlLgo+ID4gPiBzcnEgPSByZG1hX3NycV9hZGQgPwo+
ID4gPiAKPiA+ID4gcmRtYV9zcnFfcmVtb3ZlKHBkLCBzcnEpID8KPiA+ID4gCj4gPiA+IERvZXNu
J3Qgc2VlbXMgcmlnaHQgdG8gbWUuCj4gPiA+IAo+ID4gPiBMZXRzIG1ha2UgaXQgc2ltcGxlLiBG
b3IgYXNraW5nIGEgU1JRIGZyb20gdGhlIFBEIHNldCBsZXRzIHVzZSByZG1hX3NycV9nZXQKPiA+
ID4gYW5kIHJldHVybmluZyB0byB3ZSdsbCB1c2UgcmRtYV9zcnFfcHV0Lgo+ID4gSXMgdGhlcmUg
cmVmZXJlbmNlIGNvdXRpbmcgaGVyZT8gZ2V0L3B1dCBzaG91bGQgYmUgcmVzdHJpY3RlZCB0bwo+
ID4gcmVmY291bnRpbmcgQVBJcywgSU1ITy4KPiAKPiBJJ3ZlIGFkZGVkIGEgY291bnRlciAocGQt
PnNycXNfdXNlZCkgdGhhdCBMZW9uIGFza2VkIHRvIHJlbW92ZSAuCj4gCj4gVGhlcmUgaXMgbm8g
Y2FsbCB0byBrcmVmIGdldC9wdXQgaGVyZS4KCkkgZGlkbid0IGxvb2sgY2xvc2VseSwgYW55IGtp
bmQgb2YgcmVmY291bnQgc2NoZW1lIGlzIHJlYXNvbmFibGUsIGJ1dAppZiBhZGQgaXMgc3VwcG9z
ZWQgdG8gY3JlYXRlIGEgbmV3IHNycSB0aGVuIHRoYXQgaXNuJ3QgJ2dldCcuLgoKPiBEbyB5b3Ug
cHJlZmVyIHRoYXQgSSdsbCBjaGFuZ2UgaXQgdG8gYmUgYXJyYXkgaW4gUEQ6ICJzdHJ1Y3QKPiBp
Yl9zcnHCoMKgwqDCoMKgwqDCoMKgwqDCoCAqKnNycXM7IiA/CgpOb3QgcGFydGljdWxhcmx5Li4K
Ckl0IGFjdHVhbGx5IGZlZWxzIGEgYml0IHdlaXJkLCBzaG91bGQgdGhlcmUgYmUgc29tZSBudW1h
LW5lc3MgaW52b2x2ZWQKaGVyZSBzbyB0aGF0IHRoZSBTUlEgd2l0aCBtZW1vcnkgb24gdGhlIG5v
ZGUgdGhhdCBpcyBnb2luZyB0byBiZQpwb2xsaW5nIGl0IGlzIHJldHVybmVkPwoKPiBBbmQgdXBk
YXRlIGliX2FsbG9jX3BkIEFQSSB0byBnZXQgcGRfYXR0cnMgYW5kIGFsbG9jYXRlIHRoZSBhcnJh
eSBkdXJpbmcgUEQKPiBhbGxvY2F0aW9uID8KClRoZSBBUEkgaXMgYSBiaXQgbW9yZSBjb21wb3Nh
YmxlIGlmIHRoaW5ncyBjYW4gY2FuIGJlIGRvbmUgYXMKZm9sbG93aW5nIGZ1bmN0aW9uIGNhbGxz
IGFyZSBkb25lIHRoYXQgd2F5Li4gSSBkb24ndCBsaWtlIHRoZSBnaWFudAptdWx0aXBsZXhvciBz
dHJ1Y3RzIGluIGdlbmVyYWwKCkphc29uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==

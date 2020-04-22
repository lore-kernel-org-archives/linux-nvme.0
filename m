Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC72EC54FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 22:39:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD522074B
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 22:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qkTCaQvJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="iok8xrjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD522074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qhjk2XNbOziHfYE+goXYgg99OE5i/n45Bj5IzHyZp3s=; b=qkTCaQvJfbND2J6PSAo8gJKTq
	j96WChLCHTGvvDdUgGZDhbBPbi49nhsAfHvzxeNIqwafoaIHXiHKT1WhbbIKnE/sxbgvsKAIoLie4
	3rsAMdyG5jM5txFh1SgvKVuEehhVVdVI8qsLlj1+6pRq7RdoY3uEBrdRhek4nwIUzvO+z2woh/2zC
	50r/q+eE3P/8S58QO0zr1rzimT/l+1yE7RL+oYXQhVeXrBc/uQ+oZkXYmu8a70eXU3OwKs2CLGFpo
	ac/7wF2pWWHVUKRYQfvuryJDMAuBS8L15lN1Oj2GByX+Vav0otL2nTkFS3KFq48d6Re7j9irhvZhT
	2iW/BdFyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRO1p-0006fG-Or; Wed, 22 Apr 2020 22:39:37 +0000
Received: from mail-ve1eur03on060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::60a]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRO1m-0006e1-LG
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 22:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd+DZj6lKF+YZuyjL8ZN5x3fynDMZn/eFokQ1a4zNFkgVaXxQtGsPuMa47rluhJnnMtBOQcaUdvqQnlTWngjov8AlvpYKrb1JcseK8YOMnHe+NmtxT+7JQo5sHBW0Q5oLmRJTqxih3onlvKDL//nckTXuPswEA9w6v0Y/+PvNV89GxYGu4MwlDgIPtERcH0pZcCfYjttS3/W/tbbQWZYmc93r9+SFBJ1U8krUNQgG09KlS63yyOzn6Z/vha4DO9zGdZ3SNSWCV4Dm+5wEtfmfH0v8DM42ZS0s/r3tvY2tdhyGMEyi2/s8nY4n2Z9C1hb4M7GKdo2qm1r7UJKcaQRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjWWA4T+RtgQPCXfqLNJHvWak0hPaGD7WVKcamttDs=;
 b=Mq3xq7Kvpq/ony7Lv55y6EN7uWfR9Ssi+ydZHY5nciWToTBke0PxRUyizZAv6iWM+zDZU4Sfj0MQebFZH8u/nT44VD5LKXqDggIWK8OZRirLzWADsy5PQvd0b4qZlljo4dRI+/1VCSJfyyPA/KPuOtwsVI+ZsE5mbIoDeDnNo3qBlVGh9zkhhyNtYWoSUHURaclbzpPQPG2bOh8YwMKtDLdIlPeTXvo8sfQkMlikeCwu1M0T0Rci1k0MLKmnZ25Z3jGFWVpKxgZSppLdPSwcrH0GaVz35sDgPIr5jz3cMqV+BK9XIJ8iCFdooFKkh5UtsSOAwSIFZjo6KGUnZM46oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjWWA4T+RtgQPCXfqLNJHvWak0hPaGD7WVKcamttDs=;
 b=iok8xrjnQb8lkbc5zJGAQ9RlDPwIeZq3rctRhwnLdLbldSx1h5bwSBdFO2UF6LiJuvhGJeb1JWHU9I6+N9BKGlGBVJ9f/AR6D5p/c+eLyxcBDz1GVDWwbxhNt95zvXCI6BH9FhCIRQZBia2wQQlKGA180sZsIBlTeK/RGBu77v0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5713.eurprd05.prod.outlook.com (2603:10a6:208:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 22:39:30 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 22:39:29 +0000
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To: James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
Date: Thu, 23 Apr 2020 01:39:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 22:39:28 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f0d82e7-adf1-4563-a48e-08d7e70e0516
X-MS-TrafficTypeDiagnostic: AM0PR05MB5713:|AM0PR05MB5713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5713E72938CA5305BB38CFE6B6D20@AM0PR05MB5713.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(316002)(8936002)(36756003)(16576012)(110136005)(66946007)(31696002)(66556008)(26005)(4326008)(6486002)(31686004)(66476007)(956004)(2616005)(478600001)(186003)(16526019)(2906002)(107886003)(81156014)(8676002)(5660300002)(86362001)(53546011)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjh589nqeXzEUYPqZpdozLtoD8YA6t/vfdlsGP17tdGDN09PLhV1Q1TwCEJ5Kcl7ryRqD5nEb58usiqz6L3lmnnue7h3KNmbTNRi5O708bsuBAHvOh9TmuhWK0Jygof9XxvB9sw+YGYWJsdlwYOCsmRl1aFO63WJhOMrYD/NKiEntam/mav1XDsQgI17FeBVnx1VJF6faC+GqdrDThWTgJlQ4qt3zC+E87b616E4Uib02ukuPjE9OF+0DgxpJpVN3i35rnY0/h2XTeBJRs+r/qpGaRFWSiX0Hv9Qy05MoOGySnDu8+NRQ4ieuVbZ3dCQyGwFVApdB8dkxICQsjpd+johaQ8RWkpqgETqymQCLvPO2ZGM551WxkQHMaBXes4U3f4aTBrxhEGAqZ5xC9d+QdkPsj49Y3hFw+mNf/zDN3FDhgbmaSQ3cNY2o+gdj9nI
X-MS-Exchange-AntiSpam-MessageData: x+MOvEZYUpd2RJ6+1Hb7LyihrVaE7Fb3qScTN9dokZye4npyJtKJMGlOByN+FqxJtvXWOIC2dDlj4dy6I+eiE5ChXHpTJBV49LpUZn/sofW/4iKvbdH9VR0MaHsrx621LvK6C7pZPVBLepFvTrBMW9vm6FV3q49o2MpvrgM/g/qpTSdDNpDsAxTFynVXYPyKWh2stzdA0K2Kee721HMFPNyCJI4OUIEiuHEg+oiJMffK8su1O6LBEuj8u1CF3Zhm1geHYcEmUuKX1xyVodwjGKVm5Lsu3ikksBfO+APsxzXOLZM0QD9lR5DyKjRonAxQN7EXM2L0OvRzAs4LAXCikIUBL+OZStEioyyxvVIlu4L0+HpP63X66eCVdWGx37mfeWNeJyl4jqocdhWtqYlOvEU4JNa4tsDBTthBFxsMZDvvcIzH/CUX/ukABKKL5WHjeo/55a/POtksaXd3boibl/C992e3bheowwxLRjx6xusgNbvJ+y8jA06adkbOrAvzl9XG77liVFUGHjF7lC+VOUfz7XNchrkhXsmyfyWbaxnw1H36+h0Vq57WS9Bih12svbwQA2brFljsJwF83ZuMlCQJj5Ny5dxypsheRpQuixQhzwpyZVoTqnxyDt/SL6eeTT2nain5cnX/Vti5Bl4mo+b/XY5vNqmHiS1xnXdsOM/JBX1mifV8NADxKCStT0rSbJkmSlwFhOYgDL7vhM/rSgBRWvuPg1YXbjOjFYz76x/zuXd3svCR/eGlIVYbMy7RUa/3uLDvU7Exa2AswVCJf04fIzkT0C+UVtiEx6+N4BcZg3SHGxPC/NNvvGWKCc7x
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0d82e7-adf1-4563-a48e-08d7e70e0516
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:39:29.9001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Lx3VOwuNkjb0Q8aQWsr4EQja98O589QGIXXpaRcDzBbfcgPBfd40klLt0VTCpa4sSj6BAaYVT7vv9QRcmNkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5713
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_153934_696772_646706FE 
X-CRM114-Status: GOOD (  19.88  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, linux-rdma@vger.kernel.org, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDQvMjMvMjAyMCAxOjI0IEFNLCBKYW1lcyBTbWFydCB3cm90ZToKPiBPbiA0LzIyLzIwMjAg
MzowNyBQTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Pgo+PiBPbiA0LzIxLzIwMjAgNjoxNyBQTSwg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+PiBPbiBGcmksIE1hciAyNywgMjAyMCBhdCAwODox
NTozM1BNICswMzAwLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+Pj4gRnJvbTogSXNyYWVsIFJ1a3No
aW4gPGlzcmFlbHJAbWVsbGFub3guY29tPgo+Pj4+Cj4+Pj4gUHJlcGFyYXRpb24gZm9yIGFkZGlu
ZyBtZXRhZGF0YSAoVDEwLVBJKSBvdmVyIGZhYnJpYyBzdXBwb3J0LiBUaGlzIAo+Pj4+IHdpbGwK
Pj4+PiBhbGxvdyBlbmQtdG8tZW5kIHByb3RlY3Rpb24gaW5mb3JtYXRpb24gcGFzc3Rocm91Z2gg
YW5kIHZhbGlkYXRpb24gZm9yCj4+Pj4gTlZNZSBvdmVyIEZhYnJpYy4KPj4+IFNvIGFjdHVhbGx5
IC0gZm9yIFBDSWUgd2UgZW5hYmxlIFBJIGJ5IGRlZmF1bHQuwqAgTm90IHN1cmUgd2h5IFJETUEg
Cj4+PiB3b3VsZAo+Pj4gYmUgYW55IGRpZmZlcmVudD/CoCBJZiB3ZSBoYXZlIGEgc3dpdGNoIHRv
IHR1cm4gaXQgb2ZmIHdlIHByb2JhYmx5IHdhbnQKPj4+IGl0IHdvcmsgc2ltaWxhciAoY2FuJ3Qg
YmUgdGhlIHNhbWUgZHVlIHRvIHRoZSBsYWNrIG9mIGNvbm5lY3QpIGZvciBQQ0llCj4+PiBhcyB3
ZWxsLgo+Pgo+PiBGb3IgUENJIHdlIHVzZSBhIGZvcm1hdCBjb21tYW5kIHRvIGNvbmZpZ3VyZSBt
ZXRhZGF0YS4gSW4gZmFicmljcyB3ZSAKPj4gY2FuIGNob29zZSBkb2luZyBpdCBpbiB0aGUgY29u
bmVjdCBjb21tYW5kIGFuZCB3ZSBjYW4gYWxzbyBjaG9vc2UgdG8gCj4+IGhhdmUgInByb3RlY3Rl
ZCIgY29udHJvbGxlcnMgYW5kICJub24tcHJvdGVjdGVkIiBjb250cm9sbGVycy4KPj4KPj4gSSBk
b24ndCB0aGluayBpdCdzIGFsbCBvciBub3RoaW5nIGNhc2UsIGFuZCBjb25maWd1cmF0aW9uIHVz
aW5nIAo+PiBudm1lLWNsaSAob3Igb3RoZXIgdG9vbCkgc2VlbXMgcmVhc29uYWJsZSBhbmQgZmxl
eGlibGUuCj4KPiBJIHRoaW5rIHlvdSBuZWVkIHRvIGNoYW5nZSB0aGlzIHRvICJzb21lIGZhYnJp
Y3MiLgo+Cj4gV2l0aCBGQywgd2UgZG9uJ3QgZG8gYW55dGhpbmcgaW4gY29ubmVjdC4gVGhlIHRy
YW5zcG9ydCBwYXNzZXMgCj4gYXR0cmlidXRlcyBvbiB3aGF0IGl0IGNhbiBkbyBmb3IgUEkgc3Vw
cG9ydCwgaW5jbHVkaW5nOiBwYXNzaW5nIAo+IHRocm91Z2ggbWV0YWRhdGEgKG5vIGNoZWNrcyk7
IGNoZWNraW5nIG9mIG1ldGFkYXRhIChub3JtYWwpOyAKPiBnZW5lcmF0aW9uL3N0cmlwIG9mIG1l
dGFkYXRhIG9uIHRoZSB3aXJlIChtZWFuaW5nIE9TIGRvZXMgbm90IGhhdmUgdG8gCj4gaGF2ZSBh
IG1ldGFkYXRhIGJ1ZmZlciksIGFuZCBzbyBvbi7CoCBFbmFibGVtZW50IGlzIGp1c3QgbGlrZSBw
Y2kgLSAKPiBmb3JtYXQgdGhlIG5zLCB0aGVuIG1hdGNoIHVwIHRoZSBhdHRyaWJ1dGUgd2l0aCB0
aGUgYmVoYXZpb3IuIFRoZXJlIGlzIAo+IG5vIHN1Y2ggdGhpbmcgYXMgcHJvdGVjdGVkIGFuZCBu
b24tcHJvdGVjdGVkIGNvbnRyb2xsZXJzLsKgIFRoZXJlJ3MgCj4gZWl0aGVyIGEgbnMgdGhhdCBo
YXMgbWV0YWRhdGEgb3Igbm90LiBJZiBtZXRhZGF0YSBhbmQgdGhlIGF0dHJpYnV0ZXMgCj4gb2Yg
dGhlIHRyYW5zcG9ydCBjYW4ndCBzdXBwb3J0IGl0LCB0aGUgbnMgaXMgaW5hY2Nlc3NpYmxlLgo+
Cj4gSSB1bmRlcnN0YW5kIHdoeSB5b3UgYXJlIGRlc2NyaWJpbmcgaXQgYXMgeW91IGFyZSwgYnV0
IEknbSBhIGJpdCAKPiBjb25jZXJuZWQgYWJvdXQgdGhlIGNyZWF0aW9uIG9mIHRoaW5ncyB0aGF0
IGFyZW4ndCBjb21wcmVoZW5kZWQgaW4gdGhlIAo+IHN0YW5kYXJkcyBhdCBhbGwgcmlnaHQgbm93
IChwcm90ZWN0ZWQgdnMgbm9uLXByb3RlY3RlZCBjb250cm9sbGVycykuIAo+IFRoaXMgYWZmZWN0
cyBob3cgbXVsdGlwYXRoIGNvbmZpZ3VyZXMgYXMgd2VsbC4KCml0J3MgYSBiaXQgbGF0ZSBmb3Ig
bWUgbm93IHNvIEkgcHJvYmFibHkgd3JvdGUgbm9uIHN0YW5kYXJkIHNlbnRlbmNlIGFib3ZlLgoK
QlVUIHdoYXQgSSBtZWFudCB0byBzYXkgaXMgSSB3b3VsZCBsaWtlIHRvIGdpdmUgdGhlIHVzZXIg
YW4gb3B0aW9uIHRvIApkZWNpZGUgd2hldGhlciB1c2UgRTJFIHByb3RlY3Rpb24gb3Igbm90IChv
ZiBjb3Vyc2UgYSBjb250cm9sbGVyIGNhbiAKY29udHJvbCBwcm90ZWN0ZWQgYW5kIG5vbi1wcm90
ZWN0ZWQgbmFtZXNwYWNlcyA6KSApCgpBRkFJSywgdGhlcmUgaXMgbm8gb3B0aW9uIHRvIGZvcm1h
dCBhIG5zIGluIE5WTWYgKGF0IGxlYXN0IGZvciBSRE1BIAp0aGVyZSBpcyBvbmx5IDEgbGJhZiBl
eHBvc2VkIGJ5IHRoZSB0YXJnZXQpIHNvIGknbSBub3Qgc3VyZSBob3cgZXhhY3RseSAKdGhpcyB3
aWxsIHdvcmsuCgpXZSBhcmUgZG9pbmcgYWxsIG9yIG5vdGhpbmcgYXBwcm9hY2ggaW4gaVNFUiBm
b3IgVDEwIGFuZCBJIHByZWZlciBub3QgdG8gCmRvIHRoZSBzYW1lIG1pc3Rha2UgZm9yIE5WTWYg
YXMgd2VsbC4KCldoZW4gTlZNZS9GQyB3aWxsIHN1cHBvcnQgbWV0YWRhdGEgaW4gTGludXggd2Un
bGwgYmUgYWJsZSB0byBhZGp1c3QgdGhlIApjb2RlIGFuZCB0aGUgcGlfZW5hYmxlIGFjY29yZGlu
ZyB0byBIQkEgY2FwIG9yIGFueSBvdGhlciBsb2dpYyB0aGF0IHdpbGwgCmZpdC4KCj4KPiAtLSBq
YW1lcwo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

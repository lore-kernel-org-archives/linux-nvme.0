Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCA8C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 08:11:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DA22067D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 08:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KEvYMz5z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cepIz0jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DA22067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/14PhycsxBApkpqHO37DFumRMZzJvbyMBJI7xjIWALQ=; b=KEvYMz5zzbWcH4b9PdIkBC+wG
	fls817TQ/VTI4Dr27QqS5uLuFhRJuRgjq6h547MbMraqCTgO9RgUGYzs7EXTbdtDnwON3tiZGva2x
	4SuP5ngxKmhF8CzqktO9nW+EAXrJKdmiFHPnrdGxUSN/A2Sl7Koa/lVAmgugPfI5A/eRrsa5/fKLF
	yjgG7VFFAfyze24q1SYLchig5k3hdJ5QKeZHcfxAksnfCnk5HYTC7xvChYqllSmzIt2vJ4rjznFSF
	VPf8+WXhk4qdUmNQnFZQlBDcOvc6Mif/J1wzyO4dYs/nzCDmCYFRzo+LBcEPCXhv5VY0UpmFP2X3U
	PsyGq8NAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joMyh-0005rp-3S; Thu, 25 Jun 2020 08:11:23 +0000
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joMyd-0005pn-Mj
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 08:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvc8RBca/jX7oOusY0wraSz3jg9LK3On+b8hCoKbUWo/1KX84+akWE5Yj5KUwo0qK9ILewCvimd3Rtpph65Pvoajz1bQ8UUyKNevDUcdFlm0vEaQpvCzOayYEooxWTBqu+btAemqzW7LOTSXEzEikOU8ZQWWQA769J0f2rLul+VYgfEY4cctOF1QUzyL6wbUKBw0jhYI4uEPJYo/BeU76i29BhMHYgS+k0+gCdp27BupaSaT0JCza5lKvPyjFj41PcRZMoqAt2AJ0KbptXFAlWosTqqN4kP+hke9IQMmN7JDm1I0+2pbUWzffXCWKAS/7qPgeIUeBX7s+KXRa2RLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV0yeVlkZ4cMo9S4SCjkEDAGvuo4QrRq8qeO5OasIYk=;
 b=oNDyLzTzxa6dI6owY33RV8QwLQelEntBdtleQ5RiCL8NkJWANAvKHHRU7dt3UlcuX+bDGwPz/vhM2yvjNU6ZfPbYnvlhxvW4ZUpwQyrY50OSbVjIynRsn1BOTXnfRC2TxBEvRAmoQ9QvCB/4LuafPqB+Tyrazhh/gB+3aMH52LBKzoUbeG0AcCTCOxaUGLm/1z5Fk1X61OV4JeVTvgS/G2bXeaKf0VplIPrxo8pchhV/XmL2LBPrvSKAy+ODgFiH/yavEliNBaiYRzx5VUaTGckvImJlpkr9bujePHEHPDunO6BXMU+ZB24tdk2I4VHj0rQ0JTqlRIUS6+fgPFWRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV0yeVlkZ4cMo9S4SCjkEDAGvuo4QrRq8qeO5OasIYk=;
 b=cepIz0jHSthNo9CrEhqK2uzsetF1M6HGV95SRX4lGbJEohY3lBfI9UOzbuq4dkVylZCM/HAFLG31/mnV9kD/6wxtaswFJuYo76kybuwg3wa/WQJ6WX7f4fjMbQYRj9hRvDfi4JZog/2ISIQpZaEtPH03+vAsHxVo58CXvVlMXOo=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR0502MB3699.eurprd05.prod.outlook.com (2603:10a6:208:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 08:11:17 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 08:11:17 +0000
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
To: Christoph Hellwig <hch@lst.de>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com> <20200624164149.GA24788@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f1eac15d-0847-889e-8f79-814830cf0639@mellanox.com>
Date: Thu, 25 Jun 2020 11:11:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164149.GA24788@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::32) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:208:ac::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.10 via Frontend Transport; Thu, 25 Jun 2020 08:11:15 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a690d6ed-8978-4123-2467-08d818df55d1
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB36995EBA41EF6F98002908ADB6920@AM0PR0502MB3699.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy1oAKQZudr1J0Flh8mG0Yrxyyj7p7mpn5XAdkfRFwjdILK4IFxz75zohqoxs1cTVELTHXcY+MhtQZSQj3BewNmj1ujOdgrkFR0iWIN094aX4O23QdB32vpbmyK/+PflKBxdQAlGf5gtEz0/Hx4xr3YOFo6a6RdPj4bfDuNu65yWyO3BsmXc+33ysOI24cW56WamfYsJP2hm8AJiyo5IjtSpY2mQ4GECzbr9Wjs1pdH8/5xUy1RcOBWDJL+ZkFhlvqEHw0oa2CJ5KRKiKBQmihCNX2yMWctY390UXpsliktprq8izkS8NZ/bwB0oVQfk8W0a8LO7POWQKIAfQwDG95jWQDp0g+j/kFIuXQ+Aq2DPvZXG+5sCg7CgB3UOJpsr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(36756003)(107886003)(558084003)(31696002)(478600001)(86362001)(26005)(6916009)(31686004)(66476007)(16526019)(66946007)(53546011)(186003)(66556008)(52116002)(4326008)(8676002)(5660300002)(6486002)(316002)(16576012)(956004)(2906002)(2616005)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5+mBHk8rfmZZcpXGyjmVZ0WGflHIeJrJIOy6PL9Xd8liCNYPuars9WjIPLfs1Q1itOJsMiHY/gq4ErKwbIzLaa/G0SEi7w0J7xYe3wF9u2ODsBiR+RMdAI03t7b65uhoxNGpsFgPTRhTw8e4yAKt/Jq9c56iMSrI5d6w8Ivo+La2L/2r0hSAXbpw6EbTvw8RCqVxQpS9phynjKQVTElxKJgkrDXVgTGSBITcSUjw2I3ACxMlICu2tk2yytIcUC88gohXa1X8qzfFbN2SVor1LwG1U84Gn2BDihyHNVoosuRltJbf08NH3MpFda/1vcp4mCBI+ILUFywXZfVYVvlXMRTfkO7uLvwpga9utJhGv8+x8WrV1aAtuJ7K2zTqficeF6ciHkt7rK3clz7/5HzG1DjtZrkT8Cafi70JeLzYfuhOWEOkrOQcTUQ3XnDI4QwVSxQAySMcS7+pwq7GomdS/rJFaPh7MKK2/n5aIXaa7j4MKrxjy4/aYC5aPfVq6nU3
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a690d6ed-8978-4123-2467-08d818df55d1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 08:11:17.2486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CX+wrlrX6lF/oMFObITGCnIV1aZZtR3QXiYRUesED7rMP5aDBaU4jgAE1H/kqwmGINalVFWLhADTfc0VHtRqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3699
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
Cc: yaminf@mellanox.com, sagi@grimberg.me, shlomin@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 jgg@nvidia.com, kbusch@kernel.org, ogerlitz@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Can you add fixes line manually please ?

Fixes: b65bb777ef223 ("nvme-rdma: support separate queue maps for read 
and write")

On 6/24/2020 7:41 PM, Christoph Hellwig wrote:
> Applied patch 3 to nvme-5.8.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

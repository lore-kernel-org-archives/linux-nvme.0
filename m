Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBB0C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 15:55:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58A12065F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XRK8Lj7s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="O5jDzAAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58A12065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xbzHLEeTrksxiDKZb0oiihr2R4sZt7+KB2BrOXgyMuc=; b=XRK8Lj7scYREcmmRUASrcPQ4Q
	lF/2ShfffgmyBMdHH5cuBYG+kWipHWtZYUvpWDd53sL7uXf4njl6UZp9/Qcc/YWejzRu5sl3Z2bBH
	K9EeuUDJEN3G4o5sL4Vvz4FDV4I6xtx3JMYDgf2hpzxmcJR/7l3eOX0f/7G1Mnet09EieR4jN2sRD
	p+yTJb3lX5xWvXCP8ysXi/uhcvmQkWLRvWTkQdRgB9N84PULQ+zNI49t830Cg2ZnuhgpqI7MdmeJ7
	DF9rOloYnoR8VB8C/4S7SsHAtUUHtjEwlQ2NKMMPgNZN/MV2LALay9yPgyWRJM1pSPWf5EEmGpPzc
	+8GzUs3fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZGCt-0000Ju-3y; Thu, 14 May 2020 15:55:35 +0000
Received: from mail-eopbgr140044.outbound.protection.outlook.com
 ([40.107.14.44] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZGCo-0000Hv-Dn
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 15:55:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdGN6qW2N7w5wP2r7ryx5vXdDcAxk2IaKE42drEHo0qu9wN/U7dzxPupXIDmPlQHyezPNTxizGFEv42EjsguOAPUjZZoflfB1sSYgJws7WZUCFqNURxrEB8LiYxOJSSoRUaIQJwMswG7brivPmzWlGmqQvLO6MP8YRv1aO6fRX4mD84SVrHl9ss6y8d3jlv+CKFwVdHhumTmmGzmh28YrLFk2YCK7xihGa7WU0mtIa7zvKDShI/as7fKn2v3YE6St1vgqjgI6HXQlCPmNjFxmhAXfnP4RRNdlHrYzIOY087ytwhVh9votcO33qWrvy3dss+AHvgR6w0hJgYwq+yziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7YAj88cnnH7xgHvO2+ovwN9UagjOZrde3l38cT9Hos=;
 b=cLWF7iQNhJyi/dNcrRGv0uQugZT/hEZtWYXIBM6w3gH5BYp7IMLxIzhgnNMekKUOp+bq0nG8Oebzu0G2b0OjmeF/kINbEbVbSCGrW7A0QYc/mWZhkg0fjz4Os8oyzNgd9WiSNL1gssPFmdozq4iBWry+doTqjTsk46rTMS22hoasLHnXpXuOb1ihgnQn+IklwirDzyQM5/W/OXAZ00nNbaue+Ek8l14P3ywHnrzuXO5hPcWeFbPvDlFttfrgmcLwHVq+r+1swzpRkAjJy5s0HGINrv7eD85BqKHaod28uIxmazVHvJmdcdGV20amSXD1caQds/QEXI6I9CWOVAgrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7YAj88cnnH7xgHvO2+ovwN9UagjOZrde3l38cT9Hos=;
 b=O5jDzAAD79Jpx+pSFrNUxtRb8zt3KSBo0uvv3f3vuAf8sCaRavw+xGRvaU1vlChyiMnylMnK5y9z2dSOY6ei7+zYTWPbMZFSbtXBYp1iwVVW7a5IX4VQFAJt3VhZk5wzDYFGhxNuRpcI6zKSndQQosEeXHpXRq85NQNsOP6HsEk=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4692.eurprd05.prod.outlook.com (2603:10a6:208:ad::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 14 May
 2020 15:55:25 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 15:55:25 +0000
Subject: Re: [PATCH 00/16 v7] nvme-rdma/nvmet-rdma: Add metadata/T10-PI support
To: Christoph Hellwig <hch@lst.de>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200505061325.GC3995@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <dc53cbb9-a2c7-f4be-c665-5b45da3cbb27@mellanox.com>
Date: Thu, 14 May 2020 18:55:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200505061325.GC3995@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0083.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::24) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR06CA0083.eurprd06.prod.outlook.com (2603:10a6:208:fa::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 15:55:23 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a019a9d2-f771-4a81-805a-08d7f81f3753
X-MS-TrafficTypeDiagnostic: AM0PR05MB4692:|AM0PR05MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4692E154C16FEBBF08A89F53B6BC0@AM0PR05MB4692.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d46RQgm5Hk8UqPzX3uFeo8blOwgI3rRqaSS7H4pdQv9AbFa3LunGayISR1CaR3+EM9WtJfJwM1h6TAPa3FIptK7B6EeoOR8ovr5Y/igBVoYv+x5bzgRf6HarECtSTw2962q4+u81Wr2vNu94KpKdSwU7jnmHhpDMd9PAGrS/zZPu6EHYUOiGvGj3t6iSEc50pulu5Y8rzpbiE+HmGp7qaaihr6DiQMBhxxAOzqyag3UQri59HgaQaPYjTGAbb2GoM1tnMWq6Nrx+fVjJGh9v46nZk3P08KQDlZy047m07p9QAvulANIZ3rKLUN0S992kCJemvt9ZsM8Hv68tfFthcI74k/zAJ1ZUEBOHMeE9qggUmi6zpiE+399twIRaMX6Ph0bjuevL7WlFJt9I9AqKbgytJGFDOdG3DyoMPX8LKDULRAHpSQKmH5G/ZbZN+OKJJ2q6NP44nizsvIZUZLz+EvDXSEk+ZBqP8gDS+kSxgbQaaEWSc2m+HHQLhMoDuTQv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(2906002)(36756003)(956004)(16526019)(316002)(16576012)(4326008)(86362001)(2616005)(26005)(478600001)(52116002)(186003)(53546011)(5660300002)(31686004)(8936002)(558084003)(66946007)(31696002)(107886003)(66556008)(6486002)(6916009)(8676002)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cN90rXC+DaFeQvLQyBzs6qXVwjxQH8AoxNTS1n6mEmJSSIpSSPbzaXBg/llgRSn5O5OnQdAoyYaXyzvNHiA5MTmtJMG7M0GJ6vwUMZkGsfxMj2qP9AQCvM5ISAECAxrsI3htORpOS2FLiQzErx9hcttcTQl54w1nw3F+lVZZvnvWjvNzrSve0SZjRh4/9yGrfs4afxKbzVRTg4IKR1CnR3KmKdowt04aiK5cjIP86MqQpL8vXFeEbnn1g2r/UNnC7cuPyCdB45FNjfQWJ3fAWaJqOp57d6E67ReOHDVRcqW2/9gIeCx90XGmJa7Ty50gAXx21ZBgtQnKtC198DNXZiydEGr69BMlQMk0Ra0kooMbIT57/FvtusnFmSj1d6jSyTQpfz+ssJ07D0NZj6Uk7GrZ7+KoiMl9pSx+8m1ZtY4n7D6NDOTfblCK+hb3g/3Ur+BuJcNaBVWd6XXtDnjt/9GAhaEv4nztBybXDe25hfcW/PM4f0WXpqdSRyOf9lZr
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a019a9d2-f771-4a81-805a-08d7f81f3753
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 15:55:25.3647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/KYMmd9S7FzY0JXI2me8T+XLtPPLdJtrE9+8MPNhfx/6mozrLNrmMwEIhNtNOfCyeI6BA5SVY7xzFH+o+0cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_085530_464926_CCEBEB73 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 5/5/2020 9:13 AM, Christoph Hellwig wrote:
> The series looks good to me now, but I'll wait for a few more comments
> before applying it.

I'll wait for Martin's ack on ref_escape and will send V8 with 2 small 
fixes to RDMA drivers and reviewers signatures.

Hopefully this version can be merged..


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

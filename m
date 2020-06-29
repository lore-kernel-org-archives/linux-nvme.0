Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69124C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 16:18:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361372558C
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 16:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mu0wtA1N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="a3bW2f0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361372558C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CZgp2e1Qese7Va+7mBIovxAAhep+TLUZVu3u62bS/8A=; b=mu0wtA1NOgcdpMPynnx7DZi+J
	rq/wxU/iX7zNdny4tjnmulr+pTP2B/L9gPLAnXWdUpC95X5dDYhs16up7gGQ7ZuQ+1ok+vGQWg8BX
	VwmtiH9HRWxlKotXV2MPxJKf3tcviazHj7/0J6coqzptUSgtpxG5RfKowpJv5mwyfvpgRel9ZCHYE
	j5nfm6BCb/mdrcdDnokS8zKuGTY8rpIjApZFZN7SjK83UZVvXCNozBtqEkM99WoX0zq204PwgVvHj
	dQR5Af0tn0kMOl+g3kUtKuJifNFEYuHTUahj63Mm1LQvMyKZyrxRYQm2va+bxRCGisRVxjY6orCM1
	m6KVOJvhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpwTg-0007IK-4a; Mon, 29 Jun 2020 16:17:52 +0000
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpwTc-0007Hl-HE
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 16:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuYkiiBRS4E+6opIJ6Nuu1uQMCTX7/zkPaYxft3ggceRDBniZZK/6q6vmAednJDL7VQuV1Qz5wvTsn8l6BrAedRjr3IcQLFSis0Qsv8v8a+UUxiey7KncsqMAWQulXMobm19dVXW6ED1O1gpQgroLlVQejkO0tfDPnBMr7/w0YV9RwQaya7HO1A2Mxwd+4dnbcHOSm8gsm+BBk7l6u82vyryIFoPU7i3jqXHj2+kzbm1jHu7eXdC5tILaldsBMICGfL4tHPLX+/13UunJulkl3uBlAJAwxIJlBJ7EEEg6HRq8f/kZRreV/vFUaOWlyz/OT7kXpO71cKt/b9hrxQW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYfljcGXqaco32+70Lj98gHmuZ0rF9dLeifLuc/KU0=;
 b=ivwu9+4w/ZvK6P3lrBdvobwsH0E2b0rbCNd4a8FzWShz1CwoVPwa4gybertM2vHyHkHY2DIhs97nwfyBrdoa/dRdaNnhNB0j/JZTgrrN4V2eT0YGR0HoM+M1kEX4LUKFVsMgGZdUTnHRfGc/GncM3xSCoL1JV18dJo/QeU3Orh8HlA0p3tQs9ydOctxGe/moEBBWblJXpEinKBawingh76aYGlKHFbZ/kdqJbc0A9V5LkbGQm6dhqFhJC1uOXEHZmp4KbFBopmBZzQahD/TKzMBhV5nFbgyNB0BOvYoKya9lxI2J3eTFWrlUodIs0Vwn+qc9Zz0VlMv4ZkbyxsxqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYfljcGXqaco32+70Lj98gHmuZ0rF9dLeifLuc/KU0=;
 b=a3bW2f0aw4Tz3oTtbyifP7DYga+1AxtQ+nbyuWyevN/AvUTGxj0cPpVxUicKmFRFZ7jbxOZ15hnKLRc450RrwLk/6YbeD9ljmvrBm4keATzjg1C5B9Rwn2MoL4kS+0iMC9xL34W6ExmPlrOzWvflXsmnJoXeaiJm959XS+F9ejo=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR0502MB4049.eurprd05.prod.outlook.com (2603:10a6:208:12::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 16:17:45 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 16:17:45 +0000
Subject: Re: [PATCH v2] nvme: fix a crash in nvme_mpath_add_disk
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org
References: <20200629143422.2695541-1-hch@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <df78005e-043f-a6ea-53f5-db37f0c989f2@mellanox.com>
Date: Mon, 29 Jun 2020 19:17:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200629143422.2695541-1-hch@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0063.eurprd05.prod.outlook.com
 (2603:10a6:200:68::31) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.7] (93.172.90.42) by
 AM4PR0501CA0063.eurprd05.prod.outlook.com (2603:10a6:200:68::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Mon, 29 Jun 2020 16:17:44 +0000
X-Originating-IP: [93.172.90.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f12de7d8-350c-451b-9af0-08d81c47f545
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4049:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB404902036AB0195CF5AD8635B66E0@AM0PR0502MB4049.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FaNNuIuvmX6zcZax+MNUr3rJhEVtDUPqjsuxuIdE9SEMglBW1/HEVggJ8KTEBfOAZNWyknQJBbUAUr55qVNit3ZL1cvUlLYIzFZKgoSUWCr0fONuOx0Je9Z6j4OAHqeJ9J80pkeA36Jt9nr1uROqv23STQ6cUP9/ByYnormGf8GFO5KBiw1LVTqBnA6TQFf8L2+ZOW7hUGoE9w/BU1SinYZuq/mp64tjahJGEcis6IMKLyxdJZbZQn9SDHIh6P94hEKgdDkbSgOK9HtbrEyPh2rWuXYuWsMb/acGbapvw8q3ungGBhD725P+FIuSEiQrnkkPgHB/44Z6TBIkcWdwyg664XMpERQ6en8OSWG8lOxA4TORYTCJl1Ml3lH5ZUg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(26005)(8676002)(5660300002)(31696002)(86362001)(558084003)(4270600006)(8936002)(16526019)(186003)(66946007)(4326008)(2906002)(16576012)(956004)(2616005)(66556008)(478600001)(316002)(66476007)(36756003)(52116002)(31686004)(19618925003)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lJINdIoV9MURXLjigSzr5kUODTi1jX0sDuiAArVwcUyUV00ZVr5tSo83xEk1J7y50H99ZQt5wk3FSmeNHNgQDfboVw24xP/3oH79heLODMKCcatOF3O4bNY3/KKlqOpSmWz2CFU8jyXR5WvX06o7WQY0pj/I/MWd6b2q9RRhqaOILBSCxQxIZp9vJ+3FDSIbbR8hNNFp8Yp2BYC6kgLiveTT9rH8j19VYxbB2oCwastZZoJjkwujrJGQBFZFAAD5eXaN76ipM/npXa8D1nF1jK6KL6sqg2z5HKczwwK+uCBXDKhJ/AdqhZ4e7iKPzqlZIdZ6J0dxsv9JqvXtN2pbHIBgO2n0169RkFxRoF6/YWQI4KjwcwOvbNh4TTiYZqTOQ717dtClY2F/jZqy7Py+P3Z7vaDMp8KRDJwLTqxImtYp+yE0/W+w5cfIw6tfJR7zYYNAK7YSPN5iHCyojHsFRCKv4AgzvnLJWhSXPS/alnQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12de7d8-350c-451b-9af0-08d81c47f545
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 16:17:45.7979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b1Qvxuer+7LDbaACSSUCAJT/J407sYzO/X+gMsfy0veR5jhUMrYB7/IWCY7NlnkbtXGTEeHl++TFol5Zf1CQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4049
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
Cc: Avinash M N <Avinash.M.N@wdc.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

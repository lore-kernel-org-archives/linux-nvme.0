Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F75C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:18:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17217206B5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FnGRi368";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="tNfswfxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17217206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CT9zKLCumdoWvid3orpdgBJHarj3wwIJfYr84zCfh3A=; b=FnGRi368aKiie5VLdntV59DpR
	9gntncjbFqSJD7wszl1Wz4PfQHCKRJTer0YSdA4py5FN4EZyFhz9YNsSUQYiKTuXvZYXbDcser8XN
	1ktjo5AaB/7p/L7maNV53bI5TQBjtCeT4iTayMSYtWr9dBUkhI7ovWDI1wkHl3/tHWvgLoVwLOgy7
	/AYpuRCF76ETxAUxw+YhKW0/ZS0OR1y0eAwR28QGxufY4Db9FVZvnYXdzjkJWZg0G4cCcoafIwLPQ
	UXoRjFn20riWCCudLogtibUKWryCniEGMjiHsIQIctO2TnT0VTW2Nh3HYFfCai18i6nl+yTqwyts6
	20ph0K4ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3iae-0006IW-4j; Thu, 06 Aug 2020 16:18:00 +0000
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com
 ([40.107.237.50] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3iab-0006HA-8T
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 16:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnjA4EzMLAGL34icwb7GzQZTKFMMTd8bjDd7erfdoanR6VLB2lt6oTSO5V6WZPYBhKIGF3JwUU5PkhfnABNLLU1QtGNiNFa11Kl2JtqtlXIUHWAWosBo+8D8G0Ezj6GtBvNODdKF3/Kwb10kP0ljmjM9bR+nacnXiVN7lCNZs9ldxnegz2wT0tpcIgZQQ49nEE9MASA9wdZBvXi1z3D5519dEYhTO2izHC9Pz2CzcuuyZXxSs4MZQydZkLWOgNDHt27NNYLYKapD79y+2/j83dRrVIE6P5yiysrFWhndNNtDKg3mjO0fnvJ6ViUL9rZkmcwFPYHhmtSxRnQO9XIiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfA1kD1gRQykSlKfaNMRumOHyYNiumgO9woGvKgHUPg=;
 b=Im3r6hFq2tLzUwwuGK09MafZgs21iN4Pg7JvfaSfYiWg9xS01zzo4Cft95c7CqI3vjqjqS/I0mRJcMjyqtnu+6+tEpieVRXQZJ+Xavv2gsEsTGJhHepsy1yMIWO4dtgai7uWwlWqbinCk7QLcWFvpT/V2NHumxpotZmSlYb/QL69LRdYWe2i4jMrG6Nv9MrqITd8cduzXG8QpxlgRadZ5IVKXWAWvp2D4nbe3oJN2g5X/E6IOTpooBCc0e8QXNLIjFJwKnHVtDF2vUR6IJD+z921hIyUgVYnUIGToTHMr0WGZ33yKdroRTstmeR8l8NI9n7P9N2ngZ1HjjETAFRKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfA1kD1gRQykSlKfaNMRumOHyYNiumgO9woGvKgHUPg=;
 b=tNfswfxeaAmmKMRLAa0gp6KcdfTg7xGylMTjg3XzqMjL98g6kyh7YirRhq90F36Z2tED8dX2arIbsvuy8WBDKBktrUf0cMDG8+LxOXrCGmzmmkxxTsoTt05WvJQ2tbrGWhtZfJOeJy77siU+Y8HqdJtEGjaCgkI3jPChql0/EEA=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN7PR06MB5220.namprd06.prod.outlook.com (2603:10b6:408:3d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Thu, 6 Aug
 2020 16:17:51 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 16:17:51 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Thread-Topic: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Thread-Index: AQHWY9sika+Y39+nU0e0JHeDBPsDKakc2lUAgAEFHICAADORgIABTLEAgAm/SwCAAJOagIAA8UoAgACPiID//9cAAIAABRMA
Date: Thu, 6 Aug 2020 16:17:50 +0000
Message-ID: <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
In-Reply-To: <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2efa87d9-43a8-4614-20ac-08d83a244445
x-ms-traffictypediagnostic: BN7PR06MB5220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB5220BC9F5A920BBB71A67690E4480@BN7PR06MB5220.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXMVZsHwY6mdRL02y2ODmaH5/AKZQ7Tl2pywTPs4LVgIHyhDGnCzK/RMissJ8FraN8/+UCpivdEulNR7f65YISKU8mTY7aMN2tI6MYoFKLTl81z3yvJzv7JoTQtzYf7TCkz8FSgNk/cgIDvVhQpPCzlTgGrMBG8++rVnCSb16pKXdgdkp11f9UYdK/oblDviIgbns+oFlFWvPEJCHjfXOfalaBFl6gHW60Q/B8TvT7Rr1JXyXspf0WDv+rFEnRrpSDgPk8a7ZwtpfJYtOlqJST3v12Dc189PvpJSfJNBySJ1oZw0pnDKbdxCYZNMOmwKcL7UZqr1yS7c3YGDCY1MbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(2616005)(26005)(478600001)(33656002)(71200400001)(186003)(4326008)(6486002)(86362001)(2906002)(76116006)(66446008)(66556008)(66476007)(6512007)(36756003)(5660300002)(83380400001)(8676002)(8936002)(91956017)(66946007)(6506007)(53546011)(110136005)(316002)(64756008)(54906003)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gINqg7vmoNLJO9/J8e2DyOGi1yP5lUdQGnlQOmLX815JG/VgYBo94lF5yOakxEYc3iAKcy47GJp8DadrzvUMI9bqRiNJKQTPUufNlVngeiOB28jARyGlHW0oGOL7btTxMTt8BVsmKuvLP7zcbcOz/I7GFf/nltYCdtZzKMHqjXR3CQVxDqcUdMK0/O1MmXu7OXzvjG2bgeluxhmSfUw0aDlUhzGEbBJT4zmxmkm9gcYIGAs4G9b0qGnmEHBXIDKXoexhQ7W6kTzJXuSUNvhR2Ukln+bI37UMu9wStX3DFDRi9x6dq1lFuewr19pMBvwLlRoczPYlY37+RXNFo9VMgvzEi920CRIgGXQRU6DPJ5lE/zIot9h5sWNInUs2OjAGpvfovkbEIxl36LLEuLngD182HeKj9TzQ+EK9ft07o0CJZKLIhU357DPDepJmTFHN4p9fo9J6EGS7y9BmZ151B2on6U8++iT9CQEMlS9DkTzdNw8fSSEg7IsKZqp5FZ4M/uhN3f6xvjkXBLRHswwTmrIRs6qd2FN2zzRovDDZlKQ5OXagtj9XeBWplHH1M6tM86MQNwHclRO4MuqDtK3y/0f81iih2ke09O8rVqHwzUBC7hg2FD/KNHEaWyuGAAlNk5b6p8pqNKVY/FANXqsVkw==
Content-ID: <BFB438BA121E2242A38A0BBEEF2CA90A@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efa87d9-43a8-4614-20ac-08d83a244445
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 16:17:50.9421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30AwCAzwamjRz1QJhgGWkrfFIqC3UK22Fdra4F0xbYbvSoLj3GUthUSgLiCrD+WHlXnR0GtPF3kBpNaOlPT6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB5220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_121757_334593_400E8FE0 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Hannes de <hare@suse.de>,
 Ewan Milne <emilne@redhat.com>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20, 11:59 AM, "Meneghini, John" <John.Meneghini@netapp.com> wrote:

    Maybe translate to
    >> BLK_STS_IOERR is also not suitable, we should translate
    >> NVME_SC_CMD_INTERRUPTED to BLK_STS_AGAIN.

I think this depends upon what the error handling is up the stack for BLK_STS_IOERR.

What does DM do with BLK_STS_IOERR?

    > BLK_STS_AGAIN is a bad choice as we use it for calls that block when
    > the callers asked for non-blocking submission.  I'm really not sure
    > we want to change anything here - the error definition clearly states
    > it is not a failure but a request to retry later.

So it sounds like you may need a new BLK_STS error.   However, even if you add
a new error, that's not going to be enough to communicate the CRDT or DNR 
information up the stack.
 
} blk_errors[] = {
        [BLK_STS_OK]            = { 0,          "" },
        [BLK_STS_NOTSUPP]       = { -EOPNOTSUPP, "operation not supported" },
        [BLK_STS_TIMEOUT]       = { -ETIMEDOUT, "timeout" },
        [BLK_STS_NOSPC]         = { -ENOSPC,    "critical space allocation" },
        [BLK_STS_TRANSPORT]     = { -ENOLINK,   "recoverable transport" },
        [BLK_STS_TARGET]        = { -EREMOTEIO, "critical target" },
        [BLK_STS_NEXUS]         = { -EBADE,     "critical nexus" },
        [BLK_STS_MEDIUM]        = { -ENODATA,   "critical medium" },
        [BLK_STS_PROTECTION]    = { -EILSEQ,    "protection" },
        [BLK_STS_RESOURCE]      = { -ENOMEM,    "kernel resource" },
        [BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },
        [BLK_STS_AGAIN]         = { -EAGAIN,    "nonblocking retry" },

        /* device mapper special case, should not leak out: */
        [BLK_STS_DM_REQUEUE]    = { -EREMCHG, "dm internal retry" },

        /* everything else not covered above: */
        [BLK_STS_IOERR]         = { -EIO,       "I/O" },
};

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

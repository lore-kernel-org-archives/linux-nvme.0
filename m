Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF45C4708F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 18:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BCA60FDC
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 18:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BCA60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oPYoJrnrWKC6tLsLTS/3fsR9M1Nw3hDzDuMD8nv2ZMY=; b=PML/hDP6VSgyJ9
	mTu5xEsWhYyckZqTxV45Ent8k566TCWHf63ESS3scCINxpH7CxFSO7e0jzJ/dqtCG7ebECaVEI/90
	LnpzULhf71EdLzajIjSZR8c1A44vr+gdoSrWj8w98PP2Lq3Jlzk6IA1KLiuDUfG3i5xIuSJJzGXhe
	5jRbNHQEoKc3WTiPOg9ik5gRllYauD2hl1UNIjhMjAjvaHAfmWSN6QEi/+JKPDrIkhy/0syQyiKKn
	bfpPdW2vQ+UK5wb5UCeHpWgRAXmhI+gjBIXElf/qM0Up35dvxFMES03dz5WqKdUDOnNr/ncbrfrNX
	Z6jir2ZwcmPZhZs/UFTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo961-000NFB-1F; Tue, 01 Jun 2021 18:26:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo95T-000Mr9-TG
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 18:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622571967; x=1654107967;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YuAfjp2kTzDlVtNJBJsXHmEYzc8PHsGCqAcKqP/POxI=;
 b=KGGYPxZZiHjdsd9DfWT5cVf5t4Q//OZpgLzFmLbhrtK04fA1BSgaVbCe
 VKwy7D+JYWZrQmRdwq546n0XzfusgBFCdLSoiQ89kdJNvotuh6r6jNdr+
 p/du7KhbesH0CvIMwV386DaGfYQlZUIxp/mKxW7vWx14TIVeEEcdL78Fu
 RFQUPNuJFOtv9v1Vc1smZyuNo4brGe2gN5n8Hea7m7LwKf/zBB1hnSOGA
 BQDhzWt1yXorI3TL62XSjoX1F07yeAzY1ZFOj/BeBisPX1bdrdfQ5sFrP
 pLWXxBraXgwkIMnn8OAysnal5Fu8EGB/SNgF4FAChjy7mbIxmVBJsUSmt A==;
IronPort-SDR: bK7UvvRQjcQS6h2phzkplYDjxtC9UoDimhpCurBXwXwbp3o3LIXTE/+woPRH2agmYB0v7tDori
 /FOXugqS16u03oe4EGZYkRdA+wn5E6RZh/D389jlufiGBCU95wUH0DMJhScv6sSVxVI6Q3yGMa
 /heBvlgogUpXMi3/0XaahZZLEs/euHbu8n40fFcUASscRrnFsNDgKIJ7h5xtW3YPkIOX8/id2A
 UJsWoo1wqOlDtd6hwp3YY0Q/xOlWUeM1KHWEVuIOU8wpIHmiMECq8aG1wZ8bEMttwPQWk4oNyc
 Gic=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; d="scan'208";a="274182973"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 02:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOBvuxjIPAxPGPt/uMqcY7ZNb1BmlT5BcD3I0rQzG1Vq8+E5KvMxae1COVONE95dP7S7BFcFwiiV7O/b4FYB76IhbmJFAubp0TsnRejGvI7uoyeHBBxnDDJortC/93zh7NJXOuvfkatxIXYxqmxiT+pfLnfPM3n62S0SiZAi2kgdQncFYA91aQbvJ3kPCG2WqODRUs1YRNoxCIFg+JES217pl9ypKbqM8lhujFkf07NSqnzQnxL9LeN/YGJgCVIqnSDO4t9v4fj5Ev1km14vinp/OvuKNpQgW3ZnA9xe25mHpLJ4/NEQmH2WPegGAj3GBCQZ3NALaQ3LbzSZA8KQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8YtYdfaQ5aQRAOTyrjdhL0/4DTQWyqjrxl7gTotX5Q=;
 b=X8YCA74XaG7mKbHsmjst/26ktpV5crQkurdCddCM4OIXuUmT8FaTpoUJ8G6rl8RYkSCe1W7z1cbmKhzDubJcaBr2/3FdoX+KXGMDmmodNL8TQo6KT9gPRyuvBPuEOpZ60LETFBe55HWVz+c/FifXrvN//jc/L4bPk3Swdxovz1aZI6kakEni7ab6QneAF9G2P1W5rile4928jiKi+/YBaIEtDC5mlElN//g97kUm94SddKTm2yg65pesqZaC0rSBETW20f0v/4Mb+BKIvOCl/vHRnh3tc14TG5Zkkc13DtiIFRMMaCbWDVcV+MVzweuSuUOKfMu6eGHcHI77rPrjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8YtYdfaQ5aQRAOTyrjdhL0/4DTQWyqjrxl7gTotX5Q=;
 b=Q/rGD7Bbjj9CeMPfg1G/2hqBhz7SO92+uJNRgvX/h2Z1hMmYIHHhWgpxFhPHb/AD/YVoy1iwEMD8jkIt+0i7ieIY1h6AXtyqb/sZcmMXM/B9TMciJ/wea2OShjmau+G2X4VaziptRS58yjPrJfBi7gGhV6GBm87hs2DOHHwEtx8=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB5739.namprd04.prod.outlook.com (2603:10b6:5:170::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Tue, 1 Jun 2021 18:25:55 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 18:25:55 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "oren@nvidia.com" <oren@nvidia.com>, "israelr@nvidia.com"
 <israelr@nvidia.com>, "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] nvmet: fix freeing unallocated p2pmem
Thread-Topic: [PATCH 1/1] nvmet: fix freeing unallocated p2pmem
Thread-Index: AQHXVwJK8McGq2a4mUOTqJWB7bPHGw==
Date: Tue, 1 Jun 2021 18:25:55 +0000
Message-ID: <DM6PR04MB4972308EB90B231859C1C83B863E9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210601162205.38326-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67698a56-a96d-44fb-7d73-08d9252ab1cc
x-ms-traffictypediagnostic: DM6PR04MB5739:
x-microsoft-antispam-prvs: <DM6PR04MB5739790FE8C0AC21C1AEBC8A863E9@DM6PR04MB5739.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUYVBan8/d7tUnVLlImj9C/J57M5py2zGnelxkf7PdFfDBxXLpNKT6gYmw1S4p/vs/q42SOTyOC3pzj38maGMWFECuJYOXSAwyZWCnw75ZwOqKtrdt/uC3xfQ6uVsDo8lvs2A1WdxgADQZjysOYAEo3nXAIvzt6AXE7Z1TQ79ylmtT4gfKlTZD7RleykIC1oyKGAagDUI8ZsA3OD0eO4s3douOHb3TzV07lq0b2HGKCjRDH7TAHczdw8ZPpzIQKCMY31SYJAbugRRwkyvdqX7EJalje6GWvwdleX6IoZTIXY+J8tTojlnkZRoz8ao3bcNyT17pR5aQ7K2F4WmexcejbiQGLtb1bVDLENDbd+Rul+BmRTripZpsdGL6TFw21OHuK84YD3/OS7idAqi8x92ytAWTjg4dMZwOSvnqjf33TGG1b/n7Xm+4/KPghR0I7Xc9Y4dFgHLCDIdR6CSVx9vbrRRTY3RriU4hlq8unilHSIwStMLdGDX4jNNy2+uravshEJleXKmmdwC7OdQthH+GCoOwmTAw3hsUzdGeoh3lEbl/fGAKMmkmk+bqmdzIqAz0Jlcu0xYr/rwcHQuoz3faay1A1ripUh9wAt3lW78iY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(86362001)(2906002)(66556008)(478600001)(55016002)(76116006)(91956017)(122000001)(66446008)(66476007)(38100700002)(71200400001)(8936002)(8676002)(316002)(33656002)(83380400001)(66946007)(53546011)(7696005)(6506007)(4326008)(110136005)(54906003)(5660300002)(52536014)(186003)(64756008)(9686003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1psNCp1rT9ZzmSmR1Ofpkb5FUkxSpE60cH5AJwjuvT1tScMK5R+dguaDb8Xa?=
 =?us-ascii?Q?FHQPUv5LGtRSayABR4asYg0mRcDnjVEFHz1Ojj6pLRSPHkWYvcUUti/5Za4E?=
 =?us-ascii?Q?W73Ljv0mCie1NuQUPIRpJJIFyr8M8C8qNSN7M5KQZH48zEdn+J1YUr7N/6pY?=
 =?us-ascii?Q?nRWoX5FXk3gFqin15LEjJ35yoqhd5VofAVjMQQnmHP1Xr3SdCMQYzqpBXYb8?=
 =?us-ascii?Q?20ikTz679jeKTlzQVivNZgOnWnO+UGPvz1nX1hsInfhst5zUcrHy0lwMvCAA?=
 =?us-ascii?Q?PA3i6+K1XNhZP8eEfILvw17nbnc6YhsCyORk0nLv6JH76esV++8u78jLoqm/?=
 =?us-ascii?Q?SnQOxQZnCV6OkTuohCl+hOMOfvMCB/metn5TfWouY0+YIKqNrOdEFSipZ3Eq?=
 =?us-ascii?Q?hsl/Q905KTH6kK7rUh91/J7Gjy/1b0ABuY6IT8CzCVdENrQKoHEcz+KbgfeN?=
 =?us-ascii?Q?2dC8j9x30CyOcZeEd2ZogBS1mzEN9gMhT2heLU2vfqr812+ptpJt7mX7DAyU?=
 =?us-ascii?Q?0VrOVWcz8URb/n5CvLbw/AnQL5fyyKMiyFjkbCZSN/ndP1vIcVCyQIVPr6fb?=
 =?us-ascii?Q?MdbsF6JNP/+VigMzyVQtjBONq2lxWwviKRJFUg6/SJlw/EgnnGFc61TjwAJp?=
 =?us-ascii?Q?ltS8ATyvGiIbv7fnMID3QerElpkU4bAWrM7J3F6MtZHlSDNHK5Q5qQXu3Bf2?=
 =?us-ascii?Q?ONqIozXajumoR2IING9QHk6iQhcyIXNIvTbqNPoN/0J1W+8W/w2ezDSNGNkz?=
 =?us-ascii?Q?ktyP0PAtoG9EbkfIgEnv3S38K4JeY9BRkaqC8LTw0MX1twga+q0TbIBODMQc?=
 =?us-ascii?Q?BOVQqXMN6lAxPHSNAe+lIOTkRVKFnqNViOrZWHVBTG8xGUSdweiUHrSZhi0A?=
 =?us-ascii?Q?olgyzJTXnJrvagVR8tpDGUkX59+1DQkHs1kvKRwZzUSdola0yooBCM+uZ+Bo?=
 =?us-ascii?Q?DPoEByxpTkXQGND7I47LyREcEQaJa7hq4QWnjL4I0N03talOWIX6R+ibdtvD?=
 =?us-ascii?Q?ZQEx2k6c0HaPenk8xl52VfahAmCHJP2ATCi6rddu5CE+4TDIaZPZsn5P/sgx?=
 =?us-ascii?Q?n7LXGAyYLHBe1LRjTA/NDbjqlzg+pg3iLTElVJMvbRlwt4E5b3sMYzT1WzwC?=
 =?us-ascii?Q?CJLZ1uZoLD4ixjSQkE+LdD5/AYax17TWjE0hfXaJDC+FCQXbaUI0wO3LQwWn?=
 =?us-ascii?Q?YJ4hVaYDbtPUCGrl8cP53RzPmB1FsO0KlJFv2Jh3iXzmn4/HQAxPMX8R3SaE?=
 =?us-ascii?Q?pnj3v6IFK8JeOxvT1rdUPFmN2LNrx5+FoI449twJ0/EqoYfeMZwyAQ7Ssl8Y?=
 =?us-ascii?Q?rLaNLKXzWV3UcH8do2mv5uIw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67698a56-a96d-44fb-7d73-08d9252ab1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 18:25:55.0189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6olWq/K2DPSbu6TQESuJ+2/MkugqdYB087X8pCPAk9YNwMGQscFsSnWrL4zxp8DFoeBus80Z0MvtpeYwbuaqUegyaEN/yM25mzXUy6Awn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5739
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_112600_058163_3266F9B6 
X-CRM114-Status: GOOD (  13.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/1/21 09:22, Max Gurtovoy wrote:
> In case p2p device was found but the p2p pool is empty, the nvme target
> is still trying to free the sgl from the p2p pool instead of the
> regular sgl pool and causing a crash (BUG() is called). Instead, assign
> the p2p_dev for the request only if it was allocated from p2p pool.
>
> This is the crash that was caused:
>
> [Sun May 30 19:13:53 2021] ------------[ cut here ]------------
> [Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
> [Sun May 30 19:13:53 2021] invalid opcode: 0000 [#1] SMP PTI
> ...
> [Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
> ...
> [Sun May 30 19:13:53 2021] RIP: 0010:gen_pool_free_owner+0xa8/0xb0
> ...
> [Sun May 30 19:13:53 2021] Call Trace:
> [Sun May 30 19:13:53 2021] ------------[ cut here ]------------
> [Sun May 30 19:13:53 2021]  pci_free_p2pmem+0x2b/0x70
> [Sun May 30 19:13:53 2021]  pci_p2pmem_free_sgl+0x4f/0x80
> [Sun May 30 19:13:53 2021]  nvmet_req_free_sgls+0x1e/0x80 [nvmet]
> [Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
> [Sun May 30 19:13:53 2021]  nvmet_rdma_release_rsp+0x4e/0x1f0 [nvmet_rdma]
> [Sun May 30 19:13:53 2021]  nvmet_rdma_send_done+0x1c/0x60 [nvmet_rdma]
>
> Fixes: c6e3f1339812 ("nvmet: add metadata support for block devices")
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

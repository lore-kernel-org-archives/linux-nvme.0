Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE1C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 14:48:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F002820727
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 14:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="khb+mSJu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="ggyWIoHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F002820727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X3Eqmg7DsQ9vgCO/tHjzKKSsQcObQeQoMxmj2mfU148=; b=khb+mSJuR23AMW
	jJ1cSCSS1h6nCGEJnoE0d5x9q7Ecubx80h0uihZl8ZnoPgKlgLsKmqzVwuSyWw/E/mCbOHuccJlXN
	LoOxIsdIRx3pPbI1aw3rwNxeqNH0L7Q/mq1yIxb8ZJOhQNUh2HHp07QG+YCYsEDGotwy7DdP8wq2q
	BxRbdUL+J7Se8UPQZK8MdiboTlmQmLwPJlyP/YL5j9dUTNVoIwLgMtVYKByG0I1GYjqvF3bGnX3jM
	QH0/SdsHPCT48ouACsv0uYnMng95pWH5MQEuXxQ5e/jQhHMOTTnH+YGx3Ni0Kd80ZwkgCGshQjyBQ
	FN50b7DrC4cxsln+Ih9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZc91-0004bK-Q5; Tue, 26 Nov 2019 14:48:47 +0000
Received: from mail-eopbgr820079.outbound.protection.outlook.com
 ([40.107.82.79] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZc8y-0003yG-Ax
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 14:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRqFkt+eYPHxa1Ptw09GquusqxC3ZoiCgKjztqf+EnemZP288kk0H0m2x7v1UuniZCDG/jth4XPBuspWBmE3Rb7v0e5zm60WnuhjTkMLJxHMz67hS1/t33xdd3QHNzuzliaC/TuQoSGvYF8zoBcFnoIWHNS5XcByR6NnFJG739b5Xcg8UfCJX0qSJ9UOAFdyxMziGZ1tJgRN0fZBZIF+SyIx9iPQW9wfHB7PpK7WEdfKZUYjE+k3ygfWI+lNRt0WkK61WgwooIugZWuYOU50XiHNvbR6AxLPkVc3/JT5h9mJDda9HBmOuKH1l+H0cXCqyHXaVCovvWThHZW00sAk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N2opOEHKdyv7hwMaswfHprH/CcZuB3UMsTF4g8liFM=;
 b=lM3l7vQLoBSObD/U7YJLp8I6za827McDe7Gs6FWOzrBcnianf+WvfO5Q058sHfATBenE/oirHjSNEnWKO3/hRUBuIQBIMkbPrvigqAPA2Zrf2K4+BDarLIQ71NC0pgmXYJ3fNNgVeanAp5Qa8+8DsQ0yTZPOXMMlmXTI/qKqbXkq8kEUxaZ9zXQp00XUZSdgH91/z3UAqikmZ+qWHLjF+t+dik1jVYM0IOUzKEI4/LOGSHFYUEgoC1Af+hp24CSNRNFKPCpeKwvOvqe5iMNxNikFNLKlq9z/HYJW1Qf9ehTGNQSFFs+VgoIH4k5JE5RE3MvNshkh6NInuWpHK5XFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N2opOEHKdyv7hwMaswfHprH/CcZuB3UMsTF4g8liFM=;
 b=ggyWIoHJ1vxViiTL5wYRX1ZPRXGja7ye+SU8g31fCtgpyOpsqa1HyNPep/kjDU30h9lWzPnGwT9dziuaxTlK2JB9exs0+aND0KQqCUCqEnqM8XV460RA6iy5AABFo73BuRuxZ5v07MdtiScz7huoSe1NiE3J71rg0RhW/txsqMg=
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (20.176.111.217) by
 DM6PR06MB6537.namprd06.prod.outlook.com (10.255.109.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Tue, 26 Nov 2019 14:48:40 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::2188:6269:2263:4fdf]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::2188:6269:2263:4fdf%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 14:48:40 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6i70O/OcJhBkqJbsj3FyXxoqediHCA
Date: Tue, 26 Nov 2019 14:48:40 +0000
Message-ID: <863930a5493eb29659ea599e946592fa48423e24.camel@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
In-Reply-To: <20191126133650.72196-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Martin.George@netapp.com; 
x-originating-ip: [122.172.5.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 732ba807-f760-4996-5acd-08d7727fba51
x-ms-traffictypediagnostic: DM6PR06MB6537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB65371D99883CB64487E96CCA95450@DM6PR06MB6537.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(6512007)(99286004)(110136005)(25786009)(256004)(54906003)(229853002)(2616005)(118296001)(305945005)(6436002)(7736002)(71200400001)(71190400001)(76176011)(446003)(11346002)(36756003)(6486002)(4001150100001)(5660300002)(8676002)(186003)(81156014)(81166006)(4326008)(316002)(66476007)(26005)(66946007)(66556008)(64756008)(66446008)(6506007)(14454004)(76116006)(91956017)(66066001)(2501003)(3846002)(6116002)(102836004)(50226002)(6246003)(478600001)(86362001)(8936002)(2906002)(99106002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR06MB6537;
 H:DM6PR06MB4634.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syNR2LZgbto8nzGSWqn4HLY7idepWIvShUDz+irJDRdvBhWuyOAvgZbIM0aKy3zinN4zEA98wBQmPTKeN/uB4BjBOL6W6wH/pa05spVMTodCTASHvq5B/mxb4I08IEG15e0yRz5qotTXsQXgRMWZfxRE+rb+2yqs3W/YPa9ZAw7F+gjIbMu09H6dkPjbAQFY04CiMopuJZglc5AnoeiO+VsGW8dVP4vBEBTaVZ3cih4X280zqq0SwUKRZBm8Fu39jAbH5LQj+PyeELu2hItwFCDYuGG0Rmeri6ggpUX7BRKldxyxjy7IXFkaFjCpSh0qQ3HXE7E49VmsXsSwYGGIB5haoWHQYHlj1vvHAm5SmeiE3N30GDrrPfhE+z7ukRiXyviPNSodHlufsk/645byl9Oz4lhJ5xhxYxZYIVd+RfCQ+aLre55pddVZ4M+7SlkW
Content-ID: <9115FE98C241BD4EBB91DD82D8149AFE@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732ba807-f760-4996-5acd-08d7727fba51
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 14:48:40.7262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zi03HWgqNP5GaItHAFotV7S9BcdEIMjqeA5ONzC4FOTCBFXkrWin+0t7+wU6OGzwa0uF+fWbQNczcYU/NEvYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6537
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_064844_452764_1C9865C4 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2019-11-26 at 14:36 +0100, Hannes Reinecke wrote:
> From: John Meneghini <johnm@netapp.com>
> 
> This patch fixes a bug in nvme_complete_rq logic introduced by
> Enhanced Command Retry code. According to TP-4033 the controller
> only sets CDR when the Command Interrupted status is returned.
> The current code interprets Command Interrupted status as a
> BLK_STS_IOERR, which results in a controller reset if
> REQ_NVME_MPATH is set.
> 
> Signed-off-by: John Meneghini <johnm@netapp.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c  | 2 ++
>  include/linux/blk_types.h | 1 +
>  include/linux/nvme.h      | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 108f60b46804..752a40daf2b3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -201,6 +201,8 @@ static blk_status_t nvme_error_status(u16 status)
>         switch (status & 0x7ff) {
>         case NVME_SC_SUCCESS:
>                 return BLK_STS_OK;
> +       case NVME_SC_COMMAND_INTERRUPTED:
> +               return BLK_STS_RESOURCE;
>         case NVME_SC_CAP_EXCEEDED:
>                 return BLK_STS_NOSPC;
>         case NVME_SC_LBA_RANGE:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d688b96d1d63..3a0d84528325 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t
> error)
>         case BLK_STS_NEXUS:
>         case BLK_STS_MEDIUM:
>         case BLK_STS_PROTECTION:
> +       case BLK_STS_RESOURCE:
>                 return false;
>         }
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index f61d6906e59d..6b21f3888cad 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1292,6 +1292,8 @@ enum {
> 
>         NVME_SC_NS_WRITE_PROTECTED      = 0x20,
> 
> +       NVME_SC_COMMAND_INTERRUPTED     = 0x21,
> +
>         NVME_SC_LBA_RANGE               = 0x80,
>         NVME_SC_CAP_EXCEEDED            = 0x81,
>         NVME_SC_NS_NOT_READY            = 0x82,
> --
> 2.16.4
> 

Looks good.

Reviewed-by: Martin George <marting@netapp.com>
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

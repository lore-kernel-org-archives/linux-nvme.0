Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBBCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 16:19:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C116122D05
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 16:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C116122D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MlMkPYUbyew5yYZ2Xv1Jot+6Yt3Jplmuz1F5BQK0fDY=; b=e4h42MfH21v7Rkc5cn4b4H4JV
	YiLa9gxOnHTFfu1wmCVJFYiG4OQYPSpmZKsS33GCVqDGWizbLT2H3bhyjqvLMFkfklZqx3Fs/BYbE
	dVchbttbtwg4HPkIyWzQyDMQN1YL9Xsyq4qdDQtaKsvfFCSRJWzz8xLRLOHwpS0Dzb8tUlfJEWZjO
	mrZmYsil8RI9/uqCPCIaNAd1em5BqWSzZg2+r3C6lqQG9h7CVGeIUT/0yc0VB+FYYzK1mVmruv3eA
	W/JxmR/l0c062eMhjSvdA0PbgQzBQFCQWOydoWV7BzQCJ++vpG2egkjXeMjsC6NNVaVlwsslC/RCe
	bfgyMv4ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzirI-0006PG-MR; Wed, 13 Jan 2021 16:18:56 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzirD-0006Kg-1l
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 16:18:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610554730; x=1642090730;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=k+3gkpEmkYWXEMlcK9LgKlLQmCnkEFvDv3TlVX2QVmY=;
 b=NqLthJ8aWRIFFDPWjdVHUP0X1Vns2SYPD24kRpgwNry73Eqz5m9WaO1E
 QJQ5buPm6Hpi4rVmrKAKga5eqbgk+reevvxcwH+nszKQKyaoe6+DZbv63
 3TcJB59jZ8OncasmVYsfg+2lheBrUtpkIYSHm+7YbSF5816gDaFUM0eeU
 9ba2j6KhpHlecmNHQTdrlsl5rvTgkLWoPxPETb0uYvjcWKfrr8D38XOwQ
 bh/eqAiEoSG1LZwBxQETUCnPlueYkYv21Zi88otU8r08ivC+N2p5EGeBA
 CKVfzLfMKUBys2Z+WBux5EhzuduFfQveVSbXu0yeoQUH8K3ZC5m+DlPBw g==;
IronPort-SDR: /cpoqSpCx5YQU+hlCYuGwrkq+EiqdycGSOkYiIGyL9OSeHmIgriPQVPrZyzhNxqNp0snAE5wDY
 LkQ8slqVB8yH3h/S6oMKENi4yUNq/L25Pz2U0HjmaJDxt46nWn2gC+Hoa/CbOa6liXvmOQT02r
 D4m6UP84koB9DfGQs4PFfbwewsuDh4+5QFd7R51ltak7urCaEny9ihPK8q40i9Yrhzsw8C/3IO
 OZCi7dNhrpsTaZrYButorsvQOk0ZMn8Zc6plhPRWA0fDqnb++CnzOE5+NE9PQ9ifP61yfwW/RC
 Fkk=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; d="scan'208";a="161785390"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 00:18:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f22wFLqbjmo/O2SwAZkBp8C9KYKPyAEhv3Dmw4rfDTnH1AJmfmid7N7XQOSjT0U3S0lD+2RjtqiWV+dWiTkkn+0IiSyPpzGAQ3ecYQ8hejnJNCn17y0iLKZddUskJxJeZGmDj8kMstdhbFZLvhmZRNXPTXSSToKe561Ka7GU462XdrnFKVCK+9ygMsgowAV/E/Cgs9rRGP3+jC8g6KtW4tk+dSTFus2mkXD36ZR/r6dVTq6kKFMjTwrXkPDuZNVQOcct84SZ+sPcBrofd1vbpoXc9g3cUkxpdAf2qBt42kHPyzpa8sfm8uL4ehp1cvZfOjk2PXJuyKU5Kxn+kbNQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Esrvh2jZ7Pcl2YZL5+wmdUluzkTPA+R8JCSGHMRNI=;
 b=bQy1j8QfIg9lEFo96m0fHdA4N3u9hIRZR/k1T2j0n7H+IkpoNX1QmRC9gsyq+VXvbAZ4k8hhzYsRLfeeV8NIcqbQkOqfonrrRX7GAVsaBKTQwvU8Ugx7kfj9XjRBGDX2FcihKdo84CnXffoUWIVW5icfK1Pg2yqN/Y5agwkSBkP7ulwDO1D5bJkPiiachkPoELHfhEUdf0XXGa05jUCKW8q+207hC73G5c1hBghJKNh3OTGMF2yHGnNEd+LA2c3YnDGCoITmbLKpbkLqMznevyFc/od/mZrWgjwy91BX1nv/d59gU2iEoFnlp4CKEMHcCZBJbWKXxPNViKpcCTn7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Esrvh2jZ7Pcl2YZL5+wmdUluzkTPA+R8JCSGHMRNI=;
 b=bIAk5YDYIEoitjN3+AHfHrBbQdQAGm4uyk3GYfvhFzMNLrRUM5EkKD/7Zy728pFjCeAIvxgdLkmhDkU7go8y84OJ4O6GHHNNfT2QosEuHXGkvc5mT8PMzbrPcUJ4gfDTTKTCqW9sgmK6uBhrBZWM/QGX0W8xS0wjYmBS8IF6Xvg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4160.namprd04.prod.outlook.com
 (2603:10b6:805:35::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 16:18:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 16:18:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Li Feng <fengli@smartx.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
Thread-Topic: [PATCH] nvme: reject the ns when the block size is smaller than
 a sector
Thread-Index: AQHW6cYiQ8r0UOC3okaYJHPdW7DXCw==
Date: Wed, 13 Jan 2021 16:18:26 +0000
Message-ID: <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210113160621.98615-1-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: smartx.com; dkim=none (message not signed)
 header.d=none;smartx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:c8b:c088:e383:ecf6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b11ee09-8063-4ebe-8c8b-08d8b7dedb54
x-ms-traffictypediagnostic: SN6PR04MB4160:
x-microsoft-antispam-prvs: <SN6PR04MB41603B6AA8E289EAC0CBC1F19BA90@SN6PR04MB4160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Hg0CMWZs6gC/p9+OHQM+UztcHvlJK1JIHTrO138RZ7kormg281Hh01Nl2LtS11Lw7AvrxkmqZgVzj2MSGQiHAxd4sHEeJ89QY87OouQ/OoF8QQjPHiXCU51mkSOJMpk4hxYdri6/HED5jam7iA/HQVaRhzRdAIMJP9fyDOtw2IsbtiQyrtNGZh/AQ+0grTWYTqRiNT4uR2DbnTgaVfIlt5BJihqsNlHKo9JAnxbCntSuUd2NDrXJ8cMNTd2zlbTGCFTay2JVEGmSH8MsZH6SPk0E61EEzLKfFBTaZo8KkzjwXorLWp2XqsrprM4noLpG/U5fjkO8iNA+0qh3dz7CKVsvTb7DTtHGb5D6qt6SFfLabbHtn5UlmrQQ7z3CaI/NbMIyqti0vicWpTcj2T7lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(4326008)(186003)(86362001)(71200400001)(8936002)(8676002)(9686003)(7696005)(110136005)(55016002)(2906002)(91956017)(53546011)(478600001)(5660300002)(64756008)(66476007)(76116006)(66446008)(66556008)(66946007)(83380400001)(33656002)(316002)(6506007)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R5zpLXegbSgegiFgTn8xSIcSJosTeURblg7KMihQGXU5Lw1Wry13Z6M3vRe3?=
 =?us-ascii?Q?i0xh/O5qPX1EnQEKN1GL24af3NFYfIe3tW0Inc+cZAtnYLRvQQ3iWv2Z5bdy?=
 =?us-ascii?Q?apqUaBLwemh0wfJGIQkrAYWAY1Q9KcQEm8hl0pf4qMCrlWntB2qgtwIFFs4X?=
 =?us-ascii?Q?6+Hn8eD0wcLKOygv3ZkYLp04iyRQarG7FX0oNrKJ2G9KqqySoHUOuL1sUlAt?=
 =?us-ascii?Q?b1nhcH2vfywp1TecgMafxmKLYtBTwni89BGY246IM6vk+s+MyeIaPjl0mBFb?=
 =?us-ascii?Q?5gQtuCUoPhkVcqj8zss51LUF7l0LoBxz7PmO2Vrd4Gqmo/fkJfwebYyVRDW9?=
 =?us-ascii?Q?2er3V77MqROzv97w+CFS8r1ADgk7FsncalXCm01MPtQ6fjgxUDo96XHclym4?=
 =?us-ascii?Q?+zaZGWJ8hEvoa46B6UH1ludbbCU5y9b/DzIz7Ju4HUp0aZDWTgHmoTpDfBDs?=
 =?us-ascii?Q?PO1TTBS/wJSiiYhDmcCCPHgX3wOZWhz8e9iz0re6QbQfMOjiedJ4vSgrmHR/?=
 =?us-ascii?Q?R24IAzFAJITLnbat6BZ0xtkuX3iM7qaC1lT1KdN7TGgNzHsR7tJs8aX43Fod?=
 =?us-ascii?Q?n2/m68aarz2tLvFg/5xI2aSL3bIli7KV7yyQ2yyUc512yeUor8SwjHWdD+h9?=
 =?us-ascii?Q?o7Fu2Kehr/RtAqqvNl/CioMcxutN4SqwVWE13Awx5ju8XP1JID0mfHgPYRq0?=
 =?us-ascii?Q?tL05lqDZV9Ns8ou1rrPpteXilVb7kQKjEMArNoBttdcxHxx3Dn9iMs/bg5ix?=
 =?us-ascii?Q?82FI6CXH1UBn6sHnja+FMtjBL2PKcaW4wXbTET5NcZWJOoemF8Oo42MS5vhr?=
 =?us-ascii?Q?PRApqoYmbaMu/Q3K0LX+cE8NEoYRGUnuDdfW9DYmQjk8w4BFRGslMF236dD8?=
 =?us-ascii?Q?GYn9R6hJWAGTu3dJGErp8jq5HiwTcj57+UmISBF9X2o2BWA4tKv/i/chNlfp?=
 =?us-ascii?Q?rqZEzwamweQYPBKn13xuLhLskV6tDoocC5a3vwTdVCEm4Gd/ztVrsHaJZOZt?=
 =?us-ascii?Q?z6O0fIX9voEQelKRBuR3pzmkeOi7Of4b18rF8InKk1+739bJjhxdTqM/VAE5?=
 =?us-ascii?Q?BT13uHeu?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b11ee09-8063-4ebe-8c8b-08d8b7dedb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 16:18:26.2579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teadxG2QjroiHl9WQq6Mo3r8R6jk9O6Jo/GX192p1+kbfK7xzKOI9TLiHygmU62ju7wYj3mXPwCfeLInZbDucDR+0LR7NBOQe7zyhzDA1DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_111851_582055_DC88C4AD 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 13/01/2021 17:07, Li Feng wrote:
> The nvme spec(1.4a, figure 248) says:
> "A value smaller than 9 (i.e., 512 bytes) is not supported."
> 
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  drivers/nvme/host/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f320273fc672..1f02e6e49a05 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  
>  	blk_mq_freeze_queue(ns->disk->queue);
>  	ns->lba_shift = id->lbaf[lbaf].ds;
> +	if (ns->lba_shift < 9) {
> +		pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, ns->lba_shift);
> +		ret = -1;
> +		goto out_unfreeze;
> +	}
> +
>  	nvme_set_queue_limits(ns->ctrl, ns->queue);
>  
>  	if (ns->head->ids.csi == NVME_CSI_ZNS) {
> 


But this only catches a physical block size < 512 for NVMe, not any other block device.

Please fix it for the general case in blk_queue_physical_block_size().

Thanks,
	Johannes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

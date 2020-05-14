Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C5C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDA120575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOdV4QsQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LItuxYg1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NtX4qy8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDA120575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3c9JsGJxj3tGwFpocZnb1hPF1vQXrjfvPq4YC+jU49I=; b=qOdV4QsQtkoGeg
	uhH+L7rqcjulE1z0am1rma7KxEhhvUF8Jl0iAEyYbJfHKgpTPV1TRLwZJiOaVdDRTi7PMduEu40BK
	VrjbUN3Z9aWzMA9wTi/hs2yRyCkl7q1iTkxD+pwzsTtSyO/HXhSg0IfnVdRgTL/gv92Nu4n3aaJP9
	eGwUXswixIbjROEEhF1d9dyFaTWdPqoLs2RCkTkOJYrxnHFokumXahY2FmN92Pv9haTG8mA1UhJ38
	NaZh25y3dV5FebSHDBB3Gt5oE4D/ZbvZW1sRzMrQRkHcP8rCpuvuHLILz2CXGSUWyzvBf2K1OmDKn
	F202AzN06R6L8LEiGuRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ7A5-0002GF-2z; Thu, 14 May 2020 06:16:05 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ7A2-0002Fo-Cf
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 06:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589436964; x=1620972964;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Syq1Pyd4rnVg/LKJim5YYi/SDeYI1KuKRG5AGuj4WMg=;
 b=LItuxYg1JiTFL5SUrr2buR7cqXWJ7JFF48kAuQHjhWrvCxHGTm7oqa1j
 jrSm9Myg/vNey9bZN/RHNorQNpUHtmcEqHNayiIKaakNTMOAnfoL3Nfvd
 2gReRUbrloh5osopa4l85dFtgwQyfKrTansmInbn0mTwaCJ9FtljGWSDB
 2CKR7V5yxeveJ24G0wcqajihwZuZtPjo+NBXzMmwCZF8gTUsHKHAHtUeW
 GUTvcn869TY5P1gPILG3XBcWp9QIYPFjt2WlO5J7ieVfQV4GqD6AdRSnH
 MsfCLmOKAArj9RLebv/oYZh/9k2cmQwdWyo8rx6PUAaU/OIDNQKvDwrKP Q==;
IronPort-SDR: yR4YQpj3LYo0oUSsdKHDm+82+TqPDLAjrOjBwo65ql380O4S2OPbLg5Xsg7jL6sbbOmVYHj2Se
 bLDCezROuucWnlC+SnOY57cnuGMjTUb7EIch0WxBobU8gvM5+XGlNiDP/tFqttFfpq8I+zn/6h
 cg71/WZTvd+ZRhekNIU1WNIUe6c4X9cnLjnzt3M2Z8K6MGrLwGSHKNqpVQUz5fzpVEaC1GYbdz
 JfhNlNshzfnbym1MQckRZ2XlLDUFev/K1pvBa9wpxCfnbAmhKciBpdCkrP8Q1rx5Ek1QLIkMb4
 HH8=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; d="scan'208";a="240358592"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 14:16:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF5UDMsa9kkvNPEEDstR9JV1jkqWbaoho4XPGbFYuWl4yRARzzboSOX9gY5JYIXelRiBoA1jMQFaJubr2rC0dGggK6OMy5po4p+16WkWQrvpnBvyNLBFckbDr7xKUd0Kyd6wPI+Ak7XlOjWvj7JSqybDkOeDh+LdK6ihNcrVUu0Qhq/ARaqn8jF29QA6+l5onh6p1mhvALH7eochS3m8vmihZ8ljKSOxa6u+ODsT4yWqtDCgLBccatRPoIouS61nYoNTPAMyMzaxZQsvo2HdB8bjpg1jWmK8G9ZPzW6mcAOB8bS3MdsgRwlAwuNfJI8M+NAmGsIZ2WRzNxx6gl9jAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOw8bc+8a2kAJBz94et4tT5Nrq+AeoskywSZZSZQ3Qk=;
 b=JMKXpOhUn5KXvpdWfwLmhe8vvZCfLiPYnQLKjPWaT/UFrwt1Mmmp2VeNzSsf5rHK5zLe3Zt+w07qYr+aFI5M1b3XaYCI9T0KfQacxNvWdaVKMNg1xiG3JFdbT/OBM9qIot3ZIffVu/SeuAxT/Girzp8d+QbNJDNmTOy1LVcAGfdbhSxDRdAZbq3ZcDQMVGMdXieUn/aUOLA8GR5CMIWAp3IY4EJDbKXHUBENB9hhjhiKyzxMNsTcz05BE6yotSQZdWZIGynLZJPKsP+c6z+MbUtPlpwxeQxp9Z6yQjYucHQwS8ygXXLiWOuQG/20cmWp9wiuk0NAp7TyR6FukfS05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOw8bc+8a2kAJBz94et4tT5Nrq+AeoskywSZZSZQ3Qk=;
 b=NtX4qy8qOdxakORCBaP7VweTSBiRuH1G03PISIs1BksMSWDSTENTbUiBZPE4c4fBYiOvEKCH+/SPMWKxqDpYRnHJ1y8jr/EXdUQM2Q5mdFAAF5qerQs5X9dgy8x2d6O9EEBVJgYevHAP46AVklHA4ndtH9vl8qciDdruwrNmttw=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6962.namprd04.prod.outlook.com (2603:10b6:a03:221::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 06:15:59 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 06:15:59 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: set 'io_opt' to '0' if not specified
Thread-Topic: [PATCH] nvme: set 'io_opt' to '0' if not specified
Thread-Index: AQHWKbWpu1oUgY3vRU6AbpBX1ZdECQ==
Date: Thu, 14 May 2020 06:15:58 +0000
Message-ID: <BY5PR04MB69006E0CA6B876CAA1D1474BE7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514060514.85309-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1096604a-37f2-4335-1148-08d7f7ce451d
x-ms-traffictypediagnostic: BY5PR04MB6962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB69628D1FC4F9A8086F24FFF1E7BC0@BY5PR04MB6962.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0D0pC9zcRbge3B6h8bSjZqR3vN1ULNCQFO3OzjpMbs1c2WxE1kroDKqKYoUFdStdUlHbsemJHxrMyS9ZjefSpav11OPCoDlklaOoe411tLXX4RDJf7CaL4+bw/qsXalTDpXwjq2a0HMioSbxNZbBKLl6ZsfMO0/7wN1HcFDyt/IzcF8klV34jw+ZXSOy2wQugwjfljYcQoj+kKnnQtYgFOTYRqCDZ/C0x6zL1VvLOi/eEKeUkG0ygZ6JLmNkhXSNgNsYGTThuQK66AvOA0b/l+W0qZUYK7UynYH+59y7SNAsnt5pFxfbmCyEvoo10xDnH7LzOnpMDj7ivtRRm6QNLtEyawdHx9ZgFer5i4ADY65fr3+tWtofgfxPCzzfmi2r2RJAu4ZBPuggfzvuYQkN7BLM/h624Y+3LSU7HHQlMKIH17H7+vk6B4T0E6CSBeF1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR04MB6900.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(7696005)(5660300002)(33656002)(86362001)(76116006)(4326008)(55016002)(8676002)(66946007)(8936002)(9686003)(2906002)(71200400001)(66476007)(64756008)(186003)(66556008)(6506007)(478600001)(26005)(66446008)(53546011)(110136005)(316002)(54906003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: lz5RoIahCDs86n4mZ/NicyD9sQ8pp+1K7PCfoqeyFDW+lXzuKywX8L93thgVR4P1w+GVQIgU6CoUi4qm06uExX2oMbpXyfwGHLmT5bERYGXXIIx08rLrNhtwF3Imjbm5K3CKHdHBfYrzigZJDBAxFt2Zak/3QAsyTowpNTK4COIVPtcB6OdhT/zLIr2J+H+u8SKCKq2J6vQzRywH+OAvO5P2x014d4PolbSE5zEiB/TzVHugZBPgejtQSPoWsP3kIVKEa3mE9Kv89jUQ8lbaosUa4fAMbIb0MxmpRnzEM33Xwa+DVNQkIpsMS8ULQg+Kr/m5UA5avvpdwYVBcrHMwN9oMaRlylAI/7ysulYhkyxP5fPWa7tn5FHJircc7FTrZ+8v5D7N73Qb0JSCA/OfV6DPvwtGTdAKese92UqnbqQgflzsnBBRzygetWf6LzI1Oovep25E9Ea+o6glyewIKbiyoPeodVnuN8EBbUALehaap1Zk/pniLi7viPJfLDNU
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1096604a-37f2-4335-1148-08d7f7ce451d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 06:15:58.9876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IJO+CwAPdtN8SvSyVkX+yl6iHMwY3n0j/VBPTlUeSf3S7+BBfJeITXfidtKNwXyqY4v9HcEm/zXcgFN86OB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6962
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_231602_591889_0347DD17 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Mike Snitzer <snitzer@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/05/14 15:05, Hannes Reinecke wrote:
> When no optimal I/O size is report we should set the value of
> io_opt to '0', not the block size.
> This avoids any potential miscalculation of the block limits
> for stacking devices.
> 
> Reported-by: Damien LeMoal <damien.lemoal@wdc.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a4d8c90ee7cc..6a8a8e749d11 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1785,12 +1785,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  		atomic_bs = bs;
>  	}
>  	phys_bs = bs;
> -	io_opt = bs;
> +	io_opt = 0;
>  	if (id->nsfeat & (1 << 4)) {
>  		/* NPWG = Namespace Preferred Write Granularity */
>  		phys_bs *= 1 + le16_to_cpu(id->npwg);
>  		/* NOWS = Namespace Optimal Write Size */
> -		io_opt *= 1 + le16_to_cpu(id->nows);
> +		io_opt = bs * 1 + le16_to_cpu(id->nows);
>  	}
>  
>  	blk_queue_logical_block_size(disk->queue, bs);
> 

Haha ! I beat you to it :) Just sent a patch for that.

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

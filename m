Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A5AC4740A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5FD21479
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XT5YKDro";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iFE3CVFJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j/5Wldjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5FD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BxWs+cdjgGgwSg2NCePEvuFAHJ46PUbhym3uEbaL/WA=; b=XT5YKDrofLy+os
	w3EPsaGbh27ff8Ulfs4viy05bBHTREEHjvXs0wCfEsZp7yl2LOsydBat8cNslg6ZVvzmrPAxhz/Av
	D0Whzc0GYEVUjJTmk9ugsGnMnQmkRD5dObvFvObsmpnPdwHh10O23bpyRKJp5TzHIy5I0wiOZb0gR
	pm2XYZKswuiphWgz36oI9jozXc8RdO53yXNRXCxMcD4PyaVSr7aJmRbeoMSY6jBVph4Ul14T6R456
	1ctBSdldAMspDKgsalSXtWHg6SeVowggwEUbUZEvAZZkkwsc9qOGuyR41X6QZCeneFvSETa6b4S/g
	8RO2Kb1X+7OcxM6upE+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7Mrf-0004aq-Ex; Mon, 09 Sep 2019 16:50:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7Mrb-0003t4-Oh
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 16:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568047804; x=1599583804;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vm5gUj66+wjL8ku2dZt3S1Ycw8/LEQ7wkKsHUx5z+JE=;
 b=iFE3CVFJXu5jfFgCL5/3HamZ0AH079K1bTgEFU71YMgDIqiSopZOwA4v
 0t5SEUh+b/P6wW8gGL/t8ZYFiKMq0IffQxWd8s29EKIGiXiGQD2Xn3Pc7
 KkYjpqE2qkp9JgyQHEyDrwFhtxurP5XDZYvRfUFo63VXAq+WxnrFZBeSv
 v2uP85c1KbVl3VW+RwmGUJHvARYX7GHtf/oxaAbS2Bda9Y1+Fr1CqXPPR
 SCVOMUzzFhhC6H98iD99QMotYnaJIFqCl9RlEW4iAB/IFfYebCRFkI4iV
 dtH+O9p69sFZJneyocX/EDYfkIykioYOOEYAdl3EBL/14PrYqjQcHhCzu g==;
IronPort-SDR: 0UkRDSqlUUZ6SQGBNvbHtz44gsXfiWu63Z44Ad81P7OlXqIgm0Py86YyqRbSgkrvWio5ExB9J1
 m42YFr0Neo+XXGXppZX8ukpCMcckm812IFHk63i45m1RqoVwICe36NOMn6U9uICVt8W+AkzKiQ
 xPVnCjyzEdUDGfu5D+a/z0OIry1qdKvlpKhOPRghqu/zV2y9KjMteiSzy0tm61e9YifveDAgMe
 EfKQR5UqlWFpjAFtCXOXE2433y3RfUiPBAqcsBGiGcYbmL0nw1jcCjG0NO1oJyThNT1Se8qWo6
 IXA=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; d="scan'208";a="117829724"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
 by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 00:50:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN8/FZJx/PZ8gJHxI4IyRvv57599Ph6qA7ntdrFga0pN+NzpA4GK9EuFC9Mcf39xI5IkzqzOSWzwlHooQkLQYr+oSMDiw3nVCA8iCcG444N6/fTuS1n7mpS/mSO5KXzew+soRu5z7K9pqmKgCOsRTAa9DehTjlmQefVaLVbUxD6FdGsOeTnGYlCnb6SRQZ7TVLzNHoebs9MY+vC8oQEgsXPpjsAquVNWjrTsiXV91ZKZEGh+TBcr8w/zbhoeTf1wahoVcphi1/j9gr8tvFIwCBowmyerWDpBvAbnfqDL+mDi7qiYBJBtxYlRy33/I5cSCgdpMWC54++DZc3tl+aIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIC2/V29IGN9wdOMUABeO86fLnmXapxq/o50rBwhLDA=;
 b=cTeJwMGBCz8w4QreXjc2wjMw54x0Hto4RlY8Gg23Tx/bT6uAWdN6vQWwyDbBzwvS4pYk+8/pi7OLWw21jU7tJqf7/XP0dHwsVw1uIGKAh2VXZ8uhp12sZ+1P3d8Bumxs/jbUOyWGrsw2pgykdK6I4YM9IF8CqC7ZLDnzwXJgYNOxlgh4SsulgNEtRTr9S6yWBGpMJn2/tk+5LuSYNZ10DXUd3r0PH+2bNmtFqe1ME/VsvfWxeMxoe6yoghxvJu7XiXCU8sL9DoxZXyWHaULV2MGp8Ke0wum21agd7TM1yw6P8MsPfwdVrr84N4XcBwbVGwJP8Slqu8U53gCehVAmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIC2/V29IGN9wdOMUABeO86fLnmXapxq/o50rBwhLDA=;
 b=j/5Wldjx7kt6SqQOLTbH0j5AX2bQX0y0fCJ5kVhB5TUeQSg3F556v+rEqo6ICgIOJCzWtfn+fD5engPlf6qQTunatTG0skcTF0Sm/VoFm6+soHUa5YMbyYoCkgweqWoj4ysrdpd43JN0fOKyzeEMFz/dnrEPte41UyVxD+8h20w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4167.namprd04.prod.outlook.com (20.176.251.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 16:50:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 16:50:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 4/4] nvme: send discovery log page change events to
 userspace
Thread-Topic: [PATCH v4 4/4] nvme: send discovery log page change events to
 userspace
Thread-Index: AQHVY2w1tt3T/4yQU0qIlLQruAEubg==
Date: Mon, 9 Sep 2019 16:50:00 +0000
Message-ID: <BYAPR04MB5749EE58BDD4B39F9B39EC1586B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-5-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac18c430-324b-4458-1449-08d73545c121
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4167; 
x-ms-traffictypediagnostic: BYAPR04MB4167:
x-microsoft-antispam-prvs: <BYAPR04MB41679CEDE087369FFBC6401186B70@BYAPR04MB4167.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(66946007)(486006)(3846002)(446003)(476003)(305945005)(186003)(5660300002)(53936002)(2906002)(8936002)(26005)(33656002)(102836004)(6436002)(99286004)(6246003)(316002)(14454004)(25786009)(66066001)(7696005)(76176011)(4326008)(110136005)(6506007)(53546011)(8676002)(256004)(54906003)(81156014)(81166006)(229853002)(9686003)(6116002)(66556008)(86362001)(55016002)(64756008)(76116006)(71200400001)(2501003)(7736002)(71190400001)(74316002)(66446008)(14444005)(66476007)(52536014)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4167;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WJPw/o7XkeD8RMCXvVjMEQkozEE27n8pVrDsbvInI5OLLG8y9AtyytOkHA4dLM5nEJgf/TZWo+hvLUU5xF2e4NeRzrU/aTLUNUaBBe23fKdup9X+QXnVbyQgQElos7sFYpulVOUIIG1FswOkYKY6aDLHhtR6Gc0TsZHlmx7YF2UJzF4zL0VAPy8dSKz2SGZEmZF4E2mTZRqjuSBPrcUs/1H4XXD7O7OxiLFjPRCt3zscT32D7VJKZaSdSfvq3EVNFiT+PrRA9i+W3ioZ2FSWdskBrH3jgxFW+VpNE0jF/+8Z1SDO6R+vq8IyGA70PCNmrJPqfFo54GnbuhuYZE+nJhl0B1GIlGQB583tBoR4vyWL7RoqwMjr7I8cELpvk5hrS6JD6fwRF4QBVYunxdkdtVM52fkstawCSunwBGVny4I=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac18c430-324b-4458-1449-08d73545c121
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 16:50:00.3861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uDszPBjDqSXsDQfYktciXG2SNpOBK/3qmz0nFSJqLfFcJ3Zuc2/J0yJRlb5hVJntyXvsfRgz3C0jGsg5Y6B2dpemzoT3ZpLyxzUULVJCGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_095003_849280_88367156 
X-CRM114-Status: GOOD (  14.19  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 09/04/2019 03:00 PM, Sagi Grimberg wrote:
> If the controller supports discovery log page change events,
> we want to enable it. When we see a discovery log change event
> we will send it up to userspace and expect it to handle it.
>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: James Smart <james.smart@broadcom.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7a1df95ec840..b1ff49ffde25 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1186,7 +1186,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>
>   #define NVME_AEN_SUPPORTED \
> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
> +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE | \
> +	 NVME_AEN_CFG_DISC_CHANGE)
>
>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
> @@ -3763,6 +3764,9 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   		queue_work(nvme_wq, &ctrl->ana_work);
>   		break;
>   #endif
> +	case NVME_AER_NOTICE_DISC_CHANGED:
> +		ctrl->aen_result = result;
> +		break;
>   	default:
>   		dev_warn(ctrl->device, "async event result %08x\n", result);
>   	}
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

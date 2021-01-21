Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67396C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 20:03:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D8423A54
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 20:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D8423A54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=6Kl2Zto8WstSfNkNS+SteHzoeeqndwSbh483JkC613U=; b=tjjzLeFxQOFU++RwauYBWkIZY
	zXoieFn058K2mjzlzuS44iVChdlvDgMRyMmR5gyd4OaYlsmpMG5kIAGLQvv1HhWkYcR086bG/WVK9
	1xxQjprUeLzsqrXyQ6AYEKwz9wJUJYuF8TmZCQG2HtK6FgC0V8pNZbZDU0UMWPA5QwxvUx6GiNdWa
	6W4QJ/A/BxYDeQfEuIU+7He9TN6ox+zdrrFo3qGnX+CrNntbx7OB11DTWWrrmC/Ltu2l+WVXksI/8
	rjNPp6JIQzHKET1Vvw13f5ym4V95BC/xTZqS5p2WOhp/0cYDCGZ6+e9N/gxyRLRCVMBwFs+4Jc4MK
	E3okbm0PQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2gAz-0002Ty-8T; Thu, 21 Jan 2021 20:03:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2gAu-0002Tb-GI
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 20:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611259404; x=1642795404;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MWbYd/3UOD84RdiCMnyqCbiKMserwmFIJWMaGtyueLY=;
 b=ic/bkqkITQTnaTPV4xg3KT9aL7P55oeiKxzx2zLRzCA26gkmWfafAQPR
 3rIaY1aGub0pHrTGkLw7+T7zEg5ZACQASGJZQ6CpnmZKNcB3kpoDgDXEd
 idqIz5ryghi/4E7rT093YN4jtLtRdeH2mkFdp8k6zktqX3YtAlD86tmC1
 iacG+sL3hHl0sEIaZnAg3vR6vK3XLeEQUidbmi5Hk7yy5k40geUrP2L67
 1XtZMaYx0oUDL92CUv8lSR4dnj3gDUyIIRjJZHflOOxsb4MS/uTmTTfWt
 HA861+Xg1k0mdTac3U8lVR9AuOy0CgFtUqi5UsaVrTqXlOU+OWu7nRcY2 A==;
IronPort-SDR: gyO+Zr+wZRDRbwhW8UPnO2Hlp12+6YQkAcarWUJzG1VroG+RCa/b0J04J5NSQU3tZYFrMOU+1y
 qvotAa+agOmi22/5eP6bYmvQn3m+wJXddNIhG4h7P7o3GWxVO0JBSkDFfExEZbhgZhmQi1vpRp
 wzEs230/WK13LHCC8Cnc5lWeVNlsaxk3IIRzDULXwQ4kpCQCbcBbQfhXa5fY1tf9kiMLXqJrRj
 0rb2+pL+uXTS1HHU3uCVhIlqaMZ6+Ens8Oj62eWfe0rKRbkMoKZVScDGq8Gmp19z94aHzaG0Hi
 O/E=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; d="scan'208";a="268352198"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 04:03:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA+dcHl1ftuS8cl9dwMobhdCNuu4IOzzbYYuUH3kuAWHo/ZFCb9d9riuyGKBUz9ko+n4HTe54cIHYKFgMhNu33jlJycDSS27wzedJ9Msf3Y1EabC6kjJMKOA95WzxlSkMyZ7zFu4u03vaFT34kUL5qiYHEsIY68NHTPoHInvOK0ZFzUQzn1/cRg6rc+n0XOVZueGkVqI+oL4/xEpXdYB4IlViCGPGysN3w+vztsWDy2/fuRDYlMlxn3adVjvmSAk7YMJBj6kNtHJcPaKcFsAMHS+qG1DWdmcYi76dM+ZFuZ8fKYKp1nyK+LNfZjmNCzWziTTEf5ob52EXB7QoCE1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxFyHrD/u75Xmh1/IuNaLnvN9f/nluO4LwxEjzf0n5Y=;
 b=hEbuMD6OkGd5j2517MLl2hCgoomLuu6/p36gH2GQx1ez81ly9iGHb8LxitRSsT3oBEvBzqeDMt8aeQsLyYRPNOaTbWgSP0eXYZo3OJZK0Au7sU9hWYf3UmBtHVVh7Ax5bwy7t5Nx7WDIBTqZNgGdxzvG/wVRTFrY0yH1jFq/Jy/Oat2LklD4KE7g5otdEHSV8ndLXtPMrIjedbSFGMtYm5mRMR19CVGpKoATlYD8Kj20bQudtI/dpg0EKgkPZPEvxbiNTp3jFuDzB9CgnJk2mEQQbk6n8EaLUJHw/E3OXGKWwrKuO1Azo6MSd6LtEDxwGtinV20NhabVYoEJRf3JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxFyHrD/u75Xmh1/IuNaLnvN9f/nluO4LwxEjzf0n5Y=;
 b=RXYdaGzEG1blpcgSMYV9nxDXKoEKhITV1MPRmNQvanDfoIRb+uYY7/hEMtMVJ5I+K4eH8c+IsEfs43qMX2MmgnFk62uZgEOFtkSh2SEgmIsTv/KsWTSINvQsWTimZGtoQp1OecWQqslmvTjSOi0PMJGNK8HFTT8lEfuQ4EFK0TE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 20:03:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.014; Thu, 21 Jan 2021
 20:03:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
Thread-Topic: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
Thread-Index: AQHW79ty/9dkKpZp10+YeIoqsPe/uQ==
Date: Thu, 21 Jan 2021 20:03:20 +0000
Message-ID: <BYAPR04MB4965DAA1B3A63EFBBA23BE1986A10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210121095021.22807-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:c86c:de23:1602:ad74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 023f90ea-0cf3-432e-48ed-08d8be4799d6
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7122B4E5428B80D76D286D7786A19@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMnlik2w1BbgPnsoCS0MrDayb1tUHTjxL7mGCZT/3e/ISi+GkbZsePZSxF9xR52k7QbxU6ufmDAJ6qBWJOQAeab3kpMG6AOdx84snVl6r24zUsJ2jO2Vof/zJEJuFqr1uuLXYTXDRXjGh2wzIXpylMhx7KmjpT4O+zqAp4yr7tZ3myLMgV6Yb9uVNHO2Fjysr45+nNY6PMPFDa1gz798+l1rwAlW1K4bnOrztNb/mjxk8hkJwLDMi36cxB1cSDPhQfRBRVo3EPQEMw1TtoxH1j4nPnB5HfpU2aAXtuZYg3OhCMbJrSJAh25Eli1bPp2NYIrLhJ73nPl6b6O95rr8aVM8KKT6svfiR+q14WmO02aa4s3Lwkgd5cUOyi4xzPl3C8mPuhxaN9+2nXwJe3MGm75yBN+TxVNhdwLFeLzVfZr0A17LXNQSJozybxx+Pb4NGXnu+3y3FPMqZXq0Sypa04EzLQyL5/armzFQB9+78cxY+Hz7lo1k/kWTFKakajTfHpoa6LE9/jidyLgsSAW5bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(4326008)(8936002)(53546011)(71200400001)(66946007)(110136005)(316002)(54906003)(5660300002)(8676002)(7696005)(52536014)(83380400001)(186003)(64756008)(76116006)(66446008)(66476007)(66556008)(33656002)(6506007)(2906002)(478600001)(4744005)(86362001)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DbP/yYOixlwaKyv9Nj8Eo3n+jeMbLVGCv2Wj6QnaY3lYm6ksucOQqz0gsBlW?=
 =?us-ascii?Q?yOQYxrfWszdARM1ZPJwPJBNVjVo2Y105uZcxOb5Pg1pl0TJhh+/xXoerynsr?=
 =?us-ascii?Q?UYnDddQ96vmswR0zEVgakcmBE2NR5qsuoMg3qhDL6UE6zg6dWWJe8y5mkVms?=
 =?us-ascii?Q?9apuziOtq9/uV61PAec5U3hPrCVhAoxRK/4bu0vJgx0PrGkGD4cPHuFuhHPk?=
 =?us-ascii?Q?dAb3lgwPvMLaI3qYQC2OwiPsEeEDcPa8BJ5fhBaWQ88W+ma6yiEx+lecBs8F?=
 =?us-ascii?Q?9tm5W5f6j/dPjMH8qziGEe3jdUDnNy/TdEvKHX1kTec8AoDn9fk4wrSCqJiv?=
 =?us-ascii?Q?BGNaqW46Lnj7DGPvAsAk1RYgOTwfQQ3rHUEsQMjf46u7O9rhgUtnDoosKUFe?=
 =?us-ascii?Q?x/mXml07Ou0UCo5WUYBWxB4ZsEukWCXQXawsnlkQfxfjVwLDHHC+76Rr2vd6?=
 =?us-ascii?Q?RTi2YosvMYvC3JixNUUr1TRcr+2R0EngJkzTMkArXf/22PcmbjMgZ2hAgv/M?=
 =?us-ascii?Q?5ycnAS0+1B7t21Ro4lycskw47Hh4dWF/n8GJFhXsdJxxXtmFj8TefYsNBgQT?=
 =?us-ascii?Q?PZ60/PZFoy6cksdenbrZRVoblEzsRcMeSQ3ZC46SB8vZXT8QUA+nxpT5iWfc?=
 =?us-ascii?Q?YFX1abamShN7SOmA1RoLPw/oMoOyQ9MeWYq+TrKP0j47L5IAll5R1sWt0haW?=
 =?us-ascii?Q?fDFENHRMsNyz27ua+n0dIULdWIgzXw6J2K7oMHp/XNRveM5D27f6TQGfz00v?=
 =?us-ascii?Q?XW3dFdjAZ+BIbtGXDG5wz6SupQ39/NjLcL0CxCzN7q87oRZ30gV5TPCjNSk0?=
 =?us-ascii?Q?x49xyV4pzTgO1uImxuqKQFMjjxD0in4547WuIwWKCzrki9vu47vBGZryMijX?=
 =?us-ascii?Q?i8aEazbSb8UgHJCLjNoe/ysp/WhrLnANfRKHzofLnjJ7ikb3zQezlJtCQZc0?=
 =?us-ascii?Q?2XYYC0+3/0CkREtwxv7xETGcV9SkK7MgeQdoTTZ96rGz59vRPf+6YXIgw03I?=
 =?us-ascii?Q?sY2JnFACHjwOj8Al72BJajEbZe2S1nR5unigZvCf3rseLWAYmv/7JdwKWO4n?=
 =?us-ascii?Q?BjRlIG9d?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023f90ea-0cf3-432e-48ed-08d8be4799d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 20:03:20.4520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJa626mb4R+YEW1xSEie+axOocyY9rzP+o2/OoJInOnXGyodF/huIJ2U9Wvc90NzaPjr2iimswEiCUM0txxK7dqQDdPDCSPKGJqRUoZaqsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_150324_966323_1AF5F5CC 
X-CRM114-Status: GOOD (  18.22  )
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
Cc: Keith Busch <Keith.Busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/21/21 1:54 AM, Hannes Reinecke wrote:
> If the call to nvme_set_queue_count() fails with a status we should
> not ignore it but rather pass it on to the caller.
> It's then up to the transport to decide whether to ignore it
> (like PCI does) or to reset the connection (as would be appropriate
> for fabrics).
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ce1b61519441..ddf32f5b4534 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1486,7 +1486,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>  		*count = min(*count, nr_io_queues);
>  	}
>  
> -	return 0;
> +	return status;
>  }
>  EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>  
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=k2Ai=Y3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE4FCA9EBB
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 18:15:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113062080F
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 18:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ex3AOHIB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TdtlYBqM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YfkcRCoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113062080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=bsnvtrHj4nPgZy32sI4RjS7Wgnq+vSBed9QTBveRUnk=; b=ex3AOHIBsn4jli
	VZIsFCkmiroV57/2OftuXKyuNMPez1vKKRLOnNEwU8oGMSMVKmtguCEW04PXcrdOoNoIRgQ8m0da+
	UYBbcSsDWPHx9jWDfTzPseOyT32AGynMmrvcFV7U263sG3yWWd7zuBm3i922WowCbk3leXY3QzdrY
	O2v1IXMMG6+0Ogeh7HF3QggK3RxfH4wDgA9XU/+7B67hyETfPKLBV8Nj4+e4P3vEBlwOae9BbEzim
	xEvZiAvP454vQN3prWcnGkROxyKKMWe1nCJjnVss0z2moQhIlrGE4UkTHYi9utOiR91DGylKQgnHz
	pkOjTtshfOdX0j7qQtgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRKPp-0006xw-To; Sun, 03 Nov 2019 18:15:53 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRKPm-0006x6-SH
 for linux-nvme@lists.infradead.org; Sun, 03 Nov 2019 18:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572804951; x=1604340951;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Sbd467X+GMgemP4DMQwi054MUH3/gd0nubWfIJRvbCI=;
 b=TdtlYBqMG6EL+35okgu876DuiIWLVZA7FDPiMO+Lk30jR8IQEvjoi4fL
 tjGcENbz4iiOiCkwQ2WktWJLtEeYHi7ME73LT4+K8BHH1qZVrBBjFwltT
 zcpr3DzJKLf7oEBGU6x1JxffMyIo/v9tRWP3PkvYeo2fRmcMj0BBUKczH
 zB8nZPl5s24XVDI2gEAdUQCv37gZX+dsiYcMEKgzCfhWwXBmG4fzcxIzT
 fhSZJPXVViuwHop2AJLwSn9/efzHEk6m8yvDx43toKbiKp7ZFEvrlJeUD
 I9v75F3g28aLSOXp5Q24KZGoHA9KmNEPRsJ/0jk7r6cbv3bZx2Ge/dhFV A==;
IronPort-SDR: Kwx3XVpv+tlK58NVQMGzjj1eU0wzeQYYvrfJ5Jy6cfPDjZegFCe04meerNTeSPMCgAyBCrur2I
 H2VDUF7sdesPWEV+CbiZikUZ2gy9xSB0RuY1N0przn10CVD4AgWicLma7cRjfh2wtdCngYiMA9
 Y/01lPGNA2UxwXQiMGdpT1g2Ct2UxsdGfj7n5+hk+0Iem2F4kxUmk4ixKgwWjWSbVD6tPTbSfx
 DRKO2i+2xyyEuK4BHsdH52jZBW6tXN8hAGsDT+tt+5P1UQ5yXfKU4Z100AaH9AaA2r1xTXOxpK
 +hc=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; d="scan'208";a="122755699"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 02:15:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StG3a8SK6nF3yFKY7SOhwvR2hgsgTPjJcnDv/9+uAs2mRmuc+uY9/1d904zs1apPvfIqNIhKNK2zhva3ask5VHq+BPGZq90FoocADH7wOOZLmoEWrR/68gmupL69B2LUb/pzfSoKZk2ZwxMqCmmDeRNb7gKn/CCIh+w4oJVQIy5yl/LFfJ/WU8QOIMfMKxG75tNsG9U6x3wBnm77m6Z6G2lDJVRIoH31CCMlXhpLeZDiVkjnNo1QCn03v3tsij/lS2aBBCVj5mnEr0LTtbQwno222lZsjHu2tNE2bwNgoXKvTeSGc1aC92veoci5t4ykgyRBrVUttxY625DCDkj5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIhNp/OOoLPzFd2FIcPv7fE+iF8hqEIwBB985RGds5M=;
 b=WcPlmMbKHwzaE8ctBAXGK5sO6VcjLyOFa7R+5BQ+V5ZQ05rUyJs5CBsmE59B4OZK0fvs/xKpZzS5U7/wvpjUtjyqo9R6WfyhNEYhEkCVQZ7KsR43GkDiF4yr7BxFRMeLQiF9s/KzFxKHe8MSXVeBNzTcqFqGI2LeQ8ewJ+z5vRn0xp+Exb9TTnBuXlFJ+z1Ei+ouPY2Epja2Pz0LC9UrJ04vy3H9w1s+do21MplQROcWVBVrsi9JXhXHqTSj75HPnAlLOJTbDHgC7UMexhlb9EqCh+NrRj+wnpX1Z2wWMkcK2iCGdYr01qSTI9I31hpjzAxa8EXvxFKboTzMsgK3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIhNp/OOoLPzFd2FIcPv7fE+iF8hqEIwBB985RGds5M=;
 b=YfkcRCoIjYGMldKDqOzRNcdTtxIvD8SCXNGNu71SJDSkcMagNFxO8r2NuNaifZhopdL8o2ggbyRTeF8fxh6/8U7V/11oN4eqFm+XfzfnVQIhwrLakg7JCq95Bs9nZ35hrDuuPQvH1XggCVceeTybh/J8SEsWa2fDP4dBNuUjEtQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4917.namprd04.prod.outlook.com (52.135.235.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 18:15:48 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 18:15:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
Thread-Topic: [PATCH] nvmet: make ctrl-id configurable
Thread-Index: AQHVknJzonXLyg8iIUGihKEY8P7NbQ==
Date: Sun, 3 Nov 2019 18:15:48 +0000
Message-ID: <BYAPR04MB57495D8490E37BED916B2CF4867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f217421a-a593-4200-888d-08d76089da54
x-ms-traffictypediagnostic: BYAPR04MB4917:
x-microsoft-antispam-prvs: <BYAPR04MB4917240420D01F12F2F79334867C0@BYAPR04MB4917.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(14454004)(8676002)(81156014)(8936002)(305945005)(52536014)(81166006)(71190400001)(71200400001)(86362001)(7696005)(76116006)(66946007)(66476007)(66556008)(476003)(446003)(64756008)(66446008)(486006)(33656002)(99286004)(76176011)(102836004)(6436002)(26005)(186003)(316002)(53546011)(6506007)(3846002)(6116002)(6246003)(5640700003)(74316002)(7736002)(66066001)(478600001)(2906002)(25786009)(4326008)(2351001)(5660300002)(2501003)(229853002)(55016002)(9686003)(6916009)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4917;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eRE/aIZRjb1KMnmtwNzzGVfoQ+LhB5PyXuhmEE+NWaY7AFkblcmL+WXr3wvjo4N7wIkIwRJgC4JgBUnWRqrKyMChtsd+ynl7plEerJfX6su86KQ2McaeZGzdbyX+qPbbHC/A25hzzsD9gNRgWKCnq1lDs3KA2n6H4F17hjPWlSbkNwh0JkZ2IL3Et24gpxwajruyh297XLOjvB0TgStcoQcGtcTTySjeM0PsistZXp6q9nKPDM3xUubu9JXl+qwym1M5ViajO2cGOq9+u0+L0y7dUkuNjk2OD1jWTQ586hN5EpRYc+lTysVHNbR1UPy3ZvBvXmyH/6pd7n/VVayjea+uUGSfdMzVZMKTM+04q2oWoYNpMQ4KTseRZM0rU9Xc25SweId93grgEh+UxlvTUSkU2A17fUIgPVmr6SMmYvq0k2JUB6zUMhiJaRgrKXxL
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f217421a-a593-4200-888d-08d76089da54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 18:15:48.4224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OimGk9aCYOiUmxyXsxCsRdkHwcIR2aP0I3TOOz8HyiDwVt0BPzsps8GGVOuChKv7Ov93r6FMsbnkR1aBFWc9mGw2R8y+QafEAIy4r8FKig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4917
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191103_101550_974810_5B9B3F44 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: "MRuijter@onestopsystems.com" <MRuijter@onestopsystems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

(+MRuijter@onestopsystems.com).

On 11/03/2019 10:13 AM, Chaitanya Kulkarni wrote:
> This patch adds a new target subsys attribute which allows user to
> optionally specify target controller which then used in the
> nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.
>
> When new attribute is not specified target will fall back to original
> cntlid calculation method.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> Hi Mark,
>
> This patch allows user to set the contoller ID through configfs
> which is target susbsy attribute.
>
> Can you please take a look and provide feedback ? so that we can get
> it to upstream ? I'm planning to send this on Sunday.
>
> -Regards,
> Chaitanya
> ---
>   drivers/nvme/target/configfs.c | 23 +++++++++++++++++++++++
>   drivers/nvme/target/core.c     | 23 +++++++++++++++--------
>   drivers/nvme/target/nvmet.h    |  1 +
>   3 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 98613a45bd3b..83391e54ed12 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -862,10 +862,33 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
>
> +static ssize_t nvmet_subsys_attr_id_show(struct config_item *item,
> +					     char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%d\n", subsys->id);
> +}
> +
> +static ssize_t nvmet_subsys_attr_id_store(struct config_item *item,
> +					  const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	down_write(&nvmet_config_sem);
> +	/* should this be %x ? */
> +	sscanf(page, "%hu\n", &subsys->id);
> +	up_write(&nvmet_config_sem);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_id);
> +
>   static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_allow_any_host,
>   	&nvmet_subsys_attr_attr_version,
>   	&nvmet_subsys_attr_attr_serial,
> +	&nvmet_subsys_attr_attr_id,
>   	NULL,
>   };
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 28438b833c1b..2396215a23c9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1267,13 +1267,18 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	if (!ctrl->sqs)
>   		goto out_free_cqs;
>
> -	ret = ida_simple_get(&cntlid_ida,
> -			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
> -			     GFP_KERNEL);
> -	if (ret < 0) {
> -		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
> -		goto out_free_sqs;
> -	}
> +	if (!subsys->id) {
> +		ret = ida_simple_get(&cntlid_ida,
> +				NVME_CNTLID_MIN, NVME_CNTLID_MAX,
> +				GFP_KERNEL);
> +		if (ret < 0) {
> +			status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
> +			goto out_free_sqs;
> +		}
> +		ctrl->cntlid = ret;
> +	} else
> +		ret = subsys->id;
> +
>   	ctrl->cntlid = ret;
>
>   	ctrl->ops = req->ops;
> @@ -1330,7 +1335,8 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fatal_err_work);
>
> -	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
> +	if (!subsys->id)
> +		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
>
>   	kfree(ctrl->sqs);
>   	kfree(ctrl->cqs);
> @@ -1416,6 +1422,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   		kfree(subsys);
>   		return ERR_PTR(-ENOMEM);
>   	}
> +	subsys->id = 0;
>
>   	kref_init(&subsys->ref);
>
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 46df45e837c9..a3d3471bdf2d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -211,6 +211,7 @@ struct nvmet_subsys {
>   	struct list_head	namespaces;
>   	unsigned int		nr_namespaces;
>   	unsigned int		max_nsid;
> +	u16			id;
>
>   	struct list_head	ctrls;
>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

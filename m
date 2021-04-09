Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C31C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 08:14:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798B8610FB
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 08:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798B8610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5AE01L8wgYAnUGY/sBxlXg6WINjsugWsa0VGvuknkdo=; b=K3lB4i00DE2w39RwjPHuGzRHr
	IWAIkPFRMiPJvPPSh6Pia/OgIZfv+H5cA3cw2MVnNCnoo2SMhybH7EHXM+QWmmxkZpxcKlC9bGWV9
	THRNg116AapMmFSQJUgSz8iVK2jORHwarErOO7hqvpLj1sGvKjitUj2SE1A6FP1W9Lu36r17bZ2g7
	HWOwllDczLGpKA9ZFA1h2F6AMRj9py8VmKFOZtvNJTuWS9xlt/OcDr1daBxhG20+nyGsEBWYeJwDJ
	pzobmbH9ZT/SUobKm5Pa3obwt8n80/Hojrb7qPM69GU2V5KkOvrjA1IofVyqgYJj4b/9ilFVGBt8p
	WRUlYsupw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUmH4-0000Xg-Py; Fri, 09 Apr 2021 08:13:55 +0000
Received: from mail-oln040092253018.outbound.protection.outlook.com
 ([40.92.253.18] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUmGX-0000SF-SG
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 08:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA0EmEZLMFV2U79fIjxZu+Czr0N0c5SPRXzpRy6iYAKzr5i4IZrDij/NW7eZvX3EB8RJfbYvbuCI3tOTRHUszKOAIXDz0+s0AAyFV0Ri5QdqdhaxaN3zo6T7w1pCpo9Jt/nZvSmlAKNE7BmwcQ/jLQelQOv8WAHs4fnEtgtn31zfNc5rw2hNruKTNhBgHGqf2oyy58qaT3uxDfT1tM3TzVkuKzDmf7XoooUXACC+Yo3XvxidHj2Niy2Hy1JExzCGDNk3aXyprumFSG8I/iEQD8pOwYNw4P/x4e2GlOfR4rAw2tFupfGm54Y+WoOxmO2QSZ3s+dYyee8lAN5Wkj2TSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFj3klw7ZohS5KARV8i2CwlBwKO08GHzSX9o5nwIHfE=;
 b=VAkxJg0UY17IUVu1K3/5S82qDwB/UlwqCK1YeE63NDmtP1tMq1IVnClRV4TEVz7I1aojFFknCdfaZXxOGeUr4Q4+2zpQFohlSLmeAwpX4Qz38EQiHBsP1PXameW8vuqmEqtmWBYZjBa2dk3Q5H0gV+GaLHaS6vewfsV6Q+SNx3wK2Wot+d5B3ThV70jsrLbnzGOiyCooIppJpElNGQ8S5ZNbwOU4QwhFLOv2HJ7gddYISyW+CgPFffc0ye3ddiI1JxFkzzDfCTcU9qm82Jm7tyhvNQMVZZOhJmQkPSy9KeV8iVdhB4ZuvavtFJ2hgweWVpjXs4OMQIt26MrxV2+DIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFj3klw7ZohS5KARV8i2CwlBwKO08GHzSX9o5nwIHfE=;
 b=K4f7CHpNWjifkrPnLjKK5T8TH4AbaVH8KbGdXD26lR/Nb9hmR1ruu0SMbX4qdF5VWynF+DeNaASOZiLY7ShmpD7uW9OXPc8+cWKBnnx4cBzANor82dYieyB9H3LaTVDmEDXPjttYJMzoRAh4EcOIy/qpRwcy8O5Au5wjCjVXvc+LApuUyebxFK9YtgxqoEMF9glUDQw55Jj9cYQM0SK6+833+AfYC96EKuc1DTL5Mizt83cwXGeLcifdj93z+8bhA3qGXE7Xry+1WjjgE4GDqP3UxQHWKD1QJQJmuFmS6LB2dNalxAyVF27ryk3j0Aitewwe7K8ffUaBiNnX71R0BA==
Received: from SG2APC01FT132.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::45) by
 SG2APC01HT017.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::266)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 08:13:05 +0000
Received: from OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM (2a01:111:e400:7ebd::45)
 by SG2APC01FT132.mail.protection.outlook.com
 (2a01:111:e400:7ebd::218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 08:13:05 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:2C61FBDE8E0FD360ADEBA1651B475AD5F6B7D582921FAA75F49A261C628626F0;
 UpperCasedChecksum:6186F75E5167795D945EF6C69C668569416C2796EA3804BF0132B2F71A352794;
 SizeAsReceived:7628; Count:46
Received: from OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 ([fe80::688c:ff04:4565:ba1a]) by OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 ([fe80::688c:ff04:4565:ba1a%7]) with mapi id 15.20.4020.017; Fri, 9 Apr 2021
 08:13:04 +0000
Date: Fri, 9 Apr 2021 16:12:54 +0800
From: Peng Liu <pngliu@hotmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: fix APST error for power latency tolerance
Message-ID: <OSYP286MB0181AECA9C1FF5EA4451E1F4C6739@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
References: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
 <20210323162321.GA2446196@infradead.org>
 <OSYP286MB0181DD097BC42806382473BAC6639@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
 <20210324075824.GA2648357@infradead.org>
 <20210409071921.GA4184967@infradead.org>
Content-Disposition: inline
In-Reply-To: <20210409071921.GA4184967@infradead.org>
X-TMN: [rf8dqg/MIUxUKW3uojHEraDuzarW/rO7]
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:92::16)
X-Microsoft-Original-Message-ID: <20210409081254.GA20382@LIUPENG17-2EEHB.lenovo.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (57.197.58.17) by
 HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 08:13:04 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 33717cb7-3dc9-4114-5e46-08d8fb2f4cc9
X-MS-TrafficTypeDiagnostic: SG2APC01HT017:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7f9E5y9ULMnplfkPTyF9EtD++FVX+RfP93+Ss2hd7dTRJb6AHpuR3/WXlvqu69WWmMLYk8pIfmYGAkRuIvXj6CrKwoMMYIFyxiK8BgGvRC0CLB+nxa284Wz4IW78te3UacwCgJ9vu8V8DijS3O/IIRzLiqyZ3cy28bFvhsk53NCcv5nTampyoTp4TP5gdyZuPDmHlvSqaVHJQK6P8ZckYkly+iKZtWNHxKBj58V5ddk5tMnIdlqMC7Vp9fIQ+Iz5WAM47KjXIEDK64FvUiBcEiYvsDSaBSM3A+Ux7esNDzMBDzW927EMC0wKqg/50TK/x9SdKe7UlNhsoI++DkT8d+p+4C+aab9yg6Da8JYuhSV4Vin6fb6b9nAZ8aNIHfiqrUogFenLUuHLc3riESx7hUYLnbtQsGkSDzruQLUgCTKqv1VkIq+Ne4Qf2vMYHOhT
X-MS-Exchange-AntiSpam-MessageData: o7eVjg6SjknTN6Fk+2YBA7wygPpAPKfIkk1ePqFYXEXJeyELxiVJFKGVtM5llhK9GpDdPjiaukzxhrZAgYkrVzlUan96DdW1hpMWXGzFWv2jYHKdILOqyp99rjKcf73SPdPSl/+uYN3feAj7TR8pXA==
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33717cb7-3dc9-4114-5e46-08d8fb2f4cc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 08:13:04.6699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT132.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT017
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_091327_389293_EAC80750 
X-CRM114-Status: GOOD (  32.70  )
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

On Fri, Apr 09, 2021 at 08:19:21AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 24, 2021 at 07:58:24AM +0000, Christoph Hellwig wrote:
> > On Wed, Mar 24, 2021 at 10:38:12AM +0800, Peng Liu wrote:
> > > On Tue, Mar 23, 2021 at 04:23:21PM +0000, Christoph Hellwig wrote:
> > > > On Tue, Mar 23, 2021 at 03:31:33PM +0800, pngliu@hotmail.com wrote:
> > > > > From: Peng Liu <liupeng17@lenovo.com>
> > > > > 
> > > > > Clear apsta so that nvme_configure_apst() does not execute
> > > > > nvme_set_features(), which will fail because admin_q is either not set up
> > > > > yet or no longer available at the time of nvme_uninit_ctrl() being called,
> > > > > and this leads to the error message "nvme nvme0: failed to set APST feature
> > > > > (-19)".
> > > > > 
> > > > > Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
> > > > 
> > > > How did you get into this situation?  For PCIe nvme_uninit_ctrl is
> > > > only called at the end of ->remove and ->delete_ctrl, so how do we end
> > > > up in nvme_configure_apst after that?
> > > 
> > > I got into it with nvme surprise and non-surprise hot-removal tests.
> > > Below is the stack ftrace result for nvme_configure_apst under the
> > > surprise hot-removal, and it is similar for the non-surprise hot-removal.
> > 
> > Ok, looks like dev_pm_qos_hide_latency_tolerance calls back into
> > nvme_set_latency_tolerance, which is a little .. unexpected.
> > 
> > Does this patch work for you?
> 
> ping?
> 

Sorry for late reply. The nvme disk with APST feature is not available
till now. Yes, it works. I tested it with nvme hot-removal surprise and
non-surprise.

> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 0896e21642beba..d5d7e0cdd78d80 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2681,7 +2681,8 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
> >  
> >  	if (ctrl->ps_max_latency_us != latency) {
> >  		ctrl->ps_max_latency_us = latency;
> > -		nvme_configure_apst(ctrl);
> > +		if (ctrl->state == NVME_CTRL_LIVE)
> > +			nvme_configure_apst(ctrl);
> >  	}
> >  }
> >  
> > 
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> ---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

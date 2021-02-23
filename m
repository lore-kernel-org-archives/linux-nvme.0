Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB52C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 06:34:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E5D64E60
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 06:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E5D64E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/8tLRs4uzrDlh5Ok4EYeT+2BbiFG/s3guLJicF+B/WU=; b=Ly+NJozMpw2Y2MlE6j2EabnwW
	IaayBGsCmESeevf0QsO7q5r0BzFMEXZ8WhqssBROptM6JZS2NGl5Aod639q86IVI94GS/GJeU4UMs
	zaleDyCeG1l+l+mKozOK4IDxoEadWeW+S43AQNqZnJ9YdFTXB83J+hNCrx83LsFK4BASU9PnYTXs+
	oYwRWtBQmr/yJTAO+fnYfJ8OA3ZzfcMVdg1mijUmimFY9YOl3ZsPJBnEriZSpR8lsuXvSrxOHeftf
	by2QqavGhrgoAWnd6vySRd4eLWfsgkab//xXFrhfqF6su5MWzitUmI42ANrgI4k5TQj0TP4sbCBQG
	+WLwCXdQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lERHR-000139-6U; Tue, 23 Feb 2021 06:34:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lERHO-00012h-Kg
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 06:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614062082; x=1645598082;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=z2s28hXevBhzQCUo9Na9dmL4b1lbnbx0sW8zr6k4wK4=;
 b=YrsVOtnPFOClVjNoHRvXFN0jxqGqTTmGiFqUGwR6oyRgcr+Y9BAPL0lG
 0TptlpV0rP9saQR1MZ2UsWZFGEuPdkV1/d8MvzgFKxfIl3UrzN/iEt2RE
 VKxmah2B5wCl+ljMTHLNhEnbDFkmBI8kWvjZS8kl6e/mnvPpl+cSGNh7g
 gU+2voioXSzy4Mu3OxSwB4N9uX6cbWj5slEzKIV2rau5Z0ipOhp5QPHSi
 blJQW3a2NnMZBW5BcliKTRkOSmwAczcr80Z4zLE9/63TS8qFle2IKWCT+
 cyUMEI7BvlZWBcMPkUgcBCO1KGghq9GNb20oox/Zry99IrphUJ36Cu9cU A==;
IronPort-SDR: EBj7JYWW2ilK6COqfulNNeqW4/LE2KaXuiCA6qsq7BF61CsV7Tjvt1X8pbC3yKxauoGJtbp5LY
 JLX29hzBaRaH7LRoMpCsobi8kRJRmmo2hwS3dEnm0YSFsvx+elkhmB0sJZLv+9jNiJ9QkhsMdF
 00H5/vfQ293NmHzOMs6WE7I5S3fppa8ojf+FTGLoOGArgm/EKPmDUORexKieJDFanpSOBrOCP+
 hK/ZAyV97JFFgomhvNYPlfrJBcMWdMWSPgIqjX6QQRi3ERANOK6taEm48lznQ+NpIGxDJ5JPjL
 DQw=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; d="scan'208";a="271111619"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
 by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 14:34:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXckjfZMpujvSeIe9oN+DJw5ovgsaLsKzXQd4FnzJaOANIdKFKaRLZfa5ADFfyyuC/YgoCdrC+jH5ZA00SO4eaMz83IIIvpvDQlJmNKefUG7/8m7LWaAo2FWh9HJzuObNumvIX9FyLFPkSvfzEAy4clqkGzP3UfLA6PPTrpiD5LXlMO53ArV8sYeP+KXMXvyk6b0D5vHannkgRsPljOdZbTxB9OqEFjYfssW5ESDaxVFzyI/QaVV3COe0bODrYEfAlm0f71B4S8GUi/YoRfanRwYnGPcg7Q8Qt4fRgog1267BWXRraP3YW4/LnnHoliyO129a62dIv0UoiqSXioTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yNt/xu7Vgojq7zZP6u90EEP4BX/HChajzpXnL4kFP8=;
 b=VZi3gFOho2ejAxxWgcPRrhw2O264iMq4KSXml4OCtk9lxh3yH6Fj/lGBiz6B2bFY+RVc9d3Lb/0JC8Q6wlQGhUk1JgoVKbfiA70nPy5XpRIrcL/MBSF8qxADbRkfnHwliSZ7YNkb9CN/Ku9Sr9C1/VosQPelhbNPeI0OXWxjPJCJarGpR7dfCZrACGnmnYb3MXY9YtKLnwUJOouzQR7QUGYHOZtfyvacy9NIUTs//6qNqL+qst1tDIQ8ZZdFt1VRQULz9VyS7iU/rF+Ao/pv8pTyokix1CAS35YeFKqgPVdRRyB0cgOfzpEDa5hbwedQvCufFxv/59GKHKxBk5oNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yNt/xu7Vgojq7zZP6u90EEP4BX/HChajzpXnL4kFP8=;
 b=B8QuhVIJimzmPaIk59tTWZfZ2uBWJBg+8TnkLfGZfpntWdkcds7w8viHR9RP81MQDwvJDZWZRiZJngkL1lGlrRSMA0jQ15iXbiaAJedT82xLvdgU4jHfop1pH9m0u0SDVBjHvngG7zggTDEFsffYUM4OdsQV7ZDbe/5M8tJBuvQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Tue, 23 Feb
 2021 06:34:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 06:34:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvmet: don't change model_number on live subsys
Thread-Topic: [PATCH] nvmet: don't change model_number on live subsys
Thread-Index: AQHXBaR/M32QSqBsgE6PV+qDqQU6gw==
Date: Tue, 23 Feb 2021 06:34:37 +0000
Message-ID: <BYAPR04MB4965FE04148739AFCD69B97686809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210218031644.12476-1-chaitanya.kulkarni@wdc.com>
 <20210218070513.GA16309@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaeb4516-7174-4a6f-248d-08d8d7c5179d
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB4325A7ACAA3C0A90935D072D86809@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjHfYR/T7+Y8QeKvguj7M87OnUknyjEdcVzrK6OWhGEB7bLE1SflUW8JV4/YgY0z/JBHRzolqDm1ERIFUofioR5POCvX/96c+vVl+M/ZELvCGuiVxQCPdH+tqXf5if+hftyAHCTHWNPeo15jbyAVoCWMh1bfje4eH70cZspWwmPhGzjEkooUWMwdy/zrkA4nikW77urjv1sUd1tGW1Shs3rSpeJNqjcHzac9PaezydDEKDX1Dusdnxj6Zr12YkhnF2tdjU9WenaBBSkYcFAesKLpRN0kbLpVCGUb+e4DC4kA64NC4UqCoxMLsppyyDyveed3E3pyumHzGtnPHaqZTV5KgaglXH9gpCtmKzvRy9U3bCobNPpDt+oPe6sJnQWj84qc4Mbt/C3Yhpato23l651DbRV+OoC48HkqmijkxDm4M6FcRpyjBEaoytQwc7iCfVKRl8T4gjRSXbXw6K1hMo8MJV/82lHpExpNtGaD9PFexB9YLbTyLivLCSMxvZ5I5yvH793n1//8ZMjoViD1Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(83380400001)(8936002)(71200400001)(9686003)(52536014)(6916009)(33656002)(316002)(86362001)(55016002)(2906002)(66446008)(478600001)(8676002)(76116006)(64756008)(66946007)(5660300002)(6506007)(4326008)(66476007)(54906003)(66556008)(26005)(186003)(7696005)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZZQ8hzxKm/erDLUWcH3GIl3BBSr1d8VpLNNdXlyfCtlRUEn/crMQunP7x2HD?=
 =?us-ascii?Q?uzWmUfS+ZUsXN2bC3NGO10t7wcNTTGEYdpV6zC6hJ9tRClb/zW9e4cwpuVPu?=
 =?us-ascii?Q?uK2874HU9hqt9bsFv2QXWGwW3rBOCPqmZRi5B4kl8CsoRVNDWYyAmqHHAt55?=
 =?us-ascii?Q?FyS+IROiQNfZ7uYRRbFGxW/SSJzfNwAZF00yisiVIfG8kept9h9G9yMlwP4M?=
 =?us-ascii?Q?OYxtnZcLlMSYJty6WNdVVrmp5xNc7FSdjgaE/qNEBnTHLlH9wl495pC5bNuE?=
 =?us-ascii?Q?/iVvdxiysL7WmxQAY+c2u4WiY9tl4w9xFxfT6ZZEHmQ+6d2vDfKxw6IdxN76?=
 =?us-ascii?Q?GwT+nYVB98Ch8DlWhpLfjNv38ASuzA4OL51pkcLt/T45CYKPWS5cC77fHV/x?=
 =?us-ascii?Q?IZ0PqELwzgDv3AerALXJ5yjkjwqtWxjq9kzviZ6goUxue9mrGoTGwWBJf4rh?=
 =?us-ascii?Q?IjHX2DhMt5CvDBvmK+n64jSpaA3Fx6Y+Wh0M65/r/Y54Eq3Uf58E1bZFFgOe?=
 =?us-ascii?Q?WonWRl4EvEVuD5TyZYHZWtsm2aeeug79KGUoCKr4yZEX/J5ko+BnhrdcOyh0?=
 =?us-ascii?Q?XQSafVgptom3jFSiwuyMlK6FKkZXdiEoJqWr9ajAXWq4B4nBhdb1M/spsl90?=
 =?us-ascii?Q?qrQKSKc29s8zJxdhAWXo6cJ6JAH9IvRDQBRSsVv7jg+VqSPx9pCXYmmCGo4V?=
 =?us-ascii?Q?IFtol/n6jM35elJ9NHo2QcKTNcROrkh46q6lek+Lb2olG4D+vsZjorqC4VLH?=
 =?us-ascii?Q?F8RXKyvqT/wWHq5if39VR+0tkcan19Bx1L3FutODj+IBsPec8+Wtr4mezl2t?=
 =?us-ascii?Q?r6Wirc7J+TkYYIvUFsV/v2gzyrThxV8ZWR+9mA2AfiIrXdJ7q3xBWs1OVEPy?=
 =?us-ascii?Q?jyyxrqkVbTRORZokemAadQzcYtq0mU7SgElBeAHiqI9X4FupDka8WRMW9K/3?=
 =?us-ascii?Q?V1Wx8adZ0kec16/yb1aY2TVSfJrGvH4XRO1yO+hxPzR2QP7oxoTbR/xGQqp1?=
 =?us-ascii?Q?2juXklvYR/z4/bAbW2mm8eY76whRg/9ytYyC1Td6eZlsDlkJJxUqNftL1w7A?=
 =?us-ascii?Q?ksfHnRi6Mc1OJfGjxQrbP3MvcCLr2kbWlnM2T1Fmqbt+t258b9oIYnkJ+VCR?=
 =?us-ascii?Q?CA9ItAVa0Y0IttJnb/BL2s04xnZjxXozCcE0lHvM9awfm13kQWpmHcZA5LGb?=
 =?us-ascii?Q?eLkzhIVJFxjEHHnpBvSnuY7km/QP/4Ymt+8rdQKr5qgm4a+Uhozv5yxogUYw?=
 =?us-ascii?Q?KD/FWf3S0bjqW/rbi900vBcN7AvjuAJugfw8s6VH+H0M9OVy+v6NlJkwInqf?=
 =?us-ascii?Q?UgKf4Wv5xqu349GwcgVUDzqd?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeb4516-7174-4a6f-248d-08d8d7c5179d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 06:34:37.6399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlS8JdKmKbHA+y8bOltVh2DRp3crmIc1QPhVLV41Px31zh2Nih8lsCYEkz7hu+z7Rnx1Z9q00q49hwMcpvk0jyAMKyMhiDO7MATe47mhc3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_013442_904348_1EA24EAE 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/17/21 23:05, Christoph Hellwig wrote:
>> +	mutex_lock(&subsys->lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		connected = true;
>> +		break;
>> +	}
>> +	mutex_unlock(&subsys->lock);
> This could just use list_empty.  But we'd also need to hold the lock
> over the actual change of the model number to avoid a race window.
>
Since subsys model number actual change occurs later in the
nvmet_subsys_attr_model_store() are you saying something like this we need
instead of having a separate helper ?

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 635a7cb45d0b..c9fd98080b55 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1145,6 +1145,7 @@ static ssize_t
nvmet_subsys_attr_model_store(struct config_item *item,
        struct nvmet_subsys_model *new_model;
        char *new_model_number;
        int pos = 0, len;
+       int ret = 0;
 
        len = strcspn(page, "\n");
        if (!len)
@@ -1168,15 +1169,23 @@ static ssize_t
nvmet_subsys_attr_model_store(struct config_item *item,
 
        down_write(&nvmet_config_sem);
        mutex_lock(&subsys->lock);
+       /* make sure this subsys is not connected */
+       if (!list_empty(&subsys->ctrls)) {
+               ret = -EINVAL;
+               goto out_unlock;
+       }
+
        new_model = rcu_replace_pointer(subsys->model, new_model,
                                        mutex_is_locked(&subsys->lock));
+
+out_unlock:
        mutex_unlock(&subsys->lock);
        up_write(&nvmet_config_sem);
 
        kfree_rcu(new_model, rcuhead);
        kfree(new_model_number);
 
-       return count;
+       return ret ? ret : count;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

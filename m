Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F412C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:29:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F4864FC3
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F4864FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=buU7eLKieNTuKVIOIVwbkA7LR3hmcC32nX4AzqHft4U=; b=BuELp1K3fc6x855/Mre0rmeIC
	mX+LkrrSRH1HgU/47R9PWFQShf0Hd41wSFIGI/g+G/I0VJIGvMbSf21N0gvWp7GOK5eEyFRJhKKRK
	9+uAPuw4nUGCEYApBcEk+3uxJRTpJnINn/zofmkYQSsZp8VXl42qS2jzX12uR0ZQOYPD5EGDbs8aZ
	A7iTJRTpR72asdGlncVUh3kRMFvp1uduYJKp8ITqlQp8CRdYddbF+APm0bsaEOrAQPwi4br15PSIa
	k8af1dInSr/oy9d5lj8tl11JerPNZgdHm4iQXwWfupIbTMlMa+C9upYEUD0LKZ6OQ3EmIO/GFCGdO
	KKzkykzvQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKDt9-008OxD-QN; Thu, 11 Mar 2021 05:29:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKDt4-008Ovy-N0
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615440572; x=1646976572;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZKa2sLymZ1LhWqiAd85tTokrdikkIEoJOKwyX4ZulLg=;
 b=RzuNj3Ae5ludMK6t9HJJ4yt4P5QHmTFIWp9GUlFAVFWa9ymFDWvshfOH
 MPB8gQdxahOZusJlNZMWcDFOtm+wGAcWQWJh6yRR9W4Awh20Cu+MGOF44
 KcIXR6YqyWEgLaMvsQjTkK/y5Ltsx3/UGjV5p5pUIhEHip9RHhUt60xKP
 VeJkop5I7kxsHkstnH3JyewFUYLx9Hy87bBkV3icgZ9QaZeokFoACghG/
 Qoy5GEx5vHbND9tYZXSF5vkdXyXHdyGgpXowZNn286SpSZeWkH8YHZghw
 1V+0tvJGZODk8+VTZ2eSGK4PXL4AHK34DbOUiNmbzWmjxxUNGgf5rSWRS A==;
IronPort-SDR: QTUveKumpmVtiUpfnleP/f+54TkyMoEPnmUggfnrkZv7lGxzASiD2HQsk4YXr0l1JTLSqhiQ5R
 L65ZQLp0Bqkh0TOiHme1a1t23wldw+rkT4GhBpggMO5WD3fBLl0LXB6xLm5tbpC0l3p/f+o1DD
 5cZgaOcbdf51L+aAqLMa/beEH7mg0vgAc85rouU5ZmDlp3YoojYP6KlEA0DjSeJJNxVpMVi1/Z
 051+qbx14n2TbPrpMvwLMOJMJ/e9VeSbS2eviYufMpV4LsbxLgf94PvcflnXxLGb6JkvCucPHk
 Gh0=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="163043223"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:29:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf+jr8S7qaPR9EfwmOOzOpUQqLHaYeGxbP16iFZ7yrZTEVQeh6kTGvHT4RloI5jHee/p2bEYqi2wTg2nchr/+uvN+5sN6SjX89sRr0yrXhuowRq1DX4leEYqWhLr6PTqOlYUCTa8tvMSHBbFLCAvbYBX0DvCMYYejfvofb+6qCdjJobxMQJxTXm5oymyyz/pR5Hb4OsvrBBMv8kmQhuJHAjL3tbZ6LJrbgmwOe0hE7td28vQFoqrwlwwmGFa2AprGiPT68YR36CJ9DyLrjIFpiey381M5sXnnoboH2wjOPsN1gaV4Vh2MlJw9tWiRKP/5uW8rSh6XUAImAGGBKuJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhsAmAqG7GEW4sLmO8HijkBf/ETjhznkOh9LiuJjdho=;
 b=Xqlz7jFJ6ivpbTAKa56kKfYShVlhuKd86tF7etV/NwDMDqg331ZuQvJ/hSp6j3FddkvLGqzcWI7ppppaSC9Ul/oD2daLyrYeQqVLmpjaq9Ne47v1O/KEXLYgBaKQnksVK3JBV+3/DNcsWFhQ9B2gcnSKA5FUpkn9J64auoIHCp6KyxvxlSunobPtZNFT6Oy5AU6ZC5dNFa46M/4ux5CYf0CblhPqYkFuuGcpZHrecJzzSsLcI7CT6bTvPsqATh6Xo8LtHzSXIo0czK2T2lXbRrXvC5DJtwD5CiHc34tZQA+9FVQt9iFXRg4w1h8zNQWdl9zkVeD/Y1Lk8razUXxxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhsAmAqG7GEW4sLmO8HijkBf/ETjhznkOh9LiuJjdho=;
 b=ppyc534XpKVNuYnFzM7+o+Qb7YRxZIVd7AWGuX4CzPQY9ebOvYrPXWKg65lIn6uyoHbzgsbExEl1F2PtQk9UrpY5HDMwr0Kj1RajIci5PwFykV4lUEzOnPb7n3iSdgbX7JlBR54BY/Bchy0cuz1wKSCstF5rLQZ2o2723KydZLg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5896.namprd04.prod.outlook.com (2603:10b6:a03:111::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Thu, 11 Mar
 2021 05:29:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Thu, 11 Mar 2021
 05:29:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFjCN9/5a75AcckumC9lPapW+AA==
Date: Thu, 11 Mar 2021 05:29:27 +0000
Message-ID: <BYAPR04MB49656EEBF4AA66D1B4F4596686909@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B376CCD4EE404050E1D1E7909@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a0d267d-1c38-4b05-6096-08d8e44ea38e
x-ms-traffictypediagnostic: BYAPR04MB5896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB589617FDC4BA133021F7050186909@BYAPR04MB5896.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hiZwK9XhZOhdkh6P6/nUuMd7rCxHTuVb8pHW5xlU5blAhh8teiC8RCquMoKExBCOtM+YrUc6oFcmzHlrmaeNq/Wmsnk0nA3PX4J+CK1xMpTI3tZk2caq1UUEldP7wQ6AAm2BowwCjmnaGoX2tnpe/QN2pqSGHa/oxInizIF8ULjuVuhLc59EDvURh1tLK+WMZpwBQS6WumSKvVypqWIsFYOVpTyBb9poSu+HbqG6lNNwbZMEly+3e9CGEZgN9OBa0xvLE5LaG5lk954rGn6g8vI4sq0JRVdEJ68OQl4XImh+GFq749I8+RyW8IS3nhYoCmuqHsw250vhAe+LFnYTrURy2T8ZppXxneQz48mUy0F+B92HwW822jaFNqs11dm8hNGEwubjhCs3D4CEb+FfJCp3twFb0xsGITdzTYUYah4FOctbThzUbrCgtvI1wRoKGNt94glii9gJjJC1wFTdYhfIBNbyVhKsZBT5BdHe3t7UYhz2WmDocHYma282tiXtjB4wqe5+k4do+FLc0lziw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(6506007)(66556008)(66476007)(4326008)(7696005)(186003)(76116006)(66946007)(66446008)(83380400001)(8676002)(5660300002)(86362001)(64756008)(71200400001)(54906003)(2906002)(55016002)(316002)(33656002)(478600001)(9686003)(110136005)(26005)(8936002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YmBhCdKqJbUl5eJ5dZiHzsXHE6jUeWOetUKCINM6WWOjolCilU9ub40N6EOA?=
 =?us-ascii?Q?VaLe99WJX2IfRm3XK9cfKAvOTJlKqygPVIEB1QbMzY0thfwMgJQkS/A+h8ju?=
 =?us-ascii?Q?lwQET6SNOeU1mX/QJw1iyTflWvCuvhTrSSlSN9Cbu/83r2g6hmRHnkb3Chk8?=
 =?us-ascii?Q?E7MXnOQEyx0Jsm4z0/YJghG/wZnba13fXsep9EZsuNvatKRv3DdKMOA8tE8Z?=
 =?us-ascii?Q?cZX/SpuaJXMnKFCJRJer0dVkJ/PwyUeFL+grlqLHmaQP0c+qz3KlZbKGCE2d?=
 =?us-ascii?Q?2SuNQtp/P4FcNHsUXkOMt1y7DDdnLeqbAmgbQA7kPtB49CdERxj16Q8mai6V?=
 =?us-ascii?Q?z4OEmqaq1glAuX+csvc2wKvLtH27zrGOyMUzRGkxnAoFav5Xy4fcYLcd+h7/?=
 =?us-ascii?Q?sGafLKvyY0rc37CjCmKIuK3I/oUUmQgmXHgABA5SYEPjvoO1E/vIn+VlnmyU?=
 =?us-ascii?Q?LwKci1bbUfpcoN9ENR85u4S2PvBQ/NXc6L2ypYID3uLSC9WSJh9wD07UlnM8?=
 =?us-ascii?Q?AJSO7eUbX+34FI9d6cbn5ripQqHa2M4UAESgXFd/4Wmyj//0D/Z/ZFEmRHgX?=
 =?us-ascii?Q?JNV6P9ZkzQ8WmkAegXU+lUHPz6+0D/Sufk637ZDTtThYM4u87x++D6hnjCp2?=
 =?us-ascii?Q?85p+X2pfUM7K3Bd0ojv5DDkUTS6BUr8DuJVdfdLRjOgSGthPq9kcjmD8yJUn?=
 =?us-ascii?Q?LTSozdnRgyq9oKOKUHiN6NjG6DqWYmHW1RUfJL/nsj+tXQdBfyIqL6b2vCZG?=
 =?us-ascii?Q?SrW5r3X3enaueMMHOQ8RBDMHgqwAjKlF0zNnN2Dt1UWjQr0SSZlnKnd1WP5h?=
 =?us-ascii?Q?2WeJ4k9v/yaojTk1ZmpeQ8D52cJ5s1mnGnWGaJPnLppa2HtVNSTz4L8KF9XJ?=
 =?us-ascii?Q?FMVqdbu8J0Y3YaYs3m+IFKq85rmB2ykGxaczOrVM4sBYdzxH4fnMEeA2kCsk?=
 =?us-ascii?Q?hXzp2OlbFigV3Yd7c1w4ZJJzWytXh8PsfYBxP0UMOXkI0f4rz/7CAu5EJlkx?=
 =?us-ascii?Q?qvSurNrRw5JieEaBoANZnYPiy/j8qdFhqpZNzie22RKllHU014HiT0Rkco2X?=
 =?us-ascii?Q?4sHVW6W0o31cxvDwD3r1RQf8UKzZovjLGGCwlISXYChY10acv3lcW0Yp61bF?=
 =?us-ascii?Q?VsAI6WIA50yFaULP53+DwHX2xBzPcBHnzlwllkEgiUx6scZ1EAOMAlzgUR28?=
 =?us-ascii?Q?F6yS0aDn6iaUpMc0RFNS7r2SeQBFVU291O1NG6oElTUBrV3vt/WNhI6cs0nh?=
 =?us-ascii?Q?9pE52nCdMwbmMNLtf7S8Y4mGSaU8fPSfWbHAF+TE1ZSzp9khGs7ntoul8jOB?=
 =?us-ascii?Q?uGgGOfW7oelW0sFOgFk86nBQ?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0d267d-1c38-4b05-6096-08d8e44ea38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:29:27.4654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETlPLO39QEHdWtMS/wWiYMMWtRhSlb5X5hpp1e1NEh/j9Ctb/2Cb//DHjzqwE/P+3bcewXZBKx3V5O8WX0xN3/Wq0/ZFl88YOEb2YIy4W3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5896
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_052931_299730_3661C76B 
X-CRM114-Status: GOOD (  14.50  )
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

>> +
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>> +{
>> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
>> +		return false;
>> +
>> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
> Shouldn't this be using logical block size ? Otherwise, zsze calculation in
> nvmet_execute_identify_cns_cs_ns() could be wrong.

Okay, will send out V12 with that fix.

>> +
>> +	if (!nvmet_zns_update_zasl(ns))
>> +		return false;
>> +
>> +	return !(get_capacity(ns->bdev->bd_disk) &
>> +			(bdev_zone_sectors(ns->bdev) - 1));
>> +}
>> +
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>
>> +
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>> +	unsigned int nr_zones;
>> +	int reported_zones;
>> +	u16 status;
>> +
>> +	status = nvmet_bdev_zns_checks(req);
>> +	if (status)
>> +		goto out;
>> +
>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>> +	if (!data.rz) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>> +			sizeof(struct nvme_zone_descriptor);
> What if nr_zones is 0 ? This should be failed.

blkdev_report_zones() already handles that check. I thinkthe error condition
below blkdev_report_zones() should include<= 0 case instead of just <.

Will send V12 with the <= fix.

>
>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>> +					     nvmet_bdev_report_zone_cb, &data);
>> +	if (reported_zones < 0) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out_free_report_zones;
>> +	}
>> +
>> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
>> +
>> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>> +
>> +out_free_report_zones:
>> +	kvfree(data.rz);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

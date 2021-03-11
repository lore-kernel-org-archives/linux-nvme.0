Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE1EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:37:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB6164FC4
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB6164FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qWfKn+BtOOWaU0huH1DWrOXpHrITBzqqMOEjlqyZNyY=; b=KzQ1dZomhRHQyGoLDkHerDUBi
	mG0npjJHhNy6WrjX6Cr2fePRh8GwbPPlKRJEDWKfrLXUZg62FpL+CLaAHKJOYc7YgafVOoIFpz829
	/q8+YDsMb/nOFzeUsgQ6e0127RlkA++IO7bMDfOa3LZRhUYvxXUC9MkvT6iPs+LS4/LBWUFiC5OoG
	Ls/NmSW0wvB1dk5pcoMuJyp1yoHe3J6CpehHIIIrNFEheSydcKEfx83Tfq4EhJh9xrIkC3pql8wGB
	+H794h+tfhEgUTcPHxYc/BAXnc0tjhYs4B+yasgyrQFwEI8MUy5QQ7/f3QjN4HAGgLaD3uuDTfJW5
	hbs5sjmYA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKE0N-008PRn-7m; Thu, 11 Mar 2021 05:37:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKE0H-008PR3-8x
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615441017; x=1646977017;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=D2Rv530lN5D2epFJRrEL3AeySwpmKkAqz5FldU/GUdA=;
 b=Uw3OYrwtI5vp0oSMUdtCQQneDhUTAjFzUVdKRstkagQCrXGl3ZSJYdEA
 n64z00sIuOlPr5rsg7dRIFrZkCeuCSU0lI5aqmulRi7WxHmB50aDCmya4
 YHAAC1fUnl5M5wx46g4pzL3X4t3L+FX6zXxP/W+68+eeuNe9waqoM7BJR
 F6keE3JieSNOkTrtzVeaHoAkBHRmhuYBPjZsnX7ndxb7JG+O9FRxnerYM
 RdKZxHV8wdvLVB1S3KJvaBJEi2vXhen24mDLkIqsGCe1I9yTZVZ/wKF7F
 MbRtwWJxf5/n8xxrfv9SAnIVy0g4ThXnDBlJ4QswIun5TYaOO6apB7BYG g==;
IronPort-SDR: CgVXJ9ntLGRpQyI4bsQMSZHx6aay5AtEFE0duwkQ3B7qUZq4C8vWvUUTjFpg1URbpNnTpT95WS
 96dXMutZShXHhq+2ydTZ8ufRWe4pr/J1MRhT8R4hMgfhLKk6kQ0+gWnSJCs0Lhhnm9/iwonxNn
 sK4cn0lO75RJDo3+0ovnkeYMHPgGLo2taGB58xAXp8MOpRRm4IkRHicAzkXhGuj0IdjtUpeBKy
 c8RhN5ZQiyAfU2A8nsd77MFJEKiUebwY+aQ4NjmKDbflo4uPccGo0u2W9Wo7VnOcEJ49bsk8AI
 GFI=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="161898187"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:36:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWsBvdMsM1PUvNzMbHSb0FenPhGraSv3bWjWUxNDfNVbFyG40u/BIrIflulyBGsFCoXnMqLq7lcJ5yp0ssUZoA6MiHZiZa0ODMHwr+ZfLztulc1MORarfF2Dzogr+M1sUYdJfhfuT6x+Fd2BtMeyXLLlmqgpyAEiFqVhLs+2CqMDKtA31dXdnL4CzcJczvOCvSWSCw8g8RG2pxILXVHYBI/L4FZrDMbOdKjJG+9/8gK9HRtNPXJHbo00GQ0/k2vnywCFPwPMCf5jeTZqg2K/2Mcq9j+ayXICwDBkLSvDeItO27f/rZ6xWF1mIA8CN0cH/DbPT6bCHonHSGzpOfp12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O98C4Rzevt781lNZha7a44qNS+3LgeafIZ5cwC1cJyI=;
 b=MTmrZWGPQsmq+ykw8n+D0E7bfTHX5SlGO3ZScKoRsUfR+SbORBKgArz8+o+V51XIr1UGlb6Fk5MylS1k/sBI24DlUtSpEDsBn/wdt4TKdZTepvuLfEsDjlbeyPDBUK1kLLSziJhN7ZY6r63l3lr+MtpDbytPrdqKwSc9Dib7Yt3gw62FKdPmZbGh9JpbQxDiGC5kaUpLHMiSH+piUlZ1F6okQig0pprmmANEsX1k6tomJ4QvuEaXYBiRZH9jcExNdhoEfO12UayJOl6jENJESVoiXxHx9MbyKRMTjNE6fTTLvUb8YHZ8SX50i5cE+CQRiwnqchn5bUVFIoHnjWA4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O98C4Rzevt781lNZha7a44qNS+3LgeafIZ5cwC1cJyI=;
 b=c7nBVEDc+UxzncPnUEmL6RKHk6R+4YZBvXRodDVDXdSLX2Uoq49HKSWeGpblsICHSSuDazaU06w87VMM1rS8cOOh16LW/QASre+/mQKycs5Fa7HrScyL+NEPwULG30lRXmdQNdm3XvITRDIxCJE9PvkaQ/TyboctCSENwrGYcNk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 11 Mar
 2021 05:36:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Thu, 11 Mar 2021
 05:36:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 4/4] nvme: add comments to nvme_zns_alloc_report_buffer
Thread-Topic: [PATCH V11 4/4] nvme: add comments to
 nvme_zns_alloc_report_buffer
Thread-Index: AQHXFjCXtI+x3gK1YkqYWEcfPCeoKQ==
Date: Thu, 11 Mar 2021 05:36:53 +0000
Message-ID: <BYAPR04MB49658642053EC41432FCD9CC86909@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-5-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514516766FD5F343D4415AEE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43ea8575-f1dc-4f9f-ad77-08d8e44fad87
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3960AFE5867A229E102BDA4D86909@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRrT7tVBCKMBoTL/KXVrLIzkkehr1y45Yj7QFdmjOLcF30QSa/mqLTgUju0h5jVxdRYKFy4atByNFzw7U6EeHRdOVytoWVJDvvo7A5q+Rus53+rbnIZOiRKOFkhRruxtWEH4jZZxgQYUzwshf42g8bZ4dOsxFBls4KJXEo5Wp0KiyFl+30PLS71j+OBZvoklO+dnLUilOXnPDXvOzKIcKsLFZhKTieSAJoNVrn0eDxfqTyn4LMeTxxOOijKcUCtMriW/rBW4jr7My2n4Y3NDEFlZpS9jc7f3f62v4VXqk2tfpHJquX5nDCvWV89q/vG11Zbp7CRuGak5vWnDjsU2/mdBb/lR2V73M4gK69naFx3HPlClSlJB1edgMn2T17u4Z0Hyjlde8aUz21dcXnKLmJNm75DJyW3xBRnagmMgJEyHjfgvK2wHXTDgRIaDwvJlV4G+3kXtuOfJXJg3GQOtXbu947PRhnqtnEkF4eAh9u0itEMXaja2iZJ+bmZOr+RjsnKkYIl5cI2Lr4puU9x+0gO87HJFS2J9JTYtV8RHNFGitUuod08altp6xe05eU5w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(64756008)(53546011)(478600001)(110136005)(52536014)(4326008)(316002)(7696005)(8936002)(55016002)(86362001)(186003)(9686003)(26005)(2906002)(71200400001)(66556008)(66946007)(6506007)(33656002)(8676002)(83380400001)(5660300002)(66446008)(66476007)(76116006)(54906003)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w7cRTHY8c6xYM7YxnGOjzzRfDDocM8PtQjavtaSDFCizr/gNSuRFuW3b+xUv?=
 =?us-ascii?Q?bqlCd82v2XIS7QFbk1e86SyjfOmmq/NBkGk0gULySmacAaU4eOeCjSXJkKhv?=
 =?us-ascii?Q?pKdHMFl32d6kcBBwHey1BAUSNw4a+KPoZUBAkgiyWgc7vHCh+vieBaHTSXMl?=
 =?us-ascii?Q?E3lRYIcwIWNoFIGiKvtHKVuhjGGg3TqOnKQ/8G35z53Ewkvcp9rjjjp2o6Rz?=
 =?us-ascii?Q?QGm1j/MdRAQI2IhaIK0HWiBTQHm0AiK+/SOIUtU26/Apcau5p6joJEuCALLd?=
 =?us-ascii?Q?oanT/7FMkFX8EKj+IfAlgxN2XOjZlqfxp3z5C5AttV8NL0lg42yL3dK9wH0E?=
 =?us-ascii?Q?JpLbwhS5JvjOPQGrfQ2AX09h4jEIoUhoMJP9cFieYS5BQOR3EMkWK80n4s73?=
 =?us-ascii?Q?SnB0z+B4+9ut1brQTUMivj3J6owaUXlj8Ags4d+Mvyev+f33lR9w4v8YK7by?=
 =?us-ascii?Q?pjs4T0R+4K4iMiN3MeCqjI3EpjqfMLH5W03gffWw33EwNlHs9jm9xQxsTXZL?=
 =?us-ascii?Q?1BReC4nYQMbF4etfqqBoHbzCpJAsO+6n4A/22bo2P+ryBibur0Z7hUa7S7iX?=
 =?us-ascii?Q?slBzVRljSw50B5hRLV7gnHvg6uqwpIClhXj+EvBOLNh2d5JbwP/lib10HDXI?=
 =?us-ascii?Q?Gnbhb+tkDwSoZXVFVU9r6iN6Vw4GFFnhi1UzaxL/DnzjD87c+eB4yXcAHkqU?=
 =?us-ascii?Q?1L2I8ZNvrNuRynTb6Q3HPCrHODnuouRq+poj585ZUIyG38laKTdpHg+WTwrd?=
 =?us-ascii?Q?bi6GqY1BccjNfvfT1mROJlr+S6AfNu83YvuS7AH7m1nYEVix6b/d/gW3U7Op?=
 =?us-ascii?Q?4xmmml5DlUEA/YUZqWQhP6/Kuuif3uIUAzAV87Dq6zR8d9scZfiyi1XSMD09?=
 =?us-ascii?Q?ypJFO7c8hb5RbqS27BfE2N/inJyRxi1wGnXxQYqz9Bcu9kfRNQwXuLPSL4ap?=
 =?us-ascii?Q?XQICYKhAYFfBvF63B/myph/9awYHpMtvtyX6mgW+pH+r3MiUa9xBDijJMhQP?=
 =?us-ascii?Q?v5rpYurkZTYc3S+0u4t57onIhUb+QnKuCLy+BxcgEt+lZgmn2o4pxec/S6zl?=
 =?us-ascii?Q?YAyMJZrk4tam7xFkVnfzbNTPnONHqxOAya9imxkndllyggIpJqTk9RuSGEZK?=
 =?us-ascii?Q?VqQMrpl3By11OsU8XjvggHEig0CZEb833BEU5Jc4jGjfppeWdbO9NwPBP1XX?=
 =?us-ascii?Q?E37utVFS6yFwq3XIkD8xpM1CXkm5m8JOXm1tBVG/7a5XwY+oyBwsBh+AHABg?=
 =?us-ascii?Q?IHp4tI0tckjU11G6oceyhjWridBrfsjOQYKuGrNUMaF4upm0V64vNYTXXk9K?=
 =?us-ascii?Q?AEkWCpowuLF5681ieYFvQRWj?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ea8575-f1dc-4f9f-ad77-08d8e44fad87
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:36:53.6955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rBUccDzzGAs3Z08vCaSSQE+WuqzHtdyGcrMiL9/WL4R4JTFWMgwmlofnAwhP9457/lSA+HFDWyp/+4asTwAmsyCDevict8G3QrUCMfue6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_053657_758790_6719C071 
X-CRM114-Status: GOOD (  20.80  )
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

On 3/10/21 21:08, Damien Le Moal wrote:
> On 2021/03/11 13:39, Chaitanya Kulkarni wrote:
>> The report zone buffer calculation is dependent nvme report zones
>> header, nvme report zone descriptor and on the various block
>> layer request queue attributes such as queue_max_hw_sectors(),
>> queue_max_segments(). These queue_XXX attributes are calculated on
>> different ctrl values in the nvme-core.
>>
>> Add clear comments about what values we are using and how they are
>> calculated based on the controller's attributes.
>>
>> This is needed since when referencing the code after long time it is not
>> straight forward to understand how we calculate the buffer size given
>> that there are variables and ctrl attributes involved.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  drivers/nvme/host/zns.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index bc2f344f0ae0..c2d08d9cc269 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -125,16 +125,38 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>>  	size_t bufsize;
>>  	void *buf;
>>  
>> +	/*
>> +	 * Set the minimum buffer size for report zone header and one zone
>> +	 * descriptor.
>> +	 */
>>  	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>>  				   sizeof(struct nvme_zone_descriptor);
> This seems unused. And not really useful anyway since if this function is being
> called, it should be clear already that at least one zone can be reported, that
> is, the report start sector is below capacity.

Okay will remove the comment V12.

>>  
>> +	/*
>> +	 * Recalculate the number of zones based on disk size of zone size.
>> +	 */
>>  	nr_zones = min_t(unsigned int, nr_zones,
>>  			 get_capacity(ns->disk) >> ilog2(ns->zsze));
>>  
>> +	/*
>> +	 * Calculate the buffer size based on the report zone header and number
>> +	 * of zone descriptors are required for each zone.
>> +	 */
> This comment is not really useful.

Okay will remove it in V12.

>
>>  	bufsize = sizeof(struct nvme_zone_report) +
>>  		nr_zones * sizeof(struct nvme_zone_descriptor);
>> +
>> +	/*
>> +	 * Recalculate and Limit the buffer size to queue max hw sectors. For
>> +	 * NVMe queue max hw sectors are calcualted based on controller's
>> +	 * Maximum Data Transfer Size (MDTS).
>> +	 */

Will remove the above comment.

> What combining this comment and the next into:
>
> 	/*
> 	 * Limit the buffer size to the maximum data transfer size and on
> 	 * the maximum number of segments allowed.
> 	 */

Will use the above comment.

> Simpler in my opinion.
>>  	bufsize = min_t(size_t, bufsize,
>>  			queue_max_hw_sectors(q) << SECTOR_SHIFT);
>> +	/*
>> +	 * Recalculate and Limit the buffer size to queue max segments. For
>> +	 * NVMe queue max segments are calculated based on how many controller
>> +	 * pages are needed to fit the max hw sectors.
>> +	 */

Will remove above comment.

>>  	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
>>  
>>  	while (bufsize >= min_bufsize) {
>>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

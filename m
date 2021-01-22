Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE5EC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:57:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1902A238D7
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1902A238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=AbUZp7mXgBp1E6R0yLuopvTUhvtmibPgYrHFc81F5H8=; b=C5qYFKYmmrznjXrZThx29b/Is
	WYNouBfU+ngmb6WM6/GKFsFO9yyn63oOw8OkAhVb2wDsgwrmhiiXdjItmW3Dh5C5cIPjFlDgftuhA
	7WBuC7LvVVlWfx8U4hzGGVVbuA/1DXuBkg6U3XgP/rt22q44K7O9NmsTONKCynoHHzylB0tnY9NP1
	QKHjusHklQlDdHSZtWJDDuhKJt6xcsgkJWRhXN6zTO5pcD96hwfS/UawiQIZsfwIzaUs4OEujUXJe
	AAd5I7khY3XPJd649tuMjZEREB4q9034B9OlnzERqUlbROoYITuv59WfhpXVtZR1859basBavSYFM
	moRr/H4+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2sFi-0001dB-A9; Fri, 22 Jan 2021 08:57:10 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2sFf-0001c3-5p
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 08:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611305940; x=1642841940;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IFxvEl9TLmT2BFaSwUhWlPrjBx5NqzUmZU0VXJe+qSI=;
 b=lBvvxYcu0thTGl4NATrgvR/zSmFhSE8h2KPaqvkp9dDH0Kv+AWrDcuFt
 Wv42j6cA8+xwsrUDVpTOl8mHnr78/klr3Yw+++xOp89Ps8GQNsPDq3u2F
 BsVLwMiq6LDYxXaflBROmeBUoSUXo49pUrHn9puikvJFpbKaviqv7fq05
 M2fnFvQv3Sh0FESSTrIEPzfPUx3Kk3QJxvjCMwPG7Y2Y8oAIwxPkmS9Zx
 +pO7+M6zTmn/GJ+4gcH7E8/HtD7xlahTrdPuhd+WOyi63tw0EyjNPtJ+K
 JsUCSKAm+LvBb37T3JtphHUkk8oD3e3BSWznVVjEgExBiwq9luejjxKMV w==;
IronPort-SDR: 0qgNYKdgm60UO4A1p2gyzNFTFPZZlq2WIju4QKV1dyGdGCIKlhjimh859IVQ9OIb6bKG+r5zia
 +jn2f3oPD2LYoauS2tfN+mQZBnlSshwZDdzIKQKg6ILEJezPXc+voqvXB37biWEHZY2rlZrUeP
 ezHY6ZxmvPxLkkd79Iq2wHzhSSfvv5Jh0M8TmLjYCvu8ukUvV0mkzCNjI015n/TzQjZRmwFfNZ
 JCu8nQ6sEPkkhns1JPoD8VCuWc/uhKH6qr/nJJUmxnv3Kaw1cPEXKH5rmN32PIf0lISmIpXTu8
 u44=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; d="scan'208";a="262053553"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 16:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvRgjWYbbFDV9vr1eS5LB/+m+D3uBhrk027SuoHPlVEG7U/EKhJJVyL+36rAP4/okVt6L7G09G88jcHNZVXKaApu0IzJJCdShugkEazafH6tcBkB1j6xaWCgXw2v0Klp44lr0S5+63G/BbFCIrY4BjL7WjlnVILgqt619hICk20EVUI9wxbNqU+xKll+MgLSyXlPxSNDvMjSr3iL6q72++TYsRQDy3+NR5pFFVDc5a9+7AGmCjHSKTGBoqyixCfDiQfXM7IsaOH3W+xxaXfwGXarzA2lPhHLMRB8VVzP2o6PIx+i9fL+bs9kVeZzL6/RpmCNvt59vZdedH8Xetj+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuhjnCL6MgLz245xyJvZ6LjD7YH9HZFRpPyCSQrNZa8=;
 b=GWVh5/TqVKqwd/Lpc8Vsu+jU8WE/bKXhsSZWtTaxhVrQ3rZo9APQo52f5HMIPYfX8tY7TQ/XQd3OKp/Bb1gDACg2JQnCDzH8pO7wh6cSnKM1ipFfwXcbYprSXGKfgYvpRACoxdSGJPQZuiOcKykgwkmKAzhpsYb2sKCb3i8voQOJKucKUfdMqS1exkHCIEP1PQjgcIZ1w8GaIEW6ylmR7SAo8TFdh/IPe7loEFIereWlR3QZQvNbJPHfJLaAzK00pET7xr+n4l+zkinsSk3+V5WiC2je+Q3oUN6e+xoG003B3Vpp6RVZazHRwjwvg0uCGla9hRQfVzgEa1zv/b2sOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuhjnCL6MgLz245xyJvZ6LjD7YH9HZFRpPyCSQrNZa8=;
 b=tZaeHPVf6UcKhMytnkn6qI6eFWzJ69nPuMMg0uhLfvVNklRj5Zna6z+W0ahHmdiKdDVNLN/UYaqaGoTBv4UVjnTZ2ORIgur7CpmYuCT3SJ5lCuOeVunfdyNN27jHIa/my1UHq2E/+9Ny7FC530AazrwRscbV6PFxq/2FVdxRlNM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4532.namprd04.prod.outlook.com (2603:10b6:208:4f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 08:56:59 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 08:56:59 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/3] block: introduce zone_write_granularity limit
Thread-Topic: [PATCH v3 1/3] block: introduce zone_write_granularity limit
Thread-Index: AQHW8JU6qVihsq4M3UKmhepNN6tFNQ==
Date: Fri, 22 Jan 2021 08:56:58 +0000
Message-ID: <BL0PR04MB6514A2655635DFF482E4252BE7A00@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
 <20210122080014.174391-2-damien.lemoal@wdc.com>
 <20210122084209.GA15710@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2db5:5c10:5640:816d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad02ac0b-f326-4889-53c4-08d8beb3ad70
x-ms-traffictypediagnostic: BL0PR04MB4532:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4532975D80C502B05F5F3C1CE7A00@BL0PR04MB4532.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0MtYDS6WAHBw72Ty33K6iA/7aD4bbAoATvuXSLZldSmu7BDRpV/vURNoPjSRaLSVnyu41FmsiiNQkZv6s69ypDaPyUKXfO96Rjsmb99Q3BJf5e6FANIlcqe0+EJSs//vUEmFH6ZVLqR6mpzbhzqZUAIuPaYFLCadH6ojw0V89gVUSEJmuzzAyU/W0yNR5Bgl3e2TBBcataGkL53Ogpnmego70+OdG3g1L5t0TFFzZmD9YEkUCgF1oEf31nt+rQwZTrMk/lRPDJKBbhbhiDyGyQtSbi3KuUW2KTjDxoLPSNxuRVD0x5PFrdYWBjjyUtTCZn0KDX0CjE7+cJ/XM/QUO6+lHNmB5XgfkySTBQAvqQL3VUq6OlFkDh37+jSbb1IOD/kqyt0iqiuYFbOP3bRTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(8936002)(66946007)(52536014)(64756008)(8676002)(91956017)(33656002)(6916009)(76116006)(478600001)(7696005)(66446008)(6506007)(316002)(86362001)(4326008)(71200400001)(55016002)(66556008)(9686003)(53546011)(54906003)(5660300002)(2906002)(186003)(66476007)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J8jcNiexa2LEgn5M0zrNxw1Jge6JnP4ZA/1kOmV6bHPlU1ywDRKYNbCXIDSt?=
 =?us-ascii?Q?Z6BzWFKYdMPHAbypSjBURt+2YR24tOHvE4DqeyELhQwI5HYgS8NltXL1kplg?=
 =?us-ascii?Q?7kjgo77WDFi803XktGBsHMi243TbIpAyWWcOrYoSyGs/0dwTNgyfvWtcjDWE?=
 =?us-ascii?Q?UeHKrchFDbVnrAhNtfBBkJaESrxgkZDdOCdoBIh5tu7wG3w+YYfT0ZrPK8PP?=
 =?us-ascii?Q?GlfS0ModkWtDyDhY/v15+eT/VBToNW4FzcLQvqfTJyezBBwC9v6EUpH9q2Gq?=
 =?us-ascii?Q?tv9mMtDzcV01Qj92Sh4hWA5ci2351bnrF9mvJIraUWN0jwYTZc5r90apM/af?=
 =?us-ascii?Q?Xy31sz/rNgIaolfIWTEB+VRSAx4yGDYj9gkY6cjwZ95OPNX0eDdL8f2OxaxX?=
 =?us-ascii?Q?hwYvCg+IulQSS8hJXLGSx5J0DghR1fTepVYHnd3MBMC1DRCpoZKkoj+pfbBB?=
 =?us-ascii?Q?DB/eH8kjKO8I2BzsfwXh2MAL7Dik9pGUZEtdqJpY+SOBH0aU2/VnQ2miSc5O?=
 =?us-ascii?Q?vcsyItZ07Ty72jx6krmAwEo7WEWsxs2kgD20+wDwfmcMPaXcL+FRReGqe+1N?=
 =?us-ascii?Q?KSfPCp9vLTz/962W1wAmfdpEFQF1wX49zzlG1Zy46WYcNa4wBH6iXAyJzokj?=
 =?us-ascii?Q?btHk7lhZVF00hx8idpgZeT2s+o+74PijM0hWEb8ezlOMVLSZEQOvOc+MsoCH?=
 =?us-ascii?Q?0hAtFnbxoAe7dmpdPtQ+ZFPLbACi9RVMxVr+I0a34wqUR6VwqDf/E9Wz9Bz7?=
 =?us-ascii?Q?6sqO0c84uJvDFlL2qfsZK1f4WDRfUYPuDwyQbkPLf/HiRvzZ4CUv0Bvz911v?=
 =?us-ascii?Q?WC1kMCr/z375BTN4mMzobxLkCB69uzO1+YrI1s1DPq6+EzFFivkx3vcgJweF?=
 =?us-ascii?Q?dd8VqZMBLIoSTbdoY1spiTZh21pBgNbBeHquAo07+FlT08MHGOsOyjWRrK7d?=
 =?us-ascii?Q?ce7b4j5aXL/Sq04lITKXpZwQoaPuKXiaDY0RKTgCz7Y8OPMU3IHg03K/KE4C?=
 =?us-ascii?Q?HPgAar/pwr5ad9GmHTEIiEIAC+EjLMM7C0Sq5IDdkQ2vdNJRrNiCYZxskCZq?=
 =?us-ascii?Q?HBx1K99o9YZpU1HG8IZxB/8Kcj9VwVfqyY3vnbupc9t5ZgaswTvXgmfzawli?=
 =?us-ascii?Q?4yfHJ8YIfdlRxUwSXqzQCwFgylYjDuD5wQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad02ac0b-f326-4889-53c4-08d8beb3ad70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 08:56:59.0003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwTW7X8E57r4GDU7H7EhasSa9YQR827nFHqg2PUqyj4vuL+65a9gjQus85/0d6Z89tIj2qgX4gdIMv1BkiSrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4532
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_035707_520269_6AAB99CF 
X-CRM114-Status: GOOD (  16.98  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/22 17:42, Christoph Hellwig wrote:
>> @@ -864,18 +891,20 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>>  		 * partitions and zoned block device support is enabled, else
>>  		 * we do nothing special as far as the block layer is concerned.
>>  		 */
>> -		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) ||
>> -		    disk_has_partitions(disk))
>> -			model = BLK_ZONED_NONE;
>> -		break;
>> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> +		    !disk_has_partitions(disk))
>> +			break;
>> +		model = BLK_ZONED_NONE;
>> +		fallthrough;
>>  	case BLK_ZONED_NONE:
>>  	default:
>>  		if (WARN_ON_ONCE(model != BLK_ZONED_NONE))
>>  			model = BLK_ZONED_NONE;
>> +		q->limits.zone_write_granularity = 0;
>>  		break;
>>  	}
>>  
>> -	disk->queue->limits.zoned = model;
>> +	q->limits.zoned = model;
>>  }
> 
> This looks a little strange.  If we special case zoned vs not zoned
> here anyway, why not set the zone_write_granularity to the logical
> block size here by default.

The convention is zone_write_granularity == 0 for the BLK_ZONED_NONE case. Hence
the reset here if we force the zoned model to none for HA drives. This way, this
does not create a special case for HA drives used as regular disks.

Of note is that there is something a little weird in the sd_zbc.c code that
needs fixing: blk_queue_set_zoned() is called before sd_zbc_read_zones() is
executed and that function will check the zones of an HA drive and set the queue
nr_zones and max zone append sectors, even if blk_queue_set_zoned() set the
zoned model to none due to partitions. That makes the BLK_ZONED_NONE case of HA
drives a little weird since zone information is visible and correct but the
model says "none". As long as users separate zoned vs not-zoned cases by looking
at the zoned model, this does not create any problem, but that is not pretty.

Will send a separate patch to clean that up and have something consistent with
regular disks for this special HA case. The above blk_queue_set_zoned() function
can be used to cleanup the zones information for an HA drive that is used as a
regular disk (nr_zones, zone append sectors and zone bitmaps).


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

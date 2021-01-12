Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF6C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 06:31:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84057229CA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 06:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84057229CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OTDoYcOCyVJtUZG8OO2ZLOkV7yVFzpxyDJNTCyU0Ny0=; b=Pd7B3mdYOAdvwC+pVuY+R3891
	/wyrM93i4ZyIhMT/kc/pr7CvR16wdzAPwpv+zzj47/mrjujE8oZjhYx7Gv/SaxTNNn3Hny6vR6m5e
	nM7PHN1HTm5jL4bHXKH4m3uj17mEJQdiNXDwgRkgo4M8OFHG080gUo6Hf8eziRVNXSWov05t8dP14
	nZaw3hUBPnWwUdRri9cYmKnaFEtTCayUwzquePZDUvVpOwV7kflxZdgr/iRPGfTT/Q+/9bB0zMPKi
	0n8huBPrl5iXc9pA4BUZ3WGA17uRBE3QT+cM9rLUJAZAtwumKd6FrYNoAZPiYQIawtt2Yu7KIGNPl
	PluX0qAuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzDDO-0001QR-CR; Tue, 12 Jan 2021 06:31:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzDDM-0001PW-8A
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 06:31:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610433096; x=1641969096;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xM5gKSNNqxEecHK/e7aTl8l9bUMn7BpV03GjT7JrQjo=;
 b=gG5FWwKrlj71uqKg7Po9TLRWtwmb2MMakWhkt+dI93xjYE3GnfWZZxd7
 5mRFHKQws+DfJ3eDEKaL8viH5V/bsmf8zybnaPOP/mncWq1OtSYVpZzN+
 S8/fAS8Bmp4eduBcg4hxWV13/CCborRYO+IrQuS/ROydZQLx4eDTY1T3V
 woN4pPe5LLTw4XzKsynx558/pQUVTOstXH5VDRlSuuElZcttIhHFytztX
 kYU6N9YgnL/vThBKiJhcYuM2A+0uP7yun0qMI6KsykHIFuE4fE6P2WoXi
 I0TE8rB5+IU2Mb8GHR3gx/Ko4WklWSzuCX0vrE/rlCIn2u/5pO+/+eOjX g==;
IronPort-SDR: J2w3RKajKCaIv1ESD4dX/ZafUSopxDIbW9N2CKPswmErDMrM5Ivay5dt9pMbJckWwj1GPg6m1N
 gOfZ1FVFZiMpHKIBuS1DzuDpVpUlt1shnp2jLMRMMHM5xvv72Ke+I1hVJaW9Ba4/g436AlL5NW
 F8pKZ91MKqxNs6ztFm3Jlh4oRD1rwnkF8FnLOuX8oO4ssr4O3Bp8DirB3KUl7dxsZL2ihO8EFQ
 ok9kSuEiOllLIfbkIqLk/BJALRRv7iHWzyGGXdWVlXWuBVo4Me49S1QkoYqIk+wTgihqgVxKdL
 ADQ=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="158387592"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 14:31:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R155ZJwBUqAyBA533Z9JsheFW2OWYmDCqtM7IQvdYoXZNrZ9BRKB+fCbBSXP8Q9szdDWzUrFS7ILqBnqUFr06i/T7w+yfiWx6jK/RM3ugpvvJ/L1SkE0DUEstuMKlFsOyn3NqCCXGSQDN2Y61GoLVtPN5+0o3do2nHIFFG2LCPAmDGKtZD6oI/nk4S3XefzENDPV6DRANcO4J/ue9JcrfhL5XtruQ3d/FLntQHckFIBlngseG8Rk+JCoFEfrZyvh8BatLleMnpxx5bhhFUQJjL6Mvu5NnV1pVE3coxw2h3fFvwbMfuKfAmAycxBoOsHZH0oFgYcPGWT6BWDzW/DdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff1/COrIRf2E/KAaDTlkoufdPcrSLrlBQJSfqJtbcKM=;
 b=YTHLY5CNDg7RhKIQnq4EP6J9fn/scrSMRjA64fmUllziV/ih0EB9y5VsvQYgMifIgg19JzphX/KWoobZnC9WYpBRmN1PNQYzd/MlD/+jRs+IDmeH1kqB6xSe/ztYYeA4fd670TghScp00wavd6ym7+6KLjDggEP6cMgI06S64jcWmh2uvnAIO0KvY+NxlpNOkk5JWdjjtvQkv91wBuBSE7lwMw38J7P1AFZYKVMfyKHnXFimxa8Xas1IygQ9+SV5aTn7Y58x6Oohs6bFncSV89dkSbi6/nAOtYhxKHklPyw3fK3Vp4TSft45bbBX6I+lLHiXCqqQuVIQDRQnfK24fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff1/COrIRf2E/KAaDTlkoufdPcrSLrlBQJSfqJtbcKM=;
 b=VWAMrZUvlXfqmG0NV/cHAjniRNoLggAFwQgZwgW5H19wA8Bf5h/zeMzqBEoQMxjMfx7sKWGkUesOuZiscGMca+7XtnF2NqWlEcqHbwJxNLpqFKemmim9Iqy4T9K7f/yxfWk0gKMBlZv75iCutX4S8ou7KPIgt2eJ3/IMY7zQ9jQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4610.namprd04.prod.outlook.com (2603:10b6:208:26::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 06:31:33 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:31:33 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6Jsz5Um6YbJoj0ev+CR8KYF1Aw==
Date: Tue, 12 Jan 2021 06:31:33 +0000
Message-ID: <BL0PR04MB65145A8886218E4C56C6122FE7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514A4C7F0F7A2627C4639B3E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB4965A589B5D8F480355AC28986AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4194d1fa-71c3-40d3-f71d-08d8b6c3b48a
x-ms-traffictypediagnostic: BL0PR04MB4610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4610CC6B80C7081E261F4C44E7AA0@BL0PR04MB4610.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63gWCOfJKevf8KduXC+GWtMmk7ONieslaGDXWD6c2InZ9jtAuQBf2eHUzE5+/sfHFnpVnxYpAFLt/WqcsuLyJ4TpwVDMFORTnODPiA03ryIlAZ1DvI22ItHVAi+BomA9G0WNRmlv9getNinsNs/8NDx9nL9L9mnDS13uEU80/E8M4/JqBE/ws707kZBYrYxuzXRe2tfPKf+FdWfLLkK+4lBZ96iGX4xwHJzIIDDN34Hg6ksKdDCU1e5yr9MaiEf4iXiBXqEpqwEjjcY/qzZLPEN3yMhQOReoHrmj4jI1p50epafPTxyE/vpEz/IBV4DwmiKueGvpoQCveIbMCDLpiY9AX+kQX4dZkgcGVlViwlqydrc25cbXeir13ELIUH833CnhPafGa1N7XrveoIdZRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(66946007)(186003)(91956017)(76116006)(5660300002)(55016002)(66446008)(110136005)(86362001)(4326008)(54906003)(9686003)(6506007)(52536014)(8936002)(71200400001)(66476007)(8676002)(316002)(53546011)(478600001)(33656002)(64756008)(2906002)(66556008)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Iebt7BfUQAtsrEWlcJA+Nq7su0maxpQ3Fyoo0DS4g9g5U343dMi1THR04j4L?=
 =?us-ascii?Q?zWh7kKp7sBxrQ2snqT91BXa8/bU6P43KAfEJ0mcYO9B30hvTpuptMQkWxVWb?=
 =?us-ascii?Q?zp7eXQTICj9vQpzUIj4Eh5l5pFw77GeceOM2qjaAjHRuRAGcWmTMHxSikBPn?=
 =?us-ascii?Q?Kp0TJQB4NNRFrOjZR/8fjO9fnN0D3rTEEQoWYysoYBk6ECp0uXYwbh29hOro?=
 =?us-ascii?Q?ImWJ1uCoSAQC0tN/+Ewb3NKL2TXQ3GkbhoP/DYh5Sn5njXq5Ehmy6qhIz15Q?=
 =?us-ascii?Q?tHrdDIr12fF5DZxQiP9XHLZe4sv4tyr8RC2dAGry2YRuGBIiG7PwoNHnv/YJ?=
 =?us-ascii?Q?TJ5+RK8LNkeb4oIEYHqgQHHfdzXh5cvXS5TWnQDNeXd5GjIbhkRGe0VZixbO?=
 =?us-ascii?Q?+xShOPNj5sgfvvR58ARy66wdHYo0OfrSQPsHYLTbstehPP3q4JWTurF6U3Km?=
 =?us-ascii?Q?sz9tCXSYjf5qsSe0e6pCGPONJJhhUyiUEmHwTkMrXwMGJxzFcdOyfkJioQ06?=
 =?us-ascii?Q?kkjVh0OBS6hIacwubzCNPOVgKtE+yM9jWa2/HrEvu9nClMXpXc2fc0x7cpPQ?=
 =?us-ascii?Q?R6l21SIVrUTNDqJdZAeFzuZEM9AgRV5t0mb/C3Zr0zBfPCYFP/YKC3Wc84xf?=
 =?us-ascii?Q?25GCRrAa6uGqxL33MYA75+PgeajZSR49fkcCBmfgcMtIVinWOrJRWGefWmJ+?=
 =?us-ascii?Q?MZ2E4EirsPI3qKtfli4YsZ5CqZo6sdqHm/csmQbYySqWtndE0+8cVED6ckj/?=
 =?us-ascii?Q?UPEPcpnZ5FjDPQTJb+yAluwuOwPQfs/qy5BEupg60Cv1rsULRfMBqMolV/dT?=
 =?us-ascii?Q?PPpFnDbxBE29eUT0L08nbKk9taO1lsbOGS62MHGHke9oVuAFxMt0bPe0xB4i?=
 =?us-ascii?Q?ZMiuiaspa0rFYb1Gu2kkmmyWXfHjpwKyeL8p9pkes5dQLbfx5F9P4MmSPrRl?=
 =?us-ascii?Q?N+3BvkcCXW/8xxTXGlgjIOPVHqP/Mkm4XSBSAjL72hELwVzZnzaTPaGiVO+O?=
 =?us-ascii?Q?d9WwTM7Cf9SnYCE8WmTXGi/v2Zo4LQDM8QR+pI+9PGntO+Qdw17VHe649ukO?=
 =?us-ascii?Q?ytwoKzYT?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4194d1fa-71c3-40d3-f71d-08d8b6c3b48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:31:33.6271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcPo90fK8D2WUUCNjNraFoxsUDiPBss3aTdgWUKZmkaX2V92XFnvCk80i//6cdqtqwAVZJd6qv7fFTcOSnNz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4610
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_013136_440093_6CBB7638 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/12 15:11, Chaitanya Kulkarni wrote:
[...]
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>> +	unsigned int nr_zones;
>>> +	int reported_zones;
>>> +	u16 status;
>>> +
>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>> +			sizeof(struct nvme_zone_descriptor);
>> I really would prefer this code to be moved down, before the call to
>> blkdev_report_zones().
>>
>> You can also optimize this value a little with a min() of the value above and of
>> DIV_ROUND_UP(dev_capacity - sect, zone size). But not a big deal I think.
> I did that as per your last comment, when I did the code review with
> host side it didn't match, I've a cleanup patch series to fix nits and
> host side css checks for zns I've added this into that series.
>>> +
>>> +	status = nvmet_bdev_zns_checks(req);
>>> +	if (status)
>>> +		goto out;
>>> +
>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>> Shouldn't this be GFP_NOIO ? Also, is the NORETRY critical ?
> Yes on GFP_NOIO. NORETRY critical means how we areallocating the memory on
> the host side nvme_zns_alloc_report_buffer() ?

By critical, I mean that if __GFP_NORETRY is removed, things break ? Or is it
just an optimization to avoid overtaxing the host resources ? I suspect the
latter case, but wanted to make sure.



-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

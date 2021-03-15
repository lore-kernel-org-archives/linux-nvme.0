Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A24C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 03:55:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E27564DCE
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 03:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E27564DCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=V7AB5uxs+bq3/SPoGmV9iuwVYYgv9ohMxkmIMxtAMsI=; b=NyCwK7ImsaVj6Lo2oBr91ePJE
	N+BNEwsqdtuQx/LO1iRwRdMbwlp9sAdC8JZUmrT5oM14F3TrfvxmudgDKniKXbBO4OkAVDc8jftlg
	7p/sDzoFbPDweD6bc/gZXf4rlanddCJh4squmhzI7RH6kjpGdDrVsIl2ZyKB0KwukgpfXlr6ckQ44
	fgLtknubaPpaoUsKqL/3+OT92vlQAfpB6bRs5G1LsHXRdZpph6XvGBJDJUuliTq0vEQNLw6NzcGXx
	x/DGfriLCxAsAcmbNlpyMrQJoUOgPRQdKb9DHiATEjANmMcIsOYUecNJ4JDstG4dQ3T7AIWIZlyoP
	c8ef0HUiQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLeJd-00Eq0e-CF; Mon, 15 Mar 2021 03:54:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLeJT-00Epzn-Sh
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 03:54:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615780480; x=1647316480;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=C07mR7Urn6Vhkn8bpH4iXZpY+SFCn5oucxEqqVemaHo=;
 b=oU7EuIJMAKBnSa/3PzToizyWimwrLb/lO4z5m/vGqAFP5zLZswUfjrPD
 gJcPGIWXOHh0bRQpJhtbjNMzVXVcXEKZtVmxZJR8wZAGLEmN6QptjRT2V
 SYjp/xOw5aRra+HfzWS8ikn/yXpqSGrjlb2R+sBq70iGKPASwYgYfojsw
 LpvVksngC/QohMPB8L8o5be+vObPrc7xoI71VDEu0WlhhBv1hzoGIa1V9
 gvh0v+s12xaqPgxyeA7JbqtsgLm18euaqMuvAM9N+VnQc8EURfLDnkeul
 NBn9RUMVsCqg/T+wkdC3jd2uIRe3H81EXP8uyryhZ4TBSNCKRCGXLHd9A g==;
IronPort-SDR: RrFiUnxdn650/YsL+sZASRAF7lp3Jfeb3tvOXsM/RYs3+dxmXSJGQvxqu3Eosm5+mHttHCdA5w
 QVn2mjb7iyJNCK66DfXMKC0M9MTXaccEmPgMSumdFQY15Zg4HOC9129a35/RGjoujs47ZIC5ba
 ieWiV8TlMWB+Y879WzAhf75GDEjRPO5nPdoVzTCQWLtzqrCWPFUiS6LwVwR+EW8AEd/bbTJ/kI
 Z/o4qGvlJnnkSIHQ/pJpuy7P7Hzdy6PULTRgxJglrkfjYGCWdRtpBO2ERpxvkU+nqU2/hpMkRj
 YhQ=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; d="scan'208";a="163282781"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 11:54:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TImPCuAsrppYxBIoWTuu16l20G53njk2SG/FyqxvuG1RWgLavF2472+B3ilDb2wYZX08OzvO+VI2+fi0Ix5+QyZpGiOpkHSeDZEPaEHeAcLQG7UjB4WlAbFdLxq5CdY8skwGampG5xPuiWk6AE7772TcJ73DIagfYz3SumDILBPGTPPdyWPG6Y6XkjfJKYxaXmuBvJx7rODdXB2N62tDwE317AFKQxxP4bXkpoDtJdKniT4fw8HHA8sHSuZuBdmntdElkX878IidAWhoFvTT/pZSlb8Dq8BY8GTNq4GtN/75Fa981hl78fz/6B3ikkFii2YLbpztgCgL9yLOy6SZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZLiWKuBq1MFcLyBR5WCMtEJ4ahlkbUWyI8v14dURzA=;
 b=GGwv0LF/qT9Y+cCudjseDr4nGn+KqozzMfN02nnhEcapqqIvs4f2LjDc7IEuWIJZSqlV24gtMN7vl96CTjrRIfbbisiFDek7v+QuW+pnDhMrAEi6iFgwNqrkALkzdAV+JkH7XvLBq8ARZZPHHsW3B57RYUpRMxVH3xaZdHnPfe4db6Ltxow/FOWN6eCHu86KCiSx1bd3MzNwQkbP+lwI7j1cRDZfmh0XP4FW7pbHI/p4uVDjRxCcqbflr0KT+9m5L1Xo+0csen4b1dFxKd/q9DWSFMIX89EfCUeHx7Gdu+WLm4x34Xjxf2ceQRPZ8XgU+L6p8IQ4lbQ34jpT7EkkrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZLiWKuBq1MFcLyBR5WCMtEJ4ahlkbUWyI8v14dURzA=;
 b=Scu3IIihgBmibgr5B7ekpDyA04lRwmdUmFKFlCiyOsvyqtRLWSScxIGxCkXE0BE5GotCHNqZ5VQIoP45b8isx0V1Yr27lk0Hev7ZQFh7x+VEwmbXf3XNaSQwC8OunfUuJ+QJoCUvbzTF0ZMms/2Tlgc83dvXPQ46O0ddLMua43c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 03:54:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 03:54:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtzlyRTj6MdkG4iVwqsOEFzw==
Date: Mon, 15 Mar 2021 03:54:29 +0000
Message-ID: <BYAPR04MB496561F5A30C4200976B718E866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49657E04A5017F5C31D4EFE1866F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BL0PR04MB6514F4EC40A62AB4763560E8E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5823900-6ec6-4bf4-6062-08d8e7660926
x-ms-traffictypediagnostic: BYAPR04MB5525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5525EA344DE735D3800B7621866C9@BYAPR04MB5525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPgRHCumM9XwC7zdYzL6iFO72RzD8xO+6A43j3pG0WSspW0yQcvztnZ1lhUoWlHiUNR6O1BooaQC6GQTnfJko5JKZ2EFDqcSgftWPqkBI1HJw0/cMfK7kuvBcoS33kjLxr3af6/dhgxrDa/m+1vrsZ2EpRjILxH1RFVB33JzD2e9ei+yNSwEYt4ecu9j6M1RU/6fvbZJwu9GDoAiFPtkJ6ONnIP02RDSt0pOtIr8ILOgeUDQH4ADsURLbHTzs4IDvOobQ8fuHQSZO66MUoSi+h/ibr+boTKye6wKxouEFdPunOy9OdGhaQJkvf2NmyFA49MTnW4utFa164zdY83lYK+v9g15/ZBYOU9IiAZoOmsKtm9idggVSP0aOwBq8pOdToOVN9Hc4h1+qTEXwJFErbZjHEbN0GxBInrhW5uIDAbovX/9P9zYrs5nyaq344+SwHERRoWFItMhiAaTzSaOlGcXzNtdGuvS7aZuctGbMTtS6/dYHaqZW3WbdbHbIRuxV6Kfwb0FLFPFeVWjUG88CZIedZt3EPExPlA3I5AhZcyS6eCrxljtfwwb4GBExV9M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(55016002)(7696005)(26005)(33656002)(4326008)(66946007)(2906002)(110136005)(9686003)(186003)(71200400001)(66556008)(8676002)(478600001)(86362001)(6506007)(83380400001)(66476007)(66446008)(53546011)(8936002)(54906003)(5660300002)(316002)(64756008)(76116006)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5SJxYXrDGM9MJxHd9LAxZm7LvgcrucJzOlti966W7P+5x4YOP2Zs1mqbwFQj?=
 =?us-ascii?Q?5EtITLOoFElclALCkEAQFtwX/+/Hww2K7XO60BwQRYIxdGa+Pfw064olg+Fn?=
 =?us-ascii?Q?FDW0/EGlhIM4dtPaPvaZIx/7Hp9KdLRv5mVQleNmh08Tu/8EyBFbFgtpRVMC?=
 =?us-ascii?Q?EMIrlen1/N90jaVvSX+FZSpnHAcdO+BCY/M8zl+rNXoFuewxbg5yEEZGuw8P?=
 =?us-ascii?Q?deHDh2hjyXx3+kGTiUZdY5t012vaWt0eJ+sl4UCA2kcvWB67g0Ophpkdsy6E?=
 =?us-ascii?Q?54JMSRQcVnaW/Ic2f8muNFaixOSqdh50glzL3MOPNDflh/CCtacQ2VB+9sxs?=
 =?us-ascii?Q?i0vNMDyDUuO23aAeeaI/WEJUW9rdnLU34k870VC1XIYrDGTk+6Pd/WjxzMZf?=
 =?us-ascii?Q?jCUSuOAWV69HbbYtK7nF6U6Jmm3KBGKBBgfGyDCUxvBVKCNSJuxkvDdDK3Om?=
 =?us-ascii?Q?f1KTA6LHTPFkJlY5VgvfrViu++VK6gwWdM81o+semJRiD3q+DkxmEoIaR4w1?=
 =?us-ascii?Q?F3ihVWkcBj2b6odmw9I5H/4fi/+3tLEsQw2PPAdT8ItTe7fJO5Uo9fjJlRcA?=
 =?us-ascii?Q?qEwTcohckUEcZN5dBH8m12IM5DeAAwsBzsIn3XoaU+XqQtfjRDlOLgG9MYiR?=
 =?us-ascii?Q?ZBktCj1qd1N0AriPAM9mG7hAJkbRw9cK1oIs1EUOjVKy1YygmXFT4b/CbDs8?=
 =?us-ascii?Q?UeV37KGxwkfprmaXD2/P0YfmZ+R1SUNsGEHvsM3owMNBm+Nvya3ZzndJ69xI?=
 =?us-ascii?Q?TqQvOSRGwxCHRqZ9l5WkgBLgldK+XWNt/mw1mjpKBdmynCvdeh3LK3bAkv8t?=
 =?us-ascii?Q?oO3+KEoqsIFdHdXWlORrI4DeO+QQexUDFhYf3y1Krid4Z2ZInsKBi46SNitI?=
 =?us-ascii?Q?gA88X7T9bxq5u9HQj6RQ692BOKH0lEnWBVQdEzG8qTr9u09u2J4TS4rXImVB?=
 =?us-ascii?Q?vQpaGI/9eN2iwAKhUkMFoFD+zghn7Opg6/fMBdlc4p9kITRHjlKgO2nP+Jhc?=
 =?us-ascii?Q?vBiut6ohVsg8LAvdoVpdQx1E02PW+89Q97ublw/1CypxtQ9YvFSoezj+c4mf?=
 =?us-ascii?Q?et0YFvU0ThRIQ7xrlU7FhPBC0A9Tr7yfQEop0ePDbou3KqL88nlU/6r/I8uR?=
 =?us-ascii?Q?KPQruyXPT5R5HoxLab1Mv9khJSAebCKkE2BzGE3SNndcPl5N6TQh1vfWq2I0?=
 =?us-ascii?Q?dUv+1lSAriytlPLgPSOw/9+RfCgfFg+x03wOubbx1vPNRx8yn4wHCPFiSwNt?=
 =?us-ascii?Q?5S0ZMiv6agui61nPCe06TNj5wZb9Y3Wc9UJhu7t6xHYPw/n5TSLrfHaSgrTH?=
 =?us-ascii?Q?mN291xGmE/g5y1WoiWSEBUU3?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5823900-6ec6-4bf4-6062-08d8e7660926
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 03:54:29.6695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlOcnuYZhbbdnCRvyWT/aWSfW1+W5cKCoGzWNhRThZg6qDCwZR3JsrziWTcpgfNxmU5RbM6kuIUowFtVoWRIIYlKAsRQtv+NOxA2c0fQIdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_035443_449248_A985508D 
X-CRM114-Status: GOOD (  27.22  )
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

Christoph/Damien,

On 3/11/21 23:26, Damien Le Moal wrote:
>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>>> +{
>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>>> +	unsigned int nr_zones;
>>>> +	int reported_zones;
>>>> +	u16 status;
>>>> +
>>>> +	status = nvmet_bdev_zns_checks(req);
>>>> +	if (status)
>>>> +		goto out;
>>>> +
>>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>>>> +	if (!data.rz) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>>> +			sizeof(struct nvme_zone_descriptor);
>>>> +	if (!nr_zones) {
>>>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>> +		goto out_free_report_zones;
>>>> +	}
>>>> +
>>>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>>>> +					     nvmet_bdev_report_zone_cb, &data);
>>>> +	if (reported_zones < 0) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out_free_report_zones;
>>>> +	}
>>> There is a problem here: the code as is ignores the request reporting option
>>> field which can lead to an invalid zone report being returned. I think you need
>>> to modify nvmet_bdev_report_zone_cb() to look at the reporting option field
>>> passed by the initiator and filter the zone report since blkdev_report_zones()
>>> does not handle that argument.
>> The reporting options are set by the host statistically in
>> nvme_ns_report_zones()
>> arefrom:-  nvme_ns_report_zones()
>>          c.zmr.zra = NVME_ZRA_ZONE_REPORT;
>>          c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>>          c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>>
>> All the above values are validated in the nvmet_bdev_zns_checks() helper
>> called from nvmet_bdev_execute_zone_mgmt_recv() before we allocate the
>> report zone buffer.
>>
>> 1. c.zmr.zra indicates the action which Reports zone descriptor entries
>>    through the Report Zones data structure.
>>
>>    We validate this value is been set to NVME_ZRA_ZONE_REPORT in the
>>    nvmet_bdev_zns_chceks(). We are calling report zone after checking
>>    zone receive action it NVME_ZRA_ZONE_REPORT so not filtering is needed
>>    in the nvmet_bdev_report_zone_cb().
>>
>> 2. c.zmr.zrasf indicates the action specific field which is set to
>>    NVME_ZRASF_ZONE_REPORT_ALL.
>>
>>    We validate this value is been set to NVME_ZRASF_ZONE_REPORT_ALL in the
>>    nvmet_bdev_zns_chceks(). Since host wants all the zones we don't need to
>>    filter any zone states in the nvmet_bdev_report_zone_cb().
>>
>> 3. c.zmr.pr is set to NVME_REPORT_ZONE_PARTIAL which value = 1 i.e value in
>>    the Report Zone data structure Number of Zones field indicates the
>> number of
>>    fully transferred zone descriptors in the data buffer, which we set from
>>    return value of the blkdev_report_zones() :-
>>   
>>
>>    reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>> 					     nvmet_bdev_report_zone_cb, &data);
>> <snip>   data.rz->nr_zones = cpu_to_le64(reported_zones);
>>
>>    So no filtering is needed in nvmet_bdev_report_zone_cb() for c.zmr.pr.
>>
>> Can you please explain what filtering is missing in the current code ?
>>
>> Maybe I'm looking into an old spec.
> report zones command has the reporting options (ro) field (bits 15:08 of dword
> 13) where the user can specify the following values:
>
> Value Description
> 0h List all zones.
> 1h List the zones in the ZSE:Empty state.
> 2h List the zones in the ZSIO:Implicitly Opened state.
> 3h List the zones in the ZSEO:Explicitly Opened state.
> 4h List the zones in the ZSC:Closed state.
> 5h List the zones in the ZSF:Full state.
> 6h List the zones in the ZSRO:Read Only state.
> 7h List the zones in the ZSO:Offline state.
>
> to filter the zone report based on zone condition. blkdev_report_zones() will
> always to a "list all zones", that is, ro == 0h.
>
> But on the initiator side, if the client issue a report zones command through an
> ioctl (passthrough/direct access not suing the block layer BLKREPORTZONES
> ioctl), it may specify a different value for the ro field. Processing that
> command using blkdev_report_zones() like you are doing here without any
> additional filtering will give an incorrect report. Filtering based on the user
> specified ro field needs to be added in nvmet_bdev_report_zone_cb().
>
> The current code here is fine of the initiator/client side uses the block layer
> and execute all report zones through blkdev_report_zones(). But things will
> break if the client starts doing passthrough commands using nvme ioctl. No ?
>

Regarding the passthru commands support following are the non technical
issues
I ran into, it will be great to get some feedback before we proceed :-

1. We don't support any passthru commands for the generic NVMeOF target
backends
   (file/bdev) for that we have a dedicated passthru target. ZBD backend
is a
   generic one, so do we really want to add support for user's NVMe
passthru
   commands ?

2. In past we've decided that for NVMeOF target non I/O commands should
be handled
   in the userspace applications to keep the target light.

I couldn't come up with justification :(.

There are other features that we may have to implement apart from filtering
if we want to support NVMe passthru commands e.g. Set Zone Descriptor
Extension,
Changed Zone List, AEN Zone Descriptor Changed Notices (Log Identifier
BFh) etc.
(these are just placeholder examples, please do not take it literally).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

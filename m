Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C5CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:39:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C7A64F94
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C7A64F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=t9Hbps5paTA5XcMt260udxTWCRA+oK7bpPn6lyYmY7A=; b=DX5/ebKoplIVcfXKzf1PtNo9Q
	X+1Q9D/G+F9HpOAX7Pm/b2p10nEh9K93wfU81Sd584a5VcknT0Hkdz2Bj7mf4CPGU4KGjPjnxSwyo
	new8950k8XE/oZma+lmmWbtgRUIN9o27ko1eYTGV842LOMGwkAUACfBSefaj/K5NDZ2eiX8xhqRKx
	2YBRTrunXPmbOETlrhn5u0oMkogAE3MC4NkO5j8u6ybK8zhbNBlJfmU8JLXkyjSR9RnSJ5tGxpZPF
	g1HN6qcHbOhBwLj2YpEnFt0epHMSM1aBQs0L3mwUiQs96ydd/e/O6kRaNgXmGOOz+Mj6n8fxVkyil
	Kykk0I3Aw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKE2R-008PZ3-Ge; Thu, 11 Mar 2021 05:39:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKE2M-008PYH-TA
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:39:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615441146; x=1646977146;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nzk+RdY9Vdj4XgFSTrjRGsWLakutDZXYgnSOCsRiVHw=;
 b=f2Fcdws3ZcQLPfTZs6QjzD2T67Lt1kk4iFs4edqyj0mN1gxZ2HXSp2qh
 paJ02p3qbAGkz4OTsvT/WjC/6Wb7XZQVv+X+/Lh9LBryir/Hidzl4m5AV
 /65JyN/MVABcKvSR27QwIaV8gCpQ4CgQChjkfQa0myKCOjJV9EdCMTvIx
 KxWjayToDzQb9OVewut0JZIIqj+lG/HxFY18vQbhYtrGleC9wMixqfBQX
 /XVRWPetoQonF4hN21TGOK+mCbCw6luFZAZ0PPdaRVc59dKTaVZh/O6hi
 BmRji3ISqC2pYd3e1kqGrRzCuceofo52qluX0BPaAhPqZ5CEWjFRH6NtP g==;
IronPort-SDR: zh6npLs/3iWy20KF3tHDp2pmARDg8HoEQcUWXEZONXGFNisT5hOuA9vNy5N8QKNtN9kijuBfw0
 njaIEWad+6MJ1nNPt8E17eXZNdauWqLCBhLndecBYQOHy2LdIlm6B5f8tT/Q/qNscKdl/Z/BkW
 j7V0Em82zfA82WzshR3aOEa5A9smGL59/btrW+BifMTKGqc+vJE0EMzCnMB9Zp9D3W9qRpE55J
 Yan2ev4N17q/bfbcJb7+F2a4fHJIbBMqm2Kkld6+DkuahfRFiS7QgLFBqKEQ9zLrY+AJSpihfA
 56Q=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="161898374"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:39:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzjNrZsi/6q17hPCcEEllWiEUdeFjer+wJFalzO4ERxus8H19hmNTGCXU4KyOSu2PvrZROpK7+glfsnt2QcxasmKgIR0Ds8yca7IcwPEsEeqe/ZD7HBZdNUv+Awy9QVDNa9rqrDLvb4RbMS7O89RUPUiLeXvfMOidZnI+cobPHPhbDB1d1R5crr+fkOZN/tUuLQsko814KJ0Lmc4VeiDT9clnSOzg6hGuGCfeJzPOUMIN7/jpcq4aCHVlieclewr2c7vLa82c2++cxPAn5SCzpsk6z2dTBRcfVe1Ho8uvCJHM8Eum9Y1LaXn8+WYFcX86TkK+/lQiv/UOzqxcG+bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQgF5rp9zZgrSo72dLrH9vCXMyEPtRQMWsJDmioh+u0=;
 b=G5how8SoQpR1D1hzqsOSBiiGYRiH1gtCDYjbgVsJ4KRi19Ti7i7PUFQGfQNdxSiLJCXKzNHm5O+MlcMkmYavO3dtlBdSXdz47IktfHd81NMoukWcwngYTEukB3Jp407T+Qp628+13YIxZa7BXaeeBlYgMf1azxYo9B08KeQ/qQEDB+169Jpy9Eu7OHzKTP8aQJnM2dnFDOwsmgyajhh4j537tCzxVBn2n1racMhwbaWSpXulXXJ9FqsgIKUKFPrzr1ezyPqfWybkgRixHU6f9EJYePjgMbDiD3gjcUEBFaMQYGMQsvYBhBgSTIWD9yYmLPDyZ3vZdflA/NoraLZFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQgF5rp9zZgrSo72dLrH9vCXMyEPtRQMWsJDmioh+u0=;
 b=AkX44kc2+5hSXupZEYBsnJXZc2YAMzvokaRFLBOXVHpPuGsmftxBcK7d0iEDw2s9motblrVuwmlmHFGUoEDpNm9rfdV7HjrA1d82xhtE6aHYHmZ1RzUTrdj0IBzj6CQns4f/LSV0rWBbyg6uGkdrabGky3pp3hjaM2F/lVmbsDs=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4771.namprd04.prod.outlook.com (2603:10b6:208:44::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 05:39:02 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Thu, 11 Mar 2021
 05:39:02 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFjCN2624kbFnR0OBSVFjgPrDaA==
Date: Thu, 11 Mar 2021 05:39:02 +0000
Message-ID: <BL0PR04MB65140897830F157825CE72CCE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B376CCD4EE404050E1D1E7909@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49656EEBF4AA66D1B4F4596686909@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c1a6:aaec:6201:ec23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41b7aa42-9a5f-4e90-2a30-08d8e44ffa6b
x-ms-traffictypediagnostic: BL0PR04MB4771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB47712329B6BED699C1813DD2E7909@BL0PR04MB4771.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q687FdNt/8S6y/muRpDtpgjdQMiwmKFo+HojLA1PR7ItTZN/oTElYn581zBvz47F5JQuINtYXdWu/e3yQEQ0ensk9uErjYrznQz0i8SINRgkAK7f+ap47Y3zaIO28Gb6JRPRW1pzSYYxbIxsdfpjo0A2EbCBYQNkFC7xQJsUJIOuuk2HLYN/7AC05w7+oSxdoc5TEsUOxWmUHWpF50bDmxti72Q8IVKs57IRDbcM03d+nemuQ/WUMSEntwe06oqCSyJ/DaKFy40e4hxoAI+f/OFv0XkbWTrrUpw1YCm75hRp1Ek+mAWqIrMzzzWLZPMxqmLKcj5RDAh65PKIrL6L6Tup5MPAWm1LstkieVajRwWIKYopvutl6TaV4UkL45kjQT4b0tRT+FFOEArruq5iMO1itcTLva4fMEIhThqj6AOx+D6Mo8jUYDn0gr7oY2vYs1XkFwvvvJ9ZukP3R5i/k4h65gJnbu/tEebbNxHj059kMLikndP7j/BFMB1cJPPkPGw8YMjBDw1w9JCCIhbZdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(478600001)(86362001)(7696005)(2906002)(54906003)(8936002)(110136005)(316002)(53546011)(66446008)(66556008)(71200400001)(186003)(64756008)(4326008)(66476007)(5660300002)(83380400001)(9686003)(33656002)(55016002)(66946007)(91956017)(8676002)(76116006)(6506007)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ig2DMHNz03bz4Kv10Guks6/D8lFv34aOTLCzV0FLk+0pr8skzZlB5lTReraH?=
 =?us-ascii?Q?kg/zpQnvh97wWGiwNcTFcz/A0dsYsYbR+WEmytUPKc+1J3VtPmX+n+w+Xuty?=
 =?us-ascii?Q?2DAvNQ9u5kezN1/CkNJHoF/LwddtGvCet1ZkyQ1avwyKONoU3p/ABopDQLo7?=
 =?us-ascii?Q?E20hJkNmhpOul8jSP3+tFTyoXQHc/ped9XP0UhEmCYeiFKIEu0PKm0mSuz4J?=
 =?us-ascii?Q?5AzvZzcz3W5YOOJ/uWHiJIweqj7WsMVBAvcgqnoeJiMyBnjIdrtyBd/owmY/?=
 =?us-ascii?Q?rOihw8G1P32FSCnxuB4ic8Awu+kJCtYW+9WAditg/GHAgKMDztZOiW0Glj5/?=
 =?us-ascii?Q?tGsjok1QH7YGbF6zd0RCXQGdZxjNrb6D+eySIZ5phG+zJ+KVj8EvPb2FJE59?=
 =?us-ascii?Q?mcPa+ab1JEz/rbpCZvZOafNS2yiD/kG9fdig5ya2KvTf2xBgvwH10zlUAobg?=
 =?us-ascii?Q?UurcZccIPoAF5p5yndWxgX2oFKLZjcfrvUecnJKYEa0YZ/4cQCdaKU9cJ3jF?=
 =?us-ascii?Q?oBJS3Fbk1YQ3MOHP1UX5urdjx5grhJ/JjC4yZPc9F3FLS/qZ3XJInT++uNje?=
 =?us-ascii?Q?LAzto+XhJ7QQrH1IXd0ig4UchQ+EgdOdx2Ru8dvJlgOp7p8eJ8Ky22hXw4f9?=
 =?us-ascii?Q?XyP+vCfhjYc5ZUe4nM4dFPpi1AD14EJiqT8jNs0kTLAVd/I3h7RodbCtbCCm?=
 =?us-ascii?Q?k7pV75zD4AmOHqz1iOrtbDNp4f/eNk2JUmJ38ZY0KZ/mcyxsYXNqqMZdJYta?=
 =?us-ascii?Q?OcZedx4HqTTkTf2V73QdqK7oDVNpUNEpMF/tHbaA93uM0cq1WSi+aMj58uwA?=
 =?us-ascii?Q?CQATwuBYM26jA8kbP+ArHdZswKyNFyuwIjXre4TfMGKTvHgaoKFYPE6vy0Ym?=
 =?us-ascii?Q?Arb4uc6gXMcB6plSCVrbPCluqt2vA14CtsdIdx2tgQ1kgFOQ/O42OjqWgb6O?=
 =?us-ascii?Q?+kRUIkG+l0XtpNST+MBeaHGiujYsFipEi077Nc3eYTEDlPXi8JTXlIf1PT40?=
 =?us-ascii?Q?8klj9uxKr+CaJtP4FuHaJK3zcs6MRoEpEQ4UexuxWSXM3mxrs9XLJaIHTBed?=
 =?us-ascii?Q?VBjrodR0wSeACyCSAeirCoAn7t4kSDsQpRpmlq1bybbYNIm532oGZ+H2C3IY?=
 =?us-ascii?Q?pNLVji5f9JCO5rmZGrjo66l1winaBeUroKkB9pCM4KXuCBjTgxjnDVtF8H2R?=
 =?us-ascii?Q?+YkF6zuRZaLUIq2JVFYc/7cHy03UfskRQzlTHcrj8W8li0Gi0t9TfhQPwce8?=
 =?us-ascii?Q?63/rkFmghb0Ot6jy2nLqjSRyFXaDJfWCPrnlNDHGNjxkzh62PjzSC2wEGJSt?=
 =?us-ascii?Q?hK4WXVDNtUOuIVa3Vzd8R/ZYyUtO9H/9HEvuoPhukhZCKR51yvU9LciNynDY?=
 =?us-ascii?Q?8kFsS1ecJoFSyUILmGzPbmRnaing/wweoXM7k4WFQ87FPb096g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b7aa42-9a5f-4e90-2a30-08d8e44ffa6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:39:02.6815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OG/jTafJRkGfbNgnxLkStZOigL3sEpJea36oqO6b6UrQ2q52Q8XPLcNG5Rfk2k0oWcIFEX8rKbeIbPZHiazxog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_053907_290571_1AE7A185 
X-CRM114-Status: GOOD (  14.68  )
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

On 2021/03/11 14:29, Chaitanya Kulkarni wrote:
>>> +
>>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>>> +{
>>> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
>>> +		return false;
>>> +
>>> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
>> Shouldn't this be using logical block size ? Otherwise, zsze calculation in
>> nvmet_execute_identify_cns_cs_ns() could be wrong.
> 
> Okay, will send out V12 with that fix.
> 
>>> +
>>> +	if (!nvmet_zns_update_zasl(ns))
>>> +		return false;
>>> +
>>> +	return !(get_capacity(ns->bdev->bd_disk) &
>>> +			(bdev_zone_sectors(ns->bdev) - 1));
>>> +}
>>> +
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>>
>>> +
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>> +	unsigned int nr_zones;
>>> +	int reported_zones;
>>> +	u16 status;
>>> +
>>> +	status = nvmet_bdev_zns_checks(req);
>>> +	if (status)
>>> +		goto out;
>>> +
>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>>> +	if (!data.rz) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>> +			sizeof(struct nvme_zone_descriptor);
>> What if nr_zones is 0 ? This should be failed.
> 
> blkdev_report_zones() already handles that check. I thinkthe error condition
> below blkdev_report_zones() should include<= 0 case instead of just <.

Reporting 0 zones with a valid buffer size (nr_zones > 0) is a valid reply, not
an error. This can happen depending on reporting options. Even though
blkdev_report_zones() does not allow reporting options, it would be strange to
fail empty reports.

> 
> Will send V12 with the <= fix.
> 
>>
>>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>>> +					     nvmet_bdev_report_zone_cb, &data);
>>> +	if (reported_zones < 0) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out_free_report_zones;
>>> +	}
>>> +
>>> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
>>> +
>>> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>>> +
>>> +out_free_report_zones:
>>> +	kvfree(data.rz);
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>>
> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

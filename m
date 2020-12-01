Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15165C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 05:44:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0542168B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 05:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vcAJ6qn3";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="AWdjNS4S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N36KLJrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0542168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=13ebFtv/4qAPGfooAMT0RJPJgOcgQGWdaXlec6q4D7Y=; b=vcAJ6qn3PSoeK41aiG2RXxF70
	oYQ369/4svmj9HPUlq9o5VLBjG4Si7a16pFlxum36u7TnqFXKefGKnJqjMOR1gJ4sk6b9+n5VB2Vl
	j8Scshl/eH9SVKHk3GagtDlABKV2CD2KFjmT4eURii1kCZM8plzUmG12qNZmLmrBbH2yshxHAlga0
	TGkk1prEyI0lGNp4LzbTdSkVFjhFXtx3xBl57/ySzpViUIKYcdAAOTVNO5B8BI84J11/3uxLHt8pz
	1J6ezQUKrNltAOwbGscZeTRRugtNu24GD4X4l2kIefPXFckVoaRSY2EromQNEMm6uRyr84fuZxPGT
	EmDVBelVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjySt-0005tp-27; Tue, 01 Dec 2020 05:44:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjySq-0005tP-1T
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 05:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606801793; x=1638337793;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=INg4bDOSzrG++0IVKgsJiIm+GvygEsoscYQuYSgQb+0=;
 b=AWdjNS4S244Ekw3kRvRW2ZCuq7Jhh+1V0APTYxSwpwn6utvZEYSZ0lXA
 nmlcXowM9/h31THN31lU+5zW/JYAEG6EqMQsNtfq2Pqm73KHoxUKBqPkk
 jEW3flFkDHLTeczUHlVVQFF/UGaEXHFRT5n3FGyuFRT2/IZJg3qOw46uz
 DTIzuF1N5vGVhtTdTWOcGgDmj0dwX/tJ3bJzkZ66g+nv3pf4G3sE8acGn
 Js5CUNHGVwnCF7EMlPwJ3UMYGLddJnymjNBO7LI9wBx+Ti0Jk+LoVA8/K
 iCtTGRIEo/dtQ8Bc9sQX7np6SLtF3R2/fUW3t83YyB2yPmyvPSYT9MVVa g==;
IronPort-SDR: LZ4LEfz+xE8LO7i1CTelToBZlTvhw5fFbEIGuFUDn73FVOjN42Ok9Mu+tm3daMVbsziHAWcfJL
 HwBTVMWISZmR+CDOmJuBCgxNH1bLjZTC0vOAKnk43xDHfQ5ZqFhFYgAXfPWtV4G87CJ5osvcXt
 VqPetiaIY22FhRYh51mGWBrMXf5bnYJMCPibHTi2wklq1cjVg0XBa6h1Jmap9IZG6esllB5pdM
 +xpQ/FJMNRwGFu33TO/0cFKBWHemvNzrTGr6GV1afrl2LuijciMBEcDVjyjwm+OiCNAJ+5blEm
 vSs=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="257565194"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 13:49:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dswEgEi5p9U9ocR5UQgp/yP1Nh5sThtcReDzqMP0F6YuYW9QmCHVa1hgJfOgSDj8M2Tuh9YdImTUtFqHU+7Fo6l+dB+nKK17FxwCBYkOG2ty4tva79h8nRMwfavNgavd/LdBUR39YeEbECYzKoIZFD4NaaesKuIYODD029h6o1azM6h8dUzSBNfzd39IKzueERwIQX2ZZVtJkrOIYWnDsvtPkwPY+wc5EvEynOYVEhmMa/JVK7zo9f04Xb0XLEU1DJ6LEmk7//DeqwxxpW90OkugRRsc6IWwWoY9ebySZ9wzkc2NK2bdFCPP2t2DzRCFxhJkTs4TQz+1HrH4MH700A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEREm6/G4ovBRc25uwuDBwpY606wS+kKKe8eerZs1r4=;
 b=JfRK9KexXhdLmF8gAeScsBfbOaQI7Tj+d4CMayIe41mlUep3NIFiOZEIuCbZEEbd42tFwuNWiJzmK3R5MSBvuSNsPBQKkOWG/SmufhrrUTcEIl/4CJSFJmyujctd2Wj1PIn4svNEVSO5pmXRNMXByw6E8w3kbm9gzVbrzToCLxOA5R6Aow1LRUGKzXgVamdCKJutyDR5kMcNu7Hbhsb8oCbERJQFP0K3MSF0ghV7XGQ/lIUZnStgCABk3KQZCBrt3w15U5AKZ3rLPhpfNrNNvPAZZAd2vVjwAzC02iHyX6xsKe00YgrUYJnWAPPKgHm/g0bDi7B8Y5iny5xMPikgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEREm6/G4ovBRc25uwuDBwpY606wS+kKKe8eerZs1r4=;
 b=N36KLJrODq5jfrL5clujW9zTQryJI1YP5LCp60aN7QWBotyXP5TVl9l40h8KaRg8zLYuPXAVH3gUegme9+mpZhkVWagW13JLpVgc0igO62DRBvbNelp5WQRacgzpKAyTopp9iDaGyOGHDW4Ch76syLNASM1DJd7RU6H3uT4dj3k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6885.namprd04.prod.outlook.com (2603:10b6:610:92::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 05:44:31 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 05:44:30 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIQyfbJcgpJ0mkN6+CY3xyrg==
Date: Tue, 1 Dec 2020 05:44:30 +0000
Message-ID: <CH2PR04MB6522A475CD3F0F4D123E913BE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652237C06F44FF3C9B6DDD11E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49654A4ECB46346E8445D8AA86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5865e20-f2a8-4299-8635-08d895bc2cbb
x-ms-traffictypediagnostic: CH2PR04MB6885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB688553B6A623AF829F0CEE9FE7F40@CH2PR04MB6885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGvprKV0DawBnhwdltlw07LbLL35e7H7XidICGuRJL0s6yY7wceNBbkFEc3mUtOlyXfFBAkUXenTLZhER8Z0GRQiYtr4Y3SBclxmFlmYIvrfCcQA75KAz7Yr7C2UeiWisIjt/HkZyR+NUTQCN88iiUiD64WJqccr6fiDpOONG6D8outM69LRPDLjUbqvE0ckn3tPGi0ui6j77UkcpVx4yBfuE2IE9xSffTVbCuSa0rSX96Yb4uZCYHYAVwvm6Ap0BzWG55ArWHmjXiYkRFNBEczTtV41X0aHrzMJC2sa8c3R9NQxzp00ZlS/nOQHIxBbK4TjVc8eHx+8+DE7WKeKMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(55016002)(9686003)(76116006)(30864003)(83380400001)(53546011)(8936002)(6506007)(7696005)(66946007)(52536014)(64756008)(66556008)(478600001)(66446008)(66476007)(4326008)(91956017)(5660300002)(2906002)(33656002)(86362001)(71200400001)(8676002)(26005)(316002)(186003)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EooiXuBt+qmLqW0diETtCdQnZsY2DC7dFbRtjNGEx0f0rQUnCka8gy1cZgbJ?=
 =?us-ascii?Q?rdsVATblkY1YdB7MLrswujcpL5jUdiWBfhrs24HXkFOw5SqS28MRXpGqJoGM?=
 =?us-ascii?Q?EVPChFDs0JMaQVmgZCVKut5vanpm+KE7jWo8eU/rvkHiCrdMWIm7KWgnIbrx?=
 =?us-ascii?Q?NFampWkWhRtIJ+8OUTuPOjI8ezN3JbY2N8TqtyNskM5QEaSv2FOCQYlen6+G?=
 =?us-ascii?Q?5VPZshIsiAAawqD4a1dxc4Ov3uVfJfVMDNJEY0MXoleDdkYxccEAGI0O+5HQ?=
 =?us-ascii?Q?0PC70hA559G7sNFzYrAh+NfuikfXJMHVjaJdswlUXaz9mMgt/yje/TDUSdCA?=
 =?us-ascii?Q?tI902x+Pgkub1xCQM6oyKL6ehuBFahmMSf2ACkB9Kp6+R7g6+frbbkrHuW6q?=
 =?us-ascii?Q?P86PkMyYqJrdSj+WrM1Jcq8CeXrbXNlDh7LdDpq76htU7I+0zk1ssdvJOgG7?=
 =?us-ascii?Q?Uuoh3Sx+H1FxBrjiglbb+N2LQNF5/UA31x51ntKUghiYfsys4YZhnRpIx/au?=
 =?us-ascii?Q?OU9hMWjV9fPbq9/tR8jfv6/hTg1GqjLei/yDlAwmEokz1EHzVc9OU/jQZ0gA?=
 =?us-ascii?Q?R1ydpx34KLHSrKxGbPqiccGH8H/+IAc75qd7uVSdonNG5oQEtfBPGlmB+y9C?=
 =?us-ascii?Q?CznDflh/KrmNxxN5eGpBGL6229chZ3bmfRcWsAUEvQMW74UHeuUO2vaR8OY+?=
 =?us-ascii?Q?9iIr8qE3bO2OjNdtLFQph22XUzzfe534fOwUzs0nynBpq5C1NIJ/MfI7kFi5?=
 =?us-ascii?Q?3/wYJaeLqqP7w4LXU9t0YZEzJOT2F9cOiT9V15VuQRvT03Y1OXr0tQl08NH8?=
 =?us-ascii?Q?lKwHwvhW06mGI1WTzAdFQ8jWCWypMcrWbknAUzvD5GtXSFdEvTOAbrWCCS3Y?=
 =?us-ascii?Q?7nW/bEGcjntXNAbKbni7h6IFshz//4zGCBUtuHcIBIum1EEdhOSNC0f2pH51?=
 =?us-ascii?Q?nVlEzfEOpqpPFbLPP2Vf0QamIJwZqp7wetb3gXlHK/dtLrb5XYXJXa+v03tl?=
 =?us-ascii?Q?Id64?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5865e20-f2a8-4299-8635-08d895bc2cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 05:44:30.8478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQ6gu6KJVTMNVVAuWQ7VrdfIRyHpRVDjhxtJRJYSoboeoivAoe4sLBnkHI6BkPsCfdiZTsbzFlMm0hrMFNP6bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6885
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_004436_384018_71FD32E8 
X-CRM114-Status: GOOD (  19.45  )
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

On 2020/12/01 12:38, Chaitanya Kulkarni wrote:
[...]
>>> +	 * namespaces.
>>> +	 */
>>> +	min_zasl = ns->zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
>>> +
>>> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {
>>> +		struct request_queue *iq = ins->bdev->bd_disk->queue;
>>> +		unsigned int imax_za_sects = queue_max_zone_append_sectors(iq);
>>> +		u8 izasl = nvmet_zasl(imax_za_sects);
>>> +
>>> +		if (!bdev_is_zoned(ins->bdev))
>>> +			continue;
>>> +
>>> +		min_zasl = min_zasl > izasl ? izasl : min_zasl;
>>> +	}
>>> +
>>> +	ns->subsys->id_ctrl_zns.zasl = min_t(u8, min_zasl, bio_max_zasl);
>> I do not understand what bio_max_zasl is used for here, as it does not represent
>> anything related to the zoned namespaces backends.
> If we don't consider the bio max zasl then we will get the request more than
> one bio can handle for zone append and will lead to bio split whichneeds to
> be avoided.

Why ? zasl comes from the target backend max zone append sectors, which we
already know is OK and does not lead to BIO splitting for zone append. So why do
you need an extra verification against that bio_max_zasl ?

>>> +}> +
>>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>>> +{
>>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
>>> +		pr_err("block devices with conventional zones are not supported.");
>>> +		return false;
>>> +	}
>> It may be better to move this test in nvmet_bdev_validate_zns_zones(), so that
>> all backend zone configuration checks are together.
> Okay.
>>> +
>>> +	if (!nvmet_bdev_validate_zns_zones(ns))
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
>>> +	 * to the device physical block size. So use this value as the logical
>>> +	 * block size to avoid errors.
>>> +	 */
>>> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
>>> +
>>> +	nvmet_zns_update_zasl(ns);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +/*
>>> + * ZNS related Admin and I/O command handlers.
>>> + */
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>> +{
>>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>> +	struct nvme_id_ctrl_zns *id;
>>> +	u16 status = 0;
>>> +	u8 mdts;
>>> +
>>> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
>>> +	if (!id) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Even though this function sets Zone Append Size Limit to 0,
>>> +	 * the 0 value here indicates that the maximum data transfer size for
>>> +	 * the Zone Append command is indicated by the ctrl
>>> +	 * Maximum Data Transfer Size (MDTS).
>>> +	 */
>> I do not understand this comment. It does not really exactly match what the code
>> below is doing.
> Let me fix the code and the comment in next version.
>>> +
>>> +	mdts = ctrl->ops->get_mdts ? ctrl->ops->get_mdts(ctrl) : 0;
>>> +
>>> +	id->zasl = min_t(u8, mdts, req->sq->ctrl->subsys->id_ctrl_zns.zasl);
>>> +
>>> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>>> +
>>> +	kfree(id);
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>> +{
>>> +	struct nvme_id_ns_zns *id_zns;
>>> +	u16 status = 0;
>>> +	u64 zsze;
>>> +
>>> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
>>> +	if (!id_zns) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
>>> +	if (!req->ns) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto done;
>>> +	}
>>> +
>>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {
>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto done;
>>> +	}
>>> +
>>> +	nvmet_ns_revalidate(req->ns);
>>> +	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
>>> +					req->ns->blksize_shift;
>>> +	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
>>> +	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
>>> +	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
>>> +
>>> +done:
>>> +	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
>>> +	kfree(id_zns);
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +struct nvmet_report_zone_data {
>>> +	struct nvmet_ns *ns;
>>> +	struct nvme_zone_report *rz;
>>> +};
>>> +
>>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int idx,
>>> +				     void *data)
>>> +{
>>> +	struct nvmet_report_zone_data *report_zone_data = data;
>>> +	struct nvme_zone_descriptor *entries = report_zone_data->rz->entries;
>>> +	struct nvmet_ns *ns = report_zone_data->ns;
>>> +
>>> +	entries[idx].zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
>>> +	entries[idx].zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
>>> +	entries[idx].wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
>>> +	entries[idx].za = z->reset ? 1 << 2 : 0;
>>> +	entries[idx].zt = z->type;
>>> +	entries[idx].zs = z->cond << 4;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>> size_t ?
> Yes.
>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(zmr->slba));
>>> +	unsigned int nr_zones = bufsize / nvmet_zones_to_desc_size(1);
>> I think this is wrong since nvmet_zones_to_desc_size includes sizeof(struct
>> nvme_zone_report). I think what you want here is:
>>
>> nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>> 	sizeof(struct nvme_zone_descriptor);
>>
>> And then you can get rid of nvmet_zones_to_desc_size();
> Yes, it doesn't need nvmet_zones_to_desc_size() anymore from v1.
>>> +	int reported_zones;Maybe there is better way.
>>> +	u16 status;
>>> +
>>> +	status = nvmet_bdev_zns_checks(req);
>>> +	if (status)
>>> +		goto out;
>>> +
>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>>> +	if (!data.rz) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nr_zones,
>>> +					     nvmet_bdev_report_zone_cb,
>>> +					     &data);
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
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>> +{
>>> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
>>> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
>>> +	enum req_opf op = REQ_OP_LAST;
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	sector_t sect;
>>> +	int ret;
>>> +
>>> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
>>> +
>>> +	switch (c->zsa) {
>>> +	case NVME_ZONE_OPEN:
>>> +		op = REQ_OP_ZONE_OPEN;
>>> +		break;
>>> +	case NVME_ZONE_CLOSE:
>>> +		op = REQ_OP_ZONE_CLOSE;
>>> +		break;
>>> +	case NVME_ZONE_FINISH:
>>> +		op = REQ_OP_ZONE_FINISH;
>>> +		break;
>>> +	case NVME_ZONE_RESET:
>>> +		if (c->select_all)
>>> +			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
>>> +		op = REQ_OP_ZONE_RESET;
>>> +		break;
>>> +	default:
>>> +		status = NVME_SC_INVALID_FIELD;
>>> +		goto out;
>>> +	}
>>> +
>>> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
>>> +	if (ret)
>>> +		status = NVME_SC_INTERNAL;
>>> +
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>> +{
>>> +	unsigned long bv_cnt = req->sg_cnt;
>>> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>>> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	size_t mapped_data_len = 0;
>>> +	int sg_cnt = req->sg_cnt;
>>> +	struct scatterlist *sg;
>>> +	struct iov_iter from;
>>> +	struct bio_vec *bvec;
>>> +	size_t mapped_cnt;
>>> +	struct bio *bio;
>>> +	int ret;
>>> +
>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>> +		return;
>>> +
>>> +	/*
>>> +	 * When setting the ctrl->zasl we consider the BIO_MAX_PAGES so that we
>>> +	 * don't have to split the bio, i.e. we shouldn't get
>>> +	 * sg_cnt > BIO_MAX_PAGES since zasl on the host will limit the I/Os
>>> +	 * with the size that considers the BIO_MAX_PAGES.
>>> +	 */
>> What ? Unclear... You advertize max zone append as ctrl->zasl = min(all ns max
>> zone append sectors). What does BIO_MAX_PAGES has to do with anything ?
> That is not true, ctrl->zasl is advertised
> min(min all ns max zone append sectors), bio_max_zasl) to avoid the
> splitting
> of the bio on the target side:-

We already know that zasl for each NS, given by the max zone append sector of
the backends, are already OK, regardless of BIO_MAX_PAGES (see below).

> 
> See nvmet_zns_update_zasl()
> 
> +	ns->subsys->id_ctrl_zns.zasl = min_t(u8, min_zasl, bio_max_zasl);
> 
> Without considering the bio_max_pages we may have to set the ctrl->zasl
> value
> thatis > bio_max_pages_zasl, then we'll get a request that is greater
> than what
> one bio can handle, that will lead to splitting the bios, which we want to
> avoid as per the comment in the V1.
> 
> Can you please explain what is wrong with this approach which regulates the
> zasl with all the possible namespaces zasl and bio_zasl?

For starter, with multi-page bvecs now, I am not sure BIO_MAX_PAGES makes any
sense anymore. Next, on the target side, the max zone append sectors limit for
each NS guarantee that a single BIO can be used without splitting needed. Taking
the min  of all of them will NOT remove that guarantee. Hence I think that
BIO_MAX_PAGES has nothing to do in the middle of all this.

> 
> May be there is better way?
>>> +	if (!req->sg_cnt)
>>> +		goto out;
>>> +
>>> +	if (WARN_ON(req->sg_cnt > BIO_MAX_PAGES)) {
>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
>>> +	if (!bvec) {
>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
>>> +		nvmet_file_init_bvec(bvec, sg);
>>> +		mapped_data_len += bvec[mapped_cnt].bv_len;
>>> +		sg_cnt--;
>>> +		if (mapped_cnt == bv_cnt)
>>> +			brhigh frequency I/O operationeak;
>>> +	}
>>> +
>>> +	if (WARN_ON(sg_cnt)) {
>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
>>> +
>>> +	bio = bio_alloc(GFP_KERNEL, bv_cnt);
>>> +	bio_set_dev(bio, nvmet_bdev(req));
>>> +	bio->bi_iter.bi_sector = sect;
>>> +	bio->bi_opf = op;
>> The op variable is used only here. It is not necessary.
> Yes.
>>> +
>>> +	ret =  __bio_iov_append_get_pages(bio, &from);
>> I still do not see why bio_iov_iter_get_pages() does not work here. Would you
>> care to explain please ?
>>
> The same reason pointed out by the Johannes. Instead of calling wrapper,
> call the underlaying core API, since we don't care about the rest of the
> generic code. This also avoids an extra function callfor zone-append
> fast path.

I am still not convinced that __bio_iov_append_get_pages() will do the right
thing as it lacks the loop that bio_iov_iter_get_pages() has.

>>> +	if (unlikely(ret)) {
>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>> +		bio_io_error(bio);
>>> +		goto bvec_free;
>>> +	}
>>> +
>>> +	ret = submit_bio_wait(bio);
>>> +	status = ret < 0 ? NVME_SC_INTERNAL : status;
>>> +	bio_put(bio);
>>> +
>>> +	sect += (mapped_data_len >> 9);
>>> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
>>> +
>>> +bvec_free:
>>> +	kfree(bvec);
>>> +
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +#else  /* CONFIG_BLK_DEV_ZONED */
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>> +{
>>> +}
>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
>>> +{
>>> +	return 0;
>>> +}
>>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
>>> +{
>>> +	return false;
>>> +}
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
>>> +{
>>> +}
>>> +#endif /* CONFIG_BLK_DEV_ZONED */
>>>
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

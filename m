Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A867C388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 20:34:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A5E20BED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 20:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPRx5X1P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qp2sX1+s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qeegH9r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A5E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=m6eRO0MlZeV5SbnpZmnUXbY7so+grHE//nOmguUbQAk=; b=jPRx5X1PTReKMZMTZRVwqcr5H
	3ie+JfGQMopoyWiVnI8Klafx7AdXfwbpnQ85ucOvvB3MLsukdpus6wFBqkJO5RNkc34LhYly/VVjN
	4p93uBJga/8p5pDd79Xm2221RFWXOOxFA+aWKIYlU2ygg4C25HQdVZgc8IgknTme9/1Bvmfq/3cUd
	0GgWaLNRiZQX3lPmdDqjFFb8ycVzEFHM98ovXauXS7R8lKcEJf7h1rmavReF9buollYizFJgiE42R
	RSZKfwjQ2AKcnp/Rt8CT05jO+KprVOuxibrIM8DSufA537Wvq4xhPlydMcBT6edLA++F1m8+1DlxO
	zlE5aVrCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW3m0-0007Ci-79; Fri, 23 Oct 2020 20:34:52 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW3lx-0007CI-LT
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 20:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603485289; x=1635021289;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=iTl+Q0JxmkXKqwv6m/oHET+0gRwiJehx/59PIvNYfXs=;
 b=qp2sX1+sazq64PEJkFDBPDYeHpG/zclDtJfGdAfhb+XHjq3ccAW9ZtlP
 eeDZSY+PgdpbEbP9ADUPoE3QguCgQghJRU3V81w3ykVJyDm9DSCI1Q2Rv
 MouNoAum9PBGqGbWvZjG5gQ9L3FIuto6ZEgVimITLGffOD5kf8XZcmlJh
 Ln/8L0h0ce+HCGCraPmk9dYO99HNPUD/dXb4oLaGg/htG4Gg7ftq3fVWa
 tc3yje+aXDtF6RBD+s9gmwHeAYjMA9Vjr0Dr6JstRXLt+O+Q3LGVBRzPR
 zZFjRtfV2gXL7Q5+4sa7sB3kkNjW1HwxqfSBTQEpv6qVluFNSGGsVNBHX g==;
IronPort-SDR: EAVv8XlzGe6ujaYPNBXPmoJu7+JiV6HjvyAKYE87vF6J/cDNcN/pPD+QK66MPii9Bftty9B8IU
 AkeH7/SxUXZGhv64RcP5qKV/y5e3WmUUdI1f0MTeFNttYSPLRGJ/2DiLhH3+k6suyVvt7GTfEi
 3J6HLh9e6Q+j96G3wNibP8Ye5rsxtfMYTlr9NN+5vZidfVpgJFLV657XQm5DIzF9chkPztsAOy
 pWkCrLif4Q688YgZQWil+Vg9E/wt6Mayd+BBFalOB0i9Huce3wwj04BnV2ggud66xOR0WXVrqC
 HJ0=
X-IronPort-AV: E=Sophos;i="5.77,409,1596470400"; d="scan'208";a="260658180"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2020 04:34:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5aN8qF4HREediCr/RW7TAC4ToptKcSvrvFSJakuiYwJZkY1KSPUjYeggAAxGa+ZdcP/nQTW5ok9FJ/zHbsU3CMwWxk7nJFRbTgwqBkelYrNyFdr/FsZuo0TLOto2wB8bDZnsfNA6Fx/aNA/7rX4Hi8dVKzw9aal19R3Qx12qAl06ZOK1QLsbEJNcxSm9lZMYsPFMnCjaP3cP2I+dngKMd1NQM3+7gc/eSBzDoAthD6PWzNxUCfl130WGZm2RzLtxJkFSJIUt1/oqUN3yIaRerYOk56l6PLtsQgHj0BjpYFBMoJzniMOz3FSJM5rRk0MUsVz3pNbFyAkvguL//lcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTl+Q0JxmkXKqwv6m/oHET+0gRwiJehx/59PIvNYfXs=;
 b=NE9rJ1tKMpZno/zuNIIhHOIagmExLDK10bGVoQWQKF5VWJ300GZ/3N2CDTYOJ5qc8q4d5NeOft9tm9vhNhdKNQwv8t5S/yOPiiN1UuDfJ8MqtvOsla6beIuQLW9VGtdZj7ExvZDDxuguWcOO06qErpxzQHORiEpuqkfrQrBCWf1qSV2kel6/VTtlByLoL/E58REzaZT1kGYX+SuI7xRLYo0I06FQUhgNnvhoSz9MbPNlFmiFoD9rqBQMm66ypIvMfO0ccb0MLePWhjNc/+3aOgpAei9a+blP/YFU0VZDT9z9UVvaDnHFHEuA8qj0yxidsGh+WoKbcLc/ScT1z0d0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTl+Q0JxmkXKqwv6m/oHET+0gRwiJehx/59PIvNYfXs=;
 b=qeegH9r2zZErprOVx/E8lnkUQ8J0dZeBuhmyiJyDq7+zbs5scXj5QUUbgxsQUWeGx2BcelxJJ29lwLlO5Lw6/0D7brg2TwnRM+7dczAVmfA7EHq5zFsFiLXWZN4G7nq/wVGRZXwmpyqQpiA5ZJED6ynBcG7Pc0lVFqNjYHPojOQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 23 Oct
 2020 20:34:46 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 20:34:46 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: ignore zone validate errors on subsequent scans
Thread-Topic: [PATCH] nvme: ignore zone validate errors on subsequent scans
Thread-Index: AQHWqXHq3lpqqQfJ2UuoFDZapX2qHw==
Date: Fri, 23 Oct 2020 20:34:46 +0000
Message-ID: <BYAPR04MB4965696830CA41FFF35D2139861A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201023191628.1729393-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7c12c50-ba9a-4a16-0fe5-08d8779314b1
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB378183252E2A9E08516316E2861A0@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27+5aXB9O0vY7dZj4zu3NnxZn3at26XwWjOGBRXlxGX1y9n5WY7QHiIPOW6BpFnx1Q46DHusq7Z74Cuj0Wj4w9f396vy+byyVHek9vKuQAPNGJfT8MOcnlt3m/oItZ2b3tsjvyHvhwwUT3niE6lrFr6deQSXM5xIKumiFSOKXyGcFOFNAkifhaqsCCkgTmcFiyl6BcLv1XqKFHOqNaw0EEjSV7F6uiTpmPC+kyniJXDkFXX7I9ya51P7NhfiguoXebez9v8rBNmQqtwmC+KLvTk8Q4WwIoXYKv0EP4H+MAukaIxiXt8qxKulmx3SpueFSLj00hWYrQeXUEb3GFuMsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(6506007)(66446008)(7696005)(86362001)(4744005)(478600001)(53546011)(5660300002)(83380400001)(76116006)(26005)(66556008)(8676002)(186003)(110136005)(2906002)(64756008)(52536014)(8936002)(66476007)(316002)(66946007)(55016002)(33656002)(71200400001)(4326008)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: q8LYtb5nmuqH6mhDwgbZRQNv4onWGM6RM1mmpJ8rMiBnCnfVJFKRTa0K4Yopk8P/Q0tYnBptN+g/7d6zGOOZA72meQxDgaPs4Pkql6QFoyToOPwpVmagvgF+rd9ad7J4bDBMCVff2sAJepWnD5WuGgEvrB7LagFWpR5ehni9yOc0ZM5tiZ2epcJkrnEgeop1UdWFE31vY4bLU/I5fmKbbXL/AXB3RQAhhmuJF51AaKILPrrvlgOUh90MtaIKTyQKs7t1L+1TQ1FnhNHqy1TopEelD81+PIC/beTfsB1JuRx+vDGjuGAnZ+16gK7pvV1xD+yJRzXNxc1voIUeXTVoieJ81kM1+0GiW5gSvGhLciVpwlHINMUXAfK0nYPHxNdBrAC7SU8FjNHWUYcImmTdIKmfU0H2TZJWL97jQunDuijoRbf5PgwvmcNUHKTHQNfKonKlEciy247rk/msqMnNfu4e2xcQg9Ru3GX1g7Qw1PfLyrUXU3/fdjXzp+2eC1Ds6Iq+DIsiIW7B4yb4T38sq3BuyvHjFkS+6OvBkEmzAFZ1xJB6Z10HL/weOgfD7ZVzoYlDOSbcvWiRMgq7o0yUwd9+G9pFNSLpu9p0utz+z4rvYkAdCEuroFXFBp0sCTC9f66+SX/0OsniaaYgV+PeQg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c12c50-ba9a-4a16-0fe5-08d8779314b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 20:34:46.3061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jp8Ltjf8LpH78bdTmXWSBxJo1p2zD6v9Y/3KKsuB2Oy/HA1ztyBdlyITG2kxQIA1bL7FiuTkZAMcqsRzz5J9elYrx6k0XjmRcaCljGtu334=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_163449_951716_4EE44B97 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Michael Nguyen <Michael.Nguyen@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/23/20 12:22, Keith Busch wrote:
> Revalidating nvme zoned namespaces requires IO commands, and there are
> controller states that prevent IO. For example, a sanitize in progress
> is required to fail all IO, but we don't want to remove a namespace
> we've previously added just because the controller is in such a state.
> Suppress the error in this case.
>
> Reported-by: Michael Nguyen <michael.nguyen@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Yet another reason zone management commands should have been in the
> admin command set!

Agree, I've raised this question.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

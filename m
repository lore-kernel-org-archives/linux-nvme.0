Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CA5C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:58:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D422020720
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EPm7n0l7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MmDFLwn8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NJbd1c6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D422020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=UGSDBZcqc/mDLmVs4llEKB6lTco9LI4YNzBFUXO10Ok=; b=EPm7n0l7XGUVfpv0ZzhD4uLCz
	6Kv4ByrXJmhClz6qRXpqkyoMQOt/gLm1fgyCgrbjXgUqiM5t1SM3w9rp1klUaof4Pcp2V69fnbR1q
	u1/TW2fQRBunZ4+KikjbuM/tHOeqSK+ogpE7uzwLYlMWkVzXOcfY7loMFIThwsYT4V5aXLOsnHSCZ
	f/PFG4f/ui7L1AZeW6yf29hP57Mj7GOM7EPWy0jWETmuaS8sMiWGhPCcbCdoPg+4TvkzPA7QHvzz/
	IsY3EtnAa0QDDSdyoC4m0tK+zX5quWlbXbKNXdzwqLrsidDhs/k/wojMoxLycL/MEBGfQfzjgtBo0
	zgXER4NBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIKqE-0005Qw-NH; Tue, 15 Sep 2020 23:58:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIKqC-0005QY-6M
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 23:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600214309; x=1631750309;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kl4N1WO1Gfb3CpmEd21Y3f/x5WgaXi/bUzX3am7ema0=;
 b=MmDFLwn8x6bMTM+Lwqiv6ENENrnjFJg1bnI+OwhjFrvUcLRf5YEEKuO6
 9KfYShnBw4Hyon9vUGsfqWRx3SbbDwFiJ0BmlccERLM0nj+yWq+4fxigk
 1bs4a7arfwVhC4B6bUKS41A8V1OWGefCXAAhmo/4TbAzexFJLynUntZct
 8uKX5u7NpzC+vRBT/ReUug7uFco6JTJ2XoTEVkzm+WROgCRKvftcy2zt7
 GRFHz4udvB12mpdyUVW6T7v1Di8FbyENNyMPV+cDMWpKX8QcD/FtatiMF
 +QsnRPHn3EVDDxyudHhVbCc417LIHVpWlYgGhXs/b8a8uDNyp87m+kXWw w==;
IronPort-SDR: 5zMb8FBZ9DTZal0qm5tvERP2hCq2JmyCjK4+GYFlvVnE7I/PPPFx531cenU2x6zG4IdDIfltb5
 x1mShfTqtYIdGjrCHb445QxSDhJ2gVHQV2kp1i9W26MNsFPn02difAcDinb8LgdN3lAMNqtm0X
 BE4K1IgHGJZhdcPWPY3jGQH2FA8xGLa9gZWOjikoWKdDbocAi28iZfBryLBmLwimOJcqdACo2t
 0zhtTNNIIG4Jjy/rikOjrmrBfHfh0RYclpF30Zgo5zXdWmvLwlBoXTLvtQouTmYPa/XmM2WdE+
 yOs=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="250800943"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 07:58:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5tOORUnnfJlhEAihEVQtIYBa05hm2J+Q7MYTM1YfR+7ixVq0vxzriPWeVNxnYyR2G373H1xcNIWq+IqDNzUGsc56KdOF/uTizSYnPGYb1xapNi4MGA3TdaAIGKnBiYojVAeOKNyejkwzvyqfyEslvXjS8X8c3XfqAvxzpMd+He0RNekTxNzBSiQQ0NxMCF8+9njRMwkD/1jatfbCgqCWHpLPAPA1WEfSLRWI09WKFifCPUN279RBqBkYwjHo+W5XgXqk8N1hd209Tw5c+hgazIsPjzLoz5soe4XDYM44fHJTQ6w8rbZWV/P34uJduCu+NZg1vvjaM9NlqMa60Araw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl4N1WO1Gfb3CpmEd21Y3f/x5WgaXi/bUzX3am7ema0=;
 b=f21Vl6dqfr62beMor1JHeBTKc8RTHepizHA4ZIfwsx4ORJO3JJdSuZQdiiKctoSnL8/lpdGi9ttScB29E4RtCNalulmsN8le8uIwRqUVujHeycq20Uau8x9xjr7iiKhyFhfDllUt/wjfB8347YIlTlrYCf4gHtpdGs7UuWPjHjFFjJnVAvmHsawtneF8YKEhAEfb0BZq5UFy5uoUc9WsCeEeFA68cSfMG7x+xD2GNc7eSJyKaLOAr7lMkzxi/sXnjsHZOtcKpND5XcHtmNP6iq0HXdwDw9Ev8rBNvuk6W+jfCfUdYOalGcqP25J06u/TqxnytuTecG6ha8ItZVOaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl4N1WO1Gfb3CpmEd21Y3f/x5WgaXi/bUzX3am7ema0=;
 b=NJbd1c6qEvA5lN+OLfnM6sgXHX2/gb9E8LIwG4HTQJoQfiaCYBoq1lKpLgueSTWugAJWDCKx1JTH21Fgxbgx6XhEPBaW+Njx6Bb8abwt76rFF1nGlJi0aVVfjkzjN/9jNpfTEv2kzKL0mf4DCBxSNwLq6ZpHYxxsNs9BdGKIBUc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 23:58:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 23:58:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Topic: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Index: AQHWi7SiU+yGXE+Gyk6gjm+/HimNtA==
Date: Tue, 15 Sep 2020 23:58:24 +0000
Message-ID: <BYAPR04MB4965FC2976ACFAF04955AD5486200@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fd896e3-025e-4688-7f43-08d859d33b84
x-ms-traffictypediagnostic: BY5PR04MB6849:
x-microsoft-antispam-prvs: <BY5PR04MB68491943FE207C4281BE7A9186200@BY5PR04MB6849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p97p4IlnN8wzGOCkYzgI15ybtCgDzGbj7491vxM8D2WaxP1TStNOmHlV3+PCAJqvIgiWZa4gAb0C1/dk8L/1L4s78gmU1NrlPX6Yw7GjACXjx5Cn5mG3Mo8/fvRzsEmRoT7oS+iyjb5ZgzZjTl8FDSV1Uq/M0+a18JU4e5Y7kux+HDgX4atGK+YS5ly4guAz5MO0fon+Dh/VlHer/Ho/sEjn+5c9RhbJ4jhDJtT1JGcAZQ7srC+hLgBOWDtYVnmurZ+WA8EG8TsdrEHOHk6uEUj6t+tl8r36g1WPsbYsXMUDyNw9b0Pc8PTsgrACogQGpQ8Hf94YfE66ldyF2wKl+5zao8TPMbxbeMTh0ym9NSa9dDGsNRSbAlGaTW612Mms
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(53546011)(6506007)(316002)(71200400001)(186003)(9686003)(55016002)(8936002)(33656002)(478600001)(110136005)(86362001)(5660300002)(4326008)(4744005)(2906002)(8676002)(7696005)(66946007)(66556008)(66476007)(66446008)(26005)(52536014)(76116006)(83380400001)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YPsHXAC6VFADatGDawvHSPUxGcZNfedoVZN5nJmNcVkPOmL1280YCoR0ehVUsiUT4xl7lpTv0DEUHCebX+kQVhj90yP5Mu8zVsJ1uhFlL9HWKnFWEPuB+2w8JujJGw+9TwD7MWkvbL4JYEIYA2eyR5jMtwCX5cSLBg9Lz34iCgOxO0e5tQdqxrtmSCaWf66gMtsYfBvj70cCERFKFo2G+t2u9QyOg0PVXKun2NGjA3T0wTSWcTdeBSc3XM0/xg7i/C+1xpXIQvdUyKToeOuaxTNLldhehTy9kVHaxFT9hib0U1LdLdGaqpktpUd0XG2/MwzVaOG4LAHl9BZFj8VEr1GGHJIuLUdzgDsP+y4rUOmcz07vm35pEM59LEucWpMKPyti1z6eNgfRGicuU+Ea81zYAieA5rHaqayGPGpZCgzhWNESP0G/7htS9MlR+Don3I0z97LLPFx8H6nAZinYdhfyWsZln1JR9nzeIgiIJrHBr4XTsMk3Gm/YVwXTpSVB6xoatDDrRJIwkP3N3KeVCDkxzGDHBgvvmuY/ldG4m86s3eurb3gKLYq3124/XOB3hjKiJ96028G9wuz4EIWudje/Cye+WAqH7RXYv0E2K7/uUVrazbUGxm9qCr0i7VLJpyGj+RhkroQouKNxpnbKMw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd896e3-025e-4688-7f43-08d859d33b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 23:58:24.1997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEdmnNjhxzJXC/pqQjmeFuQFJvctt29/arTfQ/vK0pGGSySdmYnt72p7yCWxo3CZ8GJqBQoEmJZVasUhcuPMKW7uX6q7Il065coGi913sIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_195828_454222_BBBF5DCE 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/15/20 16:12, Sagi Grimberg wrote:
>> Update nvme-loop transport with NVMF_OPT_CTRL_LOSS_TMO in allowed ops.
>> Without this patch following command fails on my setup :-
>>
>> nvme_fabrics: invalid parameter 'ctrl_loss_tmo=%d'
> But loop doesn't do anything with this param, why should it
> accept it?
> 

I think latest nvme-cli code adds ctrl_loss_tmo by default, which wasn't 
the case earlier (correct me if I'm wrong). nvme-loop doesn't have 
allowed tmo opts which makes param check failure in host/fabrics.c when
creating a controller.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F9C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 05:09:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9025020652
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 05:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5pDPLwt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rqmPr/Y2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IJFMhmxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9025020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AlnLNhzr7x4YCKXXiqFAiDIRwUsNlAHt7pNHxoGPM9o=; b=m5pDPLwtbJSan7
	NbcjkfKjOSGUCjrGL+ru+MhddqCbQEXLNbXKty/TtCIW8QuZSujo0+RJHPouSgGTjuRNrBiaz3Hrz
	6hQWnJMxuVhGr2xDXzbYCRI7pbhKfmtN2JlsiqkxKsAMyJnjSIya3bMUADBZSs5icaO9ETctPbANg
	c2F0eTGY3N+abjoGbRrclGd1ZC8rUifj8nApE4TXoSBlMO/8U6o+h6ZDK4zd082cEKT9daSrrgWQe
	w6A/GXLxq3jKUXZb3R81nmyBjKHM+Uhvu6D2f0shpFf9EKV971rWG92ld+1caOzSvmADCivtHQs38
	AfsGvMSza0p1i0piznYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieuFZ-0000tt-2r; Wed, 11 Dec 2019 05:09:25 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieuFX-0000tK-4k
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 05:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576040963; x=1607576963;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=N/f5QsFECMGhChl0bqub1n+sWXp73aoQuap2lGaCLJA=;
 b=rqmPr/Y2hH1PH8spja8ulvz2LXeKHPa4+SCp1ccWp4hcY5oyZvv63sYd
 gfkNmdbxIDdK4e4k1IAVYHoGtrDzcK92P5zoMiUqHCh0QCTuWA81jtI85
 HHXwc1JcHff5sIDWKewQmZToHwAo1do3DFRqErT6efoObQz7FudQF0n1B
 hxt59zhJ8mvygZTzbUJ9El77kXlXJiZODhna4ULOnlu07XIU0Uc47QPSp
 YI0Sp1MtK3zdj6VbNBjxG+8pzMt1bKr2kQCCD3Sv8MJnnI2590lH/EELi
 6BzfcsB0BPvVeZVyBXxGPZPu1jJhGb54kXW0pXyOWUPctHGxZShHj3XtX A==;
IronPort-SDR: Zy1D7Oa5hcW11UnbfWMm2YlsoQYGG8lUVO3Mo3Lb7hPb8xMfFjUfPIpikF6qeayXWUJsrVhlkm
 9yeL9Wz/bnc+Lkh40x7pdVPgLjz3W0MaTvi1Vrb1NKLpPYJz9xNUydak/RFdzGJFIN9/0i8qEa
 db8LC4rGqjYpE9vicMpRvx+gyBMUzjKnM3hKDwV0WB+7TYzLeAFYSW7F6wEJRmUJKBvTC4Ai04
 TBp7gChvvdTAuD+pTAmCZtEUMvvIW4bxIH/61Nd8cA+m6ybrL1renBTtvylXX/dVWlr0BQu/Ph
 YJA=
X-IronPort-AV: E=Sophos;i="5.69,301,1571673600"; d="scan'208";a="125062567"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
 by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2019 13:09:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjdDpk2jx/+K4xnrg020ul3g8S3m8oN3eXu0OQfBU3RdEgYfBwY96SSUnJwTUHN3dYYe5+C7ZDiGOtPGAFx+lMcG99vsxyZs59DRuFA66KQwWt6PzTFFTDQ9nEOGzAlfE2CnIhszNHxDZsurI2ktm20bOJaPkcIpXH3NjafPFIGsh7m0QAe6wOM86VzV0ikag3ZSd0pebYdtvICpBqXqsTPhZ5Qw37nkt1MX20B0YyVZ5EYuFWIsuCJ07vQF/vr0IXaPGRiNky5wySYS2QdySUhs4U0ryVcMuGbJGxhZCiU8TYj9+gY/ykvrglMpKTkwrhxiLFTvx1zl2HRntbH9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y54cLsHI7Pfc4+Q+w33tJ+LYeELiJSNIkIeRi9W6TgI=;
 b=XOc3a+QkKYQcg/kB+kjoSuXXAadsQF9KkJTMdRASYLrznjTOzjsZKXAw+Al+NG1qzGoGXtHAi/N8Qx2pXAj+4sfcZhB4aOCJKRyb/grjDJ4UGqaUT72d/LnbCJmjjENeyWJXhxB15cia0l2TmY7Q2xkW7hIAAbZzZci9DTYgUrFCoGF1lj30oeuMqt5arWXVsmmBQ7aQrPUCPfs9pQ8rvatRPsrW0pwROsKa/REYOIzZekreK6KVoxZ6PDuMNMVxjN3jQ42iRKn0rRwVCaq2DniC+nfQdc2ZOt+XHplD8tekIU6Hv0BmO4zkTgJOgh8gyxIv1+6rgnxC+ARBPMy73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y54cLsHI7Pfc4+Q+w33tJ+LYeELiJSNIkIeRi9W6TgI=;
 b=IJFMhmxXUiPur6wK/2CISvlYVgW6jD0FyIXKwctf3cNoz75B4cw2LnJenIy8dEL5C30m0bPEL9H6UoFXgMMAbe+KL3xmN00449s27rROSovCDxbxJ49EInKThEQvvl127H/7d8YondOKNYyQQlJGtx+BBh0GZYfMW06srt7z3YI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4005.namprd04.prod.outlook.com (52.135.213.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Wed, 11 Dec 2019 05:09:15 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 05:09:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: fix per feat data len for get_feature
Thread-Topic: [PATCH] nvmet: fix per feat data len for get_feature
Thread-Index: AQHVryqMQEjO/f6grECmz3bFWU3J0A==
Date: Wed, 11 Dec 2019 05:09:15 +0000
Message-ID: <BYAPR04MB574989BD16D14AD27C63C649865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191210072201.9631-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5b67f26-8b36-4943-3fab-08d77df844ed
x-ms-traffictypediagnostic: BYAPR04MB4005:
x-microsoft-antispam-prvs: <BYAPR04MB4005E53F8B77C1C7EF6A6F77865A0@BYAPR04MB4005.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(5660300002)(66946007)(66446008)(8676002)(81166006)(4744005)(478600001)(55016002)(316002)(26005)(8936002)(64756008)(9686003)(76116006)(4326008)(6916009)(66476007)(54906003)(33656002)(53546011)(86362001)(52536014)(186003)(81156014)(71200400001)(7696005)(6506007)(2906002)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4005;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A89b+hbIzZ62B8u+nJ4/VE/46qz3PAqcfIQZEHRSJdzxj84cds02MIUw4HbOD+ia5ACKOID39Z7i3wgZioC65fRy8y+aXYAdlmC7C4Ps2rtbj6F1GBvae1D+UU4mHMy970zuY3dP5/UYvaugQPNFVnXKpazqJrgSSepp7DLb6RBBffOEBst75EfzhX1Cxok5MYJ2ls7t+Eq6FvVwYC8VBD5wYglu+piduHAFmRbDZjZveW6GZMvAQubZoPMWd5+5MWgSoCDPsVSkxK7lhk09+gWQc4BEPGKqHxk+Y64iPcRvqEkB54Q4DjhYDbXzQbGWETb5gjxSbqkOJLRUj0EyHTrB93BuY8EtHwafGrPITOOlkbw1THYsuClFFW1eP9F5fhFrlTC0t95rXy8ui1sK1zOu1LLQ+cicpvg6wINQM8DqX/tq+nvsPom+feJFagEk
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b67f26-8b36-4943-3fab-08d77df844ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 05:09:15.6755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WB/NPWxx8CvIvQA/2WT22EBRvJ904jQRja6QwTVhm0aXwOafAg3UOjYh73EK3dbTl8x3klXt5kxXeIbnI9kRv3eGXrJHOMoR+cTspJxJvDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4005
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_210923_281782_802165EA 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: "hch@lst.de" <hch@lst.de>, "Amit.Engel@Dell.com" <Amit.Engel@Dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/09/2019 11:22 PM, Chaitanya Kulkarni wrote:
> From: Amit Engel <amit.engel@dell.com>
>
> From: Amit Engel <amit.engel@dell.com>
>
Seems like original author is added twice in this patch.

Should I send a separate patch to remove that ?

> The existing implementation for the get_feature admin-cmd does not
> use per-feature data len. This patch introduces a new helper function
> nvmet_feat_data_len(), which is used to calculate per feature data len.
> Right now we only set data len for fid 0x81 (NVME_FEAT_HOST_ID).
>
> Fixes: commit e9061c397839 ("nvmet: Remove the data_len field from the nvmet_req struct")
>
> Signed-off-by: Amit Engel <amit.engel@dell.com>
> [chaitanya.kulkarni@wdc.com:
>   1. Don't re-calculate cdw10 nvmet_get_feature(), that also fixes the
>      endianness.
>   3. Rename nvmet_feature_data_len() -> nvmet_feat_data_len().
>   4. Get rid of the extra variable feature in nvmet_feat_data_len().
>   5. Mark nvmet_feat_data_len() staic since we are the only user.
>   6. Kernel patch style fixes.
> ]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

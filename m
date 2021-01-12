Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC591C43381
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 09:03:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8291922CE3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 09:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8291922CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7Ea3vBI6ua3strJs6zIxMJIBjc6LECbIGfAuUuXl2Cw=; b=AVa3zrVWTTiDdA9W743jEieGi
	Og51y7bEEJWj1acSNW2twxwLKj05VehSjqO1GYOh41j901KqSa34SkWqSHud+yLCHXS0qZIqvzcqt
	ubHRPtToI4acqRjAD3SdWiY7yBd6hfN2XGFKi/Ehzsdm7h9i4G2xCf7oBiOJN7qceP/48ilN6Ixti
	JjRg9eX2RYtrHXuwYDXtl5mp5qBt6J9losc37OfDjHW6WOySk7Ttl8kyNRt6zyQQN6bf3bf0HKm6z
	hX3FjZbhrfVbu7N3Hq04g49JPhATnRz6CMljwFH0DnOM/fCfn+cXXv4ZMZq4OjeNJYhLBmWyQldpV
	3r/Ng6SgQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzFZu-0007SL-GK; Tue, 12 Jan 2021 09:03:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzFZp-0007Qp-Ra
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 09:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610442847; x=1641978847;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UZCvIMNrsbT+2f/dKG1nXK7CfOGvI5kMecAkj5p1ARE=;
 b=EP8I+I6Svi+jthEMVGeeMxJOnOW5UjOsTtwU6deGhzkiSBB7FmP7aaWp
 EZIZG19nYRMZaIlUX3e8U16ygi86EygeFymH17T64+nMHyQAS1X2e/QOL
 YHNA/LVUlT1R+GKSgflkXtsEsSAlp4oG9wqWKGwXoiBsMZjxw7K2qGw3z
 jeFjwxGaKQpYBf3bPXgB3JPlzO0hcYzF4tehxA04c0egT5EeZS48Z1dIn
 9Kt4kKg8E8ziAiHhaIQqFOHPEM2oGP2Wtx0q+RbE8Ltn3lc2/MroytDcz
 icCDE39yvxa8JA4Y9C0unzUBMl8wgFnFhLSJQCG73fBal4KcK4Q2NR90N w==;
IronPort-SDR: Z+KivkyC5NplztvattM0YBo/7OUyQFTiYyk1V+TYCuRSZaXLbuln8PjwCFSddzCRtk40RxFXP+
 7DJkiL1+euky6YGmiqxQ+VolkTFcPtgGKklawXBbo4bHNplNYX4ic2vX4u1J5tZ9aZTLP5f3Ih
 iknkBHq9lybUP6r4YeG+SovnU8HLGuLL8ilK4wkXmQwgFYXLtDEZbB2uQogIt7X/WLvDY+Cpq4
 ttkfbU5PV2Zs2hNW3coMzPa177bAlg8h6cv3YDiE3g9f6gDheLGIUWuOJOkTvlgnnbnuig9HEL
 I38=
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; d="scan'208";a="261121570"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 17:14:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbEvg9xLwV9Sh7NmzfBmjkbq6YL4juJiKDSPlvO2J2/uzM7cf6pH8dtq5vV1X9wCCG8J3e6FLq8cKNGkTUzK7WJ2R/7ovN1Oelog5V6OPeOsn1FoDblKucojtNc134zJMr+mTplmZthAiTWu9nXdyG57FPj5maIEs35MDaDE1QS/1iFtoIYuTe2R60CkpQ6+RDO86bTD4h76l7BTpChQ0QJhLWtNQCuVyFEkgYEMHTm4kSJOVShbJBPPPz09QozYUcxgzwd6LCCatktbj7OcSdQE/Fttiwup37yCh5hZFAFwu1Hb9J5GR5Bdc3r1QQ2SbF15driWgKDTURLrdX6PtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZCvIMNrsbT+2f/dKG1nXK7CfOGvI5kMecAkj5p1ARE=;
 b=M7Y/k/tGrIYl8fR4Xd+jYZ3CPD68ERRnfM3CqkycyUQwpazbDzFI17XhRYyH73iQSKa5ZVQfQrrL4QrYDsDIOg141NTXmLOxHuzRVaJbZtXxixWMYsN7tngeeMZzt1+7OdWCS/ZDaWjOxTEjZzBnXLVjI/DEdSjNStRnM9h7SjxcvJxfUsGq0E7jVWgdgGyBlZcGUJysRFCB3lQkfhNaHQ1WQW0VLFnvGkwQgh9gEc00kdx+z/AcrDbFd1bg3zODY20IRSkabC+Be/wjhVBbpWdlKyVgCd3MqNu426XZIK8ml5eep7W0Tgd79cpupQACJG7rH6fRpN37NIhVFUwwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZCvIMNrsbT+2f/dKG1nXK7CfOGvI5kMecAkj5p1ARE=;
 b=b55SSDifSahCqwlp8pZK+Btvvcd84F3QiVKrruGxpxqxo5EJ8uJnpX6WkX9pN9FyRELbyBrzNvkNbiPd7Rb3b1OC3J86Nh1ZPOC4qTdjFgmaueyr+FaGIWvksTEe3CtBfTsLZvP6/RP2Zo4OoFwAhEWktogypIVbwBsMmAN2uIA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5591.namprd04.prod.outlook.com (2603:10b6:a03:101::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Tue, 12 Jan
 2021 09:02:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 09:02:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 4/4] nvmet: set right status on error in id-ns handler
Thread-Topic: [PATCH V2 4/4] nvmet: set right status on error in id-ns handler
Thread-Index: AQHW4lVydalzEkiMDUayveljJ+g5qQ==
Date: Tue, 12 Jan 2021 09:02:53 +0000
Message-ID: <BYAPR04MB4965C9A4E18F0C1968DC9D4286AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
 <20210104045203.24472-5-chaitanya.kulkarni@wdc.com>
 <20210112073003.GA24211@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:8899:4b5d:3a87:ab2c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 341ddb63-7e5d-4175-93d4-08d8b6d8d89b
x-ms-traffictypediagnostic: BYAPR04MB5591:
x-microsoft-antispam-prvs: <BYAPR04MB5591DBAC8F6B6509EBB75C8886AA0@BYAPR04MB5591.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ed8Mb8zVlvBEexpNxEKCl3xHEpvR0bMgOvcglrWNsHX78LUvH4vUvyLYMy3g+IIYM+6Tcu0wcoS9hGk8EkhIL52lhSaPaPVB2HvbTLXAPEYi5lOiGUWo843mf7gVRchvzgLYmVKf9uLZ57l3kWi1eyN37oSCgbPH5jBn1Rbre5ySRKd7TJoEPGUPU/ciZHhG0aVz0FmqfAbC3tpOkc+u04UIeRT3WfnCX+TaH+AOtrHGixjc9Kl0ohE7f2E3FOMZ38ikv8PdvNtX4RcjaR1gtU1miaDMztSk4xS/Rq+zkzjWYekPc2kyWIiwYb67303PampLaizJur24gDVT9txv/pM/nGRPtbejhz50WtQpKjrUPHHWiU9xnBiW/VF/dM9/ntTp7jnB8MXdXlOxZh6g3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(6916009)(4326008)(186003)(33656002)(66946007)(52536014)(66476007)(8936002)(76116006)(7696005)(9686003)(86362001)(54906003)(316002)(5660300002)(6506007)(83380400001)(53546011)(66446008)(55016002)(2906002)(478600001)(64756008)(8676002)(71200400001)(66556008)(558084003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n+2gho65HyZCAHVEudmM0p7n9QrtV1R6POmM1hW6VdL2KYLzsxcwUuzQsuuu?=
 =?us-ascii?Q?N0UEQn36uIdbprh6Cov+d4oEId2nCRqV7A+a/d4q5nhQqUIOBSrKAFsrn7y0?=
 =?us-ascii?Q?u/OFVdkGRRkVAowlwAG9fm1kmeu/41UNZkaIyYXz2ahV3AHkINFjs22QhcEa?=
 =?us-ascii?Q?NzYEY57oA6vlD54jKWNWzgYBVdams5jT8PUHiV/Ej95Doy2vr4SF8e5/OGMy?=
 =?us-ascii?Q?cAsrsMEEq+bH5Z1IgfgQqnVAeDoT/BHDqeZf+CjLaK8tHFmnyVEJ5c4bACu6?=
 =?us-ascii?Q?T5Wft+BM62lX+eG72S0GwrcygVmFoGEqtj5OSmhuMZ3/nFnjqija3DdaFg7/?=
 =?us-ascii?Q?hREvZUNSz/8EjiW1nsahZd8KA9q2h2tMOlUKOwxtCRJbpfDdHiBy3nUMMhH6?=
 =?us-ascii?Q?DyYgGGILO8Fs1HRR/G6hiANjSkobsMXLVpcYoz67elub0zduWzXV01mj9eiy?=
 =?us-ascii?Q?/HwXhwXRvQHJa235ksmxhJbXtr8e1KfKT+dtW/QDlcaRFIbLEzDBQLeNynZY?=
 =?us-ascii?Q?Y+7Uj8jK9G+8nzFAJxlpJtl80ec1FYDzrCWFCuBPQriXUHalLuiRIDVZUd6b?=
 =?us-ascii?Q?tEsVDD2sREluwbY6+CfYOdW91hfhxtFIPxuWy6fBCBgSQVg31OGQpjmHY3gv?=
 =?us-ascii?Q?Q6TGJKlBpI3pl8N+UTurs8OY++0XWeTU7gRz/AoJQ5ui1ciRa7wci6Upz4t/?=
 =?us-ascii?Q?HGrBpxKW4yvL5ZzyogM37/2Es6SQFxyYdRtVSZMlW1deKYw4MB2jUa4/ZBv5?=
 =?us-ascii?Q?rsm1kSHMg6k7YZJGdAwAlC1Dxdhu5jF1dfmQDCg76AfjIEfOm5hEJh5G8Cfo?=
 =?us-ascii?Q?SmUZWmaMOfT+2Muu+0w9TA58HLJg3KtGy6RzMI+Vkw+ga11NbVGm0vomecQt?=
 =?us-ascii?Q?l3pHqqPtvDG9BTFPywg7Yc722Ua49iak+gsNGRml+zIVrChIUOnNpC62/H6t?=
 =?us-ascii?Q?UaEUCxMZ4G6hUnaWtq0o5PQhmxEcNGStiZ5gBktTJ9Z4/Lal9MvnKvtgE6i9?=
 =?us-ascii?Q?vKg3Bd1BZ6rN/VnVXNEnb9WFUJK5a6xy6SMnJKY1gbPdzdYlgwBaHUBOvqE7?=
 =?us-ascii?Q?NB3KnWYB?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341ddb63-7e5d-4175-93d4-08d8b6d8d89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 09:02:53.5651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WUA75ZexlNLNlY4e1vKz5HZKSJzg2Ee9/8Y5krCm9dlVBc8WuKebE75S+0g8EjeDSSb3sWy1XnBRGTNZLgLPnc4d7oUIisvzdaPhc+XLJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_040258_198681_33359723 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/11/21 11:30 PM, Christoph Hellwig wrote:
> Can you reorder this patch so that it applies as a straight fix without
> the cleanups?
>
Okay.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

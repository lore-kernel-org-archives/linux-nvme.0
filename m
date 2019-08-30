Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652EC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:45:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC3D23428
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PJ4ibCA3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Flcd7GVo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MUH2j/UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC3D23428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=usQ0SfkAHVhQUoMKUrm6zu3TDT9UH4YNycc07QIaH4U=; b=PJ4ibCA3jqqRwR
	ncj88ouxkwl4SUCBccYQQ6333AxPx7PFVAqHxUFLX0XlZmEoETu00xn+AsTYTinmGnEdLiWCTZn7Y
	ULY0W7NfzeX575xSorsxaSnq6O5ZbE6zObOx4BvauAGtvcTFOmUkOoA8zv2l9lNxiMNGqG/nOGz0Z
	386y2mQYeC8mh81KejVJyNzXEdQJK3IXJ3fRTWiZIVk/HJ9zDvDlZsSr0o4U+kMifaZ8ASCZpRUcM
	0p8/wX5BldPja1BYywc5PgOIQR2qFBK03zyc8kkHhFH32KBdKA0UNRbHeHBGDsbTZSzKDhpy211a1
	IT7mPE8Sm2PAtO/rh5/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3ltv-0007ID-7e; Fri, 30 Aug 2019 18:45:35 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3ltr-0007Hn-W0
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567190732; x=1598726732;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MomVQc++kt7FNdVLUfXKuku/iPHTLi82vBJIc48mkGU=;
 b=Flcd7GVor5a9eJKp4mIF5KR7W6Lt8JfdtRq6qLLtbmessNhRsK8r9OWs
 w5XvpcLrSmeD4eZb/AFhFzzslgA5wLqK46B5hbpTRAjt2lWKwJ5AMuhfW
 380B6Iy8fPO+ViPghK1jnTklkmTktTxe8/bQ72BWbrZuN0Dur/Nx+1Kvi
 dVO/kMI7nQfpPqNDvLpeqyNH626tanOXgqPqc33oaHE+TR4yf0KDIlqKp
 l+EUKPgHBbXRLHNBzBNbFFes2lQpJ82CXPeYYC//Us1SOOt9a/wN2SUxB
 hipj5sr0tC6jPAJkqbzv21oGev/Jgsh2EuTJQDhCCSvssFeMwdzGAUiUU g==;
IronPort-SDR: Dv+Mgz5zjhw3rJ0RU7F56zSch69wKRzDD7KTL7CCLS53UHmOiYj/g+iKi6TxbAWxtvOXTnl6oU
 SPfHTGZCMvzYAnMfOdleML0aDcCpNCUGz3u+aUDdaI9+Zmvc48zqh5hqrTW+9a8DNrjl0uQxB9
 0e0DLcBh+SiH9cPwUkfj2grHZNHOootXRt9lqjPKhrVG2ILaOr6dGpYL1yLdIUpLcq3mjJmGZi
 z3ahfTOH4mVr3W1GqWGXj3Z9TAuOc2VgDpwhvzqap9wBI6amL4U+pmt415eDVpk2mDBlQV18UQ
 Zlg=
X-IronPort-AV: E=Sophos;i="5.64,447,1559491200"; d="scan'208";a="117966415"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 02:45:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpuBK5wczZ7OZ/Gm3u62KUjaHeYS4t5rZIgwWF/lNR134/4Vutxo69jVJgCxBVjB/qK6VPQIhHlmAHMf1JjSGtwIZEpdZ4uGMIE9nNeiOYpcsDStK0ebWKzpw4J34vkQFicf1/Hi6eLhEHgfoQurNxp1FeKzGFP74d5Eyzv0yPg1ev1A94hspZ/LQqzAMkD4oSxTMvJZm02ggbIMifzcImlyxGkW0lFZOsRSRAdewptG9cbQpUwwva1t/V0zJtn0ByD053ULhW8dXBRAdbvpS9rY/dlatrt2Bc7oqpemOV6IAORa105Zl80jEorK+kAcgiGvXrPS/naeFs30lg37Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiQcPlpn6fOxqKIEjV1TCKWqCwkSWbqcl/JzBNxZ9as=;
 b=QtXkOhdtu3FDYJ4gN9NyN4skYZqgxTf4+EftFBt06qw4VXfOpS4Y1ZoCNzwTabM7l489FkwWBDWQyamcK+JhVI/Y+w3vDRVfNUgRjCbYcvf8A5oJ9RXh2mZdYGZ/TGR0dIDn3s/p5h2U2mHnrqbMWp0kDDJVeiSoWNekTW7XJp8NNqhZqKV+3IRuv4hi1dNMCRvONQFubcNk6dfDTds8g9qUAD8wImQcDi7iWlZCk1ZDVk+1TBXhnSnRNBWwj7sM7p8x9pyj72h35vX56GEyCh5PODa47MCChVarsTjYDd5UbYYijQNb3XeJIrq7yqwjfs/+5Zr+L43EWhTPE3+Huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiQcPlpn6fOxqKIEjV1TCKWqCwkSWbqcl/JzBNxZ9as=;
 b=MUH2j/UM2BatlyTwlc71smBFjHIh9IkOQw9OuiwhkYM/MZDSwgdWF6IHAYflvUX8jvZ+Hf7msxGFcs9rVpkqDbQQ34/Z28nt2Pf/VAhWGigST5jhu42ENpBbtvRGtXE+YssalzB/FOD6JplUbSFirllLimwG276ZtnyeF0G5j+Y=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4296.namprd04.prod.outlook.com (20.176.251.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 18:45:28 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:45:28 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 3/9] nvme: make nvme_report_ns_ids propagate error back
Thread-Topic: [PATCH v9 3/9] nvme: make nvme_report_ns_ids propagate error back
Thread-Index: AQHVXrYc21v1nYu64UqHqiEQ2/7UEw==
Date: Fri, 30 Aug 2019 18:45:28 +0000
Message-ID: <BYAPR04MB5749D18A67ADBED8A1FC6D3A86BD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190829220645.5480-1-sagi@grimberg.me>
 <20190829220645.5480-4-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1db81c0-8a7c-41cf-0ab6-08d72d7a3a9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4296; 
x-ms-traffictypediagnostic: BYAPR04MB4296:
x-microsoft-antispam-prvs: <BYAPR04MB4296B268B56B346335B56B8986BD0@BYAPR04MB4296.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(186003)(71200400001)(256004)(102836004)(26005)(6436002)(229853002)(55016002)(9686003)(110136005)(54906003)(81166006)(81156014)(8936002)(8676002)(76176011)(305945005)(66066001)(7736002)(7696005)(74316002)(2501003)(71190400001)(53546011)(99286004)(6506007)(486006)(446003)(476003)(86362001)(4326008)(64756008)(66446008)(53936002)(2906002)(76116006)(3846002)(6116002)(66556008)(316002)(66476007)(66946007)(14454004)(25786009)(5660300002)(33656002)(4744005)(6246003)(52536014)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4296;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SbF2Kl7e7R9HH/R/MSRapekbrdlN7g+7kp6J0vDCyID8QrDsj0+3YUucs1alf9iiXF46gZp+fyXEPnVKvMgd64SimdTkscVKMu3ljVVIn1K+u82J2ps3GTdD1HeYnOy9RELv4tPTWD3nl0zaN5H40Ch1xt6PXAx/Y4YL90MOxvmKnOjWLkO1/wQqzv8q9vd1m5LhMlW5zrbgJtRdMv6/5VGcBKqY+uI4qvYV/vyAFY98IoAddDzcuEnJ1KFy6mxt54ISKKn/pPNea8jWSQSx8TyVL/ij/KsjKBJ+X1ONeCHtKzJ3bdQeeJgnxs7WGuV5jjp2Rzh9JtQRPysy/N/z+48aLAAudlSmEdfDqq68iSGWLq8qQVLHBihN5PTnJ80hQ6Nvvisc9qGEXK4DKHGzkFg1k4s56Pn99eNqHUtbFp4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1db81c0-8a7c-41cf-0ab6-08d72d7a3a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:45:28.6701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDXaK1Ea1M953aHD8aH5DahlnYahCqvBxgSI43CV8zXz2jb41ou2FHEPlgjo+UujbhDM6QH80UNnpBP+Dr0urtM++dPyY3CjcASKfMQq2FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_114532_150077_920C037C 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Starting commit log with "And" seems little bit odd.

Otherwise, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 08/29/2019 03:07 PM, Sagi Grimberg wrote:
> And make the callers check the return status and propagate
> back accordingly. Also print the return status.
>
> Reviewed-by: Hannes Reinecke<hare@suse.com>
> Reviewed-by: James Smart<james.smart@broadcom.com>
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

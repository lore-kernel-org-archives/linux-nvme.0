Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CE1C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FC2206E9
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPWgPrFW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UmnNq3Tm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Skudzonv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FC2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=UxXzcBApRsqDdIY/EehIDLRMcCgXT2gSHthQYnAqOwk=; b=lPWgPrFWGagqnm
	q8IkED4nNxqe/BrdIvRwJA5Cgma1TlfgvwRnqq0MPWvyQcmca3drYt42g98uHM039DlqVcjVbLbNY
	QxXJqo3q97rSUdkImDKl0pL40oUl13sofJXyPi7wvArcuuIl1EGRQ9q5Jgi3HuqtXaHws6iIQIH2E
	emcHiRq12qUfSjYObb09WjVZLYlG0q+US7NR6PBuH2UXu7/Uik/YSdBFkHrEEH90PKbrtI7qSbcI5
	KyN4Hx9zXQfEjCrqT2grl3t7CgA7EtBwNmbN9dW4+anzymIw19As8JskASIFRitaU/7Zv43pX5G7K
	2zao7YiPcvkhA60FGcjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKSrF-0002kb-6r; Fri, 03 Apr 2020 20:24:05 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKSrC-0002jt-Az
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 20:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585945443; x=1617481443;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+6yBOTqUG3YgkG19QszLign4dTsPY2z0u9rhGPgELcw=;
 b=UmnNq3TmJby0NMGmhK133ysSIRbpBc2/N8RRgDB0RlywVkBgdyg0Deoh
 G6tWc+qVbiaNPV/sbcVKtdeJWJ/Fwu4h4ehJdYN9AUh7OeX5er4TW6IIb
 LLH2BOOm5IDvEqqfd4NSQ+ODHPUR92iRhVigrhdv3tXktNEDbeWyTm0Pv
 7NFTWJ2M5RkdHsV5010eEEA7mif3oAOjPDgvvnujRpvEV+7LwiwLDBglL
 7iraJlHe/EdpeaWpEdaoevRQW6AkpeEnngpCFeyhlv0RWefOAWa67wImt
 4jOyBu6NhvxD7k19pG0/evm+QmkE9Xj5d4SIvnJuO/OJULpjO04jf92lG Q==;
IronPort-SDR: SQgmhj96AvSH1WgVm4SU8TtMw98WvrPSpMCWlLDv2pMghWq51l34KiXfqpGWYY8f69Mto5VEXX
 U2EWa3El56YobtkTfi02DoLZ9CQtkegcS+y904R1Djk71vdK+RWcEt8tNFzP3HZIWVMHkttvWJ
 v/JQ2HWD0TAOwoMC6uPuoPNxSc4UEQtchRiD9X0QLl/rDFziyp2g1F4pCW6wfnXLtSZvEMEEkQ
 0ZsdAkY6orV5fWK0QDIYBYYryo8tUIhdqyHjw65POVDqpKCOkFn0AT0hHC7NyUFUAOyIWXql4Z
 QCI=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; d="scan'208";a="134854242"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:23:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huUoV4CaLqbKnBos+acl+hb7c6tm9kieKYzAuceivUTiSRTlVM6KUUnAU+73n0NyaeVLwI77x/VfVTardSbWYcwEx9uYDa+YIyFCnbqmAkVMFUn0JbEJ39MsQtmY4CT4O4zUKMBZsxChkwAPbdDYdd3Qu6pzlBUqlE9NXND/5a0XOqTgi8j7X17cZISIE0UN+waN1pYxaliFm9CVMcWFB9QKrP3dz2RIUkkojkDYJi52qz1r+5/+ElyiQ7l/LVUWFpKGkHAI/pPW+V+vYxPXfTP53qHRe45ptQpE++VSSa51hxiBXbx7Rf6v+HqJeoNkzJpv9eGkQ/NVkEQstJOHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLDQYu5AJwZw1qfu0XPaiqAJg1wkmZ0H0UuGsLgopDE=;
 b=f0iBEj7GGUVclcsSpVYidKVOQT4lCWJGRei9c7SGeEZmhzswR3wZU2ETrHaWUAcj9BOfa6mTPgx2SyTKCJf3ieLQeDlcvRzL9zGMjrnVVBs6YcALHKebQP+4ntTevxEcv7eoT1CeJAVLsDEhsizk7xHRoLY3eDlY1nxIHrQ/RUDWmvhYGt0eQGbYHNFwpOziBhoyjpImY9wfrh3gEby5NWQwdpP0EdmEZ/Z1pEZNOaDMYfbxqw08U1rWL708w+utMJmsmNZTrEG8h1jAwDHhl7ii46TFzhN1NtLSagYKXY3an5VlGJeN9f6jtDTPj3r6LJzbduWL0K3shNbXtLLR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLDQYu5AJwZw1qfu0XPaiqAJg1wkmZ0H0UuGsLgopDE=;
 b=Skudzonvf7UpDYUt+8XrfvYhOLwRFE2gUUbj98I/NYFUpHmOTvJAMXkQkMfIN0czKLfS2kbTUbnbnQr69BZDhM1+G9RCi0PCzZRmokJI3ai+MYu7OUMS4BgOBnCEoef3GYnUHCIjvHt5ok0fNjYWAlpP0SOQV7ZjC3A+LUsu6vU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4040.namprd04.prod.outlook.com (2603:10b6:a02:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 20:23:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:23:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Anthony Iliopoulos <ailiop@suse.com>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Topic: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Index: AQHWCSVL06kuVSKmBEqONSGslHKI9A==
Date: Fri, 3 Apr 2020 20:23:53 +0000
Message-ID: <BYAPR04MB49652594CD66C48E2F6996F086C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200402193052.19935-1-ailiop@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 339cf102-52d7-4974-91d8-08d7d80cedbe
x-ms-traffictypediagnostic: BYAPR04MB4040:
x-microsoft-antispam-prvs: <BYAPR04MB4040F9B911BE25A787EA753C86C70@BYAPR04MB4040.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(5660300002)(4326008)(9686003)(55016002)(81156014)(26005)(71200400001)(33656002)(4744005)(186003)(8936002)(8676002)(110136005)(54906003)(86362001)(81166006)(52536014)(66946007)(478600001)(66476007)(66556008)(64756008)(66446008)(7696005)(76116006)(316002)(53546011)(6506007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eB6WATlimWSptODnx2BoFDV/tUBE5D6L1Rg0+63vpFPd/kiNERinoyz6bmXFxEOyIWMQfjRqXTb69CmJvAdp3SpD9psAcLe6u4WNHOQQnm/EwSlQPevStW64nqtZtETTj8Gtrg1xxB8iX/qmZA9vIURevNW2rKG9Dfl/a7hsFWdS9/9EF+50H1nCGVllz6vSh5nLpOXsrdiPOGt3L0UqG5DMNZXZfgNcZ0+HTn7T0c82mwlvi+pqOEXEQdC+cUCwtCRnaq9HzYJvaLfcm4B4SWv+d5qKYDVk6KnCAJjJigtO7Nn/+iDC1OTUJ4jhV3IwsSmZNK2A6HLzIfxcbz0dH9xDwnoWhisqe+uC3tWVCJqojJyb93mmuLnZVJpCt54FJIk0LeNx9IDFJzwS9tPTdRibjZsR685mGWqdVtLg3cz1zi2mHacANmpBm2I6gI8t
x-ms-exchange-antispam-messagedata: e4jFnJ3LGmU9wbaEUiwTVTUa6MPQt21ghJQQgrqIV3MBnquKFmZALMQeYLWck7AeItnKXdutd4etP6e0wjI31642Kvq5BB3by3yVc8QGnjkJhQe0L+duMcVAGP8U1m2s2P88TRs2aFwa7OtrnQZw2A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339cf102-52d7-4974-91d8-08d7d80cedbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:23:53.4601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rWAhaekCxGJVym9qt6rJJNcrACaalGY/piNip4WA9p719wrvqKMbG6S7oGAkXOeYv6AHI7fJBgfL3gKCw6pVoAAJoEB62PuwL4oBQTtSBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_132402_387546_DDA54490 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/02/2020 12:31 PM, Anthony Iliopoulos wrote:
> +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	loff_t size;
> +
> +	size = i_size_read(ns->bdev->bd_inode);
> +
> +	if (ns->size != size)
> +		ns->size = size;

How about following one line which is still readable ?

ns->size = i_size_read(ns->bdev->bd_inode);

> +}
> +


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

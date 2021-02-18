Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6903FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 04:07:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F3564E28
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 04:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F3564E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=q0x5dvqcNKDIVceqZP7JQ/kNBbiDe8dxx7J4I8TDcA4=; b=F/fC3rN7FVF59pFSBkFnxNg+t
	Tpi60ScZ1pAqqJIS5iZ4x8SGuwtqLBdkXba3tJb5bigwtChcpOMwGOanjnh2BGU5BfnMyWL3katTr
	YGxfI6vd6eNClEfMFO3wKEC8R7Vq72goKDEhZspgUOOGtjPxEksuKwYOfPPjnuzwcsYw1NrKkdAs/
	PDhRrhsta263XNQb4shBBbWmrfWf+d+y6sal35AmLZs+XGuf1xeRU7pE0BsXaZkxY0c193A1eGHmT
	hv8AvOzKKl3z3/QRdm/LhVA2hGIBjZjBrTkDXC9woVKBmo+Ki/FVPneBaKJjNl3eChHIQPXLjH75W
	0lSpUhmWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCaaP-0002wR-Na; Thu, 18 Feb 2021 04:06:41 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCaaM-0002vp-QL
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 04:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613621199; x=1645157199;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8npuxIhIGpou4czvDsFmDTcL742k7zdUoCQtFM3LgZY=;
 b=gwuHOCa8F1NjRZ3oS8Ty7pwQw2dxo8BAWG58Td7jZfg1svRN91PunfRR
 c/G/w9HzyifElovRpg7pMeygP5LgLEGbNqU8zCnkClSjHI9DdK7LNXTAw
 MeatzWC/t+9g3EeeQ9OqF+2pk/SuIM2cN9nUwFHrF9B02Sq+KbWFNRiUr
 f8//EcN932W1Elj5lj7yTUrbeZ70iPsV7mci7W+UiOuPzEpUwDr8c7V5p
 jaJVT2ieuROA8c4342rHRxaxsB2oTEfiHVQpTILARoA0z+3hGbiMyvUJx
 Z72dGbwszleVUWYuMA2YpXe+WQPJbtsQSV8C9LQRU7clAeNLjM/KA8ibV Q==;
IronPort-SDR: VH7/o7mQ1C8rKb1mgWS5YAF1c38XOnQN+hgsGPQAwLfsquuApDKlSujiHhBFY9s9QT7Q93QV6O
 1ZIYh0KpCTNqDsxB+3ZOz3J2svHbEIxaGBJc6P/yIFa5L3axzCS0tjo4Uey5aELqRbfm9vG8QD
 vdbLKHZN/T8SEnJdNrs/0O1q29VC+1+7zQxoZjzOME3XqJ0BvejzCkaB2dsa05Q1yCs+tm3/rG
 riWnoYj4Xf07ls4Jiwa3WT+rZ3pCrv1JF0duLN8Kz7yKtLFwPmWJS+/nCfjvuHwLvqfO+0dzM2
 kEI=
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800"; d="scan'208";a="161400010"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
 by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 12:06:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqHmIp+MLxFw/i4B60oCuBZykVTq4CD92uqTIk6Gdl6MRjrabXVZBwpaLK1Ub6U7YyIUqSTGHGysQyJ1hDfa6eTNdmt7t/rfm9oica8mXcOCAq7xLwDS3zF7gMHBbVZ3FgYQO4O4F5dkLUomxw/pXVmLrQAYa1cAZlZtTQJktpfsuAOhd1fY99z95mZkBIqUGGTqob/wQyIZfcpe1nKstEKhHucxXo5edXpoUUQBS8NUdCmCZ9IG03sraNg330xmSft3dHvwPefDbRb7g3F7pIZiSfyABdStegHG2nH0J5Qc7WCmsd4NrkE620MBb4VNp0ySvGsKC5vZvWXXE7Pqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDdY9ny4SdjnOcS1Q2eGDYf/GRwb0lMR2a9nDPMPSEg=;
 b=hkDCX44drFhivglNRHQFCwLT/17uXeIo2co0zIzIByZzjOwVoqrcHyUf8Vil8dvICrAVpENKkk7v2CxNeza3dwDgxzJfVNGF6J34t6hNm2ljN8jk/I5quWnSfrHcfcBU5RJtOdji2nTymleeX3HEAbA72RZppb/aaZUBKLrokyftDf0VZTvwMh+2h0s/V2EQZObz9tucnq4v4SGeUeoUJygXx/USqpRFEBx4csACH/bEhJf53NNLyyOeOzskZuY9k4WEcXVk04VKjK0uaXrg0o4zH8y7mQ+HqU6RogF4Zwzi86nWL7YXjCVrCTMedxozYfUfo1k2wzzFlb8F5dplmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDdY9ny4SdjnOcS1Q2eGDYf/GRwb0lMR2a9nDPMPSEg=;
 b=wCHjHLgcbmE4kTl55tp7ynYZAY/rJqFP4AURdwkgDnT9YeazmiLJh1braIEYku1TU5EWqnaxmBHWpJ7pJ07OknoPX7YzLXCau5qO0sv40sHfbqYKwYwHF5HKExriyEithlhJlg7c+gbXTh1Z7ZC1hogfGYNTOt6Xgddbq7vRUpY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 04:06:35 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 04:06:35 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] nvme: use lighter smp barriers in nvme_irq
Thread-Topic: [PATCH] nvme: use lighter smp barriers in nvme_irq
Thread-Index: AQHXAu696T9/DajUoEiPLgnbqLXgjw==
Date: Thu, 18 Feb 2021 04:06:35 +0000
Message-ID: <BYAPR04MB49659AADB83039BA9DC0041886859@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
 <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <be263cdf-19a2-05d6-1023-7d935d526663@gmail.com>
 <20210218032822.GA2711165@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa8368ee-3235-458a-8abb-08d8d3c29523
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-microsoft-antispam-prvs: <BY5PR04MB675331E35B7F375B84E27AFC86859@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/JHLequIAJthLD8rfeANA/XnCVPz9nfEYm/AAAPbBqzJDz6dvnUkaUdOu86duUFLrFS0JTV3cvEX95xvGeH+0/mU6+iqKz+xzm+52uccVGQFh2MbTHOC3bfifTyNS1uu9jvdMI5BWnqo5Ww0yWcekcyrpnITpqSApPZVLFOXlaZMq9fhWUOYCWD0xa0IWp5sdLOH+DAOyR05AnPHZO/uLwDvQrnGwkQDv173s7kHl5aU0lO4Ey2Gqpb2A4ng6fnPvy/woWDYBI2JIHWmm4jJZ3RAHtgR3dtTOQ74DcFJm49s2r83F2vxU7jTaAltaqpXqhlSNxxhbK36zBFCguWZ/AQ7UKC/aVP4Gyu6vpmt4gCVzmKVXPKLmO+xZy7+aMhUnlR+FkPEo1h6BsYvSFpSCkHlur23683p5We2iby78HL2lG0mnGaMDgGXPnEhksUeptcaZJ2Ni+v1XFYyL3jyZyY0LHqCssSVoUYaewHxI3TZmjmHNsoVbO1ns3FO+h4T2jbeLkgtxS7meB55LCI4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(71200400001)(8676002)(54906003)(76116006)(5660300002)(316002)(478600001)(2906002)(7696005)(66556008)(66446008)(53546011)(86362001)(52536014)(55016002)(26005)(66946007)(9686003)(83380400001)(4326008)(110136005)(33656002)(186003)(66476007)(64756008)(8936002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QP1Z8may8S/sRqH9vhMDmbNyOHwl21qsWIok2AfUPqG++mlWGURawSDv5PgS?=
 =?us-ascii?Q?0Qo7vGd23u9X9BaIJWIkZrLKVFgzgJHXQZm99ZploTKKGTioPoD+ITzWRvlO?=
 =?us-ascii?Q?KeM8txqBb9PUg/KYMUVLVR0UHjY1LWhUxvf0T6AbDKuPZq7DwOdzYJ+SmiHb?=
 =?us-ascii?Q?S/9US7kjPyt2pqX38Od1upF4TT1ldPPLuTI7OWfqClk795Nli5s6mHFjU7Mi?=
 =?us-ascii?Q?pK2T11EUPr+H9LPpDWP+BmotRpt7k6Fd+sZJYBTiLmN9KaS+yxRdT+k58Mye?=
 =?us-ascii?Q?vMmgWFg2tiR1sqkI+4Yd3noM9AFhl6Gkqgc2w0lYUPFlWKBz0J9mMlOzDaNZ?=
 =?us-ascii?Q?ztKuOCjgO9iWA+HO3WJ+n7FOjn8N3L8dw/vp8nN4PaE7QAlQ65MDDKUtYloS?=
 =?us-ascii?Q?sV0g76VdH0pG2XZitep+eNJrWd7iNHFcmnG8BnAHe6GVgW0Y7YEtDfo87aQj?=
 =?us-ascii?Q?hI/64sRcNRrkt3cRMc5zSBIpWzeFNrufVmBZ/ex27NPg4/WM9t51GqrdWSZq?=
 =?us-ascii?Q?Sp+8nKg6ecvllJHY/TIZkdt69uqLv+UM2W4BGkSk4/NnVM7cvmPTLJMMzigI?=
 =?us-ascii?Q?UuvttnBsQuAlZ0toL9r8l7jKqNot+Bnn0Kfik02hp/mFsUR8pffygEJZdKdD?=
 =?us-ascii?Q?TpzCEocsI0KYl9jNIIWQjMVOdZbwJmI544Y9bLRhpIjQDAHko3PSc0FL1LmB?=
 =?us-ascii?Q?iWkDOk2pb+w+ZDxnWm26EaVrgBl0htpmEyq7I3SXUdg3Gvi7u4jUzBKk2JBU?=
 =?us-ascii?Q?IpU4CsctOfu/zrOoRQOXkD/qDMQBzdHkL2UK47QyEH4URH25RU4uFNdvRj/i?=
 =?us-ascii?Q?Mt2gMiA+H9rbqx3CQzXLhbOFTFUzr7UzozHxW3rKHnWIKmQpeHjC8k0aSshO?=
 =?us-ascii?Q?uaEZhY+8uCq+A0cdbpBwW5lI6bkuXpJg3sHOF5NhALpmppa1gqsT6uhn43wG?=
 =?us-ascii?Q?+SHvKYOQdPNgh0FKj1bkkb1Msm1jP9eB/pHabuZR6ih24warqokqmZu9rtt7?=
 =?us-ascii?Q?a40bLzpAlQcRuhI4LCJoCrIZnWraorcjTyIm0fcROTjGEnNYMx9/sbsuvsQD?=
 =?us-ascii?Q?BWSK7QrmBwaW8BcBy5fUnbxO/g6GVN/bnnALHhwGDl0eu0Ms5kwP3qKbJq4g?=
 =?us-ascii?Q?Kfa0/R4ucP51IQej5h4a8oBzGP/UaK3RdInTP4M57dWd2uzUs6FOHFCVZ7B9?=
 =?us-ascii?Q?EM74Te/BjkIOhfshAQXwAq5l0RNNq3l0m+CMEwvFmKjhRWfO/rEa8gPFWrMW?=
 =?us-ascii?Q?B6GiAXPhqpEHLKldv/vFR3ylPrwD3I8DesTc0WLgC4NFq6l9etXBbSknerX3?=
 =?us-ascii?Q?6aUFAbvq4O952jmgeonqG7EQ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8368ee-3235-458a-8abb-08d8d3c29523
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 04:06:35.1286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvGGGOBt/7On1RTwHueMOSaeYgSve6BnNc4/BsA4p1AclZN1PSvOcKyGy/iBBWr33bpV3Msu4vZa5glW9SRMYi5vB52IlO/wd8kSB31Q6Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_230639_073550_E7F3F9C6 
X-CRM114-Status: GOOD (  20.87  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,

On 2/17/21 19:28, Keith Busch wrote:
> On Wed, Feb 17, 2021 at 08:26:30AM +0100, Heiner Kallweit wrote:
>> On 17.02.2021 00:59, Chaitanya Kulkarni wrote:
>>> On 2/14/21 08:30, Heiner Kallweit wrote:
>>>> Based on the description we should be fine using the less heavy-weight
>>>> smp barriers here. On x86 this would be compiler barriers only.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> Can you share performance numbers ?
>>>
>> I stumbled across this code piece by chance and don't have hw to test it.
>> Having said that the change is based on code inspection only.
>> Unfortunately the barrier comment is very generic and doesn't mention
>> a problematic scenario. Also the commit message of 3a7afd8ee42a doesn't
>> mention a potential race. Most likely the barrier can be removed
>> completely. Helpful would be if someone could explain the potential race
>> in detail, means which reordering / variable accesses could be racy.
>> Then we would have a basis to talk about READ_ONCE/WRITE_ONCE vs.
>> smp barrier vs. dma barrier vs. full barrier.
> The variables the driver was protecting no longer exist, so I also agree
> the barriers should not be necessary.
>

Are you saying something like following is needed ?

From a3a73bd3943b479f82ff00582baf2c37c1afd8e8 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Feb 2021 20:01:37 -0800
Subject: [PATCH] nvme-pci: remove the barriers

The variable which was protected by the barriers is removed in
The commit f6c4d97b0d82 (" nvme/pci: Remove last_cq_head").

Remove the barriers which was protecting the variable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0045c5edf629..3729775f6a8a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1062,14 +1062,8 @@ static irqreturn_t nvme_irq(int irq, void *data)
     struct nvme_queue *nvmeq = data;
     irqreturn_t ret = IRQ_NONE;
 
-    /*
-     * The rmb/wmb pair ensures we see all updates from a previous run of
-     * the irq handler, even if that was on another CPU.
-     */
-    rmb();
     if (nvme_process_cq(nvmeq))
         ret = IRQ_HANDLED;
-    wmb();
 
     return ret;
 }
-- 
2.22.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=1PCA=XQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA32C4360D
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2019 20:40:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D285921835
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2019 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S9CkFBBD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QwcoxPu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D285921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u9scMGvajqxdty8cRE9vvn4Wju3wk2ieRiCSd4uvffw=; b=S9CkFBBDG4gj20TUFwjm8WUfk
	q4oTHm9tFFAM3nW+2ViQrWxxTultzLYviw9umPEN3zJBUwNV0SpTJdC0U36m/sQEjQR3z6HlXKE/k
	1lZYQAvUMsGzU5moGVwpMRe+pg+HErIG30LR6ufGVe+33nBwmoB5FQG3JxPfaY3UuBVEv7o0SkzLb
	jwuaPEDUik9UhX6WcdR3oByICL6mL+Mzju3Smt4jHhyILTeMeIYo9q+PEOhLeFnn2v9NHYnFWVaYb
	26QgyAozViD9RVlJeQ2LcbIqTpSnj8HUk2J/rPwu7vJGyBI1WAnG/99+4fVaaYxPl6lXM06db+UfH
	jLCBopHwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBmAr-0002Pf-3x; Sat, 21 Sep 2019 20:40:09 +0000
Received: from mail-eopbgr130043.outbound.protection.outlook.com
 ([40.107.13.43] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBmAl-0001em-MQ
 for linux-nvme@lists.infradead.org; Sat, 21 Sep 2019 20:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBAy968ZPIfWx4Om1iAX5WdU2A5jo86i0a9mYrnLa+Fai4setKcTCDsyhCIzvQ81cQ/A/4eHaQqillFHxcrgm2970X2w/J913/rQZalDxhB0m+8Ty5ztH90WPCkI3XYf6B8sbDi9RiTPAU/VPU3dPOVJAkUztwu83tnQ/6RsaA7OOUaT/URIQkeF6bfXVZKZZw65nGjCRlBM2cFR4YK/sceH+UV86PODc3UpX0u0VUNM4EL01OmvLnSaIOTqf2dPoCrQHeCr2wh6lgcdRiQSJWIMK/opn2ynbIUpzkiddmC7O8+E4Xk47dHAqEsdAUUWUCROnrZLmpyDahDm8SEUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGrVkXVtr6MyFtWZ8ykWDux5fUOYT+GCAWKM7KU5fp4=;
 b=gUNHLv/MWLhac5dYOEUUDnvbwbfYuaSeP+VVmfj7djf9RUgvZZ/dwce/cioaF8zIBZ9wurIQ88OY6lOW4Z/1gc4PHsMUCfnEewyeJ+mrPuKndNY0z4o8S0e83E56KeRAhGtuCFj4kUd4IzHa7bVPYjFP2GV9BQWUdr3mGE4YTI0PY6IKFIGfuSGCP862OsBlWR8YR3k9LxWvIoH/ruE2zTNPtVbHpiOnOL6Yh2TunQ2ZM/g67MqNSHIit7Qx6eX7q/WlDBnUKkmbq4eckCUYMTKlil86foBqmwgMR1ZyFNUV1ftMGegbJ7laXXSroIxzGDZMWOD8TdSHKOSxHX1aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=intel.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGrVkXVtr6MyFtWZ8ykWDux5fUOYT+GCAWKM7KU5fp4=;
 b=QwcoxPu0eJjWpZjkzqtXi/0/JdP1Blo34kdwPmbPrVH/M9DM7e4yRLZ5AdEenemnXClHMVb05iJRqhQ6gI6w0zSV1g6Zf1TSvf1cIF/EoHoUJpZx0BpvzWxoAWVDe2JXZ3u20Ay4K6VT0nGoY59Xfru210lPdMocVE4jNYoWpO0=
Received: from DB7PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:10:2e::48)
 by HE1PR0501MB2587.eurprd05.prod.outlook.com (2603:10a6:3:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22; Sat, 21 Sep
 2019 20:39:55 +0000
Received: from DB5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by DB7PR05CA0071.outlook.office365.com
 (2603:10a6:10:2e::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Sat, 21 Sep 2019 20:39:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT008.mail.protection.outlook.com (10.152.20.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Sat, 21 Sep 2019 20:39:55 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sat, 21 Sep 2019 23:39:54
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sat,
 21 Sep 2019 23:39:54 +0300
Received: from [172.16.0.37] (172.16.0.37) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sat, 21 Sep 2019 23:39:33
 +0300
Subject: Re: [PATCH 1/1] nvme-rdma: Fix max_hw_sectors calculation
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>
References: <1568815936-6257-1-git-send-email-maxg@mellanox.com>
 <115a92ed-d390-1a30-5d81-755fd3128ad4@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <183cb09b-0da5-d926-0050-11e48f65a1b1@mellanox.com>
Date: Sat, 21 Sep 2019 23:39:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <115a92ed-d390-1a30-5d81-755fd3128ad4@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.16.0.37]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39850400004)(136003)(376002)(396003)(346002)(199004)(189003)(86362001)(2906002)(31696002)(478600001)(8936002)(4744005)(5660300002)(50466002)(8676002)(230700001)(7736002)(81156014)(81166006)(70586007)(31686004)(4326008)(65956001)(305945005)(76176011)(47776003)(53546011)(446003)(23676004)(70206006)(356004)(6246003)(2486003)(65806001)(6116002)(2616005)(3846002)(106002)(58126008)(336012)(316002)(486006)(126002)(16576012)(11346002)(2201001)(36756003)(54906003)(107886003)(110136005)(26005)(16526019)(476003)(186003)(229853002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0501MB2587; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c1785d4-3252-4997-d020-08d73ed3dc7f
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:HE1PR0501MB2587; 
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2587:
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2587B0627FCADF5CDBF141CFB68B0@HE1PR0501MB2587.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0167DB5752
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cS7Iu+fXCfz3dC7ERd2ilybdoZ7MX63D29cwZG8lHbMrCii6SOu5xD0YpQ2bkH2YVhaIbQ5I9AST5FDyoovoGpG+nwaCbrUT3pd2gu5IxtdbuI0pk2Dm/sojOGALIveIw0wlwraVNufD/0jdx4Ht9Y6vIcAhgSuPrZlI8kHTW9wGb6lE/g7MxWQLrdkLaLiwZqj1+Y5QoVax2AapqsXHvVsGz1ics1woqLec0KTBgbsuuMx6fi+/KGyeVNwmxVzxDfVL/cmn5HbGnbvopzcmw95O+pWFaOO2FkSlO9vO5hzn+qwA22+RAP0o/GMdlyJpcTXxAK1sewV/9wij+ceQB1SAuuXxtcvtpluNWMvdv2da3LfEtwDgkhgP/BBU8os8lhRcUSH6nuWXRrQ/ElxzYx7aWj0c2DuUaYAIV67IiEc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2019 20:39:55.2746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1785d4-3252-4997-d020-08d73ed3dc7f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2587
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190921_134003_809427_0999616C 
X-CRM114-Status: UNSURE (   7.79  )
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
Cc: keith.busch@intel.com, shlomin@mellanox.com, israelr@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/20/2019 8:19 PM, Sagi Grimberg wrote:
> This doesn't apply on nvme-5.4,
>
> can you please respin a patch that cleanly applies?

Sure.

what do you think about adding an option to configure max_io_size up-to 
16MiB as we do in iSER ?

I was thinking to do it using nvme-cli connect command parameter..

>
> Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

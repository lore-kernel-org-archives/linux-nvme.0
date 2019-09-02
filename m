Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FC1C3A59E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 15:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF61A208CB
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GRJLU/8z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ws3lhEh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF61A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2SvWNpoBniIrnCemGoRGf0zfQF0rG9cUNHrLIT1T2sU=; b=GRJLU/8zQJkkoGGXt5jWYaDZ/
	M21IK1HK0gPWCDzLmQ09tmAfUuadrp6bUvtv7ivweiHyglI2IVf3PxlpZ0Oe3FSY4g2bM/Gzx39eV
	v+BgUX6CXYceBJ7MfJ1CA49lOIp44AFc8/fgPVPoq3NX+61BrbjYnUncooU8kV9jc7vLdiiUGrCIz
	qUWybuuiKbvn2R9xrjVEDDlYVEG1L5pmovZuIsZu0C01D+pbO6kYu8pzIDSYqeGxD2WG3x7dI+MXh
	Ay7WXb/ae/+XbJBxKGajbJNv2eDdl8jJ7SWKac5hXheeB61Y8qE/cDGBv778d2z7r5ecMwof+45pZ
	m2VbBv49Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4oU2-000578-R8; Mon, 02 Sep 2019 15:43:10 +0000
Received: from mail-ve1eur01on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::603]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4oU0-00056S-82
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 15:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw/+Z1JH6ZJSgJ+WS7M5Za7G3MDl5qNkr+ELZ4Niby3gJi86t/HW5nsHqJK5x1WXC9tZ2J3Ltqd5psUdbkWudVxGQXVU0iATaUN4aSG86FbUoZiSYb0fZ9PvIbVg8vTRsP4CP2+yEvdDr6tWczb6V5S03Di9+G3yEFoSZ57/PYbR1EELe/kkIRA7Ego4DoRGkUFWAKnROjZqUeHQvI3P6JQHcIsb9rAhsOROZa4PNYWc/Qg1KwVM/XCz/kBW9ls39BdghH3QHHzc0P8aU44IbqUtPJtGDqnII2xLmB2t009NztAyj/10vpCSXuKkXh1wMi7iODlDQzmt7kf6lJ1j9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neY/dLVmXGAlufW3ew0hqWiWcOwz9ORj9QHDhjH/MzI=;
 b=Pp4ZB9K0w8i4kjPbYJmqOzPacncv7ZsNDftlwcbUTCsLTQTYvSsISlYcD/W7MfwLSRDb+scWPAMhNoqdJu001UqYX5OjIWFTSYxk+Ftw2T9XhtCL0TeFzN3mqhVGUyzYgvTsokzIEzWzl6CY+BT+q+SBRH9LSvMpn3YBLEC5D3UC8rWHhM/UVgvn+lM5ws7FJlAX5hmgPrUUxKFgv2Fp5udOTBrgrsiQavEsU2Xl02s4rvSdp5qA8fjJBljXsWDbnrx4cTbPERbcDvEfzQG8+ofsOgHl7pI5CbZxEFHXufIA0qXn1pa9eOryMxDTXEN81Th+JWa9gTv11wHBNmpgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=oracle.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neY/dLVmXGAlufW3ew0hqWiWcOwz9ORj9QHDhjH/MzI=;
 b=Ws3lhEh4LCcoyNVRX+7P1XbfHvodMZz3+E8LHHKAbbPGObyqEFiXsmjaUX1bivPlv/EJMRBLMmW6BQzdLSlT2pejyMUGO7LrZmnp2PHBEcsE1vXg5XNZGLgEScqPbeyuO46Wnj2OduaaBRrRXrcxokYsTFOAInl5NzDsGccX1yo=
Received: from HE1PR05CA0253.eurprd05.prod.outlook.com (2603:10a6:3:fb::29) by
 HE1PR0502MB3659.eurprd05.prod.outlook.com (2603:10a6:7:85::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Mon, 2 Sep 2019 15:43:04 +0000
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by HE1PR05CA0253.outlook.office365.com
 (2603:10a6:3:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Mon, 2 Sep 2019 15:43:04 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Mon, 2 Sep 2019 15:43:03 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 2 Sep 2019 18:43:02
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 2 Sep 2019 18:43:02 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 2 Sep 2019 18:42:43
 +0300
Subject: Re: [PATCH 1/3] nvme: introduce nvme_finish_cmd function
To: Christoph Hellwig <hch@lst.de>
References: <1567436462-23218-1-git-send-email-maxg@mellanox.com>
 <20190902151348.GA5034@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <174b3d7d-3d57-7529-c504-542fbec7299a@mellanox.com>
Date: Mon, 2 Sep 2019 18:42:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902151348.GA5034@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(58126008)(446003)(186003)(76176011)(11346002)(36756003)(316002)(305945005)(126002)(476003)(356004)(16526019)(229853002)(336012)(7736002)(16576012)(2486003)(23676004)(8936002)(36906005)(8676002)(6246003)(53936002)(2906002)(81156014)(81166006)(31686004)(230700001)(3846002)(70206006)(4744005)(50466002)(6116002)(70586007)(26005)(53546011)(4326008)(106002)(486006)(14444005)(6916009)(65806001)(65956001)(5660300002)(2616005)(47776003)(86362001)(478600001)(54906003)(31696002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0502MB3659; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db46f0f-7be5-4179-f5a3-08d72fbc3df5
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:HE1PR0502MB3659; 
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3659:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB36594E2F9F28C1D7EB2642A2B6BE0@HE1PR0502MB3659.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01480965DA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: l6JZhsrKjkclmg4QRNBZj1xN0xuNgISIzRokVK72weAQpxAWULGKG+FY6BxBjRwIo7NTX4r5eJjhCFnLMk+2+DcnGe6y5DYiSinOcujwIoDYRzUtvAd5ZrIH+uO6xEIhWZ36jc+0kMCq44CC3afe0HGyPp2IX6my3+v5BCeD50buyCvQTz0SS5MSI4Iryp/EVt93UkfWdGpsHgJJTtOfZwtFUyF5dzLNYmJQboOPW7bXokRy75KT6T3dKbzb9OJrtctbPGTAphrwc77DT1jmVi8mUzMnfmjScV+UTwkKIrsFmMzzaWKHAfvy/NeHGTEFZiHXwQ3I/Yz/6x4Z/bdBOg9UjWY+3vPOwIs/mR2ZQ7QiqdeL8kTks1nJxQEwng5z2SvB5mgVZMLE5BrLafDIBfAsXUG3KWmRZ4aLEL+SGT0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 15:43:03.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db46f0f-7be5-4179-f5a3-08d72fbc3df5
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_084308_353017_A0555CF1 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: sagi@grimberg.me, martin.petersen@oracle.com, israelr@mellanox.com,
 james.smart@broadcom.com, linux-nvme@lists.infradead.org,
 keith.busch@intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/2/2019 6:13 PM, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 06:01:00PM +0300, Max Gurtovoy wrote:
>> This function should be called by every transport during complete callback
>> upon successful submission of the request. Thus, in case of a failure in
>> command submission and in case nvme_setup_cmd was called, the transport
>> should call nvme_cleanup_cmd in the error flow to avoid resource leakage.
>> Add this logic to all the underlaying transports.
> The idea looks good, but I'm a little worried about the confusion
> the two functions create.  I remember we once had the idea of lifting
> the pi_type into the core block layer, in which case we could do
> the t10_pi_complete call inside blk_mq_end_request instead of having
> drivers deal with it.  Same for the t10_pi_prepare call on the
> submissions side.

I can check this out.

So scsi layer always use blk_mq now ? no legacy IO path possible ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

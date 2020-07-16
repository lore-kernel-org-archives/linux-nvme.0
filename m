Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B1C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 01:48:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F82B2078C
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 01:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SYCZE/l+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gWqm8BMl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M2Xj0roH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F82B2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7Jcxb2wpm628PRzK62l6eHMfJnnjocap1slNVsXsqLw=; b=SYCZE/l+kQ6DO9i/qsdvcnfqF
	42gWmaMP2FiLRu9Yj4nNtQgLmja/pMGZAfrMh9dCRo/SIwaUZT5n4sRSnkM1BjeYaZpFHFPHnLVPC
	YoIbOlS2H4rXjc842fngH8PCbEtwBUEAfqtC3XbWaQcZaLo3jgrb/1TPq6KVC5FGB+8K+wyHLYP9E
	mG0yqQBZYfjvjBpgYrxOGyYZuDgkctaZvbAvfvU3hDzjfh9GKlXDaZTCfTnqoQsyFdjEu1PbJ0pc+
	RwQ7y7wsY4yRTfimHhPr2w2kdM3A6IL50TtS/L3E5J6RqXSkzxKBeFBpR88kAuJGKkBeD5gDCB5/C
	aK9tljNxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvt10-0001kc-N7; Thu, 16 Jul 2020 01:48:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvt0w-0001jx-Vk
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 01:48:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594864164; x=1626400164;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AZAGmkSjlk0NcL+yMYiHboZ7qcTxYY15/MKCdp2amBg=;
 b=gWqm8BMlFcBAePANvw80IahyibDZIVbHgCUXIUW5c3VbI9VVzvmRxjnA
 cHWKUKIoAN0NnieyppETWYhx33639HDvhoILnQrqz4sRDqNQPuuxNd85y
 06/mZvkh/AMn0d1iCmLs1WFuCecZ7/vJ8M8YTpb5jwQYbgShuo+FLR3X9
 zX4LOqVF8VceskDg0dgFMHhdnuCKSYTZhKvADDUf2aHK0ILwEPPsTNFa2
 slifN2ONYr3YAGbDnBF/tWrdgL/PuHrq+W56pMoNqJwxBejAPsyHNR5qY
 PakaSQC3jtGZtGS9Hxl7mwbDtasif1yDM69jfSMU1sWFhKe6Ut0pwVoHm A==;
IronPort-SDR: Dz4KFwt/hjhIbm+oDfBknypcgrogTr+5moRkYHY0tOMSeH836zeHu7/QTIrqp46GYormyCfhaL
 qDKjOQXQCaDkSjAnrf1Nct2gZUZ32vkNGCO/naJiWdCDbrBQLawWiGr3jNzDdQAiRkt85/feBP
 nx6aSI3DeUlfqw94c6P3wzYqzBin39tdjxNa2IbZDoKbcutp49OBcz2eWh9TpZfxfEzIh202wz
 J6D6PPlhlSMvZ2nTDwvG0onOXxgGW8q+nXdrYhWK0MdyxNR4F2VhNTdhEmWPecu7s1gKo8/IqE
 mRQ=
X-IronPort-AV: E=Sophos;i="5.75,357,1589212800"; d="scan'208";a="245601568"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 09:48:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2J2Jzv7fyGc9vBJgW33KsxpRWRf7eODEOJrxVtSyPj6MGKp/KFaLj+FD7R8GWtdRkYf0VH7fi2Wir3XborMykEG2P+Mn+1NNfSavqFuBmJluDdli7Y4GaT+84Wlqwl/zeiw/3jxzKPiySTuFcddeaELI2AXcSRBRnLJijKZfx2wM2fuZ2KS1AoenhHK6vBFVtpbRJydIMnJ6huV68JfXCHY3UVr9kgnkMwmWLWOpnozTy89of/DLxvV0u+Nc3XVa0pKTxW3J7Rc//blGjGWOYeA8P4WYdonpcHV8DmibNazPY3hkrBPGEumU3XZl6LpPTHIRSrpW3JdVbqyGS9aEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orh3MOID/fs6n+WIc9Ysgi1PsUV/G2T0htViVxrkJAU=;
 b=fSvRtxHnSQXAjf/kghpViuQs21ZY5OlKiVv1pEC+R9endHuX/rozzkMVf9HLRM0cNhzPMkffD4td8rqtxO14mbzPfCgP/LV3IF+pmmeIC/fw00dXzdQ2Qp0KIPJ4CipqbCYpx8VEuw/GMkDCe3a5lbVv5y1DW38bIafnbeNyRTLXO5M6o5ZJFoWmrLTfuiDz+IqPH0O2JqipHWOKVg3QgsWG82U8AWpjZA9/gjwBsLoSkE1439U3fYlhXgSM8mHMpHVqzdElEXDks9kYBVupgOQtCeIJ8E4N6fqTmKbc2CgBH3NQnsVq2GXfJbL+UVJ5J0b263lafH03Q9Ptb9mMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orh3MOID/fs6n+WIc9Ysgi1PsUV/G2T0htViVxrkJAU=;
 b=M2Xj0roHAL5PyCkP3gB66wz0/+9k7OXrV6+tt04hirKVh0lZWxzGg9kUg4B+inaIrEN2DmndkF1OQEdrLPhQfS4spT2/xVGmPCKK5QhmDqg6Wzggv6s520sgkcbg7pRNv5L+Wka++aSfyL47Z8nciIwAPxfdo//XIRUia89qcWM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6247.namprd04.prod.outlook.com (2603:10b6:a03:ea::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 01:48:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 01:48:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 00/10] nvme: use xarray for ns tracking
Thread-Topic: [PATCH V3 00/10] nvme: use xarray for ns tracking
Thread-Index: AQHWWjbfkXJqkK13VEKRp+x7lckQDA==
Date: Thu, 16 Jul 2020 01:48:21 +0000
Message-ID: <BYAPR04MB496584229FBE1C69F5C6C65D867F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200715070328.GA22320@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19c84172-a441-4b29-a33e-08d8292a5246
x-ms-traffictypediagnostic: BYAPR04MB6247:
x-microsoft-antispam-prvs: <BYAPR04MB62474D15A467FF3D1CA554B0867F0@BYAPR04MB6247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ljySzZVFSpAbSP8g1qnt9UYlWQxWMVe9Ut1gyzloEi3EPRSMAjQo6H7tKVSyRkpumYh7kZXaN66Fi5ELQw2YrBNKM3poH2NWDkziJC24mBu4UasdnGKtjo03U/IOexXbFZbtAy2K5b5j4CyB/kc6hNtq+Z/pLm6e9agtQQs5n4Ak9hGLUp0005wn+gs1lsPevHewGTqT7c1LU1rjoFPaY5FIlqURtbZ5+VR3Z7OLFBwXf8wxnrDNi5SHFMjP1/Mhzs6FPHj10MYauw+LWQBJTzy0/bwqDXdOpc6D3snEfwlaGLf/cQHvOWYf06J5NKJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(9686003)(55016002)(2906002)(6506007)(71200400001)(8676002)(316002)(6916009)(8936002)(33656002)(4326008)(26005)(54906003)(5660300002)(83380400001)(7696005)(53546011)(66476007)(66556008)(66946007)(64756008)(52536014)(86362001)(186003)(66446008)(4744005)(478600001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4BZ+MOHsWkb6yFKcZzWnCqrOHiCnqIbMb7xZWQsDypHOG5I/bE485Ds3p9essvoMoaULTpmWtPSpPuiwXbR40eXk0nHkgurRz+ozCvs2caf30XQcTH1/PUmFo4znC4TxRQtspGCjd84yqB7u9i6SeRW1l9tieQVBn4gCSSHQ72B2gdgPMbO60tDLfBFBSIHX3i2Gf/F1I4mlq+96i+ppslj0kv1xGd8PIwuel1ZfDenalpipka4ETpUf2kxAMsnNG2j3LDrA6XsEt8VlfAluvatDvzZr8VTL4et0D82cqVy4j/8jEsdjepCOUAJd3aCbbEnN10plvlGQupKqMiBiXE6y6M46vwhLkbY1Mf83OgJ8WVLJZyJlNIQSVrdtV7npNJnYjwYhhmA9q2L0159/bOGRH2UCsALqcyMEILyTB5b5GcRe4/dyuoqPHWmdOvZ8Yi3f4gO4tqDtnNTEB8oyqPF3+LSU00dUJK42th2PpqM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c84172-a441-4b29-a33e-08d8292a5246
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 01:48:21.7841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61LABfnObCyaIG0Nb+bgf8BbInTAKlj9yFAw6a42S87nUQ/7iI6VCW54KFSerPCPZGSZMNjyvyKNWWcH/fzUm14jWFuk6frEycXkZhOFckQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_214847_405264_704573F0 
X-CRM114-Status: UNSURE (   9.92  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "willy@infradead.org" <willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/15/20 00:03, Christoph Hellwig wrote:
>> Following are the performance numbers with NVMeOF (nvme-loop) backed by
>> null_blk devices mapped 1:1 on NVMeOF target backend :-
> Can you make sure the nvmet patch is the first in the series?  That one
> is obviously useful, so as soon as everything is sorted out I'm happy
> to apply it.  I'm not quite as sold on the host side.
> 

Okay, will do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D4C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 21:16:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716A7207D3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 21:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2KwFTc1h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D04GbnLn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q90KBAJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716A7207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cP3rJ/bwYUk/OenbJEtNsRrwrZLnr813RgS8njXjJMs=; b=2KwFTc1hfaQoHes+y64egG7SL
	U0+DTDOzLgflwCbLy6wzLqZmMmL/ap2P3EjS9gaUfYkLWvPYevw7KNcP5E59hwOeEEkztksrZlJyP
	oKLq11hRQOuX1E6yDp5DUsGoauaRSYNenUGHgTs5pQ73ohAQK+g6aCV1U2qEAIK1NoTF/uLtVVymG
	kO5zS4L8JNT1ExqLvHOlQBBHEN66jN+CPOIWYBAZI4KTVa76cdXFoHQHr15Je9RUJR+ZkPzgKKHZZ
	jCoxSnD8r7DR1avcUQreVW+zuhPmiYwUbKwr4Hggt8DpzSKCHLC6LtDZkhmNEwxKScytJBQhtj71B
	eCHxvMVbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDDdr-0004Hp-RT; Tue, 01 Sep 2020 21:16:35 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDDdn-0004Ga-RB
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 21:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598994992; x=1630530992;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=TIFXX14UgtITnUBXOKY3l9L6+LQ2SEfglWfBw6VsxBw=;
 b=D04GbnLntz2HHU4fGrBCq+7MNC47gHBPe0ZbqkZOPnbAY41ZvVTbuw25
 xkNqnK7lntAOM8VRQk7i44SeWbMhcxNNrlY2Mqbt0suGDID6WdPWZv4lH
 RX4RyyS3FEPquQd5BEo8pZ2dV2s+UtsnfQYbE21yv1wBY29dGV4nU1Rg6
 oloI5yW2TTgT861VVFzE/w3LZdRzunrQClujpkWqaBNSukSQUwLl/kf9h
 UgUgkFTWEmdaP5HUQo1xIo81hWskwaFtTqXkgBv8bPlVtLLf0EGS66hKj
 /RhgUnlgEJHuyQtiXeAgNbTq+RCgK/ldY5e3QJcPIkh+1GvnYLRT7Wlxp Q==;
IronPort-SDR: 8N0d1/1JnsrI5/0CYA5Y9jhvwx9ff1NWAwrs5DcrBY99iD3MVD6ek/RpWuCD4MbdJzebQGYr2r
 huGrEF2R8N6lyggdkhOWe9rzYc1GBhhKPMV0NmaQgcP8g7hrjrqmjmaCtl5kMvABnzUE/YLWS6
 RSrqo4WRoKPNObNSB+1y7A21wdiaw2Wtt+1mrMabeK0dSaU3Xfw9PmtpDEoALZMFuz+paeCb3p
 LiYc7YC4oyrI/NSpbeeS0Lq+So12fA3pXE53fKCKGsA8iZeaMJxZ0dyJyJg6T4COLEhPf1RS7N
 enY=
X-IronPort-AV: E=Sophos;i="5.76,380,1592841600"; d="scan'208";a="147577800"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 05:16:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv82ii4s9OPcOTDiEb3MBPYexJSjDPplEJXiA+TGmz/RLOXaEaVy4laPk1zwowGc4h4Fj3+SPgKf77CrsyknOr2eNj9ZDui0v/cNA2gORlORnb4hnQN4MUvLzOWXpw2MkCo929h8vKW0QgiQf5sVkbXhxLlfw/0PNPX+N6C81WPzxFRMbIv0duQm4L8mGXpvCnucgdcXvrapzr5vzcUC1di2y4IJVkxlBSZML0c/MpkNlpyeQwNPdZlsjUebFeodSaoVnFpLoQQQAtnwRdGi7g8DqK2Y0KjVr/pb+M4ra4Nhfl87LU+qmbxoP6JIYOIbpIfSiuOJpm7b05QOaNCAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4iOzXOzZPaWo31CFxPCKz3on1v1jwo2071y10/2FLs=;
 b=TZmrodIboj+y/xRwA50E9hR+O0US2UHsmGksbeQ21XykhlUPsfHsPm1tMfhX8vyOIu1Y3X0yI2ihaaN7NrZ5drDAKXiDSq8Rj55FQ823EYkSc5Xh8JF+Nz+B1mjF5NBcreKt8tccRJEtYFBjQUl2we7Uh6BuPY5bHK+bncrxOvbRZQ+lE0zfC6pIlMpSyv2E1D1zE/Ga3K5ZwizkIEed3+tSFN+EgGVGgOXjZ/zXHaXf4VqQ8EK9q1RjNc973PAKRritNos7xnsZHzOrGrxqBTPLhIYu3M7bqgixeVpgndY7MT1Hw7/xCTOPw48GX7YopIhgf9R3voWeMpo3x//4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4iOzXOzZPaWo31CFxPCKz3on1v1jwo2071y10/2FLs=;
 b=Q90KBAJ9QFvEfhbSOVWwj6ABslM5XNBL59zYPvq5z4pbz7E4Oz4qCIwBYizk1KpgG6fLGb/i8HhHhAfvuQkiKQglpvtTBhhv0nDgmfUQN0iwKW7jYRxthtLkepE95zBtoxCvcab5n8y7UcQxDm+la3oph4as4PA2E3MDZmPSQKA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4662.namprd04.prod.outlook.com (2603:10b6:a03:14::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 21:16:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 21:16:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Baolin Wang
 <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Topic: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Index: AQHWf+XlK4Ms7t96TEedzmnzF2kEwA==
Date: Tue, 1 Sep 2020 21:16:26 +0000
Message-ID: <BYAPR04MB49657F07CCFF8E71DE1332DC862E0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
 <20200901015659.GA4398@VM20190228-100.tbsite.net>
 <74008ef5-f54f-ab08-011e-0ff271b1f33a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 604c7c9f-c449-4a4d-52da-08d84ebc4986
x-ms-traffictypediagnostic: BYAPR04MB4662:
x-microsoft-antispam-prvs: <BYAPR04MB466241105454648182964571862E0@BYAPR04MB4662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGOXc/ASzny48Vg0jlECZpabZ/ZSjmtXrUo+RToMx1hjdEdN1mf3eEcb5L71Wrl0SQfaRACNU1KLRkFWJmSJLQxV4rbKhQ4vozhuK1QgN+404I3+2UZerbhJikzOJaHW/rsaEBX+2ePzXuiiXl+z4QdPMlEt30IlGa03GANnJkf8rHv/qtWtnwp/zvPnvuhGt6ApRY5Hcpudvwa9RqiVDanc9DTvDfy6iieaOvgg7jIVzvKF96OXIk7ZtIT+k2autgG7VFClu6mgJuq+4S6jekWNevBPbjY1UHmXOwpVAcYpm616kaS6/IoAwgVLiFId
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(8936002)(66556008)(9686003)(186003)(8676002)(66476007)(7696005)(64756008)(71200400001)(5660300002)(316002)(52536014)(2906002)(66446008)(4326008)(66946007)(478600001)(55016002)(86362001)(83380400001)(26005)(76116006)(53546011)(6506007)(54906003)(33656002)(110136005)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ng0LO051kXCptD9mSTp8cQQSpaTE6y97tDA6vhuz+oftz3BAzskcPRHONQrqByXq/+nqt7H2Z51Y2NHWBt3FFCqkoFPX01GEl2i8F9qU4RqRNyoMmRAyUeYrnPeufrKc04ppdhR0U/B7vLSYPH8QENWKEQq+8jKcu16mfES8mOrdzE9aLVBUEABq1pbAimpzgJKqm60bOWnW9qqbv4SIYcId/EXRGVMRGX+UtKgLpVlw4Gr8722XvdBLqRa19OY8Xekd0lcRO5vbqO5xa+JSGW5ayRGT+PI4gz3Chzr3vkI850Xj4c9f1+mUtzkjQHynuABrPZzzrEBk6MgVf7w5RoxRtwQxDymj4gptTM7azL5zAA9vTlNxr4/Mscu2Lh8OKv2wFYfdQLGFU0UICZwpab5NcXemCCy7ukJ0j9xLYiQlv+nKQnX3YDPbzaSaXpUMUJOVPXz7+22jFsgUpidKjGSN7K4MImNHR6hXyGWsuAbe7NWTC7RA2IMwKTMnUIHKJ+zb0E6FJwE7I2s3rI0ukGeHRPOTRh1udc9XJoY/ORE+ieclMwL3f9qy+wC3jwk0tA1+y6LMZ9HTkKlaYRpxRa3avEKM2OGJRGevwmaqE0QLQDWq6j0fyjbU+hIFzca87dniTESASOdSOXjcBP9Vnw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604c7c9f-c449-4a4d-52da-08d84ebc4986
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 21:16:26.5284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5U3VygqTPChmoxUUSGRt277VG4lEi3gIWcaR4QRBaCGDQF39rYjzm9ToSMZmE9k/TeZGc8pZrpBL5DqhRh+x1G/mhpkxOuHEUAONGYn53A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_171632_978815_1D069B68 
X-CRM114-Status: GOOD (  14.36  )
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
 "logang@deltatee.com" <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/20 10:21, Sagi Grimberg wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 5702a3843746..a62fdcbfd1cc 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -508,7 +508,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
>>>    	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
>>>    	struct request *req;
>>>    
>>> -	if (qid == NVME_QID_ANY) {
>>> +	if (unlikely(qid == NVME_QID_ANY)) {
>>   From your commit message, this should be likely(), right?
Yes it is my bad when sending this.
>>
>>>    		req = blk_mq_alloc_request(q, op, flags);
>>>    	} else {
>>>    		req = blk_mq_alloc_request_hctx(q, op, flags,
> Chaitanya, can you check the objdump that the change actually
> resulted in a different machine code, I've seen patches of this
> sort lately where this annotation didn't change anything at all.
> 
Okay.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

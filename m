Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7BFC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:13:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF05664DA3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF05664DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=PdxOU98EUhUdCLopuMZAyfTUyPxK3K35xvQ6m3Nq3hw=; b=XrFj6KxcTCyIiIW9MNonkZUrt
	F/qBZGxvIqZlAolu66fzVQDRfbrXnUmzyc6dvoN9RVyA2P59PB5n5USobLH1j+IyqXhCUoRTHjpE/
	JLF/YDKRaca1JDgZed1OMpmZ/5XTxc1Iv6AdEfBr06a0rBx7qEIE/1tYaOkh5RDglKfFa4lijVwn3
	fHDUD/k9A5E0U9OZAwc4mhpLFRngWIhozCIVOAWBm3uaehZIXXEX5Eu5T8+w0OfMzCLfUsUxfFr1b
	oe3zRMXlgkXN71qxIp0l49XcGwxWVXODz8pjrCQcPXRkJKpg/JoFYS3wmh0ReMoLEbZIvNYetWQOh
	8T/j7E4cw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jJj-0005Za-OU; Tue, 02 Feb 2021 00:13:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jJg-0005Yj-2i
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612224791; x=1643760791;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=yUI72xZqF+V8mOcVaMCDtzk4M+V8hITrU1r5FQMYglc=;
 b=GUfpijoNkAPtsm0Kw/1V29HY6ySFPsR1pVTY/I4i3e2gDeoyzFV/X0c6
 2f9TepLZvoVgfDLw3B1lXr6MOtxPws9EOpuE3/e8tZNv1dga3n8fsC/vq
 6klzs6hxzSGhen0a5SDJ3RMJoAWVfJZlkYzITvZZs+y6m42uCSzkpdsPJ
 fTeIys+imM+4XMA5vDfKhaKt0YPUCeCaHP+/jDoB6v4U5/DQJvLWPpwX9
 jtdFCze5kOCr8U18vzmaqAQlX4WfDJ/fiH0bA+OuqNHNqYcjo/OWFCm4k
 pNRJ7D4E/gDUYkn5R448ucnVwoXUX6ukRbWx9DRjq5r6/sMcdm+Z/KOW+ g==;
IronPort-SDR: ca5dvC0g/tVi7X3/7yu7EU5xoCdZJp+6fbk99UJCxnbdP0uZxAP2fmdc2ud1DS/efvAYxm7bQw
 /CVLQmE1jOdv+Z0RGTdHDhWl6ZN+rAH2sW4VXafn6I2/HBxYQYqrXKdembsnkqc5xCRdAz4FBz
 ZRAL08VhQdgcLd9sfttvzw3g3Tv40cJ5tUnAEJ9jjnefiomVKDatjMZfhg8137G2o0OWiKK52Q
 y3QAvphydPxinbKZOrrp6ljkKplV3a9rxJnl3s16ry8FxNnsa1eTvlxCngbPruLzTvzNtuXsvW
 rtI=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="158861403"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 08:13:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZxMud0je0kit8fuEFFeLMhKP85fQLRE39DAh/L0N1tbmRDn5aS1dsWRdUU7JMJ4bsl7l/uNKPwdX/Gfq76BfzGASNpQsQqn6x9BGora7WS9ufqfCI7w4l0r+M/CcXrgC6BfWmD6r9rOeGaojJQZe6ODO/pEeWtBH7iO08s/z0BC/kDDgSvTmT0fyeR/C5b70XBHWm7CrDJYqfiS2jsNWmzVP0rS7t/uiNipti05aCBVy9gp3SvbzP1YROhtqTD/zn4TlVOBP6zGSf427qhrDi74yFVUt1pAnvEAEXjnBz7Kpt0Gw3rKtY3QTSEJcdmgE8TqKdVbLGSggOifunoW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUI72xZqF+V8mOcVaMCDtzk4M+V8hITrU1r5FQMYglc=;
 b=dKvXl8ohi4Tj4Ehhy1X+AF9YPDAd+wMDxLepg2mYThFXs+1QtZYXCITOKJCIJnrD6gjS/k0u1Xnz7Ejfp+3BFsyHUvQT2uFxswkcWZeFT/+6vUuC157AihtSJSd0HsIvu76S3CtzcSdpZzr+VpbKlLZEyBsM7hRSdFsKffHfRulD70UIA26zMxRBcXKQ2UWAPBDvQoZmWopF6j3Qh15AZ/IH8PKTo2rSkoY/p1TxeyR47bfRyLTJOsqJ6ppFmAy3AJL5yKjw7FFMcT2CTzJ30WDlUej/Myxx5gG4X+IDMjm/74V+FiQ2gDJBFtyU+xYuEBsTv8wxatdKIP8DT0sf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUI72xZqF+V8mOcVaMCDtzk4M+V8hITrU1r5FQMYglc=;
 b=zVpbdiRXghrbCJX2jNfs/FDeu9EwETIPMTPdc4xskc5/7Hs8JB9Ys77eHoVHZf4OSrGWzE63YdO9qr4ZVZvsdJEzGla7lNZbzxvrTI6E354IXIqDNuLnhPYoklrAgguWBagzYUBaTcqTOZQnULfjJ+BnO22DCCN8T+gQ9qHrYJ8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 00:13:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:13:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/10] nvmet: set error in nvmet_find_namespace()
Thread-Topic: [PATCH 03/10] nvmet: set error in nvmet_find_namespace()
Thread-Index: AQHW+Fz/GIDJXW/Ta02tnRwySr3KJg==
Date: Tue, 2 Feb 2021 00:13:09 +0000
Message-ID: <BYAPR04MB49656D0526749AED6B2C6FA386B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-4-chaitanya.kulkarni@wdc.com>
 <20210201172730.GC12054@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7173bdc8-7c46-4f43-3062-08d8c70f52b5
x-ms-traffictypediagnostic: BYAPR04MB5431:
x-microsoft-antispam-prvs: <BYAPR04MB54312B723233F352D096DD2C86B59@BYAPR04MB5431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PnPI1i0sWL3vUc4XlO0HvC+g1iS2YG8EdrLyyj4/xSWt5syFohlDYa2a7rS0XeuSwCiiisUcJ2/ZXbdbYEepi3yl0HTmfOQuz57HUrn/t+gqOsF9+jaMaZbi4XqcH9LoR0K8+6Avy3aim1RFoAjkALsZgvAsSA+oaaaacHrqJKgufRQzStgYigYDU3bEFMg0OOcsP8FoOpY13iRdaGPddx9CQD1iJmN8odmtM2zz39523g/uRrnMWYr/zZd2ScYRa4g4OsECCfbiZWyJ842OLb2bJXhBXYYADbS//YXv/c3a9PFT684yALJZHCoZjl5q9X0LywnsiMR6IbB22zz4Yvn/LfkJR3R68wL2QaTwTyK5TxwY3PHonDBdbd0k1uILdpSmIBgeCinKMW9I6JrX6LmtHGDzbf8AWgckj9l3l/tiuGkONUDb4BVEPPrhElmEPFhgKAaTGxfdd3JmRY49PSZmZOl20w+19WrtZxj9EW+b8d/NIXyk7aaJLCyiF1lmEOPlflO5dFHJxSq/yw5Puw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(64756008)(66446008)(52536014)(66556008)(5660300002)(66476007)(8936002)(558084003)(6916009)(53546011)(86362001)(7696005)(8676002)(478600001)(76116006)(66946007)(55016002)(33656002)(71200400001)(91956017)(9686003)(26005)(54906003)(4326008)(2906002)(316002)(6506007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4x0jIFXDE8ArgEjC/vbq7S2FP1asu1tEwzbQ88ekw+UnfpMDjnMCwv0fNUgs?=
 =?us-ascii?Q?bHRJvWB0zy3IAi5njEA3RXJtFCxXlJ+AxycA/+HcNnFsK1cfn+EHaEgCGFgQ?=
 =?us-ascii?Q?3ts2mbPZk+UnTCjKnypYNOD99dqWEpOCu3y0BbtsnqD/RV9/5aUpukmPygR3?=
 =?us-ascii?Q?OyWnneirRwk8+WTq0s2uN4q5miaUQRwAIYKMB+gsHJkNMNDwK6rHXXyEKfHz?=
 =?us-ascii?Q?5YeYnar9RNJHn6j4v35eSSkGPbo3TBRZQu7pmp3jXZMP5Gcv5RaEVPK2Lp8n?=
 =?us-ascii?Q?0heqrlEItI1BbiNwkSOKMxP+iHwkV7DUGMhsYPYXw990fTqwaml6cH3fKTZr?=
 =?us-ascii?Q?AEK/fGKE06t3hZviLshEmYWSX25s27ruu0vAYr+JfHXo+J66DpDG36sdE0F6?=
 =?us-ascii?Q?fgZaQlzEAqoeZ5PUZcB8BcxcNgCd25cgQqvhc+RFHu0439pfzedD1+zgXgsC?=
 =?us-ascii?Q?l3/KsKqb5MZDO3nTKUwnnFQPhxb/7kFn38RNfM1LWPrrwmdOtlKjE/mj+Uo3?=
 =?us-ascii?Q?v8oCAncI5tVp/8+8AFyV+gUKAKeW+qQenvhoFFAx4dfgdVFGG56afBCWOeFE?=
 =?us-ascii?Q?cGjADGDfXUhZVftre/hBm0FWOK1/MypfUbrzKNj9j+UDWYSIisJqMU7/bUb4?=
 =?us-ascii?Q?oyNumMPo6/AqU6ma5rIDFPY7sVtdZAS3pvK36vEwo4Fbz4ZR6vSdtfHbRVIV?=
 =?us-ascii?Q?92IyoBlyL1YnePVuKVE6sTbTkoLvOJxxBl1hKFTbr4EF4+cbmsthi/Vt8Bca?=
 =?us-ascii?Q?ZH0Uu0BzP9NzFcnFScf07jtQ7lZRXC05a69DTVakzOUEuZkXjBBCnu9r6YNk?=
 =?us-ascii?Q?V1HWhfaWch9GSej/ZTJwMudb7lS74QHXjaSjzHtD+hK6pXTMhp79btTVFNY5?=
 =?us-ascii?Q?BIoGr/O8SFtu7azAiQ2NBH/87mIU4GeOZs/lm4AdCBHgpMf6931u27Lb+heO?=
 =?us-ascii?Q?/3lhEYeSqxkdcq4Z4UUo5BbplPlHAgN6O3olhXxED6RqWvYFJipoKkSA5L47?=
 =?us-ascii?Q?ULjOJLOF+9lLNYBcD8yAMlrLklEJnEJoVQz9ynpTABEBVkXYkgG12cH4V+yl?=
 =?us-ascii?Q?J2PDMw1wrigSV9BHqEm2qlnbIdej9Q=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7173bdc8-7c46-4f43-3062-08d8c70f52b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 00:13:09.7409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIH8FukC+mxaf0HxB+D0+Ows13HjCkbTfm8Q+K6K3FSof6UNAHNIqyEYdQkfEgciEz7mRj2x/nfq9HUBEb8Yjp3lRHE4GoD/ylJzodYDqGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_191312_291591_C89EDD86 
X-CRM114-Status: GOOD (  12.63  )
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

On 2/1/21 09:27, Christoph Hellwig wrote:
> This does look like a nice cleanup, but I think we also need to
> rename the function now that it does not return the nvmet_ns
> but only sets it in the nvmet_req structure.
>
> What about nvmet_req_find_namespace?
Perfect.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

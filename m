Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E0AC388F9
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 23:23:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1708724198
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 23:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k195Jxi5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BVPxUtU/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ER3nk4A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1708724198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=oZASpawzTCVTOQZO24x+OqmddJHrV5eRB98PKX8MOec=; b=k195Jxi5t3oL9IYnIjiFSxwDP3
	1ffVFbHK2OgS83ASllXTN/DZ3tripbVKRFYRCLOWrbIa3TA+7UDX2rGG1OmM0C2E0/TjWEhiMGksx
	dUc2a7xlHz26LBEgCyTBlq90Z64orYvy2JsC67ptm+1Cxg8UohKHJKNK+137u4hj5k5unKbTbOR2L
	olPIfd1j3qA2r48Kfas6EmQvjkeY+JeKwB+W+FhqPOrBSH3pIf3HDOEBbLXIct8in5HB5AxwDm2El
	kSnQlolwZAMBUdfqddmn1NERSfdrZwepePhMZ+6lXgE7HDmP0UcPGh7Ewm2LCUo4kPeN9wbr0MnXF
	q+o0pF9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kenqY-0004St-Cj; Mon, 16 Nov 2020 23:23:42 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kenqU-0004SE-Hn
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 23:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1605569018; x=1637105018;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HkQU9TLIHnvXGse6liEID1JUD35XhRn8v3jSaa8hjcA=;
 b=BVPxUtU/S0lnzKNKryvw1A52Ci3CtAAoqdFjWcXrS7YDFWWCn+geClEf
 y0xNkRXtMSCUN976Ix4GgmZtHu2XaAd6MN3PNxGMAIPWlAYILlKAMhQ6j
 oRhuv2W78OQ1UrMeL+FDvs8lkmNYzuZ99Beumuwy9lleH1B42LkwYwq5M
 tkAsFdc9PLMx7n2niIgTtXwRqROb1+omSVErmviC7noeuHVguBny3r78D
 ab4dCFT5z5+XWxmlZbP8VWZaCq7ZsgvVpRiwjx7cMTbG3q8G9S1YCY0JE
 TcEQ735RsK13qAQB0vi4eGh8locYPrSAUQ+S0+IxNovnqTg3WcviM+iZI w==;
IronPort-SDR: h2pkhbaFluAC1BN7ee0gs24r1qjon2I00Sl2gnV+LR0+huew9mBjh+e/PZuSQfQeKxoy5WO4fl
 JEjMVE16OQ9Y+Tn71s+XXL4AYNbanabLpG/TA71PmvGX1Y9ktBlSkCSOTq5lpMn1j3uuDkvm9Z
 d38ZKC6yZVo7K9infEnX3UtOw487SYn9S5yXqhcn7O142aLXvO9+U5H6mJoznGF8pzuIj58Adx
 BotcMmqq2OCJBTJ97+pXUWfhMadYMSvIv2XQy4LhbNC5CLpqFTFP4HcRsANz00RdSyml4ZDvv/
 8Ew=
X-IronPort-AV: E=Sophos;i="5.77,483,1596470400"; d="scan'208";a="262773617"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
 by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2020 07:23:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtZ1gLc7cOErXrGZHOJf4N3M1ngFyRmPo6CpPZqfJO9qPhvrWEdVRMqaW9PbpZlcSKcD6oWj7EK9heRy5cx3yaJmRxiwdIHfzOFU3Ct7b+br9KB4+8HBl8mspheS+K4QmH2J5jDzqj1R5GeD/HGXQlmemUbfWTCbjWE2o4vs2XWRWp9uu63J3VMYfjpieip2t8V5GvvC96U4X9AHyWilRT1/DZkOP24KyVTYsqrfGYVr0HbNCzxZtoyhFMa5SrjtJUMLM/eWLi/3UVhR6wrjNwEG7PlFKsjw1MkjqtGy4Kp9nk9F+MKKvLyp+3c8hd7+/FqcvOpdR4qUkhc7jZ0euA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkQU9TLIHnvXGse6liEID1JUD35XhRn8v3jSaa8hjcA=;
 b=lDOf30vnlQHeZL5+VDipujhxifYQ32FKOLqu9mFNVAZoh1kLVYendLkSttyg3FPXkJSNFySCwAC1KBfacAUTwoH32Wt96BoyARhBFKgVodCN0+pFgKGt6NrsIZuszokJ6CSSyu1bvqZ5h4X2jasVDsIejL/KEBb1hkK1Wj1Z6LoSdVOscSePzswDG0Vc8g7mCo9fYznMx31szH/Bhyxzi6vmRTy31BFoTfNtMkHCA1giVLwHL5nCR2/vTMS/Yi6Z2gRnX27oxcSr6aQMcYdtIv2THvYLl+41ZO2oDgigSm3F4kVozX6iSQD2QogCzlaoxhehQUbOqHK8A2AFLeyXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkQU9TLIHnvXGse6liEID1JUD35XhRn8v3jSaa8hjcA=;
 b=ER3nk4A9rG1h/SP0XWxPgedPBT3SQ+1X6qKEYctBKzMOw03Ea/39FnKVa9jtX5QX0/jUypp0GSRkzcDISlBaU2th5wAlpxi++94vz/wVhW/cxa2J7GeTYG9fvCiOihlicBVS/lIAMxpXl1d2Cxy0vRDNGbwADDtx3ViXnHe9+fc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7694.namprd04.prod.outlook.com (2603:10b6:a03:32a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 23:23:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 23:23:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix memory leak freeing command effects
Thread-Topic: [PATCH] nvme: fix memory leak freeing command effects
Thread-Index: AQHWue027xy65zLFAUSMSz9kkG6cJg==
Date: Mon, 16 Nov 2020 23:23:30 +0000
Message-ID: <BYAPR04MB4965BC005B917A995976649386E30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201113184545.2707853-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c3bd3a2-e856-4e82-9d33-08d88a86a11c
x-ms-traffictypediagnostic: SJ0PR04MB7694:
x-microsoft-antispam-prvs: <SJ0PR04MB7694D3840871C92E5B54D5E886E30@SJ0PR04MB7694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYooQZwUJyniNdSqS9CYUFPsttQU3HZN0+00g8rB+7RypVq0+OypozZexFgkb+Ee7rXtFsQh+gL/owjyulkY9OpJbv16Q233qZBjBmKGQfbUqUKAGXHT/pdVC+a5Nq8k9Je+KRXF0dXAAusdq7DUiYnbqTvZLrdRsElHVTPqgiIOPUSWiLOz/3rbjLimApi18pqsn90B3lCaoCnT/Z0flgXRguHyHt2XjwoRRRdGB5wpDvHo4rTF+JXwl+L4KCf+V6klTRbcZqeVXfbPr6c4ni0Ez+qfSkC4uDvdZcNNYJM3MtmdmhZIrRuwcj/g1A0qSuueStrOKHrRBxFJJ6KjNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(9686003)(8936002)(316002)(186003)(55016002)(2906002)(110136005)(5660300002)(7696005)(52536014)(86362001)(478600001)(8676002)(66556008)(66446008)(64756008)(66476007)(66946007)(71200400001)(53546011)(33656002)(76116006)(4744005)(26005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bEyeR43m0Q93cXBt+JsIaTUbTp9e46wJHuOXRkh7S0NIQiLA4ZbMhGks7/3ieu6KL/vR+YEHYmBUteehzO26Gm4f4QA86C1GRxRIDHtYaxieCWNxnEsPFDqXBANjmNmBKzNradWF9dCx39ZwW1isB7NS+Hf15bXKqWHtKq6TWu9v+5zkZWackFI8pmzfcha0sbCFWpoIx7tvWAv2ENXWdbpJzxT6ctK5Isu9K8TROuVS9L3TjJUBqSrwk4qyDPsXj6aldKOMConJb9BnjG6GfCQq1wGL4uYmy8Jbm7iwQRPrfz4k+fvmw0+4hxstHlvfiW/x0Z8jai9PXsmE124IDtVCXUi+yps9ZO/nloPfpd+bbopgBsasxJLoJgk/QmDSekNlQYkWz0sSSl0js6rdlX7EhGPz1MPJuI549l0eC1W2XIIeXHg6vXse70cJuoNV9rm0KSyBvIdTCkpAKl8EKkOkC8LgwYORCtf3vrd/JKGCiWgkhUrU+wHbyrTiTzVpf9J3Iti0VCXnrPzrVX7khYzuyVVzhyM7UHSvAvRVFtzmMBKFdkifgKHtH0pt5Zcxo5Y8wnBALUG+FKdDeg0VdAzQJ6gNdT4wbYjWr2l5lJBcpMkX+/pSF0h/Zcy48OdxE5NhW6lcQRDGhb6aaXFWng==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3bd3a2-e856-4e82-9d33-08d88a86a11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 23:23:30.4483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XR5OvJFMGNHZfzM5Ji2iv1SJJheCfWVXwncZUnEvq72VIUFCp2xIyJnnoqI+paY6pK/VvrlujSq8i4v8kHH/P/ArpV9jI831B30lzWhHEWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7694
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_182338_969082_285F1D72 
X-CRM114-Status: GOOD (  12.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/13/20 10:45, Keith Busch wrote:
> xa_destroy() frees only internal data. The caller is responsible for
> freeing the exteranl objects referenced by an xarray.
>
> Fixes: 1cf7a12e09aa4 ("nvme: use an xarray to lookup the Commands Supported and Effects log")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Thanks for fixing this up, it'd nice to have a common helper

which also erases the itmes from XArray so we don't have to

repeat the code to erase item indivisually.


I'll see if I can send an RFC.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

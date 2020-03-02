Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A45C3F2D1
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 03:31:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D77A24672
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 03:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2cUqVs1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CW1pxJXC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fmVuXIF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D77A24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BY4ZEmzs28F6eYIxehPxg8GCFQrcqY/vI8ZQU/Snr6Y=; b=l2cUqVs1LQaOCg
	j1s3fSeDdxaGtqVThos2PrSYZlruUZ3x1Fq5QlxdzOcOIIuY6+Onfwl5XoqG5x/REyTRbp6jxaBoJ
	xwTh7jNz4rOjQuY54ZQhG5jV40qUa25Nb+nmslLmmUXTrvre76V3GatO+RNiN5CAqZu4beEkCLCdA
	ATJnN1Ct7uyhkxjCsN3ui459SM4Y2rv3P+2CQAg0RFEo4qBf6IurCgpIWZuk94lHhtf+Tqh93L+44
	pU/Ot4VcoI5CtFLQEWBG13KIUhAmHC1FFPp+g4XtWMNKmOtVtp6ghhf5l0+7rtyXKLUuAcy1/wMIB
	YFQWFVSDpZ8kjz2349bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8bnG-00041K-QK; Mon, 02 Mar 2020 03:30:58 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8bnB-0003x1-Hd
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 03:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583119853; x=1614655853;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=E620ZeHN9+Z72n9pStFn1ifZvqWe+j3kiWmBfcCyVsE=;
 b=CW1pxJXCIi+NDs4YL0iKUmTODafCiisc6WcByip+4FF8o97CWFZw5Rym
 ytUP92YXfZALnFkISVqjB3OAhW9Mu+8E1pEgIVCRymITrrRAOYlZzx6RW
 8eUuFXLPnHjzJ69m/KBcvBt8ZCAo8ghsXXOGfLrlBvfIhZjujb6M0ILEv
 5GISIB8Ec6E4eHcbevtjRrtSO8MTiyVpkX8ftureVesFayocm1LvLyw2C
 Twd5PnWpka2rhgadgOtFAaUHc3tJun4DIG903kWSqUSmCil9vGnU+2Wnj
 jz4SrZAGgRgKRom/Uuo8kCUO+ZrguvjoKYUcUjVAmmOkv70leFrIReloN w==;
IronPort-SDR: gaB/s+wj2YCj9cqeHuBjQGrbVz+YkVFHWAFk2gYQweEDQPHtr1Vobf6+d4+jrJJ+t4LkejhFeb
 cgiafx8gHLF+tAofrV8TkKnvXQVvGwHwEU/6SNqA9B7h0hHvrReDAwf6iRTv9tcKMYnQy08U1N
 PyU+fcWpiCzanhzlwBWxxmbNxkM1PR9KX2S2KZxkpOaY32HKOxGyloJ+qLu3om7BZkLXxVmd7I
 u7RQkXnk4H7lOjSbFHmDk0FM+w+TKLaD7zI+7PSTVqv8b8wALOXgMADBFwCr0gRdRqg5utRZmL
 X3E=
X-IronPort-AV: E=Sophos;i="5.70,506,1574092800"; d="scan'208";a="131116400"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2020 11:30:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAgcb9uwk5ZMIAVKV93tsp58risVBDac0VzYTwP1/yEjhuh4Gs/LH8iUjFNWk+3f2QFzUTtQzl1fmaiYtJPrakhcadJHgtnK1cBnWFXoI9YcfpaqIM2d4A8YKHbggUJMaM3QbacnYF4qm0jt2ClfFSHcBxxzaMTkdBep8DvAtxzI9FJtvd+XFjzwcPl3D3AXpTkIiDyEM1oYdfCQsee56TbDtgvgV5ccJ7olg/He/VwyVYS26IIIGJ6Wl3731fuBTV86wjZU93PCo6SH3ffCs6dxCEChgfDc+Qqp1fy2Y+v2pGqppyfwqnYUCz5HPD+C5BejYj0FlLCakk22Xmi5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E620ZeHN9+Z72n9pStFn1ifZvqWe+j3kiWmBfcCyVsE=;
 b=Jqtky2mFPZAzumRlk2wOIzyQaxC+nhWcZWsrQw6XlIBo8a5wdST+loP02uOViZZxnibXTDJ9mr4qAQzrgu4BHDsiVS50+K7JtxvB6xzEKn5ksMypewYA4c/TfZsTlUHYB+ToGGesfllze0BE9N2cgwswzgWnX2YZUFK5SmV5rBu0nD62Hr6sRmueB+KULVlJWfsjf3PiCvmNPTYyPUAyWYOuygyoVJXt82kA5aphB6JUckJYxFMxdx9BwrlL3go7RPSVnHBkrvzh2k24gyiO57u4CyNvFT6G9DC5kKUfbOZX/qmdRKhxATkLabbW60p/kehKp5ROQG99XvJTKvmMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E620ZeHN9+Z72n9pStFn1ifZvqWe+j3kiWmBfcCyVsE=;
 b=fmVuXIF1WjpYWXwuIZ0/uxLX+b3vNcyH3zAVFKRadU2khY0vtbR8i5HDR79xfvjmlkY/FAJCbe44JRlaO+aJ8yxGyDSSS90b8fnxCahlGjBXxye55VekARYnRX5xg7S/fVQZq1sT64yYCtsCDyw3FE6VznkPCyq47Hew0j4vUBg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4679.namprd04.prod.outlook.com (2603:10b6:a03:5d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 03:30:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 03:30:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>, James Smart
 <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph
 Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v3] nvme-fabrics: reject I/O to offline device
Thread-Index: AdXbcCoP3Iz9GTcSQ9G2kH7D3alHRw==
Date: Mon, 2 Mar 2020 03:30:49 +0000
Message-ID: <BYAPR04MB57496DB7A3905FBC85A75B6786E70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <2d77d20698b14aa6ae261a71d239c50b@kioxia.com>
 <20200219152849.GB13942@infradead.org>
 <7ac74c23-db96-56e0-ad6e-24bb4df1934b@grimberg.me>
 <f1d99912-d177-85ce-7ebd-4863cdcb2a36@broadcom.com>
 <57375a469831480faa022a5593dcc96d@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2850f63a-a32b-4264-b28e-08d7be5a1a31
x-ms-traffictypediagnostic: BYAPR04MB4679:
x-microsoft-antispam-prvs: <BYAPR04MB4679C1DF814439CA59EFC85C86E70@BYAPR04MB4679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2906002)(66946007)(55016002)(52536014)(186003)(9686003)(8936002)(86362001)(33656002)(478600001)(66556008)(66476007)(71200400001)(26005)(6506007)(81156014)(53546011)(81166006)(8676002)(7696005)(54906003)(110136005)(316002)(4326008)(64756008)(5660300002)(76116006)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4679;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nP6ZVEfV/22k/LX0Ek4JoP78T1ElFXSGMizOxfEvzfjMIoDSl/0nTYZL9PSKMS7HGGBIvDMudbM9J6OIU3pFicDeL2gsaStQmnI89oSfx8y6tkz3nQf3rhsFEXgrEfqiLqlkt2DaSHDZEidetDEngFyWYhtlVV7MqhLE7B/NwXVlE7vP2Hjej9PW9YExdSCgE1Ts5tvm5EMYuH2dZg9FxJT5BFDgpAXVSbSLMwErWUCIQh1AIdY+nTwfQjve/7Nsxffuj7xb0V8vc06UkPTC/mj661uSuqDy2vdrZ7jreR4zAkZRL6U6GFo2m3Nn0kNKC0bjJJt8DKFmn06hcmpmgF4DmJjNPIAovbb7MfdZhWXL+Q4F7mEoGEFLlNYlu+1EVR5rdqPgrROikQEI8pOROp8bwkzrE3AEBINGlXVaSbdlQ6s/Qzzt8W3tH2HFqS/W
x-ms-exchange-antispam-messagedata: 09JBI2pQgzh5WBzqHGNg6Ysqm4OzsTGiaJbi/CzJhgjKWdaYLd27RhmB/Z59aDIMe/waB6pimYciyicvy2XhBJlR+NEM5Pd3OPoF1zWKd+ESmYd388u5qrPCv0qU4oq9CMDMpe7TrYIsvRZu88cnQQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2850f63a-a32b-4264-b28e-08d7be5a1a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 03:30:49.1133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhmUlWICjRZy5JVfn81cy7o0VeIxFgymZorkm50I4bI4gTcuaUwIZWjkXyQPmM2LTkWB7Xiu7vL09imkIbGic6lS3zG3UgZ2zVUQSxFVP6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4679
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_193053_632048_7415CDD0 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: Mike Snitzer <snitzer@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When reviewing this patch I found a bug, along with some
general kernel style fixes. Sent out updated version V4
please have a look.

On 02/26/2020 12:53 AM, Victor Gladkov wrote:
> Refactoring according the last reviews:
> - Move call functionality out the state machine.
> - Break long lines
> - Change parameter name from " fast_fail_tmo" to " fast_io_fail_tmo"
> -----------------------------------------
> Commands get stuck while Host NVMe controller (TCP or RDMA) is in
> reconnect state. NVMe controller enters into reconnect state when it loses
> connection with the target. It tries to reconnect every 10 seconds
> (default) until successful reconnection or until reconnect time-out is
> reached. The default reconnect time out is 10 minutes.
>
> 1. Add a new session parameter called "fast_io_fail_tmo".
> The timeout is measured in seconds from the controller reconnect,
> any command beyond that timeout is rejected.
> The new parameter value may be passed during 'connect'.
> Default value of 0 means no timeout (in similar to current behavior).
> 2. Add a controller flag of "NVME_CTRL_FAILFAST_EXPIRED".
> 3. Add dedicated delayed_work that update the "NVME_CTRL_FAILFAST_EXPIRED"
> controller flag.
> 4. When entering CONNECTING, schedule the delayed_work based on
> failfast timeout value. If transition out of CONNECTING, terminate
> delayed work item and ensure failfast_expired is false. If delayed work
> item expires: set "NVME_CTRL_FAILFAST_EXPIRED" flag to true.
> 5. Update nvmf_fail_nonready_command() and nvme_available_path()
> functions with check the "NVME_CTRL_FAILFAST_EXPIRED" controller flag.
>
> Signed-off-by: Victor Gladkov < victor.gladkov at kioxia.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

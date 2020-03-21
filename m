Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A8CC4332D
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 00:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34AA2070A
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 00:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ltQvwBnu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CTZeEIuf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bfkE1Uvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34AA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BQo3QFBbG488AARy689IMmDtsu8hPdDa1LjmOcJQ1ak=; b=ltQvwBnuM6k2N+
	5oZN1qKV6flBHZeDEFt3eBTfFbys8ady2mW0xEBMOHvashTjtPIEwtZHhmnzIIE9ygd8PI7ZqEOdx
	X5OVloqa7Bnu2Vs2O+7ETPkTkwg6F0a5Nus9XpLTQzNiVWBzKBHGcVAzGs1IyvHXQEyBMuPfULZFj
	6VyDr62brxA8WoRvKxdIXHzEk+akPruFZ9+VjVttfYIh9IbU1Zw5VbQdQb2YfyWrST3g+obU82Xrj
	0PTAFSXabTzHxqFj78bV8CHa1eEOSdU67dy1HFE+dP+stqrjwXYaSALM5OZmJw3erjD+p7Q3X/lF3
	X31BNq2MqtLDJcyy0OHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFSIN-0002EB-Ng; Sat, 21 Mar 2020 00:47:23 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFSIK-0002Cq-T5
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 00:47:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584751642; x=1616287642;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=KxvPlm9zYi0Q5rRDAWuCVTJvFM2jycHgjMpnIhZXefo=;
 b=CTZeEIufefUjgEF/G823vAMqSZd3MMLwkpTtdCZRnU7liUEwNCTr+/Kl
 H3jnBpdpzZv3/gwflUOBU3r69TGF0SQHCUwpGJQmytesGZC/4Y8YdLjjt
 bIR766CT+56pkjjOh2Ff+7LrX9ZYnCDozFLZDkbJ8hbCEZ9rLgp9XnBo1
 ye2nFBnZD7S4EEKWRj/Zjq5zH6y2wEGqbjZdC3c5zMMzFvo7TV5IqeJxK
 FoKK00rpJwK2Ha8Z0yLGMSRn34APr3DnkjwPrpZf6rAtizn10Rde0HmL/
 lr0jXnUBpKDzVP/pDKFdEy3DOgXcCoQRUVqQhe9ZaLurkqyH9/Lo1cPWS g==;
IronPort-SDR: /aHPkU1erFwlcLa0d/cTF8AOJdCQHCN74AiNHei6w7vuD8QOV0X9MRfDu7Ae71exCr35flYuek
 bLkic15G20fFiO/98G6nb5eTIu4dV375wvS8efmAXMzIqjLWVU9OsRsl5CX6kdWKXiX8sSrX3q
 VDyEQBQsefUX3if7Bui03fukUeyW/o2s/slFoQs/xQRHqcRW8sSdLf4PZK9Zd3PpgsqhpqMw0j
 vsrEqBu+jKFrbu5W3sB7Shc9HJFvoOwrcfZj1H0YTH0e6o91DT+gCknmObsE1RrtHrni/Fhei2
 WF8=
X-IronPort-AV: E=Sophos;i="5.72,286,1580745600"; d="scan'208";a="133553410"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
 by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2020 08:47:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgl+uIxpI0V1wgpw5f/0ncHFEPQanL9uqlzgc7KeC6KkcMjKztUYvBB1aHSfOEMbSzcsi2Z+pP5BYDHARqiywdLB4r9+K4QlyrgN4loUpbJG2u6tLfMsmM6//HvP64Ux2hzlnZgT8ZjFeqpGmzyp6UjW8IsBNUTolqfyL4Gl3cEtLDvp1c8uS9hzqwKxD9F6Rn0ywySEfAC30WalGZFrqavJJKEorHOuMLkVMOy8AbONfIjEf8d11PlidxxNdVyNeVSEMMNHnl7twxBTxAQYxVYk4dvi5pSdgj+AhCQq+cyI8ad+fT7ge3oSTqXzOYRAKwLZrGUoAJdMv58KTSzA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjtFBbTd8Q4NjWPTWi7ZdhTxCknFurQQHNHGRj4iH1w=;
 b=BPW7q4nUhE82KCZ7zMVpC2WcutmGAkSJ55lxMYHHFyywu/jxzvIwWQvF5JUPJ3nNy3v833F7aG5rivjMF1nskWKuX+e6VG8nVp25lzyfxaTInqq0Ny1YQUj4PeiAShUW06CEUhzVVgeYdSfWUktbq6YWiTOFD8E34+8owC0s4EsCFYKROMnvdSkmvpa9qTezw82qG1MG7FuEhukzDHzBMBt43MN7nmLV3wGwO7P/d8ETAT79vn3/xV1UgQRE4gQ2wDtR4cLloDTbC7C177zUZO/XdlVMTSLD8HCp+yTQwUsINW+204rSmzXP+k8381/0YWlC1MVUdCOMAYmliBJLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjtFBbTd8Q4NjWPTWi7ZdhTxCknFurQQHNHGRj4iH1w=;
 b=bfkE1UviP3yFK9cTEvLbUlLVaHmx2ege3JfmO+Jw0p/QtSb8XxULzRohKRTmZNljx8c2gtekbb7vUiuNBaordnJplyPdDh1pQJsyvSabsWNg21MwwN7ppg9d8IqqRdvQTzCkm7OSHyMyTdls9XiHc4ExwwWX0E3w1cH8Br5GdBY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4534.namprd04.prod.outlook.com (2603:10b6:a03:57::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Sat, 21 Mar
 2020 00:47:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2814.021; Sat, 21 Mar 2020
 00:47:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Tony Asleson <tasleson@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/6] README: Update URL for configshell-fb
Thread-Topic: [PATCH 1/6] README: Update URL for configshell-fb
Thread-Index: AQHV/vgX9IvKvv5qy021KBxhYeuqhA==
Date: Sat, 21 Mar 2020 00:47:16 +0000
Message-ID: <BYAPR04MB4965D1F97C81DBCB0855646C86F20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
 <20200320203946.37338-2-tasleson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19e3f27f-b2bf-451f-234f-08d7cd316799
x-ms-traffictypediagnostic: BYAPR04MB4534:
x-microsoft-antispam-prvs: <BYAPR04MB4534C7E8D919A0C1BCA0629A86F20@BYAPR04MB4534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(66476007)(66446008)(64756008)(66946007)(76116006)(55016002)(9686003)(66556008)(478600001)(33656002)(86362001)(5660300002)(7696005)(316002)(110136005)(52536014)(186003)(71200400001)(8936002)(53546011)(26005)(8676002)(81156014)(2906002)(81166006)(4744005)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4534;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxfyi3EIfzCguBMhK/Hs8AkucfpqmkuadOSlVIqsSwCq3ci1qCw+cKDok1BEbq7ZuSfl0ixXbwLb6oIWHhrLdDmJNfddo1Qm2Lik6lTMRKONFfooj72qNHFzxRww+yAMQPo/6WTgN83bpEXw6ndsIdWTsAvU7adsbMj6Hrk3OIkSuPPKpNq14XQ3i/BCEQHmhuMZ5/7vIL8XXxAAuDM5dyCriue91D7XQgmzS4snHbwRz3mcELTRfZd0uzYI6bddvzLH6ahrLBLIbhGbbuYwn9ydCrIMOhF3UkHdV2ZvKwSAvoQdf99QiAJiGs6ZXDm+dc8jair92KcsY4Mn0QcrOVp97m/TxsfqID/wzwfwLlbdxiKI43lcn3xFX83gbmlmqGj/Zdu3AONxHtk8PjVo0CZQ5zFpdSxnKGDo5JsURWT4MDb7IIEDGiBLdhU56T3zYsZqdgAlm2Tk9p/JSpV4Md1W+hhFFkM8VvHnmKqqu7T4RHYKeg3rsJnxwg2fq1NQ9gKeueLBaXiaqq0OaOnVpA==
x-ms-exchange-antispam-messagedata: 8CTE0EokfQ/GWJEPEgtQJLRc8L/WAdO86l8lIrSa8JCgl060RgARAEqj/bDnoKF6ufXtzPPKOf4qWGgIcFkjJE0osPwYvOYgqkppn26DSrV661zver8dzzFipkCPM4l0IweZAe/4+yzXjzqyc6fxZQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e3f27f-b2bf-451f-234f-08d7cd316799
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 00:47:16.9886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGjRy0+BbhPm7PqtP+pIPzbAc5+Jyb38OVtFewI5l3UJqXF3EnSyi+SYyvjR4SGCy+mWg/vBYzqOMduWRWPj85gEbIZ8fGI91rmOckV9FOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4534
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_174720_944148_165A0633 
X-CRM114-Status: UNSURE (   8.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/20/2020 01:42 PM, Tony Asleson wrote:
>   Installation
>   ------------
>   Please install the configshell-fb package from
> -https://github.com/agrover/configshell-fb first.
> +https://github.com/open-iscsi/configshell-fb first.

The link is not broken yet. The agrover is now redirected to
the open-iscsi automatically by the github, so do we need this ?

Anyways, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

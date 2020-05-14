Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64CCC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957E4206D4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FbjUOO1P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TC3OGOuU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K4EOhW3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957E4206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=B6DipcSKDvYMoKYWMXNiTog08TIWbfj6LGtbaSprxG4=; b=FbjUOO1PaJn1WS
	hRlScGcncL1iVBp2mAAuHTfZXLBdA/JAv8FedlI46lPTWygoTtvpm373ydoEKpAG2Au9hnvjyKxy+
	nlhapZYZhQbIx7B66LyFLkLsRBQopulrRYZdz/QpTxEfVc7dyzieeotDWVthY3piTv//Hem3oNklR
	pFFvk2vs/aewpjgjL6Bb0Sd48POFnXP7snwLXUjhVcjH1qWGiyWzas1BDZ6WOG3F28rvIhYAArj6r
	KzDJhyJPbeo6DuubUKHcQdXIMbcC/nkZsKu1eggpR77IA6Ugc5N4wJUYgquF9fmBe35hMPuvHyCvt
	Mgc28dxGOzpMt3ex8v+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ4qp-00058E-5V; Thu, 14 May 2020 03:48:03 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ4ql-00057c-Pf
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 03:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589428080; x=1620964080;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IaixDKM1i72KEBLLga73FG3WiKfWeMn18qdDpsgLbgY=;
 b=TC3OGOuUAYUD6tgV9o17eewa9Ux1krExH9RTYfC4of7F2CwkZARAYiHS
 ki9DRaS8fcONYDIgbNgKYj3SzkJB66ULUGx5xOxw1DMR9oFuA/hwAk2/m
 fIUcixhswc9cOG/ChivqPNlIELcezv7RwFRwX/Fi5Qky8Ev1/7Oo4DibS
 ZZajl7JDqPH6BK4/oUFahK1WhXv92+I7n7T2PX3fXXNjMWTqVuDUXa+QT
 BuhhzkLcRGDtqEBzZGsDokzJuTlYX1PVgtH77t/hG1SEdKaX1630rEWGJ
 SGm0KQfYv/z4A+HVh23eKgseHSDfw2zFzJoJ5ux6i0kc0yDqnORSTwLn8 Q==;
IronPort-SDR: g2tCEQMd2rtdoFlxY3GqqxvqdlPXyoBC+inn7W8s4eQt8SEPhSyaapboz+AKrqKZB6xbAH6wiz
 //IPfj2gFmZP7VNe+wpAsufXcl8WlDecAMXjGdt3MBwgOo/dKUMFLBDHiTXpVpg+9QAJa4+jwu
 6Q5Yw97r9T3S9TMZ7t4SNvhlZ1LbO82Zd99aE58Xi7rwrCs4gZrYpUja25UNdu/LtHtfateBfa
 Ja6/AaIO1V/UJiFeG4kSeooXqJBH/XQJTazPR+AC6GqMdNOxcvIEFNwic6WDRsSKUmwszJcKPS
 1VQ=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; d="scan'208";a="139071585"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
 by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 11:47:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWTX+ErvdCqfSb0Y0JIlmO/DJidse60yO4JruOdeuCHxNyWiwEpidnOdOfEE5vOjh1OelBJrfO91pJOwaUo/0pPY58209AXEyu7i8WBrKC/SwNXZb+de2ujEEbxp7Lp9078tQY0kt75TqQKYwrILaFIRr9kaJvgnwPUFsDd566dWGMtKGSVsITaV1UjjnV6KiyY6FF5B3CLahKoOAD7bhKuvqDtjupJRQ37WN5bSY0Yu0cPyQ/ztqXTFrFaxpM4h/BBBMKjB0s666ygnB+QShCZ7ZZmi9f2RFZjk1nF6J7MYh/zGUyBFTXbMQyD6YVHzUhYYH9cGshb7pabYdDS67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssyYMEUfnMT9vPFHTGWvzhwGjqvxgGkFphxsVXcphMY=;
 b=IAEzCRAdDgLi839u1kYKI8WlCcmN18YipwwVtSBaKDwRhUcgmbgdTiKaJJ4/hgM1llPcKzXu9YDhOtnyJH3CFpVdHkfrHXOwFdrr+oLBbZ0j9jHAcf8Y6CaUDnvo87HMDMWiNlhkcS7CwEVV0zKIdSPTZ03UvsIi6FbOCeOlg/zU+tzHGwv3wpKM6szA5JkJedaQdd2i4tb6ch6xP9mcng+WzQbX/ssb1xW4tCJ7QdRpfhG+RU1GWqPXhE1MzZcy+OGq1gr2Cc/v6HSeBGNS1RtHbP9DchihTilIzwFloVovPUUm6nOR1+HIOxdM/XEzplqERJkN8zt+Br48TCA+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssyYMEUfnMT9vPFHTGWvzhwGjqvxgGkFphxsVXcphMY=;
 b=K4EOhW3f2JsH8v+/9cv5sitbN+qiAHOBaQgefc7VUfnBRNJPo1FUivO03SeeWMyZ7ZZa7ADX/ppB01VMe+3XbBosD+RwUFV5nnugYZRUanNEEMbsPVRrZTm9CLSEp7N/rxI6ca+Nj4iT+8QK4/hN8tdFyyc2TFLFPtVQYdt45FA=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6565.namprd04.prod.outlook.com (2603:10b6:a03:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 03:47:56 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 03:47:56 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
Thread-Topic: [PATCH] nvme: Fix io_opt limit setting
Thread-Index: AQHWKZKteeWR5SmRQk+RzMo1gzRfSw==
Date: Thu, 14 May 2020 03:47:56 +0000
Message-ID: <BY5PR04MB6900584D1F292E65425827F4E7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
 <20200514034033.GB1833@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fd9c218-bfc5-4545-a979-08d7f7b9969e
x-ms-traffictypediagnostic: BY5PR04MB6565:
x-microsoft-antispam-prvs: <BY5PR04MB6565C82152C8C949C0119797E7BC0@BY5PR04MB6565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGT24cNWNan8/DXiAltnWTHojV6fqb6YlMMRUlu74plxQDcByhSt7C0t5jY+uO3Tt9X8DB/0E5fRnt6UaxeUxSGESJVME5Qtxv6579Fi6FUF8gntAKI7mWRCJm9cHSy6NSw3E5t6JaVMIMmHA7G4yXxdbm27RGTDuTpE7zxNwRpHA1VzxAWCKXn13F97IFEISvpcCbfNu4TS4HCJCpFVCHIawxe7d3RA8+O/0zK2PPrt3RujvHAeaE+o/eOiLZncgEHJKNCBtienEkRXbHph/7rUFEHAdjwPm5uE9zsL46FZrv3ayqlGwpugi9bCveuWCGbmjQ5wcTG7wdsnLUtIrg1d2pLAQk9rVTHpgFmcnsZvbzeAMcoGt2vv8Byj0NwUjLQoSa4NcpR4vKh5K3ciwFudddRzGVDt7wca+I/1dqpPNL/7zpi7B8SGVhA0N95Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR04MB6900.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(66476007)(9686003)(66946007)(8936002)(2906002)(478600001)(76116006)(4326008)(8676002)(66556008)(5660300002)(186003)(54906003)(26005)(55016002)(33656002)(66446008)(6506007)(53546011)(86362001)(64756008)(52536014)(316002)(6916009)(71200400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rnGzW7pAvScn3o9G7quzrGkil9GljzbybR13Lj/daHN7u8DXCEDxTe7+nFju7C14qtJY/mDktN+JGXY3hIUUBKNnBJjYCSUgAKBgOs9Oa3YPsceMMhZfaV9VavoRmMOp0aNSevBBVdT/rVQeLT1GdmOhT6Wa03mjGvho5URVJ3ek3qau8IS7Quoo30KJqCio9YU2G38l+tnJ3Y+n+gmQBSvmxn6VO2FS+C3eWG1bY+9bidE9mHq0/T76bJCkSW70oJjf1PX5p9LYFc7lEr4RqjAwAohGLhD9ZkdShhjOFPuSnFJLpUmBpup1B1FNevCQWlQu+EBt03+/ERmtjKZ7HzgSwSA9rM3bDQe4ftbohc6JDCbDNz6WKbLRx/kbQPzdqSoGBfQZL9L6hVzIowyY2MO8PTuBpxGHmfMeREa+9idW5AALVrc2CWyt6YVuq6ILojSa+QwC7LRSetFGcJtmACDzNxxPyB380cEZ1XBgX0xvZ9sh8ON8kri+P//loDAS
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd9c218-bfc5-4545-a979-08d7f7b9969e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 03:47:56.3279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMe45CP0bQB4X6qin2x2dtG6tsEhbrkNY/bMNNAwUbsCzHKEglX3BBlXJbMrUu9srAdXGdAwwll0Yct6x6BBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6565
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_204759_985254_D8DB18E6 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/05/14 12:40, Keith Busch wrote:
> On Thu, May 14, 2020 at 10:54:52AM +0900, Damien Le Moal wrote:
>> Currently, a namespace io_opt queue limit is set by default to the
>> physical sector size of the namespace and to the the write optimal
>> size (NOWS) when the namespace reports this value. This causes problems
>> with block limits stacking in blk_stack_limits() when a namespace block
>> device is combined with an HDD which generally do not report any optimal
>> transfer size (io_opt limit is 0). The code:
>>
>> /* Optimal I/O a multiple of the physical block size? */
>> if (t->io_opt & (t->physical_block_size - 1)) {
>> 	t->io_opt = 0;
>> 	t->misaligned = 1;
>> 	ret = -1;
>> }
>>
>> results in blk_stack_limits() to return an error when the combined
>> devices have different but compatible physical sector sizes (e.g. 512B
>> sector SSD with 4KB sector disks).
>>
>> Fix this by not setting the optiomal IO size limit if the namespace does
>> not report an optimal write size value.
> 
> Won't this continue to break if a controller does report NOWS that's not
> a multiple of the physical block size of the device it's stacking with?

When io_opt stacking is handled, the physical sector size for the stacked device
is already resolved to a common value. If the NOWS value cannot accommodate this
resolved physical sector size, this is an incompatible stacking, so failing is
OK in that case.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

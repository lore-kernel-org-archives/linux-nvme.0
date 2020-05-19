Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783BC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 00:56:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC3F20674
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 00:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pg/gBXnm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p4Ija3ZN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MKxmhu06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7ASFfdnEOQASrvlfianU8jEJQK00gR1JSk3bPuNqUdU=; b=pg/gBXnmS3/UvL
	IXl3htna6QjTPYQtuHqf637fFC+qXDC1CXZCiiM3DWVdE05B7dWGn8vkQ/uuJCbXPG7zG3zqu+h2V
	C15YnovWUuJaMo+Z5ggTRQhv68vH7vU4ITX4fspd2l80OhMxvmWwtmJ+OZBgR0l9JugHWQ+7fNNET
	aCogKpU0+AoAKoA14lYEbt8YsNszNZ0GFeAu1BBaM/8+/KCHDBoD3lZf9lbINyDVGj5Y2lkaoXtnL
	ElkpJ2b35ZrJjRWkxsI9Tp5YZRNxv1sYq0A3/HWn6TF4CBEwhgN2riDbWg1SqkGvZwBzcKXmDLJoQ
	vq3eVG43l15otNNgewpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaqYk-0001vo-9x; Tue, 19 May 2020 00:56:42 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaqYg-0001oG-RW
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 00:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589849798; x=1621385798;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jaWxgQZke4Mdet4icH1LmLcD4yjRz4OynIvynTN6dOU=;
 b=p4Ija3ZNzVPf1FtvxygnL0fz5aEFNpwED0gHixgELbes1i+N6oCJ83Tv
 konc/WdEfiIVy8RmBNuI3dJgXIZy6xBbw/S7q/ZOQH3NpiGmJHZbbhDVM
 2jaOEsu+HKtb3nfalSuCzxSgsRPJDlinHJ8M4R5lyAKlbZFQMvEYfs8Tk
 I/JBi7RxSbqSmvN/7IkR+pALmFDslSDr5ZLHaEuIEsBY8Usrn33afAjIZ
 VX0WOcqI87hAtBHJNdBaANqG+l/F4TtfsPegZobEU6MKd23K9cpPzJOWe
 E8BAZNnJVmqoeWspQ1cCkUClI3IHsljXiIai1PrNwmKjq6Wqfgvf71eAy A==;
IronPort-SDR: N3AC6h7hpYEvKJ9Plf4pl/sJcxuFgIkfi/PNAhD8bmO+DNCAhls+nUOxm/vSqV3MqQ4cRBdGuN
 H8QnjKgEGEFwW00FNRBRHKZUtX8bO2Lrmu7lxrGPzMLoAaYizmPxt85bbud947IjchTtJlTcUw
 CFVj0DuF3OloXERI+upprmS8HIxwbRrwmRvaU0ooAtVVykXhtK06O/SExKb57t0a2tPzjUH6hS
 4kprs6XAxzXEzrG+vC+11B7pg1CgpKXXlUomstkl+QERgxTW1KcxgCLReP6nMQYAPdQlZFTVFY
 dX0=
X-IronPort-AV: E=Sophos;i="5.73,408,1583164800"; d="scan'208";a="137992101"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 08:56:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvo8jqIWk6eleOcocoXWBjjQC7RKP+3siqtp6imnagpYV3MfpyYNQq4qstZt06WrSayT+zXpWLyarrnkJQ6CD33C9Q/FMBLuZ60Q5U6c3u7G5Q9rOfLCYs8V0iIVz47iL6gnjm/jgdjOG46NH1AyFVGxCRyoX4qJ2UY8u0LON/RMvsJatxB3bxvNWsTh1QRok2u922kgcN6KpdI9gr2/z+FTIAMnzsv0deLY19qrnd7istMDZY2dKksjaVT0eGlaAdc8MImCqoRXVBHH9fu45XSo2fWYb6GiMwXu2e4BBCePZB4J8Gaoj7leTg3nwJyczWoOm4ldrRIn4zbn9xvtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYjI/XCpcOFR+LF+0QZt03l9MvbKJqaW9NsQc9QqslY=;
 b=A8/72qQthentwmwgb0qnElfB2ZGYAt8EHsjFX9k/aywHJRj15uSPkMDLjeQbuFOTkag/olJTYZBFTNp79mZQbVoixnBhezXeQzeIMvoXPM9bZddRWBzvh1olqC5Ty15C6RzMhfLfGMR6dX4a2fA06KT0ASFCSBvMk4peL7H9s5iD8SdcVJG+nFXm7XGHF7w7yKbeyYbHH9JqU7nP6zuu5zxXP8X8djAX/gZOLSMksx+RkNIjlV/EyNvwqj0AnCqTg4OE8CrHzhcjiNYJGS5HHH2bDFR/Etd8XnkUA0I/yr1aFpwYqQmsATid9eh42fTHMHhX5bqTyUbjGJSjEVdlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYjI/XCpcOFR+LF+0QZt03l9MvbKJqaW9NsQc9QqslY=;
 b=MKxmhu06n0r7AWb/VbSh/LePZOeI6vxRElclVDO/oI+qGcfaRYYq/8SfQmWQG9+ljBkJCkHKueRKGRGJptm+H4CGol/uBwwJ/PVPeJn8ZIvVxE7D0T09x7N+KEzG60lsyRaOQdwaHiLxCZSeDfS39m8kGeeViogS4qk1SUt5L4I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3974.namprd04.prod.outlook.com (2603:10b6:a02:ae::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 00:56:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 00:56:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/3] nvmet: add helper to revalidate bdev and file ns
Thread-Topic: [PATCH V3 1/3] nvmet: add helper to revalidate bdev and file ns
Thread-Index: AQHWLM0jMjnKEqmxdUe9uH1n3NqNEw==
Date: Tue, 19 May 2020 00:56:33 +0000
Message-ID: <BYAPR04MB4965B15F2960C7BF521A0DE886B90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
 <20200518043034.48277-2-chaitanya.kulkarni@wdc.com>
 <20200518150445.GA8871@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4095945-6531-423c-924a-08d7fb8f79b2
x-ms-traffictypediagnostic: BYAPR04MB3974:
x-microsoft-antispam-prvs: <BYAPR04MB397445CFF531FFE686FDC1D186B90@BYAPR04MB3974.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaxfgOzwWxyaN2MlqEwt2NQr/CjmWPij9j/9DtmRHORmHat/U03TQ9rMkUWnZ1PXgS+sk88YGVPJBN8NFBSH3i+UQnLWMePty54mqfCBYtk1nts2ZPRNepqHoRXHT1Hal9AHwrXLohBTlCVC46qT/M/yGD8btrPDokoozdNHUjEGCrEGxn2GVdqF4UmyL16P/eQaa1/H6hiaMYcj1hl0osDGqe+Z13sYPr7/yRECIfCP02TQabLtY7YEhYNRx3xW7YfRxiP5hNPeh+8MbhJgu3C0693coG2663nG2GcA8LVOS2Hb512C2/lMLQlN+ZpcpI5+ou0rWByOWWSNlwHUTDH9f7YD0bQZTXOpYKmxNWTFupMu1tltZ8IMt4FcyJl4f6s+ZZo5zG66xjwcJPgc39DxQsNF6FmRe9e1nErlBH2MfhTcxM9AyYakmptFgKRJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(52536014)(4326008)(2906002)(53546011)(55016002)(9686003)(86362001)(71200400001)(26005)(33656002)(5660300002)(66946007)(76116006)(8936002)(7696005)(66476007)(54906003)(6916009)(66446008)(66556008)(64756008)(8676002)(4744005)(6506007)(186003)(478600001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: JDfPJ3FAehGjYJdTMpqyPHIc1t0RjnMGCnXIAN3TpZ1gmAa0ER72CzGX4NYTEEYqePSX33LwqSpPoVFYWXCaHXPSvwB1VGhFW1huKSL974lzHTSgsSUmTbOmh1xMbWwyW2v6i3hkkj4+JBH2hh2QQi/cln5c9hdPGWSgGgwvmCeMuHRsRBV1E/jE56/w05orPVSweOVs6vp88b8OGhrM6pJNzf+RkafVhu3llown1LPrxnaKaDOxBMptTzfYJBX3r8OztWGvmH1bQcwf4IbKVOhEut0CjU5iZuxy5Jzwkchjy5PpdkpbC83Esiw8tybPU3tStWPmEh5tAJYfct6fsScQxGjFIV47+In7OXhkfePOBmfJklxvNPN0Ky/xrrYQmgtO2cK8GloBSDGljJCF2gOohCgscPJzQyT083i47pstgaUDin/bKbXZHCIgjjE+uvkipLC6LBB6FVFIFUfSPl5XnarqMX5JzPDJesf6NrY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4095945-6531-423c-924a-08d7fb8f79b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 00:56:33.5996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ud3u4SBA0IPHOwZn/ugI4wiHhDgFtYGqhDVjWMNFtETbry067e34qSBE3OOKbwwf3EcwsIplcruuKvC58EfgSP8TUsdwU8SMpiEz/TR7reU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3974
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_175639_068696_4F3B412F 
X-CRM114-Status: GOOD (  11.36  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/18/20 8:04 AM, Christoph Hellwig wrote:
>> +void nvmet_ns_revalidate(struct nvmet_ns *ns)
>> +{
>> +	loff_t old_size = ns->size;
>> +
>> +	ns->bdev ? nvmet_bdev_ns_revalidate(ns) : nvmet_file_ns_revalidate(ns);
> 
> Please use a good old if/else instead of this obsfucation.
> 
Sorry, I keep using conditional, seems like an old habit.
> The rest looks good.
> 
>> +
>> +	if (old_size != ns->size)
>> +		nvmet_ns_changed(ns->subsys, ns->nsid);
> 
> Also this should probably go into a separate patch with proper
> documentation and not into one just saying it adds a helper.
> 
Okay, will add it.
> Otherwise this looks fine.
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

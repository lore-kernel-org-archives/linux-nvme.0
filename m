Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FACC43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 09:35:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C02220735
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 09:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/JP3ewV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="az9iaBYL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F+4dCdxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C02220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nDhaHF9FcE8atLzRyE88+YQ79sROs6flLUxPasDUdk0=; b=d/JP3ewVHG7RVjwzjRcSj8F7+
	fIXA564scJ3ybh0Magi6lQotXEh+SmuOIlStuD3b2CbbT2LVBcldJip2onpYr/P6Y39rQkR2+ullb
	Nlt9GwowH+EVLbwz4sYp8t8Rcrnj3Iw2iJ6MqSCdhwL/zCtPIL8bHhjgMEv4knBkgrcZrHnVVyfd4
	QO8eMgbC6vP6WQJfpO1pyThdT10vC/J1roEYF33rgFl34trbWdD6pWy9yDvYlOtWc7G6Cuj2BHcfw
	ZkjzLkUtcmN6S19hqLDFtLPCVNbbTxIhoAo+FbHlhXDUBxwgOtnmU1DThnqDPhVU+lOgLb/A5zrTa
	pviY8qYYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGfT2-0003cc-K4; Fri, 11 Sep 2020 09:35:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGfSz-0003b8-FB
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 09:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599816937; x=1631352937;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4/Tsdh7n/pHdCmPNeG6jV9KpC2rQa9L7C/HhdBlFVbQ=;
 b=az9iaBYLDIN+AHu8M0s5Q5mJqAk9SfG0cylYCvCZRCP82quaMPsgDJCD
 0K8pV8aHzaY2quz3nDWt5E00CR+WY9Zu+8UnCiQ1FD6bQm4mqzOIhnfqW
 HphYcxKcjyeRbceaekzjCCjDpJsjNMXPoxmiEb5eY/RtvkpLqVSC4oN3M
 QJ95fWvfCrO0vuACjpsV0+k+gv+yBwr1EjVqc1SE/POSkyBbupsvDtrZA
 qrluECiKea8dxIPmynxJbGrlJCOm6yujvo6mZMo4WvrQm0DpJgpj4OfMm
 ZoFVnflWJu6uvG7loyf5VJxE4nsgKnDKX85DN50UC/ZPrqC7a8N5ytxm3 A==;
IronPort-SDR: Svi028oO/O1XdNdwD1rMRDzPWU69dLH6C752uWdfa3UWseDDBMZXN3G9YTHTnVor4vmVhyPUB5
 KKS5+saNm+MVGA2U3zY0cw+B8GBrPr+k0MOnR4k6rb5LFnKoo+ebl07bmMf1HZrKbIE7CVHIw0
 bO6kIAkajjYeVwBaeEpGIJppv83xcHTXD/eCex3vzk7JOnqv4SjvYe0AFqOUGlbfIIbGZqwDMo
 Uudln02VuvxFhRFvVpifWYs2aQqUOXfrVUuokhuwJHbbrx53XrHHG4gUu6LVoaO4OyldbUhRJR
 9A0=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; d="scan'208";a="148351996"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 17:35:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLDGR3+/RDAd+7XI5nSdDMWX/4GqOgawmBDVOvZRmfUzTGJ4/9aSSHJCr7Fe7W27uclVXDX28Jc/c19mWnN1QlzOzspEfzxK4Fkevu3jBNOX/v9PKQ9bIsIzs5ZFskQQVfOt7sYdBD7LfZuLR848pwCjRvGzAWjAM1YAb0gYbnuYrtZR9uxZPWgj6L0YadsvC6bO7MNQkc04sdT9BrpGJLqHeUAdFAC4kRdLWh/cNjZee3rVGuXG0y7mW0Vv2XHG5i//KZdHF/nuiq4PxdoVm/TjoeyBzREjWHSZZDvilPdpUKlxhD2C/YaRjaX+0R4ANrnVJv8fnNDb3cN+LIk2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+nCZlsRdnr9StSzY8qIg2iHJUBThVcVghWTo/rfiYI=;
 b=fv7fCV5vxynhxFWxgiece3qiDvzRJLTp5/tp3FWk7CEuDImaZsKXsbMBrlKk2J5A3CMGxEOkXOhnKgd/4QxTxB0jIKqL5+n5BR0G5AdqsP/+9OfZfrSZ/PEMGP/EXFlTYwx+m6xQSZeZ/sjIpBzcEzPTiT6Dtw3ZT0FT53DuGPDwWoMgxMnpQDzAZX6PmwjrXba6n3hbfY5JI0tNpfyrrfQ4HPF+NbtLgUKqq29nM252E/C2mTzbikL/tRNZJbOTb00Bmi1DOZAsCPHOtWqlEk9TE4SyxlpHqy4CYvgl43Z1+9a56wp6yf5b8kz6yGpqJZeqIa98CvR4yJCHHW1Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+nCZlsRdnr9StSzY8qIg2iHJUBThVcVghWTo/rfiYI=;
 b=F+4dCdxWiU/a5eFYlXeBJK88fmF9xf1ndhq/I2g+5YfvLV0eHAT8GvOZnN39HYd+hcGgOOui5ft4JTpX4OUk4QS6dSPO32adGbHGvX3aYpCSKtc4bBgzf7Y3s0Iqc7dEEQWZf3qJFo03KsnECky03TG94zW3hL9ej2xzPfP6hvA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3633.namprd04.prod.outlook.com (2603:10b6:910:94::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 09:35:31 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 09:35:31 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Topic: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Index: AQHWhukkr+7z5FAjgEyIuorVxC+8EQ==
Date: Fri, 11 Sep 2020 09:35:31 +0000
Message-ID: <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:593c:8256:27ca:4ca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bacc357-42a8-4f6c-1640-08d856360706
x-ms-traffictypediagnostic: CY4PR0401MB3633:
x-microsoft-antispam-prvs: <CY4PR0401MB3633AD10064FD015344D32B5E7240@CY4PR0401MB3633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aEfvgb1HSZPUtXN7Yz/i5nUMpTyj4Ggn3HIN/JlftaLEnJWsopIdwZv2PLC+OedFaJHqhwBlw00pbdw7QF0SNAWxZvmDIpwXpss+/WhczlcW+RprZ8pSOG4jhtM8SuGqArFrV0Lm7l0hD4yilHf0z7NwYjxITaP11UDnP4ueeWalH1CwnfjVilNjBJbcZBjgwU/S39KdnCwrz20OkUD7UwvJ0DbSVtJFhr3fYuQBdZMWMp/1YrIE9v5qc7hIqyoZPHkWJ9EzuUBxsSQlHuawQdu+eR0CC1UPssyQ/0UXVSmX4eOq4uyn1KIowQBAdOTNYErMQIoMxhCEnFARRvF5Gr3ViU8seTvSk2id7g0kJpNhFjVX0H04zXjRgKS5QRg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(33656002)(5660300002)(71200400001)(9686003)(8676002)(7696005)(55016002)(478600001)(2906002)(52536014)(8936002)(54906003)(4326008)(186003)(316002)(66946007)(53546011)(66476007)(86362001)(76116006)(91956017)(6916009)(64756008)(66556008)(83380400001)(66446008)(6506007)(4744005)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: q5b1CVg8MpNkiV8XYF90aQG21fO9oIy9HGQ4XQ611byQz2sfqmhiR/YHm9fbDiGWSdOZFSCqpFACvxjKe/y57b8Rt6x5nlVz89xTymR9ZaID8x/WBVj5J1iSkNBaS9da7IcjxvPXrhG6OTWtw0KaE+RVr6sgRFMpzRAAzMQjhNtUln5mYJD7JuRUzfOYVU42jxQD/RbDnwmqC65sgYhTntH37F+PxpvSyeWn6+kPQ3fo2Od8+l0bwUd/m0zCC0HMw7sDMv9ISMk5JIj7guFGblY6eqO0GHIYzJygIhlUMyKYfU5Xa6CVrbt83W0ha9Ipl/qRpoNlb/4fIWt/sURKYUKVzAK0UbabMGWlZrqUXS+5esLePWa/9Ry5zpK8KaQZJkghC4Sahif0V3X8jsDUVkuatYEC5L4rABjA1Saiv/r8EQ1flQgNqdNSdEo2HKyyo4eWp7YPKrHyKeqQkyoKkKuIOEXIMKit80Vr1/DZ0AuKuR5Ot4SmEoJ0AImPvzbsDsFDmTIFV90Gm/eO+B3WZn09sQijpGlLHCDgqGCczXPbL7hWx68xF47/x5wV9M/B1PxMDjh1/FmxmWJT27U3oMGFLEl94TUaaRSmluSlEsDZYTukm3RYgl+fK8b+OUJs5z3joQ8eN5t+LB7Ut0lLS/g8DcQ9PhVe/qvaPN+uam29EuN3j6wskcgsF8p8oO0ht3RVSw+GEWbkFx4m+Nm72g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bacc357-42a8-4f6c-1640-08d856360706
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 09:35:31.7802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeAcg8ZTKoL60MrYKPTIRRD70uRURn8TLqHRLAILjOICznYt58XUmIOGMgd5gkqVwzixxk8RhM54RMWfwTNXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_053537_652821_59C67F06 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: Keith Busch <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/11 15:10, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 10:25:24PM +0000, Damien Le Moal wrote:
>>> I'm not sure this is the best idea, we probably need specific error codes
>>> if we want file systems to be aware of the limit.
>>
>> Do you mean something else than -EBUSY being returned to the user by the block
>> layer ? Or a different/specific BLK_STS_XXX code which translates into -EBUSY in
>> blk_status_to_errno() ?
> 
> My primary aim is a different BLK_STS_ code.  But given that I think
> that we should not map different BLK_STS_ codes to the same errno if
> we can avoid it, we should probably also use a different errno.
> 

Hmm. Beside EBUSY, I do not see a nice existing errno that we can reuse. May be
ENOSR (out of stream resources) ? Or do we define a new one ? EZBUSY ?

And indeed if we define a new BLK_STS_ZONE_RESOURCE and map that to EBUSY,
errno_to_blkstatus() will get confused.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

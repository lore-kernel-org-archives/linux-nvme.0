Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A028BC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 04:49:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD9520575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 04:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izj5t9vZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LRyMVJxX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WI6dxfBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD9520575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=T0+KGB/Xo1U70ouiIsI0A43k0FCz6Gq/Trfo2H4H24Q=; b=izj5t9vZq6FBBj
	LBzF+p6JtrgOmJr7O9zxBGBvXy3dItXpCyux1ySbM1EXu0nEAE19I6sRp6G+B5FWLFICIOGzNZJDq
	//QTvImiT5R7bgaJscNqORHYCXu33nfhtt+GPvg4eoUMAb0nxSvVHUJjzM1N0yX8JlfrFTn2/6tna
	cfsb7LisjZmeEKrzDJy+n1u6RQSEdB2hFLljUUggKXKkxZsCgPPTcNStoiMsi+DwdzkQY1dUQ9OJl
	KoOlKZwefgQSJD2AO0deGDuV+smqJDxt4Jn2S36ARS6+3PGxxxvwbb7z+DLu/Z/PyOCoEX3cfuJ9j
	WNpPSNPBYSZ3FCamZh6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ5oi-0000CW-9v; Thu, 14 May 2020 04:49:56 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ5oe-0000Bt-ML
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 04:49:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589431793; x=1620967793;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Mrq7bZSDx4KOVXtDKexU7BTiqSHvMS8BWRYrkL203CM=;
 b=LRyMVJxX+HZuGnxYVq1iTlINKBR3BU21rLaufV0POiDqSGYPsE40Rv9z
 mlJXK3Fzp56ROVDkMO69leyQhAbHgJ6vxu1/rflkI93a00VoC1Oct4Gup
 c92CK1eVzNxgx0kBSedpk4xJbHATpotGtA/29kTo1ZHEFR5ReWcpQ71Bb
 CaPs1TjtSLIIQ8niwH41/qBD7BfvHIkFVLG2IWEpHqE1MKM3dk20pUJ+w
 NEWEVhfbWR8g/S9MVFfadtn+tsToL76kIYZ/hP09AU9yu4mv2MYijiayy
 h0m8quPvXc5q9QzZ0KjM7stVZgtIOaEmY2hZN8GgHlUUFQTz9VFduSFtf Q==;
IronPort-SDR: SLN3VOl3yhInZyWlow4RWiX5TVlGhnlVLZFo/v0x97y1hfMjpCr7z/BK8DjKGzJjzPUu5Ten8c
 EEoAvRSFmtn3YaudgD/hWMCCvia8AksyQ18nWLKYutnUhUBUepHyuG5kTu40qQs6bsqKZS9gRs
 k9hGOkJUgqxtieNFcmax0fP25SXSMNF2IcscFNJMaeBlDqb+ugM6tYNZHFhkBCXoLcLt4qf36C
 RbhRnKhrohBwNah7n+v9RYa0TtjpELcwgsYLqzdyalwV09pMkztcKC1db+eiOWIcqQQqEwjKxC
 CAU=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; d="scan'208";a="141991853"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
 by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 12:49:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bngFErr2yq1s6/CCEUgQEmlV8Vp3okqB6v5knVAaG79IjFLUc3ACrdvzxou1wB7gK8O0F+U2Q3ewLT2OUQXrxtwaUDdZzYXS23/oyM1MCP6HvW7i8BENCyhbb3G4/ZQrAobFt+mNTA6SSTJPSYWL2c9hCICDNaSkCVhaWHT/qHVyOpEP/urxMue1DhCGwpkzVgNg7n5QC2Fsyz6WZUffjxj6R3qB1K/xd66p9E8yTgGX9isqpd+3lOOyG/Upk70BCRpEwIvuxX/SYXsR3GuO64/b0UPl0fP0NQ4Cv83QlggjZAUeF+PIbH0jGGm1ooxbDgDbC845Xb1M7H1O2Y+a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDaWaE8KR+TKMKOCISI9dFZ8hDFlbKL2W5+T5Ou4Afs=;
 b=Ed2ff7szqS/3WP75lN6ZSMraWSQR3O4oYprCPny/GmuqnnJm5tfI6adZIHOW4CmavY23q+O49hp3og27L+TD92/jcPwLxr9O5oJOIgk90C7c6YGi389K9RpPb04ycQZemyW1sa0fO9w7y8wr8YwZTuPB4FoUrGoX/GTURckU1AdM+YstEJ9kU9oPCbz6BZI9V3vepZ215CO6KHN5nzRmWPY6o9jrhYWA1qOLwy9U+tJmEaM+yot/HZD1ZLp8KAJVdS2hY3XhlZ3IYn+e3FP361chUTRpUcWuT4mw/y/jLAGmBXbWYQYChSQUX9c11VAktpv7tAeGZSWFWBAL7DjsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDaWaE8KR+TKMKOCISI9dFZ8hDFlbKL2W5+T5Ou4Afs=;
 b=WI6dxfBsI5aqzwpmCvIHtbt5cbgdjOOGhgD6cCdwze3zTMTd8N08OhXYavZ3xGuGGq7sMEf1Jmj7CM5oDwYl7U3OMsQClr1U1x8amhIRfyDIP+tyrwuDdsmsTKqT1tRVvdfwavGs84wdT4ncuUdeuQRLk49EGeVWEBVpwb/Mz60=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6883.namprd04.prod.outlook.com (2603:10b6:a03:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 04:49:47 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 04:49:47 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
Thread-Topic: [PATCH] nvme: Fix io_opt limit setting
Thread-Index: AQHWKZKteeWR5SmRQk+RzMo1gzRfSw==
Date: Thu, 14 May 2020 04:49:46 +0000
Message-ID: <BY5PR04MB6900CCC90163A2E0DFE3CC9BE7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
 <fed0df8c-3005-fbdd-c413-06fd7d174dee@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a57179ba-a6dd-4ee1-c574-08d7f7c23a4f
x-ms-traffictypediagnostic: BY5PR04MB6883:
x-microsoft-antispam-prvs: <BY5PR04MB68838F8DEE1A80D881BF6B0CE7BC0@BY5PR04MB6883.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEw9aJ+kghd9p/tIZGC5mGxU1KvxJDkxc4r8O9J/TxJTKvXZ8NSpDo6Xyl6hvwDTAxzRFMDzUQXQoAifWqG2XCx2OJ3HwdenKq9wwMcwg2DQ4wFkizkkolQpwutKNAab6gpzqBPDjNeG4wM4uh/UrEszD1bfP+COPmFz6UZ1Irsz7xRlwVxMBVQ/6yVzTRf6JFHpD89ewWqa8E12PzamDmyfSMHXfRnqBaqTSNDTQFZ8WhBDcZcT7EZttp1Y0phoOzWS2lLRf5VqyQ+meIgarqfYIRBhYBdP3CQuV6ThEr9rQKy34HC5xRPNp5lFzhocv6m0hfuwuhtgbGorodTUN7SliMg9xwRRQ2XrfYPHYxHyXL5QHwkIifUtc0BXsFYTsUEvs3ihfV5ehCoZpmsAkiHR5udBAuwRDwC5jtcOKTxPl6MP6+mAbIcAR6gDQfGi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR04MB6900.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(6506007)(4744005)(53546011)(9686003)(478600001)(26005)(8676002)(186003)(8936002)(55016002)(110136005)(7696005)(316002)(33656002)(5660300002)(76116006)(66946007)(66556008)(66476007)(64756008)(52536014)(66446008)(86362001)(71200400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nCqc8or9O5PO7h4A/8zmRVRmN40zU0Ug6Cwkk15u7fcX8xaUMz0Rfe9IFet2r6TWLHdmw1o4CssGWnPxsntaAIWi3FgdVeM710PINw92dqG9OeUNCm69T19jwDIK0ejyJ2TD67DjmfyUJmuTXWeXw9yp6/cMQAaW+45M8ysQu647dJKVE+cfJzwxVI+K3CtqunRq6nGJFdNfPdHMmiqrIHMJyskeZ1XS/S7Y1rND67nQ55FEZNLH9NdqfHCHE1AHGZ/yhri7jIOjdOykYJ2iW0OlI4pbiDk/NW+jRnEn1ITifVBsR0fLpV9UngvxQHhA65KPFEjAV9nk5dyIEwdO6jat7Bf2+vhYjPlIyigMI0M3MhbkyycA/hAFKukZhscwLfnklHYxwnRAUZTE+4SutBCNGQk6qRr2nM1BkDzS2kUwbuURwgmMFbyuTaXn+3S/TmeCIM6icOHVUxUCQw7qGORuxp/3iRiaHFUoTtVAZ5+Jn24qZVeeEPPWNjDYZ/Nx
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57179ba-a6dd-4ee1-c574-08d7f7c23a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 04:49:46.8992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NWzhl89A2hfanmG2wcKbfl1ZeJIbCHh6EPqh/MIee1m5+pt3hWwz30Y2WUhs5uqdCwCd+cKy696srmZ6WvDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_214952_793950_FB7EEFEC 
X-CRM114-Status: GOOD (  11.98  )
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

On 2020/05/14 13:47, Bart Van Assche wrote:
> On 2020-05-13 18:54, Damien Le Moal wrote:
>> @@ -1848,7 +1847,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>  	 */
>>  	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
>>  	blk_queue_io_min(disk->queue, phys_bs);
>> -	blk_queue_io_opt(disk->queue, io_opt);
>> +	if (io_opt)
>> +		blk_queue_io_opt(disk->queue, io_opt);
> 
> The above change looks confusing to me. We want the NVMe driver to set
> io_opt, so why only call blk_queue_io_opt() if io_opt != 0? That means
> that the io_opt value will be left to any value set by the block layer
> core if io_opt == 0 instead of properly being set to zero.

OK. I will remove the "if".

> 
> Thanks,
> 
> Bart.
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

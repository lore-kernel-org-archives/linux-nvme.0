Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2BCCA9EB5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 20:41:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCF3206BA
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 20:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LbXNo0E6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YV9g3emE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hV6HvVuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=v11L+QuZ/yUgLtRNsxWQkg5tXiZyGOkW2fnAd/oSrkg=; b=LbXNo0E6lvJt67
	dnmBQ2XiTttL8rccNjxpqiZjpkTnN9tf2RjedI4h1HglHfhR+fWFvZFhcDYfVqrkmoiFlb/X23ppr
	2cSZInnWuCEY24jAwh0oOAYKpo/rSiM2xgTKaa8JBBTgM30FVmXFjKBehIpDbodAZozpaxnEi6ZaM
	JI0HKbq779fwxN6gbwlUIpQXi5Am64P8qDeaceQTU7DXBb+NsJTMlYDTUan6T+BUPOodpI1EjOesl
	J07U6L8qMd+ErX38DxEBOq+HcUBwjJMz9UR1YJtMPtUIaZ9YHJ1PzJffshGclWzsVv5ZSS6oGtZNk
	8VKYmxOCmVepn5yhlB2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRjAA-00065O-RT; Mon, 04 Nov 2019 20:41:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRjA7-00064a-Sy
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 20:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572900079; x=1604436079;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=87euDTuNoljjTVaNAtIyfCZEsQmfZGzVyWH2dVWCtvE=;
 b=YV9g3emEcaDb//rTno+EWievEPtwXyi+Xgpa+w3bb46M4FCZqwnH7iBQ
 qnm3p3Brw1cfsATpP2PXbZbKD86xb0Qfwq8lPiEaOMjFsgWEUoJ8vMDS+
 IExYxeyVzS86w44WMo6n2jv3CMrMDEKIFWNQIZ5Bs6hNocPIJZFqrqGkq
 PUR2ljzxsVrI94OW63UDnKsLI8ePFzCLbhBctKUewXNDHOG/rP8B168xO
 ieOGvAnpLvai0sOoFeTabe+6DAzbuOZAhaApU4tWdiXnqX0CEyxaDpzuT
 VH2Abi1fmuPheQWFQWf5j6P674mr4YNk9WxZ0EvsQRQ2wYPqKVZunv77k A==;
IronPort-SDR: AtkA6t1yYeKsiyjOcrEtYFP5PNfdnpOyNDTTowhCnWmDsXrsT+e8fd3iYA0/EDfiooCJ6tM8S5
 CGn3o4E+byH3ZdTSSU803OOEFKIX+PVHXmNzg86FAkXHfRAnafLxU7s1AL1CHwWmTKalQXclJb
 gsQLJODcGooT90JPlR/cN70JRSIdPchaTU1S84Z++9c6Jh8Q1NCwwWKvGeI3R2//jtfWctGytU
 DAGiFSuF9FfRzdhChVoouf5n76XMFWKG6LBLALsdFUFJ0GSxbn/VL5sbyCkvHBeMbBn1RxtoMk
 w3E=
X-IronPort-AV: E=Sophos;i="5.68,268,1569254400"; d="scan'208";a="122094610"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2019 04:41:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTweaNuG3Uau5+be8e3IM3tzkEHwz+T1hqQj521JR4oQSl5juE9rXaVAXlYe64d758EHhwEnrnrMjpOaM9UExiqROpmcymOT/h+qJxUV3lI6TXhSQV+1v6mYJa+2bWnKZE3xgSvsAVzC2UGUlDToUB2GEZTlSPsLCxfQ8MU3T97pgH8D11QfowSxCndyZKzOK326p0G8WaHXNcUWkR1IhTxe9/Uuh8IF/FvA2K876GrkXIWUhZr1l24x2bJOSQIxL9PNCbk6za0xEwrKilQDbr/eagPKtNzPloHPIql0oNGKCoC+C5Ahb2DXrpY8Gf75dHIBNKnDkIKdH52DjrE06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua4mjN1QXO0Uk/Gs6ANe+O7y05N+27Abbp6Pq0+BaAg=;
 b=mfQxt0h1PSxyHRIDNgMwDmzTyo2T6FGWKDNLeeatuvdTObqZSyF7YrfI6dJYLIhh9lnHEqV20FmIkJQ7XEWwz9HUByygmAS2qhvef7l7vxnoZxcDDjoBgLmloC1GmxGIlORdBlZ9X2jGt8Xi2sGoGqnIsI+M3oke795TA4TqaSVQkqQyummteYoWWqS2FrW2skUyrOAmafTiwhKHcpTKZjiDkmkO0uc8GiTQBJy1PmZCG8eGJDyC5nZROtDnx7HE35npmKZJStjSw8Q7R8ETsu6P5omhtKYdKoO2f1EacqTZz9gzYUPVfOA7oJPusFCf6r5R6PSeWRnGxRc9Ht+kDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua4mjN1QXO0Uk/Gs6ANe+O7y05N+27Abbp6Pq0+BaAg=;
 b=hV6HvVuzYYgHsTQXrWeVj0HKg6zzKByj9sgJ8iVFtTenMWeBFn862iQQ+6ftcs6UNbZe5CfnS3c+JytGe0ovM1EfG7Z1OKHidhNeequEPt8+GEJuqJhAL4nEgtgSEz/uTJDoSDjzHzTscFYaL/NOxqaOAuW6+/gDngbMenzTsLU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6008.namprd04.prod.outlook.com (20.178.233.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 20:41:01 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 20:41:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Thread-Topic: [PATCH] nvmet: Always remove processed AER elements from list
Thread-Index: AQHVkoMhq0HJ9KDTYUe4XHNQTdxotg==
Date: Mon, 4 Nov 2019 20:41:00 +0000
Message-ID: <BYAPR04MB574938B5AF804C910EDE4A6E867F0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
 <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 835d1bc1-68eb-4ea2-4c74-08d761674db1
x-ms-traffictypediagnostic: BYAPR04MB6008:
x-microsoft-antispam-prvs: <BYAPR04MB60080D90B4A485CE3F0EDAB7867F0@BYAPR04MB6008.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(189003)(199004)(256004)(26005)(66946007)(76116006)(7696005)(76176011)(33656002)(305945005)(86362001)(7736002)(478600001)(476003)(446003)(6436002)(186003)(14454004)(4326008)(14444005)(8936002)(229853002)(66066001)(81156014)(81166006)(8676002)(316002)(99286004)(66446008)(64756008)(66556008)(66476007)(5660300002)(2906002)(74316002)(6246003)(486006)(52536014)(102836004)(53546011)(6116002)(55016002)(6506007)(3846002)(54906003)(9686003)(71190400001)(71200400001)(6916009)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6008;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dU1PRUpaJaXG9s3tBXo7k3oAJ93+T5cUMeWYsuDIL8qIHHhrbi5YqRR5hdl/olZCGsV0mMrSHZJ/Rto8yoWIgzABNt7GqIdPZoe1KAZOLPX2Q1yBETrKufsZRYY0W+uxyAEB+6Dipomm8n0o/vOa7JnwjZMden+v/irUhlKY95mOe5kRxLkLZmX83e+M/hLZ1tKEGKQyQ6bRnOvgP5PTT0NbhHgDXPTl3uBrl8f1NXTYR2K35F3Ba5rjpw7SNoQRFK5T/5McThkIjjUndBXZtpZKjI3rxRZP1R7erZTIo/jjT3TfFh4PXUQOmXgrTUB/VBAjgBJCQptXXpGOamU9xib49EEm84Pb88KFJ5RTGoWLwrQv/5Xo1gzhLFvJ4asevs7l3EaYgIq4RvyYpenAc1lg14AKg6dF92tBipE6v3A38s60IxW/8xrOr8vtTDh
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835d1bc1-68eb-4ea2-4c74-08d761674db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 20:41:00.7376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtHhWqJwk+P3Bi8fsGNpcwxw023vvAeu+0yk69djb7o1EwZsQuZQlRpAOQhNw7/NaOox05swXsi3rcH9f402lp177MMm+0hFeBOHOwB/JzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_124120_039981_D14E3070 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "jthumshirn@suse.de" <jthumshirn@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/04/2019 12:13 AM, Daniel Wagner wrote:
>> >I did the basic testing create/delete ctrl and enable/disable ns that
>> >did not produced any hands or errors.
> Thanks for addressing Christoph's comment. I'll get this patch into
> our customer's test setup.
>
>> >Following is the test log if anyone wants to take a look:-
>> # echo 0 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable
>> ># nvme list | tr -s ' ' ' ' | grep Linux | grep -v '\-\-\-\-'
>> ># echo 1 > /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/enable
> BTW, I got feedback how to produce the oops on our custerms setup:
>
You are welcome.

> Test Steps:
> 1. Create two targets on node n1 as target side (tgt1 and tgt2)
> 2. Run perf to write data to tgt2:
>     sudo ./perf -q 1 -w read -o 4096 -t 60 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'
> 3. Deleted tgt2 node n1 configuration during perf execution
>     and reboot the node n1 automatically.
>
> I hope I got the steps summerized correctly.
>
Interesting let me have a look at this later this week.
> Thanks,
> Daniel
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

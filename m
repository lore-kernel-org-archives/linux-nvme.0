Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB59C4332B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 01:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9022076C
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 01:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a6ROOr5k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tsc/24GX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AEA12A3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9022076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7hwduoiap4JbDZMu8/fhqyCAuXxOLNa/CjeLPipiRvg=; b=a6ROOr5kIYoHQe
	vdzme6nYkc+xwS06jL9UyDJGrB5a+FPBj5VGSc/ietZeXUlpkx4sXUjifBjD1va+lFGECQFpu4Ian
	hfBNw8whrYs6jQ+W93x4zTTywrxPdB9wiqdwhBGHpIz+cgtM0Zw1bHe4pL3E4tZkhy1T6j8xiBVlV
	qvoxSb0WIxhE1t8hUooRQuzyD7o+q7o4mGbj7uUdaf3fDKp9hyIDy8MPy64u93y2W1BEppJ6wxoeA
	Uds0LyjTk1Mf+QfgPp/0brwNu5KsQoL9AS+vsYw2WrxJRlgiemplWfUp0k6opu28f0EcMtPrL+YCv
	M7TFZK5HmEZd85td0oXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFSbF-0000ei-EN; Sat, 21 Mar 2020 01:06:53 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFSbD-0000eP-CI
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 01:06:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584752811; x=1616288811;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=mTzYwVwhrqetrvDG+lOQqQDJNvwufB/mu2Y0lSwFweo=;
 b=Tsc/24GXldZzoXIHOOu9nPAjAJrzu11gUYqqJ0CFPakwpdFE898vfsEm
 H64oED8m8Crn1ijZ5c8A3x8el5IFat8yn2F3PxnFbbU5bpq3KMZ1JMy1S
 sYNA9qMyK5QPXmhiEFr6MsKIvJfYyCH7i4udvKf2bH9cUs9T6Ko3OQNwx
 7z9tyEQbQ7oErAd85dSibT1b1zbhGo8M1K8UgvDPSSdxgBCvyurhW16al
 2BILEJEYZR+GadS0areB3uM50XFj1ygQQOlNr3qFCofK3rmrMuIuh2/Zr
 OijLaeD7alGg9rZaB3/Ub4n6zmpULsSxfKs/AnbrnoL2v+gptpXnLstPZ g==;
IronPort-SDR: N7YGEP05Iw7Rkdm4fNj000fRTdkLnGdVWdfTRcNv+U+FdpxHQs+3udtSXlFz1b2iYRgxOEm8mt
 wABEVJhL2oGnefatM2t2p+CynRKjDguzeS7nknlNeZ4WWv7G/EHM/aRYcYx/tHXjZNqQNK8O5A
 23hK37a18A4iAgj3Zs48QIOSotAY5XHRimBgFB2bBGzwMwhpqgZ/YjxeON9zjWC4PUqf9YOwwn
 wMchGHz7jw8wD3M1dzNxe0xTzfJ18hw1VUQFd1CyykGEpIHk0gp98jPsrMWrVa+0OMvmAVefl6
 CfA=
X-IronPort-AV: E=Sophos;i="5.72,286,1580745600"; d="scan'208";a="133108377"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
 by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2020 09:06:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuFnLiZLmzr4dwFNyYqBsoD+8Z3/PxSSjq1vliGHiMcsh3NtLTRuD/ttxdfq/WODBbPSvH2otqzhxynfF13n/oMcRrWAZ8RJ3TJdKQasepvSgUHmM6SM9liipq+3Kfsoa+xfJOEnstJQ2hZxGlzwxBANXdxetI8dR5V134T+D7ot0FHI23KygjxbDusihehRieXUC6tBiNDh5YUER/Yb0sShvYSAeFTj4fsDMMMHI1wpuDZMymeKHBLswziCB+5NkYGr0zB2ELErLUrgvArzBp67UQVbO3ovSAk/N3M096PPCDjE+CirBLhVP0UDx+GQDJyV26foAwnnaS5ZeeRVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTzYwVwhrqetrvDG+lOQqQDJNvwufB/mu2Y0lSwFweo=;
 b=Yk03BI73yvh7gL3w3+MTNN2HI7A8NITe6t/AatiDbUtCFWJXQJCs95KkDZQsRhqMRUFxiJGT1YgiXUQ39Ebwlb7phdQzeRO8TnuL0TAWnXy5BvG63X4LTwA2h+O/uh9jVoGtsfhz1N9GKRqBfnY2wLtw5TRiA4IFHB0/LDB+Vrk1HVDGcf6Kly+f5fmUEh0uLxD3jGwVO/juz1WOs236yy1RvA9inwypzKjnMVTU7S9OMGK0PcAXgW79/QWO4hqeVhQdgIz3TUnE89NeWJizXX1v8yFaAV0J6kdoesBT3iIkqoBJyToDsNcCx2g0CwO882NmFDCbn5g/95EDbbltnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTzYwVwhrqetrvDG+lOQqQDJNvwufB/mu2Y0lSwFweo=;
 b=AEA12A3JMJekAsQLVvn2slrhX5KKDBnnm68xnBYIoXLeJCSS39WyIu7nOzgWl/mq2TkpKQBOkkteGjVlRYbuU5COazUMLO2eb1PQHJjYk5cUwdZV5zaLlM1ZpFidDhg119Mlotm1bBNF3Ix4TAQwbht//ZMZ9fblPEvv3Rvju8s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3975.namprd04.prod.outlook.com (2603:10b6:a02:ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Sat, 21 Mar
 2020 01:06:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2814.021; Sat, 21 Mar 2020
 01:06:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Tony Asleson <tasleson@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/6] nvme.py: Explicit close is redundant
Thread-Topic: [PATCH 3/6] nvme.py: Explicit close is redundant
Thread-Index: AQHV/vgmnwYF67/JbUW47hby5cDrig==
Date: Sat, 21 Mar 2020 01:06:49 +0000
Message-ID: <BYAPR04MB4965971C531DBD1662B4875A86F20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
 <20200320203946.37338-4-tasleson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19d40c18-8936-499d-705e-08d7cd34227c
x-ms-traffictypediagnostic: BYAPR04MB3975:
x-microsoft-antispam-prvs: <BYAPR04MB39751495F54951FA40FA454A86F20@BYAPR04MB3975.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(53546011)(5660300002)(55016002)(66476007)(66446008)(66946007)(316002)(66556008)(8936002)(478600001)(64756008)(52536014)(9686003)(81166006)(86362001)(81156014)(7696005)(33656002)(76116006)(110136005)(6506007)(26005)(71200400001)(558084003)(2906002)(186003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3975;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T8nTgPhpEDW77QG/zXPVw+VXgYWDXewYbLxjB5x8ciH9woWAO3mLoQZ4e6JiI11F9n2pzy/4OmQUrMUNpLkgd6S/kG0itN+45GFzoSorlSSMSqNH5qzK60v+YTvF3tJpGYsO9fdA2aaazKvTPbUj7X7ngga286mdI1fKKYpOsu2RESX7940BVFmuFdA7NdYQdbnL6nmQ/Xz6vs76sv0cKgX3lekLbo5xqdbhPGhjpOdhkCGpHiwcIjRbXbRY9HEucH1BCGKrh61OiVtFukBN81QAOOtjvXTJpshb3BDNVI7KiOXagxp06oPaHnelF4PPkgeOxrIHl63yP4B2n7T9/2hwJvTXWHFHoDkzLz+KJoEjEbcR/mGsldgd68mmGoIwyzkshsiBEmoPRuIqCWOrec+w8JnwK2lS3GQGCQ5rkcr85ptnj5j3YurHiH9A/RCb
x-ms-exchange-antispam-messagedata: aS4gh42od/kvCZi7WzdJQl+wwYRoTKgkmrI5JrE9YvhdKaFdObqFfO0iCW9vDCjlOJsx4FS41k/p7coDbc1Lk9T0vCzstC5KaN5ieezf/h+i5Q91PqeqlAG5zat2ib9+Y8TEvE8y0GeaRkhqVJaBXg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d40c18-8936-499d-705e-08d7cd34227c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 01:06:49.5359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GaSh8VVmknCijcd92dVuke8Gz56DeubchOLkVib4XdwHlfrgeRcgR0HmPR4zroXm+GyzGpl/4youkeUP0aKX7F2hRdscFb1aq2fmYNW8Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3975
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_180651_460694_2A510DB5 
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

On 03/20/2020 01:43 PM, Tony Asleson wrote:
> One of the benefits of using 'with' statement for open files is the
> close is going to be called regardless of what happens.
>
> Signed-off-by: Tony Asleson<tasleson@redhat.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

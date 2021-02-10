Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C924C4332E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 18:21:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A403E64E15
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 18:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A403E64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qyIefErfebGKto/iMAospnaTFGuTdZJhS4xwMUfvzSs=; b=E+UAXCaj4ttzVmYfGkPbFAx4Dr
	IGKQaP1TYFmPJx6vYYk1QXspE77dz9U5dFQxuSakQ7Rh4hEt1ycC5YbylOZYibbMLfA2aNHkpAHQn
	cQkMycFZogAcCPy6/31PBZe1EMVkE6Fi+av6MkCfwtmivaI+ntxXXtaZgx+2LfP8MOqbdMrhKBdvc
	PTDo5hOdpk90kfdWEsaeZVDwz3axnT1YwGkC9k6LExIz0aQJhpTpbzg5/UkNn44wG1rJusJSdgOHZ
	j47E9JYYMr13XNKLNOP2JEJ7O9ycXQ2GM8k2lZKPFwbnjQpzLh2D90lr+PxEIuP8M+/57b8SZ2wCP
	w5q5h/1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9u7C-0004q3-B0; Wed, 10 Feb 2021 18:21:26 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9u79-0004oF-KS
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 18:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612981786; x=1644517786;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=QMfGpHmHBamfXjvSVdKlMi/QIX6twH8y9ZZ1sm6zVbc=;
 b=IXwgRIc2dndqhb+Y1IjXjnLL6CLL8XuWwMmL53+LNAUkLqEarBI6LQ4f
 PaBwqNVzMGimT6kZ4qbMXckhZR8ERO5iMOgm4gntydpzgKjGY7mdV18e1
 +XN/9OAqcn3XCk4irsWGqTR9Iyyv3MpqWjRTTdAKM+nDR/0pkye+yxQgc
 rKvn+XstJO5A5rttqE0XQgXyeO0gyVG4Sbb2gNyQVod13qR8XSRwiBpDk
 x5bLLey4WtE5Mr8FtXDdddl/+dHQ27BkaFWJuA4haZ/W6AZeFV8rjSxia
 aHT2neAUIpqWRo7foYQM83nvs33VbeAfQ1O52n14b6zw1kTkf7nT5Q8j0 g==;
IronPort-SDR: eUGabFn7U8CNF21ZAmqgA8oRRJqIdZglk452tA4jDuNt6WjQa6O52Ytlzj/td5CmmJ2xQq7JXZ
 2qh377ceChmPdn9jxbK+afYmxx3WEmt/iOOk5cen0KZLqJaXyP2eJeoLDaTKDFFawskfqY/YM/
 54ETypWowi46j1qwDBtxjtThgRqJ+A3JLwMOSEPAkUUwVwcXxe3zz6fcdAUyyfNuaZP1bn7BN2
 4Wa+bwwTQN/0cEAPdtwSRCzCAkvUbMDQZcBJOQGe6hRIiC5N5f4+3BLAnRPc6ifxsZhx6/NADQ
 1tA=
X-IronPort-AV: E=Sophos;i="5.81,168,1610380800"; d="scan'208";a="263796307"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
 by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 02:29:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3sJ6fnjqNDK11ntMT5etJCrM7/iyYEQ93SYPjCIYfd/KUF/PUc778BnhzTU/lZEwfu6P2FaJqettE4UozXUnx90ymLntaCtGSoc7kXwTSK7/yR63zQybt6gyT7Fk/PES7YScCdNtioWA+RhK38wy27u1YOhvyp+OErjo6I13ynLUkXO0/38FLSZS2WjAKpUNa0VKqCoNJPv6vpwxxKqf9ZWAN26OPFYK0WcmIxuA/rf+wuFacTslEmF8ZG0YhUD0RrKrWb4hTTV6321tVte/iu0gskxF2NlfO42d1OazDuT0xAlm7vV3Sd9YvCXqL9qkTnWrjbFR1jKpBG/t01HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh45cPUIBL0+oichu4cNW94a4ebocGQR6kXEiE+DgMU=;
 b=DR6dveNjTk9EDsW0xJt7R0IQGDU0l8bZaXRLlt41WqGD84+TgutlE7Zd/4si2EGhS1ddqVQjsyarSRRBA75aIo8BXudOpJ9lJcVt6/Tter5rX5ybyXh0enbJXl+cV7dUPF8/7LoIAdsimz6vWhry9fHsm1jPeDN+AZrNcYyTVn/RLDR5hmAKqdnTw5wuEJqW272TjQmvOoawtws8fluT1nqohYsHK8VqFHVtpBviPQQnwOhmScZuysSRwTpJMXJx6f6fHcryof/8bvMTjLpbdOvwF6yQV3ZTakz4gvDqGZmfCVNYYP83EraVIICoObmupS/eYGCcKjGTQwqsXywgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh45cPUIBL0+oichu4cNW94a4ebocGQR6kXEiE+DgMU=;
 b=dIK8e/OeV5VhU4hIGs9KxKzybrIutYZozlr8XcAQxIiMwUZP566mFnO8gmpf5Jyvx4HLyu89wMi4DKZ+SYCizZaPNqxweqjs87HvU1jSbf+fRZwNQMZniDBZi8M9JdgHJrbUZ8wvczW7wPvEKQYswfo7i20QOTSu8HLV0+uWL3w=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 18:21:17 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e0b3:5bbf:9ef1:ca21]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e0b3:5bbf:9ef1:ca21%3]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 18:21:17 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "ericcurtin17@gmail.com"
 <ericcurtin17@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: NVMe CLI Commit - Input expects device name without /dev
Thread-Topic: NVMe CLI Commit - Input expects device name without /dev
Thread-Index: Adb/2N2pr1Q624JzT5WsuecRjqjATA==
Date: Wed, 10 Feb 2021 18:21:17 +0000
Message-ID: <BYAPR04MB5656896D86A830305A2AFE31EA8D9@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.48.94.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e7f4e36-e439-4526-f098-08d8cdf0a886
x-ms-traffictypediagnostic: BY5PR04MB6472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6472B32964EB80422381E61DEA8D9@BY5PR04MB6472.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+Q4kcGypwBGa9PZTN872kXjbv3f3lBzPlLvnhbHJDl6LdD4bPmziNI1J2uE1MRUJxArOLdujvsGQ5XcE7IPqe464bA7Ngtfie039UiQSDp1ARHwMsoa+A+X1gimzXsCb5QkjlyWA64nfVreX8+qhy8xD2ILMQusKcxNQMN2XkFNmhQGnfMTp2Bb37lIJWakTS/sQvslRBAoT6lwbzafKgDE/WFRoH9rYmdmA3TSS9yssxDYJKqEPjk0t3rVbyAMN1/kKq3h/fC0qzylE3qUQv5FGdfWCzXcKNvgDC2CbM9Isum27pETqvAJ9zEf6tqr0zd3JIDeOY2L7OAsoSQGWqb3cbVLEMtC7EY9JR9Vv/bo6Lp4VMdOBUapUnFb6nQqQ7Rrixa12UxwIvdv3Lx95+LnU54NW2gt4gu2jenk+QK6JEh0o6PYiyerCnloAbhXEKl3xXALA+X6IuFSq0L8gfNHRLW3HFTMj9AMk3g6NZJu8+/X4JckKLS/Km6Ut3mfly9ojfpo3iJ1sDxfKNaibw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(4744005)(478600001)(9686003)(316002)(66946007)(5660300002)(110136005)(66446008)(64756008)(66556008)(66476007)(52536014)(4326008)(71200400001)(76116006)(8936002)(8676002)(33656002)(86362001)(55016002)(6506007)(2906002)(186003)(26005)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JqV9UG2QBnatxFhWVifBvPOj84uAOtw0MJv59W4t+rK1CXTlGHMiVk+h/uFi?=
 =?us-ascii?Q?xxoZvaRJeCj+TmAgyvSWtxrhvEGw+Sr6QSCd3trvj5qeM3fpPvN8oDtb5hRt?=
 =?us-ascii?Q?TUYnl0FhAxeeHfZOKOUK6a22gqrmU3dDXCpxryVivuRJNZq37OjhjHrKYukf?=
 =?us-ascii?Q?SLbAFlmsXhEZHq+Way8LtKO/pvYG03P0YiR6JBEYHB8t/gzb2J1fTBVHW/uV?=
 =?us-ascii?Q?O5hkPpq2IDagfJFhc5DKpwTdSxKcA2u+eDiaSJS7K8DR5K9D7bFXoegfhiOz?=
 =?us-ascii?Q?0nMEKD0gM5DuyOPS+gj/TaYmLmzlhcJzUCDh3nl/5VqXKjWlz4DU5WVzC3w0?=
 =?us-ascii?Q?dXMiunseqPs0VJ1ndeFo9mDKBdEuJvt1ba+UPjfx6yGlXY5aynvhgihjuEvt?=
 =?us-ascii?Q?Ta4bqJD8J/HyelIZ76fFUTTMqCyxFsz2eHt6luugqqwUmwsiRraQBV1kZ6D8?=
 =?us-ascii?Q?sAHJdHGwhe98fE4TQm9FOnvl3Eoo3J2YgiKgdhSU2A/HeonqVKInIJTslPg4?=
 =?us-ascii?Q?VaDOFxmAY/uZAAAcPLNkR6RR1Ll0w0yImpfhzeQEpWND6J3ixeh2ET1mM9qT?=
 =?us-ascii?Q?rT6HTopd+HWjdIAnoS0NV8BAEfWew9vnaYUBfSJYeqsi9yvu8+G63ZycNkiS?=
 =?us-ascii?Q?uSyhFnqkvM1A/4kwDoU7WzXb1sUTvMNSBrVk7jnMo+zxPOgXGUEM40APgn7U?=
 =?us-ascii?Q?rfHBt42PU4XoFHPXyskUR+wPKaELLU56XYBWULyiaRCTBbKuOp8Z6yTcAWkv?=
 =?us-ascii?Q?NxvahFjHdHil7SekWdK7a8AP544Y5YdpvgMN11G5rahCOYKtIdj+jbTySiBV?=
 =?us-ascii?Q?ZeB246ddbsgKJJ4OnGh+K9GDHbHZHCTMllsGPrD1LFqd6gERW7a0lG/OoVji?=
 =?us-ascii?Q?xvLzxNaKHYRkUDXQQ3ntxcVZ/KRnBJKrIP5DGzaIuok2E1FWGykYP4zPQTT9?=
 =?us-ascii?Q?i/E88ZgrbYKtjJVjPDQ8Z/ZPE3DpOOu2vKyznf1qZlfojPivF0PbqiBxbNde?=
 =?us-ascii?Q?T6ooxVyyMt/IMIA2cFMFLitpDibUjf0ZvsRHyRVQXnJxxZWBKsDD2ZAHdvws?=
 =?us-ascii?Q?cBqKXJJrkMitaLynMnGvuZQnOOCrhMBKSjj1bPMLDFPyFspISbQAc/WIX62K?=
 =?us-ascii?Q?3KeVj9uNf5Br1yQPyTS6QIvVGPfH4rRyLE9Vos9/8Ayh4tu3Bq0fXulufMtE?=
 =?us-ascii?Q?Rz3m5o+TM7ZpZyMGoaREqrPhldl1VL0syX75UsW4zx5/6dRAoFN8jL5nqIIe?=
 =?us-ascii?Q?zqMaIyCcpmEF9vCZf8Io4BsQl63CAyDBvZaEGW5qvtMcFTWYb4soY2dPm7hm?=
 =?us-ascii?Q?D/v1stzmSHLesNWwzkkFuXnM?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5656.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7f4e36-e439-4526-f098-08d8cdf0a886
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 18:21:17.4347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScUFyXsshZtwwPVeUmejfMr8v2J5j12ZzUHLmmNrHzlURqukVYsutEofHaRuEtylNUZJC/bEvugaLK9vkM4tIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_132123_847323_11322C4E 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: Alex Gronseth <Alex.Gronseth@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Eric,
The subject commit (ID dcfe0156360deaefa26b1d00053a791eefe397d1) is causing the following errors with the Linux 5.9 kernel:
Failed to open /sys/class/nvme-subsystem/nvme-subsys0/nvme0/hostnqn: No such file or directory
Failed to open /sys/class/nvme-subsystem/nvme-subsys0/nvme0/hostid: No such file or directory
Failed to open /sys/class/nvme-subsystem/nvme-subsys1/nvme1/hostnqn: No such file or directory
Failed to open /sys/class/nvme-subsystem/nvme-subsys1/nvme1/hostid: No such file or directory
Failed to open /sys/class/nvme-subsystem/nvme-subsys2/nvme2/hostnqn: No such file or directory
Failed to open /sys/class/nvme-subsystem/nvme-subsys2/nvme2/hostid: No such file or directory 

I'm seeing them on the  format and nvme list command.  They don't seem to impact function but do generate questions.  Do know of a way to resolve?

Thanks

Jeff Lien


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

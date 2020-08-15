Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2FEC433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 03:00:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFCF22D2C
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 03:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rHYpV9f2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BeBAMoCl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vJe5vQ2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFCF22D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=9I5uYh0cUhfl7gEJgxwxbjcFP369iNM1p8Po521OKiw=; b=rHYpV9f2ydlR8h2MoBhuOnWa5
	Sh/YJdXYbLpUQgO7evK0fW3eFyQGF90eMJlFSn1HgHh79VKvBudn5oHIeU22qHHVM5JhPddIbcsdT
	5xwcOEP7n+YfHAYk/v/1tk2qCXCVZHN7xj5As2qvvfy9DKg+r0aQfZiBDS62zIyQZl+ibxe6n/sjF
	q73eYa3DAOemQjJcEDppUcczqq0VhfotJ2b7+KHO9UQeCRUkbhrqiRbTo3J0yZoXH+KkmCn8/N4fq
	HGSQR3MEyoKrD5bA9k7buUbvOaJ4xcpXlCxXOrF4swNbUQwhuWi7Mu9ijFXE17CkdXUFKpjtbvD1j
	ayJEKH6Jw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6mQN-0001qC-Cp; Sat, 15 Aug 2020 03:00:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6mQI-0001pp-4p
 for linux-nvme@lists.infradead.org; Sat, 15 Aug 2020 02:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597460399; x=1628996399;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=e+y9oCK6+5ou/Tm6rYcv7IvVDPChwAJEyE9rvsL12hY=;
 b=BeBAMoClbAuoroZQh2HPM6j51TRb+iwi0PDmYZAt6ngkmaBlI+Kbr0vc
 550GlSy+vbrTTY5qav4/SlozRhWrtHBnd26y0A2lmyZ2ZBk6JdpWbcK1c
 MbUELaByQGqSo6VcUiDF9LshxCUxVa85zNdD5ygKLKd/YT84sn3LQmpMZ
 ehURcAyeeghuDXu4HsKvjMKhBXE3qm+TtkHTThQj1vrTemp+YDJLGDlJI
 /fKqAS6cSRSOwpNWudKi/8kxE032cFpTLlEbRr14ip6nVInmay3HiRHZa
 FAHIQQ3HMzk0bzUNwYLkhTDKHex4xSpM0Qa31LxyMFdBL6O2QLdmuN0lb A==;
IronPort-SDR: pjh2ukl7CwEvE+azhJV0VYx9Wt7V5xJXPzkbnnq4/IAd5tgle8fvLopSI7l1zxFl6NHs4CJe2W
 FJ+ZqpiDr4qnFnVDjjIzegJbeYesj/36PopuLjYcOzBfWO1XToPw6ppuNewV4grqc07jaa2D4A
 hrmPokq9T0t2aLAUDLjP9Af7o/8Epf4203pGT7M7bpU/XOlR+W67gWQlLuqttAe4nuk5D6qGYA
 OeQLYYFYbqYJ7HqhbpSg53DhgYZ9AckJrLFtYeG5b8/FY8jW1GoO4S35B3TzK12YS+v3VF9Z9A
 t8I=
X-IronPort-AV: E=Sophos;i="5.76,314,1592841600"; d="scan'208";a="149330910"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 10:59:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpHk/ORC8+d8o5PSIvuygimBX6ABiwS60058SzQwy7onHiJBr86o2vLG79pGWyoJwuCk/g3sZWs7qEyxrRfp53LoWxju5HRMbvXwkn8cN8eYHmIfTcpROYGvmPAzJZ0jtiW6BWkjv4aLHiJi806SGv4mbF/c3IuOPGHiUsrnlZGLdsJNGcmvu7Ev96HLQLUy3CY1U7KVnLhtF1ZMkKSHGvjzSHXOt8jw6HVOUNfnGhluIaSO8nCuNZZN2Ct+cQlMAbi83h4LHwbIzHIbFPw3ShjqItV1gmrHZLuyF+lDKvBUU5VNAeweJoHeS1vO8zz7ZN40iDLmmJpuKTdRj6IP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr2mjTce4kChOovmdx7Nz4InYaXT7q0dpkdn/BvY8ko=;
 b=l9j6YSkgKljgKqCKFQEmArw8Q8xkoLywrrH9JCDu1VVDNlltY+T8fzE1uwQoI3PS91b71Df1CC1JL7VlqYhNkIqtMxkwEfrf0k/3TkOAlTYg3+gB88p/wcAkREVBf/5vfadPNmm5ToNn/Uv0wZq2pjC0bSRUTMB/uMtivGQepq3l5kZ0hYkBaNICeSqhKVzDFDAFxOHstRlCUG+Ee2BJ9Tz14jgcrcbHkvbgJ4rt/Hs9vO1LDmnitoGtk00kzUMVRetA8joLjSnycbf+cr4EMcLM9/43meT0hUqgt1mFrs55IwsnizOlfbS1Hnn3QiQ5j10xLFjefUCAhn6dg2whlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr2mjTce4kChOovmdx7Nz4InYaXT7q0dpkdn/BvY8ko=;
 b=vJe5vQ2Yjipn9pq08sXSGrPW6B6LLCkhcQA5WFBmOZd/MI3b/jbXVGje3WFOKTFsk1HPva3xs8fPneCtfxpe3a/06rf+uKOrjCTseu5MFtYvflnFvkyflfMDfleMWTsmTxXjopLtQGVifuI6tRO53hGmMGuoRUjFH8bFaQhvejg=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4683.namprd04.prod.outlook.com (2603:10b6:5:1f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Sat, 15 Aug 2020 02:59:52 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::19b2:3454:ba26:9963]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::19b2:3454:ba26:9963%7]) with mapi id 15.20.3283.023; Sat, 15 Aug 2020
 02:59:52 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATVH V5] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATVH V5] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHWceDlOZmcsT5giUaMn7DItbkZyA==
Date: Sat, 15 Aug 2020 02:59:51 +0000
Message-ID: <DM6PR04MB49728F4912D34A19BCF406C686410@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200814021612.5161-1-chaitanya.kulkarni@wdc.com>
 <4654370f-40b9-1b35-1e22-864e762c3001@grimberg.me>
 <20200814065711.GA2070@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d178e96-ad07-4501-5a6d-08d840c747ef
x-ms-traffictypediagnostic: DM6PR04MB4683:
x-microsoft-antispam-prvs: <DM6PR04MB4683759DA7BD9BB53E36B8A586410@DM6PR04MB4683.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0ZIHyFgt4TZ+WUwUo8QBXmWZx3AYllsioQ9M5XntmMfnK4nReiCy9bOLF9OyKmCsVNf+mKk3Eshx+TEoL4fVbJRzfIN1aew41XAAufZfVX2z3lyus6IA5HbxGFSZIrXRwjc5BzzrrWl7mBJX9oDrK6zWovcLkNK2/SaxaRrufhzF7vRLUa5lCMr3O0uQBeoewopLlcsXtumsqNefl6x2M8p0qnpU0V0aKR2w/irKmzpygKgPMIj53wHBwoCf4gAKE9670ft08unl2/gPFcJO0RBg4KiRWGpP3TpaL6Jv/Exx+0dhkWQmAhhlaQ/ZjMvexBII9soh9uMaG0UrmAknA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(4326008)(86362001)(7696005)(186003)(71200400001)(6506007)(53546011)(4744005)(316002)(55016002)(83380400001)(66946007)(110136005)(26005)(54906003)(9686003)(66556008)(8676002)(8936002)(64756008)(76116006)(2906002)(478600001)(91956017)(66476007)(33656002)(5660300002)(52536014)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MlzrUXF0CGKith6j8QcGJoH1nA8R1q6aEa0rK0AtK2YD/Vt+1qqZGiW2a6b8r4HFUoeeWo504yvcEEaGRwta8EquvuKQRiSX4cTUyqSyTQfBbdUKMlFBXmEPM57PtlCBRAMvYvAETNEiVppy1kpEBsjDbh+aebsnzkgHNQfiPrhNY/se36QL67sEZrZ/VUrHlmf/Urbcc4djL9YPurME7P+xZ0IIyyb2Z8KSVjwbUfXg4mGqTluec6y2/bhTeKrCEh1kkiTRWUIkWQvR0TRcDHf3qp3cloIibwq0qa7yyDsgdyQcadaU24TnW96y2kFdq79NecgLHmvr5t+dNu9ZEhH4vrogYMSIKYbo5ZTwKlq9/aAKlFvGhLN6jjRIDe/3lW32n6ZcdUV+K+rEg8Sy5NA5bzj3LXuXfsb83l83yD4TNOBz/ALEw7UHOdWlekbcTcWnKPJz9RvVquSuB/5XWbtpgaU1X1LgRVZDg9FGH86yM+/4ix8ahdr1JRX+H3R1IkYORBKp+4EhPAUpTPEkEAJjM80hXQo3lMAr5TM+fP2cvOy35Dq/ioIrVYjOQFEtTVKa3e3o4r1Zdd3RhhT30q/8ZxQhTEex/6GVrAhFPasqcNQ7C1I+1SVSAtqS4YCMykMS+g46EDSr6Rn39A+34w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d178e96-ad07-4501-5a6d-08d840c747ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2020 02:59:51.9694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3DoFF+ZjFNwe3Xu6niXHWbactchU8resyR+LgmSHuhoPZ+nW8r9/prxe+Bn4zSs5vXLJ1y5RrZQiHSlYkaCn/Hr3fuv9hEW8uHawkG315k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4683
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_225958_522593_A10CDD0D 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/13/20 23:57, Christoph Hellwig wrote:
>> This patch scares me to be honest...
>>
>> We have such non-trivial synchronization paths for ns scanning, ns
>> removal, quiescing, freezing, path handling... I'm not even sure
>> how many tests we'll need to verify that nothing breaks here.
> Yes, same concern here.  That being said I have plans for this or
> next merge window to fix a lot of crap in the block layer about
> the bdev mutex to update the size, which should lead to major
> simpliciations of the nvme ns scanning/removal path.  But I'd much
> rather sort that our first rather than touching this code now.
> 

So if I understand correctly then we should wait for this until
Christoph has fixes in block layer fixes + NVMe ns-scan/removal.

I'll wait then for next merge window then.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

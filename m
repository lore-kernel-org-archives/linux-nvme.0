Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE4BC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0tnG9BXEaWduagHvEffox1LxPE3qnPFmIkZpu/feW+4=; b=0AzDjnLg/tC3WS11/pQroc2Lw7
	+I/jKhpLIpLYVGSL9gFWdTZXApnjMsv4kQEiC3O4OIEzEu7p3dpn8RqDG+s3nwWVjqHsDIzJcHK8A
	mnCHZSFcv2Y/HV16kfUDDEFRxLLMS7w7eQ14NOXEom9Zm1ip75nh9PW9pvDJxzaTblx2PdvOiCcvL
	I5DQgQ9HNMTkltJ21poQbUNRbNKwZwPR88xHP2fjQsj8lwMx5fw0JPgXveNgQKk3sXyMzaSUtl2hB
	FB57EaH6rIuj4Ce0l0VxoyV7kfNSgxP71mbtMW9pwstxSSmhfnMt0GAxM+BJtjx8/tDFw+/9ny7TS
	A2CGgRbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0jjV-003jUW-Ey; Mon, 13 Jun 2022 13:03:53 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0jjS-003jQI-Av
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 13:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655125430; x=1686661430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0tnG9BXEaWduagHvEffox1LxPE3qnPFmIkZpu/feW+4=;
  b=KvHGUqgVe/sPJ/gqJZz5R4jfDAXGoVbV/sFCX7RK+oAoQpN+uBV+XU9E
   9w7nwkzCbs3xHt1C0CC4lGEG3jC2iPLmrjSVwwP1mhwGi/Ug0VG3xZ60x
   KnoeY+GOqcS8vCCWY7eqwarsf5vBBQixhE/vJJSuGR7NNVny5m3PfDC+D
   wW9ZjJKhL7buqjGUI+5QEV1bVn7s83gDpHWDKGop8Rt3omYSq/7i0svfC
   8WJPv5cK597Ki8my87CJNKZ/EzEZ6DgV21oWX9rVh+ETcthciSQEmSwjj
   MDj5/4vfdGgks87+JMxAttDLLATyf5XKdrt0WUG2LBx5lLYc/yY3tYvyy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="261309593"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="261309593"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 06:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="829788279"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 06:02:43 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 06:02:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 06:02:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 06:02:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 06:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Ohuv58jSJ61C0GnU53LAJAYKcCZjN8RhUu67xgeZrenPTRu62uiW9imLemn4GTSNrSGfh4N9HkR1Wc/o54oHegT5+aiFcBm+Snm489kHSJWPp6cl7F+NLwjamwwvx0dCGJnEbqkZqOQCMuuXSEeeDZp53dhaFLNA7WyieiyO37n+gW7nfWkb8UhA9djMj6ayqfAlM9gUHLm2AhKQTYL64SP6hGyAFLnq6T3FdyEK0rrAV4FCLu6VvQenCi8T+oSLsa2kLePvODIh18vg0pK70dCLKJBG82ajeOj8OsF8UATrdSyWCENBls9PSIEAeopu7lxmpLW7cPZGowVb2MKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tnG9BXEaWduagHvEffox1LxPE3qnPFmIkZpu/feW+4=;
 b=LNdSO2JISilFdTA41BgxAqGve/F2AQXF3AWkVKY7iUx987l6TGFA/n+9w47RwCYA+h+tsbDrQVO6TKuURRGHJUf1Zwh9KZFsvdDwNLpip9MGZSn36Sv6od3VyZwJdJwYVtUBoGQp5/sg6mCz82wemvqu7bdcI76ACHS9xH8Cce5qFCGWzn4pt/b4pD6/syapnUpcMmlIOSyv8uThJdR8SGj8IWaPDub0vBJKKQMk8vHt2KA/QRk5GPt5oVdKiKWQiV8GntXRO7AriFg3BT3OwHVzU9PWo21OjvEn6iSM3Bk+4STMGtTk6Q3VXlhfZm4dieygdFw4iT9icYwk51Q/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22)
 by MWHPR11MB1855.namprd11.prod.outlook.com (2603:10b6:300:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 13:02:12 +0000
Received: from SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be]) by SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 13:02:12 +0000
From: "R, Monish Kumar" <monish.kumar.r@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Pankaj Raghav
	<pankydev8@gmail.com>
CC: Christoph Hellwig <hch@lst.de>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>, LKML
	<linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Keith Busch
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "Rao, Abhijeet"
	<abhijeet.rao@intel.com>, "p.raghav@samsung.com" <p.raghav@samsung.com>
Subject: RE: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Thread-Topic: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Thread-Index: AQHYe9vO7iZneeeix02+6Itt57U7B61GyDHwgAAJhoCAAVlYgIAAM5uAgASGuJCAAGL6gIAACEAQ
Date: Mon, 13 Jun 2022 13:02:12 +0000
Message-ID: <SA2PR11MB511533DE1F10D80B57C07AF0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com> <20220610061449.GD24331@lst.de>
 <YqMMo2Dv9SZRtR7B@zx2c4.com>
 <SA2PR11MB5115C9D7AE1DF332B29625B0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
 <Yqcrq2ewmqhflAYw@zx2c4.com>
In-Reply-To: <Yqcrq2ewmqhflAYw@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pankydev8@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51308a9c-53db-4f25-2bb6-08da4d3ceec9
x-ms-traffictypediagnostic: MWHPR11MB1855:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1855FCF01ADFC123CB756249C3AB9@MWHPR11MB1855.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0g/2SGMIVIC7orqBlacOViLMEd+Wqe6rV0w5yMRmEN6R1xlaREhjalnkiO5xJ5USuFG6xEhmcI/tYxQM4KmRsuWuOBZWE2hx13teAJ1L1t4rDW2dI8XUd9h22cgJC6HSq68dhpOAxITB14hv0GlRF6gzoty7ZT0DbWu5VKZpF1anKmfXSCBlSiXIqtqCMBrnmEqmvY1D5vMLGRxyY9nt//WZn6PtHxoAynTV727Qpt9f4c5L2X9VVW1rNBD1l4Esh5S6H9D5QT1oSvlDG0DQzdk7UZMhhNp5fERqvfZATfB590/GqT97tHPABPm1T9QLndWz/imDMBRnS4KR8qwKVkoscDc5cZshnKUmrLLO5m3nRY2+ncI45U8hMsR5dvW1w3PWYeXMHHvUOtIdlhspWwdfeHWlPUljusx5fi3aPbRQDbFIDsY77W4zMM1rduaNQ1vo1/dEvDV9flfk4WEX8okEJIb2OrLGig981Ak1S849iHOnm6zoFT/eY4rbMOnSgvXliwY0TJGLQsA4dOSOrcPuUgK6l8BoGvlJwTj9G5n6kDt8/CnyfQOtNwZJj+JeTF4ByC0+qCeGVSjFebmsbmCwfJPdhImeQHLE8Ob3HPYXej41P6ot8hsI15fRNe8SxpbvCXk0lSuonJObLLmK0/XjvVTfEqWwOKWCOwxz4PjZ1NgYJ0qPxUAajJFnV9r/KxaBSal5Y7+k/P1H17aIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4326008)(64756008)(8676002)(86362001)(66446008)(55016003)(38070700005)(5660300002)(7416002)(52536014)(508600001)(110136005)(54906003)(66476007)(33656002)(76116006)(316002)(66556008)(2906002)(8936002)(66946007)(26005)(38100700002)(9686003)(71200400001)(53546011)(186003)(82960400001)(6506007)(7696005)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFdUekloblVkdzZMSjYvTllLNk9jRnN5U0FXYktVZm4xTlhJUENFVWVtVzNm?=
 =?utf-8?B?aWwxMHN3UlNOT2N3dkQ3LzVuVFhleXhiQUJHazBBK3B5ckhObWxuRkViNDJG?=
 =?utf-8?B?eDdOVjB2bzd0c3pYd1E5WjRDMUY1MFdqL2oxNUhQUk8wUU5HVDU5ZlRVNmtO?=
 =?utf-8?B?S0tlM09wNFNkbk8vMmFHdUlXWVd5NXFtTWt2RHhQNXFPZ3hGVVlCYTRRVm1n?=
 =?utf-8?B?OVA4dFh1eFdzbElUUWc5TnRhd1ZLUU9kR2d2TjlrelpMLytURDUxMjBhbWZw?=
 =?utf-8?B?NUZ3YWYrMDFaOFZYTTNtNTZHZ2ZoczFMa0pXQzIxMVp0Zk1FajZOUENuaStN?=
 =?utf-8?B?ZmpvOGNxYU9pd2cwQVZDYU5PYXM1OG5oeERNeFd5enBQWE01MkxNM0dyaXNQ?=
 =?utf-8?B?Zk9DTGNlZENDbUIrSlYvRW4zck1QSTZQZXFZT3ZKSkFuYzQrRExWaWpNM2Vq?=
 =?utf-8?B?WStiSVA4K20wWFpXVnZ0N21LN09tTkVjZ05WWnRia0xyZDNNYXJ1UEpDdUZP?=
 =?utf-8?B?WEJ3cDhiN1c3dGdyVld4cG1kUlhVblI0QTlQWDJPSDhjWXRoK2FOcS9RSldp?=
 =?utf-8?B?SmZvMmpzaTlMZlY2V2FXTDRGZ1JUVXZGckFLVjlYUnBpNHdIYTNOLzZFN2Vs?=
 =?utf-8?B?akdpNGNnMzBmTGZOengyM05aS1VPSStRVnFNK2FIVlNPQ29YMVlQS0xGdjF6?=
 =?utf-8?B?anpHL2hrcDdjK3pXUmE2NkJqS0F3bVJ5V0JFSUJvc3l4Uzh4QjROUTQzZE04?=
 =?utf-8?B?RVhnNElDZmY3MGwrcGhtNXlCSittV0FyRDZXTlRSdEZKQWlrR1JGM2l3cFFK?=
 =?utf-8?B?Qk9FeEM5R2ErL0FieU5FYmhCaFowcFlmaGkvMnU5VHhKTHp1NmZrTExZbHRU?=
 =?utf-8?B?amRJdUxaTjZPSno5MURLWDU2eFVrOWE2ZGEyUkw2cHk2Q3BMVXV0cm56MnNJ?=
 =?utf-8?B?WmlEUWN0QXNYcnl5NWtubXZhN0NUNWxHeGdRd21yS0NPOStDd2EycnQwZFRK?=
 =?utf-8?B?YWM3YkNIZFgyZ1drTVM0WWdjMjJFTm9PTjZENnpFSzFLN1VMMDluYjBmc3gv?=
 =?utf-8?B?YVMzM1UxRU9oQ1E4dTlKb3lDRW9UZHp1Z0o0MWhUV3lhN0JkQUl3TmlLaS9W?=
 =?utf-8?B?RmpKMzhTMWl4UlhxbFdLcElNMDZjMVJDZ04rZ2V6Vy90YXBRS1VDcVZldEJm?=
 =?utf-8?B?aDV2TGRKYWRGYWczeWRzbjBDYUZtODRFdGFtQjRBbkpMeFBXUC9NVVA3aTY2?=
 =?utf-8?B?QjM4YW5UMHBkeHh4WUc3bUsvMnRKdFBkcXVKa0RzRm5hNzZ5TENuSmtlV1kr?=
 =?utf-8?B?TDcwM2x5bXVEQzhIVHN5R3ZHQ3pBVEtqNUxSU1NiMmgyeXZWSHl6UWFsTk4y?=
 =?utf-8?B?anFwWWxMRVduVDU1Y0lqRm84Mnc0aWlNZVZSYWhrelJORk84ejdDTUJHajF4?=
 =?utf-8?B?T0pqWnJzakpWK3lwNU5HcFlGc3I0ZXZWdnl2L1NvVlRYS0xtWDZtZGgrd0t2?=
 =?utf-8?B?cVpMazlScFN6MHZlT3U2OUFBTDJGUVgza3ZEb1p0ODlmSkFCK3ZveitHS1pr?=
 =?utf-8?B?M21QQ3pYaFZpUWQvdVBYSVB3QTNPWFhFSlhNQWVIZVlxdzNQLysyTFhBbW4y?=
 =?utf-8?B?ZTBDTjVDdGtEcEdraDZSNEJUekIwTytTcWFLZ1IxM1hvU2NmbWNkUDYvRVpR?=
 =?utf-8?B?ZW9zUFI3MFZxYVg3U0EvcGNQZlI4Y2VUM0V1WUlnbDNqYTQrQS85QXBqVWpi?=
 =?utf-8?B?VWo3RVRVTjdWZEVWU21lRVJWZmlCbGNpRXozN0RnMC80U2prS0NUQVZhSC9p?=
 =?utf-8?B?cHpROVE5eVJiVGQyV1liMjlQZDZvUVhvajhXUk9yNm43OW1sNzZJbnNsZE1a?=
 =?utf-8?B?VG1VOWxTaDhLVThlOFZNRkplVmVFRmVKNWxSNWdGazFlMjhZdDNpWktKL0sz?=
 =?utf-8?B?U3B6SjFWWjVkblBMNC9KV2NOMk5oeTNFSXRNK0xDMEFZcXNsalNVaFdEMmtm?=
 =?utf-8?B?ZC9uRk5mdVZJejZZVlE3VktxN2w5M0pJdUtvQTRaL0dWbm1hbm5qOE0wYStp?=
 =?utf-8?B?aVB2bHdveEorNEh2bGdOdEo1U0ROSTl4Mnh3cVhRUUwyak1sejVuTy9DK3o2?=
 =?utf-8?B?L1ZkU052K0hSNEtKODN3V21NYTdQWXE4eUJGZmJDdnc0em1HZ0VFdFRjbURk?=
 =?utf-8?B?RFNJUytvYVArWHRUZXBvWjB5OXBiUTB6cXk2bm1lN2J1b05iRDloTDhXWWtZ?=
 =?utf-8?B?alBQOW5HR3BWU0I1UDVyMklZSkUyT29Tak1yWUZNMzN0M3phR3JUUFlaaFFj?=
 =?utf-8?B?L0EwaEJlbGxaVVdwYWxqUHhrWmhnNlZSVEtNaE01OFNYajRLUTdXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5115.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51308a9c-53db-4f25-2bb6-08da4d3ceec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 13:02:12.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCy4S4+zTTtrhAUzXu+vNU0np83kw3XxJaoboA6lUi53i36s1VzN2Umc/GGR9UwDNfqh/DUGFNZDY/3aQMVIzYbyCXA+LxmP8t+Ep+1ahdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1855
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_060350_560541_18A125E0 
X-CRM114-Status: GOOD (  10.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SmFzb24sDQoNCkkgYW0gbm90IHN1cmUsIHdoZXRoZXIgdGhpcyBydW5uaW5nIGZpcm13YXJlIChm
cjogMVAzUUVYRTcpIHdhcyB0aGUgbGF0ZXN0IG9uZS4NCk1vcmVvdmVyLCB0aGlzIGRldmljZSBp
cyBhIG5ld2VyIG9uZSBhbmQgd2UgYm91Z2h0IGNvdXBsZSBvZiBtb250aHMgYmFjay4NCg0KV2hl
biBJIGFtIHRyaWVkIHRvIHVwZGF0ZSBTU0QgZmlybXdhcmUgdXNpbmcgU2Ftc3VuZyBQb3J0YWJs
ZSBTU0QgU29mdHdhcmUsIA0KaXQgZmFpbGVkIHRvIGNvbW11bmljYXRlIHdpdGggdGhlaXIgU2Ft
c3VuZyBzZXJ2ZXJzLg0KDQpMZXQgQFBhbmthaiBSYWdoYXYgPHBhbmt5ZGV2OEBnbWFpbC5jb20+
IGNhbiBnZXQgYmFjayBvbiB0aGlzIGFuZCBjb25maXJtIA0KYWJvdXQgdGhpcyBmaXJtd2FyZSB2
ZXJzaW9uLCBhcyBoZSByZXBvcnRlZCB0aGlzIGlzc3VlIGludGVybmFsbHkgdG8gU2Ftc3VuZy4g
DQoNClJlZ2FyZHMsDQpNb25pc2ggS3VtYXIgUg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IA0KU2VudDogMTMg
SnVuZSAyMDIyIDE3OjUxDQpUbzogUiwgTW9uaXNoIEt1bWFyIDxtb25pc2gua3VtYXIuckBpbnRl
bC5jb20+DQpDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+OyBvcGVuIGxpc3Q6TlZN
IEVYUFJFU1MgRFJJVkVSIDxsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBTYWdpIEdy
aW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgYWxhbi5hZGFtc29uQG9yYWNsZS5jb207IExLTUwg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0
LmNvbT47IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IGF4Ym9lQGZiLmNvbTsgUmFv
LCBBYmhpamVldCA8YWJoaWplZXQucmFvQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiAyIHNlY29u
ZCBudm1lIGluaXRpYWxpemF0aW9uIGRlbGF5IHJlZ3Jlc3Npb24gaW4gNS4xOCBbV2FzOiBSZTog
W2J1ZyByZXBvcnRdbnZtZTA6IEFkbWluIENtZCgweDYpLCBJL08gRXJyb3IgKHNjdCAweDAgLyBz
YyAweDIpIE1PUkUgRE5SIG9ic2VydmVkIGR1cmluZyBibGt0ZXN0c10NCg0KT24gTW9uLCBKdW4g
MTMsIDIwMjIgYXQgMDY6MzY6NDRBTSArMDAwMCwgUiwgTW9uaXNoIEt1bWFyIHdyb3RlOg0KPiBt
biAgICAgICAgOiBTYW1zdW5nIFBvcnRhYmxlIFNTRCBYNQ0KPiBmciAgICAgICAgOiAxUDNRRVhF
Nw0KDQpJc24ndCB0aGUgbGF0ZXN0IGZpcm13YXJlIGZvciB0aGUgUUVYRTcgbGluZSAyQjJRRVhF
Nz8NCg0KSmFzb24NCg==


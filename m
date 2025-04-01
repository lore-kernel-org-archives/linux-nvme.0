Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA4AC36017
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9u6sTtosDjk+u0OTSLxciYWgW6UIO48jXktjy5i/2wA=; b=HKtCLdeI4euJHJoIxlqPzbztQP
	zGvngxGZEE56qodcf/GpCutv0eBukKT+DoC6sDNaWJDusdVtY2v6Ay8qiXjqt/t1IOAFm1NZo7vwD
	5rQ7FIvKgmKKfv4X8+AZtRtiZTcueJToqnZyHTZLWuLLjjKA7HONwmbNRweCxP2XDZFyh8nISa9MG
	/1gOip5vZK3awo7lYsbhakVv42iVYlras8zaRT8gah62VcWsCLWtz7DeQdso0o0EOCYvsIzfe49m8
	7bPatC5cetH2IeMI7lJQ6WYIfq2fuPUijn0O7ytc3GFJEaorqC/S/ulw0A7r6JuJhXmZmJ62/aOLJ
	pjM97L0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzkYB-00000004aX3-3MhE;
	Tue, 01 Apr 2025 22:57:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzkY9-00000004aWZ-1QoH
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 22:57:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743548261; x=1775084261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9u6sTtosDjk+u0OTSLxciYWgW6UIO48jXktjy5i/2wA=;
  b=eFp+S76WMBb87E/3/3eXp0B9QRAYQ2Rw/xFtdI+r6Ht5R6kYUvKYUdVn
   NGOeMJMCOLfrdFNz7F7TMaWWbzFCSApMVzwuKcnetZg6tk0cePLC3Q/QI
   XL0tzDO+NZfttdkyAmI9uVKJY6A71820jXU2lgJxi8z65tqxc+DMiJ3ho
   clTdgQYTedC5KXL5C86fQui+c4WrPF/YV2quyc6jmYduG0y1z6HSgTxRr
   jjr1yajjUkEYQSavjhP2izljQO0rlmHfJ0LuECN7R4F4l1JTovP2S6Oty
   oKwzj4Neums/1R4s4FzNvJhwiuORVJ53m87FIp//lZ8+wN8/IZmbx2rJ5
   A==;
X-CSE-ConnectionGUID: OhjDHmsLQoW6Ih2f5mN4QQ==
X-CSE-MsgGUID: Z0/8l4ZZQcuoHkKVza4DVA==
X-IronPort-AV: E=Sophos;i="6.14,294,1736784000"; 
   d="scan'208";a="67238880"
Received: from mail-westusazlp17013076.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.76])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 06:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5XrKQG2y7rKcWIeTKKych30+OAc0Aj05oD9kWOYcgjgF3a9X/76E/7xxV87R4/1Yh71RvyTMs6x2LYyjBbDhNC4jzX4ldwteK5zhhKwuzOb0OtV4iZh+Uc+NyLN4mJvnMSp5Fqr+pZ+UL6vuauPbJE3K1udC5xcaAbEe9nUvRhCCBF//X9KYuAAHd2mOaBZJq6C5mBSBKfct6mxQBwTcBHE+e5RpGui80o9g+UPfYGoK68MirNOmi9PDxEFPinEObf3Iq3+aepHuqhmhp72PWwJkbHN8IDWlQCkZxOhsaroQ2lznqbyQE0skWtv+R6IkyPU3RvzsR5rtWA3q6qOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u6sTtosDjk+u0OTSLxciYWgW6UIO48jXktjy5i/2wA=;
 b=lfTZM3vbPOpNB7BRJkr/3p4Z2wrJu7MTHfQdtpvSc+mm/LyoNEPmBc8qSnBQzIFzhh7UqtADNqvIomNa8dYS4MlW4PljNgvSYXkXYq4KBhpuO1xMZjCxzCbHMEA/EZdC5jtCZqs7wjLJtzkRn8TqmdEfj+kFarvZVg3UfMmLkiX0a126wqG2gTOPjlnJs7cJ9ip1ok/9rK7ouctjzqLLp0iapPM94Ao/TOnsujpS6D2sFVJkWg9/aiyI6Qi4pYE6ix+rQFydoNsyeiFAY17TS2cBidGPL06mIg0HN64/Qjs1E7XgGReNZIppMEBF+t62rOJlpMfvOYjf9hDY7hW07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u6sTtosDjk+u0OTSLxciYWgW6UIO48jXktjy5i/2wA=;
 b=T+gk2reLJknCwt55QzUsyaMXBnKctwP93i7HRUKXVRw0udMRjYoL8c5vk3vFNxZQWQ4MEXlUldr2tEuen/5vaoZCc+cSqBgGiKOga2tiRh5UnJMexltOgOWM5A8Gz7wAz5na4vUWlkDd/CsgPV88YBme0Yl/xwlbrb8evak30G0=
Received: from MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 by PH0PR04MB7239.namprd04.prod.outlook.com (2603:10b6:510:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 22:57:36 +0000
Received: from MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8]) by MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 22:57:36 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Niklas Cassel <cassel@kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Topic: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Index: AQHboCmElT3ixkj0uEiWsWJv1g7nM7ONW7aAgAEdaoCAAOqDj4AADYAw
Date: Tue, 1 Apr 2025 22:57:36 +0000
Message-ID: <MN2PR04MB68626A7C2D254018FB37851DBCAC2@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
 <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com> <Z-ueG-wTibsSu5lK@ryzen>
 <BY5PR04MB68496CB7512F91FEA30DFF86BCAC2@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB68496CB7512F91FEA30DFF86BCAC2@BY5PR04MB6849.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6862:EE_|PH0PR04MB7239:EE_
x-ms-office365-filtering-correlation-id: 3b2ed3a7-212f-4772-bbbb-08dd71709858
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Wg3umTMYvtkzwQGlioaxpMBVC5fN7S30eIE/fXhFLwH7h57slfVK3INUQy?=
 =?iso-8859-1?Q?omeXa47OrWiNK070/rAqoff3ikFGzhnJ2QKV3AtfsXxANN/rBqr7m/N8Dt?=
 =?iso-8859-1?Q?l6OvmCLZLLadSlP1Cpn4SdzfF/gn5D8kbNBJr457E8Bdfs1mbdvjuZ4ueb?=
 =?iso-8859-1?Q?e7T5JVRdb7by78fnPuQXt0yXVV1HY4zXU2Q5ADbcoT2n1ZOf9wKMQX7kOJ?=
 =?iso-8859-1?Q?Rn0j2GtR2kSXTebdirWOOisDa8NLa2iLruKzYLqIsluVZIdNPM8FPDDqUd?=
 =?iso-8859-1?Q?o1P2E6SYL9Rj5XLCBu1G0SA+MyOt4+m5AHyoZmHnlz5MBCzgg6YNC66oVJ?=
 =?iso-8859-1?Q?qUdUg0zN3vq5kfbRY3k2CazIDYsMTMU1AAkoi883+hBOXldMw3XELB09UY?=
 =?iso-8859-1?Q?NALJ5AlOZ48RZZaBYqQnr7tYZXII0w71HFiMT1wUvSPkgnwQ+/Nl2sP7uX?=
 =?iso-8859-1?Q?R34FBTyGDbu/bPFtjgVxZfeRoJJu+kBmv13XD8uHTsid4i7mlxxg7Iq2Ug?=
 =?iso-8859-1?Q?fAZyM+DCBC3bF/xNlJZ0MF/dvv3ufTyFi5JY9K6i32NaPUAWHe4A8q505C?=
 =?iso-8859-1?Q?YUCjpgUejrusviXKqjD/3MI5j2RY0LpK1gN1nvX17g5QxB/gKzla0I8YzY?=
 =?iso-8859-1?Q?IZ/KNsIFkTGs7zqiaeRzHk0y199HZ+r/MAdHDI/ZSdh8VWABjA9FK3pFKt?=
 =?iso-8859-1?Q?AcJ10jaYfp8uCTs4mSHqwoBCEgJTF4oXt2V59v7WMuP5IRG5W4zu2jvVBF?=
 =?iso-8859-1?Q?TdYAoNPkA3FQgvzo3vANGgoWpEicIZKb5tXtDZ3AAplpV/sUgUwcG/ll3W?=
 =?iso-8859-1?Q?V+3hm9+6Lgi55Fi9Svy/WQX/wvuQv3EpIxB1ZRPXbrMGstasFXJG0PHgPi?=
 =?iso-8859-1?Q?td1xG+ppuvv+U8N9QB8Peqi9Li0yVHbkjKK30w5qsFXX1lDfi3pbVu95x4?=
 =?iso-8859-1?Q?3DE4ER+Zhd2Os6WHAb68/eu4vTFdQ7+LICUMSCO/wV38PLiDFWowkrvuXu?=
 =?iso-8859-1?Q?YlAgtbXtididCXQHlcGI0GDXN09MkTBanLfFHBFnLqn46y9apa7aHcF3vN?=
 =?iso-8859-1?Q?I3+d/dREIiQ09oxoI6qvYdVFd+7YV3WKSbxJBWFfUBK7c4bkcgxAyd9b0c?=
 =?iso-8859-1?Q?uull8XRMyhG5eUGWqnOsMMA2tEF6FkYStcDlG1dY/E7grbFMOgwFjyRJp3?=
 =?iso-8859-1?Q?dBKmQ/flLutEPFo9TSSGlAFillZl9uAM6RxIBYwkAea09/aENmR5PC4DHG?=
 =?iso-8859-1?Q?lZ/e9gQBHg6Pow0XPSqMBkhSzk8/Oq6wuQntKTKRFzQN29EXt3QIgy7vnJ?=
 =?iso-8859-1?Q?dUWhN/7FxkWFvvDW/AedS4dqD49I8/nZF/2ew+Ge/nhc+6Fy7qbm11bR3B?=
 =?iso-8859-1?Q?qcmWfv5ZJmajSL15AEi5FK8FWKW7cvz3pxMtv6hVHB29fKB+V7CjjL89am?=
 =?iso-8859-1?Q?n3ZyyNTSxj+04aopJ2t2637o9qrs2raVjzZi1LnMlJ4uWI7qC+zFsaqMta?=
 =?iso-8859-1?Q?URerMboq4GgVt11yCrNSTw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6862.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mLa+2mThFAhdVY2KHbvxNXKYfEJ2boYv5J3xYcqMuZDWPfKo5luJ5dPuGr?=
 =?iso-8859-1?Q?ZIm+MwBoj5WoEj4tQ/CABsTxH9zRssBMfvmdE/G9Mfpx+KAZHSCzFksR9t?=
 =?iso-8859-1?Q?zraBSwY0PqL8mbK5FTM+tu0lQ+MHbFH1LYEhJ1UuM6e3QKF5/tSIZC5m+x?=
 =?iso-8859-1?Q?3rMcVoAv20ujLB5AXSeVo/LESjpZX3FjzY2Zw9tH7E0YvYNRFb9GwUyLuh?=
 =?iso-8859-1?Q?p2DtH0yBnF2YvlRDNeuP8H4SaFGtkmBF+A78bSfJUwUjt1zlPzLjLFtqHx?=
 =?iso-8859-1?Q?mmG+VbevrS5gmucS/bmr+hqnZIcxCPhSQDZ0SWVy5ns/nq880KzRkdF17P?=
 =?iso-8859-1?Q?TLSHLw6pyHYcjP6eYpfW5l395R0rCbE0c0WhQaelVh9IwEKkBfKV3bdk4K?=
 =?iso-8859-1?Q?j7qOX8CdNDkMNqsEmR4g8PvN+Cv+ImVUpWHESYND0fLqzfeem3iUi7TWXb?=
 =?iso-8859-1?Q?VJnGih6gUrtQxKasv6hFcjGDbK/0mjoioPf7cnhuIOa6xZts/h3OMnOEVV?=
 =?iso-8859-1?Q?BtD7DDVcEvRQcoYpeUB4glpsno7Y662q247EsCYbTHAMyMA11E3Sy1+sNd?=
 =?iso-8859-1?Q?00m0bvz8gwhvdRo97JlTtonoH0PCpA/JPBUxIy2juSwdBoyvt4Cd2vNCDq?=
 =?iso-8859-1?Q?HXZVdHdF2K0m0+AJjYbNWu82/3VWLKdfEIeNPvfvGMSwhR78JzBhIjp2Yl?=
 =?iso-8859-1?Q?JgtXf1lO1Efcu8BRku64+CyYQAdcu4QsBn2UVkT4S0rS33vlP6ucMTse/k?=
 =?iso-8859-1?Q?Aj5AYu3+sPwPblyFnYf/vhpuEvKK2hgovPlrHrg7IW1Tf9Ae9JouyrGCQO?=
 =?iso-8859-1?Q?5PA+dljL8X2wYgpf6IcoDwBsbtXtFUKxAVJUxDMC3ClrZ0SZNIw8gPPiHe?=
 =?iso-8859-1?Q?M7wAD7RD1GUtz94ZQcMtGuM7e+fwNuycR4O6ho5UAWV9qXGxK/GoY6SPzi?=
 =?iso-8859-1?Q?m9WxEZXbh8fIMKieVgVPHadVBFt2RGVwBIXF3118Y0xkf8DL80IIi1X81X?=
 =?iso-8859-1?Q?sjbXyuOjXw/1ScXtxqjNBNx/i/jY9dfmIrYfvET7Fk3OHKLSypwgWEGQR8?=
 =?iso-8859-1?Q?d3IpEn+0GJUcLakngQVqn4n6FHBNUuHIipjFFzXoPC3HLsB/12yqSJq7eb?=
 =?iso-8859-1?Q?jtV/mf9A0ywK4KtlhsOb3TlIU03GzWgBumwRhmni9bh1AJ7kD9S5/R2b0H?=
 =?iso-8859-1?Q?GkJH1mfe/ym1UgO6qUoXMl0tACiHcFWbzQAN86qXfxxGm5Y6zqMLWkNZzo?=
 =?iso-8859-1?Q?RRnyNT/xwGB/XCSA35r0lp+dCD8UX3n6pLR174XRDp+0Ud02GwN3yKPDJn?=
 =?iso-8859-1?Q?wsB23Aepp4N23rfUuGA9W2g9bMUSE3kwa/o4i/CjDcKjrS39HlUnlhXK/4?=
 =?iso-8859-1?Q?S/SCG2Pap3hDQCj2CMuKJ/vWDdcfcUZlHn0mQlilEFj+6YW2I8ZdegpJJk?=
 =?iso-8859-1?Q?agmjbibzYN9Ov/t7KofLwGOoIbZ9OSyNGeaLrIP6x/CTVGENf3plXE9BH5?=
 =?iso-8859-1?Q?G6BKj7V+9z+nLDmevXd1UIMrxO6nl3vJW0uoMORjdOtCbhWpBfpzvKnnz6?=
 =?iso-8859-1?Q?Su5Hafr4uOKfHc59+oMXQVh/Y/FiycefBrG1+daJuKmksc7Kp8WD29QsA1?=
 =?iso-8859-1?Q?Xq+9gtOVws9FHcSowmOH9FzMBLADJIwXuy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h6QtUnRN4r0iUr4DKxOl+blZxfozYR3eyUZ/Xvf3kaZ/8+Xgxge8AAr37nkxipxVoJ/x9dvGtQliIR53Xr3FQYHTSBF2TXH9v0lHYsiwJpaHH0Hcwk8jQ3867/p4qDWyRvkq1ePGmNJgFcjfV1WnCO84meAkjgcXZwzijbksCnagQwYtZ4+pcDMrUagKjdRcZNsBNAxmI1IEz2IdQZ2LIIOtHaecupe/ZD2SjWzmRLOx0PwIlPykx7s7Bfzt2qRYw9xM3ASJLHI1Tyq/MXSoAK9c9gypZGqrEB3vAjAHiuOIDdDrS9RLWqZbrdSRCFopEThif+jkC4xnMSdLZ7DGgVp+4D6JaRy2JViYl8T5T5LaBM+Qgu/kr0KyHDL1+ZVF+AZkkGjkh26lnc0qDka7xcQqqeFA8zThqyNDGM+5YS0OPm6/AK/oCb0iyBrlde8eeTsbAGH8SvRFWrh/YBsB7doyN6T2seLVkRBBKT9X9NMWMCFVp22Keok2O5Y0HTchIiAP/2J7BTZ7beL0bwFTGJsqr4JoSfIS6o/z+vrQqwHQPwg9VL6ew47N8U0+I3bur/S++LRf2QbJYOMN80JTW5msXBfOn+3JLw4eA26i9//bq/tpdDKEeRLnXtowJzqi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6862.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2ed3a7-212f-4772-bbbb-08dd71709858
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 22:57:36.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnNMIWpDzBKBt6VEhL+04ZG/PoonoGR2sIUCgq6O/g6K7ptVQT3c1P1BFwPnNTDnU5vFKb+wKv7oGS5Nc2kMfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_155741_389558_C8D45CFC 
X-CRM114-Status: GOOD (  19.57  )
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

Hi Niklas & Keith,=0A=
=A0=0A=
On 2025/04/01 01:04, Niklas Cassel wrote:=0A=
=A0=0A=
>> > +=A0=A0 /* An admin or discovery controller has one admin queue, but n=
o I/O queues */=0A=
>> > +=A0=A0 if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl-=
>ctrl)) {=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->ctrl.queue_count=A0=3D 1;=0A=
>> > +=A0=A0 } else if (ctrl->ctrl.queue_count=A0< 2) {=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* I/O controller with no I/O queues i=
s not allowed */=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EOPNOTSUPP;=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(ctrl->ctrl.device,=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "I/O controlle=
r doesn't allow zero I/O queues!\n");=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto destroy_admin;=0A=
>> > +=A0=A0 }=0A=
>>=A0=0A=
>> The queue_count=A0comes from the user. If the user provides a bad value=
=0A=
>> for an IO controller, you're erroring. If they provide a bad value for a=
=0A=
>> discovery or admin controller, you override the value. Why the different=
=0A=
>> behavior?=0A=
>>=A0=0A=
>=A0=0A=
> Good question.=0A=
Keith,=0A=
Yeah, that was me trying to plug the driver hole when I was hacking the=0A=
nvme-cli to pass a zero I/O queue value for an admin-controller. While=0A=
doing that allowed us to connect to an admin-controller, it didn't prevent=
=0A=
us from connecting to an I/O controller with zero I/O queues. Per the=0A=
spec that shouldn't be allowed. Hope that clarifies the reason for that=0A=
2nd change. I'll make it into its own patch.=0A=
=A0=0A=
=A0=0A=
>=A0=0A=
> My initial proposal was simply to override the user provided value=0A=
> to 1 (admin queue only) in case of admin (or discovery) controller.=0A=
>=0A=
> The check for queue_count=A0< 2 should be in a separate patch, if we=0A=
> want that check at all.=0A=
Yes, I'll make that into a separate patch.=0A=
=A0=0A=
> But to be honest, the code did previously=0A=
> allow an I/O controller with just the admin queue and no I/O queues.=0A=
Agree. Initially, I was able to use that hole by forcing nvme-cli to=0A=
allow zero IOQs. But based on your suggested driver change we don't=0A=
need to patch nvme-cli anymore. That's slick!=0A=
=A0=0A=
However, from the nvme-cli's=A0perspective it does feel awkward to be force=
d=0A=
by "nvme=A0connect" to use -i=A0<non-zero> for an admin-controller, even th=
ough=0A=
its=A0now being overridden with this patch. We will have to come up with a=
=0A=
cleaner and standardized way to connect to an admin controller.=A0 A standa=
rd=0A=
port number for an admin controller might be the way to go but it's not in=
=0A=
the spec yet.=0A=
=A0=0A=
=A0=0A=
> Thus, without a commit message explaining clearly why we should start=0A=
> to disallow an I/O controller with just the admin queue, I think that=0A=
> additional check is wrong.=0A=
For the separate patch you suggested, I'll add comments to make it clearer.=
=0A=
=A0=0A=
Thanks,=0A=
Kamaljit=0A=
=A0=


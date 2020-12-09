Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:13:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6794E23B54
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6794E23B54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4p3ctG6fFduwWU/xLRTC7Mz/DIJyhhwt5vOeJNuFqu4=; b=zNzrqCH429wt3fwwLSLmbwqO+
	huJ+uM1laXQ1k4fAg5imAw19nFe9mVkMtBt4oGik3kescb3kifSGqQGHEr4Ovz1xFGm25L2Z/LuPh
	lNwVp7jnCHTSbGmZtajEMQ1EwGP2qfIsezPs93Jdl57+UKcBK4GusY8wkqrlZFupj9+FcxP6LyWSN
	H9KkODsnKdIb0A6QOOhvN9jmUg462VEfl3jtKemLe7gozk6hoOFQVuH/aPY1oeiGc3jWPBadi5iDC
	sTTzERQaCOMzVbhb7pQ5w7p4nr8zZaIgIJtlkeOXsRYxIiLUBlxVLSeh9LRT8hFhrQeTKQj0x6xne
	rJJUBxEsg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmn6x-0006cG-FY; Wed, 09 Dec 2020 00:13:39 +0000
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com
 ([40.107.93.77] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmn6v-0006bx-Pw
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 00:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQnbD/kJWNd1JBwAra3HXkcKPN0Avup6Du9oVTnvFKS/p3UpnDTHEgaFYl+pOWBJwfO5b10w2SZ92zqXJ61jCMBWBD6aIqX+efMWu8Z9hlu8VG9CkdtEdYb1YtT8yr1hNXY9UoHlg5ykZyJkmfoAQBERzpWBGT4SxNQFd8HrdKFZSzDwfRjyHTITLUgxa6L8pQwH34oz8bnkbWyMJaLhkMMcDNL0LeaZns3wdS8c0S2iiKbWz8G/RJ6TFvEWqe/q1czLsYmuNrSgG7EY2J7nRV7T1VU9RUK9sR1rQp+ONFwncswciGPogx5HL79xSudm2f04afHRy8jSYsvWAIOHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBxsne7pVGauS7diWPHTToiCJDrOosYOcptXgZrBXKc=;
 b=RFkPto8I+Q3nmvD3zOLz2yHcqOVHnu2o4lJb4uFWplNOE+dk6q6GagoPKgBfFeuxqbXCwG6BVNpCEtgv3dfUnLjO+FOsCNKzd6n4bJ09W8YHMnCdFVapWW0nvUuJkhi1sYVGc38kITz1fRJlzrfIFUnVDM8+7OxhZ3XUNLmYezMarSG2dlAVaWB+d09AQJpHqoK9sNoeupr1Uj3xynhRqyct6oiUJhQjxlUSBQAEE5wyVPuHR+r8SDenAdO1wOV64uLWIPBUxn26uHcYdfIH+1UnHqsICBasF2U2A6DrP6BPbA4Uru/Qm2UjBBjLo/VemxGLwmEPUiy1SiUyS0+VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBxsne7pVGauS7diWPHTToiCJDrOosYOcptXgZrBXKc=;
 b=cxwzrBpnIC87NJCIoWVUylVHcjtoqbWhvn4HYZtb31Q3K9XPHNdpMaOk53mUqqkDbS0UQQssgS8HXVcD9Vy5vVScrPS96a//XiD7hHm4ulSt+FyHzjYkyZSbyZ64f6sDSDakExTPFF6zB9vmHhwlK2J3BvaJUryUqYSX9xp4/K5RWzS9l1OcGPkkGDG/pzt2fgxJsGQcItsV7x6yaIBToGGkB7wBSStNk6sbrzOCfKltkgT7D25CoSc8UnLMZXzv60zYbMIYmiyKmYk9eG4loFuTpsa6rUvyn7adzq5OuMNWblawVG6c/hmBbNxRH4J3LWHVy22x8TMIUcsiZrwG+g==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB6521.namprd06.prod.outlook.com (2603:10b6:5:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 00:13:35 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 00:13:35 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgIABtGiAgAACP8CAAAzlAIAABdaQgAAv1gCAACeTIA==
Date: Wed, 9 Dec 2020 00:13:35 +0000
Message-ID: <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5cd3:ab9b:a8f1:b122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef4d58f1-fd62-4303-5820-08d89bd74545
x-ms-traffictypediagnostic: DM6PR06MB6521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB652105EDDDB6C586BE2A498CF1CC0@DM6PR06MB6521.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KeYJzLT3kD/f6Jk5r2TCSgZJ9UmVKCCbtpNSW3BrR4ZAT642TBdE7qfOa/McqgvYQ+kiV6k91MWMo5PHkBfXfCujb8S2Ma5iqPs3wL34zix8968TRzVApQ/S+jzs7Mh8fObY3tHfW6hWgNZ+G31IoKPPLh+nV2Auidz5iaxvgEwiUHUP3OUs0AzyAYLknHM+L/ZPqkSSaVj79/umQqiuCMqW2IGjuVxJcmbgL+MEgaS0dtFuSuktNaHsnLjS8B7w22aGZiGligk4/FO/c5PUHVPFlWVvWTzebQqkxfZFQzzDda3uIyyuGDDMa5/t6nm/kPHIukcZDfQSrfixiTSziw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(86362001)(2906002)(4326008)(53546011)(508600001)(83380400001)(8936002)(55016002)(6916009)(52536014)(66946007)(15650500001)(9686003)(6506007)(33656002)(76116006)(8676002)(5660300002)(186003)(66556008)(66476007)(71200400001)(64756008)(54906003)(66446008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s1/zV5Sajjasokl21dkv2Jx4uTNi8Ln0CaQOZ5KpmQpDQ+WJiAsQVOZtlAgl?=
 =?us-ascii?Q?odpTrD7xpDlcCTH/DffJRonJAgX9GXZ4OM+P+RkJ3l1h/sJAsaOyYj2yCBPX?=
 =?us-ascii?Q?tLwJpL5uRcveV7azNSx1UkNW/iqrsQFFnh/Z943f9ZHh9nHYc70f7SNsl61q?=
 =?us-ascii?Q?3BPJJB6nji7sfZ6uTFu0Na9jWt0hCZpDqp8k7Xh4udhrFnjB4JIEegVXc2rC?=
 =?us-ascii?Q?SjXQJpHT9c+kCyP1mXWcKxvVG1B2RCzDANfrMPCzqaRC1RC2GGzMGSH5iStv?=
 =?us-ascii?Q?kQTHyWE202ERhkc/ORvMGn2fLzmMxxG+thpjWOJzsroG/PD9iUiJR8ashCks?=
 =?us-ascii?Q?o2tbUHRFLH8McMrreuTWYRkHleZoVnIaq+30EWiBRD/BMBu0K8ySdUC0wkyN?=
 =?us-ascii?Q?3SscJB0/EGO8bPYBdwXW9GZJC1W0DLccOfxuBgKa7yvtHbl/97tVEsgjvlKP?=
 =?us-ascii?Q?7XUPXSX78NUzj4eKVHu8M7UCyUfvlXVBATp8rhBCAhbRLxl0q49MHwUWOuTV?=
 =?us-ascii?Q?geLO9rQrKyL/6HKIyjiX7L3gN1aZR9X1hkeLJeeyA4wG6ZWEabBsdtiyUMjB?=
 =?us-ascii?Q?3qo8xWD+9sjZFYnvjxf2y420z7K5+tFLvmEEhgK1l/E8lEv9SFjQezaDdeqj?=
 =?us-ascii?Q?E9nT3R3rG61Y2orHNW1z1UiiS6iYfcL/U2kCEDJNHxHqx2Cuc+wQfdDXn5TJ?=
 =?us-ascii?Q?VJ66i8H5TUAQdlUgw9d91b0SIslTHhbLZdaLPX3DVb+sdlySMh0iSEjBfkYx?=
 =?us-ascii?Q?IrbUhSOfIwccfC+oMjtqnO8l2khYtj5JusFuGJaY58FQo6ukwmyMNK0UozRz?=
 =?us-ascii?Q?4reNXszjyTYPezvS6KK3DIuqmd07Rs1/ixzXo9JUOB5g0HP92aJyxYx4XQsw?=
 =?us-ascii?Q?U6IhSZ3KwUk/n5td1Gr4HBokW/Inwn3myRcTqn1qUFQ5XtZxYvcD5tr9cmTA?=
 =?us-ascii?Q?tJgbiuw6rMtV8nYYI21xbWm2jMIDrrnkSMRGbRtNAd/tpK1pshw2VJfhMVgc?=
 =?us-ascii?Q?+/xiS3sCdO1LoAFevqkplANIQLirGjRBFcGx2LY2A8ITjcY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4d58f1-fd62-4303-5820-08d89bd74545
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 00:13:35.3952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57CoaIgqSIx6xk+Z/ShzPZGoiEYA7O0XM+BJqs7Pj3SQ3tlnslyA82jjAjOH8KuO2CFXAf1Cd14XZiPwkWZywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6521
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_191337_885353_DFAAAE60 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Here are the authors of the original TP:

Technical Proposal Author(s)
Name	Company
Fred Knight	NetApp
David Black	Dell EMC
Curtis Ballard	HPE
Christoph Hellwig	WDC

Myself, David Black, Curtis Ballard and the rest of the weekly FMDS meeting all agreed that an AEN is prohibited during this circumstance ("due to the creation of a namespace").  All three agree that when ANA groups are created, they already have a state and there is NO transition.  They all agree if you want to change that, you need to bring a TPAR to change it.

The fourth author, Christoph, also stated during the TP development that he did NOT want 2 AENs when a namespace was created.  He specifically required there be only 1.

	Fred

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Tuesday, December 8, 2020 4:47 PM
To: Knight, Frederick <Frederick.Knight@netapp.com>
Cc: hch@lst.de; Meneghini, John <John.Meneghini@netapp.com>; George, Martin <Martin.George@netapp.com>; linux-nvme@lists.infradead.org; sagi@grimberg.me; Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA group

NetApp Security WARNING: This is an external email. Do not click links or open attachments unless you recognize the sender and know the content is safe.




On Tue, Dec 08, 2020 at 07:13:00PM +0000, Knight, Frederick wrote:
> Setting up a new ANA Group does NOT cause a transition from <UNKNOWN state> to <some known state>.  The establishment of initial state is NOT a change of state as defined in section 8.20.3.6.
>
> An ANA AEN is prohibited if the ANA change is due to the creation of a namespace.

Yes, the AEN is prohibited if the ANA change is due to the creation of a namespace. In this scenario, though, the ANA change is due to a group entering a state, and you're required to notify that as long as ANA events are enabled. There is no text in section 8.20.3.6 or anywhere else that I can find that says creating a group with a valid state disqualifies it as "entering" that state. However, I do find that section 8.20.3.5 says transitions may occur from states not visible to the host, so <UNKNOWN state> to <known state> is a transition according to the spec.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B565C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:07:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8612923A6A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8612923A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KtHc4g5UM42EwdfRqFeCkHQ+DGwLoiznXRAgLf6D4/s=; b=pvADV3eXM8f21TqoaaN6T1d94
	9xsDnZJUx+BUP5CA8RtWSwZHGaJPMXwzYVXHB7DL/fxJukeCjXnXd3wpF4VlUl5VwD1bNEuLKHEsV
	noZPq0TVRO6X0NA9pahuqGUhpVYLrEvUDk2WgkLLAWDbGf2uNWg0+1MEtnmgKNGb5Ypg6b08r4qjf
	APkcpat49kny3igfXGQHj82hOwbeG7A1i9KseW/Izkj8vuX8PSdZ5I2SqWRAfwdhSMEDy2OEGw6S7
	ShjaevOfJV1pW4I1hgVqobn7mBcvgqF5ToCIuSpeYEfXz5sP5trAw2qtKOx6vJ9Vpg1RfiU1Bg1B2
	S1HoOuwbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmn0m-0006Kh-Sq; Wed, 09 Dec 2020 00:07:16 +0000
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com
 ([40.107.223.76] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmn0i-0006K9-LP
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 00:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ1UWMNW6AU590T0HWqfXtt3sx+oObOofDJmM0W5fzu8MPcDztv5jVbpgFvVHF8xraKaRHxC+DfCix+eUEKkcBtolcOezGRyJYnuUjpwYFeEFgJPyTiQtd9sokJKV06O7mPSpYtCEcoi81UmXDw9xGxI9QqBqXiI4ml9pW5DCr/LEeXSFZ3N6e+7uHvy1rJZIj1+bGlhbIAvacFcb2sr8ASkszhEPzEa8Sj3HPIahZBE0NQWlbag4V573bH+gl3DYwY59E8W5WL1uJz/gprLUohUqb3uxiYWomenaN4Rk/3bcICSGT8kI8m+t8W5iUJ7l9SIcT76CxYwKoiaJXTPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkO32RGDA/1WZtKJUWX9scxi0E9EGPG0yQg5zgcpRuk=;
 b=WeOT68oX6aOZy3gHihyabHf/so4sJ3howZvdTEk7HNuThPFsZ2akYAW0r+txa/zbO66+wgYuhUyvFswZbRSc7cbXyN60LdJdDG7qiVlQ1QA4tIEPruW/MaJ1OC4Hjq9cX/Es76jkSjT4rtZb06FGCRJ9iZ10aBAxL8E3BVWTgWkNZ3EU2zT9HzBzZxNN6FvhH/NzCXIGGdsGfNrR0apvyfFz/uteDV3OLdiETp5YJ4XOj7WoMoMmOwyi9Ve57f9XWCix9PZUr3TL+1N2PRCv4Ci1cZhj4mZ9x5WMMgfcGIxEGmjiFgpybmKhHduQLe0ZoHVmJj2jHjraWUdmhg/v5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkO32RGDA/1WZtKJUWX9scxi0E9EGPG0yQg5zgcpRuk=;
 b=RLrxrma41rXvI2JpufkAgAG2d9O2t4FUflELNuWPDJvr03sNqw+a3MtTlKLDL8bIWK5xLMouVMwZHFEZX8O4PcVGtTTtfId1AQ7x4qyg58bbZLF6B2vnnEqI+anNWHONoMx1xnqMjoIgtqwTPZtL6SONNFw+EvkZtfQ/8RaBNgNiJPXkKi7S1OOSJkRwkFTmNtFu55goYq2Bz6rMUZgepjnb2neXZYsgi3kDsN7kCcrFuI99atZJ7SJVJd9uJY/POLXXG15s4fMIpat3i0EAefueEXdCA9mUZr4pgfln+Ro5DlvpM6Kci8L5ADS2nOqI9c4MIvVQ64ClxbBcSS87fA==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB6521.namprd06.prod.outlook.com (2603:10b6:5:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 00:07:09 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 00:07:09 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgIABtGiAgAACP8CAAAzlAIAABdaQgAAv1gCAACa3YA==
Date: Wed, 9 Dec 2020 00:07:08 +0000
Message-ID: <DM5PR0601MB36241CA22888CE6A6C66A702F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 22b68447-c8ab-4828-79f3-08d89bd65ef7
x-ms-traffictypediagnostic: DM6PR06MB6521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB6521A1798144BDB639C182FEF1CC0@DM6PR06MB6521.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8dOR6uwKtX7jHRVgIgy7hDRc2FAmG7EJL4lEbcDGTGUypMf71An/6zo3CvfF2alOL7Lh1NWfIzJhp3HiNguYtvDQVCJVJeUAbNtkNKStgrBcTJPXBMgDCiEEm+k9Hvr52v5Ooic+QMDS3Tk9UMGfXGlVav9IgB/MgE/8Q7WJPckeO+x76tdGQslJevVgmRus2l2djF38cz0BrnzFeXhhbKb0Gzr+080Wfcx868YB02gssHpz2z1cggdTa95KZdTGNGaEZJTN8y8cLC9MAlzdc8T62eTEH+RVL0YS/qwzfWs/jQhfXrAc5N67KduvfnAcEszZvmDiA5ywSPY8bzREA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(86362001)(2906002)(4326008)(53546011)(508600001)(83380400001)(8936002)(55016002)(6916009)(52536014)(66946007)(15650500001)(9686003)(6506007)(33656002)(76116006)(8676002)(5660300002)(186003)(66556008)(66476007)(71200400001)(64756008)(54906003)(66446008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x4Sy0DZC8XjZPJfKnnp9/15jtABq/4mPBe6lqlp8E76QrSxsdCYiSFg2EqCS?=
 =?us-ascii?Q?OjIGA9lbS4aEi6tYn2gaYzadZ70pZeJBxVNRTnhgoalSOG80CQvVGZTA7kFw?=
 =?us-ascii?Q?VYUieMG2HTfyMzvMyGr3mN0ZuWVkWMKSZk70OrE4o8Sx1Xx1bvYIZn0dChP9?=
 =?us-ascii?Q?4ZhvwYdoNntMYGV21FvibZ8JoHU15p5lWQwgPswwPzjjU8AULaMyKLVdus7M?=
 =?us-ascii?Q?kB62oI57nA2zqPHDzJt+EAMmNg/R1g774LVUkX23mb1BdElb+1klCHRRqYNw?=
 =?us-ascii?Q?wzQXjIgHvhWWUqV7OvmNKjtak7N2NGyZy+BQ/+lyt5Ez9s+PspcGr103zOBZ?=
 =?us-ascii?Q?b7Pcs96OahCG999hMg6bUkVppyctZz+TCZepCoMjvlXdWG1fK8c7MtgtE2Of?=
 =?us-ascii?Q?hQWu1nAZ8nOMK58VGwXrSQrIbJP121cgRXXQsna5ug70GbS5qGt7MW39fHyZ?=
 =?us-ascii?Q?P2aoeUSNlrm3okoDNioJ2N4Rr309ECc3WgmUZnY6g/w1RZQ1ETLQdiYLEcn5?=
 =?us-ascii?Q?UXXIis3YewyIEaY8Z8oyKjvtHJqcg0BAyMGySuQbEeYA3fBXzXuGaSeX2JcO?=
 =?us-ascii?Q?5B77vFuU/E4YYd6uiH9K0rfnj85Jis1fff0BRGEbjzV3IWlj0VqEUCqBSM2A?=
 =?us-ascii?Q?HrNKfFPiqJxGLrJyh/JGdz3lnjCAwKHxMrE3TeMIrNpMjK0fNc6SSNco/IKM?=
 =?us-ascii?Q?LLDMr7GG/1NYJuZs6x0xIXw89HJ4SWYzj656yt6/RLKWmlvoFQzEu/n7sOa4?=
 =?us-ascii?Q?FOiQ19Kxj1bO2rpjlRa89HeyCbKo/zZuSunKptHKGihANvkT4yAIKTIQ40qE?=
 =?us-ascii?Q?AdNnnLAtGyzOGHIjbvQhfE5wii1RfKIr5JrA2nzt+zQblGmDPqWvQLN5Nei3?=
 =?us-ascii?Q?DLgHDBvgxTU4WdNxLnx30usRhxXarHsCWLMJauN3OrFnYFS1dIBcXT13BMaF?=
 =?us-ascii?Q?qPuz4nSbkBz8kiYALVkhT3JFlneYMpAVmd9cGX8YSjofqxwJsP/lYdDaMLtc?=
 =?us-ascii?Q?V+/WiFTr7SI0gA0Nh5dF4T08tlBR2haj0D06M+ChUHiGb9E=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b68447-c8ab-4828-79f3-08d89bd65ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 00:07:08.9849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5NBTn/cVQcjKR/ZlJOhzB0azfMuhfQ7IeDBeag4PRVnoZIPcbxBDJaw7ORO0QYhQQI+3bPEY+pZdGUbhCb9Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6521
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_190713_142669_4D51CB55 
X-CRM114-Status: UNSURE (   8.63  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If you want to make that a transition, then bring a TPAR to change it.

When ANA Groups are created, they already have a state.  There is NO transition; there is NO AEN.

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

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429E1C77B72
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UykNYWaUAUw7fpxUJDmAKjML2jIZJDm8UaCHKxdLpnM=; b=hHRrbeTa0/eejI+iuEUyHYA8RY
	pZajwcSbk+e7wbdj8X/vK5z7sP8jLbtigFAoF37xVicy+yv3DAMpIagI+r+88k/QgW8JQA4ct/uIy
	Pb8CGcrTjtLH6xmgcl34Tc1TgAo6yNIg3ly+98xYTfq7Lf9t+S8WLdtPaEG4v5I2YEOTl+hGBWyCq
	RndUoTzOlwwSMQEc4n0FqTna9UXOo5RdyuD/aiN8JIMchf2JaXEyGz1CHBaNBUa/kioCAjL7I3DJ3
	5J5I1qkXontr9qTgPd6yeedV4qMFRKnDvtcBCsUKDDZ95SHyTJwVxYpSTwfpGJoi/CfYSfvReQvcO
	mS26k49Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZu9-008rOk-1P;
	Thu, 20 Apr 2023 19:25:17 +0000
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com ([2a01:111:f400:fe5a::613] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZu6-008rNk-2Y
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 19:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQqoiK76TtGKI5l6g5fVeIbqAEhqTboA27kCSQBI8GM1Mgb4tR3+ky0B26ZuAzID6nHCXG0FzJaZrsNT5+72EBBu2SzBOoXIbYHLlHezu2AJuC8vbRXCX/BmRWs2Rc43vN56ugzxTneh8jqHT4Uhx1Jv2pjAlaeQRoKPK16N6yjNAz13lxeyL+8jvKwMBoxddsA8vskjBF1Avgnddm5mBs0zb8KCI6SWDb0zPqNQBeycGk5D8dXjV300jiAT6KGNBSqVuuxzGryLYsb2UOKfYO6l2o4hRtOi9DkCYH25aZY899mkATKicVR7kX1e2pfp1aXxqxQTs4fXCwuRH/iivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UykNYWaUAUw7fpxUJDmAKjML2jIZJDm8UaCHKxdLpnM=;
 b=OLzocIxxZ9jid7hIHvtIm8Q4IerSt8799WfjSpUly/3evP0PV9B5rZohqXQrk6G787aXDejWeM0fnjP7vOYNgRNDigXsrZdTLP7gtO4l30DieIixtLU1peYByNkmINymIr1u2IK5LaC+THlSGNQa9Eb3u80N5o9dyNPaXBWiu04ADuTmyzF5Fr15lD3WwCnGsHneC3yhQV7seqm9a484asRtZxVIewpY335hqTQlNT8ht6M1YAWE20TiqvW5QA3YOwKv+0UFwpH8ke5eXl8MkPsjwnQK/fKW1Mz87oUuM+TGH2WcT9KfW5DeG8gSU+1CZHZWaC0XQujspST8ewS75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=media-clone.com; dmarc=pass action=none
 header.from=media-clone.com; dkim=pass header.d=media-clone.com; arc=none
Received: from BN8PR15MB2804.namprd15.prod.outlook.com (2603:10b6:408:c8::10)
 by SJ0PR15MB4648.namprd15.prod.outlook.com (2603:10b6:a03:37d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 19:25:09 +0000
Received: from BN8PR15MB2804.namprd15.prod.outlook.com
 ([fe80::2008:c8a1:4af3:7836]) by BN8PR15MB2804.namprd15.prod.outlook.com
 ([fe80::2008:c8a1:4af3:7836%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 19:25:09 +0000
From: Igor Rybak <igor@media-clone.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Ezra Kohavi <ezra@media-clone.com>
Subject: read-only flag
Thread-Topic: read-only flag
Thread-Index: Adlzvc/8jU4yvLUdQeOd5dxG5lDJOQ==
Date: Thu, 20 Apr 2023 19:25:09 +0000
Message-ID:  <BN8PR15MB28040020497BA4D8375B643184639@BN8PR15MB2804.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=media-clone.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2804:EE_|SJ0PR15MB4648:EE_
x-ms-office365-filtering-correlation-id: b3fd5675-f162-4b40-40fa-08db41d4f4b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  j47iGnrubld/MS7ChHiRgWsddKOHRcupwiWJXohCS6MbdVo2a3j7qeJto1Tu/anZcGZ/3OC8FV/USo1KQ/BK6SAmrR8AqsmN/5cm8a3PYJ/9/DM+5hApvQBfl++uz2izSvLdo+PqH3BBh1MonLwOAtGyxbCU66Bx33ZfVm8EDi02CrauoEf3rsLA1ZhyLkRMJjy6nYtQyLN5mw3MQ4Oj0NUvD4AfLfnPonijAzmFX27cIvW8zSg44yaI8mBEtYGlGya8Pm1zDpk5PsU7h4th0X4YJttLULE2O+CrN3amfqBxJOtEcC2OHnz9P+u8W0hpqfMEySA7/PLk6aGaTcI3v1copQ5Ix650L1oqKfN5jAO1uJ6nht1aXD5XvC4eEGF83QtGI0a4GquF08/xhJ/pxxrPs84KWMB59bH8RbqTudtag275uDW+nuoGSD+UNXLhWE7zpiILbzAvnpw5PmC5cMH3SVeX8D9NLIzCP7mZzAiTx8v45ubgyUPXBd0w5Kjn+b0hzUP5v8sWcmD5J64fmW6RzEAnk5Eh1LPW6J58saVTmb07jLU+jlsZDU4o/9h2QpZiDHavKIgcLetJh2MjRDp52CYQvIEq2vqEyiJkMKk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2804.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39510400003)(396003)(346002)(376002)(34096005)(136003)(39830400003)(451199021)(6916009)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(38610400001)(64756008)(40140700001)(498600001)(586005)(71200400001)(7696005)(5660300002)(55016003)(8936002)(41300700001)(8676002)(52536014)(4744005)(2906002)(38070700005)(86362001)(33656002)(38100700002)(9686003)(6506007)(26005)(107886003)(186003)(3480700007)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?GBrfFK/HwKooRCgujethO+G2Qieim4+xQ79yk66KWx2BYlySaXfzrR0COb8E?=
 =?us-ascii?Q?DJ5XFyVVqu0ZA1ujmAkP5SBpJeiVZBcXvJZBb5LSz9ft+GchNwuDBVL7vOMF?=
 =?us-ascii?Q?rCNytjNo3qDMj+UhpLEvhhw5C0xwi7srcNwUTfzUiIFA/LCZuYJjJRyu608g?=
 =?us-ascii?Q?qGeAx5kDZhk1JWSxJ3yCa7XiAbMNW8JdUsXFUbKZVB0GfdHPh1qkpDvzstlj?=
 =?us-ascii?Q?N9f8YoXyNJLarEz4DMJoCjIFYtHzHRQG+yJJy9Whz/jCBidGGaLNJ29M/O/E?=
 =?us-ascii?Q?f5RuOilyTLRF8tjMDsHdHbFl1adSeKEs0tJtosfxls/jC2bjqsMre/iIGv18?=
 =?us-ascii?Q?ERpCmJ4Vfy3e7dmb0M9vC1VKfCcqlj3G7OORfw5U5icvroHdsGdFdfJmWwQH?=
 =?us-ascii?Q?fmzNjEmkHq5XI76bBaHiX7pY8VbJLxCHqHBnsBYDA9n3e5foM/0FLBCUzRj/?=
 =?us-ascii?Q?mMiwqZEw9dowRlu2aU+JIuYM4xetfzhSMXyTgXTspL7O2YZxxJQhU43Qx4sV?=
 =?us-ascii?Q?DqLonQamov5+lAosMT+OlnDsZ104qXh0wvxI2MLZJTSBh+j+KGEqu89ohI49?=
 =?us-ascii?Q?4BGwmgFqXOw4XRBP4yb68PDt19mZODdRhNwuiqWvxsjxi7/oakOsmlE6oBAV?=
 =?us-ascii?Q?8PMY07dqAdwVoF8fsRCecyULPVQsz2aZIAzLLVsr6U6EvUkq/y+Flvso0DP8?=
 =?us-ascii?Q?2ZT/JJIp0mXqdCkVYbWLxGjOAuXGjbJ51xfFvHQ/mOuTfIDsXEIxnMHX4Iwo?=
 =?us-ascii?Q?IvfiMEqD2qEfRKiPVcQr0iIsrDrDCSZnZD1Q2dbOobpjb47FNu5tfUKx1bLR?=
 =?us-ascii?Q?5y6wjekjXfVv+EeH0Ucq6AyOAtiZPx1c9h1WuUZ3SzHL/0lClT5hRP4jIDQk?=
 =?us-ascii?Q?T7n7yJkLEBiMGXzMjY6M0moPYtdfMIktf7sr6bLqStuWUjua391P1lYkbq+B?=
 =?us-ascii?Q?5uRkT32RB/PFguodaVk18Fkt9Jkt8vEaT+wvJWxLmf1YoTs1KRMoTJVeQwmM?=
 =?us-ascii?Q?X5BXUQGlns+oCPwiX7i5hloJ76i/lIwRb7CcZoqg2Q6OmUw4gT9M1V9YAIxP?=
 =?us-ascii?Q?TpYgpqJRNtGBqK+BOXEIkObdeRtLBcdX1oco1MgLwp4x/4Def6fXGEWoI8GT?=
 =?us-ascii?Q?yiGEyj/3r7U3lX1Gw7i4Gy/hMpQdm9zPv3uCJEatgQPJhxJGu2B5LmoWUqc/?=
 =?us-ascii?Q?apcrjvgUDhFp3aXY13SUDbFJYHyDS/XS26U1VD+OOt29AA9WuXq+05bqMHmN?=
 =?us-ascii?Q?TkMizyKzSFV16BlQaPM6XA7EnLmNFoWokTjJDH58zsc4DxL6U/WilwSAXGox?=
 =?us-ascii?Q?bHvb4vWGAHzu8jypiWmGFbjlHoY69JAFC7Y8ATm57+LYigCpDSviFIf0xK8U?=
 =?us-ascii?Q?fKwAQsW2KXCCdzFX1a2oEsUvJY/YQxcd31nAMDYa1XPWgOSeQx4/7SlbZ/u6?=
 =?us-ascii?Q?TBsDXKA1MBk/35nyk3+E2zPgGZsPR9ThgEYVajXBxYI9wU660IlreVcIh4pJ?=
 =?us-ascii?Q?B0sHqYfTtCaSxfC1c/h3R+8lEHAF6FizAE5pEbKIGqendKc6EQPIaBUZos2P?=
 =?us-ascii?Q?U/DF/BXjaxxbN0lCW2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: media-clone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2804.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fd5675-f162-4b40-40fa-08db41d4f4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 19:25:09.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423e9719-3bfe-4cf0-9b8b-61836a4eb11d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxbn0XualdmIwjcoYc0tXM3/plNKV1ppKIaUPyntIjRp4ddvuLXLNKkZCJpsTEZZprgIF2PcOMVwCOXigLGjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4648
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_122514_853571_DA4F4B3D 
X-CRM114-Status: UNSURE (   6.16  )
X-CRM114-Notice: Please train this message.
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

Hi,

If I set the read-only flag on a block device like "sudo blockdev -setro /d=
ev/nvme0n1", I can still erase the drive with "nvme format /dev/nvme0n1".=20
Is this normal? Where do you think the read-only flag should be handled?

Thanks,

Igor Rybak
CTO
MediaClone Inc
6900 Canby Ave Ste 107
Reseda, CA 91335
(818)654-6286



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA977C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyIU6mogsbaF7OcyMGAlyRTLa/oQRnTAamIIWwFKUd0=; b=etMpxr6mdymSqGDdZ150oiVHs+
	XtWubXj9SacdOY3Fa/sIAJfeKItQn0unNRJIsPDJprWB8vA8YiWYhEoxZ+GeHVxT/gYOO+2PofsuS
	/XU4OjZ3ScwUeZdCy3zOGhvDaw6CUbvw2tdbxicEFMwMQ8VRyQCi29ftU652oNoOfhT4ZdEgCVqaw
	bRz6FsWUVjmwMZ5c+IIcC/YklWwoJDr+BqiUPoSRGqSndtZicSWw/V0fBNDKdnYjQnsM1D8ZhpjYT
	ZSmdZfv7u9egIwHlLx27Ihni7/EdI2n6jd/AWhdcTk4yxbQuYwewx6vAK2LYiLOHV5H3oW1VobjU5
	D7L9pktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scBl0-00000009dwI-2QbX;
	Thu, 08 Aug 2024 22:37:18 +0000
Received: from mail-bn8nam11on2072d.outbound.protection.outlook.com ([2a01:111:f403:2414::72d] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scBkx-00000009dvn-42Cl
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 22:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idfu3W+sMW2bqpGDlB/oy2opjS8JVSVwj2YZyWUZFCHVkS5z7d7ghiCZxycbZOON8nPbvfiFzAwP0spO2loZ8Q6MIkV86BWd0hnsZc0Ugzso/gIGQpRssgKXAXnZaajVUkCood8AJ0wH3WDAPeYrG9pJyFMrE7wOhDHvkybgRJUI7BalzwNR/gg0vXdZf2+a6XIDhS6wE5ZeMBeltnKsTfW2h3JJ3q71eFhV0yaSXl0bLHGP2DROZ6Uzv3RRo+oBP12AfgzoCiwXHZlay6ORq+UtN0pElbY9ZesfTq0Negy04KX0DNklplyQs2wDbEQ6/5TFzRCoIsjk3ZcE9SLnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyIU6mogsbaF7OcyMGAlyRTLa/oQRnTAamIIWwFKUd0=;
 b=K5wEx+DfwNAdWp+L4qAMPI/tnyWT2QjdlXiKLfTs7y5wuxtnEptGOSYxc+hzzlTnGQdSj1QfRn5MiaPMwZvjY0K2asLvG3BoM3eW1FR5jX4WA8Cyrbd2/IMZy3jPGw482F/+Jtw+ybM1e4s8wJChC9qVuOaXxosnI47NUCPsXDTNw7QQ7Xq2tuPlDaO4LuJF4SVvr0C1mhhsz0nqw4JQbAlACFvu18pHY5BU+/RfwIHfgoUzfCYN++zVFGUe8ht+widrEmQm+mxJoLBWoEfVx9TEpBuOq4ZYCMvBEFgxdeQawzJ2Y0aoNSQiDjLyBAMetmDGLSyWjZJfnoJhBSCzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyIU6mogsbaF7OcyMGAlyRTLa/oQRnTAamIIWwFKUd0=;
 b=CGR53mJ52A4mrDfqBi4p65hHr3SVgsd3+N57DoVxa8T/pa9X1+lrNKWRXbYfBNK+fkslAHJIJ90H1eKhdNokgTGX+SsXJNjQOB1yMMiM4DVuw+A/UL83ExS1LhViXe79ZV93OqWAWPgGAfm1t7pC4HrolckhV1UqV/d90E8TNP8=
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by BY5PR03MB5172.namprd03.prod.outlook.com (2603:10b6:a03:221::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 22:37:06 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%5]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 22:37:06 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Keith Busch <kbusch@kernel.org>
CC: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: Disk Says It is Full But There's Nothing on It
Thread-Topic: Disk Says It is Full But There's Nothing on It
Thread-Index: Adrnh75MzNJkXFWcSMupUSjuDERcWgAbfTgAAAMQYXAADoXcAAAAtK2wAAxXa4AAAjAxEABT4p5QAAYHTYAAAGZ6QA==
Date: Thu, 8 Aug 2024 22:37:06 +0000
Message-ID: <SJ0PR03MB650193976A7429E630C99056FAB92@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
 <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <ZrLZs2ZpxcM1XcV_@kbusch-mbp>
 <SJ0PR03MB65018D5649C7BEBDE4B8B75CFAB82@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <SJ0PR03MB6501FFBE1ECEFC2E3047FB52FAB92@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <ZrVDyVG6ZpIkBu9T@kbusch-mbp>
In-Reply-To: <ZrVDyVG6ZpIkBu9T@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|BY5PR03MB5172:EE_
x-ms-office365-filtering-correlation-id: 3d7cf30f-47e1-4803-d3c5-08dcb7faa1b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vElVjc5ld+qdnkDFYThFmji+y7EEVjy2ZzDi3LRETo/escqSu0pgoNqqf9rT?=
 =?us-ascii?Q?Bg6GRh4aQh9Kiupfo0+gT7fwzoybryRZ4FRqaFOntsCZkzcb1oU5ZQx1aBOh?=
 =?us-ascii?Q?AcvD1AQFTl6kSt3xZ26GLYNxCnEa4B5dI7GJVdjca4DueLootb2iO1uf4Tkz?=
 =?us-ascii?Q?kUGj86aQFzph7Vq7ZYQVpEjUemMitR2wJbfM8tYKYbzWpHiEkqQhoRan3oTh?=
 =?us-ascii?Q?/gkyZi0v5WfqBpHqpYZYs72LYOfJD6H4oNCEmrPRGxXsSnuR/tcxjqMkHpD8?=
 =?us-ascii?Q?kyYHroEhGrvh44wAOLGrtqqKkD0WNdFuypcEpAcEQR+B3yR7JV8E8/goJhUO?=
 =?us-ascii?Q?PhxuQarbPUBlmXJ9yjL0nm+My/4SYkTRVDA7mpk28UXfvccO4YC2F6bgU7K+?=
 =?us-ascii?Q?AH0clVSj9lf3A4Pko6o/Xv5DSBHnkGDtoiwCLAaufNKJFr0bBjGfDMrXEx3p?=
 =?us-ascii?Q?WazkifQkUZ//4wDTN5XLj79CfH7luRHeis8wtXJB6c/ZnVxWwekx0NADCvph?=
 =?us-ascii?Q?dRPkXgXTmjYQmstHbXsViLHsn0AywrbAQA5WDhdg82xVjV5wihsDghSw4+Xj?=
 =?us-ascii?Q?TeXuRfb3/doYOUjHlLr7vU7ZkrueQCJFLZVywjE98zQV3mja4aXaaQGSxQJF?=
 =?us-ascii?Q?5wttqOiKXNoaFdJ1Doj8ErUtXv6UXctLbCbMe0xxh0t12wa3YuRIWUgcAg0Q?=
 =?us-ascii?Q?2RAiUWoEBJ1GzMxvW/14IC1B9ICKMiaIuZKeeW5XFbC8XSg9HzrX8PT7G9Qj?=
 =?us-ascii?Q?oqSbxFNolR6Bhb9ONRwrBADp24d+JA39Dboqs88QJ+x4nRX87giE7tebXw+W?=
 =?us-ascii?Q?gZT4WvPe15Iyuqpbqoc2nqqWO8rTggHB9oKKK9wgrIEK53w/fa1RJMFloNu2?=
 =?us-ascii?Q?6PE0Lf20j/BACnNcr25ahd2/352BrvdyXLbUEMEGP+alZlowywvHx75x8p1E?=
 =?us-ascii?Q?IB7iheCBRtJwWaPqdk4JoGAc751qQzTNSfj0wMzHndkw4MJT9wCFMySFdwC1?=
 =?us-ascii?Q?7xKAmqAOXVOd3Lt1ZJNd8nmNlZjp4uDwa2doChean4stskZvbOU+vpxc4sTQ?=
 =?us-ascii?Q?kJzToXAlnOuzv9aRqy3wHG8bGTiSuvMmSZ9GtQAVcf1YkRu7Kl83iEh5g8/6?=
 =?us-ascii?Q?CasEs4EbHY/04IrAuMt7nVIYHvhTwt/N9gUCuFpQpBTih68DwXCn2pDJif8g?=
 =?us-ascii?Q?XLeQvxgTTHrNaxSZylM7GCXgY+vFmwpqG8RfNI3c94PYLNrFqLBxzIBH9wSD?=
 =?us-ascii?Q?p3NDOKv0B/PdD8sf7Hq6T/NQoTRpd0yf2UYCnbfz4dJcppAUwK/vL/tPdHRF?=
 =?us-ascii?Q?pE2iCcPQGOYA9XGOpc53/9lPrLZSCVSGYkdusX89YmjxCA0SF/ui0nLYPxZv?=
 =?us-ascii?Q?seQfy+y8yz/+8xrn5nnLl7w74sZilMuBPQ+AOkQlgkdcIURhxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODMAVZvGj/pXnnmtSNMHt1DfiXK6QYX8Cym7BFGS7eJIECHRFssD84BwuaxC?=
 =?us-ascii?Q?ZD4OiEIGQ+Gz1VJ4+DajI9ndymyyo4avPBy/VwVwFV84ofoU0oNvQ8zqHAOH?=
 =?us-ascii?Q?RQzAj0iWiW/mYFie81uhz5SZNambUGgF5+w+rjTGrUXMiOr91qYy3AFsLi2S?=
 =?us-ascii?Q?eEsNf4MMjHFVuo38K+lXrToXofQkaw5AlwV1PT1FwwTWzjXJdTTHKTPHBDi3?=
 =?us-ascii?Q?hkaLRBlQLabmX+2jgRHJL1IHCHp3mStVjLi9/+mWSVHtrJt4JSDyy1jWy8NU?=
 =?us-ascii?Q?llgJ/frFJCFsAoPLfsLobPOI0RmY2TnMXxYZTPNSzUPhZ44BNMxaUcnn/OBp?=
 =?us-ascii?Q?UgOwLk5ERfvSg29g6o0pMfg1w6Bst+R5Qv5aTN2j5S/09xCc/jixgwmReSwC?=
 =?us-ascii?Q?qO+dIhm8b3J4rfngP8UgdWtunTluu5KGUqsIOSU/IFqygVLYQsYDJoA56h7w?=
 =?us-ascii?Q?DEPfJzWlArF1R+kE+g+gij4JXWLJo0KlqQDdfGgAmhXh6YGJ1i0HeByM6zvf?=
 =?us-ascii?Q?460huaFNuMf3vuxDee2K4L/S1wscafOWIrflF7ci3sgXmJtoxcgAeXH0bx6O?=
 =?us-ascii?Q?FQZkZitFqkE3PiOhszkwbCzai1kHXAH1fg8sH7Z5q78ysupcDxPVCox+baU+?=
 =?us-ascii?Q?Dl0mPvgea23xXwB4a5BFKE21NCD0vze1sJnJV3pRzjGz6EWOjVx3jAis0+Ep?=
 =?us-ascii?Q?IKf37J7T9cbxZP0cgSTJudjabZKi19e45o2kpH/CPxj8OKkn7EPU26xx5sZ1?=
 =?us-ascii?Q?ExTqXblgR9lxMcfesp0dsDG4qvmHQjUOHoyIoBqtbvdfSKH+P7LMCkIvoyNw?=
 =?us-ascii?Q?V00hz9Ppa2sioSyWUrwNJY87SMi3mL4JxARGMAwpucI/INR/cPpdaN3NgaTx?=
 =?us-ascii?Q?jrWX25ntwbtwcfjyIpt9THwMIQYElDQdgmwAOCr0MP9uWyW45lzoEtmbeus6?=
 =?us-ascii?Q?JqqH8OaMYFBL1IzC4RPc7F8BB6klC3w3oy1HfMnmpF0a8M0EqomKuA5OjxoR?=
 =?us-ascii?Q?uv8w1yYS+5QbiBuCovwhBBPkDU1LgLs3XCgCMTzklqljW4V4YjKCFbfnXxyV?=
 =?us-ascii?Q?dCw/JDBbSXsTIOwsN/LTJ5+LGb0azelwGnvwGSiVsk3OkGHY2YOnK5/Sb8G9?=
 =?us-ascii?Q?O2o56Xi2GRWOuOTrOkdRgCmrPlJabo4liidrN1MGLvirAYRY7vdR7wO6NJ73?=
 =?us-ascii?Q?bQSxcw/IC8goG9RCSMe6MAPMsQOnYQA73LlGPK0H+VzI9IwW1e5g+8XVKSsJ?=
 =?us-ascii?Q?6bXUTZ4NhjD3kpvR7g2HQ3xjSdPaa0iwtos/OQHI+Orb+8sDrf5wR43d0ag6?=
 =?us-ascii?Q?YzstIQQobrRRSuifjlCpaFnhRRyRW+CbV8xjC/FDGVKhjPr3hTgJtmZq3eHL?=
 =?us-ascii?Q?aH95a2jxE3EJceeBbo6wgTIYEcM/9F9JzLrJVdMFLm8MIC3eClBOZzUltl2B?=
 =?us-ascii?Q?7qxqM/mv+Zgnbxnmmia2u+sd2zykGYLDHDoBgYbU+5351Aj0uAzL/2C4GeBv?=
 =?us-ascii?Q?FifSAvYfBCZiQFzRSaxMBjCMKYVv6UFMGiEyjqffZP8edb78e69kp1YuxNqy?=
 =?us-ascii?Q?4zRMPy7ktleHrDYtdPW/Ssf4Y314iIn+g0bKs1r+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7cf30f-47e1-4803-d3c5-08dcb7faa1b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 22:37:06.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzwV7gcL63uv4Oqpcz226rxBf4JDCqsxibWM3K7zpACClWjfkjZNQgV8ZOjIvZxUM4AOYNAqlF70Fr7j0SGF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5172
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_153716_049363_71D917B5 
X-CRM114-Status: GOOD (  20.99  )
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

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Thursday, August 8, 2024 5:17 PM
> To: Eric Robinson <eric.robinson@psmnv.com>
> Cc: Daniel Wagner <dwagner@suse.de>; linux-nvme@lists.infradead.org
> Subject: Re: Disk Says It is Full But There's Nothing on It
>
> On Thu, Aug 08, 2024 at 07:28:11PM +0000, Eric Robinson wrote:
> > I thought we resolved it, but one of the three servers refuses to
> > change. It continues to show the drive capacity fully used. I noticed
> > that the drives have newer firmware than the other servers. The NVME
> > drives in the one that won't cooperate have FW 2.3.0, whereas the ones
> > that worked have FW 2.2.1, if that matters.
>
> You should talk to your vendor.
>

I reached out to them.

>
> You should know there are plenty of free email providers that don't appen=
d
> disclaimers that are fundamentally incompatible with public mailing lists=
.


We use Office 365. The disclaimer is a corporate level policy. I think most=
 organizations don't use disclaimers anymore, as they're not legally bindin=
g and they're basically white noise that the human eye typically skips righ=
t over. Maybe our compliance folks will change it if they get enough compla=
ints, but I think you're the second or third person to mention it since it =
was established in the late 90's or early 2000's.


> This is the last message I'll reply to if it has this disclaimer because =
I
> do not want access to any "confidential" emails.

Understood.

-Eric
Disclaimer : This email and any files transmitted with it are confidential =
and intended solely for intended recipients. If you are not the named addre=
ssee you should not disseminate, distribute, copy or alter this email. Any =
views or opinions presented in this email are solely those of the author an=
d might not represent those of Physician Select Management. Warning: Althou=
gh Physician Select Management has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibili=
ty for any loss or damage arising from the use of this email or attachments=
.


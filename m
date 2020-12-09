Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EDAC4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 15:21:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F9623AAC
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 15:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F9623AAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ai/0mgCPKHxsUZTDXuAw9qOv1zAcCBO4zyQtbs62aAg=; b=CnJjh6sQTHEN9VXkKGCbMmdGM
	CvXpPRw5kHcDM7tzPuuZuXpW22ntqDkvZn8sxMsAO8WfnUNbG7klxj2Hc3GZ60AV88l1p+L1qtHwi
	ScgtVERqFY91zPs6oottZYgaQ8NijCz/b7tKtuCD0Gtk45ca0Q3O/Ow6KVd9xGmKJLPeaRaLu0yHv
	Xou+KaRmHG9qznoY9ox3LBVqxALXUo76+vNslRA/kxHMak1XGqtIA4Nv4ybBwtIMaOMj5LZFS6IM6
	Iff0tC8EY3LP5VGVZzP9P7yENrPBWxNeBORbOr7bBAhfISR3jFqajD03fHb1RY4VOjBTlBc35lTei
	Mddn1Sqlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn1H6-0002fr-Pr; Wed, 09 Dec 2020 15:21:04 +0000
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com
 ([40.107.223.81] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn1H2-0002ep-Mj
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 15:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjMYfJKTvWYObR5y/A/VZKAG5YWooI5rZtj+s6X0OOoRL+Mkr50tT7+Hl/sCUtrK61BvO8SMn+WCfFodpExIKEvd/dLxt5Dd8E+gl5uUbD7T2DC/c+DOXfGDTydPC5EuH69GU1smNl0DtsBAgBoYxSB5AriUGIimYeKHK04fl5FZ42PeTT220Q3WaU/dvJa1aYTAzncXxE6uDIzzAMvjJJvdh2RrFLHSHfvuk0TUHJRjVJyU2x4dJ+8mJe6Q3VnKqMHDNzdTriS97ltE9WrtXK8RQNOkR6fDHhqCxxHmpvY0mSRKo1dc9XBc1RE6bH0XMLpthUZmNOUdxTOO4/K58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+4fIZU5hOWiBdIQAV7mxNcTkHMdUvr0tIJXnOT7UwI=;
 b=OXT94xV5+HtKuDKajnBU7cpClelyW6+2wKEA4OQowhMVokfsMpghL5eSMJHqbspG9Y2a9ukAZCAkjzvC81myNvtth8uWY+a29TviotwpQOrYMPOUADced7Ha77xyYO9wwZz1u62vxbLHppPotKst2FV7EWycTu5ZUiNHd6XSRc5vWA50viehKAdz73VZrdz4GK4m0lj/xsnFGMBwBLDvbsed+nbycfara4AoO3On6KZVT2k0+PaxBcjKv4dnr+oczcE5SWnhPZigNYRXTSsWldC5780+dnMNB5pF6jWUHJbwo82FpzoLfL8c7Ki28MTY7H5h9YdQeaZNGlKZlKAtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+4fIZU5hOWiBdIQAV7mxNcTkHMdUvr0tIJXnOT7UwI=;
 b=dAAin5xTHiyNsEPuiulRAiGZoMUd4qbJRaD4FaFnX2l+wO0EiwGlw4EznOvqkD5nQSBRZRTuR1EDrhUyW2dYJ0bjbN6yYiz0ZKZbRxrRZwP3OdcXibMVg413rOqeGNfVy7QpKQbocYWb9Nh1JHpc/vxK1oJg4g+0Mk7n+WiOfBG6WCrk8uMhskGIp8LNAJ7zrQdwSO4G94GIcI237rlt430AvJRXxgZPKqBfm2ipTNfnSZIPxDlN2Kkq3eC7x64cpcTpZcbCE2rY+VlwnhDPxMFZ9WTwgAD/MI2qah+i/CygFpND5S9t5IoFm+PSIguVzquHmiPzKSN4r6DN68W5SA==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM6PR06MB6444.namprd06.prod.outlook.com (2603:10b6:5:106::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 15:20:58 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 15:20:58 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgIABtGiAgAACP8CAAAzlAIAABdaQgAAv1gCAACeTIIAAetQAgACBg7A=
Date: Wed, 9 Dec 2020 15:20:57 +0000
Message-ID: <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
In-Reply-To: <20201209072806.GA10037@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5cd3:ab9b:a8f1:b122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e8fb41b-22b4-4fd7-77de-08d89c560785
x-ms-traffictypediagnostic: DM6PR06MB6444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB6444F78270BC9CDB77567C3BF1CC0@DM6PR06MB6444.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFT+U4SqzyonEyOBkOimRzhp2HKP7z+nXV/r5tehUtdPqHLSUACSIsA8kEp2sme+upziZsa1YTu6YTN2Av2aquSGlaLvXGxzNglGk+rMBtYksOzoZNdklZirmBhOQyL4lrWqg0EKMkLWNglQ5ZHfAScN5W4in6fo5SM6AIj6CBWWHE92+/s1jtH543pp4VteNrQSm1mwfnh4bwGJORjylSkEDAxhxhDHc4+EjawMjdoiUUKfqFrJrYdtFFyIGFk8hTosw+JE3qWMuZ/aYtLvoix/Kexe6bPNhBH0kRuQ9cSWKEKFhCq1CL4WY+hYQ31/57ikWNiqoyrDp5nh+4vi9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(55016002)(54906003)(186003)(64756008)(71200400001)(52536014)(5660300002)(76116006)(508600001)(33656002)(2906002)(7696005)(83380400001)(9686003)(8676002)(6506007)(53546011)(4326008)(15650500001)(66476007)(6916009)(66556008)(66946007)(8936002)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MGpXOZqpPB5fYZw+YsOOTfMkPEptmqaDQGS2LH1Mah5h1bXxPlfdCfiLAmN8?=
 =?us-ascii?Q?JDYIfRSphDNPqwUgiaOLM7aXD2ZQDXvO2K4MxvU+z+iqjqPlBePmMknnM9zM?=
 =?us-ascii?Q?738bPQKRl1xdqvHLNopiBni22gbbZBBcvd/yn+DXjmyCXEIKxC/a3qQFcTIg?=
 =?us-ascii?Q?M98ZKj1+17ZEW55AtzyXDb9bZhg+vYiYp9hZjP5Yu3mwBWAP9y34utJBl73C?=
 =?us-ascii?Q?UAoTIY45AbjsxaosJvWQjA1uhg63k6ISKU3NnZOCyjV2UnfbzZ+19YXOuJUd?=
 =?us-ascii?Q?45CREXIp8uHkpD2nbBMJVK+Ghv4IauCROB4qIe2TcT5FP6padf6KfMvlmEnX?=
 =?us-ascii?Q?3ottvASkunoPNDmUN6rco7E1ypzL1mFTKcoBNt6aK4aZ65Q9EduZDcNDVoEP?=
 =?us-ascii?Q?xOraKYcZSKmmmWLzbclx7P/GC5mDIv0HHGYpGRe77oQSH+sNj2xmWGBVr/M5?=
 =?us-ascii?Q?+DM7y9fhdTEvAw44+flbAkGsezE9bQlrUdkrOD/KPJTuI1t/JnjTJ/wJTUzl?=
 =?us-ascii?Q?xDyuKZeUkQOaKNmw8aNCBwPHBCI9kwsj/5hTH18UHW602iluJ2M1xiQRraEI?=
 =?us-ascii?Q?+rze/uJkusYU+RsR2j7EcfDylcunWorfH20VDtv7XSmkuc91PVDgxcbwm+1X?=
 =?us-ascii?Q?9a8QIN59r488VdT1lnExV5RcUaH2UKYKe325K+8BRzBJ2qabF/EwIT2ej/kZ?=
 =?us-ascii?Q?zSLBJhjuworRgd53Dp1drGhEQarKtFQ29xMiBDDxF6EWuPopWaymHGvBe/pD?=
 =?us-ascii?Q?Rn5nNC0Hbp+ZT9P41/vKbUZaNu+e6i8xg/FGgm4l594C08U53hhh7Ox5EqNz?=
 =?us-ascii?Q?2EsfkggsDlpCqty9ULJMYRxQ2qkXcIC4XHO2uWnXv2tWH3pUHz09hS9jonBt?=
 =?us-ascii?Q?p3ruZHzs0zb71dAUqRn4d71U+Ftz/4LvA91rAvvpCefVcAAXyIX5a0q1FdK4?=
 =?us-ascii?Q?eww7QNFQpaMN9f/75xA6SnQJ+7jcVxbyJu5bV0+GTc74VbQEtzMq6uPfYVIs?=
 =?us-ascii?Q?fOkmfH6bs0a1viF/4kKoN7DjyYjJRdcxFVasfjeFQiQ7/k4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8fb41b-22b4-4fd7-77de-08d89c560785
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 15:20:57.9363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beWOU+MbmPXicgfco6P8MxqL4VfuyOv3Gqvb9eInwK9L+A+JazNlAR865ps4eLkBzkRiVNurR3YL1ehimp4h9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6444
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_102101_913364_0C26952A 
X-CRM114-Status: GOOD (  12.26  )
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
 Keith Busch <kbusch@kernel.org>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Then I have no idea what you're asking.

Creating an ANA group does not change the ANA Log page, so there is NO AEN.

When a namespace is created (and contained in an ANA Group), the act of creating that namespace results in a change to the ANA Log page - therefore AEN.  BUT, the text you site specifically says, ONLY the Namespace Attribute Changed event is sent, and the ANA Log page change AEN shall not be sent when this happens.  This is what is described when either the ANA group already exists (and the new namespace is added to it), or when the ANA group does not exist, and the new ANA group along with the new namespace are both added to the ANA log page at the same time.

If you are not asking for an AEN when an ANA group is created, then what are you asking for?  Because I clearly don't understand your ask.

	Fred

-----Original Message-----
From: hch@lst.de <hch@lst.de> 
Sent: Wednesday, December 9, 2020 2:28 AM
To: Knight, Frederick <Frederick.Knight@netapp.com>
Cc: Keith Busch <kbusch@kernel.org>; hch@lst.de; Meneghini, John <John.Meneghini@netapp.com>; George, Martin <Martin.George@netapp.com>; linux-nvme@lists.infradead.org; sagi@grimberg.me; Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA group

NetApp Security WARNING: This is an external email. Do not click links or open attachments unless you recognize the sender and know the content is safe.




Fred, stop this bullshit now!  I'm sick and tired of you misrepresenting my opinion again and again despite me correcting you.  This is not a basis for productive work.

The only thing I requested is what is said in the document:

"A controller shall not send this event if:

  a) the change is due to the creation of a namespace (refer to section 5.20); or
  b) the change is due to the deletion of a namespace (refer to section 5.20),

as the Namespace Attribute Changed event is sent for these changes."

The Namespace Attribute Changed event has no way of notifying the host of a creation of new ANA group, so strangely interpreting that entirely different event to be part of the namespace creation does not make any sense whatsover.

Creating the group at the spec level is not due to creating a namespace.
That might be the interpretation of your management backend and is an ok implementation, but nothing in the spec implicitly creates groups as part of namespaces creation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

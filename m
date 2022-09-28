Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC2C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSf3ARJIJcYFCtGOtHGOx4PjC20ElTCKLBYRVBUD1RI=; b=yOUFW1dCN2dtD45eA2nYy1nm0y
	1cM0cyGsCxf7uvqIFeEyMu1/FN3Pas5DH6JWNR1Oq0CjHtPV672B/HF3B1H7zlJLGbdR7+pdZnCDF
	GN0vKyZ/j8P+tv/XTnpN84t6dK6gB5Q6gssFyu/220itwpIKhYHWJgKTrso5U8OKyulepmZUxrYdz
	Dvs85OBW0kMFAemqIvhZ/CJSl788+rM0crXZ2mqT9XA+DqHCTlq6v9Uevm/fZZHofLQ6oXEw6LPLH
	TLorf9PgcYdUPvn7EA/qPBrNl5qQDPNbBW8zBBpAY7LcxrhdYX0x4amMVBTxUDmdQSdTosC7j2ppj
	LBtuN8FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odZVe-00H31P-RF; Wed, 28 Sep 2022 16:02:06 +0000
Received: from mail-bn8nam04on2070.outbound.protection.outlook.com ([40.107.100.70] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odZVZ-00H2wF-TB
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 16:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/8OR1Vyhix0ocib4C8NFSLblgukiNzCD+8rg6wd87aksK20ch0FCrPcPioblFz/FCNl4DOF+i0DlbRIJtUVD3Y9OWpbMrnS9XRurwSkPyI+sanvSj7hRQID7n9gnhwaEvX1niK8K6KjlvSspBNnIfJ02vXqCDPNX/QKE54Xf63Ll2ZJR+u3pc3/WEwSaH9ppCfCbv6SsKV7GFTSSoXghhpw/XyIS6FVeoPxc0Kv+Ym8xFVYa3sClsM3udcgC/yrd5FcWTMKn+tJ/k8RWi1ZLkXmswSAGHfWBIUKqZ4vSM6GXAh2SE5Y+tDKamYtN8PR+Hh4J4+Bbqj+K17CgwnFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSf3ARJIJcYFCtGOtHGOx4PjC20ElTCKLBYRVBUD1RI=;
 b=YK1pgUZbipm4O55PzjlAGI8Bu9GdgFrOqdohzKeo59glWmJJz0+b3ogJqiQpYYlTONHSh1ZNDjTmKcjXAptLbilMmsfmU2xE9gFAE+ms83Ugc1ioVhqi0XMrNsLe5TQ0HF4spI4fjop1NyQm3FfEuXoBi4flvA0MQ/A7UN+MBHdp4XXZ/R5PgtSJqx4Tkc+HxplqNSHr/KFUqAo+dWDcLTr/irP38RcdmAzgIbiHhD0gWf7AtsQMyp58krF41K81m64ymgznQ4PLw8LxqA5jP1DRGKYHYTV7P8RLjPru3qbRErl3lPPQSSHSNbBPL+YH7HIBabPOrjIkRbBJKPDK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSf3ARJIJcYFCtGOtHGOx4PjC20ElTCKLBYRVBUD1RI=;
 b=SfmUDOkdzRPzf0pteYw/I5k/ARd7XzmpVEhU555QKt4GdsKjfKVH3D8hlDxajgYcl/aIZrXE8RggJa8FSSjFRd/CSN6fEZG10IHJ45UPKeBOWbh7YB65ESZ8ZPp6quDZ0AWyncHe+ufR7MV7k/MUwMhcn5z9k4ddlGDoH8ufWpm5c5rX/r1fW03SdrXaDHD7fO/rkGwYYeLjE7ffhbLzVngJGLTAAKDHHBgqFrgpjgUhwWjMLOMp7SlynEIRz/9RyJYG6Fq73nMnD/HZzdrL+sM3xSM0i+Qdm6OMEdKdOCr7w/FYBMmvamq4Rkp64qcJjF6iwZDrcTz6lppO1kKYLQ==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 DM5PR06MB2729.namprd06.prod.outlook.com (2603:10b6:3:3e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 16:01:55 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 16:01:55 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "hare@suse.de" <hare@suse.de>
Subject: RE: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Topic: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Index: AQHY0xkW0CvFgvGYC0OqpzqIUZQ+Z630t3BwgAAlBICAABc4QA==
Date: Wed, 28 Sep 2022 16:01:55 +0000
Message-ID:  <DM8PR06MB770480E2D341BB5497EE0AD7F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
In-Reply-To: <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.600.2
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR06MB7704:EE_|DM5PR06MB2729:EE_
x-ms-office365-filtering-correlation-id: 2f0ab25a-b4f2-4cc0-299f-08daa16ac3f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IOeiIjkE7HPPJtkbrOKJXXcE/rPFX4gY9S2B6EeuZhOWWtPSxp5Bu+tXEknp+6TyFTh1xK1CXlbF4l62e29ICGPQqdGrtTv+BscLRRXiwxxhoJXdSKSpRB1w7B5pOgWFjo0FA4WiTD8P8kTSTc4nLW9Fx465BjBDIuVgxlFiLh/g91Zhvz+J5vvfTKDpXHvH7GROGniRCKcbATMmUjyl9+pIQzBH/OTqxo4PCEjwvwgzgGz0qLK1Iei4xSW4ASis71hk7eVCQvp2IV2Y/EFVFprbD/zhjWof697n7tKRuI06ox2UaIwxWyFsUWrJDk2nz4lgCU9kpQyMsxde0SfNlQl5POEp4CkHOW/YLY9fyilLZwGCfSe95DD+AZfQ5G0QS2ynUjuS3zlXpx32eITnuI0+7RTAo63PNdYJY3/FeBQVpqDopN+a8OTWxY2NxevCs0kyHaN3LvVTbaad+2YbaVYU4Lz9CnYWN3ARnUV1izF9/k96++9ZOt5HGnKpvA4I6qloBsQRRoqLZiF7NUTL9B3v4JnETGI6iyYHpwGUFvw6vtLbkVlIRiXbcyKm7D+BTQZtG7Ypc6ctNYsSFrhr6hYlcmRNIVJwovkXIFIh6/J+9vtyCEDw5/ergV56jTXI+VXlouKhpCcxy0Mzik3fH1Fk5W78RnD5oKc7EkLm1OgQgrS89ye401esqCatWQJI565Ngl+hGWmBYOHpasXxzvJq6yKktBDOFYCA6T5a2ROs0XiaZU8wlMRr3a1501gK5wPNdyVgCCqI4TFo1c1g+w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR06MB7704.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(478600001)(5660300002)(8936002)(86362001)(316002)(53546011)(6506007)(7696005)(66476007)(8676002)(6916009)(186003)(26005)(52536014)(54906003)(55016003)(66946007)(76116006)(66446008)(38100700002)(64756008)(4326008)(66556008)(41300700001)(9686003)(2906002)(122000001)(71200400001)(38070700005)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?GeTfpJSBmVDHmuYWdHCZg8+cydk+XGdhKyMimKpXBGUqBZsvchurD9F8EzKQ?=
 =?us-ascii?Q?1d6oGTQIGib7qzGD0qj0LdmLpangtmDWXdZ/VmzAvmLvbDWbWRH5q7F1222L?=
 =?us-ascii?Q?tu5GvZamYk0VNizJ4yshH4Oed+04j9YZAbpVbwHFUKyhDOLaes+1rQt2pNbN?=
 =?us-ascii?Q?JYYnhd6ZNk/xfFZWtmRK9AIe41Y25nu7FtvaWsHU0PnjhLtllgIjttt4dOpT?=
 =?us-ascii?Q?FMTcaLGSDj16YAJwXYqrcVRQeM58c8jaFUzUCLW8HgZP8T6qJ0U6aSjhhu3Y?=
 =?us-ascii?Q?3SbSDkrrwwYxVKS+OCAAiemdkAm0t3MCidxPYXOzo37df84eBK0PtwuDiWC0?=
 =?us-ascii?Q?CxuNtcMZ4XLxGgukPKSmJw8oj3uXdYQ4crD4HZhoUbMrCr3bpZnqkyLH80PF?=
 =?us-ascii?Q?slCdRdLQGIh3naIgGeLdpIjUZ67JMDP+rFwD/65EFsPAOOvj8mPCX8fFOWGy?=
 =?us-ascii?Q?ha1sDGnUoT5wJDkFDEAUv0pChn6i28cvIkcEUr18Sw3TNWMvXT7lQFr6XN7m?=
 =?us-ascii?Q?6Tci2yqZ4RGH8/D7XEiFukc9utDunVsEh2drETJF/whhJRXtAZK5aNN3AXyz?=
 =?us-ascii?Q?+OHLy3qZwqbPXy5YHCz9soZOYfDRWyqIvB5Co09EBgB+AfvxuCukxayfLDoA?=
 =?us-ascii?Q?5W8kO7w+Y6YMSArWKpNDBTwvSKXAoypTYPC+hCneLfQeaxQOSa531fBqu5yu?=
 =?us-ascii?Q?UwRV4FR5N5d0pB16Hcq6EmtCO09epHdDkbupKhxGQ3lSspdfBVrJ5XZhoAMD?=
 =?us-ascii?Q?t63//+btGL5DUtVszC1sFla/oUlJLulrh7IENKxjYchJXSEHmsx2QMmeLLTI?=
 =?us-ascii?Q?/FphfnDnjJD7cK4TighyIzaXrfuL5PNZ5vkb3ICgdp7pzqsfL+3owO28872K?=
 =?us-ascii?Q?byQX8JrAucwePDX5DXGeHEqEmpGcKs2z9rIydg61/kTv7P0DA/ahD973/GK2?=
 =?us-ascii?Q?AAHotAvEg8085qVztfdL+rDpeIDPMgPm9VPm1ffhSud++VITbXJaeTJKN414?=
 =?us-ascii?Q?72fWeY/2QS+XSdShjwiLiP9V5wsWtFWz7JyrkxuZXPlKGj2kQ0xNWAbzPM79?=
 =?us-ascii?Q?RZGloqqUjsmYe070yPu8NKhgodHBigSGZf1akfRFVzSRip/KZDrJ1O7w4ZLm?=
 =?us-ascii?Q?HuKtYJVpdFvBc8On4+Dt6tixiSshQj0bNTO1P4pneR6CalfW3IoOfDXMfP70?=
 =?us-ascii?Q?HxBwQz8VvCKGPwxQzkF/cHFdIwoXyvMCYHksV3ZXG7zYohc77y9orPcqEB0Y?=
 =?us-ascii?Q?8To/RukT8K4Q2SxiwqRSEVoTB/tBxBmVNVEn3zIrlpwHK4pslhHvpHTvyZ29?=
 =?us-ascii?Q?9Jf0XUlvSV5T5hasZW61ko7BmSTHq1AimG8aOhiHqhcLeYPbTX8iRWI+uHRp?=
 =?us-ascii?Q?YqJLQ2v8FPER0Z5CRVoGJLUEs04j493NJ5xBv5PxB8tSVTKYo9dUhDOBnvL+?=
 =?us-ascii?Q?San+3QbTEJUSmfnpCpyFhas1fyTBOV8N4vKdUGLclKaXLUFTJw6r7jzVCiIR?=
 =?us-ascii?Q?0oUwqrbfhQj1uzdx5WHuzT/Pe5ZmlJM9oat+bzVTuMOUgSLIVX0JIIyQwChu?=
 =?us-ascii?Q?0LIdmpmjyeTWX22OR4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0ab25a-b4f2-4cc0-299f-08daa16ac3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 16:01:55.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNna9mDxBZuE9jwd/N8Qp58vscbP3aknway/113pLdWJYUXKrVaDSGi3amxGaPH0rMkhEPjZ6JjbaKci1BLdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2729
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_090203_077960_CD29368D 
X-CRM114-Status: GOOD (  45.81  )
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

> two targets (*)

Yes, that is what it would be called in SCSI (2 - SCSI Target Devices).  In=
 NVMe, that would more likely be 1 NVM Subsystem with 2 controllers (which =
could be on the same port - although that would not really be redundant; or=
 on different ports - which would be more likely).  There's also TP4034 wit=
h 2 NVM subsystems - but that is a completely different discussion.

There is an AEN for firmware updates - "Firmware Activation Starting", but =
that one requires just a "pause" in command processing, and not new connect=
ions (it is for a different use case than what you're talking about).

If you had static controllers, then the Discovery Controller would report t=
hose changes; so, if you had persistent connections to the discovery contro=
ller, you'd know when it went away and when it returned.

For dynamic controllers, it's a little harder (since they all get reported =
under the single ID of FFFFh), so there is no change when a dynamic control=
ler goes away and then comes back - on the same port).

If these controllers were on different ports, and the whole port goes away,=
 then the Discovery Controller should be reporting the changes - the remova=
l of a whole port and then the addition of a whole port.  But you'd still n=
eed a persistent connection to the Discovery Controller so it can send the =
AEN to notify the host about those changes.

I agree that adding some new feature just for a test case isn't really a go=
od idea.  For one, it doesn't really test what would happen in the real wor=
ld.

	Fred


> -----Original Message-----
> From: Daniel Wagner <dwagner@suse.de>
> Sent: Wednesday, September 28, 2022 9:51 AM
> To: Knight, Frederick <Frederick.Knight@netapp.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>; linux-nvme@lists.infradead.org;
> Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>; hare@suse.de
> Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue
> changes
>=20
> NetApp Security WARNING: This is an external email. Do not click links or
> open attachments unless you recognize the sender and know the content is
> safe.
>=20
>=20
>=20
>=20
> On Wed, Sep 28, 2022 at 12:39:44PM +0000, Knight, Frederick wrote:
> > Would this be a case for a new AEN - controller configuration changed?
> > I'm also wondering exactly what changed in the controller?  It can't
> > be the "Number of Queues" feature (that can't change - The controller
> > shall not change the value allocated between resets.).  Is it the MQES
> > field in the CAP property that changes (queue size)?
> >
> > We already have change reporting for: Namespace attribute, Predictable
> > Latency, LBA status, EG aggregate, Zone descriptor, Discovery Log,
> > Reservations. We've questioned whether we need a Controller Attribute
> > Changed.
> >
> > Would this be a case for an exception?  Does the DNR bit apply only to
> > commands sent on queues that already exist (i.e., NOT the connect
> > command since that command is actually creating the queue)?  FWIW - I
> > don't like exceptions.
> >
> > Can you elaborate on exactly what is changing?
>=20
> The background story is, that we have a setup with two targets (*) and th=
e
> host is connected two both of them (HA setup). Both server run the same
> software version. The host is told via Number of Queues (Feature Identifi=
er
> 07h) how many queues are supported (N queues).
>=20
> Now, a software upgrade is started which takes first one server offline,
> updates it and brings it online again. Then the same process with the sec=
ond
> server.
>=20
> In the meantime the host tries to reconnect. Eventually, the reconnect is
> successful but the Number of Queues (Feature Identifier 07h) has changed =
to
> a smaller value, e.g N-2 queues.
>=20
> My test case here is trying to replicated this scenario but just with one=
 target.
> Hence the problem how to notify the host that it should reconnect. As you
> mentioned this is not to supposed to change as long a connection is
> established.
>=20
> My understanding is that the current nvme target implementation in Linux
> doesn't really support this HA setup scenario hence my attempt to get it
> flying with one target. The DNR bit comes into play because I was toying
> with removing the subsystem from the port, changing the number of queues
> and re-adding the subsystem to the port.
>=20
> This resulted in any request posted from the host seeing the DNR bit. The
> second attempt here was to delete the controller to force a reconnect. I
> agree it's also not really the right thing to do.
>=20
> As far I can tell, what's is missing from a testing point of view is the =
ability to
> fail requests without the DNR bit set or the ability to tell the host to
> reconnect. Obviously, an AEN would be nice for this but I don't know if t=
his is
> reason enough to extend the spec.
>=20
> I can't really say if this is a real world scenario or just a result of t=
rying to cut
> corners. Anyway, I am glad to do the work if we can agree on how this tes=
t
> case could be implemented.
>=20
> Daniel
>=20
> (*) not sure how to call it properly, is this one target or two targets?


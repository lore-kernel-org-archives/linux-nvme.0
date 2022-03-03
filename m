Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B82C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsrjM5B5SIOhjzb0PrQT+Ur/WmIxfOwH0uEPuma3VcY=; b=wZzc2UVHw4HeKOcTNSg0jFuUUk
	Ch2T9wpUUs66K00IJxr0u3pa9jRDWRHgBMcsz+xJHaO35BT/DpN+H+VVF/2zys/m5n5xO7tgQdodX
	mK+b3UZwTAM7qYuOe1dKglVjFgUjXC9T+Q8wwSGgkIW8JZpfc4hL4dXpquo3OhOq2GNKpNbAyLWx8
	Rr4rnKvj7vXXTqvliNIfoR7LTMohH768kEGxo+/ZIc2QDMs2UoUfei1bilF3N9Kn2ZzCwgb7kubME
	6AFp7nDU7jrbah0d70lXxyLjnIT/Y8WHsc6vSr2hhFBhZuQG11Wb40OR8kUy6x9UNNciBakgs34zR
	Z/WV8sSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPjGU-0069sy-Vp; Thu, 03 Mar 2022 11:04:59 +0000
Received: from mail-bn8nam08on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::601]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPjGR-0069qj-8r
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 11:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC1SvstHEHPCP/qm9KB6Uxg8sPk/svqhIny/h1DcZlDqDeZ9wyL8+52kfwMxSiiZ+uA88rtKypG7AZiz5abZiUGFDWYru9/oaAIEmWYIzgTwv9uOHV1FufjwvV7vWmsX2F3mA26b1jsOJ6xL+I5mlkwB9+sK2+l2VtuKUHCrU36M3m4cLCoP1o1+9UjWwG04Uc5oNf6O6fcbbWNInd/gBKZTASOdLF5HeX0YT+bBQfskAoRr8ppnhUyFFBL69lDz5eIXIGrIhkrYnmci0oblTPv0ZCTdkaR0TNASaK5eQaDM5DupnqMCKGsx5k/2bPaCv6F7znDafFgvxP5m5JskPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsrjM5B5SIOhjzb0PrQT+Ur/WmIxfOwH0uEPuma3VcY=;
 b=CrWg9Y13bNRsPH4Fwk8y1xWbdSu4aRvso93WrVYTqoHXv7lDvq4l/0l5EkbT3XhwGe0juBMGHC1vmMl1K9RDj0bAtsTprUn31y+vtvjHKqvr8/aOHHOIzB/xeuTncPGtkK4yKHRE7Opb17Taj+cZ8eHEkoNWkgE8eeL7N/2SsES6QYkUHjqXtk8v6BJwQcrFu5DlkpBRQCo51PTtNEM2BlXYYhVQecGsdygk97hIITktIfHTNktX0WiiA9l9S45WyxlzGRptztWQXLzpTrpNF/uwkvzyrNRKtOXvLNJQfMLxvlpgrWS88V3sjteeld24h95FXjYLuzJp+OtbQmChzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsrjM5B5SIOhjzb0PrQT+Ur/WmIxfOwH0uEPuma3VcY=;
 b=Z7Wt1eeruhwwOtGBanVIg8Ph8x+vGchC2I5f+R4885fF3DIoTR8gl7bwhTZoTwHIT++iADm1B5naKlC0l2q40WNNv3qcVPibyUeI7pv8gzpcT1vM7Galdgs0iS4859SNzZjiwkqrQIbP1aL3/buPmyKu3BxmmSdu0Mzkhpcq2zdXHJe3hMElQSdDGTyOl8w7gnjFV/NPCcWpSVzEZDx0n6fPlet9/SUMdAfjdPFq4/dEq0VhDgUi+XBfb3xsJM9nu/ag1k5xRp8VZjvcL4ZlrQoHBtBihriT2PFsO6fS9KnoJk/YyrgDLBN1gb7gZD/wODMn67co+d7/vSpGQEGDDg==
Received: from CO1PR06MB8044.namprd06.prod.outlook.com (2603:10b6:303:e7::18)
 by BYAPR06MB5030.namprd06.prod.outlook.com (2603:10b6:a03:1a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 11:04:49 +0000
Received: from CO1PR06MB8044.namprd06.prod.outlook.com
 ([fe80::5d6d:7562:8b41:1db0]) by CO1PR06MB8044.namprd06.prod.outlook.com
 ([fe80::5d6d:7562:8b41:1db0%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 11:04:48 +0000
From: "Adurthi, Prashanth" <Prashanth.Adurthi@netapp.com>
To: Christoph Hellwig <hch@lst.de>
CC: Randy Jennings <randyj@purestorage.com>, Keith Busch <kbusch@kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Prabhath
 Sajeepa <psajeepa@purestorage.com>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg
 <sagi@grimberg.me>, Uday Shankar <ushankar@purestorage.com>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>
Subject: Re: Native multipath across multiple subsystem NQNs
Thread-Topic: Native multipath across multiple subsystem NQNs
Thread-Index: AQHYH5QvYPce0CnGB0ubOxl2ohyynqyPdfsAgAD4GoCAAkgVAIAQxFmAgAAKbgCABvVQAIADI5UA
Date: Thu, 3 Mar 2022 11:04:48 +0000
Message-ID: <8A95D51B-C843-4BA9-B64C-49C44759D750@netapp.com>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
 <20220214081252.GA18231@lst.de>
 <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
 <20220225005306.GA904231@dev-randyj2.dev.purestorage.com>
 <20220301110840.GA2005@lst.de>
In-Reply-To: <20220301110840.GA2005@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ede7c992-7d7b-42a2-17a8-08d9fd05a24f
x-ms-traffictypediagnostic: BYAPR06MB5030:EE_
x-microsoft-antispam-prvs: <BYAPR06MB5030D18A9C2CF4AFF7CFF35F99049@BYAPR06MB5030.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNSP2F4pCsaMBiMre21Mhl1v+AC2acGaAmabuacHf4y8kREsWMYoMchimXz2mE084m60PifREbszVkbaYDxvd54XI0xlUzyUHk/DOlrS13ckXNdJ3e0YuqRqEt+tgvP79CO7bN/Orq/69ZYz+O39+tyb0p3PLcCbkKAUP87Lrq3w2tg5LU5i6GTiHdZ8gZstk2s4yXBkQhQdS7NRNOBClaIyLCEumcsvgZ4s8B9XjH/7zhDJyXkD8CPvD7tvWwBrQZaBz5zyesLY6NQARfbjuxeFaYMkP84rzWtrX2ES5cAr6MbAinNfgZKBCjm96uKz/0pO/mMpLK85XGVPnDEYq0Plt0lbbFkRt4NaFaPXhws//JTkrpJAv/H3dDQyA18xKvrvFOt9SoGlGdoEcirPFAJjwGUKLq+N/i0lpZNieiIzpiIy/Mc+irQM7sBRNxrOm7dm0EcXHqZMlySilstH5COes0EDKtCO3aCh2J5Xr3QOF6Ac7UHbVrVZff9Fy8eaeJ8N/IMbXgY5YHCHzR1TubN+lX0+qGTh0uyXUx0BeZY/cO+WhRr+pnjRyQHC7KlsWl454nKfM08+TUeAGqIEm5VE/4C00f9liT2fUHJhQ+0Y8VziQfEIFxYGp6K2D9d8zHq6XhL9rMOj1ii+I6hRWG+83t54vq6MjO9hKJW+anNVOVq5rGuOGp6WQbmwZNqKtuqyOCSSmggAa1PjU8ZNk24Tuepk4NxhAsK5rwLl4vOFB/CoqITXFsWX0UncdFxd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR06MB8044.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(71200400001)(8936002)(66446008)(66476007)(66556008)(66946007)(64756008)(53546011)(6916009)(76116006)(91956017)(8676002)(6506007)(4326008)(186003)(36756003)(122000001)(33656002)(2616005)(26005)(6512007)(38100700002)(86362001)(83380400001)(2906002)(54906003)(107886003)(38070700005)(316002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KLFSgbdeTnmvlO5jNu7KTN4h5la9KGhyzfH6hqBTRCFJXsM3/+giY6F5ZITP?=
 =?us-ascii?Q?gw6xVsSAjKMOys3trnNsIC/JcO5Q6x6xgCUN4tg9jPIPCGCae5ZdIpyqTTwR?=
 =?us-ascii?Q?Jb+cfqTo3dkHxL2jlMWfrOY/fEqXAeM1edpojhHAh+t3KsnU1t5sfFaAGISK?=
 =?us-ascii?Q?ztTX8Os3vNrSsTgt04W6x1nmg38cveF3QrGfxZrT4UCtKrwhYBwZZNMXa6a/?=
 =?us-ascii?Q?+07kjxxiAhcXg8dU4Ccdz8RrZ13SAnYNGMXz/tzUklLCPeYY7bHk4Sld+d4a?=
 =?us-ascii?Q?SsXvD5lp9NfRCXY8f5Ou0TapOQ+X96An0WnjmqKWudoYBPtl1E3KpfFljhsb?=
 =?us-ascii?Q?Cb4oJC4dxePfxoDtZl892lHfi/s20xhfRPYEbz5NPM908EwEZk63PEYKK34o?=
 =?us-ascii?Q?v8tf9i7f2RBGGeoTSkxEavyh2CIDIFXH0bmTv0pd3ynsPLZbfGZdPPUIu4iO?=
 =?us-ascii?Q?mhOI3aKf1c81Rgx8Av5WCq+1S8w4AKyiPQIgM/lG7IT8QjI4E2K26HbHt2It?=
 =?us-ascii?Q?6T/w2TOH/W9vH2rWps+0f8/nr5HCu1SveFr8CkBbvPFBPxlxUVcnN3CGDWQD?=
 =?us-ascii?Q?rsytIPMTgRCNH+F/l1XAFw4CCPMf8Q6yqNvutmSln7dONN4+y41uUTgzHgAB?=
 =?us-ascii?Q?+DF9+OcPpqypU7e0eReCDQE6LJdRzJlgiCZ+9d8ySSApNksnwL1s5Fm2gJFb?=
 =?us-ascii?Q?a1UFvXpT1vi3nfW3ed/iO+D65bjaaQeFfjKa4pT9E5JhdG9czImC/rU/0lJ6?=
 =?us-ascii?Q?DJ2gAk0xtzElTHF9Tlxq9ISJ9tTW3oSTkah9PPaqjWdt7gHk69IKscdA7jt6?=
 =?us-ascii?Q?tSJCHN25AF5H1dfceLp72KlSzft5Y0O0p3e/kCdAjw42qWWmnCMD2QvTeeuI?=
 =?us-ascii?Q?qgUeFz3kvICQHE7I3ZGbrQWYkTTVTSP6CmqSZaZ19iKzR9omLhAF70vAjMpf?=
 =?us-ascii?Q?Uhwt1TXp7MfqaL8pqqBBih6B5gZJR1K0s6lshiodiAjaJnXHnTs3hDRfION3?=
 =?us-ascii?Q?51B515k7mvtislNPcWGjBS/HGY262e+pr4BAzVVd/bJe8M8DlLQF38afzJCU?=
 =?us-ascii?Q?TMKP8r5SRWogidznAADGYg9QRZOP1/5z6xEO2kajKApD3mpJHSDqVwKk7jrD?=
 =?us-ascii?Q?F9geFoOA4t+3zW3DrhDZAgzZI0wgMEyu/febFJ5UTnRMPIezBNcNmsC3e5lg?=
 =?us-ascii?Q?LJs6OfAM1g9aIBIlXnUPxd+ziKA+3HCxdzW//o4KslSvd+p5we7eQGqpCjW/?=
 =?us-ascii?Q?MHxedtFgQ6Yq1siJgZd58BfzlOBieofsxmxh56K0r5z9FwWtTKR4FNasZ1eQ?=
 =?us-ascii?Q?H0ngXHVIeFGoz/xTlT9+m554LI+yGUznITSv0ACZoffQxYllyZIVsOAnCZ3i?=
 =?us-ascii?Q?4hOrWmb1OLF13lSI/NJN8I8LLuONNg0v2dZbOWxfTJsmxF6K3EQwKz9AYWqx?=
 =?us-ascii?Q?PnH9LURmb+LKvXy4D5s3BKxg4RVRirTNIDLisH846QbSTXipdpdq+GxyBBrT?=
 =?us-ascii?Q?k48Qv8Ayd/Xn/xOIJMqy62u1NqI7MpSASoOHMwiHcUtunkRX8yYo7WwZX4h/?=
 =?us-ascii?Q?fmG/T7Ok7x2rULXQCVikbBn45KXeQRrARJ59fX+478MaEwBxO0lu+QRqvMyt?=
 =?us-ascii?Q?zNYf5gPhd4xNablVO1yKj2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D0DCAAA40A7044FAC4B7F31EBB267E6@namprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR06MB8044.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede7c992-7d7b-42a2-17a8-08d9fd05a24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 11:04:48.8142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dj+Rm861xtYEkvdX4Xgv3AKeIt8cCHrDdbqRy6S+Vzt30RNtCGLeqxGPNN+zAw+zT6EI/DZRMZC6foXwMF5B2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_030455_367122_5CCDCD1C 
X-CRM114-Status: GOOD (  17.03  )
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



> On 01-Mar-2022, at 4:38 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
>=20
>=20
> On Thu, Feb 24, 2022 at 05:53:06PM -0700, Randy Jennings wrote:
>> In addition to other considerations, migrating a namespace with hot data
>> from a different storage vendor array nondisruptive to client i/o would
>> be difficult to do without having a namespace exist under multiple NQNs.
>> One approach that has been used for SCSI is by multipathing to both
>> targets & a proxy mirroring writes; on cut-over, the other path
>> disconnects.  If the filehandle has to change, that is disruptive to the
>> client software.
>>=20
>> Unifying different storage arrays behind the same NQN/virtual subsystem
>> requires coordination of nvme ctrl_ids at least, and doing that between
>> different storage vendor arrays is unlikely.  Having a mechanism to
>> migrate between different JBOF devices non-disruptively would be helpful
>> regardless of the source/destination vendors.  Such devices will
>> probably not have the option of virtual subsystems.
>=20
> Yes, it does require coordination, so please coordinate.
>=20
>> In other words, even with implementing virtual subsystems, we still have
>> use for non-disruptively moving a namespace between subsystems.  How
>> will this usecase be supported on Linux?

Implementing the same subsystem NQN on multiple storage arrays imposes exce=
ssive
architecture/design costs on the target.  In addition to implementing
the same subsystem NQN, the target has to ensure that all components
that make up the virtual subsystem (across multiple arrays) have
the same inventory (same namespaces with matching NSIDs and ANA
groups). This needs to be kept consistent even when there are communication
failures between those components of the virtual subsystem.
The virtual subsystem would also be required to have the same host
access control settings and similar QoS settings etc on all of the
components that make up the virtual subsystem. This coordination, in
addition to what is required for controller IDs, is extremely complicated w=
hen both
the arrays belong to the same vendor and next to impossible, if in the futu=
re,
a multi-vendor solution is developed.=20

TP 4034 is designed to specifically address these migration/business contin=
uity solutions, while
minimizing all of that complexity in the target. So it's quite useful in th=
at aspect.

Can you please shed some light on why you consider TP 4034 retrograde? What=
 issues are you concerned about if Linux nvme were to handle namespaces sha=
red across subsystems?

Prashanth=


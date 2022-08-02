Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E0AC00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6sxxXrtq5HgFKwvPq7J02JNNKEdtMBZZsgEfxf2bW48=; b=iUbr1TFNFMqoFVEFYrQinfr16O
	R6mLGcgAfHYZD6SC1m+yEPKivN+w9LXeQWT8RvrEvbBFqWDFWZpCm3j2h78mpcUv2L6wojxUePZIk
	Oi5V/rI8IQrEOG3E4L2NZfG2FZ3ffjiUxbsuTOnWjsoFMOpZMmi686UqeoS+3+Tw8hZ29YVgmDow6
	gmdPvPSgCQSWQmJSWFblVvhlDBMk7+ul8WbUs/KB0CvCZedpHJTH2oORqvg8/1BA99SjYRB98ggsN
	VH1D37Mv6CcJKMZE73xzKZAVRsO5Xafq6Q362Iiw2vptpXAc7r+M+QpA7qYEyqU6Wa8PDlhoJeguH
	f5Yo7laQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIo4Y-00CJGb-C8; Tue, 02 Aug 2022 09:20:18 +0000
Received: from mail-db8eur05on2137.outbound.protection.outlook.com ([40.107.20.137] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIo4P-00CJAa-1e
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 09:20:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f94Z6fw+WF7VaqhWx/h93PPVJn27JwGPVm2r2MSMNra5JPhKvN9Z/oVnVUM1XT/Y0fBtD1P3q1gBsTQGFZK53gVK+cCrbtfbFMOQhZHOQzMRPHXHNm3wzgzRTWb4415SyfQaiBxbiGiRewfu3y+vl8ezY+531qMbix3iNvUpXENFxd5rBxL8JVhKjLp9QTl83qZxzGg0MqaEFX+9ghx3RHeDkBKR38SPbr6gPYBbF3Ao1XAdH9iLj1mCMwQdvGc7Qbj8WHPpFZeJBuB8n2P5HzoxP+dJlShuevtqLsP9F94VcyEZccRiOjSFxY5eQ7eNfPL1YJP73K1IgEo2dxEc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sxxXrtq5HgFKwvPq7J02JNNKEdtMBZZsgEfxf2bW48=;
 b=BdDqljbztG1gsAqlIsnSFie01i/OAKpPlbLsAFseRRu6C6+YtVa7Cb6EH4gEfBifn23juxLWgNUWQR5aiMRRmy8heRJnD4FhtjGt0hOjxbYJ7zj74/3+tRL5f5xXWUG18do5v0xpmWUixixv7UIoegMQge6tb+waSgiuehBX7FXYuS586Jy+9QgvcKi4j4VJc623/dTc0QjF292xr9pO28q7ojmfTVJ9ZwdDWYdgnqMhIHLbYx/ehvTALSN9O+/qf6ULv2XcwLHdCfYxErgNNPvyZIdVrlBNi7O1JxZM03zZ+0ntjFeoLWV/SufLmyzkk8szt6lSPhRYwHO3gGzJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sxxXrtq5HgFKwvPq7J02JNNKEdtMBZZsgEfxf2bW48=;
 b=Knzoc2KJOBc4mDwa6AVy3Pcx5fc4xnqXrCMtjIRhQ7+Fq3MxM6gQStRJPJ5tgwFCCOtK4v7ESrJ2K0UbBjujsPzWP35i6tsGjbJJO6+Ea8MuCn1ngv+NiDrqro4fXfoj2lc9QaI/m2SeEqc7+0nOLMkY6nYNeCj2NOrV8ZsKnxw=
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by AS8PR10MB5829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 09:20:03 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 09:20:03 +0000
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: NVMe write protection support
Thread-Topic: NVMe write protection support
Thread-Index: AQHYpYEbiU4zQ2Uo+E+2RUoaxlVOoK2aX6uAgADzx6o=
Date: Tue, 2 Aug 2022 09:20:02 +0000
Message-ID:  <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
References:  <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
In-Reply-To: <YugctzU0uDZvfAal@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9f5eeea-441e-4fad-9334-08da74682e5e
x-ms-traffictypediagnostic: AS8PR10MB5829:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pcfzYRJEHAgnj2C5QuAxqrxmBTCFypd4umUrhUu+SViVnKJC1wmyh7dyLc4mW+tb+JUF0DyVJ2BEzRUG282hZ57cIemPewAGfILntDPJz8bGowemOn27h1Fwn1rKNSOcylJgQEhYQnTySRGgSY+SdnlGmqmfD7QzMVy0c8IohvThkcP3yhC7GQ5QG3EeKMQIMuNuUqrOUsejmD7N+AmwFLRVVKcJy/FSspWx2wTK+6IKiAc1wcWjz33pVUF609Eg73rrF1qZBxsuh2F0eHdaIuzrimfkASXgdofu2LAVj5fbjLSIW7fZU1o4ECWZJg1p1uL0Pff1rTe+Jw1uE/ceVTdh34n085MucIijBAgCWLT3c6a23uK5bJdOJmU3fZRYNE2jhuODKZTzKc1yRw5/tbIXpfI0iWJTpvdCg6STZGwwTTnvqvcetYbcAvidwy5rmQq2k0/EV3n9ixiRclozNOXui+gs401yM98ZWRL17D7TE0TIczC6o4K1QjmlccVDNFgpluW7p7lv5hj2E3i/Epv6lp1eChlkw0SBNWnyQmCUDlG8N+RiubGFc5g1jfP26dQH+n3I1XVYEHZun03BlNIG6MeYoXhPm6rnzG5K42JujfSnRpITInZM8wtOl/cctDEUqfNXEcI1alSLrytVHOx3R2buq4xtyaMR8KR/iIVyb10UWzO3jF6kTQIbh+LT85EGFkw3r4Ho+c1SXjQ+mzJM+iOi/ffHzspqEJCE/HZf2ECb+gD9kEK60k+Wbmib5aA7Da0S6ZIXNLoyk4RMbjVjmFi11G6otT7mSaDaldpRfxsLLOrnV8RiTgPzrD9H
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(76116006)(186003)(38100700002)(6506007)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(91956017)(71200400001)(83380400001)(7696005)(66574015)(8676002)(26005)(9686003)(4326008)(6916009)(2906002)(478600001)(41300700001)(5660300002)(33656002)(55016003)(8936002)(38070700005)(3480700007)(52536014)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?KchZvYOvTTMoJ8dnIFfv65ygZ33m79NbCFcBJjzIrUqqPn93/UICEu27hW?=
 =?iso-8859-1?Q?Ft5rmny8l/+6qSivuD53HCLMiL8NCnYoakrZuJ1U2sZwIg2lJ9jzaOyBbG?=
 =?iso-8859-1?Q?ybC2s7WjC5eQYDb7jb/B/CxiD8EFXgDZec6auamr2Lf4I15bGt9k4ggWkd?=
 =?iso-8859-1?Q?g6dU7BqU48TVOLlho6IqlJYi/XXgtZ7wpjnWeYqi8ebJzALdqVYQJ/P18l?=
 =?iso-8859-1?Q?Jxmbg5nckki2asteq8tOOMTDMcDoGZGgfsl7a1bltZ0NIIq05f888DJsyq?=
 =?iso-8859-1?Q?VQZh7isJfsjVGy3z8XvQe0SCB62XVEYkDESb69z6FKJoSeNcbPEWHZjC+y?=
 =?iso-8859-1?Q?ZzEzyNYYPM3k9Qg/P3gr6nAh7OvYpn6a++G8XG7E5MJOj96dp9mmKClNhk?=
 =?iso-8859-1?Q?f9pgSThsL3m2gmbJVbvrlzOEokvIVPv6/uz5/KlRLFam9q/d597CzEZCBI?=
 =?iso-8859-1?Q?9XFj5aO/lpJmVI28wNeKAJSlJ7Fo0xB2a4mumr+cNKSewb+bjNxn8RtbyR?=
 =?iso-8859-1?Q?6QsxtH2A8Yibv/JKrdPLpV2aB2AlGqervwQNYYxDzcfKXQV4kPJUc2lYGl?=
 =?iso-8859-1?Q?MenWWrDr8kZfgPRNSn0FcIfC99jAiro4mf0G87+Bp57mQTgMzJBTN5/GlY?=
 =?iso-8859-1?Q?wOgsDkdzo7KkWJpqHWfz96SqDSTk8KAyp2wE4owRvVSjeNZiHGxGPibSLY?=
 =?iso-8859-1?Q?yrkl9RBlVM1XidTCOGtaDOX4q+d8uaHX24aLZv/VOm4gpf06Ax8keuHf/F?=
 =?iso-8859-1?Q?83F1HXHVksS30RS6SMltwQfw109A3ifmqM5wUuqJjl3Fn7tIB20RMSqd6D?=
 =?iso-8859-1?Q?LGaiAW9Rf+tT1ehYwQJg37MlOyYrbFA7EgAC4TA8SNa6HhAPNixX+jRhTu?=
 =?iso-8859-1?Q?TEd/1IFRCY1Pbk/pbZiPyFCqb2sQdfcYCPFyNDkI9W4/4Xcc3z16umN/aI?=
 =?iso-8859-1?Q?6aKi5bKkG1fsu6y1ECAx2pKMv8VOS3atSDsFmDYl4D9u8dsCIEMMaZ5XzU?=
 =?iso-8859-1?Q?s3RtVzxjhDGURZccIogiFo+MLxqr2Kn1U8ZSfdHFJZFvgSiJPngpXvDDHf?=
 =?iso-8859-1?Q?UUKOvlJ+yzqkxfJSWQcyKMtxcsJ+9MorXe3V6alhsFtOQhbKV8DBV6o0V4?=
 =?iso-8859-1?Q?qTBhFF1yoW8OAP0Ciz5VYQrvbGLkUD1zJBGDpbQ1yFwSoZUIIygZ/57abb?=
 =?iso-8859-1?Q?dTqV7R9k8BXHE7N99WUb/nD7+PH3hq6kHbuffH23Y2cdte+L7Bc+tjojAH?=
 =?iso-8859-1?Q?VsIg0DePfxmiesCqFWWdMUTGW1cL2YhBEfUVPF6+Kn8+OJKIR5I81/Anuw?=
 =?iso-8859-1?Q?4iZz61hzxaVjxp7SJ+ZEK5nxgpgApxoUlq6VFWLqvWlHJQEpErAeyvCBFI?=
 =?iso-8859-1?Q?V3T1wikZKiKs2/XNUs9vZ9/5EmEBoS/BsdTYTlp4aKHKHr0G+nf/8RaWOD?=
 =?iso-8859-1?Q?rwCtaT/YH8tmT3IxtZktom/KUb5bwYYeBU+Sj6KvfHk1G7aFA3Ff7ChZHo?=
 =?iso-8859-1?Q?LC9bQ4PtSjZ8yA1ObF2NEIqM3ru1KEDj0nCV0g0t7kdOxh3uj55RBHkatm?=
 =?iso-8859-1?Q?MzvWXhh0SXgzy9t9VPivjpjqkYaQ6i6cc/2LG0LPhmTGTS1xZV5tox5H6q?=
 =?iso-8859-1?Q?6wGFO+gmRhVq75e0NzWPO7210H9S8MHTCB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f5eeea-441e-4fad-9334-08da74682e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 09:20:02.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Y8uKWEVGhwBSSE4NkmdSxXUZKI4U+BThm1vd9fdD7ERkiELVVznDmqkpp5C8MA6pcdXJaBuM7jCCDE7Gbq37oPVPZrgZfpYPg8JH+9eGBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_022009_361584_1AF9F2CC 
X-CRM114-Status: GOOD (  14.42  )
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

Sorry Christoph, I'm completely newbie in NVMe and don't know what "Namespa=
ce Write Protection Config" means.=0A=
What I mean is that all the NVMe content seen by the user is write protecte=
d.=0A=
Our NVMe manufacturer partner has dedicated a pin of the module for global =
write protection. If the pin is high it is not possible to change even a si=
ngle byte of the data stored by the user in the NVMe storage.=0A=
But if we enable this protection and attempt a write (we should not), we ge=
t a "critical medium error" which seems a bit brutal for a disk that is sti=
ll valid but just write protected. So I would like to make sure the NVMe ma=
nufacturer has used the right method/status to report this write protection=
, and if possible get a less fatal error feedback.=0A=
Thanks =0A=
=0A=
> De : Christoph Hellwig <hch@infradead.org>=0A=
> Envoy=E9 : lundi 1 ao=FBt 2022 20:34=0A=
> =C0 : Gilles Buloz <Gilles.Buloz@kontron.com>=0A=
> Cc=A0: linux-nvme@lists.infradead.org <linux-nvme@lists.infradead.org>=0A=
> Objet : Re: NVMe write protection support =0A=
=A0> =0A=
> On Mon, Aug 01, 2022 at 08:36:12AM +0000, Gilles Buloz wrote:=0A=
> > Dear developers,=0A=
> > In case an NVMe module has a write protection feature,=0A=
> =0A=
> Do you mean the "Namespace Write Protection Config", Feature Identifier=
=0A=
> 84h?=A0 In that case you need to set bit 0 in the NSATTR field in the Ide=
ntify=0A=
> Namespace data structure(s) and the kernel will mark the namespace read o=
nly.=0A=
> =0A=
> If you mean something else, please clarify.=


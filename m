Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D28C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:24:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81CE22255
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81CE22255
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=skntD67XrEJa389U4Fomc0Fkw2CfL795ZVvFApjuiG8=; b=3QP8OLsmUZmJ+JTsWbtwucClT
	qRGZmEQauc8p9LGjkuarbyEcoYuViNg9JQwXyIP1qzyY9YStcqVHPudBbKHSqQOanG4Pp6uhAXvdU
	JpHrWdhfc37u2CaqTONGajUXB7ggH7GDcgjniXqv1usde5ggeFoVLOCYNuDN3rAu6EQMYbYtm+La4
	bvkD+eNsQUV49DVEfGF2PCNKa9dzN4eT74Z+OV5HasZu8HPE9v2nelH9w9lG+DQXtAnZJWX/5S8rx
	6x7mp5to5jFykjF/CuuiYdmnUuDzJL8ritzm2VBlRmepzFRWhxPXEEco8hiorWrGFW9BxO19XPTHF
	5k1RICChg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Usn-0008Cg-M2; Tue, 26 Jan 2021 20:24:13 +0000
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Usj-0008Bw-OD
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1611692648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xW8MtCox9GD9b+81qDicbEDgmgJfG7eGkM1uJ2m4msU=;
 b=Z9qY0zN9OWJ75l00wUC9oR7YTEOr1aDobWqhTRl6skOVA/KNYSUBiRQqSxruQF5fTK7TJq
 JwMzIoh33FpDzrji/oFp70tbS04UDRhLhEfCx7lgjVQ5O4EliGE2C2NnzJyYqvU2Ixb6BE
 6FVpPmlLuYs0CCho2kh2fWTat9AehlM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-h0cOR5qfOnmWuIl9MmDOBA-2; Tue, 26 Jan 2021 21:24:07 +0100
X-MC-Unique: h0cOR5qfOnmWuIl9MmDOBA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTjt8nriBMq/WRUPGcJX8bg0T2LwVzi643QFJasbdN9jHh7hax8xiEmdVLA3Koznhj1YMDjLU1tsCqjscsjzI2qBX0ADsbBSDVuK2ZTWwoUagiXYQ1FIHd11E+TyZfO4GUcEChOkdb7yvIC+gkyuByv5obADn0LSeL/dULUlZHl9hDGR01qH05VLQjWf+IOIS+4IGPMFAJTBJPeAkFntu7lEaA1RVCsus3JX83ncgoZNXlowdRH7lZJdJUlvnRnHckoavI6P/N/CA5Yvg+VfkUfsfvfdb08WsJFm6ILJpuhK5PUK34urVvxE9iRK2JmaV6YEakstCpfEhYuSBViI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW8MtCox9GD9b+81qDicbEDgmgJfG7eGkM1uJ2m4msU=;
 b=Nuh8sTEuDaR4ez9YtQdaRTrW0VDozN8fL7Rfqr5XrROatXJg0Ki8LiV/8ZaXmPOCdLBYM1Z6oiXZQq84IWARZUDvJeXf+lQ+puMv1fgIfxjK0a/HSJiYWB6G8xxzRbMU2qxCYATt539A5w05qOALSwuW9LAtYsdbMDPjTVuwAH8IGKmoiLMkARWidff6S7AMmCiZv7hzu/N1ueatHxVT2dDZI9zOHD6/FohS5pcO+H14Nn/vN/XQrIzFkP23BzsTkuFLOEJFTyhVgkXoAPlER9J10abBPBVDjFCQ+YAogiI3e7OsHHh5yuIoa/pQYNTHHas+wZd/wxdy3ylMU/I5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com (2603:10a6:10:103::20)
 by DB7PR04MB4475.eurprd04.prod.outlook.com (2603:10a6:5:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 20:24:04 +0000
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::c1ce:f675:7:30f6]) by DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::c1ce:f675:7:30f6%3]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 20:24:04 +0000
From: Martin Wilck <martin.wilck@suse.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "Chaitanya.Kulkarni@wdc.com"
 <Chaitanya.Kulkarni@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: RFC: nvme-cli: add "nvme monitor" subcommand
Thread-Topic: RFC: nvme-cli: add "nvme monitor" subcommand
Thread-Index: AQHW89gogC1mLvZpZEW/Svc7xIvEtao6Wq4A
Date: Tue, 26 Jan 2021 20:24:03 +0000
Message-ID: <efda478fa8c3eb79a3916a395c62be9671b6ff5d.camel@suse.com>
References: <79bd830da01238e1b36dd8e858e7cc29fcbf2876.camel@suse.com>
 <BYAPR04MB4965D8F1CCBC27D60B242B7486BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965D8F1CCBC27D60B242B7486BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
x-originating-ip: [84.58.19.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08211008-fec2-4ed7-11fb-08d8c2385352
x-ms-traffictypediagnostic: DB7PR04MB4475:
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB447532C2FE2B4D92461FA53CFCBC0@DB7PR04MB4475.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I407/h2ZKNWOexLOAcR3NNF5usGm18nxgtlOTO9nD0s8zjXK/1BV9H7A0Wq029lghEwNQniU1pZToa8INsu0ski7o4sRWLWECTWEw0Y49IP9T9wVkwySY01MOaxbe7niAJfFYqzlFW5kdVY2aHyt+s1rwyOQdAULZyRN+OOGrl+nkc/JT8juLrw22pz8mftZEPf1ckbNSBeQ0OWZ4i8ggMqkwrLZGA/NgYH03jBMXJFLlA3AoZA8bIeOkEJK8XM9B+6GSyWPTXRBTXS4jNFmcPanFn7tbp6QegYBTx8IB9DbrmiEJdNu20kxK2Ac+z6WwK5qHiWRFIqJlRrv8xl8QhNsFmLdow62lY6xfvhtLSYoJfZJ830gw9RIkctQE8/OVbhNa3zgRMoV4r8cTAlMcktz1m0TtQQEWxDrc5C77eSBrw9mo7zTK/r+bJJ50lgntd111DpM84IG/2/H+kmXw4t5cJGYF401Eve8vj0yW9W28q2cnYugUdj3IrF12XPN7XeWhkEUj4vcLOBTm8yiIPjTHnwz4X1ZK7LN8mk6MszjkaJ4G2carR0vqllWh5w0FnzjBPo4BMlqeIqVCFdZTnUR2KXWq7Lq9MTv+6PZL+I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB6555.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(966005)(316002)(44832011)(86362001)(54906003)(110136005)(53546011)(6486002)(6512007)(4744005)(2616005)(5660300002)(8936002)(91956017)(76116006)(66556008)(66476007)(66946007)(8676002)(71200400001)(478600001)(6506007)(4326008)(7416002)(2906002)(36756003)(186003)(66446008)(26005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-15?Q?QiQ3S57kL+BMgINYv3Nz/oHMFPdB/Z2wKm2oN+edDhzXugfDUnTDfQbvd?=
 =?iso-8859-15?Q?xEBX1qU7+3dZP0iAg7fWQN7WtcTi3WL0lHrI5fJQRlrfnbS5BHw2bbB8n?=
 =?iso-8859-15?Q?UCRDqW6tXxG3c4T+C0EPzOlKrYKHQsd+/pJrclbH1wuYt+d6WKriX35Wf?=
 =?iso-8859-15?Q?BDGTfZGzgEaRKuSU5iS8wi3iCHIQzhUPBrmbM7w94bR3SI++O7x6WemWP?=
 =?iso-8859-15?Q?Wqwonk4oqbPp/f21E8FboBtyOHYZfZPcl7wxshQTO30T+izCq3OfxAvlc?=
 =?iso-8859-15?Q?CgkJFSremf0Z3IcWqUPQ+awBuzZmJYS5nN2N2p/5ShwhVdlN4pDYRyTct?=
 =?iso-8859-15?Q?Q2xirN4OeTj1cMbUD2Dw6PDf1lDcOKQQ5tp8iag+sqWIETwr6Qsrw7Z3X?=
 =?iso-8859-15?Q?89/kL0MjGFPDhYmjjHsC9RFl45kyaXYZ8PwXeW+TEIhHNdRFmWXEWgiDS?=
 =?iso-8859-15?Q?x1uTUL9rqje4Thgze+BwlvKIjTlLlR/CFXU606D0vYVMGVaeRi7JWqaGB?=
 =?iso-8859-15?Q?T7mQL3dezaejzMNrMFsjvoh8PRIu812v+pijMWNE8nCvgB8/9ysQrKYWF?=
 =?iso-8859-15?Q?MwihMDAF3LK5q8Z064d1vPVOBL0NQvKoSumc8jXNZ+SfCp6ae/VZEuDji?=
 =?iso-8859-15?Q?PtGSdA89geem0srWH2rWHlxk2mxegjWx5wHwH73W2CTCuc8fy1GiGaYLS?=
 =?iso-8859-15?Q?40aGTb/vdHcU2VrRNFVVX1TFVnBxb/PYtuFO5lWKeRANVCnauD9CZHgRB?=
 =?iso-8859-15?Q?Ptl8+Fq+AE2c53SLkzHiZAbKq7FM2YbUMTvhPubnd2L4lVrt2PeZCHVWK?=
 =?iso-8859-15?Q?MzU7o6ms5rfcKlNNIxM9O7e9uXYqfhW1+UhfShE9R5L4yYMJFcR0osn++?=
 =?iso-8859-15?Q?V/NyBKcWf9cf7A1ZixORBv4D+s+3HSviTDOt0xQeWSy7ezagTkof9eiRT?=
 =?iso-8859-15?Q?nHeGWCpsunN1dYBEftb2rH+CghfzxTteKQkm4832DUXgsuIMXAXdyRJMP?=
 =?iso-8859-15?Q?1B0i595zh6xfCfp4pSTfMskpNc2lO5ietCBESIMohpLZwLSokG66CSweF?=
 =?iso-8859-15?Q?Pw7tVZNE8bbrhQO0oHyz/drWyk9xI7nL96wXcdZ8BPTibBujUJlECxN4D?=
 =?iso-8859-15?Q?OdpZJ?=
Content-ID: <783A5CE7197B0648866D5C649A0E763E@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08211008-fec2-4ed7-11fb-08d8c2385352
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 20:24:04.1491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gX9s2MkmrrbJWm1dQx+U6uiIBAfSw8bp5vgSQV7Dl4H97JFYu0YNiKmmssmOi+d6lTJoMO3PBLBiI+AYJBEZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4475
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_152410_009096_4C25B920 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "Steve.Schremmer@netapp.com" <Steve.Schremmer@netapp.com>,
 "marting@netapp.com" <marting@netapp.com>, "hch@lst.de" <hch@lst.de>,
 "Matias.Bjorling@wdc.com" <Matias.Bjorling@wdc.com>,
 "johnm@netapp.com" <johnm@netapp.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2021-01-26 at 19:23 +0000, Chaitanya Kulkarni wrote:
> On 1/26/21 3:48 AM, Martin Wilck wrote:
> > Currently it handles only AENs and NVME-FC uevents, but it can be
> > extended to other protocols in the future.
> > =

> > Following the "publish early" principle, I'm posting this here now.
> > My test results were positive so far.
> > =

> > I've created a github PR with all the details here, please have a
> > look:
> > =

> > https://github.com/linux-nvme/nvme-cli/pull/877
> > =

> > Issues with the CI came up after I submitted this, I'm working on
> > that.
> =

> I had this in mind for a while especially with AENs for ZNS and other
> device features.
> =

> Can you please create a patchset and post it on the mailing list ?
> also
> please CC me.

Will do. I won't CC everyone on from the cc list of this post though,
I don't want to spam people too much.

Thanks
Martin =



-- =

Dr. Martin Wilck <mwilck@suse.com>, Tel.=A0+49 (0)911 74053 2107
SUSE Software Solutions Germany GmbH
HRB 36809, AG N=FCrnberg GF: Felix Imend=F6rffer



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

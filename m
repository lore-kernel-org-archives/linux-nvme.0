Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F71C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 11:41:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3F5230FF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 11:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3F5230FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date:Subject:To:
	From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U90wWylgOrPK3DXO72lUlc2mEELqGsDfT+LBFfZQ22E=; b=V9PJ1tfbzITBtAQ5BQiHMSpjjr
	Wzs4m/RWrRvRn9pbohIYoOlaM8s39pbvDzcMAraATOsI5+Gi0L8pOwMDNd0lOTHnxD72H0B0vwPHZ
	00/DJi8GBDJeTscDLUm9PvBXLqR123C1tMpOGKpIG/XBw778uEokUada4O+GbhIaF0ZWsVN9MZUnA
	/8t15zYSUHomZz7PM/dR5aFBMzdTVzVzEfdlgaqH/3xJnhd5zy1TQgT7JrQMoiH6vK3iTPu8yGMAG
	LM+gA/dxzNc6gijY5YhAdcb7U+KBLX08V1Lmh07bjC24HfHpTkUtV/nWtBl13BqDoHv2gqHDKKodY
	egvSgpiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Mis-0007ax-W4; Tue, 26 Jan 2021 11:41:27 +0000
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Miq-0007a9-32
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 11:41:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1611661282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3q/1qQwGpVrWbzWHbqxylRPQUmA2XUHkvIwdvH98UCw=;
 b=hGfy0vknHSaRLcCDoCD3uFh1sIURJmneyQ+ERbnYh97E9ur9zvAoyyEvZWa83aCwh2HanD
 fdYjTeMj4xLRMzw7uSS0yp3wtBeRwsETWsFDJlpzSbTge2mnnXaw2fFF7FR5z3NiqadL/y
 xiSjPbHK6U+HUNyfC4iuVOTpXEkTNHI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-qqFPLQPzOJmTjmaBwBTZ3g-1; Tue, 26 Jan 2021 12:41:20 +0100
X-MC-Unique: qqFPLQPzOJmTjmaBwBTZ3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpeRADXIJIXNeZOlBQL2RnhSrq+GJioVxA2U3qwlq59tXzAM/Wx1GWSSJjYc4NwyohROvDYeymgZRnVPEgWSGaAXK0WgoLAb3mxsad/kMfEnkGxuivQbX7fVqWdnKM8vBKx+97ulnK2atyl7Fdx4Ew08CS91c5lHprZ/RyqFlVVs4GbczdY6i3/J/v1eiE8Z4+xjTmpxNOUzFhnwDmgXc7NOVoO4opqST5DvVEv08TE+L+/n3n5IaGgFEUtDfXF4nhCGziK4WUFr3/PF19O1M26fU1SVb84FDmhhpFIWCpN4fCU1hV3bh9Q6z4YPCq+N5CAkF276pd5w0lD8YEej/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q/1qQwGpVrWbzWHbqxylRPQUmA2XUHkvIwdvH98UCw=;
 b=ZwnpG36mVRJmeyykFBBV8NqxaB26BQkm1d1lpPSloNED1552KcC1C+nvj3fSYcOLgt9m+UaGeGtWDjHREeXDoSEDVkZrpeLzWQ8/l81YwREJ10zcygbi8FZ93FaXYVrJ1W8jK82txrAQRLBPyHiIJenZQYSQG86ns/Iwr7T2F4NXHc4/80S5OkVn37TYsNAZmtln3jGUF//XFSkjv6wBT0uF8Z5yhSy2HLsbI/AU2KoJxnawHqyhPkvRS/Wby6GrNTuizZrPFsZq0XfUZVFhg0MMKvCkcHjD870KmF2hMamG37Oyd1iIcLR8k6Ur7htD92oXd8fgQ+IoJ/R4fcB6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com (2603:10a6:10:103::20)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 11:41:17 +0000
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::c1ce:f675:7:30f6]) by DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::c1ce:f675:7:30f6%3]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 11:41:17 +0000
From: Martin Wilck <martin.wilck@suse.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RFC: nvme-cli: add "nvme monitor" subcommand
Thread-Topic: RFC: nvme-cli: add "nvme monitor" subcommand
Thread-Index: AQHW89gogC1mLvZpZEW/Svc7xIvEtQ==
Date: Tue, 26 Jan 2021 11:41:16 +0000
Message-ID: <79bd830da01238e1b36dd8e858e7cc29fcbf2876.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
x-originating-ip: [84.58.19.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32b62d7-7273-4526-9604-08d8c1ef4b36
x-ms-traffictypediagnostic: DB8PR04MB7163:
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB716303FD803771B6436629B6FCBC0@DB8PR04MB7163.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9rLIk7qJfdwv7ihbvWzMXQAykI9EjnCj+3G7BgGOUKA0avP68dSZrCgNGIxbyIIdqbFmrjkx7/YVaI8V2iBxT4a2WTj15j0DS5MZ14sB8W/sgY0F2jGtTx05dbsxYl8Jd0PixfUehYTKe9nRZRIQXdwcVdeyjF+CubRHgRu5Uso9SlaJoqnzV49adcd9yY11X8lkBXCeLk0a82bRM+rTAdadXS3qa7iIEv1NT1ml7ZdkDHF+WFCkVSBVF9N3hU6ZIpBJMHBqKNNMoO60fWy7Sx5CTQCQKA0zoCVH2EOYcL8T8Z+nK/HfMaliz+gPiQC1Koze4eYNLh+SkkmereFSTrf8hhQK4vd4IViIN6D82zDi+E8hrlLZQLQt1pTqDllZRu8PiGXm6hdHl/kzMRstJ1tuBloUxDRNTS7EylZj9pALBODCuE6piufr7FvLTqw01wQgittJPf2sJDlqbBGCAknVd5NKxEhjUQBou9/oO1M/Dx466lYRfEBVKsBQaOJf3n3iypyu2lb4bj46oHZmYPnb+rxNmMxstNqtXcP60G1/BefWOfyN8XRj9W6JPpjIE3K22zoQbrFxzu4ZMVcEca5wGaORR8U4js489V8uH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB6555.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(346002)(376002)(39850400004)(136003)(5660300002)(478600001)(44832011)(110136005)(2616005)(54906003)(64756008)(91956017)(36756003)(76116006)(66476007)(6486002)(66446008)(66556008)(8676002)(316002)(2906002)(4326008)(83380400001)(186003)(966005)(4744005)(6512007)(26005)(8936002)(6506007)(71200400001)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-15?Q?swVN40s1A0mr9ClGk1dOpYjRWLRZPO/rWeQTsETaosobH9AtTW0FgCDRp?=
 =?iso-8859-15?Q?GOmxSlHU2mHyfVAx7UzNP5/Q0W4ZlRAICb6CLFufDHwyTP2oWKiFz8NEO?=
 =?iso-8859-15?Q?SMvPAAEA5u6uYQRdqbcC0tSB+6mLjEmJ082lWUi06Oi2k7ymbAIyu2Ox/?=
 =?iso-8859-15?Q?EJD4JummOqv3zvtx5kmdQpxMCTK3QsPT/Erd+F2ECcrIPntLHo9kkLcvZ?=
 =?iso-8859-15?Q?1eeRfIAMdlhMiFz3QPKMd0qtca7EEliv3brNKBNCfZElCUDKCpKTLkeg5?=
 =?iso-8859-15?Q?FpFYXN8yzNi5c5BHGcmENhuOIWJKx5cDxJ7+bsm958qTLLF+/P+CR0D+K?=
 =?iso-8859-15?Q?yWkZLbFpIjGyYTUC1TrkH5T4nIYpAdul+LOWrYAh0TmrAIck/xqkxhkCC?=
 =?iso-8859-15?Q?+EsObRsh74nIlfsYj3hr5rNzxG2g6YUehlpP4xHlbXHMLS/iySRZ2o3eO?=
 =?iso-8859-15?Q?zarDbbe462iPZhmOf3dqk1tQUwNeuHpqQBJ7sw4Iy0CdfhmXM3joLQPrm?=
 =?iso-8859-15?Q?4NQLMKCIDzPRL2UvgwsZ6Y161ZZ7rCiLI7JK2TE7zFX412454vFO5On0Y?=
 =?iso-8859-15?Q?Jb+c0cDiTcWD3CskQU/6fIumlB+38EVQJTrdUaZTlE+AtdyNrcNwdf5tH?=
 =?iso-8859-15?Q?TO4JvjGv85+duggPVKoIYPD7n6owUVECk669V1OrE7jen2W2xTlfzRfZV?=
 =?iso-8859-15?Q?2vXpWA9ykR+MhC99KDfCOugX4unwZpT1WLf9PqplgpnkXD/N/srpMMVY/?=
 =?iso-8859-15?Q?pv5KC0ST901dDjTqb6DzXap4kkaVdcL5kalgj3Ak77iP9LouaRNe02huA?=
 =?iso-8859-15?Q?5CizAaNRnaqoLogGLbSDNQ/xLMR3VdxJa4szbI7Dsf904DpvJa6QKc/5G?=
 =?iso-8859-15?Q?E8Ui84+D5PguAdiU02IcHowXZlnGZhFBbmI/vCDkh3i+wSfwMrJck3/CP?=
 =?iso-8859-15?Q?gm+mNP5SYePgyUxcqqpVoYiLftP1YGAg2xFPc0HRufwuybwrThH+doGq1?=
 =?iso-8859-15?Q?3MvKP7O07cW5EJr63GHJj7Kx6pz8nNM9nzQVn1iOlX22t0PhV5oX5u8uB?=
 =?iso-8859-15?Q?899+vlQUgOiG78/+YhHvMaupjnyclAzplStQE0PZuA9W3h6qJkV80Dmvr?=
 =?iso-8859-15?Q?rk1gI?=
Content-ID: <904B842A226B8B4FA8CEEB9490084769@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32b62d7-7273-4526-9604-08d8c1ef4b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 11:41:16.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uFNGy2oFQJd4jXGwNq5SYxcJlo0s5/o3+bYBpCUkdAneiku+zhXlc3QrvBTomC1CyDDyBeJHDA2g1jljIpKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_064124_253245_7FFC54DF 
X-CRM114-Status: UNSURE (   7.13  )
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
Cc: Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "Steve.Schremmer@netapp.com" <Steve.Schremmer@netapp.com>,
 "marting@netapp.com" <marting@netapp.com>, "hch@lst.de" <hch@lst.de>,
 "johnm@netapp.com" <johnm@netapp.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dear all,

I've been working on a small daemon for monitoring and acting on =

NVMe discovery-related events. While pondering over various recent
issues, it occured to me that this might be useful:

Currently it handles only AENs and NVME-FC uevents, but it can be
extended to other protocols in the future.

Following the "publish early" principle, I'm posting this here now.
My test results were positive so far.

I've created a github PR with all the details here, please have a look:

https://github.com/linux-nvme/nvme-cli/pull/877

Issues with the CI came up after I submitted this, I'm working on that.

Feedback would be highly appreciated.

Regards,
Martin

-- =

Dr. Martin Wilck <mwilck@suse.com>, Tel.=A0+49 (0)911 74053 2107
SUSE Software Solutions Germany GmbH
HRB 36809, AG N=FCrnberg GF: Felix Imend=F6rffer



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

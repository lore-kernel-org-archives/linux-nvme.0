Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14A7C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fL/k9nJ3lB3rNS4RWnhe734AXw2cylixbdbC5NMh/lc=; b=eIy6YhjoWjXCOKvNNvHKb4Peca
	yMNPhq7CgLurEyy9Bm4tDwOF8fZTgV2wljqtlnFSUbxtTBamtJDrHYq2cezMKixZ6MdXddB8wP1te
	S7SSXNnatplbgily3uPambitikCyFLHAEgiSnwsveusqBCCYJX1zurCbNqbv0WOqp4AvbJVYFRK7b
	bBLZEbitkLRTj6oAQamJqlnU4C6OkXvsMqB1xvMy3PxtzwRcB9SHftGghCqjoJUnkpgXLttTmaDF/
	h4vTgEKonb4YlguQlwDMcD506LSVMkvxp42Zrdk26jQOjvTcboz5qMoyWpZymoD1nwS3mlfk6NN65
	v+A8p7uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRc9r-00FbKq-GG; Mon, 13 Feb 2023 16:58:27 +0000
Received: from mail-cusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c111::3] helo=DM5PR00CU002-vft-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRc9Z-00FbHg-6E
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 16:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6hCjEKm+dEH1h1UfYwuKnjSwwama003Hw0Ad3iQ4wMtjvgGszecuy0Bd7Q8fX9mDUHJwMnOyCmbG7YZ5KroCHqxBxHYUhSdL50lbXS+1cnNny+NIyTMIj4OOURMj29sMrNqOYRr+l7tEfkg0qYS6Xp7I8YMsMc9ssuhIJiCcUvJ/BOR6Kh8JwHyaNCsJVqCkdiLZtKbt98yfTPihWrzZfyrMrJMO4T3O0C94qD5mLQuAwkVXLhYMkZfQqEoXAcIO6NS3ZiVZ5sBd73D4i3/vLU7Ccr7c9Fc1vNdcI3Xhp/hDawjfLUDDchWfs18HSy6DlI3Fovy4GQSlP2VMAcH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL/k9nJ3lB3rNS4RWnhe734AXw2cylixbdbC5NMh/lc=;
 b=l4YFiovIAbsY9AoBfWnUF4JOu3v0P/162ioBg7T/sO/QN6jRJURafmkEaJEQVRwMM3pTmLkTT6bBT/OJh+NFL2YPJSrU7cFB1kLz1cN0xwa46vEzs1hGTaNbXQoa7sZFLvFHbNYvajQ7lTHDwD3aCWBiiIFpt8h1N0r16drVkMufwnUkrFa0foQ5aPEANJCn79nUAgfzv/l7la8iZdXj6pfYUjhB5VDL/Ahxs93agO+hixl3hiUQCfZllVFITbvTGG1KPnp6Bm4FKZ3XM9CZU3SCKfNJPQsfvFYL5rPweOAzbbkNLaaxsHrShAqnTEG2VV2mzMVZZR0hJ8f0EnaWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL/k9nJ3lB3rNS4RWnhe734AXw2cylixbdbC5NMh/lc=;
 b=Tin56VqbwLuCDnCWRNN9iCaxe9bhmhzYmWbazSLx/6nGCueTETZo89PhVsfaKJJJhvW02r7IwldF7/hKLkSjSNb0Ic4l8OvMTDtn8yfOLQ0ufkaxtsRuL7aNI2+fTA5Zj7SrXYKuD+RRx/ulORDHahhWkKC6GvsuRCUEoeL7nRo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ1PR21MB3528.namprd21.prod.outlook.com (2603:10b6:a03:454::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.2; Mon, 13 Feb
 2023 16:42:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6134.002; Mon, 13 Feb 2023
 16:42:31 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Daniel Gomez <dagmcr@gmail.com>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: max_hw_sectors error caused by recent NVMe driver commit
Thread-Topic: max_hw_sectors error caused by recent NVMe driver commit
Thread-Index: Adk91saIeniTqD2RReK/0l1vmobdkgAJdtIAAHJbWFA=
Date: Mon, 13 Feb 2023 16:42:31 +0000
Message-ID:  <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References:  <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
In-Reply-To:  <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=68f78d05-4791-4855-a7ef-41df4a28aba1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-13T16:13:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ1PR21MB3528:EE_
x-ms-office365-filtering-correlation-id: b8bdaf53-a91b-4b39-7765-08db0de14d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  h/Gm+4/NKIgREMqxq9eFvuyI6v+fi+/j6cC0FKuXcUQFfNNCLQVHpp4fCZ1XmIvZiKWeAVsO09VIXTT/a5JzF38pqiR8YbQAjahmN4a5qss0ihjrm8Cwvu0ZmAWyN/82Xj3oAlh1NxM7MuU+0yjbdaIecZLgXOxtf5+xUIfmnHZ/rN6x/clwMVDYibVfxR00g4iviZsedCyQLtPC7JWwBMG9Dn0lFLSarlqbicBRwytmgCyn3O/8/RrhtwlrpV6GQUwg05prZoHZuGh5qVH9MQ0eGCuvHHXS9l9//eo5TlKNrMmCm6Q+mZ62M/LsZWNiavs60h7Gj91wvRtq2LNq5JtoqB0YqiB1+bPDwmJtucd/8K40+No4HF+zhrEhksAolDWzlsLt2hn3cbfjtCiyDfmGbY2Pt0AMA/usZmskbrkQuyX61jS2cf2/ybcLVAwQKtexYIz3MCc/GqN65oQ9qCu8CKRTceY0+AmhJKn02qFqBzldRkk6MejdaWVUO15i9nv4As0HG4YQUg+a58KTwFhfGfaxxbX1fYk/9Ma0S9/N3R5kVE3ESqv/eQZiUDZee1feiD/vDj4kE9BzlHRT5f0Lc0seDaFpFoFb1TdbCjNaf2twNMv+rzcV3cDsQMohQy6+NoN2fp/M6qMip2gUSp/H+l7cMvNl67OE9TfGe1Poh8pS9DmX0cSFSCx5VgEL0GoOL25ZyuWhIZx6K8zoVkJXUXURLkhdc9fnGfdOQUbfzawOZoL5OlXGRftILFLz
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(4326008)(66556008)(64756008)(6916009)(66946007)(76116006)(66446008)(66476007)(186003)(38070700005)(55016003)(33656002)(38100700002)(82950400001)(86362001)(82960400001)(54906003)(122000001)(83380400001)(8676002)(7696005)(9686003)(53546011)(6506007)(71200400001)(10290500003)(316002)(478600001)(8990500004)(66899018)(52536014)(2906002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?oNALip82kXMm2Wbnqme75xrQVb59LOSYt6CT2wEFth8rN/2NAwkpETiGxCXU?=
 =?us-ascii?Q?MeK5cIRBpT31VeMK/xZw8a5Yw5OAWhGsqE5wythVWw5kq2RVXUM/EFxg33p+?=
 =?us-ascii?Q?PNqQfj6tM3Q05ldtWJbqjDFrGE5/oqznv8aI//hZG3LQrOS94jQK/wWOsnkE?=
 =?us-ascii?Q?830vD3IIQvg95jUHIrlATYQeTyE1okTgZytg3vettTtbAhSKMQmZFbXJKTpE?=
 =?us-ascii?Q?JsZr/R4XNGnJHgQHO30PoQnyh3F/kQ+IV2tH+L4vyeGzoSC/VepFvJDn10iF?=
 =?us-ascii?Q?4l/OeWu8qTTx2chGn9+Nqkzr7w9fdWb61L1q4A7hVCfFHEud22peExyr5m9c?=
 =?us-ascii?Q?/5MOQ33Lwy7tMG/LAl+amUmZqldenMajruLrQQijoaBrcT5ML+t58LSu0qJo?=
 =?us-ascii?Q?KVUE+SSB42afXlxWT+Sn0QZqv6xYs+ZvlPfy3n72uWc0KROc//xSrWGWXGb+?=
 =?us-ascii?Q?9wu2AwIJLUt9KAw5cHF7OJU8SMCPf96tcIhFMlYRWTQ2JT2yPS8nridw9+s+?=
 =?us-ascii?Q?qP5uoIaJgTk7IH7a6KiU6raAz9JSjtCinsKTQgalsvmMJejqQ5CyskvWubNI?=
 =?us-ascii?Q?H0xfJB7Iv597oV3EvXMpSBhB0dMwD3hbWEJiF85j7TvOfR2LVtJXSgpcBU5+?=
 =?us-ascii?Q?I4LUvctDHj/LxpLEAUHkkgvIyexSNvNUp28jp7F4WM2+h7defchzMmYrg1zJ?=
 =?us-ascii?Q?DdEUXqUq536wZLP2fg1NDTB4fNcko8wQk2yJlmx0+VMt3MNqY2ZovGplh5E4?=
 =?us-ascii?Q?CLo5SOqLeQp831dR+DLDD94gs0O54SYc3By6xIaeeg+nWDExEOuK0ntTZgfu?=
 =?us-ascii?Q?cCVE8Qij0A/yUa2+uuJEwSJWzqfNiZUjlbUrvC/Xk+ot9BDLx9w7DqGR+OP9?=
 =?us-ascii?Q?/1tOaJfB18+qi2khqWZL0dDhAkIYgVT/MIGinx1xomO3/A9xwsudxB0HiRlM?=
 =?us-ascii?Q?g+DKV4JOupXgcFGJUL03HyhH6z7Ma+Qyen6ruwFfQaLaQx34XGhAko0Yr2qY?=
 =?us-ascii?Q?FBCNBCq/uw6vB3NSciHoWIuFis6eUbvmCr0dSfWsIiWJ9aXba9xPvNDnLdUu?=
 =?us-ascii?Q?IkHKjFr3zX3OxEYdop9y7fGjPTe+WX+gL+6rm7Ll9VHZtLpkBu571neVMmE9?=
 =?us-ascii?Q?TRNYn2pg9el6gtHKViWC/GjAulLt/rE/SluwOGk/Q/SixtnpY1fx7S2amkn+?=
 =?us-ascii?Q?WeyPraly5yTm+tMgHqgQoy3jyzwQDiRNedr2zL3zFghfTXwH0j7MCQoZ3eTU?=
 =?us-ascii?Q?v/GTVXVTJm5zYuNOr/B/Lp3mwRmeVr8kGPwMAPkiBO/o9uZTzSLZjSlK8wD9?=
 =?us-ascii?Q?f5PBO1ASO6TdCu5Ce2AcRNpIkta97pRR2yDdR1KEKCTLas4EXwpots4NP0UX?=
 =?us-ascii?Q?+xGwKY8PGuF7nFDWi59wuu/IQAf8fizO8llZfeD4U/XOXEyDwcP1ejatVJQq?=
 =?us-ascii?Q?A/pE5lboYK/ep97VVwP9p425DZ0z+x4wBnDcQJXN76Ituv95944xxVlHRgke?=
 =?us-ascii?Q?MOz53mj0edUUEHz5WlUEOkFCn0xPtnKZ3Fm/tUogSNA9RTdx9elymxb1Bgik?=
 =?us-ascii?Q?o/OOkRWZRMiaobVPHMCBg5zELJbYzPxw9U0IL5vsZ7ph3mHctmEIZ1qhB39a?=
 =?us-ascii?Q?5CJQ6mLybQwihCD/eIYQ1S9NpgLVzf6G5MaJQ5+F3N/WF5RvH1cPCGj9FaVN?=
 =?us-ascii?Q?J6Ei8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bdaf53-a91b-4b39-7765-08db0de14d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 16:42:31.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPGgAu5W28B3Vg8iJednFTbmDXivUXvgN0AIHEODIzJIGqmUN5keMmy/jhtpTlr+MHw6Gy5SQ9XdBjLtcZioyWNlhrHpDLkiqzYo2NxRu2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3528
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_085811_068591_743E14DD 
X-CRM114-Status: GOOD (  31.97  )
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

From: Daniel Gomez <dagmcr@gmail.com> Sent: Saturday, February 11, 2023 1:3=
9 AM
>=20
> Hi all,
>=20
> On Sat, Feb 11, 2023 at 6:38 AM Michael Kelley (LINUX)
> <mikelley@microsoft.com> wrote:
> >
> > Commit 3f30a79c2e2c ("nvme-pci: set constant paramters in nvme_pci_allo=
c_ctrl")
> > appears to have introduced an error in how max_hw_sectors is calculated=
.  The
> > value of max_hw_sectors is based on dma_max_mapping_size(), which indir=
ectly
> > uses dma_addressing_limited() to decide if swiotlb_max_mapping_size() s=
hould
> > be used.
> >
> > In this commit, setting max_hw_sectors is moved to nvme_pci_alloc_dev()=
.
> > But dma_addressing_limited() depends on the dev->dma_mask, which hasn't
> > been set.  dma_addressing_limited() returns "true", and the swiotlb max=
 mapping
> > size is used, limiting NVMe transfers to 504 sectors (252 Kbytes).
> >
> > Prior to this commit, max_hw_sectors isn't set until after the call to
> > dma_set_mask_and_coherent() in nvme_pci_enable(), as called from
> > nvme_reset_work().   max_hw_sectors is correctly determined based on
> > values reported by the NVMe controller.
> >
> > I haven't provided a fix because I'm not that familiar with the overall=
 structure
> > of the code and the intent of the code reorganization.  I'm not sure if=
 setting
> > the DMA mask should be moved earlier, or setting max_hw_sectors should
> > be moved back to its original location.
>=20
> Yesterday, I ran into the same problem. Below you can find my test
> case. I'm trying to get familiar with the code, so any help would be
> much appreciated.
>=20
> I could reproduce it with a simple dd test [1] and btrace. In summary,
> multi-page bvec splits are performed in 4 steps/chunks of 63 segments
> (63 * 4K / 512 =3D 504 sectors) and 1 step of 8 segments (8 * 4K / 512 =
=3D
> 32 sectors). But I think it should be just 4 steps of 64 segments as
> that is the max_segments upper limit in my test case. Below you can
> find my test case and numbers:

The maximum size of a single I/O transfer is limited to the *smaller*
of two factors:  max_segments and max_sectors_kb.  In your example
below,  the limiting factor is max_sectors_kb.   But note that up to 64
segments *could* be needed for a 252 Kbyte transfer if the starting
memory address is in the middle of a 4 Kbyte page.  A segment is
needed for the partial page at the beginning and another segment
is needed for the partial page at the end.  Also, if the target physical
memory has chunks larger than 4 Kbytes that are contiguous, even
fewer than 63 segments would be needed because each segment
describes a *contiguous* physical memory area using its starting
address and length.  But the I/O transfer would still be limited to
252 Kbytes because of max_sectors_kb.

>=20
> Check:
> root@qemuarm64:/sys/block/nvme0n1/queue# grep -H . max_sectors_kb
> max_hw_sectors_kb max_segments max_segment_size optimal_io_size
> logical_block_size chunk_sectors
> max_sectors_kb:252
> max_hw_sectors_kb:252
> max_segments:64
> max_segment_size:4294967295
> optimal_io_size:512
> logical_block_size:512
> chunk_sectors:0
>=20
> dd test:
> dd iflag=3Ddirect if=3D/dev/nvme0n1 bs=3D1M of=3D/dev/null status=3Dprogr=
ess
>=20
> btrace snippet:
> 259,0    0    23476     1.111774467   751  Q  RS 1923072 + 2048 [dd]
> 259,0    0    23477     1.111774842   751  X  RS 1923072 / 1923576 [dd]
> 259,0    0    23478     1.111775342   751  G  RS 1923072 + 504 [dd]
> 259,0    0    23479     1.111775425   751  I  RS 1923072 + 504 [dd]
> 259,0    0    23480     1.111776133   751  X  RS 1923576 / 1924080 [dd]
> 259,0    0    23481     1.111776258   751  G  RS 1923576 + 504 [dd]
> 259,0    0    23482     1.111776300   751  I  RS 1923576 + 504 [dd]
> 259,0    0    23483     1.111776675   751  X  RS 1924080 / 1924584 [dd]
> 259,0    0    23484     1.111776967   751  G  RS 1924080 + 504 [dd]
> 259,0    0    23485     1.111777008   751  I  RS 1924080 + 504 [dd]
> 259,0    0    23486     1.111777383   751  X  RS 1924584 / 1925088 [dd]
> 259,0    0    23487     1.111777467   751  G  RS 1924584 + 504 [dd]
> 259,0    0    23488     1.111777550   751  I  RS 1924584 + 504 [dd]
> 259,0    0    23489     1.111777758   751  G  RS 1925088 + 32 [dd]
> 259,0    0    23490     1.111777800   751  I  RS 1925088 + 32 [dd]
> 259,0    0    23491     1.111779383    36  D  RS 1923072 + 504 [kworker/0=
:1H]
> 259,0    0    23492     1.111780092    36  D  RS 1923576 + 504 [kworker/0=
:1H]
> 259,0    0    23493     1.111780800    36  D  RS 1924080 + 504 [kworker/0=
:1H]
> 259,0    0    23494     1.111781425    36  D  RS 1924584 + 504 [kworker/0=
:1H]
> 259,0    0    23495     1.111781717    36  D  RS 1925088 + 32 [kworker/0:=
1H]
> 259,0    0    23496     1.112201967   749  C  RS 1923072 + 504 [0]
> 259,0    0    23497     1.112563925   749  C  RS 1923072 + 2048 [0]
> 259,0    0    23498     1.112564425   749  C  RS 1923072 + 2016 [0]
> 259,0    0    23499     1.112564800   749  C  RS 1923072 + 1512 [0]
> 259,0    0    23500     1.112758217   749  C  RS 1923072 + 1008 [0]
>=20
> In addition, going back to Michaels reference commit and running the
> test in the same setup, I got the following checks:
>=20
> max_sectors_kb:512
> max_hw_sectors_kb:512
> max_segments:127
> max_segment_size:4294967295
> optimal_io_size:512
> logical_block_size:512
>=20
> So, I'm not sure why my max_segments when from 64 -> 127 and,
> max_sectors_kb and max_hw_sectdors_kb from 252 -> 512. Perhaps my
> first assumption was wrong?

The bug I pointed out caused max_hw_sectors to be set incorrectly.  Going
back to the referenced commit reverted the bug, and allowed the correct
value to be set.  In your example, I would guess the value of 512 Kbytes ca=
me
from querying the NVMe device for its max transfer size. Ideally, to suppor=
t
512 Kbyte transfers, you would want 129 segments (to allow for starting in
the middle of a page as describe above).  But the value of max_segments
is limited by the NVME driver itself using the value of NVME_MAX_SEGS
defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to make
sure that the data structure containing the scatterlist fits in a single pa=
ge.
See nvme_pci_alloc_iod_mempool().

Hopefully this information helps ...

Michael



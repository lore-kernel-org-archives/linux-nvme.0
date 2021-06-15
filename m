Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8442C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:29:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8734F600EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8734F600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TvhFUkWZAMrQntvOTva6mfKy9jDU2LkDVL56NL5gLAA=; b=34qBTV9q2UjGyb
	jS0QNCN2bKPSoL7ZfjoWD0x5MX20HJ7yKn9v009y4+N/WErExkr2hbKnJYL9ecH+H2KMbytt+Y575
	iJ6dKay+p8B8ZQ8yfRMmkrQqWMBwOTbo6+TNBU70L4sp7p88G15Lbchzl0OLyjsbRFNgJWlDHDKRU
	JpEtwwEGNiEOQWzdOrPEJN1v9EkVzVw/zdMviPXAc4Fu3PgLp1CMc9NmbvGgJozaLQqnBkusbIIdN
	Dawe4Gyx5eAe5y8dMmhWL3T7UoCCoAKHbFKm/2j77PRzFo9W1r0eawOIqm/6vpWU5KIWidTP/74ua
	XM/wfs72/vQw6RxgTwlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltHYc-003ZDn-72; Tue, 15 Jun 2021 22:29:18 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltFIq-002f9r-Ik
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 20:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623787492; x=1655323492;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jIkq00Si36JB3swFa2KcDuhAGtr+6B65zyUUWTSMmJ4=;
 b=Y8z0M2KMmBAZ8ZQrRz5bkgb/UX/hQzx1qwahT1dIz4KgxxtL9Q4tFg3I
 CvYUT84+MSyMSGBc4p3fNsxcLSjbkL4WYZVNklTO0dKgZY5YETh/C1YuG
 E1MUjobMIe1YD5TrJotj4ft3D9PG8SL61Fq+fQ8jCD+wMDxn7sbWjXOyt
 8RE2tvF+TFTtUdnwShT2Ilmy0Na24WVGFQyU1fDt/8bu+QVF+2kGoRlVr
 XW/dkwmeJ3rb8X6rOG+GsS2aCN2STowNERQtzOmyN2SC6WOQNTwAxx3kk
 Zn2GSKHW/7Gxm/bwEhUVDiHpZsv8hON6/x3LmsF3ezcGSbHhcBzPfuVd9 A==;
IronPort-SDR: fvc1J1nA3k5I9TIqwVI7HU9bKk/nN+mI/GmFprei0x9nXhzzUP5NzIa+xS8qSF+JnHx7oofTdb
 E0QxWAvXC7bxMMtT66i+2yVm2EwEz8EpY/D+TbD5Xd7scaN1AOq4tuCB5LsmHN8xETFtr8M8rg
 evlYrdXjaAbrF/nmKHx2SAecqo+fD6supKSDLAbixMrbNuShsQ3qWcHCqwDLYYfrWKi3jtYqQ2
 b/A2qiH9laR74XnzT4bbNMpfeaWxdtseR5i1gMGTVeuMpSo6X2MxJYh6/RwT9ivcjWiI+6Vzq0
 ZTg=
X-IronPort-AV: E=Sophos;i="5.83,276,1616428800"; d="scan'208";a="283471773"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 04:04:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5JGc8QvpbxO/GkgP4HZs5lu6YQjyaEMvPU6CuMNKHAOauxU/N/qVjq8NF6H56RCrOaLunthweSFtok5FhpHYtofrzagHHr8QdsjY5yzzc/H5Idnl1bcn1dTiRLrGwR3LquuH844GxkKJj/t/FTl8INn9GbuL17pRbHPJHuU8FRG+Tm8rNMXdXzy+mIGjwEocqwnHrk+F5r2WOclRlHiztzgXPgJtwlOfNGy0NBRSMJh4cB4fRSU1k0AbTGyD0RuWmdRjLhES4sTtwayE0DAFYqjCTyr053JXUe9uORNXqRmGS9B7m3tojj9458x7nqzNnGWnhaUnZ+NSNyzSWnMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qCXFdgiDkpplqbLC7x0q11SSwk0jCmFwYT/f5EZPh4=;
 b=hn/YwYTpOpXukKRMfQ8WLe8ypmBqzOZi3CYHKbF8Zc5E8xS1wp7zt71tffiWBWF7AJNxn9RPjdzABJ4P5VIHt7qmwyG6lcBBaLsH61On60lVw8d3XebZtNA1Q9rBaZ0zp738bfD2QbXAdkP3VGxWBC9UvPkkdBU1d6d57o0t9zv6t5VVu1E75c0fsbID72wuorK/wooPv4lcmbF6JwVLUNX+Wci53qSZBYjbJhD2q6IVrQ0s/ZfR1sD8dThfzCIUoxYkRPzcmu8mZv8ZAF5CefRsdlNcgFJnD2iVTweR+QvrZgTyRNK9xawJvV5bxXiFldcyvWfueuC9+qkklRBbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qCXFdgiDkpplqbLC7x0q11SSwk0jCmFwYT/f5EZPh4=;
 b=wn2t3phA697LX+AIsXhmj6DwgbNx4Oq/3mo6Llz2Q0dCLox26uMjzJlzuaX3WRwAaMqbcvEUh47m2hEBz+d+Y78f4Fu8+EttIc8XZTT49+9a3U5vUh1xatL/1YzoY3c279CYt4Zky3Zvo1M6BiB2WN5h/+73ih0wVXIvx1zkApU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 20:04:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 20:04:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: kernel test robot <lkp@intel.com>
CC: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [linux-nvme:nvme-5.14 32/32] drivers/nvme/target/zns.c:257:6:
 warning: no previous prototype for 'nvmet_bdev_zone_zmgmt_recv_work'
Thread-Topic: [linux-nvme:nvme-5.14 32/32] drivers/nvme/target/zns.c:257:6:
 warning: no previous prototype for 'nvmet_bdev_zone_zmgmt_recv_work'
Thread-Index: AQHXYh8SqCUPRLDiy0qVELSMGfWOZg==
Date: Tue, 15 Jun 2021 20:04:45 +0000
Message-ID: <BYAPR04MB49655BF0B42EEEC3DC86FD4186309@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <202106160306.n1I35Kah-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd28bdfa-9f04-4634-e16d-08d93038d24a
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6101CDBA86904DAE0671F97686309@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xALsuyeKRJqqmsjGehMaSosCCRF8jZXIBGXu7QatdtIPIjOvRe/MtxSuVU43sMKTVazS5O29H1uNxkKUpGOVk6jQrW66C9SQ9uHytm1ZzN3ZOcw7Ki9oo9PVba1hCAsy2LhfTxmpdDr53tns0oMH48h/1ER+guZPGIER9b4JQr7vs8g5kJGRLkZkwNB73lRhb3jIIbp0k04TfvqVZJgDu4GWX4gfWgHx+/Jq3+2ntu4dJS4cKo1zpZavPWZfSwc1XTSguJUWzPufQZognXTdL7LSaztvNIsy37BrGXeSHvJc3HqLvSZ8gS4vIzi2zHsXsyEdqgDsdddfoXmrqPrFLbq1L8oEYoTGhpH1Xfir0nmfuTsdhbWleKyJisl5jdaVLL5h1Kf9TXcbuOz9+wCqUeodTwOz3SUgzMl4LZE90gkkRztja3cRNM1GqmxARzqLNIMFBes53W7Hunn9t8GEWmnSD7fXcBw1P8Fj4sq1r6OCXsEi66SfLssD2/3jc1xa1Jw9KfQntUQwiNP1v/6+l5NedWPxGE9dlPZ987q5LSU9tRNqlYmqoNH9sVoMPcy9GQi/xv89Nkq3DS3lsdtC7h02eFkXODePiLGqFUn059BtiQ9LPEX2aiD43HJdhAfaQ/On/tHwGc+UUEHA3qMaqqF/KfVoH5YkgfDaH8Vgl8rEfE5gmJd48ZLPRjVLRDw+oOpgvYOL7UAoqOcZQFkvN3hXi64gtIwsBBMKMMeQOsM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(2906002)(478600001)(38100700002)(4326008)(122000001)(966005)(83380400001)(71200400001)(33656002)(6916009)(7696005)(5660300002)(55016002)(54906003)(52536014)(186003)(6506007)(86362001)(26005)(316002)(76116006)(64756008)(66446008)(8676002)(8936002)(66476007)(66556008)(9686003)(66946007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7nyMuHLEhcNXnytik6cs1kg1zDwgpAK9zwMwayzDNC9er2BHwoSnsT9mHwV8?=
 =?us-ascii?Q?gBJL+24/U3rsTwGnt6CmbZH/F/0yxtFViXCoGgUKHETjX6G3WL03NOL9wFKQ?=
 =?us-ascii?Q?n0KFaScfMrIi+B82VY/ipKW+QlmzQdAw/Fk4Qd2OTA1nf2F6cRJ5LoNF8NQh?=
 =?us-ascii?Q?jitZyWBIwwDfN9zPCjqGH4v2f/QvNdGtBCCT0ctTR8LhHLePUF7ThlZ8blH3?=
 =?us-ascii?Q?ddZoGaP+3SU/QDdYJc59IF/0EY2wdtNBfza6YwyEGRZQvDo67AZ9i0RBk7Zp?=
 =?us-ascii?Q?d/m+2OluhRTnm/sCcRCPOSfcdrbnUz7QS1Xlinzye2g1SCH+SM9HVXhIFLTZ?=
 =?us-ascii?Q?4lR/O4UKYrLVzz9emomQNYUMLrze0eV0di+QAHZ68WqQ0CPzKVkNWLB2nfr8?=
 =?us-ascii?Q?/cDi4jk4outKukw2F+sDOeuPHTBNYpoSyvkBpc+F8BiplMavXQrbHVvbptA0?=
 =?us-ascii?Q?rdh3AfxLz1Jwvek8AXVSLES0mpC5gdthv5yVvlkd6Az8pjXJoaIs3E0oaVhn?=
 =?us-ascii?Q?lXmxcgIrjtDCj4oaw4zkW8FvQ6IghAAXvFq3hQkVmbFdU4+datato1h7Gi7r?=
 =?us-ascii?Q?t6lkL8FlsvUY9n2ubSbyey78fpNiu0sRvHcVpT5R2Y0NUyRew1wwpGFtEdPw?=
 =?us-ascii?Q?Pxq+NbyEb5CoiOzL9b2y12UM+ktkGsxE1nwZSIyADmJ7rY3g1j7EmwpliILB?=
 =?us-ascii?Q?uwnBFiCO/MsAaYPkx7kBsjJmt5lMWEU8qkSQMmXfZq6iyEC7qENvHsjY20eq?=
 =?us-ascii?Q?JUtgdyoBVpYf3qO+0n/QdtrNwdM65RiBF2fnuitptd4KH6lSZudm65cnwAtg?=
 =?us-ascii?Q?ItWjGyglE9AlrJ29PjACyUNaL2wvi9t7FHEbGK5WoxoYGQWfnV6T6lkVtIku?=
 =?us-ascii?Q?LFbG/SSc7f9ses3U/DHyqDvTdZnaOx0D4DpLTeA4qqHesdSfq9yR8pGW0afE?=
 =?us-ascii?Q?EvcLpRnoYuef6WI7147mn3hRx4LlLkiaqxXrfTiYNBJ4Xwu24QhSotTLQj8H?=
 =?us-ascii?Q?Z7WafkivzdzsHJ0WCWa1Y4HWrdlSpzsWm7Fca9Wf3gCsmOXbyjkFGmfD26nM?=
 =?us-ascii?Q?J41xbmURTfq4JxN5yBdaVjh8aA3EpyXXkJe9mjM4Jvx+v4J45qd1OghCykFO?=
 =?us-ascii?Q?wqxhc8HUNLmUOV1Riy9fVqiFDC/CIqoNapBQSvRzQeSijHZX7mqxpHfsIXU/?=
 =?us-ascii?Q?d7eB6ksVjnIgVzRIbWB5T9QpMEXOO33e2sbQJQWqmmBcUI13k7qqRFWGNBmz?=
 =?us-ascii?Q?G91XQyaQjFHMVXSjOuZ0u2ZAbWh9000nd++OUCtU78AD7ujm3HvYCeE98ynk?=
 =?us-ascii?Q?gQJiho7wCmK6i6SBzfp4Gp8z?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd28bdfa-9f04-4634-e16d-08d93038d24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 20:04:45.3070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztO7VNSKazRJuWxppTI6+hGTqJxUjhUlveHK2RL0H6yox8LW0NNFiaG0W9UFGcxDp/wMgZ7L/iRcf8Whzk6Dw98mkgkd7I35nzPgXK00zk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_130452_766399_9325B6AD 
X-CRM114-Status: GOOD (  17.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/15/21 12:46, kernel test robot wrote:
> tree:   git://git.infradead.org/nvme.git nvme-5.14
> head:   9653e01d9c3c46930da3f007a39a2aaf230bd8ff
> commit: 9653e01d9c3c46930da3f007a39a2aaf230bd8ff [32/32] nvmet: add ZBD over ZNS backend support
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add linux-nvme git://git.infradead.org/nvme.git
>         git fetch --no-tags linux-nvme nvme-5.14
>         git checkout 9653e01d9c3c46930da3f007a39a2aaf230bd8ff
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/nvme/target/zns.c:257:6: warning: no previous prototype for 'nvmet_bdev_zone_zmgmt_recv_work' [-Wmissing-prototypes]
>      257 | void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/nvmet_bdev_zone_zmgmt_recv_work +257 drivers/nvme/target/zns.c
>
>    256	
>  > 257	void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
>    258	{
>    259		struct nvmet_req *req = container_of(w, struct nvmet_req, z.zmgmt_work);
>    260		sector_t start_sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>    261		unsigned long req_slba_nr_zones = nvmet_req_nr_zones_from_slba(req);
>    262		u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>    263		__le64 nr_zones;
>    264		u16 status;
>    265		int ret;
>    266		struct nvmet_report_zone_data rz_data = {
>    267			.out_nr_zones = get_nr_zones_from_buf(req, out_bufsize),
>    268			/* leave the place for report zone header */
>    269			.out_buf_offset = sizeof(struct nvme_zone_report),
>    270			.zrasf = req->cmd->zmr.zrasf,
>    271			.nr_zones = 0,
>    272			.req = req,
>    273		};
>    274	
>    275		status = nvmet_bdev_validate_zone_mgmt_recv(req);
>    276		if (status)
>    277			goto out;
>    278	
>    279		if (!req_slba_nr_zones) {
>    280			status = NVME_SC_SUCCESS;
>    281			goto out;
>    282		}
>    283	
>    284		ret = blkdev_report_zones(req->ns->bdev, start_sect, req_slba_nr_zones,
>    285					 nvmet_bdev_report_zone_cb, &rz_data);
>    286		if (ret < 0) {
>    287			status = NVME_SC_INTERNAL;
>    288			goto out;
>    289		}
>    290	
>    291		/*
>    292		 * When partial bit is set nr_zones must indicate the number of zone
>    293		 * descriptors actually transferred.
>    294		 */
>    295		if (req->cmd->zmr.pr)
>    296			rz_data.nr_zones = min(rz_data.nr_zones, rz_data.out_nr_zones);
>    297	
>    298		nr_zones = cpu_to_le64(rz_data.nr_zones);
>    299		status = nvmet_copy_to_sgl(req, 0, &nr_zones, sizeof(nr_zones));
>    300	
>    301	out:
>    302		nvmet_req_complete(req, status);
>    303	}
>    304	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

I don't understand why does this need a prototype ?

The function nvmet_bdev_zone_zmgmt_recv_work() is defined  (line 257)
before it was used (line 307).

Will try and reproduce this on latest 5.14.





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007CBC4361A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 02:43:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D134207D1
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 02:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D134207D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=DgtF+nmxr9T8jzSNC76tabEhX0eUjrKil9HGUoVrkGk=; b=FFOi5FCRzvBXC36Rme5zT2liE
	8LFYJoaBzi5Rb1/VV+Na+5lYjWQFjoCpkVbxH3oebzRo/VSeAFcYngn78+QQFgdSsjueaY2b83hV0
	PpHGcfvwQB9KPtZosVEg1PteI07POKSOS5kxOZfcKNdlxqpwjHSnRo2ifvBsbYqdV4embrcSWdzS8
	Aw1K3eYyXaBDTMYdEoSWDnF2ApKkfIW7gEqjKX/Js/YEYeN64kdsy9+Pb08A/vE1Ev+cTUyWa1xuq
	WfoZgSMLMs0bzXanLotHz7ZIC0ZgN+bztK7ufrNMUEIiD/k5ApU82F25ijj/mhKaT+UqQ5audwCWl
	xQrluFGxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl142-0000DD-Li; Fri, 04 Dec 2020 02:43:18 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl140-0000Ca-2Y
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 02:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607050405; x=1638586405;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OM2O/xqlDO4FewvNyyI47+EvwQ/TQjlCS8rAKXKJ3fA=;
 b=LhUmzgRSWaPjMPgg89ul1zRHpAoRfEcpTw3SE4uFjlOD/2Jo5FMh6sCt
 i+eRitTOGF2stRoHLI20JO/wfUASvs4FFN9ryzhlhft6IkFPzgueVz3W/
 01XABPqM3TJEd8Nm48rHwkDisB0abGyJEomRKI4DI9WJGmibFEdIiVxw+
 /B8FXhO6lIdToauru2PwIcrF8Jxg1raJpZYaEZ+1pHW2gltDtTt42mjGt
 TI9bZzBDNMJLOZ/6QHQGqtXKsDEMeqy/+cKUFF5D0EpWFxRHexTT0tdFU
 4SgryePoy3ghH48ndn0XQ8nDkbBiIzIsKYscoP7XQUoT9H0aXv8pUkOYC Q==;
IronPort-SDR: A19BdNE7DAurWhOT5TMJVm1KMWvbyK7iP7zQeTZHsJBnM/h7Gf7HOlYK21QSOcgKSFi7g4sESw
 7fqQEpTCr56RTdA8IqdVXq4bdPvRPAj3kgfqiCiaNImK+5qEQXYTIDkS37vK5p/ar8lSm8XfW0
 VnfmcnlSZc6Bw6qhaTCFBKR0W3+syCVwfp3CFS32yI1HYNC/13GPOgQuU8Xy4AFVo3Pep3gZjX
 170AWYgPaRmmTE1E/HeY8Ps80vEVrRolPV/VI4qsTsvqW7iiUaLmCCVYSsiSmBPmON1TNkzGqW
 mek=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; d="scan'208";a="258105484"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 10:53:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqKMT4gxWNQV5HPJNhLuIQojck1nEpawd7T05zGsNjH3pHUZBQARJUFbcl8arHpE1xS0XbDQbcN1iv6JGcVpqJq1mgOgaRvHJ0Vzrrja4cchsRBZsG8F7XUHhB5nybJlpkm3h+wsHqb/0qQRMK8Rk/kAddzZQHG7ADS/tnGolCAtlHcwGIqyFXh8q2pz7OIJOKZG7K2yizybGNukfa9GPeK4M5kXyLimC3V02Ilx0NV6RNvDcFzknAnxQlWTQuDYb+iGSYpQWZS/iCRpXRSq6t0NShwQX/31LEjUse9Oi8b229WT55TsiVi2l509xkES9PlRVRqzpBZ23iQurR9b0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK+byWHLh/P8GAQH4JeyquAsAFRjF7tjWhArQ11ncgY=;
 b=gqm2837SEveWIeGyep1DqvdZsRzBJgelRp2DjFOA24rxFv+4KBYAc+Ax151RI3U86ZH07G5q0D8tFHkepz2pOxTAYjZR8yy7tbdbEAir5s5YQSITIKGHr7UdHlnfQnjF3bCUtSB1BYPqpe/J+ymyn8HmczYDUoao1CxJ4XOj0wNR28Yl6s0+4HxWDxBXW6f8C27pwr5WCX2paTnnseN5pXkLqrgjnk54cwvFrSxuX0AjquRVekyawaZ5udI+ESoulnhWWoOe+9oa5ilZ8US7JDV/IOO83ZiQ3b9i/Uu9AejRYXb31VJTXGPbBc19ho8DUEKzvdkIbZyMKdqUxUJ4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK+byWHLh/P8GAQH4JeyquAsAFRjF7tjWhArQ11ncgY=;
 b=Sm+7vEoePgsdMWwPZh9JrhGdq0eiskRfqpKLHdJSe49T+zWL66sAVQyicuKwt02XMvnSyBB/GqRHzloRiKyGMkgUjDrp4ysGadeleXgeU0QnrQOxbb45z0ZGYJaFKu/eJdm1fEi7hfHpnJx3GBSKfvAoouWsrLlJdoQL7Yhiu2c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6551.namprd04.prod.outlook.com (2603:10b6:a03:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 02:43:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 02:43:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V4 1/9] block: allow bvec for zone append get pages
Thread-Topic: [PATCH V4 1/9] block: allow bvec for zone append get pages
Thread-Index: AQHWyHOTB5aCxb7qpk6uVxnjLQJS6g==
Date: Fri, 4 Dec 2020 02:43:10 +0000
Message-ID: <BYAPR04MB49652F70D16357D420E616AE86F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
 <20201202085531.GA2050258@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67c4246a-dd27-47b0-1903-08d897fe56a5
x-ms-traffictypediagnostic: BY5PR04MB6551:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6551C94C4F9D1C15EFE8555986F10@BY5PR04MB6551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M95TvxEU/2KQzhk14u1GUzIskNJ2gCWkT/wAfN1GmeBSDQqMrdewtFZwzihWHqUgPZJHZvqPAFlzsyl8SP67HZ65X8p2mMRafBov5klZSy89cfO+TglNqc4h6k16LN35Juu72RqMWdjb0aBGHqH/xAAZIEAvb9GbTkD9aJib3bxw8RcOuAsYO4b7wMCFGXITf7LWhk+Pi2txJ9RDPQuaLtwaBXBJ3iAS+/0BBsGZcZwbMNwi9XnTgdLjelDVXIkscE93HnO6GhoJagc4wgvqosQ62qHWtp3L3sajJVKASxATSKlDAY3a+VSr2f1uiAVL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(4326008)(186003)(33656002)(5660300002)(26005)(9686003)(66946007)(8676002)(6506007)(4744005)(53546011)(64756008)(66476007)(76116006)(66446008)(66556008)(316002)(86362001)(71200400001)(52536014)(8936002)(7696005)(55016002)(2906002)(6916009)(54906003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PDkDwUGlxyFsfvlbG6rpUy2tNVGNBg00Gq+rJSHqm0loQ6F+utVy48cXd5pK?=
 =?us-ascii?Q?YROKQaS6vH1E19byzFggwBLjid05x2w4HnIlz3jVV5rWqQ3LIkE8EuVw+nuO?=
 =?us-ascii?Q?AZE0RoceC36oLCeoDBRSY3/Y3QplbQtVYka81zJ5WAxWn7rhBORtqbtoLmfP?=
 =?us-ascii?Q?NvAD/8Bws7FtnUXfCW1fIZ5U6Y/TO/SsxxvE3bsva070czabSDV3HHiTOUDY?=
 =?us-ascii?Q?A26suwpLxr9GGGiD8kjsqA7aW4S6Gaj8K7qO6fcJoOWeIBrIZGm49fG6hd1i?=
 =?us-ascii?Q?Rqa+Jy5r8JAQfgsgNm/gP1AJ+/O1fKv33z5oVGxGAnjaF1jcmNEugiOhOc9Y?=
 =?us-ascii?Q?M7DWw4J0VIt6bryzjKATk+7nbt8JyJ26aAwwkZ/BMQQqouy45/HKW1i7FMHs?=
 =?us-ascii?Q?WAFENZ917gyjPtpfyGoH3aU+WaeAGWSlYvmJkZNcbLYGz7P1gRQV2POeS1g1?=
 =?us-ascii?Q?rKHtgVOtpVIjKO6dErpAEBeuZgykovxB8MPIsw6tcT7LZhhCAZMJ1AZR1rCH?=
 =?us-ascii?Q?pcRpi2VSM/tMvlBlZZz49ADzIxK7eNluMlBrP2bxTkn+pBmYtr4BZPdeeMA2?=
 =?us-ascii?Q?axDq4s2jbPsbriKXRKCS9ShRtjhZdoHPzjtJq6P0FooUWE3U/+g+zM2QcUbw?=
 =?us-ascii?Q?EhWcrAtyycRcLSis3w3fPfsnMMe0v3PG5JxKC375gr8cEIGppZDgGNH5ExQL?=
 =?us-ascii?Q?zLWwMWoKtulriYJuI7tgtR1XTt7+X1BkQAqWzEoccYAsDeCVscYZK+TXfBDB?=
 =?us-ascii?Q?jj09m0FoU9PkAmfdJMbUM6wdTajjax0Tmv2rTl1a7QyDFwTWPAye18ehNw5n?=
 =?us-ascii?Q?usr+zL4IW7FE7lg3KsxPO9r1Hbuuu6V44nx+cEKSBLgdwm1uBqmamFsJoW6S?=
 =?us-ascii?Q?oZ2Nd1zzFMKk13koVpkRg02cp5v8Zo2zmsTsFuA3U14dOuDsWRfYFzWEuSNI?=
 =?us-ascii?Q?BXq/kGJc2KObad6RgxnwUTydCo1n/4L0yJdyXkVu1dvrDH2apIFSSdgwEW3C?=
 =?us-ascii?Q?O2PG?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c4246a-dd27-47b0-1903-08d897fe56a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 02:43:10.2603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6y+NSQM/fTScFJEN3unCGe2OayzuKz3gtfU1gErkiImwawHTmcEBMkltpHmKK0zHd5VdSSBaqrmR21e5djtTpS+AggluWhG1SSKesh9M0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_214316_336016_243A1731 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/20 00:55, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 10:22:19PM -0800, Chaitanya Kulkarni wrote:
>> Remove the bvec check in the bio_iov_iter_get_pages() for
>> REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
>> bvec.
> We should do the same optimization for bvec pages that the normal path
> does.  That being said using bio_iov_iter_get_pages in nvmet does not
> 	make any sense to me whatsover.
>
Are you referring to the inline bvec ? then yes, I'll add it in next
version.

I did not understand bio_iov_iter_get_pages() comment though.

Reimplementing the bio loop over sg with the use of bio_add_hw_page() seems

repetition of the code which we already have in bio_iov_iter_get_pages().


Can you please explain why bio_iov_iter_get_pages() not the right way ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

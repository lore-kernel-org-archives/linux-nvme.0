Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1377ECDB482
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xx5abRXd+cHhJfiEOMqSInbzXujqpketmV01oW0QIg=; b=Mk9To+f6o6vqiSsjMpMhgwzDOu
	ZnC7k60qizLSKHXn3f67HTI7yizSBFJC3to/nNslhdGihuem07Wm5qzaEiadsKrkXyahlYstowXc9
	q2C2F1te+CViwjCy9VYkNUjBCigK3emwS97mbbu+xSvYWmZDOha3inFPpJ2EialB/6r2SOMC/IjSB
	oSG1fb8zXnS0YaZYGYX6rIMeXxpZu5QHf4Oiy+pyWt7++P7rbnKGY0kFy9PgKJPyjPbklgUybQe7I
	vCNZb+jAne4iUh9WCsxlokNQEZwHAZahxeYEpPo0j+evB3OWf6Kne+ttxWrHEqvEITpAZmLSwaDvC
	zX/Gj4Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtNbj-00GcND-1A;
	Thu, 19 Oct 2023 07:38:15 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtNbg-00GcLk-0x
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 07:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697701092; x=1729237092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nx+ZkrGMwfIPkx4unFuFGiSKoQ9kej/nfX6B8RZb8Dg=;
  b=DDdV0v2Dtzps9/OPhn07C40jV5rbqHsUEdm4zccdrcHhT3+9S8+G5tO9
   UI5GODTRcShqYVvxV4E0dCl2QG3yEAM8cIbKRVSPRQ5H8LgwUrPXqt6gR
   hE/7DBG294D5FWo/tRhwKW9kHYpgOirWyKTz6EoBkFkM3LM9PDhSKJ8Tn
   xmnhc2EkFd5L6wmpkOQVzl6/teY5YJhY6cV9+wdJIt6Ny7WER7y9TnRKB
   wdBvk4f/tfsXov/0BEbBm82yS3+Whetga/NN0z6ZJVZLbDcX2WDondJvy
   XZ0dKUjQ5WBbqKSTqYTyo2hVqeDvCtMG4ARW54I1JWNRUo8+IRLD3MvtX
   w==;
X-CSE-ConnectionGUID: iN4B8CJISKK6Iu2UCbruWA==
X-CSE-MsgGUID: f3eCPw3PRTCZ8Iqolz3Upw==
X-IronPort-AV: E=Sophos;i="6.03,236,1694707200"; 
   d="scan'208";a="100426"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2023 15:38:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss8H38VeL43JiERBSJ0mx9io4p9JZVoO7QiMo5n+TAPrtuSNLCYOJvK0Mje4MB5Yid/SISrp+yQ0U9rWJvVl1/GRVUN+MnFLf8ntS+s6UlIyOe54r9C/jMSxjvK/OP6AsLJFafChGh2i/iya4BWZbKI9Ss1nAfRxwb3Ko7YvBoC5YGFNgh3fxQAkNwk6bKdjlVQCikuX4JGklvOPB9sWOLD1eS5E8CdS1TribjwJP2B7HjjDX6HBlpPPOykBK//it67DsOMPotMQoppIZVpVcTyTQm0TPHcj3wNqYqGKMu207IeZM8pks+75prDF4H5hjumTjUSW2pVrgYUsqoDkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xx5abRXd+cHhJfiEOMqSInbzXujqpketmV01oW0QIg=;
 b=ZbXLISQvVLDHfskbuuB8DGbBrkB+xLi0/oFV3YqCe6YzddRnCdbBhkMpB+w9LgH2rtFnVxUe7bmVioWAnTU8HOOOtLDtvgfEFNnjP4QK456rBH/m1/eXbm23sadVPz3zEsEgzTqOM8jXXc0CwXbtb8VEUOXh6Q5xB8z5ID0EIsnq6bzZvgCht9QBviK0tNxvJlZDpgVZFoglUN9HcNI2t1ZDbvPM4GTq97St0A5hkKb8/MTE6P4Ruswagc2rM4gejU0o/xOopkaaruaH03hmv6rI81Gpeuhr8BOLkHIu/g5TdE1baDWhLDOxnfqXBIK/HU4SSMrczt6yw/lO0Mf77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xx5abRXd+cHhJfiEOMqSInbzXujqpketmV01oW0QIg=;
 b=YAg+JIBzl/3+MB5L+El0Hwq1wT3D7nfk1OyY4XYyl/UfpmlniVW4yYgZyxTrjVV+LMXqrV0xtitUrTTAZF3n9eXWtIJjTyliJyuOXfoOEui5C9M9aIXP+WGMucKUADJfRmztdGhTN0quQN12HSWSveuBBmK833ORsTf67RhJZXA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA2PR04MB7660.namprd04.prod.outlook.com (2603:10b6:806:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.20; Thu, 19 Oct
 2023 07:38:03 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 07:38:03 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "joshiiitr@gmail.com" <joshiiitr@gmail.com>, Anuj
 Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] nvme: fix error-handling for io_uring nvme-passthrough
Thread-Topic: [PATCH v2] nvme: fix error-handling for io_uring
 nvme-passthrough
Thread-Index: AQHaAfmmTNQEDdTHWUqGg0NQ8DySNrBQum0A
Date: Thu, 19 Oct 2023 07:38:03 +0000
Message-ID: <ZTDc2n/RaiQeZUuV@x1-carbon>
References: <CGME20231018193056epcas5p404b1fb38d3e9037862703690336d2d10@epcas5p4.samsung.com>
 <20231018192430.43606-1-joshi.k@samsung.com>
In-Reply-To: <20231018192430.43606-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA2PR04MB7660:EE_
x-ms-office365-filtering-correlation-id: 50693af0-c855-4739-f210-08dbd07653c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VXs02UDjGnMFC2auMEMO9mMRpRvcfDevwLCRkOj0vAOSi6DEluUFcuamSE8k6GekcbuNMC9pE6LRU9Wp15NT4FtqJ6TCPZ4dMRE1sj7IZey35kk5ZjQ2dDpl9Dch4SwA0e/pZ6eYIsxChzBrQOQQ20DHgrVZCm34CPk0Al2cXrz2QPDC5cEvU4DwY6WUI6S4hjzjBopdV8Qji1qDRDWKlnyCBklT0hq5vIaZ7rgidmAfzfdObqkSsncd6slTkr9jZA1oR3tf8lbrxWuiMNNDn54ptNBkz8/wQpFVoY5+WqhI/rNqt4+/v0Y88BNXcNYh8/ndTBtfzvmIscxCzQj2nDTV28SHHNMee1h5adu9lVIB4Oq78ez/p+RGYAnpSfY4YuMDL+IvmtEk1wNZjg1mOOFOsaSVVOv4fm3gga+675yt/Rug+QCnYg+QyrlgFlOGYu0RM/dCtBemc4X/jfhmAfgSTVxS+bxTVott6SxSOvFF+3tfePhAbfqcinKi/EmjK0/QKV8uv0/hmL/jz+emkX0QRxLanyoFc8w6jX/68sWTjHDNNDeIUQKTw6eW9GEMCidGLUWyVm+y0mMxTA3jw45nwXm7/SSxvVBwtBDz2U15lmyRUk5gswlfjdtogMtg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(2906002)(66446008)(8936002)(41300700001)(66946007)(54906003)(76116006)(91956017)(4326008)(8676002)(6916009)(5660300002)(66476007)(33716001)(66556008)(64756008)(26005)(122000001)(38100700002)(83380400001)(82960400001)(316002)(6512007)(9686003)(6506007)(71200400001)(38070700005)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JuRZC/xAiE03wEqX/BAXdTgcC5motAN94wS4UzAGHU4FSNZDGgL6qyWH+MQa?=
 =?us-ascii?Q?ru/B90evUuWzVsg6JQ1VHbQO7m4lUmRNJIM17+DP6WhdQQD7MUb7DN1GtUdF?=
 =?us-ascii?Q?DaaRhpFelO6XG5mI8Z7K5oNfExKgI5DE/5X9dXcExEX9bYh3+mfQb9yDc3UY?=
 =?us-ascii?Q?VZgj7GD23MZor0EJS3JH54VK5BKLqJvft7rIQkMfLhaQ134PSA5yvHd6X9Ll?=
 =?us-ascii?Q?XLbUkgikk6YQ4dyrAa8DIgv2yz02ChHwp128o+f1E7uwdblv3ND/RnoFeNEq?=
 =?us-ascii?Q?55uoQOJrwtichzps/3lLe3TuIlAPteaNbzIFC7tyMYm8zp/7K6XGRPRbw/HH?=
 =?us-ascii?Q?ynplk7QuuVrT0tlCWRKuOd1yxFwBV62g2JU9JhITAtu+4sMEkOAhIel4Z7ah?=
 =?us-ascii?Q?wOmC7rrCJ2XdBOxwljcQU2ub+etuJ4VTZqasqVmw7Cv8wUdJuSx8sYOiutWM?=
 =?us-ascii?Q?Hfhw7uRTV1kWMsv9gb4lwBdX8cTDNsVdRYvqXQGc8CAeQx9/b44fTvqF0rTk?=
 =?us-ascii?Q?4trzsDbqB+WWf2aYorUJIIMjhJ/mzSywNz6H82CV27XYKKBVKzMYj8wn5orI?=
 =?us-ascii?Q?DPubWQp45V8JYThgPZ/2Krgi+5um+CQD2tcuiknyuWiN20xDJjVzam5l/pMG?=
 =?us-ascii?Q?tLPKwuPYMaTg0o/AdltzneQIG3bSPKfLZBRFbGI50gIuxevarf7/GlVkKiWx?=
 =?us-ascii?Q?9hy0cnNfG2gSkICxAuu3qS8foNDXlkwseyJUsBcJZhNTwntIIjkrhBwV4GIc?=
 =?us-ascii?Q?a+D56ZWDkOGPG4aKeCHM0PHUztl251tg/ksrETL5w+4f3Pc1fdulp5zUKOkW?=
 =?us-ascii?Q?IS2/3aL42fDDMXBXGywwPjYaXyzsXu85IaxhQB3kPNaQJoM2+4zBfjIwRvkM?=
 =?us-ascii?Q?wIINUwiAvFwuHw2Yi7JR8so4ysbUw3AFkxoSsg2JePtXED0Rb3kz4DQ40dGY?=
 =?us-ascii?Q?+QyHQC8dXf/qXHzPwqGq8+MaFxaS5kGYDa7VGN9+Y4nrfWkHKyVNLgzA1eDQ?=
 =?us-ascii?Q?XmtEO+Wbe8fxw7EGL9+9ZdTgGk4e98OG7+JrS9ZxTg1BCSQW889pM2wfYYYO?=
 =?us-ascii?Q?9H0nV09evUqLyGxOBrVQRR2e7d0HjCu1nChsvgxZ1XzzRKRXR20mdWEcz745?=
 =?us-ascii?Q?U9AjoLRharZ3y0rm/wg/e7X1VcqC83sIkf9wvt1KRV9bq6SrD8uREQrA2eUi?=
 =?us-ascii?Q?l8BX0BXvdIYLtdDH4RAscfwkdboxG3JDTME0GCO1CyHX5DuwT3TQ9jXueNst?=
 =?us-ascii?Q?NUw9TQysd78EO56xPmIE+Y4AAzFWNAffNayosyiUyrnBJU5UcxyzQelo4zm8?=
 =?us-ascii?Q?cGXq5yzAvGq51EG9PTWyDwKbh7h2e9R1R1mAS8t7GMESwRU+GQz/11xQGSPR?=
 =?us-ascii?Q?5Bv+Eudl3+VIn6W5kKeEE6S++X9F5zH2wNQk7jqVuxSSlV+yt9Bzr020cP25?=
 =?us-ascii?Q?w+b3Zv2nFMO2PTzzsRUtYUKBPPa42ruWLi3w7wsUWa9QV3r5sxCN7GJKc8rr?=
 =?us-ascii?Q?hnJpV8MANuYnecgi+XkOJGJ+DG5EeeTzJoUQF7ESAJaEr5WdzxlqHmkv5bBA?=
 =?us-ascii?Q?HB3IgN/drTGSxz7IJheARe0Ve7kMUgBUulzYdjuwtenmYyVGdG9aW46wJcbD?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F6D2336265FBB47ADB8E1459544201B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fkhqEqyLhlCNnnLVmHtOBdGDAVDk1Csx05aeN8Rva74kYsoC/RTfMfg07U51LqX7E3ZODcKGF4gml1GussNz8IxZyOUHIsNPFetjXdkGQqWRpglFVa7SGn2SjzslLVfcHWJiexTp+dR3kDIhIWyU/MCMDYJ+lDegMoPg5qE7up8ySur18BMACfGzsvHGlbRtKzoVl5HJQiGZ9OzmkIqTpdxc9zd50wMB2PJYWFzmwESk+zOb5w0uvIrwgowMCI7OJKJg7h1JuuA7M8sje2YhVBf2qtC37Vjvgwvyf9jLK0ptUCxx7e0ltAEw73Q67DcdwUFy4ejfEt9CHzQA8UBZBhU0wNUb8YazfW4pRO3ozZmmaDO2FEaIjYYoJtcTTdxjDpy6fmdsR4peQjt/Qn8TWXb5SXCPnoiL6AmIrQUtPy4HF4pk1+vEAQWUyy2BzYJzdTpzargYAoHrl+dgCalAh0u9uAwTLp5YL6V80fgxjxQikAeLP1OZQRgMNgr4a5QIWP3X/61Eu/CYa3/t+O8stK3FbTsGKCYzaLqAHohOFFmlFS5vfEwaRdxcwG47C1pem08Iy+3keKTFDqa0SkjFbbZq7E1lMpHTKt3xz04oiU1NdFmKmCs6hgDG++DCARId4J9EIve1gDY+iZrKwDD/enLczGG5BcJaXAayGVZw6YNjG/HIG7rIQjvxusSZkb3m3oy6FNYYU5LJgt0TmmB/4F7ovYllkEc+/zHNyBacv5MrjoDI5WCDq1JoQ7vesi1EX5e0bm3aFkexRVOcLBls0jSPz7aARDiUzEBNddmdSwItGiupJZ/I8rRw5Cq9nlWXofOjvGWjvCgnguf35V+8hm7CnJr9w0lYcfLgprY5h3XalbRFOojpKsUBpnSG5aikPaArJlt8y9e35EyGLtCtsukvMa0rvncHbKyt0s5J0YU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50693af0-c855-4739-f210-08dbd07653c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 07:38:03.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: su988D9J7Cd1USZNu4XE/pc6XW1L5n4GKYP9Z7NEdz/9tKQFm0XSpoz61pI8dKTP7WBTh/yGujUyYIWHLt0WAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7660
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_003812_432990_C410053B 
X-CRM114-Status: GOOD (  19.34  )
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

On Thu, Oct 19, 2023 at 12:54:30AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
>=20
> Driver may return an error before submitting the command to the device.
> Ensure that such error is propagated up.
>=20
> Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on =
char-device.")
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
> Changes since v1:
> - Coding and comment style change (Niklas)
>=20
>  drivers/nvme/host/ioctl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index d8ff796fd5f2..92273a5a2202 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -506,10 +506,13 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(str=
uct request *req,
>  	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
> =20
>  	req->bio =3D pdu->bio;
> -	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
>  		pdu->nvme_status =3D -EINTR;
> -	else
> +	} else {
>  		pdu->nvme_status =3D nvme_req(req)->status;
> +		if (!pdu->nvme_status)
> +			pdu->nvme_status =3D blk_status_to_errno(err);
> +	}
>  	pdu->u.result =3D le64_to_cpu(nvme_req(req)->result.u64);
> =20
>  	/*
> --=20
> 2.25.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=


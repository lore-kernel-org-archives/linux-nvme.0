Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAC3C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:36:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA2861165
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA2861165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=NwK7i1qnP9xT/3jsnxd+e86X4zMFdGfqyiqR11EWJr8=; b=GSDSHoybXuP0yucoYpB6sNahD
	3rvVVGaFSa0BVHkboW/cwhHS+W9zr1dRWTOAJA/nKKEamXf0DH73RlyjZjMfDnUJsI4daGGF8Hu7N
	Owq6jV9QizmWwpZZqnz0WGI6T5xr2FuORFBW4mlf+zVvJWvEVNSCq1Gi9Bst3mvrzxxOckkdDoryx
	UEfn+s0Q6rUERy2LFs4DFUMuQGr+6VbGome2OYru9KFIbvi5rOLn+yqeXgcoGsrBfnnQPhMDdo/mr
	qhp9zAAFPLodzKVoV3HPqyTZNfj5Tjlp3t0xy4kg1q/5rRBC/LUU8z19BfHdvT5TtfFx4B/ZJu/FT
	IRqsDZVVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYQJn-009ZAR-Io; Mon, 19 Apr 2021 09:35:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQJk-009Z95-Ca
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 09:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=YCHTx9lwi/EL3YhPVpgIPjcvrNGy71wy43zMZ6Rwa4E=; b=wyDZHlvx8Yr6UE32/Hu4ceXz62
 PAOI89YPfXBouenrs4DWJggIHyhDgU5kR//6xsbd2OiTVZtpy+2Ppw1kLVLpggWuk4y9kKp5tVD8p
 eahY+5+jkyj2aTIT6EWXm+inHyX7OiKmS/g/m7srNVhRuBtviVdU09kuPgxkfaSqONEYC/NL3giMR
 ziSrbSHuROYwB7TWu8LEqktjoxOE7Q+luOvQmfbfNDP5AIRZEmDdd5cE3D+iul+LoylBxarGd6sLt
 3m3OrBtqwZsyf9I5vk7m6QKmUqMnR69JuiQVjDM7LIMUkEQwtwWAraLhmG9ZRX+XCOfC8NCJuBthA
 /jRqB4yQ==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQJg-00BEXs-SH
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 09:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618824941; x=1650360941;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jRHAbdA4mx9WO24xHUfkbr4wGF5F6ZIa1Be8kGe92yE=;
 b=X2+fp5+LAOr5G1UuGo0cchF1I41J7bUN3LEwSjcz5Q47Q0uH8iR/K3qq
 PeHjO5zbc3amqUI+DAUNCae0/6Hz0BW2B/PnVMnMwLVDmfx0QlF9Dn4Kr
 knAPzciRrBiZNSe0c9uPIdRdxygQ1mLdDIkpNM8ekcZ95uEsHnlJBzkPX
 cA1s10LKLWFYqoU4Rv5KwvnzRdO0G9YyvCDtEXqTW6whyKg+kx9nb7syT
 ejDfieHuLCt3MYaOgK+gH71Lgm/Hfi547ickcjDe1pcyZ90sBFoxwv2HL
 iozhoa2IIVI1gqWQpjZXO/ghAPja9uvLISLkecU1Hfa8msNm11EZVvJvd w==;
IronPort-SDR: hplLCupomygUW4XTFwNVLOjXkk4yTxAxaOIh1xpcIKHDBJ6vAMJyG8+D2kRVYawTCTtaTmGE3E
 SbY/6H2Q8vCl0KdOkI0fxicthTy23/TzzsKxT+sQhUH53BXxlpKRWx6L58/6EKJpVVFtK5gsxG
 AF/6lgA6AP4sbwIJEygtYxNJQLU84iiP7I6lS5uzHaC/Fwh/D+wC9XKhLmwsXWEZbYSwfKrCvA
 +5Rs8n7Q91H/hp+lNuTJUEL1VnPqRVbRqglMt/vX0qcT1hcI2CNzm2YW07qXaD0uscFXJcddYe
 MJU=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; d="scan'208";a="165974672"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 17:35:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J89rXZtl5wqZ57b+bbp8AhWVlUyvVaDAp8W8Z33526IoRlTINiqbHIJhuhEgKeRRDRhO+HgyBpMH8e6eLQlpqiSPUZJ7VZavZs12IedWNw45JyIkU7f4N5tUjXCB4Bk+J57U1JTgG1iVZF3kCZ91BK1MosDkMIBfHLsOjXSkoXYMZEH2wm89N7/ENkY9mjwGkMehOuENXIzHnPpN6fJ2KXbH6u793q+hNuEwgCGI92tUyftD+okkdxFqJe2LG07wCPIwRpwiVbqYfe6GJjFrq4hHnk90lxQ+iiMS4f8110YqCEMpm4RG1yQbcQ4vQodgyb26Q5GB8Oitlz81ibAjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCHTx9lwi/EL3YhPVpgIPjcvrNGy71wy43zMZ6Rwa4E=;
 b=m2NvNyW6zUpU7wWKqG/tjturFdzW2qwroLoObf8ycgHBgxd1Asv+IUevMzMy6V3/ie895TKO8AS5kQwdkn9SixEQLs98ljnPokkyEsaNIG9MIQKzSKe5iJtoKhIvPQeCq81p6rZtRxNRpkrTvADXD3JAymOMJKMAdLUzMBks2xkrEnOubSlGaIq29aL0AoMWdHoXtVMOXyNJ/D4OZPAVjjWqg3gh9EqCJsjBKvQA/P/mkSVLR4hyK+lGo+wtjrrjznokqH4Wc7Q59iTvgUXZafTMU5VT+7aqwjt444dIqktpJdyMh3sv20HryTYE6NC+5Q9iaRk86680r7AZxPD5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCHTx9lwi/EL3YhPVpgIPjcvrNGy71wy43zMZ6Rwa4E=;
 b=j71iE+Ue3IH3m0LcS3xI4oOPIRgV/2cYocnp3aFV6U7tUjF08csT3ApStz04w9zh0o/zSQuaQgDbwZeu8r0Ch8mbdKQGzSIYbPLFuOdpdoiD/eWxFAE67Qo/JVZfs0RIjRG2cUevZTqeV0ZrYBVKH5L8cRjq3l/1zBGTwhMJ520=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (52.135.46.87) by
 MN2PR04MB7039.namprd04.prod.outlook.com (10.186.147.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Mon, 19 Apr 2021 09:35:37 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 09:35:37 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "dsterba@suse.cz"
 <dsterba@suse.cz>, "dm-devel@redhat.com" <dm-devel@redhat.com>, Mike Snitzer
 <snitzer@redhat.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
 <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Topic: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Index: AQHXMm1j7e+Wo1nHt0KL4N4KN5ZXHw==
Date: Mon, 19 Apr 2021 09:35:37 +0000
Message-ID: <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d019:11b6:a627:87d8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b539474-0490-4a3a-d5bd-08d903167d20
x-ms-traffictypediagnostic: MN2PR04MB7039:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB703970456CCF5EC78D38EFCAE7499@MN2PR04MB7039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvnMZB6zkIDWqR3vM7k6GER72fv5eyeHwoTWklKHOwa3NoxPNVKWRoc+H0dDr93XpKNYBEwTQplEVfBWnWKjRBcJueg+JjGqO+Y/7yZgPAPlUj26xr+hIYIiUdiMEEtrtvqbdgJ7RY5EGSE9Tvd0euEWyh5DNCtqo1TqwllxgbkK5BdwKEKKSU0eGEeS3NH2mJLjDJAjs5iUb9t+zGppIz6lM1AmT4mPVvNO+9fTHtmgzgDOJbIxRkL93ClBDreovnivOKtLpRdduupBGaZHX55nLAkIH7UA+yGUt6/qvNlOSk9pH9IL3JM3CaE+OrNSl4kQFXruycduQeB5d1kYPsmeqwU6NNySDT80oHir/0M/rO/KDfz1B6LVeOGtNbYcwk4txuzGdfFHxdwM71oyyouLTLvT9iQDpYOqmfnGTL8P06WSafzXdoVySCTyP+zZlp8g+TVrT+FSfgJTUKwZBY8C5ZpSdO0wGUbHDAGy1lEn/HnlB+frnzqgl7okCEVrVMzUwXKofS+ULEvoEH574LZyLHBct7vY2vIEUyZGnONH9unQ2UOa8IbugAs9NPgDS+ahj399+QBX88Z0ycCd5lHbB4pk6Nfo1VqnIFaFtQnLBPl9QbRePYq26f90+AjphdBtvwz7QYtS65neSB4O1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(6636002)(76116006)(86362001)(91956017)(55016002)(33656002)(66556008)(9686003)(8936002)(66946007)(186003)(316002)(478600001)(110136005)(8676002)(66446008)(2906002)(66476007)(64756008)(71200400001)(921005)(5660300002)(38100700002)(122000001)(6506007)(7696005)(52536014)(53546011)(83380400001)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6EsK1XpSP/s9Xf0QvzFihInUqZOFsscYGSIegwkk9kxKSTjp9ShaUepGtY3W?=
 =?us-ascii?Q?flVfiSbyih6PDa7mF1X5C2ceV7LXE/T1XGxg59C/l/mfV/dd2WYUKhSif9t2?=
 =?us-ascii?Q?k5nF70AC+MmFq8mw0MJds9XqZnUsH99BSbJ1n4Y5JiRoN438p4sMRVb2DicK?=
 =?us-ascii?Q?ke8xi8kkVmhee+VzYo9Z02TO7hT6TlCv1G+mYi2V9mnoKdedHx2rnZh4jX4G?=
 =?us-ascii?Q?fFodD29TVXgtHDwEfvmwqKGi5ZEhFJeIr3lr3D49WzzM0y7myFIri8IjuqwD?=
 =?us-ascii?Q?KH8YGVZT0SBdO+dLVlrI7ShGy7N/xfuzoEg3lqrkWReSd0p2rQQw/EWEEelr?=
 =?us-ascii?Q?rW2uf8L2ecP99+S1prkWIDRHAs4HEnfemYz/f4cTAbuosOnzT4/45JvzVvNX?=
 =?us-ascii?Q?O7Hois6GrWYzFphaMYB4o9XVlbfjsH50T/v3w1IN8Bi58ptwGRSlnUI7EeL5?=
 =?us-ascii?Q?m7521W82zINAErzt6sP9ikwyhR66HmsEUY2ICHvIeVtmkf6vGwMscHGYzNjj?=
 =?us-ascii?Q?R8JHoIt+lJPNpTjM7NrgJywkJ/lVHI4z4zgOqPmrnXbb8dZs+I9/njJwJvcj?=
 =?us-ascii?Q?De/O7DH5xc7xm3evjLmT66P5S9/kXZiVyYZtKkj2M7CuBLNIXMK+nlVLKA7l?=
 =?us-ascii?Q?z4WW89R0ARv3r7Gb44PkHiQ1xJBYJBO2ZehVBDBKJkBqmqUhRpde8RXWDi7g?=
 =?us-ascii?Q?D8N4ltf3PlSGOdTGXNPpDkBeYfMU63OtcXK+R9rHTGEDuY3bCPuwCwVX9fMe?=
 =?us-ascii?Q?c6/2DfiMhm0TdWAZvUTAY8tQje4lfhP0gI/BOu//4StFOT0h+CDqQiYPYMuO?=
 =?us-ascii?Q?gMJX0WalRgl+LC3rK9TI6Y/WP4DWjr7l1awendABzWKwOtluCgmZjEOEca6n?=
 =?us-ascii?Q?mQftdQ8yryb0hNvrkTyq0Sd8CzjONjhU/i7Z3EmZ1v6almlZQe+iwZ6eOt2p?=
 =?us-ascii?Q?wt9ntpGmnBYCGJGQxh7C5ucsX1382Xw/MY53ltOLplG8ycwL4V9nK6owUTTZ?=
 =?us-ascii?Q?MdkjIymtJC+wI318fyGTMTuyXbiVMCZwMhVw7/7UHcqMI1V714GWdWbaoyMB?=
 =?us-ascii?Q?ie3xfmXy7ldFvg5Cr0fuA9B/qog2tD7D1EIhzLtv6bbFdz0N9ro/xtfVlL0U?=
 =?us-ascii?Q?UO99jqbAxsHmibnINUdswBBYoO09jaaiMQskTBvy3zJwREPlYPJKcOZniKTr?=
 =?us-ascii?Q?RVyV9NJvMvTICh73AV6HyOQ6hhicecup73jPG5P6yWzEpIgzo+HiCyCZPiqG?=
 =?us-ascii?Q?dqxf1TqOM4sm+lxsbvdMEXee+w7kxQFPiMdsGdVpR2X30qfi9axTVy5NqU0O?=
 =?us-ascii?Q?m3vrnuyKgKQo1ijmPHyls1uEnF2ty9pSLp4JQEWIBdhymHAX5V3+ABIUUUHD?=
 =?us-ascii?Q?3bbfK7EJ9tUWxTTUripDdME7KylLjsaANqZXDvPL66DifrqBNw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b539474-0490-4a3a-d5bd-08d903167d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 09:35:37.2396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5JPWFb4AFdDQmXWyS6K+qq8CYaeYTtmRHrm9VLi7mmkVvFXlEzeDe5gL9XMzmlL6bl3kcF6OTCQLI4SiPu89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_023541_075316_4667D4A5 
X-CRM114-Status: GOOD (  15.56  )
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

On 2021/04/19 18:29, Christoph Hellwig wrote:
> On Fri, Apr 16, 2021 at 06:17:21PM +0200, David Sterba wrote:
>> On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> For zoned btrfs, zone append is mandatory to write to a sequential write
>>> only zone, otherwise parallel writes to the same zone could result in
>>> unaligned write errors.
>>>
>>> If a zoned block device does not support zone append (e.g. a dm-crypt
>>> zoned device using a non-NULL IV cypher), fail to mount.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>
>> Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent
>> fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x
>> later.
> 
> Please don't.  Zone append is a strict requirement for zoned devices,
> no need to add cargo cult code like this everywhere.

This is only to avoid someone from running zoned-btrfs on top of dm-crypt.
Without this patch, mount will be OK and file data writes will also actually be
OK. But all reads will miserably fail... I would rather have this patch in than
deal with the "bug reports" about btrfs failing to read files. No ?

Note that like you, I dislike having to add such code. But it was my oversight
when I worked on getting dm-crypt to work on zoned drives. Zone append was
overlooked at that time... My bad, really.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

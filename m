Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30566C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:35:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07C561153
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07C561153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ntVgOQYEj9NJ/MdgTJK2tUwLzsmoZeXEcH+17VW4ePE=; b=NJUkopI6hPIEU+ZTexBYWa2UM
	pp7SxbB8dwk4Kyw5iCg/TIk0UugbabqIcnB32ct+baZ9FCppa4msAaA4uJo7iTAxwzXuK/r6GMWGG
	Q6pWVXNDY4Q5iOmhFCUB0y91lPEi6dCLJx8oU1imomfP91tLaY3S45dHTBcspdAi9AFWED7HKCQIB
	Fch7XliLDkNne2INHUCLV5PuVIdK3fLD8wBcJt1MK9vfH3IBGWaDxvbuF75icf8p7sia1CPI9n+C5
	3//Dg+2IpCjFae2SKx71UvlYBUujefeBNlSFWV380gq2j5bxPRrLWeGt4JZ5042M53QdXuNFjsW3Q
	l3vfERsTg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXJ0X-001Cj2-UD; Fri, 16 Apr 2021 07:35:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIfO-0019dk-Ho
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 07:13:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=CH9SFuZdv8JuWEmu5BcFut/lFhzOJLXgeTftnhf09qQ=; b=4hpz2qU2LqYldYKRpOJGpLl4xX
 1g+DqTOJyg2cXlomhp+yfbnhpl1iEMO2Jn3IGKQLFw7dwbXmmQAJ5FljCrqNH56cnVBtP/Y9irHep
 f7T9W6F95sV6Ots0PegWGDe3EDIXuj9bvbS00ySP5Ab6Qxr8QoS54wqw1ZYCbpZ+D2iX+pkuEMTVr
 b7Ifr2rWg+SF8XtVqoYGsBz8MnmES56nv6fhDQvoy9DQWtV6oY4Q0fp+72D/XnG47s3FvDDmWFdSN
 dvm75JoadFH46QWo1Y7MhTeOyg9yH9ExZr0cu1HMAl0Prp9zvVwpYBp79ZRBnqVeIlLtj+56wmgXs
 TDpOr/jA==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIfM-0098tz-2s
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 07:13:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618557203; x=1650093203;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QFC6zzacAQqZ3lTjlEPsqzUIGxYEqL9G+Pk7B/jh2r0=;
 b=Ru17i72+eTFvNhq/6iUSUzVYQBVy0w5VntbIRaseTYyPoHXJAgb/L2dH
 0L3ZelJngc9LTS09L+DJ3oyzEFLI91gnj+dMMl73GsOeRVj1t5NJbUOS7
 CAn6ZMVT1UcAW8SRZXBq+hhxYBFx3Ul6byt8Xq53F2/Lbmp/InmRAg4lN
 rmm25UFltSp2IOuUslpEilEHze6KLQf5KuctnMokzO8zGSvV6iuaz9x0g
 xIOCNJGA+nJwvj1UEgJ+C5t9Hi1T7nYe9w9VOFkGTwQn7ltl0QXtJGc1H
 W7RMOT3tbsq3RXy6ap0psdIq960KylGKQE795ui1Ei5V5WCY42KxJ48ls w==;
IronPort-SDR: 74dOrqfUSfdQ0Cht0cyh1UdPzUPz9ana57xS4zCIEFS4UQYnmALs671UgUvt+Xq3lW7U88N/Ot
 dgQBB7Qhrl/pkLzDCtXFsz+QY1bKUi1eWEJ51M8Sv6oosOvvJArOjH5oqUvFV4R/7VaD+8q6l2
 9r1joQIG3UGnw5Fb/ZQWUrPwjD9JmvwznWi77QKko6GKxnq8amlDz3S/kO7O5K/hXQX/j+Xp30
 ZeDzDpOvJdDBYH3mH694ImfJGAVCUsQZNpD6tE0w/LQOzwEuK1XxEAlz1PJ7wvRWdb5RmpjLK6
 Wh0=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="275977458"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 15:13:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNnUKy3+cdrXRoaTUTSkXbwdKETGLsjKnm61DqpGG+C3PyD1j2VyGLIvqJbp66As/uT1EplMiJYV4hqb88/vhfK5YiGssSyjl3KRLzmfH0qFTgVSSDo7OLef/C2mluXFbgIqsdqLS3pQ4Cnh5ZPZhNgBU2PyA6YSj2naHsZabR6mxVjxwqYsAyroV9vFkW97xcOz5MAAMRskG1zlxChQboO0orxds4DaMS7ygPfLDoUhayqdME8Xc29RWVM+rCFrHpzqSL9bdLyxYLVI8H8ODXNB+HG5FrnwTI0CsioFySM+wwuKcNIe05cnwqlLM6VMIQH1L04IHdvIuKcYYDZkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH9SFuZdv8JuWEmu5BcFut/lFhzOJLXgeTftnhf09qQ=;
 b=Mp8HQ2zlyTiSCDddL+VeaVRbTFPyi8GfUw73tL5FV6Up5OEkx1GhqoGzFqAKyCgO0JGggXMPSkksL2k9c6p4VRG7vBQ5FNtB09GilMpJ4V8UAUv5KFb05fUifJEI+PS51zafRGNzISpbcMS2RmsmWZ4a4OIsJlZlBohYEATmsiTFb8AhAA113fVRq4VC/dtkNf1yrBwiR6oUvYQSgTP/+giB7op42na+JtHyZWXQsQY79Zu9QkKXm/CtEG84D4ICK5itKazU2eIl8zrzmCEJ7lyjqPHSRIIW+g4Owe4YhPNAsVndIDxLuHD9B2MO4gLRSDIA05ddCjXXz6YQzBST9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH9SFuZdv8JuWEmu5BcFut/lFhzOJLXgeTftnhf09qQ=;
 b=i/uWHMgPA7FqehMrTzJnHeMOv0UrclKQQ0NCpbwAeKXMoY1jLuRPmF8lwJv3491Mn4mq7w2Inufdy0W15bZPRXuvlPdtGRipqp7HpAZET2NQW3YPbsm9I9xA1tVNFvu840nH4ncekqtGGS0IJTpkG7LZAFUnGGugkru32q8bCIY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7576.namprd04.prod.outlook.com (2603:10b6:510:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 16 Apr
 2021 07:13:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 07:13:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
 <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/4] dm crypt: Fix zoned block device support
Thread-Topic: [PATCH 2/4] dm crypt: Fix zoned block device support
Thread-Index: AQHXMm1huarhzLzpkk6eySNmcPNHIA==
Date: Fri, 16 Apr 2021 07:13:21 +0000
Message-ID: <PH0PR04MB74165367AACA8F3D9F7B023A9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e97de7d-a1ff-460e-d343-08d900a71e3e
x-ms-traffictypediagnostic: PH0PR04MB7576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7576141DA793D267154FF10C9B4C9@PH0PR04MB7576.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sed0fgE2qR55DluVQ4T5DWd9yrofTEjql3R+QBoeKqBsPFd5XLaLT8GjTt27SwdxgRl5EFRWbA/Q4yXjkQGd2XWKl1gLWdxRG5IST3hzVUliZSHcKpHpwu5lMGHDQvV/v0FZbQ9AZTdBD4XtTvW7yFUpv7dlZ0t9eGkkCtJqEC8YwwuOXDDoVBzytnxQz5YxUxfSzJUcdgjBtR4PmvVVfsDbuApDOG+BFGQfhxOtuL/ZVKF0Pk4T4IGLQotnidtTgCwxTCbUgtstvN9tudjrDUmZJscdLUoBeb1hJFv0f+HKAI38f2tQ0RczgA2l8dVZ8zdOLxqic35X4ZrozUu4h+Ml8i88vJZIO7gvWBbooJJf7L+LGkDZYHlsAQskgS99xCNYlQ1jKYEFzzqEvC2IojKY0Rdlm6OsRN2dbP9RJS/I8L4YFBCmmYFE7bs8sU52LPGSPD1TYt10vJ7HDmhr6NCmB/af/vVpRYDC1F7oHsv+561r8tkuTEtnvr0qEY6yBC1mc5xdw+whV4aAdt57XvyIdVUeFahJOgW4RPw4+Fj6PzBvNNw3L6DXA0QhzBmuMP0ruigNNjdIZvV9WT3hrcvvV0O0Ss6u/YxWeVN6R7eCAvQhw7duCsCqXPGY1WO833Mcd0aplHy3CByTjNxOVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(2906002)(71200400001)(33656002)(4744005)(7416002)(9686003)(66556008)(64756008)(55016002)(8936002)(66946007)(66446008)(110136005)(316002)(66476007)(8676002)(38100700002)(54906003)(478600001)(186003)(52536014)(7696005)(5660300002)(53546011)(76116006)(921005)(91956017)(4326008)(86362001)(6506007)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WUe4HaF08JvaW3uHTfGKSzjJNCHnuFbDPaq+1h4/ytr+weQrprAm4UPeBHsR?=
 =?us-ascii?Q?nEhNupOlXA7DHKsKTMz/T8bNghCpfJzm9MRDWAhFcorcsBkXDxOwMD4ppfo2?=
 =?us-ascii?Q?I/0GeEx54TUcCu1FV+86t/8mjSjogZ3eWIYU6yL9prIC6CNesIWVUxcvxJVD?=
 =?us-ascii?Q?SXAHIUEVi+Hp+Z3+qfKPWIeUXBQ3FfoTNVQOMgtz7t7LyXI/GYqyR1nL5jvL?=
 =?us-ascii?Q?t4pPhz+EaC2RVRvwSOivUAkES3YBtCSfD6/6Or5g2eDyjueff7C/kna40OZQ?=
 =?us-ascii?Q?yE3kZHYkx0Eaipidz4u4A1vILYW9nGJGFFZYV4SYYw2cO0Wi48nbd2sEKKK/?=
 =?us-ascii?Q?5vWjGqJzw8AgrP7BA2DfshVkLGrM+BxPymVLopETVnVCqrkXXIou78e4FA7D?=
 =?us-ascii?Q?tV3bwXaFnlYvcUC6gkXikmBU3ZcwhkpBXOjJAPJsbMz/c8rnRN9N2/XvVqqs?=
 =?us-ascii?Q?SAT9gyEwX3Vv0R4552taC/w1DgCHEgmmqTybHow6k8rQ1SKZWCrh/lJAr58o?=
 =?us-ascii?Q?qaCa7FqAE+TDi34LDHItX+beZUrpCp1vZBdPNmK7Nlc9uqkKcX/eS/6D4WzI?=
 =?us-ascii?Q?yGgNa/xP2cKYMjcilRr7/pvig5O50dKsmccBoT/ACFxMuHsIcsnfISTrTFUP?=
 =?us-ascii?Q?q8/GCGpuD/g+8oh0YM6da79bNxKyPH4L+7MYyXSsLQSMddyGs1Otv55WWctG?=
 =?us-ascii?Q?cap1/dTXuKc4CyfC+UdkNXXLnJn/r3ktYgvv7URSFEQJCRxS4uWM5tt2Zg3W?=
 =?us-ascii?Q?dzs/QELo9hOEoz5STad9LtEc0IJUKiET8HvSLwaYL7GopNiAf5Toa5IGjl0s?=
 =?us-ascii?Q?HXA+3hXwH8P6gmvqSD1IemfXbV5YyX2ovQnrvo4yCGtbdGC2HcMKIxBFUVxM?=
 =?us-ascii?Q?pcXTfM/ZWuCt6kkLfu2HyId7uvExL0ZQ1F6See88Y+12iOPO6kKDTkCenfkU?=
 =?us-ascii?Q?sdlXJnjoloOn/lrOnklhSFWHpHG1ZLyWfi++jyTmkHTBpwEV9IZuFzunQkc8?=
 =?us-ascii?Q?tUDXFyDo2oh6FXpNQ//tBlKix8VbplaAYJCfLKXBrnf3J/eah0KNBq/oudvk?=
 =?us-ascii?Q?4CzRlaNl8Pj/wzBjQXPtOJPfYqm+YCYzSJhimCtYZ+fvQ4QI5DXM9VUWS+me?=
 =?us-ascii?Q?c4iBC2OhfEkjF/4h3YHc2aCcJZHBabUVCifKeV3Ylb5SzqGMZVacl6uNlyxq?=
 =?us-ascii?Q?wZdzqt9GjdvJDpqZlzpAHoAUM1uRTgIOXSKpewSiBtqUcv9HaMdW73daPgCb?=
 =?us-ascii?Q?fOI4z0u1IUj3kjoNmc650PVRLbNO5jAwR9ko+U+3QjFhqP54avbZbcKBAFQV?=
 =?us-ascii?Q?6GttwIUlyqPeQaYnNqJtndCrd6azjSoxcZ1rmC3Dy7VYxlUULSdOsISSWDVp?=
 =?us-ascii?Q?CWOIjmYFlOlA66l4ZZSVFz5f/ici?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e97de7d-a1ff-460e-d343-08d900a71e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 07:13:21.5044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tbu/Jrt/StPtP/wGGyTKLOEZP7XMnNOtvh02Chk/SdpMo8vZJyGgMKCWRNYFxpI/c3E0Nij+Ek90p3oJFZPaOFdZ3LNZQjZ/PkEPLwsbQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7576
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_001324_161296_9D17AAC3 
X-CRM114-Status: GOOD (  12.79  )
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

On 16/04/2021 05:05, Damien Le Moal wrote:

[...]

> +	CRYPT_IV_NO_SECTORS,		/* IV calculation does not use sectors */

[...]

> -	if (ivmode == NULL)
> +	if (ivmode == NULL) {
>  		cc->iv_gen_ops = NULL;
> -	else if (strcmp(ivmode, "plain") == 0)
> +		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
> +	} else if (strcmp(ivmode, "plain") == 0)

[...]

> +		if (!test_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags)) {
> +			DMWARN("Zone append is not supported with sector-based IV cyphers");
> +			ti->zone_append_not_supported = true;
> +		}

I think this negation is hard to follow, at least I had a hard time
reviewing it.

Wouldn't it make more sense to use CRYPT_IV_USE_SECTORS, set the bit
for algorithms that use sectors as IV (like plain64) and then do a 
normal

	if (test_bit(CRYPT_IV_USE_SECTORS, &cc->cipher_flags)) {
		DMWARN("Zone append is not supported with sector-based IV cyphers");
		ti->zone_append_not_supported = true;
	}

i.e. without the double negation?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

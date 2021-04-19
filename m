Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA098C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:50:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C25260FF1
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25260FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VHvSCQtlh7v2rrLpRm0r9K2Z+IjGDPW4q4+gyJHbhzM=; b=cN+nL4gR1Ac8T1PNgVVNiEXaU
	XhwSKS8pZvyemhrKgFO+dHr8JXfkuyIdUQzHoZG0ejEqtWQRU9up375J0JouppPGV052TC+FJlNml
	uiRAu4lg7l1BxWkgZ6T5puNvr+Vq+bE9D+MOaaVD0UwZlS7O2PwdorI0mdA6u8RqzG0C6MqV/xRxV
	nVZ+lfGifBERsJ1MrN22q2njQXvuUXP1PpZGNEgoPZlO2pIyPLwM1DhdRklUE6mn3xwrSn/25ZTff
	jH6pIBgy+uNAxwB1bGRXJIMZQaIp8O8BgGLHTgjbNov9BUAazSW+z6TNzzvR0pxzPSCRX+IO3i6Ye
	w+lJfL1tg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYQXa-009cpg-3A; Mon, 19 Apr 2021 09:50:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQUM-009c79-Rx
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 09:46:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Luq3WjSeTdipwrtPd6gmctfH6GG1ZgnZVYLWnq022m4=; b=cQOpQJSOM5cLaJV1431Z7kEVyz
 MgrypDvWFG24x+Lui8b25vEtsaqWMdYkcorB/RL6anKyApX351t8DCc52RgjvBe2BSWpXpvixoQ5e
 MKrMdMO0bTJvkU93S/ZN5WWBmi6CfImF1GM4Wel/HN3V4jzpFvVdJqOCT9XJJYV8jHfi1GGPGC7BV
 y2DQiVvbrQsGFtXapUmidRGbFnKLhk3gIMxRWCw/8cSQ7pNeMqnG+SmJz2D/fvASobSVwN4Ed0KoS
 Q55YNtNXZsZ8c8fiH3YKN9vKJNhLqL1SjEHklOwTEnrzqULJX+Ee5rVvrTerbrTNUWyCJv/OqM9OF
 GZyE5dXQ==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQUJ-00BFR9-Qz
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 09:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618825599; x=1650361599;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=s1Ng0WDGmtJR4WnQVKxdfjuF0hdkkDG2TN50y2aVfYk=;
 b=KY5+lXIlNKCYCF9lLHsPjjo5xgDvH0PE8CU3qbj78g7fz9CdC+qqhMn8
 twNlI+56TSVgpu/hiOVF4VrTMeufpI9jw6x/zTcYCn+lwshwcCD8m6FAU
 jwWmFkF3Bz+syuUq8YWbRcb0IbZgWrksA2G1avAYclgaUG8HnZk4IhuoO
 9UrMIacVnWTvXSM/q0RTG9+I+6PDltJxr2UvXPKI/sXSdQduvaN0QCWh1
 g7bH08QCq43LX484oHX89ENlQEjNo7cUCu3aZwTYuwJE0ZgB2TZ3w8619
 V0enQPkJl/he2suCFL6eec3W9AMbY9IXfW/5Yg1/ctUgyc57rsB+9fh4Q Q==;
IronPort-SDR: lcobadFrnYdexR1Z7oB0EhQwNUAcNcyzQjdQ8An/jCUTUmDUDrx8UEw6dBudl9sOwINMvDICaO
 9nQxnADXKN8nbGgTP6usggzThcjIi8Eaxob1+DfBX/sFrVzxhArTYhJGjTpHRJ4YuRE/EAuu/o
 yuVE+7KZ0bC/DPNAMIyesKAwVwwWvYMkFe0yiDuvXuxt56JfduUVDQjYAFImQvu5h4Ajvm7xdP
 6zHgFdxWlbBNRLbRbB6vnn+dhAhrLBN+RJv+zAnCZb+WGryD7m2AcBqGTPn3mevGQolIO0oafP
 n4U=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; d="scan'208";a="164772474"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
 by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 17:46:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE8/6l6DHTaYwYHpvdUO14jzXqtjFDO9SRf6llE8ONZj9uvSJIAsTG6Vl0pczNEAkfI9FCLgRx68eitQD9l0Rv19cIE5MfW+taz72sfgudPu5qQ1FgtmApA2SLEFiYIeKaMZI2R6SBGNRnWjfqUamcY/s6RBuzy+mWasCB7Lo+qy6VCXYc67Nz9UUyKA3trhr3LUd/AhqcgJPsQV8Wc+WUBl94L7hzGSnm28mGhOc9DYUY84guWuxEeYbiqjVpikZSChD89OW1A/hmW1O3ER0RQJtNa9QV+GsYXJlIngpvXHRIWonwCUCG0w+Skaiu7VNe4GuuSImxbhRksYJckrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luq3WjSeTdipwrtPd6gmctfH6GG1ZgnZVYLWnq022m4=;
 b=QEBVhyVQLOcqGVGljplV5yXCYcrP/xiveShHQKPm+ZBI+OW81Ty3hwzJfl8lbFp/Uf8wTzMkGbJ71oHR0n7NbRvaSqJC5jPn58P9msLOWX9CH6m+hpq6dE8Q4hZEOwZhdpIubPfSwoNOnz9lLgCNvcBmqcXIOXBBtUVFbdGEAQ7obJ3tTkPkDNvRrW1wAdkajrTd1I8MecEieNHCgreOh7BlKn4NNpAdYoqTnKD439Chl6w+lLaolkxzW6+w1VhhCQH+AuIld5tVxvgupCoP1ujIamE7iHQeOXa3MbQblvw2kfs584JM85AEqwmI4+uI+Z6Q7Rt3KkUV0OtMlYGFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luq3WjSeTdipwrtPd6gmctfH6GG1ZgnZVYLWnq022m4=;
 b=LQCXiOxBE6SaOjebR2ldxW/MNOED+E9+8crbp/T+Q/b+YCy8QByFzFMXhsAFrVUWNRGzxkNZrT9jxFhkZin7oskyy+cKX5hR6CApTXRWM5HKi4nanzTqtlaBUFWb5GebaYtrwLDl9QAWDML2OeI/2DqGxUM2A1xJC7cwRIX6Uhc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4529.namprd04.prod.outlook.com (2603:10b6:208:4b::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 09:46:36 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 09:46:36 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "dsterba@suse.cz" <dsterba@suse.cz>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
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
Date: Mon, 19 Apr 2021 09:46:36 +0000
Message-ID: <BL0PR04MB65145DA8B6252C452EAA8BC9E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
 <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210419093921.GA3226573@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d019:11b6:a627:87d8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebf593b0-40b1-4f22-cab3-08d903180647
x-ms-traffictypediagnostic: BL0PR04MB4529:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB45291647424ACD99A03CA3BCE7499@BL0PR04MB4529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWetnChTNH0NjnRA3dpb4dJssJ6EnGX6GqMfbE+TOsAhxtuEWu3BeVbgNRy582MT+8qkeGkLzujQ+/SisYqPfQyVGJKp24os+OfZrUtC65V7G1cJj/3lrlq63k5xakrxwilgkwYxn/C9CnAZPOxjFDuKYT6bj71sLQ4DX5Jhqt4kHgTYtIKZznI2NEBGG6ShOwcAqo45xyyFc0GNZ7tBdev6XC8bmAM/ve+uA0Gp/lViqUfH1dx4WtsVralnyuWcj/noN5hTgURCr7cIIgJBUbikAVEePE7Gfms8TpaZ+VBsTHWGeXdwv1F3EGHyMXkxSri3t1Bmvi55b3TCmMf1NkrZrgGL4DmsR1Lc6g1tq/b4EozAnqyKoOzyGZw2MzKIll4xBp7Co7vBHe+XKf2saEVao02rtZ6NpYvhOx/8nZRrdEOAP7QTrEOW8eNJz4LRUVFl0SNaL8v1Ua4geoDnvGMP6tODWWRByAtLeTB0MzhlsvcjDZQBIHGTHx67+yTaaftvep+qWYlMX48AfXS7i0p1lzF4Ttr13890h1dXuXSNFg9WA9SJKwWk/YKs2ADo879OqHve4oA9k2vsDjRHZrTr/1ribyUu8EtLWHOTd70=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(38100700002)(71200400001)(8936002)(54906003)(122000001)(91956017)(7696005)(76116006)(2906002)(186003)(66946007)(64756008)(86362001)(9686003)(52536014)(8676002)(316002)(5660300002)(55016002)(53546011)(66556008)(478600001)(7416002)(66446008)(66476007)(6916009)(33656002)(83380400001)(4326008)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3yo1PO2anyL8+WM57r/JZnk3c9GLGEqv3SnBeyXy/I93Bt/Cs6/1xxpjWi4p?=
 =?us-ascii?Q?WjvxboVN3E1YDQL+MVgRVJeXiLl7F/UNMEo4QNVgTSBYPA31UeCYcRbm56PW?=
 =?us-ascii?Q?bOKKwrvoixzw8jG+doQEBRlQ5rOUQstLoZiZ841iXALkBXM/XpFEfOeEeQTp?=
 =?us-ascii?Q?6h6LgN2hyWkVmcK4GmZtVMcCnuBPzHWQeCoUM5+7Wmft/gPkrt3IsJ9UGLQp?=
 =?us-ascii?Q?11d5pSRpqEQrNcB8SiBt5HOKEmy/+OxVL1ze/fNglUaHamVeXStE/Gu6+vAT?=
 =?us-ascii?Q?ckCLm2BRHoLqT1n84sEcyxCjxfqRYPMwaH9BzfWYlZmS7uoOaBNEnRrFEz73?=
 =?us-ascii?Q?oJFItAoVHv/rY1p5vPSIg1LJxASwslcMssCybQxNX1DH9i3DgqfEQsAUXF6T?=
 =?us-ascii?Q?4MUgiSCeZXDg9ilrJOXoBKi80oDrsUXkVkJ+eWWJi6XQSfMmCr6y68BPqi7n?=
 =?us-ascii?Q?6YGIS3Zd8Qcx6F7JEWv5dppkUNLBLXEmoU6Id60LdC/KY0WTLJHB3DtFmaPW?=
 =?us-ascii?Q?re2dLa6FU7aUgyBR/5DWw4A7Ip4+tKZoskIuREdjXPfAMM4uuAZY6ADFG/98?=
 =?us-ascii?Q?hFtztSXaH/b6U1aO8eU7Cxpn9AYhMGrepk4M9s8PdS216llXkr5nq+AgEex7?=
 =?us-ascii?Q?0ANS+YZJJNFbCcqTC0wKcCdQzXd9C9aAty8p73HjMboglrN0KOeNwEQuFtqC?=
 =?us-ascii?Q?APUPShv4RCJKTHrGKywVTQ8cRIjgt5t3Fw2vwOGCF8+/vvrmSKDqhKP7AOw+?=
 =?us-ascii?Q?/3YOMqCy2fOrxpzCnSw1DJBOKuX2ooxq4OkwJfOCFfdzpb2Wnqr+KT4nPDNP?=
 =?us-ascii?Q?9vx/HdKfebm+4x69G3VCGibBPbKfXLH1Zo2sDtTDUGTVnHC3qKU9V5X63UFp?=
 =?us-ascii?Q?Ibvf9JqN4CGllEr4miuv194a/ZKVYDxPyPaNykbDmqxpV6rEI4b0fpUF9PvN?=
 =?us-ascii?Q?LZ8ndPv3yT+A0+7ELLCMl75RjqkIeU/LcC0hgVFs1aB196aerERpYA5x96kY?=
 =?us-ascii?Q?i+DHzQI1efFTok9TWdJLtO/3LdjnBM+2ZLUDTMrn5vzzgvVIMVRhc8QcCPbh?=
 =?us-ascii?Q?f8Asi/BuaHI5ZbCPSmNJ6/MhRmwhhfniGmbgGCVHMghqXrRMQat6oOMBBZkz?=
 =?us-ascii?Q?MpveVSZsirCe6fJmNAljrNf3uyYQ9RQpcVhB6qUCHFYkVwXPEYOcNQszz8Jm?=
 =?us-ascii?Q?px9b/qLVIzz25XEurXOyu9gx86OTg6GsRKy9c1nCugodMLAv/NtqvOM5091t?=
 =?us-ascii?Q?ka2fahh+O67YFrYzSQhQ6nznSvr6p+DV0I6k0IEpW/HwUzhZhAuDihc/qtdB?=
 =?us-ascii?Q?acCDnbAplXhfQvpkSE2yKg0V8oBSfq+hgtKm6ogyhdtEu6zgNOJROnPahaHe?=
 =?us-ascii?Q?PqoMacyGcTVOFSKZiHCjzl6mJTW2B1WZGU0wHXPcnZXlSOf88Q=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf593b0-40b1-4f22-cab3-08d903180647
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 09:46:36.8027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BE3Pds+nebfcoaAzLQrkvZRpVcMvDNrAneZDak6IZItjx21vANLf8T8BTcxAJ2J9GAvvoYWfQaC9JUz3uxl0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4529
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_024639_967225_FB81133F 
X-CRM114-Status: GOOD (  13.40  )
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

On 2021/04/19 18:41, hch@infradead.org wrote:
> On Mon, Apr 19, 2021 at 09:35:37AM +0000, Damien Le Moal wrote:
>> This is only to avoid someone from running zoned-btrfs on top of dm-crypt.
>> Without this patch, mount will be OK and file data writes will also actually be
>> OK. But all reads will miserably fail... I would rather have this patch in than
>> deal with the "bug reports" about btrfs failing to read files. No ?
>>
>> Note that like you, I dislike having to add such code. But it was my oversight
>> when I worked on getting dm-crypt to work on zoned drives. Zone append was
>> overlooked at that time... My bad, really.
> 
> dm-crypt needs to stop pretending it supports zoned devices if it
> doesn't.  Note that dm-crypt could fairly trivially support zone append
> by doing the same kind of emulation that the sd driver does.

I am not so sure about the "trivial" but yes, it is feasible. Let me think about
something then. Whatever we do, performance with ZNS will no be great, for
sure... But for SMR HDDs, we likely will not notice any difference in performance.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

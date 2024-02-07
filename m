Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC006C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+hjwJqLKYpj6VLOICmLMu7pkZpwXilmFNimirfWDZ8=; b=vage2ZuCheMkMJ2UtbXd+jcKQf
	p5tRWCfe4IMsfBQmjMNOIYJBell5y8aw17/ColVggZ1WOxrwFvtJdfqoRMbG4JEuea+oRifCbAsNP
	s/YOFrbshvOyOVpMk78MtaQhpKm4qc/O6xD8vtyLZ8TVv1i/a4WCED2gzKQSDatn7KEemk2PfD3kG
	8LE6JVtlzWa0W2zMbt7Eo759oPCQC3fCY9jTuT3xoYZpZKr20waEzt/KpFycYxHdPr0Zhk9xjx7Ag
	C7mETb7s1/gVWUE+kT0d5d9nvopmO1jwC+6WEzOK89Ij/Q3XsKK/0hwTI3XgHwatZ9xvb07q8cSZG
	9kSpHT+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXeiJ-0000000AHlJ-1MZH;
	Wed, 07 Feb 2024 09:59:31 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXeiG-0000000AHjq-33MR
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 09:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707299968; x=1738835968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hea75PSghQ1auh6C1D/8OS8HPbDWt6gNMQjQOX+52eY=;
  b=lkWGWQUfn7UNzj2W1cceGE9dzNF5fLfZNNbSCDC+Dj2jX2ZnnNywGzr7
   yCgqj967/KIrqJq4NPHxfgRONMzOnRfWEMVVr+OOE0R0ze5842golw2ja
   gVdVbgh2FTuGyHT0L5UlVzK5qVMbUtQh7vHGQVxp1iZwxlAuZ0jg70m2S
   iRPdGzrRopWJ1W3hW/rl+o8q9YEGynrhMMR2jZDFkmVsCuU76bnpM5N/A
   /XYADO5kJbWukjOp2YarZ9nDi4vUC/ZLwM+8T2Thgi+8jtFKZYnC1T85d
   B14F+9Wc8vgrsSOf8feqmXM7a8K0lXNRtFGtB+MQ3x29w4ENgnEHpAZii
   A==;
X-CSE-ConnectionGUID: pwjG6S7YT56MZaprKK/phw==
X-CSE-MsgGUID: m6HWBGtoT0aI0zMlz3mxsQ==
X-IronPort-AV: E=Sophos;i="6.05,250,1701100800"; 
   d="scan'208";a="8946367"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2024 17:59:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlNJZJYu8N6zbwAZeKLtLrTR2JYpnkHv4JZvK8NCxNEpQi3arOQBOogWG0n+oPuTJWEfID/N694UFa/1ymz18hgP2pXJb7R6Ga2yd7gX+xW9jy5QJ7JLLvks5DM5fQ3CBdusP7Qak83e4PBjzmiY3TT/AgZJF+xKMgZlTyUB5GJ+0Jsp9bBJ8U9q5jHmTiviPrU8KU7I6Gw1EK/mu1acr/NR85q+S3Y0HhKZ9FKi05OrnV6Egn9nkV335+7YYrqkEGlCthDyIqEH8geY8gmmJsUbUYYR/pi3PJg3hjU7/h/jdvRnU5b0OckQjN+IlDo4RkNyvKg1cXAz+4ujc4sBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+hjwJqLKYpj6VLOICmLMu7pkZpwXilmFNimirfWDZ8=;
 b=LjWvoR26/tYZMt+WgOPpexX+c/Z3FAtVaRorYzVEQ2GwW7KDw9e+9cAq2ShijsvD3s0cwtxD9tODd2heSi4yGJ4Y5bumxHDGY7eRTtKpMOvEsvcCFADbH/56SSIRIqwurD8U1Zx+uX4fgGEJKz7dOZASxMQFN/QoXoVIh0ryNgn+Eh67fIxB3Q6WY7r89zJZaWAjd/IsBIMNsUTqEu/SLzPODgd0+R9gfP5iPkmaBa0YHVZSFMmejvekEVt7XNwdCE/ev/LlIv2HZyQnUjYXUULvgNXWxdaQPhVjJz280cWuHp4n/1gDCUPlc3XrP7taMucfPBCeRtTtgfRsNcd+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+hjwJqLKYpj6VLOICmLMu7pkZpwXilmFNimirfWDZ8=;
 b=xRRS8Y1Npy6vZnhKInrtt4YiUrzWQ5eXbi/3EQSpQfFxgQ7wGdfzmGGMgfH7O5kis15/pEMZaTfrUeO4xao//p6Td5Sfnve9k3uCxkaF0kZakp0dZJp3VtcIxhIbqtJTiYwaY7VbBbnU05YPL5+U/zYSv07PylH9Zkjg6aNU6pY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7187.namprd04.prod.outlook.com (2603:10b6:303:67::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.37; Wed, 7 Feb 2024 09:59:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 09:59:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 3/5] nvme/rc: do not issue warnings on cleanup
 when using fc transport
Thread-Topic: [PATCH blktests v1 3/5] nvme/rc: do not issue warnings on
 cleanup when using fc transport
Thread-Index: AQHaWP7M+MXXOXyOV0+lNfsRJSSllbD+pqoA
Date: Wed, 7 Feb 2024 09:59:24 +0000
Message-ID: <cn2hq3q7fdnded3abtvdt6lyoxh4774mouwnosh2bm4wiewzy6@llv246hqrlp5>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-4-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7187:EE_
x-ms-office365-filtering-correlation-id: c238607f-9389-46ec-d38a-08dc27c37711
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eSkp7PcvAPX2IdK9WVr9pZ4khaqsd4Ebw77jSNuhUgflBv8f3jN2uNspXdgVqA1mcAmbyjl5UJdCL6tW+DvxHywdkC91ePzrPZfgJ5jzcrbl8TeSqBXobeJSD6JvbKGuqRBvOBIrqOns4DZI3aDQMKovHjnGKduIbTUkn4W7Z9t+Mz98PUk3MuZbQJjhG2x8v2jEQSAtGhU/HyDLWpUiCQLY6+ugb5zSNhAfTz4g8AXv9UL+zp8eVMn2+HuUFALMfsK4SfetS0+U1yvDQWQO+cDY6O1PY14seadkfQlctn4UI3AaJBGwOj0PnihlXD+p1h7nfKlgpJbwRQMf5CDHM/wWscXCmFVF1h6XR82xdVoHIvxMzbPcVrjMPESOEd4wdi48ykqhgUb6ooMPNDqf1S7RJ0lL8z1OfkkQGzxe8hZM414UpjvyiKrG+HL2jHgB6ySXKZMnQZWFifPl0UK4udwvadaMdg3RG572X8JlmH8pmO0cGrwAoFvdkpMb2kQOeWiL32JfLtWBuH1Fnm5H5Iz3CQ5QF0nQ68myO3u16zef1rtA9iFWA4YFnLRLI9sNJmm7/2lHm4xGT8M814rAGqN+ErwuIBvH2shpxyH8Q8TnDHMKKNsqtY0o3pihmand
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(66946007)(6486002)(76116006)(64756008)(54906003)(6916009)(66556008)(66446008)(6506007)(9686003)(6512007)(66476007)(478600001)(71200400001)(4326008)(8936002)(8676002)(316002)(38070700009)(122000001)(82960400001)(38100700002)(26005)(86362001)(41300700001)(83380400001)(5660300002)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/35NP5VNZxk/yWfsJUcFYndlHtwUl+bpMTVcaCCDhaMC8875gqgQ58KwCZfV?=
 =?us-ascii?Q?rppKerox2IupqBcd4jrUYnSDq3YM9Aah7JOqsL8EEfslgUabqHcbwtbpG790?=
 =?us-ascii?Q?XP5ZFUTpHf1Z+Gw8JZ5WPydfuGM325snk4zLyqt1oqB20yYbY++B1FUUD6u8?=
 =?us-ascii?Q?W6noeVUdvFsAoxgXw9kzVDnw99sdHeXN1f/T6BbrLKLaiVeyPlyOuoxu/byy?=
 =?us-ascii?Q?GVutQNpUEsS/FBqvChaWG7Oj6bqqvh9Oe9xLB4wWqcn/w+I10hzLeLxJYq69?=
 =?us-ascii?Q?2IrtoP10HwEAJDVaaabtiVNypg6pneYo8/8b3tkS3dpa4fZ8ds7MMuLYOrJF?=
 =?us-ascii?Q?28dqoBxTg7Qv6YJyDZ5Y35eLwcsrOFKa5ZgI7pu1I5TajthaAsHsIaoHUNFw?=
 =?us-ascii?Q?Gik2GZH+DvQIEBzJpyoFliTg4qp5shAfhCSb9GcajNMKEYXW8/vkD0gpyAmF?=
 =?us-ascii?Q?vSpvr3f1fx3Ct+9as0uOix2tSl2sYL6nRP4K+8dsYspt8Zc7gqtlM3/KsHaY?=
 =?us-ascii?Q?IHY+kqr504Px/vmOdBw7mlHzBSQG+EHFU8JR2MPmp7GeQAQBQwdxW/iPn34w?=
 =?us-ascii?Q?I8o+uTtlsMFNiy1lZZdCmafFN6LuWzzuLqzUNdtTwSUPprpNtWeWHvD8girL?=
 =?us-ascii?Q?QSpff8jPnbgHHFEaYgBM3IiU68i5BLZVDRBKcNu3t8Ix5iX5D69JAQQDlc6N?=
 =?us-ascii?Q?AtShKwkRr4CfCILnw8XV+rTgH9Ycb0Ixz1JYsdMhEuIg1qDQnWI9znQ9LGvV?=
 =?us-ascii?Q?lYYCOe0zNgR0FDX7XREzP52fKI+CPa9gffN1RPbvaNe23S4P3pf+e6Tr25o1?=
 =?us-ascii?Q?lgqQdRt8yGGRtYHh4lBgw/hv9kHh29z4YR5re7Pjy6mvG3Dzc9mMzFeVl1Zl?=
 =?us-ascii?Q?fPKpYsl//rxmJ3eQFqMXJkyixExF714Obnu/NkCK1ZfLTLsVsdXCVvb3Xhti?=
 =?us-ascii?Q?rhK9SdOcKvC6YzeqssZGZk0S/DeSG9zYm/c8WUhZCv8GF9RM1ZxDF3V0Pj9G?=
 =?us-ascii?Q?XIoCuju2v98K96B5LjHRmHPLYXHCohtheFKMnZtu/ZmSKxRH92AUCQIkX+dX?=
 =?us-ascii?Q?GELowI2Q1VTfKM2CvbHr1+CZcctMxGC7sZCFDePaIRO2YvQEYGWuqcbMoPEM?=
 =?us-ascii?Q?SQKH6L5csAYDYr4jmK9zPaaBtMvR8M+iz9ft+A8VaJ6um8UOq987G8RJJQW8?=
 =?us-ascii?Q?wHvqDIzS6tiwQwVmqVgI9aP19mcHTQGPwmHUG0m6m4T/wUD5zZ6Q2Qrb3IuT?=
 =?us-ascii?Q?gGUIMf/42Ig6DgxTqwKgbFR6BkcPMgWDwvetGzMFQCXICE0ccviKtLPxP2Q0?=
 =?us-ascii?Q?yuR8ZNJw8l7fuPyEcKAXATIBlj+WiSHLL4GrEnm9zCLV+aFeJvcMdsXqTHLi?=
 =?us-ascii?Q?V4xdKF4nC0qKHDDBm9Hv2Jalmprcx/vAPS20B2aAcyYXAs3yff8E/fr05QHu?=
 =?us-ascii?Q?MupPuphSf+JN4VXqY0LKW8VRLZLSUTkORYgEJUpxI5cVVw5AD5BSHKvgTeUR?=
 =?us-ascii?Q?UV9rJ50pV+J6o5jBXFOujLnreQgZnnOzhLxyeBOqM5NXiqOP9ThefC52mcZI?=
 =?us-ascii?Q?5CVRrtFvhWukK2WSkAB4QYslVnXo+N6asnJRrVJLr5y9WeYOzAKD8uuyto8A?=
 =?us-ascii?Q?cwUzFxCe3+9RkTPh98jDAZ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <472EEE3CA5C2C74F9D823976FD3AB138@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RXY5zfyZy+qC/oKzulonps8ykUsVDi9jWtfiqCN2Ar1Z2m5r01aR3qPjh4lGTlltDIudvKzGxemQIXYvtIOuiqYSxys/1hnwTErEq/gmP4jmNEZNOLHiupiQdf13ofYRYvnmzqYFXk5jbNqcZUAjP7F0hs3k5YSx7RhCUeYgYh62wYUieWWYRWHqFgIlv5R+G7sPR3h98t+sUClBpq+dxJAmKpRiEd3sqaLht6vdENFRd4h2HNbNUoCcZLBFcr0Hc7HWvgTLaq2a+JSvgnb3hwzb+XT2bQTSisQJAN4iHpEEBXceEkdvHFSXdPA3dI0oAhNUlUdZiaEN8IBstiOiJEbpvYAMP8+37vZjQgY9ZkoPOxQllcrcU9acknTPqu1K4GTauxzj0LoXES+FgwX09brMycOQKr76GItdEcBXRBJ3PNaVQaJZGigzuHQaA9+HdHNzNr+cOE11NY2rtDbned8+emda4DiB88CasvgEyenAOdyD54IZLt23FlnJz6mn0XKgKgov7dhmPKjPQ5zRtYNpClELrk0POCpMEf/FZJKbncLNIVGyjxhbbt/Uy/lKs7ZKPShpNHamadZIj0YN3NLK3IiWhJ0AUCdAsRsWqyMz9nQxHNdf6riE6NQp3ZQ0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c238607f-9389-46ec-d38a-08dc27c37711
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 09:59:24.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PQd80gQg9uotQJqMSNbAiWRSJyAr2ymHXIc9sAITWGq6xmPe+NUhGCy1WdJ7uxbELlv2ZVQbNrGPL+BPDNqhh9+G34p2HqokOhHc4Sh5XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7187
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_015928_804588_DBED5B77 
X-CRM114-Status: GOOD (  20.71  )
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

On Feb 06, 2024 / 14:16, Daniel Wagner wrote:
> When running the tests with FC as transport and the udev auto connect
> enabled, discovery controllers are created and destroys while the tests

Same comment as the previous patch: s/destroys/destroyed/

> are running.
>=20
> The cleanup code expects that all devices are under blktetsts control,

s/blktetsts/blktests/

> but this isn't the case. So just disable the warning as it is reporting
> a lot of false positives.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 9cc83afe0668..ca6a284a1e25 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -352,7 +352,10 @@ _cleanup_nvmet() {
>  		dev=3D"$(basename "$dev")"
>  		transport=3D"$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
>  		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then
> -			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
> +			# if udev auto connect is enabled for FC we get false positives
> +			if [[ "$transport" !=3D "fc" ]]; then
> +				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
> +			fi
>  			_nvme_disconnect_ctrl "${dev}"
>  		fi
>  	done
> --=20
> 2.43.0
> =


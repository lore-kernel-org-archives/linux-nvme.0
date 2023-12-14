Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A611C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UbwLnoTpzNGSMrdt/cQQqVkou15qoKEWNqpJ1/x/EdA=; b=oGgBsAbmpAwnN4p0RL0ORO+yp7
	bvRnoykKjnjfMCwYp32Jc2UUM0AcVmyqoXS0Vv8YJu6tEtX3+rY4/kkooeYOqY5ruCVba/EdlfFUU
	R2iCW1X+aJZlmOBTnvIgI58saN6oBdI/K2HCo0qWlSuRPgWsc+jV63PbdxSA8ei7oNuHC7V3MpgUR
	JEQ3Dkbkv9qbNmDWR9bNrdza7LiZfm8eX45hDRcy/QGb9J+HasVlm9sCHnsRbot5k/v/RTiu/NtkT
	aVXIMAlB/TKuObzfbyWGUmutl5zuqG1W2vdcCIe7ieh84ZvsoKz5WbMH1vtOzWBX2XivWVJqFOCPD
	mqLVmlrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDmEP-000UQM-22;
	Thu, 14 Dec 2023 13:58:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDmEM-000UPT-1r
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 13:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702562306; x=1734098306;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=dqv6mwYLsRE7qoqAaDfx+wi/6JVrJTaVfN2KtI0v4kY=;
  b=IBnz/Sn35MLLOWAPUpyevb6AyXiyAbt7NLcedDrMSKHi+UWhbvOSgsl+
   9hf2UMd0bFP83VQ7qqO2iY/KZcZIao3AUNQoCZe9Maw+IKIPb4DyUk7gf
   mNJUDzkq6xJTapMyTY3TSHUEMVdUhS8jOEejpeMk3jAVqTyl6jLpnWWtx
   hLx72gDBw31OUsL8DuGz/cZpAk54uqwi+QA5bAlxS63bFSSaCRXrunLMA
   HA0fN21a7IwRke+ZjacmIhUKbvKTybBxRSjVKnOgU3EbAUDOR82WPG5XD
   TwG4hRQ1Iok8gOWKvay/fIRIgcz7CypjAF766JanK5KiMBjSKaqKBxk6e
   Q==;
X-CSE-ConnectionGUID: YDHGa/u7RtCQ01fmDhIw2w==
X-CSE-MsgGUID: AXYjH+62Q0eJIVZmamPM6A==
X-IronPort-AV: E=Sophos;i="6.04,275,1695657600"; 
   d="scan'208";a="4817793"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2023 21:56:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjo4I4fkFEU9sqwyB9AqxIlSSfFb1RVkcnBW9ZUWUKp3HL0TqjJ6EVcshGLW+xZhMCI0FEnl++nD64X0gDFHWT/mHcUAyk+Tm1Fv+JOW1HAmfUGNQv1+yXpIETBgYieEJ/BlJ9f897T5KAZ2eyAhaIVx9dXw2HCJZu2t4pbE3EvCbSLJqRZRnOPerE66B/dic32unXvdaB83qh4yc8MVOFJPnsuT0ZN70FoBjcMsDdh9CryaHo9Xrk3P/WT+k9RHnhRJP2KTJv4DlMMxuykwAnYW+hZJzP6QPEKr7XPEvHzLgTUb6e3GNO9RjatWloENCtojXifDvRoRo+zWT3/5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbwLnoTpzNGSMrdt/cQQqVkou15qoKEWNqpJ1/x/EdA=;
 b=STPHtYa+Viz3enHzf3WSH5CoqmzipMliAGKJuaZKYAqJOAHnAfQohdsqdUTasGCZjixr1n2f+jjgw1gYo1u02Ncmhantzo6BUGQTrec6fdDAkdC8Tp5tzMtrkcB+NYmHxR4D/SKYeoqBx7pfpOeTJdGKkA0YbbMZvcsh3qbKOpAbEbFN7ChZ2u+jfqw8Lck3AF1IiU1rjMiuLztzu4Uuv9Lvz/G5Eb9imzuSeRBE8rNdMv/yew8Q2jmn8jqEJrTrrfuNCg57LtDBZHpHKXfLBiqjwk/hnDlMflcfwo9SgguaTU8idF1Bdhsnl5WQ6gnBzCY87UeUi56tGINxKG+PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbwLnoTpzNGSMrdt/cQQqVkou15qoKEWNqpJ1/x/EdA=;
 b=LJoSWVAa18uAm/ubqvm7UKXyymu/YDr5tMvfKPlR36TtQ6ePduw0muvXIeVMk22AH8YPrjNSuuonwZwKhd8MMNTmJ4Z8w25dUiqZtD37FYyiXDChKypnpG3JuY2qsM+dJ4NuJ7G1BzLHRcR8BwS9XNaqPG4SYjoKXfjrZWn8HbE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN0PR04MB8096.namprd04.prod.outlook.com (2603:10b6:408:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:56:05 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:56:05 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: parallel nvme format
Thread-Topic: parallel nvme format
Thread-Index: AQHaLpVHqt1AbKF3cUaSa/U7/bTugQ==
Date: Thu, 14 Dec 2023 13:56:05 +0000
Message-ID: <ZXsJdJxDXEbCmSec@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN0PR04MB8096:EE_
x-ms-office365-filtering-correlation-id: 9e27c3a0-db6a-477b-fd0e-08dbfcac6a68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqesI86R0CwMQnyRcqHYgjv0ysZ1FtfrFyOqxHgwKmMsekN1gVXlI0Yt97BUjnfGwx6ByU1bIywC5FemQ6/ux+LnHbIqs/dUk/te+8Q4nm0h+rooZdWXC9Oeu1DS7WD1N0PZeUz3I+8WCuEMJ6MvPWsUE94d2L6Uqeq3B6NSS6OMLDcN4mXO7SdZSpH9jL3LQsqi8sJal5Csgjcgy3FWUr2YthBC85PUKx4huET20zZZfbAh7LhvSbktbQXnFTKpFkcf56UMVMbnjpYGyDk9K05LtMwpLy7giHgLTjz7RpUSUjixruQwvHrKdF5Au6eWOgj+2JPJ4b6OjqWlHhNsSyl6d4L/BTd4kMWQzMM+UlSS34jLWxf3u56Y8hAxFUzUlrW+SQn+0L7X5mIlvJdfdSIFiKqATqcUDPxrq9Lhg9oVPK8405isz649nW0rEOHD1UlJBaVuvLMhPTTEFmp3oCCI5IEAVCEjHUcrb4EagQZfJv6Lc2yj8y+ZdqWoqKNwslrwp09FoMKe+UTgYynxeYl1Vp1QWhWy4NT+HkU8hFvBvvwQwbhBLctPf0o/7fu27ducA2BnK6iAGO6TJBv15sf6iz9JD/NM6avszMA2LExaGLEF16yEKNYji//7a0t1d2OxietkpfYtX9dhem7eLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(6512007)(9686003)(6486002)(76116006)(66446008)(122000001)(64756008)(54906003)(6916009)(66476007)(66556008)(66946007)(38100700002)(91956017)(3480700007)(71200400001)(82960400001)(26005)(83380400001)(6506007)(7116003)(316002)(8676002)(4326008)(8936002)(86362001)(2906002)(33716001)(41300700001)(5660300002)(38070700009)(133083001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xobX+6n4aWPsYFnn5bUINolUQmSxGajw9aYA5b/6P7WIOp+AMVwspfSHJvut?=
 =?us-ascii?Q?r0Rb33yM0XbnZrfm43afl8Ub9lX0M8z2XgYEgcNtbFKTFalYtyW9qXAX/ERG?=
 =?us-ascii?Q?iNulz9Ms8pbnXMhWOkU0A0369MPPiwvGwQZ1E28QdzKbIGimrMpRuf70U+GN?=
 =?us-ascii?Q?5KrfqOlovmFz7pGZiMtqlRugYfQriastnQgVLAB4igeTFgCDYajNsGB3prev?=
 =?us-ascii?Q?IWw2TN+qJeyer87oSClefWi1B1rxcS6jP9A4eT/DU0LnpRky5khgbsDE3iQw?=
 =?us-ascii?Q?NSfeOlBEqt9JyNiina10kyy7y1A86xcdlP0rW/OZyrzgLvDyLzMwBoOP6bW7?=
 =?us-ascii?Q?n5Izx8shC8LVsrhBYjSYV2a6mIgSb7GKjkRdbo9PeQj9+t7P/pnC2rD62eTK?=
 =?us-ascii?Q?emr+fxalHyJGBaCZMl0hvB1xyNZDQMnN9I8LXpIiKpyP5qSzqDMA9X68V/TI?=
 =?us-ascii?Q?tMSU+8lnDoqT9wd2TNUq99GnwUSQncQEq3WnPdtR4al+8UWH5Vkk0D4SmbB6?=
 =?us-ascii?Q?VqZ8euoUXIwWJbim7DqSbz632yndhVm3CbxA7vlDIEj2deZm2hzuE/Xztsp0?=
 =?us-ascii?Q?+csEbE8XloFf9GHZHk352yBsYdrqJahzosW6OTypkEs7F63vzKgxkuFXE5Wh?=
 =?us-ascii?Q?n8tXXAKu7kDUssuANBxEcPH0YZSZ0wPniuQwBVL76yADGn0tSHsryelM5B/s?=
 =?us-ascii?Q?jqXXWU8g9iRs8F0Gogte/LdD/+5p+Ayl1/DeUUJHANKT9QBhedXdDWYJZ0pY?=
 =?us-ascii?Q?xjT5sIB7FHGQDUl+j52ZG5dQ1ehbXx+ePHuFSsMFASD/hS/1Z6RY+BnxbOoz?=
 =?us-ascii?Q?SvYduWv5V3iqdOjXTnichdhnFF22ldMJJ2jI3eG7/59FOUiL0FRPKf+Am887?=
 =?us-ascii?Q?1NC5/yXH4SUlVLBenjvIVeEkOpjSJyriCll1vqkdyMRSpgAk9VuOJxHVyXSl?=
 =?us-ascii?Q?vJIUA9dolPBQrkR7u3fxEp94HHkjeeen21g5SLbGv1OLi5qY3Y79+7XK42wB?=
 =?us-ascii?Q?pkOd3CeojuTau7MptDgObJHx4f8gbAFwYsquqQO0FhApHn0cl1oA7CbMzLbK?=
 =?us-ascii?Q?3XrnynfGk8C0FqY7sxeBd9HRxTz6qfklXtXVpNhpAV7hJQ0sjXnLoc0hKkL4?=
 =?us-ascii?Q?ey2PG7mwv3A+F6bEGyuCFZQUivbynjYDyfZiombLu2+PRvG29w9mxZmpQSc0?=
 =?us-ascii?Q?u7FCG42P1NbWT2AGDxOl1bSSdfJVUTzfYG4ogp7mFcAmnqwFhDXyBajwltqy?=
 =?us-ascii?Q?ZLPZc/OlZ9OGpG4T5pytx7ae3aXjrlX5COP3VCl6JmAzRT3yqMNc7A4gBFAq?=
 =?us-ascii?Q?DHZaeXSxoSSoPD4yWDMDpwhivg038r3Xy88HJGbNVvuyJs/CDuF9SJzlej7k?=
 =?us-ascii?Q?zC7ZYZCtT7rQ8Q1fPTGu9UwCNH3l+hqbvFQtGi/pxm8r7iFJ5fhLswszQphh?=
 =?us-ascii?Q?Y7bN8KRP/aEk3UEnVxiMkDM+R9IhXjvpC/qOUPYTL60vaB5zKfvs5zpqLkIr?=
 =?us-ascii?Q?4g5b62oQPbTmXKY6M7nO7v5oiknhwYgRQNFQ7eup+n9u4RE5WWmLkcHFWs3W?=
 =?us-ascii?Q?2yzMPYFuXhq/iHzv86G5KE6MElbaXvn7Ey0qj7+qU+Hu9QiMtmwZ/MJpnx51?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D083FF8B1D60C4A96E5425F70295D78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oZ8cPggfzbXX7u1UZ2NITgVNg7JAR+X4ClHz5nUrxMe55zquP+BhwPWUZyKrlilji50jfosgmF4i26xD9ldrBY3kCWvbRUInerGUf4KNxH45zh3VV9ql9J+Wtt9sLfuoN/GHZHCbpGh8daUF79vW0XV0qvk35N45rZb/g+KbOEQI3k4kZqxp2fNCFLxZAM/HpGAPhUnY9Ns/L4yPBf1g4dSRT1Zgo11kKLtaASygD2GLwj7YdOq+Az9FyFy4H06UhUbXsHTV5x/iNajQpM+gk26M4GCFkh2fY9OJt9BM2NgDk1KeBCuZgfBWpUWb6cLvE6SYyxzZJbbzymmjLItNVgKnG96GHSdP/VZGurbVaR4BN+375355XQNLYakuP8y8wHWW/kGnYa5ENChb6HkBwfdd+DpRUICmqqxL+EOel7KxuLU6Jhwwl6vmqg1C6eqUrSSbg+bnM4BzgQqMb+dBrn5tWRzJFJmMcVTe+LAjTWS5h1TNMauhRj/459a9MZ3VYhVMitfaOcM1vzghbh/nlJGg+NDBgismr4yEa3NWmptkpKxiWkenYzSx1MeWRELNjKSMBtWazu+WWgH/rVQUlbtzQB3eUVKewxOiIky/Cw/vQNYU++JCjYMcA7WgpzLb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e27c3a0-db6a-477b-fd0e-08dbfcac6a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 13:56:05.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yv7U72q9UIotMYRNtNHNfHR9uXq78Szg3xsy7r0N8Ztgy073+Hh8Gv2Tbk4Te1K+/ulhVd85MpQwOStFRFQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_055826_684983_E3747B5A 
X-CRM114-Status: GOOD (  16.51  )
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

Hello guys,

We have observed the following on linux stable v6.6.x.

(We tried to backport commit 839a40d1e730 ("nvme: fix deadlock between rese=
t
and scan"), but it didn't fix the problem.)


What happens is that we are formatting 8 different namespaces in parallel.

[Wed Nov 29 16:43:56 2023] INFO: task nvme:18411 blocked for more than 120 =
seconds.
[Wed Nov 29 16:43:56 2023]       Not tainted 6.6.2 #1
[Wed Nov 29 16:43:56 2023] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s"
+disables this message.
[Wed Nov 29 16:43:56 2023] task:nvme            state:D stack:0     pid:184=
11
+ppid:18405  flags:0x00004000
[Wed Nov 29 16:43:56 2023] Call Trace:
[Wed Nov 29 16:43:56 2023]  <TASK>
[Wed Nov 29 16:43:56 2023]  __schedule+0x34a/0xef0
[Wed Nov 29 16:43:56 2023]  ? preempt_count_add+0x7c/0xc0
[Wed Nov 29 16:43:56 2023]  ? _raw_spin_lock_irqsave+0x29/0x60
[Wed Nov 29 16:43:56 2023]  schedule+0x6b/0xf0
[Wed Nov 29 16:43:56 2023]  schedule_timeout+0x233/0x290
[Wed Nov 29 16:43:56 2023]  ? __timer_delete_sync+0x31/0x50  =20
[Wed Nov 29 16:43:56 2023]  ? schedule_timeout+0x1a3/0x290
[Wed Nov 29 16:43:56 2023]  wait_for_completion+0x8b/0x140
[Wed Nov 29 16:43:56 2023]  __flush_work+0x139/0x240
[Wed Nov 29 16:43:56 2023]  ? __pfx_wq_barrier_func+0x10/0x10
[Wed Nov 29 16:43:56 2023]  flush_work+0x10/0x20
[Wed Nov 29 16:43:56 2023]  nvme_passthru_end+0x60/0x170 [nvme_core]
[Wed Nov 29 16:43:56 2023]  nvme_submit_user_cmd+0x162/0x170 [nvme_core]
[Wed Nov 29 16:43:56 2023]  nvme_user_cmd.constprop.0+0x156/0x1d0 [nvme_cor=
e]
[Wed Nov 29 16:43:56 2023]  nvme_dev_ioctl+0x12c/0x2a0 [nvme_core]
[Wed Nov 29 16:43:56 2023]  __x64_sys_ioctl+0x95/0xd0
[Wed Nov 29 16:43:56 2023]  do_syscall_64+0x38/0x90
[Wed Nov 29 16:43:56 2023]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

flush_work() waits for more that 120 seconds on scan_work getting completed=
,
but even after 120 seconds, scan_work hasn't completed.

Inspecting nvme_scan_work(), the only thing that can cause it to not return
after 120 seconds, is if it is waiting on mutex_lock() to get the scan mute=
x.


What appears to be happening is:

format command #1 completes and calls nvme_passthru_end(),
nvme_passthru_end() calls:

mutex_unlock(&ctrl->scan_lock);
...
nvme_queue_scan(ctrl);
flush_work(&ctrl->scan_work);


Directly after format command #1 unlocks the mutex,
format command #2 will get the mutex in nvme_passthru_start().

Format command #2 will release the mutex in nvme_passthru_end(),
but only after the format command has completed.

The default timeout for the nvme format command via nvme-cli is 600 seconds=
,
so it is easy to imagine that the format command will take longer than 120
seconds.


So the scan work at the end of format command #1 will eventually get to run=
,
but only after the second nvme format command has completed.
(nvme_queue_scan() will finally be able to get the mutex, once
nvme_passthru_end() for the second format command has released the mutex.)


I don't think that formatting multiple namespaces in parallel is an
unreasonable thing to do, so I do not think that we should scare our
users with "hung task timeouts".



My first though was that perhaps we could do something like:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46a4c9c5ea96..811d40cf23f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1113,6 +1113,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struc=
t nvme_ns *ns, u8 opcode)
         * effects say only one namespace is affected.
         */
        if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
+               flush_work(&ctrl->scan_work);
                mutex_lock(&ctrl->scan_lock);
                mutex_lock(&ctrl->subsys->lock);
                nvme_mpath_start_freeze(ctrl->subsys);


But that will not work, because it will still have a race window between th=
e
time nvme_passthru_end() has unlocked the mutex, and before
nvme_passthru_end() has queued the scan work.

I guess, in the case that nvme_passthru_end() has to perform a scan, we wan=
t
to unlock the scan mutex after nvme_passthru_end() has performed the scan,
but right now nvme_queue_scan() will acquire the mutex (and is running on t=
he
workqueue)...

Thoughts?


Kind regards,
Niklas=


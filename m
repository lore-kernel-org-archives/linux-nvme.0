Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B78C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 22:25:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B91619C2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 22:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B91619C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gzm62gNyE/M52nMucN0dJTxvgE5f6bye5Bldh5DYAR0=; b=KkYH1Z5bVydAKlkInewWyxmLBH
	NvIeGylAfQLsaZgawWsUDsvNFyz6/gnpAffdzOxcaswBQfOA9xGHFvk2ZEJ0eJYsGbdnYtn89my+L
	KBDtNw7bqpPDBqCOwXZ6hMuVDEDyEMHg7wxjJzbbA1UJkggYzlpFyHShZgugOpdbCGPRIoG+1UWlq
	boorSuvwn7GvMx9Hvnhf9pCZoimadw6dCduMDEMU7N3YsO9xvLqZapPNHOj91etsTQk9Nu2ZxQa1u
	MhU0EgjPTmU2h59WsrHgBhSRdWsyhWbEuZHrOSLsfJTUNcGAsBGPgj+vMi4b8ZiYniYWn1nXoDtDD
	DcUIAG0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOpSk-00FrdU-17; Tue, 23 Mar 2021 22:25:22 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOpSZ-00Frac-Qt
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 22:25:17 +0000
IronPort-SDR: NfK9avnBO4DstT1jtLIPRLg5iamEErb5KyyC8v9cKk8lz/F+AfOSbOLWW9oXXz85L5y/OXjfyP
 m/bu5ELKHILg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="254578121"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="254578121"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2021 15:25:05 -0700
IronPort-SDR: HpZor3OYOk0vlxMMI2AzqeAiG+NEWZiU7YkUzI8M50wRD9KXASzCsZhL4AT73zinu843BCfJCL
 E7rd+iKReC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="452324996"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga001.jf.intel.com with ESMTP; 23 Mar 2021 15:25:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 15:25:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 15:25:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 15:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/qp7dXTWXgQ3rvQTE/ybYrmdBISMuvMLEeYgyJoV18ve+QMr/uG6TKBw161tf/WkxRXWGR1nx/IpLvBOWHDTHdhm/A3eihZg9qXHT6rY9VCMaQam6F3oReBqy+z+Si5dTbwctOeVVxuoDKGusYIMBCdBqsrzPvQl/cjZw07ZF1dvrtnT7tLRP6hgvc4HLGAw7KvfW0bIgren2JmhPj3SXYqvIXmgKZoAeF5rDsrx4XeL6AMeNcd890iICvWgQvzXQ7L5JKh6oILta1+gszMeMSPBH5lSRmbJh9FHQYAdMoa1V9VY/wd5wCti4J2eJC38sAV2b63NhUk4cBRZFj3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUTVcsmjK5slOv98qBjkQhDpiyD399cTBPQNRfLAK9I=;
 b=cNZfr6OPJ36HV9aQ6Ur6mewJdscpvzaYxjMmbLOhnzTECG/NesWBrGSXfCd3yjq2zFNixj2shiBm6ANfo2O7H/y3OY8lFxsu0ttwLFla3Guc9fIGjUimx25KiWNIbamxvMO8UkekqBAC0fX9VvAi/PzaDVMQzBia0v81zK7D3UQP0PB/UnRfO5rROcTED9oTpdx93m/yfgCy9Dy99fWwgmx1CJUl267NCSwb4EAWvPun3+fENMQRDMcLpS6yJR+tXiGS3oYrMa7mwAX+AhZd78SFX/+Ylx0d0WVRB+HVZEJzRvdmLqUD7BFAOkpbgHU0PTafRsAm31DDyYfAMrSlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUTVcsmjK5slOv98qBjkQhDpiyD399cTBPQNRfLAK9I=;
 b=UptBC4wKJr8MyBKQBStuTOumT1klBpQMKADgiwu4clHD38pLiXRufTAouJwpIQPIsXgcb5eb28acvHBVjqt4HNmCMqyjQ7zUk4EyNmCm+fnJSa+SIAyF3wp+sJXBZ4arsQDuMZPsiBuEALkOfbfxQJtjAvt3vLhiEHVMkCBc5XA=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 22:25:03 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::9446:b8f4:d289:b20e]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::9446:b8f4:d289:b20e%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 22:25:03 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V3] nvmet-tcp: enable optional queue idle period tracking
Thread-Topic: [PATCH V3] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: AdcgMxeZH4Dg4aoYRB25z/zCrbqkow==
Date: Tue, 23 Mar 2021 22:25:03 +0000
Message-ID: <BYAPR11MB2869C572ECE86BF9CBF7F649E5649@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [67.171.162.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd4eb4aa-2708-4702-d459-08d8ee4a8139
x-ms-traffictypediagnostic: SJ0PR11MB4831:
x-microsoft-antispam-prvs: <SJ0PR11MB48317352D33AD1F1F784E969E5649@SJ0PR11MB4831.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpyIQANncrja1R25z6kYOxncZ8IrPWpqQ/Enm4sLRIKJlyCZy96WrTsbEc1oND5Up/DSVtu7SXdt3YLEkZvublYRkKL3Odd9/aZ6AQPz+wJ+q4tlrznceJxIGoHdZ6+jfq2mQs1JG8+IKuipm4zf94U94TvW/NNqe8jJi5Qj7mpOJmVu/VGJBuJtp6uEyvCFbNbffdQexhTSEcGT5yh+MWpWIseQYlT6Gn7AAn8YvXbVfD9E/onqg9Sbj8p1NxQSJ6oFyFyK2sIzF/wmr1GASMjBNjKka0R95ts+Ip2orxp8FwdXoZrUcJL8hPa+JQpfZZVkQrIeWr9N16A7ItjjvjS4LgYrZlyvUevHSLBuhOhBuHe24z1hQUaTnkxpKu2B78Lphy1QmKngTBn0XfBUN5mUiiwkH3m1ODCfwHc7cVJZzTGpGQlmQozbYCHsLsvOROhsjdB6x0PbpEMaHgt1daPvGV8IhDpnpH8m3cVDXcGY8mmCQ9sF+5tpJf4qzHO/LJjub+6VA8bLwpaxr3HEwoH8NJeN497tWVDBAmSESuHaabT1YAvZfJS53eDFNtNdFCZAsmgt5dZGQAqp0rTk6Rrqtpui7nDPCtXzpzAt4HZIrgkBlXrIdI3eClucFdR3oYecAntmBs0siRbGZZ9YIXLLU4VOU9glTwC8o5E23j0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(6916009)(7696005)(55016002)(4326008)(9686003)(478600001)(8936002)(83380400001)(5660300002)(76116006)(186003)(66556008)(52536014)(38100700001)(66946007)(64756008)(66476007)(86362001)(26005)(33656002)(71200400001)(66446008)(6506007)(316002)(2906002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FeJ/fNxFLQCo8jhDQwUBPFPt+Px4PxdZ1d4ZvfsAz2k9RBiCw/K3Jq7bHFbx?=
 =?us-ascii?Q?s0FIsnYj2GErloQ84lpAhR9SHAEMxrQTIutR+bDINy61vV3ga0Wykxy9Vkaw?=
 =?us-ascii?Q?BylLHkOulLm53zinh0Xu2abxSn1vWnSgm7+XmaaZPrR+jE5kHLfhyWS/hnXM?=
 =?us-ascii?Q?F9EiA7yn2x3x9YxxUyW2PHWKG37zI66B8Y8MmU0+OyXJLcaSiZmBJbi1IzaL?=
 =?us-ascii?Q?D+DcDQ4zbZWIV74ZsUmUpampPBsRX7OHlqmtvabepwqNvrqidwNd8p4tSbk6?=
 =?us-ascii?Q?J6RBoCq2DfM51Mhpm/nz20cLq1hRnhMpBrrvxMAfLogDRV7Bmw4lK2YI0YCo?=
 =?us-ascii?Q?2U56hcRdiCWKhbg1inohSTfk9/3sGg0rlF2Yrrh+bci6AiT0kGC7lCCLLg+9?=
 =?us-ascii?Q?4hddxVAVrWCAqs7QciBcDIB9a/QxVVbc31NfJjP/nU+AvcwyqBRdKsg8OsSR?=
 =?us-ascii?Q?Vk2+lcP09H2TWrwy2v4e3ZDgNw8iuIfP2TuchuPZDjvyHGNJpbLhpwM+n2pj?=
 =?us-ascii?Q?U2IRXmZi4GG4SXjHkmObd3bQZfmj0JE8DYdGtH3vQnLNLWaInQbKj1vUoYJU?=
 =?us-ascii?Q?fgXKPseBvFXz44+Oc8hkFRBLhk8EfqXq19cf8nugveTbxgqHwltKJGyqqA2t?=
 =?us-ascii?Q?WvPTHmgjgQUMn0uZ1LJJZ7Bbwosw0dwFIeFDawz70jI0EDRX0EzCU8AB/eSZ?=
 =?us-ascii?Q?CXlgwC7Q0fuV0KMg/Je/kUDDOCTzELjpqREeRoF5OGoeMpPr+MUHG5Vd0MBG?=
 =?us-ascii?Q?4WZtHmzZDSwUKoTufXTOP5O9SrWckIKxEvXvx5foRSl6Y5qFgLOuo5fC+sm4?=
 =?us-ascii?Q?ja3VmEsPwnoQ9DekGEuvf3T3QhSWDP4nxcU9zRac41rsTpowvDF+u1Ys5eni?=
 =?us-ascii?Q?mGbcRjR2oP64qC5pBZhDAqEhRI6Y6FrJf64+M8g/uW3rTGRwQ9yAPjK23LBD?=
 =?us-ascii?Q?ylfDwO7dZoUthnrrVy8z9EJyyfAlwQIjAJRYh189XNUV/ShhA/rdjVcuHMNQ?=
 =?us-ascii?Q?48EG+1mM/iZOzt3uPOEWz3nCL8i8uKyT/76L6o7KQ8h+JeCksw14+c8jJJbA?=
 =?us-ascii?Q?G8YzQoeoRvJQ5NRymD0O210v2ilrIaB/sSvr3G9xuJ6UsfSEiJzACKkvfMQI?=
 =?us-ascii?Q?FGoFiMehCsUTkyOSdfieMFvV9R1oWOzExEQ8vdOemraZGxsJkHddPKZvotpR?=
 =?us-ascii?Q?tkzGaQ4MsJBlPMkzS++Me7Gj9nXCy6YngJzRXtXcZ3AW1MfDdx6pJJMCqq4j?=
 =?us-ascii?Q?u7RX/ZeSKP9kIveYdAbTGszCY5Su9AegVc7mbQtWKC/nDlTZT5sOBrizukZS?=
 =?us-ascii?Q?zxcsnW5nJ0+l9GMBBQhAqXE/?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4eb4aa-2708-4702-d459-08d8ee4a8139
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 22:25:03.5316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /inuKf2QbTsaJuGzB0aJlOh5q6A0G4AItisMA1LTVYsEGjaAvbYoQ2qlvPt/G+3GQlNWWamai1Bno0EngMxoaBhFp95YiOI1F5m1dGVgMGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_222513_472280_E88FC5EA 
X-CRM114-Status: GOOD (  23.27  )
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

nvmet-tcp: enable optional queue idle period tracking

Add 'idle_poll_period_usecs' option used by io_work() to support
network devices enabled with advanced interrupt moderation
supporting a relaxed interrupt model. It was discovered that
such a NIC used on the target was unable to support initiator
connection establishment, caused by the existing io_work()
flow that immediately exits after a loop with no activity and
does not re-queue itself.

With this new option a queue is assigned a period of time
that no activity must occur in order to become 'idle'.  Until
the queue is idle the work item is requeued.

The new module option is defined as changeable making it
flexible for testing purposes.

The pre-existing legacy behavior is preserved when no module option
for idle_poll_period_usecs is specified.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
V2 of this patch removes the accounting of time deducted from the
idle deadline time period only during io_work activity.  The result
is a more simple solution, only requiring the selection of a
sufficient optional time period that will catch any non-idle activity
to keep a queue active.

Testing was performed with a NIC using standard HW interrupt mode, with
and without the new module option enabled.  No measurable performance
drop was seen when the patch wsa applied and the new option specified
or not.  A side effect of a standard NIC using the new option
will reduce the context switch rate.  We measured a drop from roughly
90K to less than 300 (for 32 active connections).

For a NIC using a passive advanced interrupt moderation policy, it was
then successfully able to achieve and maintain active connections with
the target.
---
V3 of this patch provides a bit more simplification, pulling the
tracking code out of io_work and into two support functions.  Now a
single test made after the process loop in io_work to determine if
optional idle tracking is active or not.  The base logic of idle tracking
used as condition to re-queue worker remains the same.
---
 drivers/nvme/target/tcp.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..0e86115af9f4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -29,6 +29,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
 
+/* Define a time period (in usecs) that io_work() shall sample an activated
+ * queue before determining it to be idle.  This optional module behavior
+ * can enable NIC solutions that support socket optimized packet processing
+ * using advanced interrupt moderation techniques.
+ */
+static int idle_poll_period_usecs;
+module_param(idle_poll_period_usecs, int, 0644);
+MODULE_PARM_DESC(idle_poll_period_usecs,
+		"nvmet tcp io_work poll till idle time period in usecs");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -119,6 +129,9 @@ struct nvmet_tcp_queue {
 	struct ahash_request	*snd_hash;
 	struct ahash_request	*rcv_hash;
 
+	unsigned long		poll_start;
+	unsigned long		poll_end;
+
 	spinlock_t		state_lock;
 	enum nvmet_tcp_queue_state state;
 
@@ -1198,11 +1211,34 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_unlock(&queue->state_lock);
 }
 
+static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
+{
+	queue->poll_start = jiffies;
+	queue->poll_end = queue->poll_start +
+			usecs_to_jiffies(idle_poll_period_usecs);
+}
+
+static bool nvmet_tcp_check_queue_deadline(struct nvmet_tcp_queue *queue,
+		int ops)
+{
+	if (!idle_poll_period_usecs)
+		return false;
+
+	if (ops || !queue->poll_start)
+		nvmet_tcp_arm_queue_deadline(queue);
+
+	if (!time_in_range(jiffies, queue->poll_start, queue->poll_end)) {
+		queue->poll_start = queue->poll_end = 0;
+		return false;
+	}
+	return true;
+}
+
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, io_work);
-	bool pending;
+	bool pending, requeue;
 	int ret, ops = 0;
 
 	do {
@@ -1223,9 +1259,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
 	/*
-	 * We exahusted our budget, requeue our selves
+	 * Requeue the worker if idle deadline period is in progress or any
+	 * ops activity was recorded during the do-while loop above.
 	 */
-	if (pending)
+	requeue = nvmet_tcp_check_queue_deadline(queue, ops) || pending;
+	if (requeue)
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 }


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

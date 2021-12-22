Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58318C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WmuwPz9EtqwUh9VIphIb0vtG+AkkR3yK1mVwU3ivnXw=; b=RFjlozie8eRZ9npZWlBKls7Ise
	4seKDiJO1SQUVZF5us5/Vi8j8UKJzmvwAqZBJfQJyHPadm0LFS7jxiYcyhBD6/EgJwEoLTXa3zvmW
	CdH43NhajyDRZJMFwrBfjRNWGY5c2MP2Kdmgs7to+rF157fyTf0l6Jnn3ub3cCotSUuCWOTVK6Ex8
	835bn0yLRPNEPPnDsFFpb/Eulv+RdDu7h+SbTv6uScAgJmSORv8TPOC6IFRWA6pAgA7f7qhJ8fDzi
	N7rb1kcAPfSP7+FAzfaX8zUbzJ07w5BusFJt0d1jOb9qbBkuq6uIfoViRRBkH/G+2y5IiJFyRwA5C
	LbHOrYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzxzL-009u6Q-S0; Wed, 22 Dec 2021 09:32:47 +0000
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzxzI-009u5P-CU
 for linux-nvme@lists.infradead.org; Wed, 22 Dec 2021 09:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1640165559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WmuwPz9EtqwUh9VIphIb0vtG+AkkR3yK1mVwU3ivnXw=;
 b=Ibkpz5o+34Fya4zgoxRBPqpPyFnVJFtCIhPtPNxockBDeuZACmpHd3y5z31xZr9se1F1Fo
 joshtIZX46/tMEAyhUiWS6TzuP09YqXEGJGY3gTRGz6FLkV7oG7BnXTKomyXoxkbBnc/ME
 EtJ18vW1I1xcY2OUQ6kENX+BOgGJMgc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-HlOUCAGdOIyc_VlTjnJ8Gw-1; Wed, 22 Dec 2021 10:32:38 +0100
X-MC-Unique: HlOUCAGdOIyc_VlTjnJ8Gw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AukwIvMmc6wKa9GvPCuMliFXCtGkMoHS2mFbEaHcnXLWuK8/WhqWewfMeKNXIvlEG0ICz+gT96ND9vYLoDOVojqigwz4Ud4pBABnkxmGk0MbNEAtFyaJT1tSjSZIIcmJS8J7bgAlDIoJDdB9NJkhn7ybiuEep7ImSgJAdkLXtUQBbEeWz2j/EJspfYLqQhKtrKZ0Urm02zrdALDC3/wS99lOa/+cpqHKfEqXPTvoZMHUvCkyttvDRMkCnglHOPRstYO5O7mOQgjUIUZiwdEFjSAl3yawg3wX0IPVYsqS7uobbd1t9YC728KbritqlyeWiFt8140l0ItTvFB7zwL2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyItXD1WCl7Xhly1uWjDW5T2UHz8z6W9F3bbKxIju/4=;
 b=l04xgsoL9zbRxuIFrtKMq62rRmKnKqE/QGH+hORnv2hqmpuUr5Q1cDdwiV81pluzfp5WcG2CaPNQ0TpEhm63X+TdggIECKMJaZfFatz5YbWiz4Tkdu7NhybaQKQalCFQzX8iPexGAUCK2pL7p8Hbxbp6mrcJg8xQZK8iNs8VaqkcW8GZ+496niiNZbGOOFxJeD/HmNckYcr+oGDreXVice5tdbKpkWMm6ePMluNbH1WoRunbNoqvzIEXOTQ5KKz+vNxfOjNKjJgBzMBtksbMi64kQvQbgwo8Fo0nBQ6nfsjqCEKodMI22/BRSocIwUarbzbPOnDZannbzf/o1ds+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3082.eurprd04.prod.outlook.com (2603:10a6:7:1c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 09:32:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 09:32:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>
CC: Geliang Tang <geliang.tang@suse.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: drop unused variable ctrl in nvme_setup_cmd
Date: Wed, 22 Dec 2021 17:32:44 +0800
Message-ID: <2dba156053da8242f12ae218b938bc98880e896b.1640165300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eec87d3-0da8-4219-d1fa-08d9c52dfcc0
X-MS-TrafficTypeDiagnostic: HE1PR04MB3082:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB30824D0A09F97C79515089EEF87D9@HE1PR04MB3082.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGGHRsmtFoGqz2w9kJIPyv6wVDhey2z8+0TCcGssNoqEekf94eoxqgK4IP7G3oil5cT/kBew7qcYdJ6drKgkFfeV1Gevq2+o9TFhF28TMlYzJYzWh44PPK8d6dlQyMgDH6MNM59IY8MHtRggfDCynRXNeFvUJFAV17+2o63mV9fsPqgnJ1JX81F16O2mGJLgIxHawPSDAXbwiAeM+XRi30eOfxb/hFfuP2zatXFpiSR0g7ndNIkf1qcRN0Gq7mBuHFnXSqocYLD5ENYl7/O+w19+LEQeEDElyzuJzhccCLG7owNjmTXE+17k0XT1KB3FXPl5hGWmUeF/DJe2GaKCnELL5ucKt77v4Iin0lqYkQRX5JeJv/c47zdMSOnhCjndpFg+/2zqVjIkD7mZKHXL1BQSAGoM9wgFsPnAxsONZygOD3L3NN23VHg1PrlGwGBVldQ/BbG9OmtdDCEK+VE1Z4g1E3TxWx5sQPPDnJ9wwghbwCZP5QlE0AJPoOzJZBktnPkvIQgVfTPZMyHeK2iza1KpsWVn0xJ6dkVP5zMt9H94+LBKalS+fqUWqNIMAvcWZT3Ny1cEP4kvk6BOy60WEJBv6CaMj32C9E8lGAvSkrMarWDbxMGTH28ku5tpkwljdrR38cfzNxKY8pC2dIX2wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0402MB3497.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(86362001)(5660300002)(83380400001)(38100700002)(36756003)(66946007)(66476007)(66556008)(6666004)(44832011)(6512007)(4326008)(6486002)(186003)(26005)(6506007)(508600001)(2906002)(55236004)(8676002)(8936002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwQR745790FU/6QAcw0mN3LMXNbLWebWVTtUrAOwv1+9KX5mio6thVMP1alI?=
 =?us-ascii?Q?pT62t357oLmQJ6n6eWVOwwgpfWBKkFJ98yVSJjuFNPE1FifJdGZbJ7Z08ZhE?=
 =?us-ascii?Q?ZQwngLyp0FFi9ExkIcTmn2Uaku9vNg7MnepeWFLMBk8K+t99mE8/WZuEOMae?=
 =?us-ascii?Q?+sknGUtHiMVGkxZfJmeeg2Nl5jHL/x+EPomcJeGFhX7EqTQQzwu1FRtLaTdm?=
 =?us-ascii?Q?lFcBQBzOWy/pNlJU06tOs73keXNNHzXRuKqEAqDMyx0hlYJxqNu2ZR54H8mZ?=
 =?us-ascii?Q?/P9krm9ho3d8h3IABtVz6dEqVmxQ/N9RJOythfXCV0RVGITsJUrC5ZCsRPWt?=
 =?us-ascii?Q?yXUTyVRksyTqS5iSls9YFxkq9AaukNkarNnWYVHDrBiDJVS13FLIbSi/fq4Y?=
 =?us-ascii?Q?ifiAxoZIar1OGcmVRyqQp1EEyDC7TUMlyHRHbpU162CLHqDYM75cAgxFssIi?=
 =?us-ascii?Q?MPaCFl7nl59/mmPPOPAnM+V4kik4TDifZwanS5P91sseEqKyIkyglLs8+BEl?=
 =?us-ascii?Q?oPkDXCCGMGwkxAlkBuKBUbbGcFwmgn5qCW+nZyIEx/4zt9ypGFr2sN5QCtvP?=
 =?us-ascii?Q?1yLmRwTXvS94ZW+qsHvy/9Liq9+OJmejmsfbLWvHlX9I3MIXEDZvTior84Dj?=
 =?us-ascii?Q?Uz6ClqrUkk0bhYbz0UncyOXtX9p/0rL8iAhA9q5OnTLDwpfZeyWVLJOb1Gr+?=
 =?us-ascii?Q?DVh/e1SYDk0l4pn3FBWdOYJlT3xzY8nSSL8bsp/vwCiju2YsXwALr2b6E2mC?=
 =?us-ascii?Q?+ajTXDPDpnUbg/ReUh+RpP1SAy8pyHIfJG2hvUAfCF6N3EBvx6VmF1yhrUtC?=
 =?us-ascii?Q?7MltLCf5ZSxVYk1rytjP5KeleNhMY1HPcMEJRcrkBQToE3YtV6vx/334yIyt?=
 =?us-ascii?Q?iUiBC65Tli4lFhA/Dig6C3hzWvzhRe2fu/HdQSm14N+U1muqnreIdzB1n//U?=
 =?us-ascii?Q?y3OCzIpZ69gZOZM9CM9N+o/B++jvTzMo5BfQTT2ViTyOHhhwjBh3QrzJLW3K?=
 =?us-ascii?Q?8Tp6E/dOQ6zTQhyl0AWxLwLq08z3X2UF7Bk29ABvSV+LtdK6hPMlEhhYQdbI?=
 =?us-ascii?Q?OtdvtPS8ofL/qjNXrrYm592VsF4XpyS5/IVLU0h9I4SLrsAN3awYszIv+JBB?=
 =?us-ascii?Q?gbPDBigxGAJWcPEWk4UsXf3k8arV4dLNGlOfvV5Cw/6Owrg+c6xCgNDQK/tj?=
 =?us-ascii?Q?YytICwpQugtHR7SCPQz+IeuahTCJEvxWPb1a6KRZUSVRcRAEuBTfEUxXx9+5?=
 =?us-ascii?Q?CG4SNgo8LQd3h+scoxAcbrR3qfgGU/jByFRXplH6RDclFSd9cvIeMK1x4ICx?=
 =?us-ascii?Q?0QNRTC0iQGuX1x/R6uyOf4ddChMe9Co+phFsSYFkf+jsaloijtROnR6pZPRA?=
 =?us-ascii?Q?lk7OcEw6UlrOeAkCQW0EsU9JmxAm/9M3tRELyqP4Tz0EkBHzzJdw3EA/KFjT?=
 =?us-ascii?Q?sjpSVDldGA6FEFLnJpTTNImOGQu6g5kLyz8qVAAJ8E2/Rl00pvkf87YPNRi1?=
 =?us-ascii?Q?nS+1eqG2MxwMFE+oJeVOMdVtuwzzijAGMwAOn4pk11Ceah/AJWGFeRja0F55?=
 =?us-ascii?Q?SOK62fRqo8y495biDUOoCW0jIjCso9JuYNF5hG/xF2Vovx3A2nE82EmgGtH1?=
 =?us-ascii?Q?Cq61xtoXz3ZW3mkKmO6SV+g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eec87d3-0da8-4219-d1fa-08d9c52dfcc0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 09:32:35.5550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oWLVaBWyko138H+19andXdhlTha6X4JSmec6sK1h+71jRTk29Yjqu00djgElCgs81wa+DCftehwyQjL76q2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_013244_623499_E84702D1 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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

The variable 'ctrl' became useless since the code using it was dropped
from nvme_setup_cmd() in the commit 292ddf67bbd5 ("nvme: increment
request genctr on completion"). Fix it to get rid of this compilation
warning in the nvme-5.17 branch:

 drivers/nvme/host/core.c: In function =E2=80=98nvme_setup_cmd=E2=80=99:
 drivers/nvme/host/core.c:993:20: warning: unused variable =E2=80=98ctrl=E2=
=80=99 [-Wunused-variable]
   struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
                     ^~~~

Fixes: 292ddf67bbd5 ("nvme: increment request genctr on completion")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44c375a1edbb..9666c7bf4379 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -990,7 +990,6 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
 	struct nvme_command *cmd =3D nvme_req(req)->cmd;
-	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
 	blk_status_t ret =3D BLK_STS_OK;
=20
 	if (!(req->rq_flags & RQF_DONTPREP))
--=20
2.31.1



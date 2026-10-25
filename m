Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B07606A31A
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Oct 2026 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SjdpCZqb;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=PjZhSNpl;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=SI1uDZEe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y6fReqHl4tRXTDZ1pWAkR0xGulR0h8doN1rr0PJ9Y5Q=; b=SjdpCZqbE8Xb+5RH7gOeazRP/x
	ZozGLgSGtHuCh75VQuIrY+Pq/1eFj+92XAD03qPHFk2sZbLBFI4Sb/Gn02fxnkh0Ku6vBUZ9FWHkv
	tsaHcsyqkD80GhdOQFfRY1H2s2ecObRUjRknjv2t8gb7TGkti8ENZBCu/f+r4uEsv7kH4A9fT/1IR
	Ue1aYi6P/gL95hPAAYoO4RtAKPnDg2blNRZKKNTBY+LlP1U40HY3+j9TloWLlnbIsI9vsB+k47bDO
	KMJBN81htxTBsJ2aPpuQcPeuuT1yOtb/MNOYe6/70SruYTo1h4rL7xRoAA7nQSxp/bT7XKALmBKJI
	+4ShaO7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKxnX-000000013dn-0kqH;
	Sun, 25 Oct 2026 12:58:03 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKxnM-000000013d0-2wGZ
	for linux-nvme@lists.infradead.org;
	Sun, 25 Oct 2026 12:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792933072; x=1824469072;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y6fReqHl4tRXTDZ1pWAkR0xGulR0h8doN1rr0PJ9Y5Q=;
  b=PjZhSNpl/fXFDHyjuLIOBHeupHkGx8VXsKQlKMORdfLJJWU0/UuBUyXG
   xGPPcY8auNLeFJg7OD2ymsj3O7SaqBwTwtKUhFsL/aVpMA/pMXq/rGNuJ
   g5UUwhZii18hqbSbI9cC6OMehC/Y/WGca0gP0s4bo40gIbgyLdDGlyZkI
   uiROBjGOBEWMJ0fXyq+1BnOMKffdeDAZHdwauOHAU4a4B8JUmq4rjBRFS
   ibC9zWEnCRY22aoukKPMDg+tqoM9fNkYSGpGX8zc4eSaWKsKtMMEiKV76
   8RpUr5rLniJEMze1jtKG5XWulG+wpTU9L6aErI3h/Kl8+WRgrumj0CCNC
   A==;
X-CSE-ConnectionGUID: nsOvNbcPSZGwybPOAYwO3Q==
X-CSE-MsgGUID: QpEI01otQp+/IZInnTzChA==
X-IronPort-AV: E=Sophos;i="6.27,177,1786982400"; 
   d="scan'208";a="157339581"
Received: from mail-northcentralusazon11012007.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.7])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2026 20:57:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTDdjXxsryZCxSXHA/quCKjKWafuBCMm4zaxpeLCXa9ohboYKB4PFvbGpqwddfb0sgvzMe71gMP2tWaEys2lwCUrj418m9nZ34bU3unl8q+Kagdirmq0xYGPySrZIJ2rSfhDcY5qutIaR5r95yz8X01F7Y7GmtKJaUi9HqcdSV0Vq8zQK2XlIFBg9R1dbr9iM7lsLwfYnBAxzsIVhZCvYFlQvAEfxfTYZjJjPTHsqxlmdXdICUYL/FYnNr/ycsFPBq13pLAlO/8B1CD6/mEGX7jdUfPx4hWW+VchMFfq+z567ih701SA3yUDHUdxzVyitob65KC0bObBtU+8V7yN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6fReqHl4tRXTDZ1pWAkR0xGulR0h8doN1rr0PJ9Y5Q=;
 b=kplW9FzXOYCZkvZXGkyiN2Fw/y+x58PsW2CLS+woXIYXzrJJZqRBniTdPN6Gdbm/j/lkw+vM0QJXMMd498gycQBy8PZtSftjEIXhwmYVaZcNG6MH0gVpyzpP5XpPcCAXB4y62wytAZPdaePZvBW/SzdMu7IJE70cU0Gvrh2zzikclPe8HXKP60IzGrxiCD6p+sfCjTR6ReecKczQIjDrPOqPpC+bpJaS7XWS2AQ6EV5w5P24M73zqt7HjdbSWUFynEmuVAFy4gMB/kY0Hh9C02DiF7xOXEr1W8DpMpb3xjM9UkZARrqJINz7XaIc4LXEkoj/vxAqTr8+6kg1KKV9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6fReqHl4tRXTDZ1pWAkR0xGulR0h8doN1rr0PJ9Y5Q=;
 b=SI1uDZEenjgwSMebGauWp0iDMkk4GxwVEuLXqGf2v0rceDzMTRWUx4wHAKvOZ4vbwZR/Rz8eiAePnLE5gkChM65Xn2Rwdd6a3wxhbRnbGb2NqF+umaASYLMlXBXfYH4Hk2cc4sM4eafCFI5qkRT3VTSvDiytVywgr8mDKSy1iDg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ2PR04MB8801.namprd04.prod.outlook.com
 (2603:10b6:a03:538::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 12:54:45 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 12:54:45 +0000
Date: Sun, 25 Oct 2026 21:54:38 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>, 
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Surabhi Gogte <sgogte@purestorage.com>
Subject: Re: [PATCH] nvmet-rdma: handle commands of established queue outside
 the CM handler
Message-ID: <at36um4zrsfOr3kh@shinmob>
References: <20260922124447.588057-1-shinichiro.kawasaki@opensource.wdc.com>
 <atvinQcDcpB7pzjK@kbusch-mbp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atvinQcDcpB7pzjK@kbusch-mbp>
X-ClientProxiedBy: TYCP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ2PR04MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da5814b-3458-4a3e-b59d-08df32972501
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|19092799006|366016|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tjEi7I+aLfBHI9jHEO4G1aK5+G/oLmalGgbRt/sjsxOu1FRyWCEezdfPVP86TMldMMuTrNXPzZk9Rd8nx15JmcI85tYijN/QJ/NcOlv6eDWSUNFpLMVFMRAvDJA8NSJEvHxYga1mNV7ghfnXo518+JsM5vGBd3F3i/hVJwY6HpT8P//qcy4y0Sf12FEwfMuYIVcriiBsyUDrVWLTlIr34mcsLsX2vBEvGeCNSmRmaDgb4jTiQ1QcZHPIFRM9FpUJWJJrPeAssS0k9ZZJB/gU91jws3K4i0MOptaA6VbhmXZ+gT4Hh1WcUciVye0AUI98TcZGvWghC704oRhhu3uB8KKw3ciSnaE2CScOXfRFdz2u246v+U+VvMdN+SukQ8Xc90VwbG2sbJuufrb4/y3MDzDoW+MqsooFElgSJghNCjtXa++KlmdEMJ6VM8f/4+FKDZM6OhlWuzfFr33ru6flGe+eZtTCw7XJNqpGOPK9Fnv0ihRzx+0c3KDdrlm9OcpD8SAl8JIITgSpZomKkde6OULeV5a6X8pmaVsYqiIbcMas0xcMlwx+PaGYVlPhGPZWTQRbvTwMOARFiw064UB5UOgtSEjDKHL227Ij5UehLp31KY9BV9qXzD6msl2j/zOd2JFcyHX36Ljq67DLg9ES4Id49SzPKVTobCoajaj3X1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytkZm6PnhXeSEjCMM1hU9J38UhfpgjjOTu47qMyHsH6fS3NyfbHNfNeJ0k5e?=
 =?us-ascii?Q?iHjDdAMMDNOnAJ4gtRvpyTEda5fdEq2zXuNLmMgVZyfJn9UcOG6XekS6Jkjh?=
 =?us-ascii?Q?BP+Q60NFppVQmTECQZW9WrUy5WvD4eT1/bE/zrLdGtiht6JT39r1kM/np0Tk?=
 =?us-ascii?Q?I1VfuEtLkkjZUNr8zsSHNuOqfVJXIcFy3qxvf8Jw1XnG+YzLnOlIAHcezQ0W?=
 =?us-ascii?Q?QeTT66w5cOWpxgsA9oYN4cU9uphGXPPTnC6Nfq4Y5yOjDfHY56DZqZ0C8k0c?=
 =?us-ascii?Q?5zhsPeo4tNTf3ZE7Ug7H/jhrRhuhi5amG5VYO2sSOTRy6HhATR4Vm+AqSoop?=
 =?us-ascii?Q?GhLnO7KHgaj7xDmQ0ocVIhTqWEaNMr6B+CfTwMy5GY7O9Po1dc9FEYL6pIw2?=
 =?us-ascii?Q?rz8cMQKmtPbY2LTxG+cYXe0qtNtTXkS6W9z+D8L+OMt+IVGrUkTbJCXIuejR?=
 =?us-ascii?Q?yE7/1EHKCPqELtAlpIsa6U71gifUgd3uHVjWLpip1Xg8l8VVD2iNbuXni9D1?=
 =?us-ascii?Q?u4yIcdNOsjfPidA8zgz2tcmSlrU7ysy3yAy2oMfm55UWhmXabyyC/GCpZEWD?=
 =?us-ascii?Q?ZJkJpSceqKpXF4R8JutObAUaRScCqngmAH3cl6tHwrIDvNSVjdua0ZteoD5P?=
 =?us-ascii?Q?o86EDtTbQZn1T0Per2mgAQWoPjtL0/mZ9Hso+XWsdkxhetwtC5fpP5COH71a?=
 =?us-ascii?Q?OKgmHFd5FAcUu+tJg6vh47AEBE8OvGTfRjm+LN/F/wcOdiD4U2EGWzpbYfT2?=
 =?us-ascii?Q?LXd4x/CnZF/JxAhv3bzLrmMc18MG63o5Zrnd/5HpgXamZFD+B6SWKbozEj8E?=
 =?us-ascii?Q?7z6cBLp8DEngN/gwrXB0BSdf2f3+qpWroo4huInGb/m/G57SDyqnnhyKtmcS?=
 =?us-ascii?Q?u2AKaacDtTa5RSJYD30VtEBhv4TNdWZCsuMQ5Du/3342au7Pw1+VUyWav596?=
 =?us-ascii?Q?hj2H5C8EwrXtQE8pZgjzb9AJxzswDq5+wkDPe6dPewD05uGl/qF9RfPJ8Ny6?=
 =?us-ascii?Q?5RzfKDTpRJ7QwSHW7cyHMdrNPijynIXdcV0k2O5+fb9S1qnsFfUaancj9JGs?=
 =?us-ascii?Q?IXxecb0qpIC59OtGr/HY63Wtm4HLXQfJof9HuL/9Pk5m8pHcQX/5L8RcZNyj?=
 =?us-ascii?Q?+9tTYdv52PuC7B73qWr6X13/8B2p/w1tQ9mmly8vlyj+KZal7rS8iZOyZxhr?=
 =?us-ascii?Q?9QK5CrjQapdn6XQnTvUmmfAQoLEeDx7tcUK1DvuJXhExQ0Exx8eGjvWaSUtq?=
 =?us-ascii?Q?PTAheLHhledl3Eflzqb3SaUTq51vKLLyjiYySstqzkziTPGlLleKskYFd6sd?=
 =?us-ascii?Q?I6JuQwMLDDGvE4r4rs0UFUyoBqh/3DWl6iipxBPJpDsOCST5LYBX03methVb?=
 =?us-ascii?Q?uEBmymMwrOY3XeWB3ZuQOoRGgsgep3V7nNxXzzQDkaJOxu6PcoUJc31a5XBs?=
 =?us-ascii?Q?KTlhXG0fhuidWL/G5/NiZ9j3q/8YXOt3DBlrONQiOCeh+DOOWmMSaJvdDdEi?=
 =?us-ascii?Q?Tsi8YOp7ogDjxYjbIypSxuAALAuyGei93VbkqF/7yM/HUmnaBgevjWkLG91L?=
 =?us-ascii?Q?kL9kVeA3uGi4tNldp5xHeTgFJOgH54gG46+uEewqw/HiuJN71ZhZfwu3+ic2?=
 =?us-ascii?Q?4dl4B1rI3pM+FBU738HRO35rjfOtknQSKIOLKTFfsv8DH+65DjTwCqodjdZZ?=
 =?us-ascii?Q?81VxrS8pghJ1dnjRuhQiO2jI4gZMvR4moat/TgAn/0+xzfoOchDlMaYJbOn3?=
 =?us-ascii?Q?twRIt56eDaGQtLa2PwXr3Beksj5ITV0=3D?=
X-Exchange-RoutingPolicyChecked: CaDwwAzI8VGc/jNcDn/C+hSvIiVUuh559NXg60H/GlC67WMhEgSPlWC0jV/vINpW3BPay33L5mWkX7FPVi6Q+KbyeM1Vc5+4vwPE3Yb0M6jLLWMYsUdv4OYtSx98Eb0m1RnFY4uvlf9yE3WWAg5h5DSF/8y/+pGcGhZ5IeNvqeA1tID0H/i3fHQM08DeZNmsBd5bCnLGPjX9wDtUiTS+1O+DtezTxVplJyR7Zqq7vtG/q6o8+N05n6iPtPGJ3Pbb+DPdeMkADaFqYggOuZAxEou5sQvWrS9pMDiKcqcn18msamywyPvTZEI9sFNWl90pdtnsjpVAqBonpsrdStPHbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yljKc8jmIqZbOj6b5GzNgRlN1w4xfMpASnDFs+1NIWeirw9J9ZXVpPwni8Jlc+lTL+hMU1NMcoSD6kT1c/8ca6DK/ie1t1cO8U7u70qZerKoaBQchHmA9s1PT1aJDyWSpZlHyP3HMKHMCTa5mWLRtvivUdcmwreGjPGJcvVn95QF3YSTNFs/1Ic2kPPlENtu6azUfynuIqbA9vUv+SZ+jk4yrafWeWR9M7nRxn9e3jbvq9TkgaCjIW0L8clYNTSAWizMQxVbroreEReHH3qXRUxBMEMm1eyltAGEOmVIiu0I37Izk8NfSgvw6fyOAnU7B0djJurHtmkgjKoB6gTp3hWdwM6TKw+cZaAsM5441kS6bDQPsvMhMqHE0TKKlS7VPKY605DQNQMXxyyX5LWJp7jLIWK7OxKXRh9eCGKXDia2Qyr1K8jlt6b48cfx8fEcaq1YI8/6AtUORw9Qz8ivnD6P9tNssspKncai9dpmhLp3awd95q5WtglV+FgA0BtYn5wkd6vibAjzuYjZd2SV+td61cJ0/xZ5+1bG34qB/OPaG6+gkbXCV/jk1/SUEDkuhrNwhUnt/GTYWheBpOW6fqn9mar4sgQOpVoJ1eKOPo0Chr+qmYxLI7fc2A0lcaJS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5814b-3458-4a3e-b59d-08df32972501
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 12:54:45.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ2KgpDfpFLbGkUBfv3zvxYFQ/O3WF9eoM8NdIQAvvy3ab2XKcoUi0uVwfrWSn9mbQgPnUdJ9u98uYO5PXOTocyI47v9or2iQyVXiynbeh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8801
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_055752_815466_C5AC0DEF 
X-CRM114-Status: GOOD (  12.95  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Oct 23, 2026 / 16:41, Keith Busch wrote:
...
> I think this might be a false positive. The handler_mutex taken in
> rdma_destroy_id() belongs to the listener, while the one held across
> ESTABLISHED belongs to the child cm_id. Is there ever an actual hang, or
> just the lockdep splat?

No, I just observed the WARN. So the WARN is likely a false positive as you
pointed out. I guess we can set different lockdep classes for the listener's
cm_ids and cm_ids for ESTABLISHED connections. Let me drop this patch and cook
something with the approach.


Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E702C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 15:10:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B9560F93
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 15:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34B9560F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fnhKSbeC9UgJ/6N7TzViW95sff21bWybYTlFwU2ORYo=; b=wYMoY+Nsg24hR9
	EtGzLAMIK5wkD+LVIW9Dj6rx7TiRXD4P7cNdJZwNwKUFaZTl+O3AJxZ0X1g6XRVtX2V+UAh1jIcPu
	BxUYPuxJaisCydSgFtN/CrkMKjLm3+VwhDgc4h+QO+DLEH9jTTBIqFL9eDW3FNJO8i3o92DPuJxvq
	5k/k+QGqaCyNIXoelpzi19xCiCtxZhszyAhoO+WvOsEMsJsTay0SUWji2tHgQvB2uxLe+4l3h40Er
	UCi62ltoFJCjUFwXVNxk1ex+9mQRPxJFl5N8spbp1R3S+L9WVz84qdYwhwaOJQW9vzvrTfpxCQIGZ
	JfpMNxz1TtV85LYN9u9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSKvW-0029dU-PV; Mon, 20 Sep 2021 15:09:51 +0000
Received: from mail-dm6nam10olkn2016.outbound.protection.outlook.com
 ([40.92.41.16] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSKvT-0029Zv-Kp
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 15:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRpt70sX51tlM9vSykYx2wejWQLXoF+5pKFI4Vg19JxZ1Ka9mL1yHj2TL2Kkpn7BDgr9Rm2A+3XJfv5IK8vdGXWEb68nYRj3K2pdHy6YCXHvhF1BHRc+PbAaTqpq0EMv/pe6/wisS2NChPxXI/ps5FIVF8NO3hw8buGeYL17fNU8mq7ZpGFdh8ckk9Zq3nROvngfAryNtme3OhWE7zNV0FbauulLPUEf2yb6L3UD3o8i6a7Ejv8Rf+7RajDgYbdt++ATc0VBdF3gEyqyxnS92eaSPknycwaxde1iybra6Kov1gRlMvaf2EWaVcWRaHlSKbVmYFl3iZqPd54HaxEzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wT+H9s4BdQz8HwoLf2L8NPSuRTI5lAB/1kyLvJyBkpY=;
 b=Y0AJfl5X7a0jAimaJJlVVAKeB8r7B3+qAOnmZv9irWOAiQ1xegOlIKt4urk5UDM1fJtdp5FNbnhblug2SnTfXMlL8G+HLBb6gYuPTECVTjV4uRWNGSCWPmfPQt5MMS47lvyxqyUGF1p7AF2aAU313WfEuwjIsMY5M6cwWsqWqi7AeQN7eoOizOBN/qr1MEU3/IJoDWcA/gHZr6zi6MxizHt9L3yB+DZZPfMNqo6NFfuNhJUvuQg4celS4LQKufcPoEj7nLmXIZeUhD8Yf/mBfJR1SEO7a+UzqOoSwX3G/XDmNsWKBUXW8SRgiRuyIE+coLhq0rX20fe9gHXP5Lgkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT+H9s4BdQz8HwoLf2L8NPSuRTI5lAB/1kyLvJyBkpY=;
 b=ZBWtGCEah0jDjonxblERPkuiX6o45s/8u8IQrLreT9lIYgixlX+cq868wYrgsEYNKaDUjw0HsKPTJ4/U4+h7kpbUn0xumoV3mfs7QJY3ec4XlQ5t8NZ+RSKzqP8xmPbOHR/JmYnRPRASfnS7Gd9ouh74dkx4Z2lF86/qxs+2iTyxULLGV7HjMIjhyU0EGMbKZi4sC5/wgn9Ccl40URYnpPScw4MhdjlFyOWpLEHk6M6QDUy4ux6eEji7S6Zex01/8uKNR7EG3s9a30cPjSisWF9LbfYdM5coTuhthnPdvbD1zdOOrlnzIIrvvwvvr19HNZwIqbP4qwjOjD+XLCVgag==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BLAPR13MB4737.namprd13.prod.outlook.com (2603:10b6:208:330::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7; Mon, 20 Sep
 2021 15:09:37 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::6426:e628:63a1:3fd1]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::6426:e628:63a1:3fd1%7]) with mapi id 15.20.4544.013; Mon, 20 Sep 2021
 15:09:37 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-fabrics: shutdown 1-minute deadlock
Thread-Topic: nvme-fabrics: shutdown 1-minute deadlock
Thread-Index: AQHXriWm12aptTAE/UKf5Uqmtmxxrw==
Date: Mon, 20 Sep 2021 15:09:37 +0000
Message-ID: <BL0PR13MB429131886435C5C7092275A39CA09@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8c884b99-4df0-9c4f-ed51-8609f9c8723e
x-tmn: [7TPzd+/54rGcXz4prgdfg0r1gZdSRE2w]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5caa458a-edc5-4ed1-010f-08d97c48a9b5
x-ms-traffictypediagnostic: BLAPR13MB4737:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPB/bP0DzRTMVSy+MgY8WBJiA9gEnyBEz+zE8SEcAZ97I3hct6A8wurA9/nycYKgZiJXt4rIk1g19So5B51BuhQEtyvCx7zMQwXsv4jbRBfn+hytpjOnTXfearbA47nwsog8BpnYG2kdt3xn9m6R5d4Bgyu+ZGEdjzbVfEk5JoL/mPco/T5S8Vj5mXLGlwjUfPJRhub0AW/Mu0TrEEnBTLyp6jkCnyNL46omcxulGNP7THBUModFjyDAtZqENOf9dP14B/tKh0vwtBOV0Jtx0od80RaVwVNRcg51xfdN5RKZw76OPnAx0HiqqlMSnN+v+7gr45+Ifhk/fi0a6ED0LBLHGUZFdk9gvW/wqFr74OpwSWb40F+wdvd+fqSNuj2sExzRDv1Vd9NdeIAsgW1MygflnVm9+a8VY5jx2PEMSCNmx4njbjV2q1jabJNBlcZy
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 5oQ2s8HuNF9FUgHRsURr+cHjeILyRhob4a6rTavFsF1TYZdHD915WIReUoONHLFZkYxkfiFhI4nH3KH/nZwBAjQDZX3DPnqs9fVqAOSTV/8aouBPlbpYrOw6pHLFmUeiXKIZ0acoMVVyLKmuvJ0zHA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caa458a-edc5-4ed1-010f-08d97c48a9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 15:09:37.5667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_080947_963219_FB237AC0 
X-CRM114-Status: GOOD (  12.65  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello NVMe community,

I ran into a 1-minute deadlock trying to disconnect from a remote discovery=
 controller=A0(over tcp) while the controller is unreachable. The remote co=
ntroller could be unreachable because the network is down or the controller=
 simply crashed unexpectedly. The cause is irrelevant. Suffice it to say th=
at the kernel does not yet know that the controller is unreachable and we'r=
e trying to disconnect from the controller. The problem is that during a di=
sconnect we try to write commands to the remote controller and the default =
timeout for a write operation is 1 minute (admin_timeout).=A0

For example, in=A0nvme_shutdown_ctrl() we call reg_write32() (which really =
invokes nvmf_reg_write32) to set the=A0NVME_CC_SHN_NORMAL bit, and this ope=
ration will block waiting for a response that will never come. Interestingl=
y, in the same function we also call=A0reg_read32() to read the CSTS regist=
er, but this time we specify a 5-sec timeout (i.e. ctrl->shutdown_timeout).=
 In other words, there is an inconsistency between the write and the read t=
imeouts in that one function.=A0

Similarly,=A0nvme_disable_ctrl() calls=A0reg_write32() (i.e.=A0nvmf_reg_wri=
te32) to clear=A0NVME_CC_ENABLE and=A0NVME_CC_SHN_MASK, and once again this=
 will block for 1 minute if the controller in unreachable.=A0

I would like to propose that the prototype for=A0reg_write32() be changed t=
o allow for the caller to specify a timeout as follows:

int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val, unsigned timeo=
ut);

This timeout will simply be passed to=A0nvmf_reg_write32() and in turn to _=
_nvme_submit_sync_cmd().

When invoking reg_write32(), one would set timeout to 0=A0(zero) to indicat=
e that the default 1-minute timeout shall be used. Otherwise, a non-0 timeo=
ut would overwrite the default. It's only in functions=A0nvme_shutdown_ctrl=
() and=A0nvme_disable_ctrl() that we would specify a timeout shorter than 1=
 minute. For example, we could use=A0ctrl->shutdown_timeout as the value fo=
r timeout.

I would like to hear your thoughts before I submit a patch. Maybe there's a=
 better or easier way to work around this.

Regards,
Martin Belanger
Engineering Technologist, Dell Inc.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

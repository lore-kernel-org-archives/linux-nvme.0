Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B4FC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 18:15:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56282065E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 18:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1jR0CeG8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O3ticsbZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qqei9WGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56282065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=1pD8W5t5p+rxRMigthPJ69aBF8gGy2giVfybONtCyvM=; b=1jR0CeG881q5p04bPeopj/sST
	3tB5Tv2bflyOcUkrfVlM9aDra9DtrbNeHLspDgwF1smk+Q04fsf041J0qKJ4QjMewSRwie7lNo+RG
	9J3tXXpN/0WCHnFKsjLmvammyL2bfZHPC86OVvA07Hvf2JfsEhEzB2X443XSzD+JxO3C3bmva4+C7
	skyVZ6Kj3B9oRCrgJYIWHPqym6USDP5jRrvQQRITm92bEItCHkSUXIEHxT1zFdJ6BrS64MjtB4AX3
	FciVMjgV3B5kSYKIlgXTeZ+GLxfaQj4S3PuCacwDkpBQDfTP2UqoKVhW23DpV0ppPuAykCbhtlC0K
	VhIgKQsSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0qc7-0006iD-7S; Wed, 29 Jul 2020 18:15:39 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0qc5-0006hZ-Qw
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 18:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596046537; x=1627582537;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DAX3WvVtHm+c5jtFn4UAYXsmWrNPJleyOxRYtFL4ig8=;
 b=O3ticsbZeR4/uVFfKyHAiw40INEAdnyVBVSVIaWg4nN0zm56pG1zXy7T
 bP96EJUU8YSZ5cp6LCufkfFTP1xX5E5X502ZS5UM8irCmi44x0I3d4NQa
 xn28QJEWZEKBOWhx2DresyqgWF10eZ3hdtpfTNE2Qg59FgkttbUcQdzLV
 HzWwo+E4/ybwJGoFL6TEown/CQDqUxZhnYA+ltpc/Dv5VfgJEgNj6O1S3
 d8HK4i0Zl+05IVT+s0HFBOZffmkoPFIKhOjU8ASSfv5UxQWC+7TT60DsM
 erIzP4aPUyXW08Z8jn2xtFw0igGlxN6vEThJnBavFod6ejM2FZqz+x+yP w==;
IronPort-SDR: YRWJfJTiFkdcPPGh0rUPI+VpeOuszuRuX3ze+Xr/myDIsKi7CULVzgB3lfXGeIj1v1SAGL1ebN
 n1JGujtt1Ikzuo+5n3Xfu2FMcdwka8NsFFUKMuUkBdJWe2hWVqCfr41l6qRmG+h7KPS3WQMyv3
 OKUDPyMs+u5KV5O0w0JAAc9qJxh4hsfEBknsnJ5RmBSER99ezYjQt5pEboC8aShSoXeBfC5zLw
 aqWCcTpBqRsozyqvQ7Tsa7PKVjCx/rdaTCQID7+Sj7cC+Ri8uryLsx6Qpnbf3iyQ+/0HI0mGHB
 B+s=
X-IronPort-AV: E=Sophos;i="5.75,411,1589212800"; d="scan'208";a="253017398"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 02:15:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eizH+14dYTeqDx6pYRdUOsJXEj7fIfa5iXAeI49ZBTgDXCgIYMteUaSFWFmDpG/6OmudDq5Fs3C/DpXZ1PSQxIlqgmXzLnSjYGPIvW5ZbMjrthtpF6PA7bv8K3rA0qZcGx6ZU0vxJK0SM4eX0Meyd2m1zsxrGb3JCrV40iUR+dKK5WhoXWkwMlFRyyGGZAs89svz6OvIzsb7JYeIdts+oYVnI/jEB3fNC32zN3eRB05KDG/rd/eWFsZ9FqaXg9Vil7DY09mVBLR3g32jpmbxUbjZH++1gZajvDrprjB38En8Xez5nMwpqd3ahO5Ay8DlOKl/1vJEoIrUnzYF9NrulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAX3WvVtHm+c5jtFn4UAYXsmWrNPJleyOxRYtFL4ig8=;
 b=ed2qkL3JOlQ+HN4zJe03ZocVryJdYh5KT6S94vYV/L7HXCe/c3CzkQK1S73OQM6ZbsnXQWpo2u6rPA4V8cvdGA5yeNcmZsVpQWEto78rvvHa5FWliro1l4Yph//z1sKV6nNCW1TipHTL3TFC4MqT6g9MaST5mF46TgvYfN9Wq/Xbnn4jInjygW1j9+0MXV3NY4wCj6hP62u2r6iDj8wb7VV0wXgpU0cvOJEtWewSkaT7KLEzbEFJFcj97j4Ux5M1/ty8D/xWBNbOHTSQ9B3TeCUAH+7tsERmCS7vJcPMxBKKyTMNMAR8gbrWT8rkhz/008LSRO97wg3YEk5ceF4E/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAX3WvVtHm+c5jtFn4UAYXsmWrNPJleyOxRYtFL4ig8=;
 b=qqei9WGoNkjUI+7EjyRmM1g0BmoGfXLEr0N/zL12GyiztkKmNbsRmnWJP5wUI3wtD6h6u+OsdS20D/ZumFe8+SdChhZRprXSULnn1U5OVeF1YUheapbxFZMWD0CnAhE/JHT9HLqfQqGGYxhsC3YBIQxbLmsp5kox5Va5z9HlTNo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4758.namprd04.prod.outlook.com (2603:10b6:a03:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 18:15:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 18:15:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: add a Identify Namespace Identification
 Descriptor list quirk
Thread-Topic: [PATCH v2] nvme: add a Identify Namespace Identification
 Descriptor list quirk
Thread-Index: AQHWZWxk4UqHxeSwM0iYrznNupQGQQ==
Date: Wed, 29 Jul 2020 18:15:29 +0000
Message-ID: <BYAPR04MB4965EBEE2677885EF82CCCFE86700@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200729054420.9049-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4e0d6f4-53fe-49f1-aff7-08d833eb5ff7
x-ms-traffictypediagnostic: BYAPR04MB4758:
x-microsoft-antispam-prvs: <BYAPR04MB4758BE96CAFFB5E227EA7B3286700@BYAPR04MB4758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +O7+RY6ZonyMhoTRCFGygC3UlR68zN2nMX527mCTJpIRxsqREU2L2ZRpR8Lst3vAbW/D6J+Y6cz0hUzNulG3i5jWa2LMFYUZGeAZF2rJfZ6gnxdEGrYOV6uqOdGt7EF0LdSZoypOqATNcq9MYlebLgD7Wmdi9u7HPJF3ex8KTCyCrSACdLDlHjzWR2eFfluLJ5fzBK7RbgIrqZOq0LfrhltTW8rHzZxfj3TTQETOpZvK4Hcd3qTCN+BlA/7SOcqjsg1F7eV+3T9mZssgDHzs/Mbxx03CIi4yEMO41g4c4F/a6uEJRSueDJxS8tKeKaWgL7H0T97bhuC9+kVYDy/ssw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(64756008)(66446008)(33656002)(66946007)(7696005)(66476007)(26005)(66556008)(76116006)(186003)(55016002)(478600001)(52536014)(53546011)(6506007)(9686003)(86362001)(316002)(54906003)(110136005)(5660300002)(4326008)(8676002)(4744005)(8936002)(71200400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PB+LPZilKoVB1PwU64gumqiN1HMWPSf5stvhhJqzrJ1PIdG4qnCnni13b+mcTawCBGvHSCT1qhIsPqkkJmnxB9HagPml4uR8a6Nm26bNKoQ0ot+rHCLM7aSJM0wvWABePd2nxNGDVDbC5hY+4jo9GHyCNE8Q47kZrzztGFCqIlUZxPUHklXFtvWH74oKZSTdTYVS+bhdjLq78hgA9S5YA3EXsYysBi1LP9BTlJpNEcRytuEkjaEAK8S7MA2i/bDhQ1mdzqcM3eoH9aSI895dZ7DKS7y2rAP0tft0u3xIhHj28o58QedM6l3EtTZ8sVaGLx7tv6JMxfBJJqTASQoRBiygs9CRavYZuNP/mfZWsT7dfvvfspX0Gqy5xUCmuL4DNg6LYwvLBc6eIutUd8u0sCCSW8ngzFKqYVWHlMpgybeBCB5I5v44ryMUtRAPcAFXn1uWSkAxaVGGGMLDn+RN2bZMxj62iMoHRNtOJhx0Y/A=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e0d6f4-53fe-49f1-aff7-08d833eb5ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 18:15:29.1652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKi17tWI3migAQpGYN8iXqlPLgz4um2WCXvNuI+dcl3U0YRHX/yFfIKR9qOYAkGzZjeQe8zEz0akTCIsTprUuAvWo9mcK5h0n3K93AqFYOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_141538_096722_83652449 
X-CRM114-Status: GOOD (  12.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Ingo Brunberg <ingo_brunberg@web.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/28/20 22:52, Christoph Hellwig wrote:
> Add a quirk for a device that does not support the Identify Namespace
> Identification Descriptor list despite claiming 1.3 compliance.
> 
> Reported-by: Ingo Brunberg<ingo_brunberg@web.de>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Tested-by: Ingo Brunberg<ingo_brunberg@web.de>
> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>

Looks good, with fixes tag.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

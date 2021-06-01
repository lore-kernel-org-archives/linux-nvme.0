Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A01C47080
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:41:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F6061378
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F6061378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=KiSFxwz0lLL/S6tdQdouwpeENrBUvbumk27urygL4VQ=; b=k0/iikR3dj3737
	Kup1sHavHb8mFkHY4syMXlEpQLmmz99A/SHcSA/7UuwMX+CTuPAuT6zC2+mQFdKJbtNLeOYZbDW7l
	8fpRjRYRj21MzuNLygKVsuDwpgfYKv1SlzU4zJUJ6m8Ekul2OTPoJo4SVr9gDCkOaSGXBfqc1g4yA
	QCH7BMS8bmALzbCmFLi8vSx439LSp8T+IwDyhbtQ/NDy3tU1tCC2B/gWQJAnF5LOs/rK4s5KQKUDJ
	h9iMn36Bxlo+AcYlcSng8g0YYH5NAxguvieahLzOABJ5uFr6NOhcgoPDaRTdvYpXAJQIEFPtwkOSY
	lFb21Hj0hR3ZmUL82Yyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo8OA-0007Kz-BI; Tue, 01 Jun 2021 17:41:14 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo8O5-0007Jz-AU
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:41:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622569269; x=1654105269;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=esEaAwnpPluo3MiSgJC6tm2avhY6so8UwBrBSgZR59s=;
 b=ULBPsnH8TMd7vNo7PjvdqMQUUOmMCRfFQgZ5aydZ/T0unrMtsiUSXZGh
 /orhjs/z2LeNTprqOeDmAb2YhpB3EvAO8aL1tzFLQjLyeVQ6puSP2VVI1
 6rNeey3q0Vh6yeCvjDAtz5xts3G+fK8OtccjLNEUjzKaNnAddv/BMGFhF
 9qczgk+QKiBWAAixAmT/0ar3fNgPmRkrBmAb06q9FtKOopFjjQavdyYCY
 8G6gjMwFGN2sPSJH48YEGI7ZbhhFj6BwOi6gnsTi8adzapJcA+F7b3uSC
 zLKrsPK4ttaAmpYlLlVEyU5gaMOeFxi5ke1NyLFkMjBXEAfTs/DAoj317 A==;
IronPort-SDR: KW3E1yIrW7c+vxKWIlk7tzk/+nlR2k4q4NFopYziaINkag0Gvht+DZU0Eo36n9CruEFtLpjlTK
 mKr65roxT3v5tV5G3mkqQa27t1H+1q02hLjltGH6xUGkHeyJiDQchOgfNLKsoRH+2tHJXhVNGm
 Fv4HwvvP5dh/NnwZHtiEbd43gwa2ZYkrb/KW1o2ea0BaoEnkj/61fCPbxpcsXp1eIjCh9eYPvr
 iNO5MJnI+NGxjXDTkIx4et/RValPcrOhxvKEIOMKpCoekPBFIPqqVomR9xIzvaBEr8MnutBoro
 IQE=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; d="scan'208";a="169584750"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 01:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsyxyBlJY89PMjA14pXsdK9VV37Q7nfoiNkRQuHCShDRJdXDC7tlPCcY3KRkzmke1u3SPm2KasA0rr/RUqEuRYZAnCwj7Gsk7+iWZB6Jtco+IFoDGBidcZnRc/zPYCmuNJtDHnpFJ02hRcVF5I4xJHwNWXHq6cS18dT7EvptyhPmagg8rzdCGbbHBgB46nkkg8hP9SQkkbwb1WU57KLl7616tEDXIElOYtycA0Z3D7PMhMh/FhX6gwldNcewPPFs/15tx2eeeC56+P5hAc4jlsCIBdWwK6v9ufUkRraqxeGhGUZLlaedo5BGnf1PV4UjkkMkYiLz+OnWwGm+6yTYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esEaAwnpPluo3MiSgJC6tm2avhY6so8UwBrBSgZR59s=;
 b=fRNCXmcZiCVlq5yaq1YpjYZtt4H1Gbh1d2zTFDCJL9trUvqTVHGajhZ8IcAftqYGqctS+GL9tGxREgXyG0yhA2UkSv8yhiWyuUZzdTGeEP7NPS9xDqN10nofwYWw9yeA2gTlNxzD1BXU/mTXtbl5tnsIohlTQrAYd/X1EQIblJ68rCh4wCxi8xrVcxfLwWRYheCjaASDRJji+vh0VqOKU33BjK/E5kObJlLHc8cZ3Ldkuo+Z9JQeZhPnbHo3SPHKojoOoAMB9teyZkIe/dfUITMLndMg4Fs2M+wKh6rb+DkPq65iRd6b5bVlJpJnAu3SfScwkkBpCokpMFAfgHkXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esEaAwnpPluo3MiSgJC6tm2avhY6so8UwBrBSgZR59s=;
 b=JseJxVgiFOODvN5D3K8WUqLQ6hmlpaScu3SYEyI/1Xwo7kD+1ryDS4aB2peXoDIQR7zTTqwWaSnTPKWwqsujxja2xDE1uc4ZBomL+LaR2BVS8tew5ZFDkLGJcH507KOUtnb0uY8eApKW5GcYHLnp/RVFs3CYRmyF2Gb7ZSunla4=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6282.namprd04.prod.outlook.com (2603:10b6:5:1ec::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Tue, 1 Jun 2021 17:41:07 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:41:07 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/4] nvme/loop: clear NVME_LOOP_Q_LIVE when
 nvme_loop_configure_admin_queue() fails
Thread-Topic: [PATCH 2/4] nvme/loop: clear NVME_LOOP_Q_LIVE when
 nvme_loop_configure_admin_queue() fails
Thread-Index: AQHXUlGcLovym3k8C0eTFpRAP08viQ==
Date: Tue, 1 Jun 2021 17:41:07 +0000
Message-ID: <DM6PR04MB4972386AF5FCA1CA51B734B1863E9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210526152318.107202-1-hare@suse.de>
 <20210526152318.107202-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ba27b1-46d8-4b39-b93e-08d925246ff0
x-ms-traffictypediagnostic: DM6PR04MB6282:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB62824D07CBE4A3F1B541A79E863E9@DM6PR04MB6282.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlCEJkXIInttM0ELhC4yVbalVXgr/JO4pa9jlZhVqw17+lY6//pfYJhPLG4SDuwDqJntVDLAqrsk9EcnfnXG5LFxER4z/QX0FIyS6edOgdnZF/IQE2sr5+qTOoyiWQ7whwhdElwGAhqD2fX3OsEoeL3P+JHlqErtKbInhPy+xAVhxM5snEQnn9aLUXiCqVrp55ql0HzD9h0Ci+RQLua0QDUsJ5dSLjad6BfJJM6kHzHTNAi78IMShW7hYwxnuOJgC8SXdx1ymuQ3TNnsaYmg794Il9RD2SiURX1uJtxyVxTN0ZQFR6uD2WW1r6GKVQ69SruZHj4gP6cAJ5Ny90n/htozifroHkHpQ9hlRWkqYXMaSOBAmgOpRdcnflq4xt+TLT7OPMOvkWBkszOq5yXFFkto2khAzBz5lfr3qHWiZuMt166XuYUQYEDt8IXg9IxURc3FjDRZnwFnuZzO9Y1T3lKwUGYQMq2WqJSobBNjJCb6USaZ+xbL6+wSdmEPD5gtRI/O2ODITXAj/V6UiZNq5zCnpxELcDyUNFjnI8iXjbGpZiCyUzWlks+vJQpnrY/55BLmMCmkZWx5yfMH+8X4bpA2Y2SRrS3DwqdlEfnPf+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39850400004)(346002)(376002)(4326008)(55016002)(8936002)(8676002)(478600001)(7696005)(110136005)(2906002)(64756008)(71200400001)(66946007)(53546011)(9686003)(186003)(76116006)(54906003)(66476007)(122000001)(66446008)(5660300002)(38100700002)(33656002)(86362001)(316002)(91956017)(66556008)(558084003)(83380400001)(6506007)(52536014)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YS4emunhwN9bC4DAgtbaKnIdVAmk7WoVkEbthV7dk94ErYmAnZlaTlHMH4mT?=
 =?us-ascii?Q?gO8C5Rcjt0hDtcfQTq/XJuXhpzWawevK58F2ql6YAm6tXlmUuJgy5MdUpfe6?=
 =?us-ascii?Q?3reWhTF9bN4PRDfGF140uaVi/Z/c2wtrhddbJKJeqEKnZS6jjRAbp2vqEeZN?=
 =?us-ascii?Q?i4Fhu7dE3LB6IHnf+OB985rKUE06JrmD+70nO99Fb7KmgUxE8PFBI+5uaF9R?=
 =?us-ascii?Q?V8k6uZMtOOXUfGqGtOn9p4IjHaPRcqiiFxIZBOErf29rHbfkQIrCWbRSb8wm?=
 =?us-ascii?Q?tf8giEA18CmAiRn9dO8/7Yle0QknsSgmCbqJUaSxlRlttvWvvgAphjha9lrp?=
 =?us-ascii?Q?hOYwVmx4U4sFTBM8PuU6utiuEYNBCqdg0BCqt6uC8muUeHL0QdOemL4jBnR3?=
 =?us-ascii?Q?ZqfYxFxCDFo7Masg54iTrdwbZVY1VNQfBiu932S8pyJdycGyprh/X4RA7O+L?=
 =?us-ascii?Q?laAxn6Zs/qPi9HYpBnAYRSBdYXS53Gf+ZMG2kB1NopM/aRma7u7k4MufgvVT?=
 =?us-ascii?Q?eTS8VsArRIOvoG6kkykrX/J4h/eC/pwE6nRnOggzOOB0i8F0sQfdUNVjg9ar?=
 =?us-ascii?Q?lMU8tGoZenT/9wR6nPI/IuNOjbUKBv8HMfWvPv8EJv3YTGA4Y7gXq4vvZyuN?=
 =?us-ascii?Q?Ob6pW/Ggf6/l9DsIKPM8FVqd+7D8mnRwpYgcwidfZIwlKcsdRsp2qgCjzd4j?=
 =?us-ascii?Q?gejPvxLXr0FYrLb9EB4DYDdar3jM47SI+tiVsQ8W324kGLZSc4rjLuLr0WiG?=
 =?us-ascii?Q?8cCAoX1bnv+AgHGZmr1/5FmqoN6BBmuHxedsHmT5iZM4q8cLOt8YHR8DihtB?=
 =?us-ascii?Q?ybKK0C4z+R/q1vZ1ZOWmDDloXQlQD0zbKr7zwDhdH6QSw4ZMwdkcqfkeCbaX?=
 =?us-ascii?Q?1XW2sJ3W59pR3P/kkCpnEBgJobLvCVkQkWkr1XDtE/mEXyZgE/XwfG+u0A8D?=
 =?us-ascii?Q?BTADRuohu79BgNo4LCxIZWD1szXqZLJPyCBvG9FlJR6hWMwOS5Bcelbufr2s?=
 =?us-ascii?Q?wp/ZlBHvKj3zHaAWJ3DKxM3A2l+4JAvKLn52F73QwrelI3/hkOaJEMVQL2su?=
 =?us-ascii?Q?u5KVZBrOVdWf9/9giE1NXwfEZ7CZ9Px4QMWTqzPLqs4581XyGO8bfv65WwLj?=
 =?us-ascii?Q?axk2ugkMUUIVNgvZBEzuG7y5xU/ohRMdCqbmL05LzkngAev21ScI3x4zWgSX?=
 =?us-ascii?Q?4obt7W+/Sp6iXy5spLFmXX/xo0sMn/ZBzdpI5cEXXmWHvOkteGpb46BIlVmr?=
 =?us-ascii?Q?kcN9iiSBoV7Jmq1T8wZibAZl8rqSTJy5UN5RCHqrjuDLbdKi1DqvP4XFXBBX?=
 =?us-ascii?Q?cpnT8d6LgJTueicwRkwsH9m+?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ba27b1-46d8-4b39-b93e-08d925246ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 17:41:07.5633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iL7E82pMv7o73butIBEpCJ/FCkja7UBO99Y34Fxwcp+5MTjAg5lZMfD0NPl9cHITnrI3gANGND8jkQWDVdb6S1tI7z9QAyfcHPFrf9tZjH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6282
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_104109_445923_1CDD0D86 
X-CRM114-Status: GOOD (  10.01  )
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

On 5/26/21 10:07, Hannes Reinecke wrote:
> When the call to nvme_enable_ctrl() in nvme_loop_configure_admin_queue()
> fails the NVME_LOOP_Q_LIVE flag is not cleared.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BA4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:11:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3791064DE7
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3791064DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=+gonMSX/z7vpAcKXAmWLf2HTISgKlt+V1b2R0aROV6g=; b=hp6Kw0LxNETIWHNktBNqZ/L4s
	PCadGCZhYVeUAZp/rcANcO3Sy8VhEXmaKK12C+0QolCSJ8WWm226mgfnM1mkMRxy8wCrV4CeHenf7
	Oa7Nkq02z4KpBRU6bRGy1WUo7Vag0Nzdmf4vDbM2EZrdUKBdZV1dnexcbqr39a3gUIPSz1HZ4yLrH
	QmGMjh8tDKzxUUoAYQIIhQN1rmAKoBen3CjkX+qITeEc/IPoDkjFnTZwkhbjNxmmscr1YZ/42hOng
	QJ0alrLfPX3FRJx6YOOiD9hYfQeulwpTdkHzY3h9Do5cmXB5+rrVVuLGdPQx45fsKSVkcJRaq/a3w
	vu2qz+Kqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9xhk-0002ue-PK; Wed, 10 Feb 2021 22:11:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9xhh-0002tf-2x
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612995080; x=1644531080;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YGxaOCSF6v6gVw0S+2EXH1fq+6HtNhk8MbmMhOyF0Kc=;
 b=euHJu7APgbqcRUaRQZApnb0H1fjek0EaUB12gw+RtrdN0bSsbIlKINDV
 EDf9334lW9E7Bdl20iJFo4UqZSLYXpPcGWv3wJ6On4HSYcm4zGG3VjxPc
 fc6Tr10jZvO7Z/mu3697CuDI0dI1thu34Xsyps/Kui0H9gwplQXZiuEJC
 dstKNQJmN8mDOAnSl+pxcS+X7dsnrwJuBJk9cVwvhQ85TmKPtZZMfKfaV
 Dq70AuBF6oDvLr6ZpMZ0VZkXh6VH8n/UL9uZ2AAC8rh/EWQ9J05Z8dJ4a
 cEGggFdZpley1IVyEe4N73WG2OvmcKzpC5/LIRrCrTPKcUraYua9pwJ+E A==;
IronPort-SDR: sGE99W+SyGzVUDp+xgUpCd5Qph5OWRwXuJGoV97jbOdFHt6ouSuIc9coix8ZX9W2KYMNc+68ra
 azSKnAhfkUvP5nTGaE3zmHZbYjKOpvOxqqk0u3h5ZR5ekaRrlBG+Hp+Wqn5nWys6b2mkX6feMW
 o7pguCscLaYg4OGu1Kptpu/G8A8aNzYTxuwcEsu0IWha5A+cLWN6NyV/EvihWTb+ImwXRGxahg
 YboN0+oPbkh1Is1XPEUS0FsZ980E8qxMf8BZn0qPGmd3LSBk4tECB3o3rD763RGBzsQFqET0Rq
 5sM=
X-IronPort-AV: E=Sophos;i="5.81,169,1610380800"; d="scan'208";a="159716772"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
 by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 06:11:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgrJuGFkS/BV39npVuo90gnMHatpc7SizWAJ/L4Jh/RCarseXTTDwJ0HslpR7OyLE+sACElb+ZIYveDXN6LMoATGRKysfT0kk6EA1O82zUiloRyfN1hXeDtXvZ1Het4Z+GvCtuaL1+AGUjQmchLNGcyv9fwoIkE3esHwbbbbcQ0hmZjrs5XqeoXfegAOSQnHb1vXET+JC4bfd0Q3W4SPeU8EoNaq8Q/uhUI8la+Xk4s2SEoNXjYsG60PPuUzl689Pvy+NAGf48xpAROLYDJmiIe8mwl2gE/ngAUCD0pzgCw2XcqLXI5uJNHy/EgHor5TldcT43pDMV/cqI8t+2ulyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqdyrnavqN6DNIJq6hTOKnpklHMMohKtFUAUrXtCdc0=;
 b=aEfQUQ2BXtKgE2XCMAY/AVbUfndAmPNGtCSVpUWw2MlH6E4J4cPkkHPM27KbT95ax68fjOZ4juty0GVTIubVGCOLyMdZX6/6G6EA+e4muyQKriWxmSGJE7Q3l9q9uXBGxkG1khndxXjgma1JRb3rZ4o7n+rLYqL2EjfjlwzFNBd8PCVt6SRvUvnBO+3s0J8IEE64kkG2esTNUsWQHalPZCSAJPMIQd0N2DHHHnUURuF2+1PCN7UERrpA9xw3NhyjyOkkWYTx+lo0w6OGwulL7MeT4TABHMENJ5s8kICoMcNtQS/EM0ZNk98x5tlHFVlL8MQnnyK7oGUWvVG0G0WMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqdyrnavqN6DNIJq6hTOKnpklHMMohKtFUAUrXtCdc0=;
 b=XPJmayNvxjOla0HZjSpHqVAVKh19WoN76tZmVmVXq1+NOK2fqy9TLdSgxmfvu4qNhsW6tbKj2yUV9XXodb91wpEwpfqqo+uPVcfjGJZeB6US76V1sRPk1j9Qh4lAgqO2+76Mrr+sL4QyPmiadOP3KGDO6MWTU4liDOyEvUC/XMc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6600.namprd04.prod.outlook.com (2603:10b6:a03:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 22:11:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 22:11:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes
 command
Thread-Topic: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Thread-Index: AQHW/qFWhMgmVmIHi0+62c2Fpd6hig==
Date: Wed, 10 Feb 2021 22:11:15 +0000
Message-ID: <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
 <20210210131557.GB29904@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2607:fb90:482b:10d6:f4fe:f24b:7108:1811]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 740f87d0-32c2-42dd-6894-08d8ce10c892
x-ms-traffictypediagnostic: BY5PR04MB6600:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB660015E805848396E38F3F8E868D9@BY5PR04MB6600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oTt7GMEdoA/GeugREgUy6xVpVfzqfeJxFd3ovuAX8/wwnnpZ/Do1F/LxELicASXEAp56MQZenrrtzSKn6DSD+FMUqAeab0H2trWgotJ2ADOdwJvjV+Oxlp8hUhH5gXLW2lc1E89V+EtbUw++ff5aiDD7jglTKZlY4Jt/UikQ/nU17jaX1hUIsJwVXo9uRlb8c9koI3ULHKjm/bePC5ndqU7fCyk+YxCnOVcd76/y4OReiKznZARJUVg/iy7i2hMsoo3xeucLHVQSy84pTp/nw7giRgB6JRdQxl/6IRAlMnr7Qegs/eNCQcgKaRnsv1LSPmIo6UhAiOLQxjLtD8YeFGV7GdJJtO7YraWj4RaMz44Ovyvg69aXIVOqZtlqngd/DBRpwksSZ7+hI1nuyc4lO4Qx4QSyw0RA0uTDm0VLNXoMuRyLSOy+IMhhbKEGDZyVo54bBrT4tiGJ0OlwiRHNkN9lC2qapYt97LQw0rmw+y9mtXRZUB1QzSZioUj0Pwg5fCZhha1vV4clL6NqZMEJ97CqGKxNdy5zp+BPVmhiRTDG1kGTeB7bS3nGj39fUrN2I8ms/trtpoqRW6K0JYp3WOqKqU3ORlYPsUl7LXkO28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(66556008)(54906003)(64756008)(66446008)(71200400001)(33656002)(7696005)(9686003)(6916009)(186003)(76116006)(66476007)(316002)(8676002)(86362001)(52536014)(5660300002)(66946007)(966005)(2906002)(8936002)(55016002)(478600001)(4326008)(6506007)(53546011)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fM+b6BgNvpZoFxXu60XAEE7NZm1Tp8Yx+g1+zOGNPPxZpqygoO6MM1QL370D?=
 =?us-ascii?Q?xbSDYBGQYNBcyxm2MM8lyT4Rc+EqoXocfrza2j1bqfQ4rmOGEBTsB5ubgq5e?=
 =?us-ascii?Q?6JSiTC0MCtKtLRmBssjnFBa1q6NtdXJN1UvuRrJUq56Q1CIAcMVg2+cPfNJU?=
 =?us-ascii?Q?zRdiN6QAEjnYlIs1Vwjtjixgei3W0tjbn8DQqB+Nqr0BTTLUMWVjwKeFfj79?=
 =?us-ascii?Q?z6lzEqXNPQ0EV7qTD/bdR94cOS2HpleWM+CU/PJUY1aSUkVRci20IQnhZJHe?=
 =?us-ascii?Q?ilpmkG7HdshRwbvjtJnOIoGBW12Z6Rm8NsX4hVmMqJ80ROI7Rm1AFgqynu5G?=
 =?us-ascii?Q?8qQTM/RdehKL7BsfkaKRMZ3/6TnxzRUqxQvvHpA0ptnvchkz52wukPFjzgr+?=
 =?us-ascii?Q?iHhw6OEyOjv9+qkQLOUesOVWzlI/JXHdkOkwk/t9H/KR4NNIZP5cYx/PokCt?=
 =?us-ascii?Q?O4vwPArK8OW8wkckdUZXh5Je2bNvUdP/tWuX4NVGOf+RoHNAATczLlXYwOnh?=
 =?us-ascii?Q?AYSAPwiOBwvMUBroR02hfs9jo35RgYugt29sGYvTOkX9EBIVWH/PSK787Ilx?=
 =?us-ascii?Q?sJl0zUt2sJEg94JnggEk537z4jSSLCBopGSFklpYsJGs3YjrrSa7gQVskCPH?=
 =?us-ascii?Q?xnn8d9Sz1g+WSKl+kg7O1+ABpjMfV4ullfDIS+ZFIWmR4u4ZhIUZAwLDtbgK?=
 =?us-ascii?Q?OCqK/3XLE/4vzN2AIOcPLLTzYBdgSTs4QZ4u0HcRKEYw+Ac/BWou+eJNZj7V?=
 =?us-ascii?Q?GTLvIcla4Qx8+eupcUrzxqLemZRVXj8PQqlf/zUv3EnPHW08weuSW8vVxxUl?=
 =?us-ascii?Q?uDbdjhx2awoc9mmxn8X+iQxU6Ox8jK/cSfoMhvfHR4mrPBGkMHzNqctLhqqG?=
 =?us-ascii?Q?JbQSbzmOezvJY4dwYi0ChZg/8T4BCgCiLI26Snn6AqhbAvA9slSjBUQwGuIS?=
 =?us-ascii?Q?Sgn3YG/bvWHwZ/lL24Z05lZeOzHmm+m0HKnkESIWtdttgltUq6IbfXeu/aQY?=
 =?us-ascii?Q?H91uNs++EP8gilZ7gRQgq1qLxwjayWpVjdPSv5HMxKyG/3vQy+DP3E02lKti?=
 =?us-ascii?Q?OrSUZODq+JcjBuWUxwVH8IvG9PNofusrv07qo1W+793xGrhJH/kQcjH3D41c?=
 =?us-ascii?Q?pwWlxh+GaFzUq0XYUuO/Nx/psZOypa3bVlEG4RMHVkJec5zWdbC/KuIoZJhv?=
 =?us-ascii?Q?NY5KJpZmIalbSgaxfDfPPl9d5ZOLtyPAPS0kYQ5f0H9layghGgR9nfXuVCKO?=
 =?us-ascii?Q?NEZ6mbS/PdJC9VjRyD1M+WOGYVyNdtHsjd8elSWdPsWnx41cVwa2Ih9M+4RO?=
 =?us-ascii?Q?1Cr/Mza9VLPTCxG4ZjqgR1CF43CxFbZEfGqTHyHeFgDOMwJak3vkX8Us8qQL?=
 =?us-ascii?Q?waAikGh5F8DMQyZto9fTfzTtFHHtIHLIg8Jd3dU/XB0Oh0/Wnw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740f87d0-32c2-42dd-6894-08d8ce10c892
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 22:11:15.1882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rBUCBTmVFRKg+zCBHiYeb8nIBu3jukmK43429OGGuP2U4CK01vn0XQkoj/HAOXH7J/Gw/u5vl2oqHlcYQv0OCqPZY9EBkpyXCLRnf7oMLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_171121_488431_838CEA94 
X-CRM114-Status: GOOD (  19.11  )
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
Cc: "hch@infradead.org" <hch@infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Gopal Tiwari <gtiwari@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/21 5:20 AM, Christoph Hellwig wrote:
> MDTS vs Write Zeroes is a common misconception.  We had that discussion
> in the NVMe working group, and while the text should pretty clear that
> MDTS only applies to data transfers many implementators did not understand
> that, which is why we added the clarification you quoted.
>
> Also the next NVMe spec will allow devices to advertise an explicit
> Write Zeroes limit, take a look at TP4040 from the "NVM Express 1.4 Ratified
> TPs" at https://nvmexpress.org/developers/nvme-specification/.
>
> So I think limiting to MDTS unless the new WZSL is set might be a fail
> safe option, even if it is more pessimistic than what the spec says.
>
> I'd also love to retest most Write Zeroes quirks with that in place.

Do you prefer some variant of the following patch (totally untested)? OR
something else ?

Also, I think we should gradually roll out the MDTS replacement and
still keep the
write-zeroes quirk unless you are okay to just replace at one go.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..d5ca27608881 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1167,7 +1167,8 @@ static int nvme_submit_user_cmd(struct
request_queue *q,
                if (ret)
                        goto out;
                bio = req->bio;
-               bio_set_dev(bio, bdev);
+               if(bdev)
+                       bio_set_dev(bio, bdev);
                if (bdev && meta_buffer && meta_len) {
                        meta = nvme_add_user_metadata(bio, meta_buffer,
meta_len,
                                        meta_seed, write);
@@ -1967,6 +1968,7 @@ static void nvme_config_write_zeroes(struct
gendisk *disk, struct nvme_ns *ns)
        u64 max_blocks;
 
        if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
+           !(ns->ctrl->quirks & NVME_QUIRK_USE_MDTS_WRITE_ZEROES) ||
            (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
                return;
        /*
@@ -1979,10 +1981,15 @@ static void nvme_config_write_zeroes(struct
gendisk *disk, struct nvme_ns *ns)
         * configured based on the controller's MDTS field in the
         * nvme_init_identify() if available.
         */
-       if (ns->ctrl->max_hw_sectors == UINT_MAX)
-               max_blocks = (u64)USHRT_MAX + 1;
-       else
-               max_blocks = ns->ctrl->max_hw_sectors + 1;
+
+       if (!(ns->ctrl->quirks & NVME_QUIRK_USE_MDTS_WRITE_ZEROES)) {
+               if (ns->ctrl->max_hw_sectors == UINT_MAX)
+                       max_blocks = (u64)USHRT_MAX + 1;
+               else
+                       max_blocks = ns->ctrl->max_hw_sectors + 1;
+       } else {
+               max_blocks = ns->ctrl->max_mdts_hw_sectors;
+       }
 
        blk_queue_max_write_zeroes_sectors(disk->queue,
                                           nvme_lba_to_sect(ns,
max_blocks));
@@ -3141,6 +3148,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
        ctrl->max_hw_sectors =
                min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
+       /* explicitely set the mdts value to 0 */
+       ctrl->max_mdts_hw_sectors = 0;
+       if (id->mdts)
+               ctrl->max_mdts_hw_sectors =  1 << (id->mdts + page_shift
- 9);
+
        nvme_set_queue_limits(ctrl, ctrl->admin_q);
        ctrl->sgls = le32_to_cpu(id->sgls);
        ctrl->kas = le16_to_cpu(id->kas);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0a73e78f09c8..7b60b2196d23 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,11 @@ enum nvme_quirks {
         * NVMe 1.3 compliance.
         */
        NVME_QUIRK_NO_NS_DESC_LIST              = (1 << 15),
+       /*
+        * The controller doesn't allow the write zeores command of size
+        * more than reported by the MDTS
+        */
+       NVME_QUIRK_USE_MDTS_WRITE_ZEROES        = (1 << 16)
 };
 
 /*
@@ -268,6 +273,7 @@ struct nvme_ctrl {
 
        u64 cap;
        u32 max_hw_sectors;
+       u32 max_mdts_hw_sectors;
        u32 max_segments;
        u32 max_integrity_segments;
 #ifdef CONFIG_BLK_DEV_ZONED




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

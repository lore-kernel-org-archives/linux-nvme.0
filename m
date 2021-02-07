Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54104C433E6
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:58:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0876864DFF
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0876864DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZiZ40FkZR0r6ncF1dZDg9hwBDK50QyU7VK7wPihJ8ls=; b=TsgNVSoJOMmtuRbGt7W7rLQYM
	RZhWdDZkaDdkYuX1uPGYEAvmNjmeFsqIS8TiZPwTo7tMUafQwhQOdVJkzjybREaKXRGQg2uWDVPUD
	Bf/nfgcMi1OSSbVXlcPPNvYNoUY/sZI7XufXSJprbQ1tbcRUb9D6tthkpDFF5ZOJAEf7gT+Y5dcjH
	AuEeuSRmdIPywCgoX0IC1AQWzMqRZ4CX3EoiIIB+0UsS60/FN4U5TUR940U2Y7hH8rTOBiWkD9lZi
	AMS2/QOVZD5IM1yYuN18932GnEZbO7y0MGrwooQWcp9bt+E5rAl8J6kLiFr8sgIyzKLoefj6I21bZ
	PD/sKAA1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8pGX-0003TI-6y; Sun, 07 Feb 2021 18:58:37 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8pGS-0003Sr-BX
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 18:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612724312; x=1644260312;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=duxwMG/R0BhdhTAqQ1ivaRk2f96xbF0TdmujsYZWjgg=;
 b=ICVl1NiOrkX9uFIcr3hQqgEGGDCy2cHz6HhfF0gnaQn6dxakY9wTKBUW
 njAnXqN8McFD07GlwtqOpcWnkm/d19BZZkrON+7jgvS0QSZESPMk7PThu
 wf/0t5YcdgrKeI+5KF2kmBGFqXL09lG5v27FM4dsVZ7cY2UZVtByZNW0t
 Teau0lREk9twHIvaYjHpid6hHsBA8zZUucGidwQL9BNvUyA/rp8gSRiJ3
 QVOodSfwACwtM9av7aJ+pbi0Cr/kGff0mDgNKEwjoppSTDiGg61s3bBcQ
 YN32GpDTBqeGviKw3rBs8FEQBbW+/301gb21XHxIp4tpMEqbcOOxCfvsp A==;
IronPort-SDR: K3C3Q/WF2SUxKm2dvi4D7iU3KL2kbJvyUTM1kPIQIQwJXJrfBbUozzvubuX6S7Jjk7DSEBJ1+n
 kmxBbSyte9esdNAnAgX4jWfGiu7c0P0XYPx8aeQjIRupzJ07TnWU1wisgwhOTdg90o+HHHdlv4
 iPSSCY6YNUgAy37JI9LxIJ8vupkY45tgN5DVYwrT3BiJxrgbGsVaa5Qrc2/5Tl4NZf6hvincZ6
 7MW0Rv62snLeWBGCBHZ+Olpk6xS/fsm3jXoP8jAzGdYqQ3npx/CAxL+/ebJ/2vKqyVCNQxiEoc
 cK0=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; d="scan'208";a="159399608"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 02:58:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfmG+CjLc9R0//p/4cxziplZpYSYBUflnOVUJzgDE4l/6NGfethFC0sbSxQP3VOqt4oE3LuPYr5gGgHJGhRGzvYHNslfVpGJiNLoOUNQcr8J/9Pdt+SrmKPkp7PQk2Inh7UEO3MoFG46CyS1sNLe9eY3l9XAiFPNvnCnibQMpP9GuLxUq0JLSnUGXMBl7qPMLXvk/+QZNooHSjOgO4ip4q56yuRcHegjUiadmaYPscNPYbHrg35QUy+5QykhVSZpk7nrH24yH8/njCUpO8tpNbPnzuChlnJVxDEHqPT0p+EgiRjvtKNArBZ2RtM860CT83GZwtCxVLkBJlo/bdDwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duxwMG/R0BhdhTAqQ1ivaRk2f96xbF0TdmujsYZWjgg=;
 b=FNmygGQZOTFbHdvd6K3szJtZh4lib1oLnR9qhvfq2B84Ia7k9BPeLwb0YaHTd7oHd41u1LaXHH8xfs4HMb1Grm+hsrlB7naaoRXb38QOoLbgIi+Ct3zi8fVrD3IMzfpGEJIuMU+mEgsNCQ5Vz5H+B+++nijC/zvVCFkUVW8rRSmalfK4AHh8qc2wp4EAAQtRbWxaCT4IBKw+ulXW3gs1bhxcInQK0OMNGKDnIa1u6ffSqvyVosUPUjg5lxkL0Fw3Av7BmHD7x5WypNX93hgC3LmRyXFJEDsXP0gt4JnCP2skRXhOxr9/CGoFBL1shjVmXuAvDoCzkDOMHxpSD8meQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duxwMG/R0BhdhTAqQ1ivaRk2f96xbF0TdmujsYZWjgg=;
 b=ThQPTjmN+s3klvUVdZ6XV/j6wKwZd5OOLI3KUPgDIWnkbnZTRsfkTl1FmlWN/opNWUOrncXLI0m4qQ7jUL7Y7iGwrvRvktCo0n8M60nmjqke5Qzz+cGpvQtl1S9OtJQDqaILoFYlaXFbc5YMP/Z0Gfu9ylPRW41Yfp2ucMQON48=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6690.namprd04.prod.outlook.com (2603:10b6:a03:22c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 18:58:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 18:58:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "Eldad.Zinger@dell.com"
 <Eldad.Zinger@dell.com>, "Leonid.Ravich@emc.com" <Leonid.Ravich@emc.com>,
 "Elad.Grupi@dell.com" <Elad.Grupi@dell.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH] nvmet-fc: add a missing __rcu annotation to
 nvmet_fc_tgt_assoc.queues
Thread-Topic: [PATCH] nvmet-fc: add a missing __rcu annotation to
 nvmet_fc_tgt_assoc.queues
Thread-Index: AQHW/W0z2O4fTitwq0uM7A5fpJFkhA==
Date: Sun, 7 Feb 2021 18:58:22 +0000
Message-ID: <BYAPR04MB49655AB622A135A6FBB6B97B86B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210207162028.2959778-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57ef0411-a7de-4594-8d5d-08d8cb9a576f
x-ms-traffictypediagnostic: BY5PR04MB6690:
x-microsoft-antispam-prvs: <BY5PR04MB669006EB46B653C4711ECA1486B09@BY5PR04MB6690.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6u/60evSNtW5ST6N7RKa7IPpf2AiyHv3fSVPYSQZ/Pe/F4Y67MtnOOL3gxq+J/YAmMpylY7eGDHixRV5k6XZZJLZlBQh2ClD48yZ4CluiEOsj9L7XGYF21wqPPNX6TKU7FXcZgYlY1w38qVzwQwBosHwX0EQ+Dv9yEJI/fw8c0PV3wJbGiEY6XEmldbRSHltKUXFU8Cf6a0/kiM6kQdAJq6BtUtoi2c0/y5k9t90MImqK1B+dVgZTCpc6JxhHK+3lU/N813W8jRMhTS+iF1R+goFRRKNKRUfhBsn79Cv0JFDNgTfUhYGtbU+kYJ6a1POPabwOtQlIgjURN0snrDQoIxk5DWI189L5e+IIF2gCc2A+Q+GAWUuqp1OJyzKtIAz0OJPt4DvmIiB5YT53PwEY5VEhe1teLXJWaTAVVcJdsb01N0dFvE4Ol9KcLvEsBONDnkGIzxAFbfSQtFBVCQEVUaXbaPie3lRMp/H5yotJx4fXg9mryZS/9CdDWX9EJa9/hmhMnj9clQgVep1PqS1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(66476007)(33656002)(316002)(66446008)(64756008)(66556008)(71200400001)(9686003)(478600001)(186003)(6506007)(86362001)(76116006)(66946007)(5660300002)(26005)(2906002)(55016002)(558084003)(4326008)(110136005)(8936002)(52536014)(53546011)(7696005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gwNIhNcdRj0aoa15l5kb82EszqvsDhj70++d4Pcaq4nvFJIzIP5Fb8+mREtS?=
 =?us-ascii?Q?QX+BIFi9IOUV6M0A0nHFnzgruxET1qtygOfMuB+e5BbV0FAO22vviQVIqNXA?=
 =?us-ascii?Q?DpoBUXGzyd4MGI8lSvs1IimMaSFOnmRB7qQThkZlELPYX97sj+4QtnferTNd?=
 =?us-ascii?Q?T4rpywbz3zRx/MnEG72zdfXTDtT/7RewUc79Y5TkCTJTW4EWhK58QnXXF+om?=
 =?us-ascii?Q?JxOWSa1Z7k3OyCB/eA5yv7eEsANym8YY4Vst/fLvFibPpsOxnLV7EG2c5axP?=
 =?us-ascii?Q?zuIMv0VbxJ7BOWKVjJKKPYStjeGetrjMRkz4A3piUNK2bszMM1lIGDiH80zy?=
 =?us-ascii?Q?TXhEu85nnW5mS6TkXsejTlbbLKeFUsptJRb4GGsOQhGdNx/MZobygeutVUCP?=
 =?us-ascii?Q?KEgWgfysmwx+bHlTtzWfZNuY1TGbkQ4A3w27/Px2o9vy78peSV0xld+qHSVU?=
 =?us-ascii?Q?62dqMVCo2vAbhD4bF3D7ihNJiQs7wCBDEzrRv2STfCWneeizKbNXwoZqmxxR?=
 =?us-ascii?Q?PO+duJJX95W25vSLxt4uTxnsFVLSf7tALUlxrM804rzKWHpE+EKm86ncELT2?=
 =?us-ascii?Q?vFFSahO7qOenq87T47KMrjDKIec/tkV1yWxjBe6c3WkxpfFEVOGgokzNYNeU?=
 =?us-ascii?Q?PrWgxDbA4BqtzkJySC3yxl7S+obysEklwjLQaBHnqEozpTORII1VqwBEOotP?=
 =?us-ascii?Q?mkhsIQdu8fYwxlMlTM3O09ZPRJ3D7FlJBQ9yE05Z+fFL5c7pSTYVT41f6GPE?=
 =?us-ascii?Q?rAOt075CrR/aua80bQGaGx0n7o+g/YvXhzhRHFY1XWAhlOnlSLwoq7pUit/q?=
 =?us-ascii?Q?renJja34qJscbLAUjOJvkYt8KGhh0D5zMW2LW+ICqStVPf1UNKsmrYCl96Oa?=
 =?us-ascii?Q?zvqe/EDz092x5Ft44KqvILJVEOlQgYyYrMZE6XaKejpMWhlJWS/oUd8D7sNz?=
 =?us-ascii?Q?vFza5OowMfyeiXpKrFZf3Krwrd9VclKuAAJDLMj8q8iG1b8cT2VZWtEMEoQU?=
 =?us-ascii?Q?il0MA+xDKzPnYj9LUtfVkQGC7bB8it1RjRWVJxshmJhatmCNo6rEma2FXvG1?=
 =?us-ascii?Q?W7HbofTYOxZhqIPVUCDukYCwxZBgMBw2lCkdbapXKl/xv/IMQaqqRZZ0qYSY?=
 =?us-ascii?Q?aVk5EwL+jpFEdNgAmmQXp4ab6LgDRmgJZrM39aKPCT5IKiSYZ1dkZqbZjxZL?=
 =?us-ascii?Q?PYXMLy2tbWlp928WVX4Ok8bCSMnJyNyo9YBtc66JOSxEwJfgC50mXBenyucr?=
 =?us-ascii?Q?DMMz0PJmGmiZFkkBJTpEqsG6mGLMQ5BajQ0Z8f46hi67Ibwl9keyYHHyR4WK?=
 =?us-ascii?Q?TZJEhNuR00OMWVyBSHwHI7d1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ef0411-a7de-4594-8d5d-08d8cb9a576f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 18:58:22.2797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1TUTR0Q6abZtk5nmYT99i6tRdVCMAcwdBfHtGWcsKMNu5qF5HKME6yM4gsSewifvJRsQSQqts3hS7mp+JvJOMLQPDGUpDVhIssVUeoDcpKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_135832_741938_133CFBDD 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/7/21 08:20, Christoph Hellwig wrote:
> Make sparse happy after the recent conversion to RCU lookups.
>
> Fixes: 4e2f02bf77da ("nvmet-fc: use RCU proctection for assoc_list")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

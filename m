Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05BC10DCE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 20:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE14C2074D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 20:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxyDi9hM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DbiPpqzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE14C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OT0jCV6F2fo/78+ZMnH37KE+k3lu7R8ny2WTlYowdK4=; b=lxyDi9hMFCgZWW
	jRb1NjU2exqSTSDkZHaf56P1tgrqtjVcuwO0S/4bXZ55nMvt3DxjOVjuFL3Apqg/6Jf0zx33fevWx
	cs90KzePz9AU6oAtTjDqzCVCW1n26yCQ58S3I/MJzNmh4jGrmqdT64Wy/wMAUcVQyW9zJTtfWLZ2x
	AEtTDXnOc/GUYl3K1JQuSPcvuB00jx65cDp5Aex+/zipgStPZ8BkgkPEUbEuuexvjrb/3yxfFFUfY
	kY7zyUsXKqeIyBCWMnNBZLQeWYguaHBUsc+HGdPXy2rXYFJ8LNELp0w4A74CMibTIvuEn/iC9fMb7
	RkVSnRUYgwcWclglK+eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCr7i-0003ss-9j; Fri, 13 Mar 2020 20:41:38 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCr7f-0003s5-Bz
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 20:41:36 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 13:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; d="scan'208";a="416412698"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga005.jf.intel.com with ESMTP; 13 Mar 2020 13:41:34 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 13:41:34 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 13:41:32 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Mar 2020 13:41:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 13 Mar 2020 13:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjUsNXMrt9GAO+B1nsocYsND9XpvhOEM/t7CAorEArIWRQdw8fZ4WAcqEU7OR7b/GEEd1JWLpF5CdnLU8kQAu6bT7fVYUXfuzQlJJ9ljjLeS0fjzXVh92hbMIJDYTjT6tIFb18vprtc47ITsAZp/JxDu3EWVPNiWEJv2foHtwT+zV5UL1+fRLdOkgmiCT9YSHLHB3AAPF6LbaSNUyEbBSb087Qm/ynvbw34WdYzmX3p7+1kJy5lGHx9YDFtutEVgKFxayRwL8ZQ3lS0Fntwz1ddA4PVLRBZ6vTqfrffKcBZFrv5FmIHRpyNNEHWK1KC0zFiViGmjRHB/n448iBF1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LecZojRzG8vMg99Nvb9nJhCyt4XAW47fNYG4kQno7nY=;
 b=IIj93GZ8myrn08PnKYAepyqwgBKCL5/RskHXT+XvpqfWVapkN+vAYiDQkNkTMaCOENulFUi80lfHXxi4UAJHMiWmIZuS3WwOlSxoc4e/DFa1NIJ8wRu/1FNmwTj8vm5IdFvmYdPIK/yrkzbRl4z9p6x6a4wioPNp8eN9mnAbJYgVsUahWeIa2zsOhsSF6uzGzMcvRyUxRcXkteeNIKQhRWWjl+Y0thDTQdgahAt3jX43DA++BeE8zUA6oxI0dT26Pn5RLi5WJI5l0HHotyh6SIyZxFLL8jP7LsqAbMJrO8BP0sLLEOcbmYXgX2m/MYgS95H+T4kzYXlDITDEyfVePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LecZojRzG8vMg99Nvb9nJhCyt4XAW47fNYG4kQno7nY=;
 b=DbiPpqzGtl/NbarxiuZro883w5jMSGAHN+wonQlN/u65695iSRYHzYwbIV0uTLfSMT+dF9x7/pCJ5SjKZErWYkT9F597ff6XMxo+TN+ZEr2ooA6rfre6BRdKTGjNSnex5J1IhohBz5URZ4zJBmux9+rl1xlCOGEPoiE/fRLceas=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9)
 by CY4PR11MB1749.namprd11.prod.outlook.com (2603:10b6:903:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 20:41:30 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc%12]) with mapi id 15.20.2793.018; Fri, 13 Mar
 2020 20:41:30 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v2 1/2] nvmet-tcp: set MSG_MORE only if we actually have
 more to send
Thread-Topic: [PATCH v2 1/2] nvmet-tcp: set MSG_MORE only if we actually have
 more to send
Thread-Index: AQHV+MMArcXSj3HKz0Cy3HhDYnuIwahG/M6w
Date: Fri, 13 Mar 2020 20:41:30 +0000
Message-ID: <CY4PR11MB13519F09F0A5D030306283AEE5FA0@CY4PR11MB1351.namprd11.prod.outlook.com>
References: <20200312230639.13946-1-sagi@grimberg.me>
In-Reply-To: <20200312230639.13946-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d03b3113-5b26-4b8b-18a0-08d7c78ee93a
x-ms-traffictypediagnostic: CY4PR11MB1749:
x-microsoft-antispam-prvs: <CY4PR11MB174926E029225ACD433D8197E5FA0@CY4PR11MB1749.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(66476007)(26005)(66556008)(71200400001)(5660300002)(8676002)(81156014)(4326008)(316002)(110136005)(54906003)(8936002)(4744005)(186003)(33656002)(76116006)(86362001)(66946007)(7696005)(81166006)(66446008)(6506007)(64756008)(478600001)(2906002)(52536014)(9686003)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR11MB1749;
 H:CY4PR11MB1351.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YmbKiYPX8bJz+eod/WLiaO5x3l74xFtvB4uG2bP5VAbRyJEW9FIvSb5HI+/xMqTkDqQhrrCvubmORUo7bLcZsLRON3YrqCY2m7EYNxlngXnHT4HRRd+/E11vqTAxlzj4fiA1fV6/DbGz+f+R0pieJI64BPPgizpn6jQAB9XekE0TK0wbUVSnpyu0rTgewgSJvV1kuLJv09594rNliM64I48lLVIK9AQDgh9H8rX0v3087+7CAAcZ4M36cvseKGpA81fWqy0cY41iCZNjlWG75e6+WC/3BOKMyG1JnrT/giSbH3Rxulsszx4ZtCcS93OcOQbKVoXv66k60qZuF26Ohqgmk+fcR4OgzAjGvy7BytHuTu6ePSEEacEZLS7/KaMonGpRE1KCJoPTb1BT/Dvpdz1KMBXJKYjmQX6OXzL3IXSnQP+UyRK06p6YEz2gK/N4
x-ms-exchange-antispam-messagedata: tPpusKp8iWhGwQWKLXZ9P8z7ym5GKA+dGYJZ5FVAVl0B1ult/3LmSRskqpSbbiK5zYtiVrWEmVXwHIoa2WKspzsIgHBmm+S6vbo0qG4u/BKnDzuVJBlibbdqb2cof86gYf6xjaVpd3Fu64tzntSJRQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d03b3113-5b26-4b8b-18a0-08d7c78ee93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 20:41:30.7397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZ0q0Y2YfNA1AK+dzeGG/i/EdN78Y3gqzvv78+0CFLfrbGOUSbr9kF0eVYXxgbZKBk0dvu0O86zIa1PUt96Y0RBXAu7+cRNNnNP945oiN8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1749
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200313_134135_491547_ABBF3BE2 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> When we send PDU data, we want to optimize the tcp stack operation if we have more data to send. So when we set MSG_MORE
> when:
> - We have more fragments coming in the batch, or
> - We have a more data to send in this PDU
> - We don't have a data digest trailer
> - We optimize with the SUCCESS flag and omit the NVMe completion
>   (used if sq_head pointer update is disabled)

> This addresses a regression in QD=1 with SUCCESS flag optimization as we unconditionally set MSG_MORE when we didn't actually have more data to send.

> Fixes: 70583295388a ("nvmet-tcp: implement C2HData SUCCESS optimization")
> Reported-by: Mark Wunderlich <mark.wunderlich@intel.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

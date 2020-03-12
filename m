Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB9C10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 22:50:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353AF206CD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FoR8gHW8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Qtl63jhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353AF206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N/YpvuXiumlhP0arvtF+Trim7a3cEhO2bAl6zUb3cho=; b=FoR8gHW8jo98LV
	VmiEdj0PdPkSvWv8hvsFAMGc3m+MsGhRiK8nbW5Pnd6bLHpk1yEOZXkcU2jO0WneXyafC5WW7iHhc
	kN8zrZWjfXXo76926dHSrWbaIx7Brxiav2ltVCmTUi7bdVrlGTDZUO3VxaxZmiLKCl5KdeVGNkqE4
	0zyhZg+5U8iz/EB5J/k3ibZXwcbaj8jzKFWzPxT+E/KL1zZ6MIWvwFE7lCnpl+IPwPEIjNqgOp8HU
	YLWestjsTlkbQjedHBF7SAZp57bb84awsOpTo0xPhHul7VT2+LKcwHdGN3I0YZlUhMMY0BJf0WS8D
	HWfLzgqLuasrGKpPhwfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCWeK-0004b2-GL; Thu, 12 Mar 2020 22:49:56 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCWeH-0004Zo-RJ
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 22:49:55 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 15:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; d="scan'208";a="442224417"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2020 15:49:52 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 15:49:51 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 15:49:51 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 15:49:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 12 Mar 2020 15:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBHSPK4xhkvA/FzXUaPrf5zgliPGllXWYzARo3/x6cMdLv8xchOFSa5c4i5sNXwqCKbQe8M2e/CJZYzFbl5QtPALYtvVQMTIF3WHlWeBV9RPURedzOPNrDUd+QutmgM5zLSnUtPwtJhzUUiNIAHmRkFnXeka0Kc2G8qen7ispRUMiLv3t3sSdVkZ579HojM3sK6+6OLFAykeMVwTklB61rEdHH9iCcCtSy2atMs1nJc+hNTsqQbk5P3MsZ6oxGrO1QtKU4FSLPOpFUpo7TdjKyoEzp5uZNiBhtjyYuSB+WaDjDBahFHHxSqLFrVAzJN7tgc8F1JhFBHEXB1l5m0YzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73v1Y2Ep/OcqiR8x3GlMcM634864CltVdG+bxBN3/p0=;
 b=n5cXtD45PrCYrT9FBCWNFRRBrVCzdARWIPOJVCsZC4pmOeXcFedvk0oBvUvZ2fSnOErdEw/89gRzJci98AFGyKUdZv/zncaOabJG6Zs0L1+ZNfZuGeISZXY40nv1En5/O0gmvmRwuaXk+uk6oNEL4V6qaAcQZH4zYoJhCCynn/MvdkraU9MXEnRn3xuT4nVRmSA9GEUiLCv5oCg4BMfXgEu7VDyH2EQF6ifFQE0pov+b2bsOFg9eCggnc30ExctDR430P68oC/ac0Pq18CNJU8C9f/rrV0wjsDRR4dHboLf7/JTd+ihoHwq0dY1sRyREnbyC/7bst50gVds7AJjqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73v1Y2Ep/OcqiR8x3GlMcM634864CltVdG+bxBN3/p0=;
 b=Qtl63jhGGIlOsDNA42006CsjsAsSbtiMbsfIduVx0bZEqOaJ0QX4Rj4hIYrjyDayrRXm+e+hfE3gqwgClanU/gOqQgN8lbFtZzyvMwrSk0X3GOCKgBHH2CPx63YksZ3dqkerLM9CVcEyWRBCeX7OIP0CN+Ok85aPKa182FIWfaw=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9)
 by CY4PR11MB1541.namprd11.prod.outlook.com (2603:10b6:910:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 12 Mar
 2020 22:49:46 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc%12]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 22:49:46 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 2/2] nvmet-tcp: optimize tcp stack TX when data digest is
 used
Thread-Topic: [PATCH 2/2] nvmet-tcp: optimize tcp stack TX when data digest is
 used
Thread-Index: AQHV+Dcvu4WyzMa2QUu1mihDRk02fqhFj6GA
Date: Thu, 12 Mar 2020 22:49:46 +0000
Message-ID: <CY4PR11MB13516CE3B702DC7EF4B25D7CE5FD0@CY4PR11MB1351.namprd11.prod.outlook.com>
References: <20200312062603.2572-1-sagi@grimberg.me>
 <20200312062603.2572-2-sagi@grimberg.me>
In-Reply-To: <20200312062603.2572-2-sagi@grimberg.me>
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
x-ms-office365-filtering-correlation-id: 35829f23-e512-4da0-5159-08d7c6d7a9e1
x-ms-traffictypediagnostic: CY4PR11MB1541:
x-microsoft-antispam-prvs: <CY4PR11MB1541138E4B7F6F19C4F312A4E5FD0@CY4PR11MB1541.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(66946007)(55016002)(186003)(76116006)(86362001)(6506007)(8676002)(81166006)(8936002)(26005)(71200400001)(7696005)(478600001)(5660300002)(81156014)(316002)(64756008)(66446008)(66556008)(9686003)(66476007)(52536014)(558084003)(4326008)(2906002)(33656002)(110136005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR11MB1541;
 H:CY4PR11MB1351.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4KepxTbuTGebp3ZqspH22cimdc21bOUq1d8Ksz7X+xmvtshv0uM5trfeF4BnrdiR9STHPmDG4rx6Xax7AD0bgEXJ1+uYRaBk6jygvaOvwm5GHUube6O3uQDsVrgdgpFDDznsV6WJDbOFImfPrcOKNvgF0s2LBdf21BwS0kfZJ6FWLxbRgLgbIE9ShVqJQG4gf0iap1lldNOlpSo4+WJEeei9M0nFLvSKZCSuD89AHADzPUTRF/NEVvCEqT7TN0qDjrJ6WnPYr8JIpIt5dR4zA4nvj2vqG9tECdZOiGFitqAyUedwpjhOi4e7mcWEG49Af39c3vPsHSXAErDwGZdhI3VqNEiP2uSTOkTbVSmGGcASS3SeUXHiAf/3pAYhTLuVLS6uZTgSShZosikGQCFnoH1+ORUVuy0XQfNVM/y+HgyiEs97k/Mm814Q5cDeFNR
x-ms-exchange-antispam-messagedata: v3uFVwpnLWDcwu72tOMZ/s/1by5SfB+9GON7Vgu05Dnj0zT+9ty5gnvSTvcHGH+dpmvGIXzB6vKUDZAsJsJImt5nNKNTOuMJPB55a7/OIUc9iQ4aSwNd3xOUpDyKV/qJ6e/EtH5MkFtAc6/MTjnVEw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35829f23-e512-4da0-5159-08d7c6d7a9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 22:49:46.5719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTFbqCauswccDDZlloFKr5GkFCi3ax4XjKPkcZ0ug0C2i3qwo5o7dnJvG+SQV7t/4tk++fzrfwPfLJuKNlG8E2ItrLhK1teGPs0QCNmJfjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1541
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_154953_991410_31C1F4F2 
X-CRM114-Status: UNSURE (   7.62  )
X-CRM114-Notice: Please train this message.
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


>+	if (!last_in_batch && cmd->queue->send_list_len)
>+		flags |= MSG_MORE;

Should this actually be:  msg.msg_flags |= MSG_MORE;
>+

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

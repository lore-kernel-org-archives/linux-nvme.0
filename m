Return-Path: <SRS0=ACpZ=Y7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCFEC5DF61
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 16:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CEF218AE
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 16:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWG6J56b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CEF218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/OZWP1kIaYXlB6Cr4EDGodrBGcHkDHZ5HarMt3nInto=; b=HWG6J56bQXVq9d
	EdfYekL3KgfcKVuwYowlbNmGy0nTJkxTQGfaal/q4xMP/3BHJE/zjVQuyU1HJiJxLn7SqFFgqxFA2
	5d5soY4z0qMyx4lxFtDeMChK67MYYkORBj1lv8gc1rIbwfG/uo++pYlVsN2QgdjY1bC/KW2ZXoa2v
	2ysL8XuZQ/vj3ilf6nNjzgnY5SMMfGUsWA1dRbLAY57XfZs4JO7mPya8H6i1dbkJDzIpbP0spscRT
	PqleXD27VLhtYIgk6Zdl+0tleY0wgGw0Y86UVBEF6PC6TibROR97F48kWEGI6uxz/n8sCtwFVUUbm
	oukC4hul2DbzzMUIU8Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSkLR-0007wv-8F; Thu, 07 Nov 2019 16:09:13 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSkLN-0007w0-FR
 for linux-nvme@lists.infradead.org; Thu, 07 Nov 2019 16:09:10 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 08:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; d="scan'208";a="214641417"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga002.jf.intel.com with ESMTP; 07 Nov 2019 08:09:06 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 08:09:06 -0800
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.167]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.60]) with mapi id 14.03.0439.000;
 Thu, 7 Nov 2019 08:09:06 -0800
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/2] allow for busy poll improvements
Thread-Topic: [PATCH 0/2] allow for busy poll improvements
Thread-Index: AdWPZPmJDNMuypQPSDiBzjHO6knvSgFn45iAACAdr9A=
Date: Thu, 7 Nov 2019 16:09:05 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D4E890@ORSMSX104.amr.corp.intel.com>
References: <B33B37937B7F3D4CB878107E305D4916D4AFB9@ORSMSX104.amr.corp.intel.com>
 <5f3d0fb2-7a9b-4655-1052-60ba66499746@grimberg.me>
In-Reply-To: <5f3d0fb2-7a9b-4655-1052-60ba66499746@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzM4MzM1YzYtYmI0My00YmI4LWFmMzEtOTAzNDViNzhjMDY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid2FYYnlIMzZcL2FHXC9XRU9LWlNBQXRBb3hpbmljTmtuZWRPS1hzb21xeGVGaTcxbW85SkJyeWUrcDVjeEZFWUp2In0=
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_080909_557154_58963064 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Proposing a small series of two patches that provide for improved 
>> packet processing for a fabric network interface that is operating 
>> with poll mode enabled

>Mark,

>Can we start with a series for the SO_PRIORITY for the host and the target first? IIRC you mentioned that enabling this alone will produce an improvement >and the change is completely harmless.

>Then we can add the polling change in an incremental series on that.

OK, will re-submit new series for host and target so_priority change.
Cheers
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F976C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 21:42:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E90222C2
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PAReP4hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E90222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qmq7Z0IuMoppDwzKUpcaEDWHYlUPCBgtv6AinqQ4VpM=; b=PAReP4hr1kT5Th
	L1OIzsNZxxtn2KnG2rWsgA9iwH5aqimQNQ5bL+MxR/QB1mQOsMICMNQhjKZqXWUzT30TqahWFfRzO
	paftyCpk0YdvL5vya6JMYG+RslumIAJG2nWSX6xbElXphWBZIkZyeLxcTw95Maqq7nSM7SVMcySOP
	vqkFI0fwyQn4TRpS4PsS+p8QPRH8pMfgR6o1qUq2hkIIEM6X0iDxpyTA1KuFSfGYSsh1rrT/Rb4Wn
	3neerDkhN0/hdXkQx+aBC8V2zalG1mZ1KYSlMX8B/qFBKZmRAWDjL7LZiAiqJ6AzGiqK6nfAkcdsu
	5DBYZusNm0epTHYO6c4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDbWV-0006W4-CT; Thu, 26 Sep 2019 21:42:03 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDbWR-0006Vc-Mq
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 21:42:01 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 14:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; d="scan'208";a="192958181"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by orsmga003.jf.intel.com with ESMTP; 26 Sep 2019 14:41:58 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 14:41:58 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.236]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 14:41:58 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH rfc 2/2] nvmet-tcp: set SO_PRIORITY for network sockets
Thread-Topic: [PATCH rfc 2/2] nvmet-tcp: set SO_PRIORITY for network sockets
Thread-Index: AdVy7olN4qiL2uIRQnu3j96e/6QAkQB8ajUAAAvIBYA=
Date: Thu, 26 Sep 2019 21:41:57 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D37D17@ORSMSX104.amr.corp.intel.com>
References: <B33B37937B7F3D4CB878107E305D4916D36846@ORSMSX104.amr.corp.intel.com>
 <63782282-026f-b12f-7a97-3e5d9643e262@grimberg.me>
In-Reply-To: <63782282-026f-b12f-7a97-3e5d9643e262@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTg5MjdmNmEtN2JkNy00MzM4LTg5NWUtMGU5YTBiOTYwZWRhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnJNSXN2T2Z1VVNNdGM5Z3dBN29Eb0V2YmRMWWZNZHAwVHg0QnplbGJTR3prQlRRMVhueWR4QlhxMEphUmlTbCJ9
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190926_144159_791870_86173ED2 
X-CRM114-Status: GOOD (  12.85  )
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



>> +/* Define the socket priority to use for connections were it is 
>> +desirable
>> + * that the NIC consider performing optimized packet processing or filtering.
>> + * A non-zero value being sufficient to indicate general 
>> +consideration of any
>> + * possible optimization.  Making it a module param allows for 
>> +alternative
>> + * values that may be unique for some NIC implementations.
>> + */
>> +static int nvmet_tcp_so_priority;
>> +module_param(nvmet_tcp_so_priority, int, 0644); 
>> +MODULE_PARM_DESC(nvmet_tcp_so_priority, "nvmet tcp socket optimize 
>> +priority");
>> +

>No need for nvmet_tcp prefix I assume.

Sure.  Was not sure if standard practice is to name such params specific to module.  So 'so_priority', or just 'priority' would be OK?

>Should it be a bool if a non-zero value is sufficient?

Since various NIC vendors may use different actual so_priority values to trigger specific behavior thought is best to leave it adjustable.  True, in our case a Boolean could be made to work for now.  But future proofing may be a good thing.  If we leave as is, maybe would make sense to not allow a value that would exceed the possible range to be used/set.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

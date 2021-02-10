Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D2C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 09:13:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42B564E2F
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 09:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42B564E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5l8kJRUKaKmi++u5Kj6hePrFmRS8S5C6JjtxQkoHwss=; b=v4e/nYfPhs5eTvTCQzUqgCG6g
	W1jCUf2kdBlKkWh/4S7vjOJIJ53HIjUVrUjyv01dAd7B68lmtG626i+x0PlTpYEU3rH72piP32nZY
	Bm0jn5xmyPshru4zpWucFWue2863ODK6DJAAN3Veu4HF0jqQ8nbNOn5cw6ezJ1zdn+dXD5aP3oqNY
	OWc9Qf7+M19nb3redGim5rvYl3UuzI5oVfNa/q9aOxjIDia7jEP5yAkZ+Rh8dGU5/TrpgsxmpHkQJ
	NM6cHGRn1zBqi1ZpX8XmgciVUjH5oNHP4kWPJFQTj2yIakyq30ZJTFP+WZ+tFkcfiX+wq3lUGGQHQ
	zgDZCgCjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9lZ3-0002K4-9U; Wed, 10 Feb 2021 09:13:37 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9lYy-0002JT-Mc
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 09:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1612948413; x=1644484413;
 h=to:cc:references:from:message-id:date:mime-version:
 in-reply-to:content-transfer-encoding:subject;
 bh=04NIynoa/p0bYIjfkLz8VNDkF3qP7YQq7Yjflu2JPsY=;
 b=uDE4NgR1zQjB/a1D952iQekTEKr1nehOQJQsqnXiaBbY3+BeWV7a5YD1
 uOs/7C428rndOhduCw3o9yvd90j/ji2czJkhkAoPPjKHZE2bI08Pw8qkw
 PDditC84AAq/pTKlwtf5pKvXZGIgrZG0NsXz/li2SsBCdDNyyeKUkr8Sr k=;
X-IronPort-AV: E=Sophos;i="5.81,167,1610409600"; d="scan'208";a="81286321"
Subject: Re: [PATCH v2] nvme: Add 48-bit DMA address quirk for Amazon NVMe
 controllers
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 10 Feb 2021 09:13:23 +0000
Received: from EX13MTAUEE002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS
 id 7C57CA1838; Wed, 10 Feb 2021 09:13:21 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Feb 2021 09:13:21 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Feb 2021 09:13:20 +0000
Received: from u2196cf9297dc59.ant.amazon.com (10.1.212.32) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Feb 2021 09:13:18 +0000
To: Christoph Hellwig <hch@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210210003942.25700-1-sironi@amazon.de> <20210210073759.GA23269@lst.de>
From: Filippo Sironi <sironi@amazon.de>
Message-ID: <8a375a50-1aad-96c5-2743-f91120fbc6f9@amazon.de>
Date: Wed, 10 Feb 2021 10:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210073759.GA23269@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_041332_804708_B0BBBF8A 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: benh@amazon.com, sagi@grimberg.me, serebrin@amazon.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org, dwmw@amazon.co.uk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/21 8:37 AM, Christoph Hellwig wrote:
> 
> On Wed, Feb 10, 2021 at 01:39:42AM +0100, Filippo Sironi wrote:
>> Amazon NVMe controllers do not support 64-bit DMA addresses; they are
>> limited to 48-bit DMA addresses.  Let's add a quirk to ensure that we
>> make use of 48-bit DMA addresses to avoid misbehavior.
> 
> This should probably say some, and mention that they do not follow
> the spec.  But I can fix this up when applying the patch.
> 

Thanks!

Filippo



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

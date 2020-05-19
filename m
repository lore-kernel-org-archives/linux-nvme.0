Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A645C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 19:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D658F207D4
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 19:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kO+x6uGN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvHhiMwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D658F207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D3xrdKfXf/HQaBA1Irc39fBOGUV6gPOfvymN3jAgMkc=; b=kO+x6uGNqwqj3igsJaVQyI6vG
	DonqStHoZlvOfjDTHJLXQ6xCGz1EJBMROmyXKsOA056sWi/9y8Su2+C7iBDb+OnEm9FaGY7aK1ceC
	RGFfAFBQZap059EG2W/IvrA+2fIp8eV6qCoR5/W3EB6ska7Crsh2BTJZhewR5SXe9FLZo0H0nzus/
	1otsZ2owNOuVE7KfQjsNIMKJz9t5JC53jNWO7VjSuDF4WeB1cRaRQAdEKmIPTZKGNGPsF4InKpQ88
	IBshMWKyiQzfPr9LUb0OqxH77exxe5BRvTMR395QzRynb3X+by9SMRB/BgYrQ0pWOtlZuBQoiBMnH
	ZGrWo6Tdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb7kN-0002Ex-Sf; Tue, 19 May 2020 19:17:51 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb7kL-0002EG-0u
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 19:17:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589915867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyRzJsPOwc6h25qRhnKS5bapjz10wcN3kURUSo6W/9o=;
 b=SvHhiMwGarAOfd19CppsavHYe5B95V2HKnsbE0lhhaw+cRgCVIljV9LlAIE1zaNkMxyWvy
 xYzz0tYDXkWSocORyz/Wlgi3flR+3N5thTNKeqmZR/YDTTSuw4XgXW1BG4bqpYd36mKvcV
 5iBzxRvUepJyqlrUMSPBDFirZmVMedE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-zkJ46T8vNhiaSjXb3AAxRA-1; Tue, 19 May 2020 15:17:46 -0400
X-MC-Unique: zkJ46T8vNhiaSjXb3AAxRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA03C835BB8;
 Tue, 19 May 2020 19:17:44 +0000 (UTC)
Received: from [10.3.112.120] (ovpn-112-120.phx2.redhat.com [10.3.112.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4823567167;
 Tue, 19 May 2020 19:17:39 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] nvmet: fixup processing async events
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <BYAPR04MB4965E89E9794EC5D80D830BC86B90@BYAPR04MB4965.namprd04.prod.outlook.com>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <d5453672-54b1-b456-506e-5bf69adc9e43@redhat.com>
Date: Tue, 19 May 2020 14:17:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E89E9794EC5D80D830BC86B90@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_121749_142521_44064380 
X-CRM114-Status: GOOD (  13.59  )
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
 "dwagner@suse.de" <dwagner@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya,

On 05/19/2020 03:40 AM, Chaitanya Kulkarni wrote:
> On 5/18/20 12:00 PM, David Milburn wrote:
>> This patch series changes how async events are processed
>> and freed based upon review from Christoph Hellwig and
>> Daniel Wagner, this was discovered while debugging a memory
>> leak after clearing connection on the target.
>>
>> Changes from v1:
>>    - free aens separate from completing requests in nvmet_async_events_free().
>>    - declare struct nvmet_async_event in second patch.
>>
>>
> I'm still trying to reproduce the issue with nvme-loop.
> Are able to reproduce this issue with nvme-loop ? if so can you
> please share the steps ? OR this is transport specific ?
> 

We have only tested with rdma.

Thanks,
David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

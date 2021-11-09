Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E562C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A3161053
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69A3161053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZTmlGEJW7tpFYrzfd6sNdF+S3duevoe4ZKGZT/1YBUs=; b=NOSvgwp9daffJiF0x2EaJUXu97
	texcgrBKy183K/rLBkMpDc68elLmMlhbz8mpN7ZHyoxaeUkyh1LyRc9yHOPj8ojfMI+c15JJnsBGr
	bMoFUTIHxnbqPDo9BucLqx/h1UcqWQ1yvGBLIDJVj5R5TkWEOuS+AnCMreNmMy9UmlAKNeMHqnEu3
	NAhJko86P1SsjxpgQS6H0sWgYjN2UwOqzRtuCmZr5QVSIHSqA5yxLJPTclPaAP6NTr3ncVRr4InD0
	SaBUvOFSvwZ1kMd0cy3I+iNHWefszRYoe3N82D+36YhSXN//FRrll/GsUQ0CTUBHHZu7O61vomFUT
	Bk5bMfhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkTCF-002aUa-9e; Tue, 09 Nov 2021 15:38:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkTCC-002aTH-9A
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 15:38:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636472277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTmlGEJW7tpFYrzfd6sNdF+S3duevoe4ZKGZT/1YBUs=;
 b=PInQgvyF9761zb20YD+X/dk3t17AfcMz/NDHEAzqrdef4OYm9s2Rl905NA3iBOh7JK+NhR
 WMuOW8ANXLQvAFBRygA+HwNZAkVO3MjZfy3rCjNnsWFhu3Q7I9pY+p55byGlXjdtVZGl3f
 n6jLpyqV+4g7RlWffhqlSRHHTlQjGOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-fO6a46yxNHaYmrBUno4nsw-1; Tue, 09 Nov 2021 10:37:53 -0500
X-MC-Unique: fO6a46yxNHaYmrBUno4nsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA011926DB7;
 Tue,  9 Nov 2021 15:37:38 +0000 (UTC)
Received: from [10.22.33.237] (unknown [10.22.33.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFB7F1007605;
 Tue,  9 Nov 2021 15:37:37 +0000 (UTC)
Message-ID: <9845ee70-e89b-6d76-6131-67eb5b573924@redhat.com>
Date: Tue, 9 Nov 2021 10:37:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] nvme-tcp: fix memory leak when freeing a queue
To: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com
References: <20211103081817.94820-1-mlombard@redhat.com>
 <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
 <20211103104516.GD4840@raketa> <20211103110310.GE4840@raketa>
 <20211109081303.GC28785@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20211109081303.GC28785@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_073800_460126_D1EBFEB0 
X-CRM114-Status: GOOD (  13.93  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 11/9/21 03:13, Christoph Hellwig wrote:
> On Wed, Nov 03, 2021 at 12:03:10PM +0100, Maurizio Lombardi wrote:
>>>>
>>>> Thanks Maurizio,
>>>>
>>>> Why do we need to the pf_cache.va protection? nvme_tcp_free_queue
>>>> is already protected against re-entry with the NVME_TCP_Q_ALLOCATED
>>>> bit.
>>>>
>>>
>>> It's not the re-entry what worried me, I thought that nvme_tcp_free_queue()
>>> might be called before page_frag_alloc() had the chance to initialize the pf_cache, triggering
>>> a NULL pointer dereference. I am doing some tests right now and it seems not to be
>>> possible so maybe we can drop the "if".
>>
>> Oh wait, if nvme_tcp_setup_ctrl() fails it could call nvme_tcp_destroy_io_queues() and
>> iI guess that in that case the pf_cache is not initialized, so the if(pf_cache.va) protection
>> is necessary.
> 
> Sagi, does this look good to you now?
> 



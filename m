Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F1C433E7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:50:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B123D20767
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PaVWSMrP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RO5SYVwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O8hBQ2BOuDrf4nvNVY1dS121gRfBq53zlLmqnLG0LMk=; b=PaVWSMrPO2Sjz1Ts9r1OtYbWw
	G4fac+sCVFK3HPL8YlG+E6/AsoZWU8eTUOTCs9PE4FIFh81GbSLrViNC5FLUN4hhpurNrKgoL4RNB
	FEbBSU32qg64hvUQ2piurlytFKf/EaRg4PrZPXWmDcnNSNQz9nvy5qYOjE9rzYC15dPVoKqBipVTU
	R8tSkFp5soQBLOs2utrQQmfJXaGPiO/3qX4ZIKJzJyaJR3KPsS8tWArINvQ4U+Ag1/W5pHdnDemnl
	I4VGB8CRRkZmkQwDQ5hmwlWxIRNfZwfoZzXMnAM601T0HNvRVIro2jsJBNy3mR5eXECrk4vaCFFhS
	6Yx2WxhOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDbZp-0007kB-5a; Wed, 02 Sep 2020 22:50:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDbZm-0007jp-GB
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 22:49:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZAh1rPs151/hc9R5gTfwhRdvuWA4+TBuTXG3r0nS90=;
 b=RO5SYVwaZCi8kJah+1UOk2Zd1QC5YGYbY5pnzQubBuzAweEo/UqrRQ8A1nNQUJnQb3Cr0s
 uvAHMtYhDKRrZpZVfcWC4HmrsuPpjxc8CRMWeNWwZMGtU4aNXdZyGpe3itkZu2sAbkiR0h
 Y5k8obSBS9df592EzTbv9qws6h4DaDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-6m695nlAMdKzmjGz62j6Hg-1; Wed, 02 Sep 2020 18:49:56 -0400
X-MC-Unique: 6m695nlAMdKzmjGz62j6Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2DAB1DE00;
 Wed,  2 Sep 2020 22:49:54 +0000 (UTC)
Received: from [10.10.113.131] (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4AF1C4;
 Wed,  2 Sep 2020 22:49:53 +0000 (UTC)
Subject: Re: [PATCH v2] nvme: cancel async events before freeing event struct
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de, james.smart@broadcom.com
References: <1599075985-70180-1-git-send-email-dmilburn@redhat.com>
 <85ecb479-7087-5137-30a6-327c1fdbc1ce@grimberg.me>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <1698c44d-21d6-20d1-dc29-3890c17d7fc3@redhat.com>
Date: Wed, 2 Sep 2020 17:49:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <85ecb479-7087-5137-30a6-327c1fdbc1ce@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_184958_596452_262A329E 
X-CRM114-Status: GOOD (  13.44  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

On 09/02/2020 05:02 PM, Sagi Grimberg wrote:
> 
>> Cancel async event work in case async event has been queued
>> up, and transport trys to submit event after it has been freed.
> 
> Can you split to 3 patches please?
> 

OK, re-submitted.

Thanks,
David


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

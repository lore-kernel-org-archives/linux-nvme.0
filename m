Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95213C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUfVUYnY27dspaPxD27npNwHK4NxjCB5+3ShdTHGBw8=; b=xZqnRcCsmjobfp+QRbasMDAA4c
	ulqic0aVJis7jB2XzeO0LEKzFmozZYOkGSbBOO1yrBS/F+SuynxQfd1F3bo0kmpJNfm9zR8RR4KP9
	kKWX42mQBXVl14anfpYu/9L8U0s2cEZMax/FAqQ+StIIF2UxQV4Fg4w+W7zTqX6xaiMrzlBDlYMnj
	bw5f91h/8biIXWJBQ625f4ONXDww68sX60Z2Nc6k2usqCyawLJWwxTiH+oVvRZoO8cFCKJfrAMIyE
	ALTOHTEuAALasDktmEwvc3sMY0uZ4RqMRj9VWSf1qBJ5n/1JfOKxaMckPFrnX9ax7HAxBZFhNYGB1
	QBqb+KhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublD0-000000063gT-0J3V;
	Tue, 15 Jul 2025 19:20:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubkus-00000005wXU-1uW8
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 19:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752606130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUfVUYnY27dspaPxD27npNwHK4NxjCB5+3ShdTHGBw8=;
	b=iqT3fKsPa5oudfKbZyQVNNXNDj1ib3TDlwBIQksfCAQkqO5PbQnX3D+Q5jYP7TNDedQwl1
	p1eL2J9zb2S5xQcbPFQQVdIlbB0frlPLdcuk4uXD34r/McWC1Dzqzs+OFN6XeGarlLXXsi
	SNxjdmyyTO7XX5xyzVR0mr5eBhs9c70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-MlMJZmceNZCd-BxtrZxITQ-1; Tue,
 15 Jul 2025 15:02:05 -0400
X-MC-Unique: MlMJZmceNZCd-BxtrZxITQ-1
X-Mimecast-MFC-AGG-ID: MlMJZmceNZCd-BxtrZxITQ_1752606124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75F291800BC3;
	Tue, 15 Jul 2025 19:02:03 +0000 (UTC)
Received: from [10.22.88.94] (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8804B180045B;
	Tue, 15 Jul 2025 19:02:00 +0000 (UTC)
Message-ID: <1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
Date: Tue, 15 Jul 2025 15:01:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
To: Keith Busch <kbusch@kernel.org>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, mlombard@bsdbackstore.eu
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
 <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
 <aCId7XmLnrLWZPdk@kbusch-mbp> <aFrBVeEcapNtOvPx@kbusch-mbp>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <aFrBVeEcapNtOvPx@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 03uaNAZtJJ694qnuYDJkBaQPTtvJS0ETH7yjPr2Z5I4_1752606124
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_120214_569669_AD448BF3 
X-CRM114-Status: GOOD (  13.43  )
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

On 6/24/25 11:16 AM, Keith Busch wrote:
> On Mon, May 12, 2025 at 10:12:29AM -0600, Keith Busch wrote:
>> On Mon, May 12, 2025 at 11:18:58AM -0400, John Meneghini wrote:
>>> On 5/9/25 11:33 AM, Keith Busch wrote:
>>>
>>>> If those are not unique, they need to be blanked out to make sure we don't
>>>> expose these on the namespace's sysfs attributes.
>>>
>>> OK, we can add another patch that blanks out the lower precedent/invalid IDs.
>>>
>>> Will that work?
>>
>> I think you'd have to blank out the non-unique ones, otherwise the
>> driver would export them.
>>
>> And while I think that might work, this proposal didn't go over so well
>> last time it came up:
>>
>> https://lore.kernel.org/linux-nvme/20250414111916.GB13225@lst.de/
> 
> I've recently encountered some devices with this behavior, from machines
> hosted by various cloud providers. I had to pull in something
> out-of-tree like the patch here just to get things going. I think we
> should have the kernel discard lower priority fields.

OK good I will ask Bryan to resubmit this as a version 2 patch.
  
We can add another patch that blanks out the lower precedent/invalid IDs in sysfs so that only the unique IDs are reported.

/John.



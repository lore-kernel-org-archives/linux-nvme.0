Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B9C64ED6
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VDyBBF0s9IT4+M2sg7J8UaGcHQvDKs1NOnvRkcZ4+CY=; b=v6d06Tuw96SObMyjtubncNkAMP
	VPI0rRv7F/v96v2lO9NLLOjWMG3QF2VjsTC3JmMOevA+YUQPJXZEgzDY86KgzVmbcCg6LTZ7Bo9Cy
	Hw/gwWw6gcy6T5osJM7JgWQ6atbVCN1KyYu8q7af5LQ/OAr+d90RItZPIgoooH0wNA9zlTtCopMTR
	v9a3coC6yX30gPvbb4A3LMB86HfwKCHhWAGaOeB/SbCxygLv16K/MSFdxunrTVKPEKHCwSr67XSJf
	w1PBxumtoYRibzPjwkYSJJwHbfXxMDGRNTOsxWFN7yhfiBzZRBYesPCi2gcgj7eqb4lyFQbZl+9DK
	EKKrh2xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX3Q5-00DpiE-Tx; Tue, 28 Feb 2023 17:05:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX3Q3-00Dph0-4Z
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 17:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677603938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VDyBBF0s9IT4+M2sg7J8UaGcHQvDKs1NOnvRkcZ4+CY=;
	b=BMCFFOqg098Fms5wXPJaGG+Uz1TkBx1x8ZpTMsIRLbfi17zcUMUG5ddKmyuiu7aJiPi5ws
	seTp+PQKvX2ZPbuHSdAZtjQutIr6ZP+1DnioQmfnI/xQaktGNGnEjotC3vzIFqW4MFgMKk
	opBsU/EksTP1gf2c/sG8MUS1nuKobMY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-GK7d2fO5PFCxngrSuBgwMA-1; Tue, 28 Feb 2023 12:05:26 -0500
X-MC-Unique: GK7d2fO5PFCxngrSuBgwMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0280D3C0CD4E;
	Tue, 28 Feb 2023 17:05:14 +0000 (UTC)
Received: from [10.22.8.29] (unknown [10.22.8.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D8701121314;
	Tue, 28 Feb 2023 17:05:13 +0000 (UTC)
Message-ID: <767ca4ae-a24f-5b81-427c-99ca3b1323b9@redhat.com>
Date: Tue, 28 Feb 2023 12:05:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To: lsf-pc@lists.linux-foundation.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
From: John Meneghini <jmeneghi@redhat.com>
Subject: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] NVMe/TCP Boot
Organization: RHEL Core Storge Team
Cc: Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
 "Farley, Douglas" <Douglas.Farley@dell.com>,
 "Rabeda, Maciej" <maciej.rabeda@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_090539_284979_2B482C7B 
X-CRM114-Status: GOOD (  10.54  )
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

After working with many others on the NVMe Boot Specification[1] the Timberland SIG working group has just published their 
NVMe/TCP Boot code.

   https://github.com/timberland-sig

The patches relevant to the Linux host are currently in review and can be seen at:

  https://github.com/linux-nvme/libnvme/pull/572
  https://github.com/linux-nvme/nvme-cli/pull/1791
  https://github.com/dracutdevs/dracut/pull/2184

This is a WIP and there are many changes and improvements coming in the next two months - including both SUSE and Red Hat POC 
repositories that developers can use to assist with testing and development.

I'd like to come to LSF/MM this year and do a presentation about our work on the NVMe Boot Specification and at the Timberland 
SIG project.  I'd also like to give a demonstration of NVMe/TCP Boot in action.

Required Attendees:

Martin Wilck
Daniel Wagner
Hannes Reinecke

Optional:

Douglas Farley
Maciej Rabeda

[1] https://nvmexpress.org/wp-content/uploads/NVM-Express-Boot-Specification-2022.11.15-Ratified.pdf

-- 
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com
978-930-3519 (cell)



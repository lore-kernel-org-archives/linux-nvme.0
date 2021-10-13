Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C08AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413C161152
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 413C161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlrm0umyXpkMjl6BeQ50H8gkD9som7+1NbIvB9AU1qo=; b=kGdrPpA6NaQdhF9eP8aUaMarg1
	dktPL7403y0YM6DvEsctvmGlZofd6naf7GsBJuA0/53bMcyE+EOvmS1xHNGQQkt7fC4b77sWOAXZN
	38oG42Jb9LnmVp6jqOhZ2tVHjXay72sIabKVkX41lROLzOgh2NuPvqXktoelSpgXwBiJ1nw3TWvf9
	UxFjRdWGR4LwZOAt1BuStnR6QI5zfF4BB9gkf7ecdbDPRJCgiY/4/Kw7406CMhhmmEvKsEyrRa73o
	D0qJ+pHDYxrefH5MQt1bXLCibEd3R1GOvE21cx55GR5+9HZNlhH9/hNxycr0okGDY2QJTWMrOTiOM
	SmnVRt+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1magHf-00HPB2-FF; Wed, 13 Oct 2021 15:35:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1magHc-00HP9l-Un
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 15:35:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634139306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlrm0umyXpkMjl6BeQ50H8gkD9som7+1NbIvB9AU1qo=;
 b=g363VMegeKPA6mb+nLscjXRNQ9qQXJOtEdz0keuxPlNVUlpo/nik/g0Vpo33fAjRY4+Yj1
 f0dUtc8nt2jug6iyIRgkk0svEJ4VBHuVOFQXVECK039QVH4on+hHUoRKDM2BfTiossoflO
 Bf55mBlHwXyWuWgYF1mll3QS0FUwPhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-rNbC-JFlNH-KxCe0QNsb6Q-1; Wed, 13 Oct 2021 11:35:02 -0400
X-MC-Unique: rNbC-JFlNH-KxCe0QNsb6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FA6510A8E01;
 Wed, 13 Oct 2021 15:35:01 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60A5117CEE;
 Wed, 13 Oct 2021 15:34:37 +0000 (UTC)
Date: Wed, 13 Oct 2021 23:34:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 "Martin K. Petersen" <martin.petersen@oracle.com>, ming.lei@redhat.com
Subject: Re: [PATCH] nvme-pci: calculate IO timeout
Message-ID: <YWb8iVY74vWZiMCU@T590>
References: <20211013022744.1357498-1-kbusch@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211013022744.1357498-1-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ming.lei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_083509_130726_34135BC1 
X-CRM114-Status: GOOD (  14.04  )
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

On Tue, Oct 12, 2021 at 07:27:44PM -0700, Keith Busch wrote:
> Existing host and nvme device combinations are more frequently capable
> of sustaining outstanding transfer sizes exceeding the driver's default
> timeout tolerance, given the available device throughput.
> 
> Let's consider a "mid" level server and controller with 128 CPUs and an
> NVMe controller with no MDTS limit (the driver will throttle to 4MiB).
> 
> If we assume the driver's default 1k depth per-queue, this can allow
> 128k outstanding IO submission queue entries.
> 
> If all SQ Entries are transferring the 4MiB max request, 512GB will be
> outstanding at the same time with the default 30 second timer to
> complete the entirety.
> 
> If we assume a currently modern PCIe Gen4 x4 NVMe device, that amount of
> data will take ~70 seconds to transfer over the PCIe link, not
> considering the device side internal latency: timeouts and IO failures
> are therefore inevitable.

PCIe link is supposed to be much quicker than handling IOs in device side,
so nvme device should have been saturated already before using up the
PCIe link, is there any event or feedback from nvme device side(host or
device) about the saturation status?

SCSI have such mechanism so that queue depth can be adjusted according
to the feedback, and Martin is familiar with this field. 


Thanks, 
Ming



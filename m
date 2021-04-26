Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD6C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 02:07:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843DD611F0
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 02:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843DD611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sM/w+FBJsacWc0JUy9VwqhHX0DnLQfQJRsmbjem8IH0=; b=VcpStZLFm3atgsEZQx92f5RkE
	NnomnqxGWAJvPNhL1htyAXHrR3czr5LfSsXH1FMUhD1+ehl9BN8pMBd8NGDXAriGXV8g7aWpZQHc9
	nK0pDXgB+O10zXYq5ek+MJlC15eMEQve6RQY5/E32b209HrCxFfWcEwJI5zL1n+VtM/UosTUHsyaE
	+d45UJsF00UudFMxMoDTpIjiwul/ImUMAxNxS8d6DUNiyamIgq8Py5LSkcAzZ/8tXP4bZ3gL3FDMp
	X21w6OCUc7/64MgdGugSglaR1kPFaiH5UchAYJTxX4mCHxwb1g7Jg9kOh31aAsutIkGKZW4re8Va7
	uSIZQjv9g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laqeb-006gL2-Kb; Mon, 26 Apr 2021 02:07:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laqeZ-006gKp-Q7
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 02:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=soanG+9qRJI3J9HhDX0QCMYbAkfnS1p7/A5cxZozGaU=; b=yFeQqlv5cUWjLaaEcjG8EZN6Vd
 hl2opFArH7NO3KFi17dp+pXQ85fOtCDumvIM2VAqAXFVDkg+Tb9z8Q7kk+ZUEx3oI00It1+P4yul/
 bLdHTUVWncn1alfmv82hQr8nlkyAUti1ZFiyqRAE5bWGUdq155pCfFUMyOXYcWbU3Dr4lkHsQ66sA
 DSP8xgaXvdAEnCnoR/OsQC2AmyfcJSETbrslaiXqAw6iDNRP1sGzV9Sh8M6UiIdWNFwetN0bRT/Se
 J8ur5vqNVj/kmdSgIHKS9YPFFqscITOjWYozk+MZkGwy+m4PLzhvhFIQKcsu1FOItsW3d1GpBHhpn
 nzmPqOTQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laqeX-00FgmL-4E
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 02:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619402831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soanG+9qRJI3J9HhDX0QCMYbAkfnS1p7/A5cxZozGaU=;
 b=D7HHvAHpl78wNM+VJOO2eejFdWaXYQyIaBFRDTL8fMZXtKyP9JzV5Qj0pPXecpB8VZ4d8K
 Iy/YqTZpMlL6WII00qS4q16bjE4qaTYpg3EbOSIFY3zlicHvVFX5b6rcbbBaZoTR5l3T6H
 FK6l3dniKVz1oDu4B4t0tVgWeakfFRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-hNEplzNfP-S6ZRygBUhJHw-1; Sun, 25 Apr 2021 22:07:09 -0400
X-MC-Unique: hNEplzNfP-S6ZRygBUhJHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55984343A4;
 Mon, 26 Apr 2021 02:07:07 +0000 (UTC)
Received: from T590 (ovpn-12-48.pek2.redhat.com [10.72.12.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 172169CA0;
 Mon, 26 Apr 2021 02:06:57 +0000 (UTC)
Date: Mon, 26 Apr 2021 10:07:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH 8/8] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YIYgR65kR79ghol4@T590>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-9-ming.lei@redhat.com>
 <d3493eef-ff45-23a8-f12a-b7246ba9f3a2@acm.org>
 <YIYOLHaidxc5fBH2@T590>
 <69764ff2-f339-0dc0-aac0-a1f9f4b30d53@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69764ff2-f339-0dc0-aac0-a1f9f4b30d53@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_190713_335338_9E3E841F 
X-CRM114-Status: GOOD (  16.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Apr 25, 2021 at 06:50:48PM -0700, Bart Van Assche wrote:
> On 4/25/21 5:49 PM, Ming Lei wrote:
> > On Sun, Apr 25, 2021 at 01:42:59PM -0700, Bart Van Assche wrote:
> >> Using cmpxchg() on set->tags[] is only safe if all other set->tags[]
> >> accesses are changed into WRITE_ONCE() or READ_ONCE().
> > 
> > Why?
> > 
> > Semantic of cmpxchg() is to modify value pointed by the address if its
> > old value is same with passed 'rq'. That is exactly what we need.
> > 
> > writting 'void *' is always atomic. if someone has touched
> > '->rqs[tag]', cmpxchg() won't modify the value.
> 
> WRITE_ONCE() supports data types that have the same size as char, short,
> int, long and long long. That includes void *. If writes to these data
> types would always be atomic then we wouldn't need the WRITE_ONCE()
> macro.

OK, then we don't need WRITE_ONCE(), since WRITE on tags->rqs[i] is
always atomic.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

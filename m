Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78389C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46481611C5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46481611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCLQQuEeZkbftRFn3kR0ZgS+cL9uIv0W8JgXgekwkI0=; b=gfsPIsJBLF6tcxPwXLNymRTDUr
	PcoSex2MnWwGPAXf2SErsX4WyRF+TdxIW3LclEKR74DQpGVPj6JOCwlxgE/3dHi3yV9Lp1eeo4oc7
	5DFbDjFKGn4jXjXzJnItpvfjyrKCcbQR3AXUi+7tUfC41aQciZ0wZfAGHZmZBIHvwvnDE32RwAiq1
	URA2vdHDVi1aJJap4ZlUxdA8cwwOx1Vh5SXgHSKiALWl8KYszXhCSLpx0hhnHOvEolMbRfBIGnrUo
	rVtlSqi6tyh+/sCfIFg7o0o1i/Kk98EXPY1fz6G63M/ksoMKO6SO8byvLENHGMmtPc8uKW5EOtl1P
	SndwZp+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mncng-007CQK-M5; Thu, 18 Nov 2021 08:29:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mncnd-007CPV-KY
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 08:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637224179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCLQQuEeZkbftRFn3kR0ZgS+cL9uIv0W8JgXgekwkI0=;
 b=N9skeedkU+KfBsCoydp2UDlHVuqYMe0gFyeEUaQdT6rqa0YmJN1Ac5Cmjd/UkgWQYxVbVv
 zhoQo9TUfJliUh2XxGdlFWJGe0+NKETRZ05oFEU+DCSK/XH5YQuqN4QhDJe0A+qvZhV4bV
 4ldGl0/CVOUJzpE/BR/Z6JVQCzrJwsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-vAYGcVNIPbunw06HcK2yhA-1; Thu, 18 Nov 2021 03:29:33 -0500
X-MC-Unique: vAYGcVNIPbunw06HcK2yhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A31F7804140;
 Thu, 18 Nov 2021 08:29:32 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18EF45D9DE;
 Thu, 18 Nov 2021 08:29:30 +0000 (UTC)
Date: Thu, 18 Nov 2021 09:29:28 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Message-ID: <20211118082928.GA82729@raketa>
References: <20211117152454.122014-1-mlombard@redhat.com>
 <b0c0a83c-df9a-0a91-1dff-f6bc647a5b81@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <b0c0a83c-df9a-0a91-1dff-f6bc647a5b81@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_002941_771886_28AEF6FE 
X-CRM114-Status: GOOD (  13.55  )
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

On Thu, Nov 18, 2021 at 01:59:29AM +0000, Chaitanya Kulkarni wrote:
> We will need blktests for this.
> 
> Also, can you share performance numbers with this patch and
> the errors that you are getting without this patch ?

Ok, I will try to run blktests and provide some performance numbers.

Without this patch, writes get lost:

[root@kvm-02-guest03 ~]# nvme connect -t tcp -a 10.37.153.75 -n test-nqn -s 4080
[root@kvm-02-guest03 ~]# dd if=/dev/urandom of=/dev/nvme0n1 bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0604551 s, 17.3 MB/s
[root@kvm-02-guest03 ~]# hexdump -C /dev/nvme0n1 
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
06400000

dmesg output:

[81489.687548] blk_update_request: critical target error, dev nvme0c0n1, sector 0 op 0x1:(WRITE) flags 0x2000800 phys_seg 256 prio class 0
[81489.691139] buffer_io_error: 246 callbacks suppressed
[81489.691141] Buffer I/O error on dev nvme0n1, logical block 0, lost async page write
[81489.695013] Buffer I/O error on dev nvme0n1, logical block 1, lost async page write
[81489.697183] Buffer I/O error on dev nvme0n1, logical block 2, lost async page write
[81489.699239] Buffer I/O error on dev nvme0n1, logical block 3, lost async page write
[81489.701297] Buffer I/O error on dev nvme0n1, logical block 4, lost async page write
[81489.703374] Buffer I/O error on dev nvme0n1, logical block 5, lost async page write
[81489.705459] Buffer I/O error on dev nvme0n1, logical block 6, lost async page write
[81489.707511] Buffer I/O error on dev nvme0n1, logical block 7, lost async page write
[81489.709438] Buffer I/O error on dev nvme0n1, logical block 8, lost async page write
[81489.711364] Buffer I/O error on dev nvme0n1, logical block 9, lost async page write

Maurizio



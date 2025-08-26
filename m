Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC31CA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgK6zVCaewV2AgflcmKRv9pWzRpDi+X/xM0/4eUVBak=; b=jw03l42HRQKBrPl6o3Yb3GQWef
	1wJcSJ0DEckuc2WVcJuOSeDvy4PTVTWacKX8PG6XPLViTOI97iRBBlVoThalStJN8J5Z47vv7M1oo
	Lk2SvPhuKubE83MTRbtwFASs7Mm2P21Deymda6IICekc1wI6WCtiYuUGJ6eIK/kZ1rxhYhFBKgvL7
	s7iqtdOoWBGtZPsPPrbIpFssDv2lMqUk494DhCWCp0yQGQv5R0gdF6LdkAAVYHNCnnS8w/4Y10C+f
	UvgBqWplxLWwtnrPDtmrSMIvHCAModHz3aSj0f6hkRg2SLZA25/XxaK3WPgTc6//hMrvoQG76tDKH
	Cax7kSxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqpij-0000000BGLZ-3kx4;
	Tue, 26 Aug 2025 09:12:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqpgj-0000000BFKS-0gz8
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 09:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756199395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgK6zVCaewV2AgflcmKRv9pWzRpDi+X/xM0/4eUVBak=;
	b=ahQa88APKlWL52L5ei5MK02GrOmpuX8xffNOpg2/kD78mEYUmkNzxxemdllZ+KDl+GoFWj
	liuGcbw9rMP1XbvNZTLRLEtFUyofV2dWLyaGP9kZPI9lvRK9XZzqufuXSneHVx35tTk9kY
	EyGjBtJW//VYb2lwvj/bNfF0wNO1qiQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-bkekoeDEPDS-J6oAGgdWIQ-1; Tue,
 26 Aug 2025 05:08:19 -0400
X-MC-Unique: bkekoeDEPDS-J6oAGgdWIQ-1
X-Mimecast-MFC-AGG-ID: bkekoeDEPDS-J6oAGgdWIQ_1756199298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB241195419B;
	Tue, 26 Aug 2025 09:08:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A231919560AB;
	Tue, 26 Aug 2025 09:08:12 +0000 (UTC)
Date: Tue, 26 Aug 2025 17:08:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Subject: Re: [blktest/nvme/058] Kernel OOPs while running nvme/058 tests
Message-ID: <aK15dbUiEyr0O2Ka@fedora>
References: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_020957_384983_3866B77A 
X-CRM114-Status: UNSURE (   8.76  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 26, 2025 at 02:00:56PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> IBM CI has reported a kernel OOPs, while running blktest suite(nvme/058
> test).
> 
> 
> Kernel Repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 
> Traces:
> 
> 
> [37496.800225] BUG: Kernel NULL pointer dereference at 0x00000000
> [37496.800230] Faulting instruction address: 0xc0000000008a34b0
> [37496.800235] Oops: Kernel access of bad area, sig: 11 [#1]

...

> [37496.800365] GPR28: 0000000000000001 0000000000000001 c0000000b005c400
> 0000000000000000
> [37496.800424] NIP [c0000000008a34b0] __rq_qos_done_bio+0x3c/0x88

It looks regression from 370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock"),
For nvme mpath, same bio crosses two drivers, so QUEUE_FLAG_QOS_ENABLED & q->rq_qos check can't
be skipped.


Thanks,
Ming



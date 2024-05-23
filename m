Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A152C25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6b8ckFLNrH+n0z5ZTQUnQT/jgZD23ydywQW1AVdLZHU=; b=Pmcba6HB/tlh9Jg/6kDgh26jGD
	oDliRpuPx4UOdL7bEhONnlz7rxiMzb8IVqqIOrBWoOIAaiUsuqeQftCCluShE9RQ8USFvFdG/tVlv
	AHW2bKyFKmltdH4bAmPWbhOHJp6v1tTCrYMyeIe8HDWi5g8Y4VQ5yHZmTjiDEnZ3R9jejDIHXMiX3
	5iVecG9LD2E+03iNaO+PkQ6/MIYIffiM/g8J0NAZy7kMf8ZjNwgr5L138/T2b0XQx5hEHttoxCqwP
	Ok2iPSVqkVDchWjA7rIqNw7wuk5ch6lxu7WBDLkPBFCwQu+b6jRW9PxLK07URe3+HkyCoT3FPWLFI
	acgAbpgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8FB-00000006KKE-2Ztp;
	Thu, 23 May 2024 13:12:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8F8-00000006KJj-2v4Y
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716469945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b8ckFLNrH+n0z5ZTQUnQT/jgZD23ydywQW1AVdLZHU=;
	b=Jdf34STi8mILsGNFoZB2n0CxXmt9nbXJNIP0qbMSNA151eKn69UWWIALkg5Yg974uAAtF+
	kUNer57ogmMLLLZhJvRzm80UsX0IiTapubs7nshybngK8c8dDCyA2HmwMFqexuxusBIjqC
	dJfaoKpm2uOEEnLRlhmHnSmhjIKq5Wo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-iOCUxihRPp--ENdret5jUA-1; Thu,
 23 May 2024 09:12:22 -0400
X-MC-Unique: iOCUxihRPp--ENdret5jUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E49E93C025A1;
	Thu, 23 May 2024 13:12:21 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94124491034;
	Thu, 23 May 2024 13:12:21 +0000 (UTC)
Message-ID: <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
Date: Thu, 23 May 2024 09:12:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, emilne@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, jrani@purestorage.com, randyj@purestorage.com,
 hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
 <20240523064525.GA28524@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523064525.GA28524@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_061226_840991_C8C87C37 
X-CRM114-Status: UNSURE (   8.63  )
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

On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
>> Christoph, Sagi, 6.10 merge window is still open and this has been
>> iterating long before that. Any objection?
> 
> No, it's not.  The window for development closes with the release for
> 6.9.  New features must be in before that.

So what's the next window for new features?  6.11?

/John



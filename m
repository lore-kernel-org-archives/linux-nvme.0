Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E81C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5DTI//Qha4u3Kat+ZKKMYxR5CxUYu7QEiiyD50iVw8=; b=wq0YkJ2bKblTf/8N2EAuVVh2ma
	HyiARrVNPxZaM2IVnTUE0Yk3+uirLc+Ysiap+0dWmP1QZCVg2UPQCDNQzYzrRGbCmYA12GVb9hpCP
	bxiNah/aM5t5jC7CI5TT9dZPTFehR1rnUUeZ8DtiGnJaYBmOmbunrVBWu8ag3NEWLww4zMCKkcv+W
	nyFhSexsFI0/HhTurHUyk6IHqdE3upytLw6e/LuOfIJFwW9l9wfN/7BugDlq4cyGxKLzL6zzJJMfk
	an0cyYW1ttpOffyFvUT7WU6ORFlFiyoddNjDHxV+l6IQyazH2q8tqqqjl1KXpVG8KsAVlxDjmaW6B
	8cjCCEjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKKiP-007GpA-9z; Wed, 16 Feb 2022 13:51:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKKiL-007GoK-QA
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 13:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645019484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5DTI//Qha4u3Kat+ZKKMYxR5CxUYu7QEiiyD50iVw8=;
 b=ak8Iy2Rry0FOHay2wdkFLxBxpPwKSQsmD8Jv42EXrM6VUVaNiqVVjh7azj3Llkbzm7WN+u
 fw1IOHCJlZ+R4QNicyvfQsbHY+ZOGxTJsnto+5Rbq0EV9+ehwjRhA8IixHpnUbcvn7f3om
 TJQovY9AoA0L/UaP4Jl3sR/7oCEGMIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-kBhArUV3NEOq_YS-Pwd6oA-1; Wed, 16 Feb 2022 08:51:21 -0500
X-MC-Unique: kBhArUV3NEOq_YS-Pwd6oA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAF6B1898291;
 Wed, 16 Feb 2022 13:51:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23DD17C127;
 Wed, 16 Feb 2022 13:51:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 21GDp8ZA023716; Wed, 16 Feb 2022 08:51:08 -0500
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 21GDp8bV023712; Wed, 16 Feb 2022 08:51:08 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Wed, 16 Feb 2022 08:51:08 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Nitesh Shetty <nj.shetty@samsung.com>
cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
 zach.brown@ni.com, osandov@fb.com, lsf-pc@lists.linux-foundation.org,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
 tytso@mit.edu, jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH v2 08/10] dm: Add support for copy offload.
In-Reply-To: <20220207141348.4235-9-nj.shetty@samsung.com>
Message-ID: <alpine.LRH.2.02.2202160845210.22021@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
 <20220207141348.4235-1-nj.shetty@samsung.com>
 <CGME20220207141948epcas5p4534f6bdc5a1e2e676d7d09c04f8b4a5b@epcas5p4.samsung.com>
 <20220207141348.4235-9-nj.shetty@samsung.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_055125_943117_500DE6FF 
X-CRM114-Status: GOOD (  15.54  )
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



On Mon, 7 Feb 2022, Nitesh Shetty wrote:

> Before enabling copy for dm target, check if underlaying devices and
> dm target support copy. Avoid split happening inside dm target.
> Fail early if the request needs split, currently spliting copy
> request is not supported
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

If a dm device is reconfigured, you must invalidate all the copy tokens 
that are in flight, otherwise they would copy stale data.

I suggest that you create a global variable "atomic64_t dm_changed".
In nvme_setup_copy_read you copy this variable to the token.
In nvme_setup_copy_write you compare the variable with the value in the 
token and fail if there is mismatch.
In dm.c:__bind you increase the variable, so that all the tokens will be 
invalidated if a dm table is changed.

Mikulas



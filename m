Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2899C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xNKUQpE6ACEyF1q91AK5Pa8cyyFRcdXFb2KIn9j+Qic=; b=n3r3t03KQU5WuBSgvEDPaau4im
	KJQQeWDKaM57v915A2ilg59aJ3ssl+2hI2zDpLgtloo22/aSE3oKPSrBxcDpgv427WKPUlUGYYrJ/
	+sXY51CIM/oBmBGXpoyRMPTXhmKfI2FDx/V3KnWS58OUFc7+YjaCD7pbywMSl+KCV8gFGwjPXE33G
	PaMGheBh6LrQsP3Ja0/pqzDC3bYSdupRtYEH6q1fZxPG2jaya4dDKfFKi1ktTGk8aYza07FnsuT4s
	S5qwf4saYfdwkhIYGvvUOpUmN97cz4ClEINynezW5hhuLg44tlYZpzfQtqALRZU/ZLweX6ZCFMctr
	v1jystBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA04C-002w5x-1U;
	Mon, 04 Dec 2023 03:56:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA048-002w4y-2V
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 03:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701662173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNKUQpE6ACEyF1q91AK5Pa8cyyFRcdXFb2KIn9j+Qic=;
	b=PNh51NZc9HVA8xYOuQ5CnZ2I+pZETXjBF09VPX61SYb5115ly4logwThiMu9NES7tGcG49
	fozsdQg00ulHbeSpV/BiCj0DNgqYYMjVT8gDl0Y1EocQD2c/+9iouMlv0QoVKA+4TMqip0
	WxRPk21ar7GyNno2vmvGziyL5hjjP60=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-z5VdyYmhPpumcRg0ll2h0w-1; Sun,
 03 Dec 2023 22:56:07 -0500
X-MC-Unique: z5VdyYmhPpumcRg0ll2h0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 988FF3803515;
	Mon,  4 Dec 2023 03:56:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4215C1596F;
	Mon,  4 Dec 2023 03:55:55 +0000 (UTC)
Date: Mon, 4 Dec 2023 11:55:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Message-ID: <ZW1NxiEh2x82SOai@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-3-john.g.garry@oracle.com>
 <ZW1FOFWsUGUNLajE@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW1FOFWsUGUNLajE@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_195616_978473_B32CBD13 
X-CRM114-Status: GOOD (  12.58  )
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

On Mon, Dec 04, 2023 at 11:19:20AM +0800, Ming Lei wrote:
> On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
> > We rely the block layer always being able to send a bio of size
> > atomic_write_unit_max without being required to split it due to request
> > queue or other bio limits.
> > 
> > A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
> > and each vector is at worst case the device logical block size from
> > direct IO alignment requirement.
> 
> Both unit_max and unit_min are applied to FS bio, which is built over
> single userspace buffer, so only the 1st and last vector can include

Actually it isn't true for pwritev, and sorry for the noise.

Thanks,
Ming



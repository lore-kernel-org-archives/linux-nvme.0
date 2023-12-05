Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA7AC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79PD3d2kumFOy7A9eRn22aWg7Y9KfDQNCF0FEIsFKv8=; b=CYVPGUiIG3VcK4lZwlxHJ45fLk
	mDjmiXdIUUSbGfXtIUZYX1zUbUVzkODF0w0Ht1nhjA1PRJ3HwmcL+49/dBwQ3YxeLGRsia1uQZJWe
	PoRuzO7oRYa7USpFXsaLGk3AKAmF8pTi6/5ImeRmD0mgsQSEjPeJ5+nd8syPRnVd5kcDIIXBb665Q
	/hDX1demedGXykl/N+fpwKz3nOdzi81LMGi0nd28YDYQJML0E7Bk6oxkrN3HIl2sUiLuU09ap09iJ
	8l6ldWpp6f97JQ+QuQZ/dmoXUv7q2YHD+VAuQRdHEnWF68EU0GjVn0fwzdSr+JNdUWozXDphQtS+X
	GyLh2vqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAVxS-007YQS-01;
	Tue, 05 Dec 2023 13:59:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAVxO-007YQ1-2G
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 13:59:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701784765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79PD3d2kumFOy7A9eRn22aWg7Y9KfDQNCF0FEIsFKv8=;
	b=HESmTL+fIZ+Qls44yXRTQjd1r+njpDvMONvQ81oEwLH6KyhIP1xsGItTDxznMplfArpLBV
	8gCEMqPWmDyz/YZC5wFTQ6wo4+F+zzxvuAYly5xlH5/9QMuZ1nE1eQtzOsOgeB3+3Z6cp3
	YnkFMXMe0tiXRr7DykGjzcJMJnNfNIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-uCsCU4nHN_ezAkIn8k7hWw-1; Tue, 05 Dec 2023 08:59:24 -0500
X-MC-Unique: uCsCU4nHN_ezAkIn8k7hWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E090885A58C;
	Tue,  5 Dec 2023 13:59:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A5A8492BC7;
	Tue,  5 Dec 2023 13:59:12 +0000 (UTC)
Date: Tue, 5 Dec 2023 21:59:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <ZW8srC5hTWOGF5ts@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
 <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
 <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
 <20231128135619.GA12202@lst.de>
 <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
 <20231204134509.GA25834@lst.de>
 <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_055926_810074_07A9629C 
X-CRM114-Status: GOOD (  29.74  )
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

On Mon, Dec 04, 2023 at 03:19:15PM +0000, John Garry wrote:
> On 04/12/2023 13:45, Christoph Hellwig wrote:
> > On Tue, Nov 28, 2023 at 05:42:10PM +0000, John Garry wrote:
> > > ok, fine, it would not be required for XFS with CoW. Some concerns still:
> > > a. device atomic write boundary, if any
> > > b. other FSes which do not have CoW support. ext4 is already being used for
> > > "atomic writes" in the field - see dubious amazon torn-write prevention.
> > 
> > What is the 'dubious amazon torn-write prevention'?
> 
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
> 
> AFAICS, this is without any kernel changes, so no guarantee of unwanted
> splitting or merging of bios.
> 
> Anyway, there will still be !CoW FSes which people want to support.
> 
> > 
> > > About b., we could add the pow-of-2 and file offset alignment requirement
> > > for other FSes, but then need to add some method to advertise that
> > > restriction.
> > 
> > We really need a better way to communicate I/O limitations anyway.
> > Something like XFS_IOC_DIOINFO on steroids.
> > 
> > > Sure, but to me it is a concern that we have 2x paths to make robust a.
> > > offload via hw, which may involve CoW b. no HW support, i.e. CoW always
> > 
> > Relying just on the hardware seems very limited, especially as there is
> > plenty of hardware that won't guarantee anything larger than 4k, and
> > plenty of NVMe hardware without has some other small limit like 32k
> > because it doesn't support multiple atomicy mode.
> 
> So what would you propose as the next step? Would it to be first achieve
> atomic write support for XFS with HW support + CoW to ensure contiguous
> extents (and without XFS forcealign)?
> 
> > 
> > > And for no HW support, if we don't follow the O_ATOMIC model of committing
> > > nothing until a SYNC is issued, would we allocate, write, and later free a
> > > new extent for each write, right?
> > 
> > Yes. Then again if you do data journalling you do that anyway, and as
> > one little project I'm doing right now shows that data journling is
> > often the fastest thing we can do for very small writes.
> 
> Ignoring FSes, then how is this supposed to work for block devices? We just
> always need HW support, right?

Looks the HW support could be minimized, just like what Google and Amazon did,
16KB physical block size with proper queue limit setting.

Now seems it is easy to make such device with ublk-loop by:

- use one backing disk with 16KB/32KB/.. physical block size
- expose proper physical bs & chunk_sectors & max sectors queue limit

Then any 16KB aligned direct WRITE with N*16KB length(N in [1, 8] with 256
chunk_sectors) can be atomic-write.



Thanks,
Ming



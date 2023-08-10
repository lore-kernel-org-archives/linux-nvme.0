Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D95EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=594nXTsTgZOwSIbiFys/fNQ4V66vIHVyVd6OCcJP7n4=; b=wv1tAJIqVlUncdypaiZk54cc5N
	IZQQYeIDo7+ZgKD6CLPHXJkFQJlHlZ0HZEyBLc+RN4zCew1FitfaF1cToPlcUU0s6pUOB4cAzZlln
	sbppFDqOzYHXsCvOi9UOKG21/LyEWiWm+QHq+guEvKQZAlvgMYw8fsdFNENmWkATngmPeAhjCShIW
	A2hiRfw71DOLUKqNdO4HvKfbJeL6oXmw+IHiVDBDeGnGHoHi2+KC++/L/dyeXdyMX7TeTsjfHZDUB
	cBIfTHPsUL8FfXYKfi0SQ+0YmjQZCctMLcAR0YPFIas/P6GqifXLrsAbxos40YfbiEHHinCFqKGeK
	DLnj89jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTvvz-006NlV-2d;
	Thu, 10 Aug 2023 03:01:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTvvw-006Njy-16
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 03:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691636514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=594nXTsTgZOwSIbiFys/fNQ4V66vIHVyVd6OCcJP7n4=;
	b=cbUrIOIjDb65IkYx0TCPhrc+fZL1vtHoxv6S5EjNOJafzWKKLstYlcM0p/5NEnInyaxMzx
	yQ1qUCDnGmBYkZau22ODa/y2tmz/qOg36ry2udzCFKunGfxoEo6LmWKmNHVTRQeWqYWywi
	IzGgk43aY8q0hOYJlZRiwt4Y7+QKUpM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-462o-o7QOKu_hKQjukBwpw-1; Wed, 09 Aug 2023 23:01:51 -0400
X-MC-Unique: 462o-o7QOKu_hKQjukBwpw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C5D83C01BA8;
	Thu, 10 Aug 2023 03:01:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AEB7492C13;
	Thu, 10 Aug 2023 03:01:49 +0000 (UTC)
Date: Thu, 10 Aug 2023 11:01:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZNRTGrRuwf69EgnE@MiWiFi-R3L-srv>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-2-ming.lei@redhat.com>
 <20230809134401.GA31852@lst.de>
 <ZNQqt1C0pXspGl3d@fedora>
 <ZNQ64xhCIBU6XM/5@MiWiFi-R3L-srv>
 <ZNRGNsRzEJfzUEzH@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNRGNsRzEJfzUEzH@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_200156_468884_02205C50 
X-CRM114-Status: GOOD (  34.53  )
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

On 08/10/23 at 10:06am, Ming Lei wrote:
> On Thu, Aug 10, 2023 at 09:18:27AM +0800, Baoquan He wrote:
> > On 08/10/23 at 08:09am, Ming Lei wrote:
> > > On Wed, Aug 09, 2023 at 03:44:01PM +0200, Christoph Hellwig wrote:
> > > > I'm starting to sound like a broken record, but we can't just do random
> > > > is_kdump checks, and it's not going to get better by resending it again and
> > > > again.  If kdump kernels limit the number of possible CPUs, it needs to
> > > > reflected in cpu_possible_map and we need to use that information.
> > > > 
> > > 
> > > Can you look at previous kdump/arch guys' comment about kdump usage &
> > > num_possible_cpus?
> > > 
> > >     https://lore.kernel.org/linux-block/CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com/
> > >     https://lore.kernel.org/linux-block/ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv/
> > > 
> > > The point is that kdump kernels does not limit the number of possible CPUs.
> > > 
> > > 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
> > > num_possible_cpus becomes 1.
> > 
> > Yes, "nr_cpus=" is strongly suggested in kdump kernel because "nr_cpus="
> > limits the possible cpu numbers, while "maxcpuss=" only limits the cpu
> > number which can be brought up during bootup. We noticed this diference
> > because a large number of possible cpus will cost more memory in kdump
> > kernel. e.g percpu initialization, even though kdump kernel have set
> > "maxcpus=1". 
> > 
> > Currently x86 and arm64 all support "nr_cpus=". Pingfan ever spent much
> > effort to make patches to add "nr_cpus=" support to ppc64, seems ppc64
> > dev and maintainers do not care about it. Finally the patches are not
> > accepted, and the work is not continued.
> > 
> > Now, I am wondering what is the barrier to add "nr_cpus=" to power ach.
> > Can we reconsider adding 'nr_cpus=' to power arch since real issue
> > occurred in kdump kernel?
> 
> If 'nr_cpus=' can be supported on ppc64, this patchset isn't needed.
> 
> > 
> > As for this patchset, it can be accpeted so that no failure in kdump
> > kernel is seen on ARCHes w/o "nr_cpus=" support? My personal opinion.
> 
> IMO 'nr_cpus=' support should be preferred, given it is annoying to
> maintain two kinds of implementation for kdump kernel from driver
> viewpoint. I guess kdump things can be simplified too with supporting
> 'nr_cpus=' only.

Yes, 'nr_cpus=' is ideal. Not sure if there's some underlying concerns so
that power people decided to not support it.



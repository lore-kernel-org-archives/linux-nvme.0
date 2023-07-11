Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9EDC001B0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 03:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=np4ZI6Y9u+osACrZKJ15QQ6k0qV43pdokF3OlXrj8ck=; b=Flo+s/O9b1XwIAA6vjtjdGaHNa
	00r4rEPuLXHwY1c5vL8EyFtZO+ofnh5XoL744Y4heYq3odDiUrp6Xm/68bqAKKvvKIthugLD98pwO
	IpyD40emzaziIjvDMS7CpBvqt0ZdlkqRCmkY1KRMZVQMGht83mIQN4B8h+TJSgXMlI90g1nNuoNzk
	Ksb9MYwob+k+bPR+rC8+BGP+Nj9YKoSRnu7ufY7i6NgYX3crNKYhlFj0Xsnc5iysmEgm5r4G8riiq
	SmX6mIquCyTjpbdVQVnlkx3n8GgchO9pEgYjkg2WoAKAUvTXZoS8IgmuGjZF1cWyetZ0iWxXEWL7V
	xbM6f8Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4RO-00DXGl-2z;
	Tue, 11 Jul 2023 03:53:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4RL-00DXFl-2v
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 03:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689047607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=np4ZI6Y9u+osACrZKJ15QQ6k0qV43pdokF3OlXrj8ck=;
	b=M3xE9L8my4jJpIIbTJ/kWl0BGlDEr8FRqa2spvVHK6FSwowfbuYaoLhMgZuzL7lF/ThdeR
	NsS/4pKaTGnS5hUIOcivELP3IMdDlglVXbKoo516BmCoVgEwns0+Zn6mauYjJBpxM+B0yX
	ihgYU5IrKpmby+68N5nR38a9FUKFgeE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-5JME2jPnPjy37hQuhsn9ag-1; Mon, 10 Jul 2023 23:53:21 -0400
X-MC-Unique: 5JME2jPnPjy37hQuhsn9ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A109D80006E;
	Tue, 11 Jul 2023 03:53:20 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 132EDC09A09;
	Tue, 11 Jul 2023 03:53:05 +0000 (UTC)
Date: Tue, 11 Jul 2023 11:53:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	Thomas Gleixner <tglx@linutronix.de>, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKzSHDPR7Jfoz/G8@ovpn-8-26.pek2.redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
 <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_205328_013892_1F5F25F9 
X-CRM114-Status: GOOD (  25.24  )
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

Hi Baoquan,

On Tue, Jul 11, 2023 at 11:35:50AM +0800, Baoquan He wrote:
> On 07/10/23 at 05:14pm, Ming Lei wrote:
> > On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > > Take blk-mq's knowledge into account for calculating io queues.
> > > > 
> > > > Fix wrong queue mapping in case of kdump kernel.
> > > > 
> > > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > > still returns all CPUs.
> > > 
> > > That's simply broken.  Please fix the arch code to make sure
> > > it does not return a bogus num_possible_cpus value for these
> > 
> > That is documented in Documentation/admin-guide/kdump/kdump.rst.
> > 
> > On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> > simply keep one of CPU cores as online, and others as offline.
> 
> I don't know maxcpus on arm and ppc64 well. But maxcpus=1 or nr_cpus=1
> are suggested parameter. Because usually nr_cpus=1 is enough to make
> kdump kernel work well to capture vmcore. However, user is allowed to
> specify nr_cpus=n (n>1) if they think multiple cpus are needed in kdump
> kernel. Your hard coding of cpu number in kdump kernel may be not so
> reasonable.

As I mentioned, for arm/ppc64, passing 'maxcpus=1' actually follows
Documentation/admin-guide/kdump/kdump.rst.

'nr_cpus=N' just works fine, so not related with this topic.

After 'maxcpus=1' is passed, kernel only brings up one of cpu cores as
online during booting, and others still can be put into online by
userspace. Now this way causes IO timeout on some storage device which
uses managed irq and supports multiple io queues.

Here the focus is if passing 'maxcpus=1' is valid for kdump
kernel, that is we want to hear from our arch/kdump guys.

If yes, something needs to be fixed, such as, what this patchset is
doing.

> 
> Please cc kexec mailing list when posting so that people can view the
> whole thread of discussion.

Already Cc kexe & arm/powerpc & irq list.


Thanks,
Ming



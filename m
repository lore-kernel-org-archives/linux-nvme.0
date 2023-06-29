Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D7FEB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcFzJ0h/r4o640kKx9oD5oKaAf0iz+R8cp1bGbk+mhI=; b=GtMz0003udyYXn1OxvbSVXKz+z
	rMuRFD5NBPaGw9EFMd8gMXP2cceMyIwrILKu6SU4IL2+ObhvBFC4kk4YG364vOYtkMK3xFpSzQt8p
	JvDvI9Vyo0/81k8JEjMwbzjr4uzsGbg4wNkNhwpyDMrDSMEGs+I9sc4Yqjatl2lo8hHpjgdWfphAt
	yW8BE+mUkF6sDRh8kcTBygHX7ptr59Q1b3nECGLk5eoJxRBMiIlceqzxNVaO9Z/9ujvIhHTmOVFNb
	o+sXxpsaXbC3dGQd1ROMVc/2oBf3mlZ3iytbWPjuPbqws9BMIgZDV/53CyyS0mhnZpzWRzn+TtV53
	DRBM7EvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEn6T-000PYC-0m;
	Thu, 29 Jun 2023 08:34:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEn6Q-000PXB-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 08:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688027649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcFzJ0h/r4o640kKx9oD5oKaAf0iz+R8cp1bGbk+mhI=;
	b=dPw+mKrKgvmqzLb+yP6nBiIwQVk5rpMMMHJlweWco4HEJhZ1+HGzObWYvUm3bmxD0E1drZ
	THovlyJbZWi+kjkLuTM9eLU9ZZYAAhjNNEspUUzKQ+GGJ86rsGAq5Byi0wJl4yu6GafZ1j
	pkqpgpR/0gmzJAHCmh7KLwHtbLWVcoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-P89DQgOTMauKEphGgInR0w-1; Thu, 29 Jun 2023 04:34:04 -0400
X-MC-Unique: P89DQgOTMauKEphGgInR0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF498104458F;
	Thu, 29 Jun 2023 08:34:02 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F8C5492C13;
	Thu, 29 Jun 2023 08:33:32 +0000 (UTC)
Date: Thu, 29 Jun 2023 16:33:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, dlemoal@kernel.org,
	nitheshshetty@gmail.com, gost.dev@samsung.com,
	Vincent Fu <vincent.fu@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <ZJ1B1k0KifZrGRIp@ovpn-8-26.pek2.redhat.com>
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
 <20230627183629.26571-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-4-nj.shetty@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_013410_619240_20CCD877 
X-CRM114-Status: GOOD (  15.88  )
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

Hi Nitesh,

On Wed, Jun 28, 2023 at 12:06:17AM +0530, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is

I can understand copy command does help for FS GC and fabrics storages,
but still not very clear why copy emulation is needed for kernel users,
is it just for covering both copy command and emulation in single
interface? Or other purposes?

I'd suggest to add more words about in-kernel users of copy emulation.

> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination asynchronously.
> Also emulation is used, if copy offload fails or partially completes.

Per my understanding, this kind of emulation may not be as efficient
as doing it in userspace(two linked io_uring SQEs, read & write with
shared buffer). But it is fine if there are real in-kernel such users.


Thanks,
Ming



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83460FF60DA
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 06:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCyOd8Hq2eAy0S/aAjPXgTm66WXi3qjg5wbQWwZEhK4=; b=cLpFgFuoC82LFloXb82lof3PIy
	ff2zVPNC/H5x3m4IOO6UqxB5tA9UDmFw8n0j00kQklPOvfRc2A4ZjPO0pswEgsLLjidcZ7gX3+l2J
	sXfVlcBTXBzs0nqDplygats4AVxtxTHT+yKOF5bmFa/vmJhJnZcUSSo40Z0/Sek66ORUY3hmkbm1w
	brcvpOZnudFboCKPVrK7ed8C9T2srwAGR9A85w97YhOMfDEF9KZdfrbeADzYP4hR9tcHbbfaLPkP6
	92jPJMPKnWcHxV7Txlh11vTfsaqnqRxRLOLUjVRFMHDg+6mRZ63d9vC0aDXgOdZIFYhBlDM7A3EgE
	RYI01kuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7SYB-0000000CMNe-3ZW0;
	Tue, 31 Mar 2026 06:26:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7NUy-0000000C6uj-4A50
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 01:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774918946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCyOd8Hq2eAy0S/aAjPXgTm66WXi3qjg5wbQWwZEhK4=;
	b=C/ROJU5441rgPmsy2UtOqPiz2F9xO9nBvz1nECvScRyaUKXX97VS5z1qRIu+uv46PoERBj
	YYM4oArY8mAb8fgf1K3NxfNY4W1z29/does9lwiJ88wmdXmxNLb4/6kZ27mg8zKhd7ykJl
	+g/Z8xF/7YfIBOkCXf/d+Cjd1mfXDJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-brngCdPJOnCsi5PsAzUHdw-1; Mon,
 30 Mar 2026 21:02:23 -0400
X-MC-Unique: brngCdPJOnCsi5PsAzUHdw-1
X-Mimecast-MFC-AGG-ID: brngCdPJOnCsi5PsAzUHdw_1774918938
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F39D1956056;
	Tue, 31 Mar 2026 01:02:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70BB319560AB;
	Tue, 31 Mar 2026 01:01:52 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:01:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 00/13] blk: honor isolcpus configuration
Message-ID: <acsc_GHv7Q04U1db@fedora>
References: <20260330221047.630206-1-atomlin@atomlin.com>
MIME-Version: 1.0
In-Reply-To: <20260330221047.630206-1-atomlin@atomlin.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: JZvSwLO2ZOE3dLRYeheaG-CRqE60F8yhu5V7rw0jHd0_1774918938
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_180229_102642_D44C1B71 
X-CRM114-Status: GOOD (  11.57  )
X-Mailman-Approved-At: Mon, 30 Mar 2026 23:26:01 -0700
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

On Mon, Mar 30, 2026 at 06:10:34PM -0400, Aaron Tomlin wrote:
> Hi Jens, Keith, Christoph, Sagi, Michael,
> 
> I have decided to drive this series forward on behalf of Daniel Wagner, the
> original author. This iteration addresses the outstanding architectural and
> concurrency concerns raised during the previous review cycle, and the series
> has been rebased on v7.0-rc5-509-g545475aebc2a.
> 
> Building upon prior iterations, this series introduces critical
> architectural refinements to the mapping and affinity spreading algorithms
> to guarantee thread safety and resilience against concurrent CPU-hotplug
> operations. Previously, the block layer relied on a shared global static
> mask (i.e., blk_hk_online_mask), which proved vulnerable to race conditions
> during rapid hotplug events. This vulnerability was recently highlighted by
> the kernel test robot, which encountered a NULL pointer dereference during
> rcutorture (cpuhotplug) stress testing due to concurrent mask modification.

Can you share the bug report link?

IMO, it should be solved as a backportable patch first if possible.


Thanks,
Ming



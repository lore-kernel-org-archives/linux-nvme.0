Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC38C3ABBE
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iyHYYqFLt4BDQ21nbDC7DuYcsAS65G7vhmyYZcxpcRs=; b=p40yPD3ESWut/9ReLOqqlPzxeb
	2POIS3G+PrQs4oxK2ESkuZ447Vn87i02+9wQZ3DLs60emAAmOwdziuPv7MaYD4ganz00R8sCDt89Q
	bUNPewE75JN3LjP4wb2rmgE2pb/xCk8enLDsyCu+x+J/28JMEe2E7Pehi06KVGU6wpK74MgKHArdR
	X6ueo57T9FLSqo3j1vBZuk2/KvqocNAN9/xARNKWPu7tSutqkRREqQxdYqt68Z030n1sy7N+ByfHd
	AULfzSo1EadpBGLOFnm73zcM3TyBPsZoKpEWI9yx1MGYj3et2DxLrmvwOt3Nc0aD0ixwBa4E6NHOH
	aPPSey0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDCsb-00000002CL5-0Kc1;
	Fri, 09 May 2025 01:50:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDCsX-00000002CKj-2rcK
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 01:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746755420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyHYYqFLt4BDQ21nbDC7DuYcsAS65G7vhmyYZcxpcRs=;
	b=SdgjCcKUkxpYSHQIYYbF0xpiN/SrQ/3SjyxfJIFuWkyq0jXx1iI+TELxpyadzfa9bAKpio
	MDW6TvIjRH8M0XdzGMjNawXY/uAotl6X43I7j9ajRI+KSMaIqFtpnZGAfVtZawCq2Ij4u4
	K9uiPj6iKM2a/aU5TqPUBbA606GCzog=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-haDHg9-3N-Cj6Qx2WUt9tg-1; Thu,
 08 May 2025 21:50:15 -0400
X-MC-Unique: haDHg9-3N-Cj6Qx2WUt9tg-1
X-Mimecast-MFC-AGG-ID: haDHg9-3N-Cj6Qx2WUt9tg_1746755406
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59069195608F;
	Fri,  9 May 2025 01:50:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CB0E1955BC0;
	Fri,  9 May 2025 01:49:52 +0000 (UTC)
Date: Fri, 9 May 2025 09:49:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 4/9] scsi: use block layer helpers to calculate num of
 queues
Message-ID: <aB1fO4AV73VXocMP@fedora>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-4-9a53a870ca1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-isolcpus-io-queues-v6-4-9a53a870ca1f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_185021_809318_CB95CBC3 
X-CRM114-Status: GOOD (  12.20  )
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

On Thu, Apr 24, 2025 at 08:19:43PM +0200, Daniel Wagner wrote:
> Multiqueue devices should only allocate queues for the housekeeping CPUs
> when isolcpus=managed_irq is set.

> This avoids that the isolated CPUs get disturbed with OS workload.

The above words should be removed, since that isn't what the patch is
doing.

Otherwise, looks fine to me:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming



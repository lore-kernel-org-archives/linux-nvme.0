Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EC3C3065C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 01:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+yILBKwboaBzs+O/a7xA/ftOieZ/C/5HQTQnjCyrQM=; b=Q3gI89VaweLx2EUGphs8WK6TJR
	uIrvnXbyi+84ama7P7lxjxyM/3SjXLxE5Fkvdq/jxUjLuLTrEu9ntP3/cEM+HKWQGHKr9Vxd1tA1/
	VRhoQjdZjY37+fBQkIsyXY9o/uLhiq/K4mFhi6u6v6iHfMhV4DFBZMvcMqiRFBi7uvDU2TlI44/jZ
	IVC4v2heT5s471DQirLa7+SiZPReTjtDJxtKtNpRDJPVeidv5SnBngku+JERGyWufmYG5yUgX1XDc
	LlNP1knYsIm5BcYzaAvCcsm9qVZfOhYWMM81QawPFNRS20cOw0qsm/ogF1MVwLxjnMXiu7Xv8rENr
	t7FuuxSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOpFm-00000008WmB-0Ttl;
	Wed, 03 Jul 2024 01:57:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOpFj-00000008Wli-0EC4
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 01:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719971866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+yILBKwboaBzs+O/a7xA/ftOieZ/C/5HQTQnjCyrQM=;
	b=OOmZ18LwLaII1phmpJX8XETdGAsGPxww4+n7ze7BaSbviay6tvTKzTSDwk5uBQSnWkuwyv
	VbfqNXLb4RiX7XPM6CZ5B/EbpSKC2ycENCWNufsSV8KynztZcD4KDKAj6aHP1QDn0YumF2
	C4yCGoUtVhPh8IkSLlGTRyNnKNVqmKY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-FgX_WSu3Miu3xOQvuvoHvw-1; Tue,
 02 Jul 2024 21:57:41 -0400
X-MC-Unique: FgX_WSu3Miu3xOQvuvoHvw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4CB319560B0;
	Wed,  3 Jul 2024 01:57:40 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E55731955E80;
	Wed,  3 Jul 2024 01:57:34 +0000 (UTC)
Date: Wed, 3 Jul 2024 09:57:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Lawrence Troup (ltroup)" <ltroup@cisco.com>,
	Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Franck Baudin <fbaudin@redhat.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <ZoSwCeZZIiQqisYG@fedora>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <20240702115002.GA16219@lst.de>
 <ZoPum7MPTuA6/t7O@fedora>
 <MN0PR11MB6280284585EC79A329095CC6C0DC2@MN0PR11MB6280.namprd11.prod.outlook.com>
 <20240702152809.GA32373@lst.de>
MIME-Version: 1.0
In-Reply-To: <20240702152809.GA32373@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_185747_184378_A64F93EC 
X-CRM114-Status: GOOD (  16.05  )
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

On Tue, Jul 02, 2024 at 05:28:09PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 12:20:30PM +0000, Lawrence Troup (ltroup) wrote:
> > Openshift needs the ability to dynamically move IRQs of all drivers away from a specific set of CPUs, at the point that an isolated workload starts running on those CPUs, and requires high performance guarantees, i.e. no HW interrupts to occur. To achieve this, dynamic setting of the smp_affinity for all drivers is used - at the moment, the NVME driver does not support this, so the NVME IRQs remain running on CPUs they should not be on, and so impact performance of the isolated workload.
> 
> Then you need to create a core kernel interface that moves all managed
> IRQs of these CPUs.

It is basically not doable or too hard since blk-mq queue mapping
depends on managed irq affinity.

> Without that you have a never ending whack a mole
> adding hacks to the drivers of the day that you care about.

So far, most popular SCSI hosts support the option via module parameter, and
the only remainder could be nvme-pci.


Thanks, 
Ming



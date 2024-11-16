Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD7D68BE3
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2024 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bw0HmhHxzWTrpcJPfrAm2KQ2tVa5V6s85XkvUWCpfLk=; b=hF+bykJxeYvqoxqkyU7y7Z9Ir5
	N8r/QyIk46hRA/+/GPPQKisehEZiWmkyZtsC0FKQi8SzpXomtEniGGtuqhk5aWNh/BOXDgnBssSD3
	yC69Ggze8l8avHeMgwMtyOxGTjsMHO0PXMERQm4d9MexswTKORJcI9WVzC0hAma4prABpcCKZSgef
	4v5E6M5/SWyUhMuZuBYm748xEq5Uj1/d+ctkfkvD8DeZEd0HoSh+yva9JrmGNdbly2+eZWwAtRGbt
	2IBcf2ZsniDRPL4kWV4w9cjy9amd3Ll2xpk7AxmzKu9TVEGuROLYbU3AlVat20YA+KzAJymY5Ulxj
	yhRgFX0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCDTe-000000059xe-1kOS;
	Sat, 16 Nov 2024 07:44:18 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tCDTc-000000059wg-0gF5
	for linux-nvme@lists.infradead.org;
	Sat, 16 Nov 2024 07:44:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9D0F5A4029A;
	Sat, 16 Nov 2024 07:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C5BC4CEC3;
	Sat, 16 Nov 2024 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731743055;
	bh=KjZjAEkpsSJVk26vPJowBhePl2ldo8B8xA9M+L+OP1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOQCUicnwHNNzRTBmMFH15E3g7z4J3tIJqz7Dr9Ale/FyqEtTpNLZfPxqhM19/8CY
	 E8lmIRCIY2Xcfm7maGcIKl1o/VmaE6VpJVF9DrbOnoeJS1bFBBLDCygNBuYtlN9iXn
	 Pdtrt352UODTQ6+/exPN8L8OXRJwaEyEG43NYmh4=
Date: Sat, 16 Nov 2024 08:43:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <2024111642-bush-violet-da1a@gregkh>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-1-c472afd84d9f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-1-c472afd84d9f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_234416_261872_FCAF9C42 
X-CRM114-Status: GOOD (  10.34  )
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

On Fri, Nov 15, 2024 at 05:37:45PM +0100, Daniel Wagner wrote:
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


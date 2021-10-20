Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103F1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:57:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D082B60E8C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D082B60E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=puBXKezbCFrwPfTP7DvjmJM2UBeik57g8iKslIyjAtk=; b=z3iju8xtKKDKm2OyeiyS72xVFN
	vXk6r0oqLxBKynzo+Ak7xvE2LkSrJUzEywce3ZYhmnZZmjTI6KagsSbyoAXxBChJMgY3k21zaKcp8
	qno6MqZ1b7SBdFR8bHRxeFCpCuDdbQqoNSHK+qMHhW5nxuoyJZ8uSU7D3ktmLFu/5sZ6rmItQYUmi
	o1rmiifoVjgccdESq9jezb3LvaUcFUolmzQpRu+NMMVJkU+/HGKqqIITurFa0w2BJCMH5jxTZisiM
	wwUAnB9H8vNMTIKS5D9x87aQfJNy6QxIb31iRv0r2yGE0pICNsgQKFr8gpBDLe770GI6DM/Y/Di8C
	cfSr9ZVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdDxs-00597W-6n; Wed, 20 Oct 2021 15:57:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdDxo-00596z-SG
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 15:57:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F27160ED5;
 Wed, 20 Oct 2021 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634745432;
 bh=n/qZcoN9d5Kq1RFq5XBPyQb7rQf4VGoGsCv/XK/aZqY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BxxSdo7BzOaUEmuIRJK3Q2n52frFXPwtpkomqEq6q6JmDku0FKdBtlWkLLxxfY/V1
 ExsqLtKkAEf5nDPpdm/Dq7KfIz2Zwo0p8viBxUeg1Rfy8BIuH0xSGp4cqatvP92eEA
 VFF2MYQjFeA4UODEhQ7v94eOf1qU6W5B1Vy4kT7R2QMPdJrytI0Jfp0RYzH0/UVFVm
 ug9Q1ejkpXkqF/H8WR02cqdgcC+UHhyW6+FnSOQwibmU8JsNF8PmEptT5YCG4tq06Z
 v+ZAZa3P7SAI072PDaGRp3aGakxQEY3dSkq/wJsHJmomlOamT6i4kjtzoaGX/5xFV1
 le4yAVuFmgvig==
Date: Wed, 20 Oct 2021 08:57:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH] nvme: drop scan_lock and always kick requeue list when
 removing namespaces
Message-ID: <20211020155709.GA2112644@dhcp-10-100-145-180.wdc.com>
References: <20211020055910.110695-1-hare@suse.de>
 <e44c4a84-c678-ebb2-b267-c7557d824ac2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e44c4a84-c678-ebb2-b267-c7557d824ac2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_085713_001831_52853CF3 
X-CRM114-Status: GOOD (  23.93  )
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

On Wed, Oct 20, 2021 at 06:33:48PM +0300, Sagi Grimberg wrote:
> On 10/20/21 8:59 AM, Hannes Reinecke wrote:
> > When reading the partition table on initial scan hits an I/O error the
> > I/O will hang with the scan_mutex held:
> > 
> > [<0>] do_read_cache_page+0x49b/0x790
> > [<0>] read_part_sector+0x39/0xe0
> > [<0>] read_lba+0xf9/0x1d0
> > [<0>] efi_partition+0xf1/0x7f0
> > [<0>] bdev_disk_changed+0x1ee/0x550
> > [<0>] blkdev_get_whole+0x81/0x90
> > [<0>] blkdev_get_by_dev+0x128/0x2e0
> > [<0>] device_add_disk+0x377/0x3c0
> > [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
> > [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
> > [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
> > [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
> > [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
> > [<0>] process_one_work+0x231/0x420
> > 
> > and trying to delete the controller will deadlock as it tries to grab
> > the scan mutex:
> > 
> > [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
> > [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
> > [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
> > 
> > As we're now properly ordering the namespace list there is no need to
> > hold the scan_mutex in nvme_mpath_clear_ctrl_paths() anymore.
> > And we always need to kick the requeue list as the path will be marked
> > as unusable and I/O will be requeued _without_ a current path.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > ---
> >   drivers/nvme/host/multipath.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index fb96e900dd3a..475224ecee8b 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -141,13 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
> >   {
> >   	struct nvme_ns *ns;
> > -	mutex_lock(&ctrl->scan_lock);
> >   	down_read(&ctrl->namespaces_rwsem);
> > -	list_for_each_entry(ns, &ctrl->namespaces, list)
> > -		if (nvme_mpath_clear_current_path(ns))
> > -			kblockd_schedule_work(&ns->head->requeue_work);
> > +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> > +		nvme_mpath_clear_current_path(ns);
> > +		kblockd_schedule_work(&ns->head->requeue_work);
> > +	}
> >   	up_read(&ctrl->namespaces_rwsem);
> > -	mutex_unlock(&ctrl->scan_lock);
> >   }
> >   void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> 
> I think this works,
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Christoph, Keith, Hannes, Chaitanya,
> Do you see any issues with this?

No issue that I can see. The namespaces_rwsem looks like all we need
here.

Reviewed-by:

Keith Busch <kbusch@kernel.org>


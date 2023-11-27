Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B4C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DKYWg02sQhk17I8+i3J13/5ln/Edo/wZOpwVk1QeYM=; b=M7C2gy1PQRLiMTj388DNlG35E4
	H4CadwYIbQo5TRDW8uR9pYjhCDftEwFQf3p3pkH7A0SyUci2/LebwOcW+iBQ1IUSovlEQv14Smdno
	tUCcgU5/yvXaMylEEqI2xx/pYNrJh6CKSl+bE11iWswwpcs9jdQsbbJL2qoZCdIeioDV2ox4HT7rJ
	ABbcsejzmqpBOPkxeATjrlpmqlZimTu7ITWMP1wL4dHyDKOWhRxx5ozqV0fME/Lygz/9bu290P7kq
	J5M4Ql1HCEoGiU0Hk3HUTcBmR96YsyY0l4f/8gE7pO0prPg9PhFgbM1LSpm4eDL6epCXjd9n7ogLd
	dnwi5LbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7cS3-002gTs-0j;
	Mon, 27 Nov 2023 14:19:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7cRz-002gSz-33
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 14:19:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5652667373; Mon, 27 Nov 2023 15:18:58 +0100 (CET)
Date: Mon, 27 Nov 2023 15:18:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127141857.GA25833@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127103208.25748-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_061904_132284_EE93E578 
X-CRM114-Status: GOOD (  20.95  )
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

On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> Also getting a pointer to the nvme_ns data structure is a bit strange
> (dev_to_nvme_ns).
> This stip is necessary as many of the ns attributes are in
> nvme_ns. Shouldn't these per path values not all be the same and thus couldn't
> these be in nvme_ns_head? Anyway, just not sure who to deal with this. So any
> pointers highly welcomed!

Yes, they probably should be in the ns_head.

> +		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +			down_read(&ctrl->namespaces_rwsem);
> +			list_for_each_entry(ns, &ctrl->namespaces, list) {
> +				ret = ns;
> +				break;
> +			}
> +			up_read(&ctrl->namespaces_rwsem);
> +		}
> +		return ret;
> +	}

.. I also don't think this would even be safe as-is as we dont hold
a reference to the ns after dropping the lock.

> +static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ids.csi);
> +}
> +static DEVICE_ATTR_RO(csi);
> +
> +static ssize_t lba_ds_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ns->lba_shift);

lba_ds is a bit of an odd name.  And I also don't think we even need
this, because it really is just a weird enconding for the logical block
size already exposed by the block layer.

> +static ssize_t lba_ms_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ns->ms);
> +}
> +static DEVICE_ATTR_RO(lba_ms);

I'd probably spell out metadata_size, or probably even better
metadata_bytes to match the unit postfixes elsewhere in the block code.

> +
> +static ssize_t nsze_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> +
> +	return sysfs_emit(buf, "%llu\n", ns->nsze);
> +}
> +static DEVICE_ATTR_RO(nsze);

This is just the normal size of the block device we already export.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF71C28B30
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 05:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whmPEYHG6N1H8UlgtSGjiPfpFSDvL0exFGvh42fP/5g=; b=0YQxnJWzvFf1UmQoHVTFuol+8q
	WhGYPcfjlHMzqfa37/Rwf9HBsjBj/nrO+M7ghoA2gUZJgb3Mcc3zktUBCLVSKJT6OrsyDLQQC6Zhn
	zGHH9bAxHH5K8JV/O9K/vyAtgszvgUTOc+AvgXFfU+IRi+MnFI5LyyGQ9jzooOt9zs5LbXBndeqRk
	YuNpaJ+2y57cjRAZqmlb/ZGkF/LqITBkMVG9qf2JlnaJxsGMamcHbuSwMB7evkGfu9ztmbSGY8C0H
	6tf3EZdPeazvt6Op4FsjDsjkPRokj4+pOa/ipu/i2gGI6W31/llg/+Bh8wvCn43Ten+xT9Q/f94C5
	xrgIL2YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8lK-0000000BFNK-15C8;
	Thu, 20 Mar 2025 05:48:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8lH-0000000BFMr-3Blz;
	Thu, 20 Mar 2025 05:48:11 +0000
Date: Wed, 19 Mar 2025 22:48:11 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z9usG3LELEWPYSUG@infradead.org>
References: <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
 <Z6GivxxFWFZhN7jD@infradead.org>
 <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
 <CGME20250318080742epcas5p31b31b3024d6f7d9d150c8a7c2db4dffd@epcas5p3.samsung.com>
 <Z9kpyh_8RH5irL96@infradead.org>
 <435cf6be-98e7-4b8b-ae42-e074091de991@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435cf6be-98e7-4b8b-ae42-e074091de991@samsung.com>
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

On Wed, Mar 19, 2025 at 11:36:28PM +0530, Kanchan Joshi wrote:
> I tried to describe that in the cover letter of the PoC:
> https://lore.kernel.org/linux-btrfs/20250129140207.22718-1-joshi.k@samsung.com/

I don't think it does as people have pointed that out multiple times.
Once you do checksums on the device they are not end to end, either in
the T10 DIF definition or that of file system checksums.  You leave a
huge glaring gap in the protection envelope.  So calling this "offload"
is extremely dishonest and misleading.



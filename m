Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C18C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 20:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E393360234
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 20:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E393360234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SkJ2gMOTiXOyE4qPkAIoRJCdER/9LCzVc4UUpvjmi+0=; b=xcr2/V63Y5XlcB
	UPazm7PL5Lz0o3YdWekmUY4vLkvl/2zpwY/QUGot9fFDPRlNjHO/bEm7lhD8Lp0/BgEZzrz+A9o1x
	IhmeIJ++eN0COzkIfjSSN+rS/TpSaGuxhdSAfxo5+VdCo3J/u/ZfuDWZ904nmj9HmzKwDx8Ph9Jtc
	YZ1vSqBHGOg2NEowhH1NvsIjWxSFhYTq+ZHSs2AyFtkP7lT016sWlDjrVQVJXlTIuKuB0aF91QXC2
	4Me6ECbjUDTPo1fskKFL+5l24ADPui6DgGeVUtCy+DWFGDiTv5JUm7jIvDq9YmyvSzO0uSXC7zJUF
	VtyaG8BV62utwe7e/yOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJiTr-00DCq1-BH; Fri, 27 Aug 2021 20:29:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJiTo-00DCov-H1
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 20:29:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 977CB60FD8;
 Fri, 27 Aug 2021 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630096176;
 bh=88bih5eGKB9i2ESLsafMWzYIwyGke7MVW8Rm8LZaCJM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VqgAkXLSFQ2s8YBhV0/BkRbyvjYS7iN8wS3+vPnrfYwjeVZbT3EcOkpsbz+6iOIIg
 K59JPqJADG5mnk2BZMwXfm+2K/QX3GabYmGmJMq75CAhfxkg4e7sYb4W90iqXt4wjY
 CCBcmFMkK/fitfaaSpE06RYuhbvQkR1xSjgZLyqV+ldHSk85VfL/sYK3yuWYBDlle0
 4C9yBY22Kb164kHW1308QMn1cbMYjo7ekT+NZW9nIbbZyeN7dvOl3QZ8uGzlQBiwYO
 xvNRlNxn6B/Q+DSji3QgnHGBcKriUM+BPc6qVP1hIdIo6lvljcLrqIlc4i6mgmBrgk
 KvuManA4RC1Fw==
Date: Fri, 27 Aug 2021 13:29:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, colyli@suse.de, kent.overstreet@gmail.com,
 sagi@grimberg.me, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 konrad.wilk@oracle.com, roger.pau@citrix.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20210827202932.GA82376@dhcp-10-100-145-180.wdc.com>
References: <20210827191809.3118103-1-mcgrof@kernel.org>
 <20210827191809.3118103-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827191809.3118103-4-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210827_132936_622077_9657F8D3 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 27, 2021 at 12:18:02PM -0700, Luis Chamberlain wrote:
> @@ -479,13 +479,17 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  static void nvme_mpath_set_live(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
> +	int rc;
>  
>  	if (!head->disk)
>  		return;
>  
> -	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> -		device_add_disk(&head->subsys->dev, head->disk,
> -				nvme_ns_id_attr_groups);
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {

This should still be test_and_set_bit() because it is protecting against
two nvme paths simultaneously calling device_add_disk() on the same
namespace head.

> +		rc = device_add_disk(&head->subsys->dev, head->disk,
> +				     nvme_ns_id_attr_groups);
> +		if (rc)
> +			return;
> +		set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
>  		nvme_add_ns_head_cdev(head);
>  	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

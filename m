Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F497C021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c5r8B8FRtWj5F/lOwyJCGOrGALFwc+xhMPApnCgm2s8=; b=UKGtWxiSwqsCzKBseRAmF0nWP3
	5M5QrYXSI7nj3TzDEq0f5aXZZCB+O4kf+Cq7Fq1fMoReDaxD+6s4khEqjGy87ktTE7dnf8MLRjNeI
	OiIZDubxvM9kGBo//4G9sM52Ih2bcf5AuaKAH64ao4/t/F7+/88o1qHU5zB+z1X4zodj5J0Gd8T2P
	Kuir8Z0QMQnGUpRzFzl8+sSk9IVECS0ceGNnVH1+Tl9LWHkuGtPPgXkNNuQnWpQSrZE3HIXhEdlE7
	lZLS6TyV4eZgMXEuWkhzRxyzi1vDyvAIrdSUM6YhvODdTtI8/4oTDJE6mtbbV8PTEJOWCat6BTX0r
	buLCdhAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thcgk-00000001kQj-1VWp;
	Mon, 10 Feb 2025 22:55:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thcOE-00000001gBI-0yLi
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Feb 2025 22:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c5r8B8FRtWj5F/lOwyJCGOrGALFwc+xhMPApnCgm2s8=; b=ADPclabqkKS0JDi0RCGOmnR/Ok
	JOTYHD4L2WZ7yEvheJ3rG3/kvogzr2Tx262L4lfKYAhMyLHyiUtXK53VoI2pRY9hbJlPUZs3K08PG
	sAFLB9EXQdDJf14s/UKYfYl2yrnz9cxKktwRW159pB8wzSqS5Jx/HQGmiarENTFX83IneEEW3AXkE
	TvxDqOFyB+8csTpvGBDYsoPDQVBcGo8L8tBVx8NqWhlmyh2p1IB6lmMA5BfMhow2vJRlDvfPKbuAY
	cjXzQNwemJndX5SbC18MQiFgv3iutjwgPYlpeKMx0Siv8fEv5L9WQw5pjuB20kZyUayr0jmKvcSzi
	IbGfW+aw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thcO9-00000000KLy-2c00
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 22:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739226981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5r8B8FRtWj5F/lOwyJCGOrGALFwc+xhMPApnCgm2s8=;
	b=SopERS4rPPD/sVTploOb5DH+UCMn3ANxzBRRqT6Ek1r6C+CI5sGvOafaNI/wpWNkOjFFBG
	xjAgCLWKI7we5pm9n0J0qpgvPFABxkGQP1Ag3mvXfwBwPKLMYgispsGnrHfgDI6gCxwGEB
	vYXGSJ8QhbP5LS+Xkt1Uf3GzJiBxN5I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739226982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5r8B8FRtWj5F/lOwyJCGOrGALFwc+xhMPApnCgm2s8=;
	b=M7QhTGilTcD6gwRttjoRiwr+vk7vaozipAv4xjdorhiCmxt+fncVtRnERIQxxSF/LgEpg3
	pYANMP5HQ2OB9m22DggkITj6w4RvBK8fsG4lejyH/PEJZZrDFozvhSoc994SoKarKfz6Cg
	xcjacYERLaXnR5nSvh89Ea9efmDEwjE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-kew8mM_LO_ugytJEgig5uw-1; Mon,
 10 Feb 2025 17:34:50 -0500
X-MC-Unique: kew8mM_LO_ugytJEgig5uw-1
X-Mimecast-MFC-AGG-ID: kew8mM_LO_ugytJEgig5uw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B81111800264;
	Mon, 10 Feb 2025 22:34:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEF0D30001AB;
	Mon, 10 Feb 2025 22:34:45 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 51AMYifL838184
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 17:34:44 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 51AMYg0l838182;
	Mon, 10 Feb 2025 17:34:42 -0500
Date: Mon, 10 Feb 2025 17:34:42 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
        djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 4/8] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Message-ID: <Z6p_AsZy41XMCEh5@redhat.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
 <Z6aFtJzGWMNhILJW@redhat.com>
 <3b1dcd45-efa6-4aad-9cd4-3302a29eb093@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1dcd45-efa6-4aad-9cd4-3302a29eb093@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_223625_958001_FE5DCDC2 
X-CRM114-Status: GOOD (  24.64  )
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

On Sat, Feb 08, 2025 at 11:12:57AM +0800, Zhang Yi wrote:
> On 2025/2/8 6:14, Benjamin Marzinski wrote:
> > On Wed, Jan 15, 2025 at 07:46:33PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
> >> default. This feature shall be disabled if any underlying device does
> >> not support it.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  drivers/md/dm-table.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> >> index bd8b796ae683..58cce31bcc1e 100644
> >> --- a/drivers/md/dm-table.c
> >> +++ b/drivers/md/dm-table.c
> >> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
> >>  static void dm_set_stacking_limits(struct queue_limits *limits)
> >>  {
> >>  	blk_set_stacking_limits(limits);
> >> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> >> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
> >> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
> >>  }
> >>  
> > 
> > dm_table_set_restrictions() can set limits->max_write_zeroes_sectors to
> > 0, and it's called after dm_calculate_queue_limits(), which calls
> > blk_stack_limits(). Just to avoid having the BLK_FEAT_WRITE_ZEROES_UNMAP
> > still set while a device's max_write_zeroes_sectors is 0, it seems like
> > you would want to clear it as well if dm_table_set_restrictions() sets
> > limits->max_write_zeroes_sectors to 0.
> > 
> 
> Hi, Ben!
> 
> Yeah, right. Thanks for pointing this out, and I also checked other
> instances in dm where max_write_zeroes_sectors is set to 0, and it seems
> we should also clear BLK_FEAT_WRITE_ZEROES_UNMAP in
> disable_write_zeroes() as well.

Yep. Makes sense.

Thanks
-Ben

> 
> Thanks,
> Yi.



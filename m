Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19EBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 01:06:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DAC61247
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 01:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62DAC61247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u15r5tlHLh9xwXhsGNstMaHBECmABDxMYwpF099tn14=; b=CgX7aEtbXh1NYzyBEARwOFBc2y
	dCEQddYS14UrB2+8Qw35ER4H0ZxLMPUBs+0qxA99NGXa7G0sltMYgxBd9qb3u8wZj3zm+T0iU8sNF
	/y6pF6cByZ37gceaDYmH6ogfm10w9fINlaGitSk0e6HzkJ9V0JQfjQuwuNA8PRI3LPbJ252kNwTU8
	bVAgivc0SEwqo6U+XK2MFF50qoseZPhiUBm54kH0XYLp7F1+XNRSmeSsGkZLiYzBRAuzaoVnM/aTD
	+z1+4L20JR427/tHilRRvPxvGUfvUgC7PNHx356Y88vU0pLF25BjBqiBINd6Q0rvG6I5qe3IcpxIc
	FFJtnxGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcH6V-00DafY-Pn; Mon, 18 Oct 2021 01:06:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcH6S-00DaeN-PV
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 01:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634519168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u15r5tlHLh9xwXhsGNstMaHBECmABDxMYwpF099tn14=;
 b=YlLikYxJ9u21XXZolTyHJMhwgDpcFHX6T6tRje0Yrr+7E1BAMowtK8AJy7unL2AdPC2VI4
 8pvw9LgeR4Z2ZceOf7Vt0nfiwJ4nME/fgyY9GFC2tKbetltybtlJjfrm1fXIC9SSSZ5dcb
 5n5MKYe4r19VUDuHCBzBcKzvZokzTVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-HM5rmnasMbWnXW9itrfqWg-1; Sun, 17 Oct 2021 21:06:02 -0400
X-MC-Unique: HM5rmnasMbWnXW9itrfqWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B019579EDC;
 Mon, 18 Oct 2021 01:06:00 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D57945C232;
 Mon, 18 Oct 2021 01:05:52 +0000 (UTC)
Date: Mon, 18 Oct 2021 09:05:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Message-ID: <YWzIazr+VjY9MNCv@T590>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014121145.GB15198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014121145.GB15198@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_180612_947342_7CE02CC5 
X-CRM114-Status: GOOD (  15.59  )
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

On Thu, Oct 14, 2021 at 02:11:45PM +0200, Christoph Hellwig wrote:
> Except for the nitpick just noted this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I plan to apply at least 1-5 to the nvme tree with that nitpick fixed
> up locally.
> 
> Jens: do you want me to take the last patch through the nvme tree as
> well?

Hello Jens & Christoph,

Any chance to make it in v5.16?


Thanks,
Ming



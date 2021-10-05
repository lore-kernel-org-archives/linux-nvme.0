Return-Path: <SRS0=bdbJ=OZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 02:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452B7613A1
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 02:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 452B7613A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/dGDc7Vb6Ekaf9nOwFdBx54HJR045yLa2cfhaasDI8=; b=3DD8oLBbWCZGPm
	T+bcjFp3mAf4afCxnmQ+xY3qhCvBsyca78hUhvjTReu1HmNYcsYFdyiJR1WER2DCuTwu8WHAOoSMp
	IoSgY9WiIfPehNSv+Y5xThprsq0myBkR/dgdrF9qnmBmMpa5JdDkvCHszDEohfJeezzKwhyZmieMD
	lFDojKahjUHF725sEQSvtVkrsoWY1sFv27gd55e6ODuiq5FYLC8j+oCVujYvbD2QpyQy1YKtMRerr
	ZGwBd3S8+hXUcFUP8xK/035g5pGw3jpk3dPOTM5JuHNB/cDuBHJb+m4kxTULfpCBE2vq40RCQVoqy
	4DJefLjyHsusP98PHSiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXa7D-008hmE-7y; Tue, 05 Oct 2021 02:23:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXa7A-008hlY-3l
 for linux-nvme@lists.infradead.org; Tue, 05 Oct 2021 02:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633400609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYdkGFNsg1XrWYpT1DFPpG2yoQQsTykXaPTXZFbd9MA=;
 b=CMRzfHzS9ZohXhGcA8CVSRST2ETJd3ttiLNYEvlb/ZcCLG1t27rUgMNg0w9HRdD5/5JPYR
 0gW8TGnrJd2AoNLuu8kpVcIqRkjo1HznchQ4ijz8+zJoKSyFSlLTjeCAExCcg5Q4oRvVnI
 ggOPN5qQXwy1jwnBdUACeN4zb/KuVt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-qGAyL6GpNmuEMhpGzMw54A-1; Mon, 04 Oct 2021 22:23:25 -0400
X-MC-Unique: qGAyL6GpNmuEMhpGzMw54A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910C2180830B;
 Tue,  5 Oct 2021 02:23:24 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93CFA60657;
 Tue,  5 Oct 2021 02:23:19 +0000 (UTC)
Date: Tue, 5 Oct 2021 10:23:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Message-ID: <YVu3EjPqT8VME/oY@T590>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_192332_270405_D0775DC3 
X-CRM114-Status: GOOD (  19.17  )
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

Hello Chaitanya,

On Fri, Oct 01, 2021 at 05:56:04AM +0000, Chaitanya Kulkarni wrote:
> On 9/30/2021 5:56 AM, Ming Lei wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Add two APIs for stopping and starting admin queue.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> 
> this patch looks good to me, but from the feedback I've received in past 
> we need to add the new functions in the patch where they are actually 
> used than adding it in a separate patch.

The added two APIs are exported via EXPORT_SYMBOL_GPL(), so it won't
cause any build warning. I see lots of such practise too.

It is easier for reviewing in this way since the 1st patch focuses on
API implementation, and the 2nd patch focuses on using the API,
especially there are lots of users in patch 2.

But if you really don't like this way, I am fine to merge the two since
merging is always easier than splitting, :-)


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

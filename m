Return-Path: <SRS0=oVUq=4U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE0C3F2C6
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 20:20:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BA720842
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 20:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fIqYvSRN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoJhOzbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BA720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yEg1wPZa+yzIN7cWUGGJORelCaO1vQ0K3BHe4U892YU=; b=fIqYvSRNydQzi2
	72M+wCft/fH8L14N2KjctnkXIbcRfEu6fqKdYAFoN12nYeMIXRPYGgC6PVmcK76tPXLwfseJe1sXL
	+oFlYoM6ygQbNfd5tf9vtfFhf0l2ZYw75L6MtUCFggCcP66036XMnBbMY0GZjIcRwx6gSZuM27uyO
	rNAoUIVw8ujnJtc3D0X0H1C7S4W2y2+2GdQ5rmJBohIgIlFAjsCkUXu6TkNFpSo9yl6TlqXPsfxtO
	ueLsibRAQ+IEhdWuaRqZrEC3Xb+dID2yJJL8P6hVRqfUxjlbRRb6/DnM/OvwhXs3r9LI/vxpSAfRk
	7qel6funb635WNnDTqdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9E1y-0008IF-8L; Tue, 03 Mar 2020 20:20:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9E1u-0008Hd-HH
 for linux-nvme@lists.infradead.org; Tue, 03 Mar 2020 20:20:39 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D387620CC7;
 Tue,  3 Mar 2020 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583266835;
 bh=e6wE0Cu8UchbQPnOplEUCLjQTVHqtR0gUxUBtrSXDpc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MoJhOzbFot297vSuM9Zh2gJ00wpQAbMr0JD/luMKW3YuNL74/ENj4lKXr7pA51hEm
 f1rWb0ObpNnkv6zaVXL+DcbDooHuR9D+KuXd0PvIl32BKIUJeZPEM6k8rMOphVoqlz
 rLDMWU6ARo1NjEyGMtl1/ccOJF8t/nISnjgBh6rw=
Date: Wed, 4 Mar 2020 05:20:28 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200303202028.GA12836@redsun51.ssa.fujisawa.hgst.com>
References: <20200229025228.GA203607@localhost>
 <f97877d5-2cb5-426f-3117-0b439b00b88c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f97877d5-2cb5-426f-3117-0b439b00b88c@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200303_122038_593287_E69130EE 
X-CRM114-Status: UNSURE (   7.34  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Josh Triplett <josh@joshtriplett.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, queued up for 5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

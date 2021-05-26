Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C05C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:26:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39AD60FE7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39AD60FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o2aW7TwUF2Eb3A20nnq76xuW881gLe1fdoHieKlUYTk=; b=aShgOH9tNgaVrg
	g++DXNgYVdiTN+orRVvcBmzOxxM/6ona0Wc7rQSsCw+w4janPzqk0dNscILnr6j2V9ML96i01nxkW
	fkPFodjPEFA45tHwWMloCkVOfxP5txczdCFpw3C5uW5pfMI6X81jeaboYA8zW7dmqjTHIAxGtPWjc
	DUXhf0eVZ2PKytMYHtzWXyl6rJTrHApYt8luQgWcoQ0ggZP4JsRyg6EkHZoPUeNbJhOB+YFD10tQ3
	hGwJ11Pi5tI85c7KnmpNWCkJtMx3IJ1d1VIbW9o9fYdox6DxCBix6rglzEnTaIskYW88oDfAfiBlA
	zOn/bHVb6f/Bx8zkFmcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llorz-00CQeQ-BA; Wed, 26 May 2021 08:26:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llorw-00CQck-Dt
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMgndj0zBkXWndvoMPdHnzhaYtOQq07fjFQGw13rugA=;
 b=c/q+O5C3Kqr9AIa3CBYjL7o5nleHaSZPx86dRWtHFHrbf8viczD0MFPSrCwpcMk9L2ENKw
 79AcfPE3LvBxtKFSNKR2KV3u5wpl2gqstFFuOJfplWN38tZ4XdvNH5CuTrzpxB3/l8BU/H
 eD6t+m3VBC9FhQoN9fLC7woJwy6kKqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-bbw9ipCiP3eA6sdffDQo9Q-1; Wed, 26 May 2021 04:26:20 -0400
X-MC-Unique: bbw9ipCiP3eA6sdffDQo9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239826D24A;
 Wed, 26 May 2021 08:26:19 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5344660875;
 Wed, 26 May 2021 08:26:10 +0000 (UTC)
Date: Wed, 26 May 2021 16:26:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv3 3/4] block: return errors from blk_execute_rq()
Message-ID: <YK4GHgL7h4B+QhNl@T590>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-4-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_012624_579730_EDCD1ABA 
X-CRM114-Status: GOOD (  10.93  )
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

On Fri, May 21, 2021 at 01:21:44PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the blk_status_t
> result of the request.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3:
> 
>   Return blk_status_t instead of errno.
> 
>   Removed "extern" header declaration, and named the parameters.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

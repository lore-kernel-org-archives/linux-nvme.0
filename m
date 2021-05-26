Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD276C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:17:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B015610A5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B015610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l1vPnKjdXCjMaaOCigSgtwHOR1LEeOdDMV9IphK9fTw=; b=Wyhy3OHJqeZn6J
	lkneQ0rdx1LOvLawrhFpmgu69BfzN8stli4CmksJ+83v9tiFnuOGsoVGH52I6asSiyir2xCt2UQOm
	d4cYB4ZiRQS1s5/0E73qIwgjS6hKREaYT7FYbT2ME/1Y2lt5sm+HyJgcYJSwwk873+XxhO8mNI6ON
	UIRBiSHXK41LVA7BAm1idKUmBRr5XI0l1j86yI6t8VnSH5wBXXtc7tlokiAeZKM4GWb5d7BG1CeyR
	u2XMo8DBcKvzongEuYBUg1suxUxiG74DbnG9td2cEvI56Y+ecaOgRXoLDYos7ZtIDXpR271yggVyp
	oRHJWazCotcNYO+i940g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lloj5-00CNRC-Fb; Wed, 26 May 2021 08:17:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lloj2-00CNPa-Ut
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GPzbOUdLDB1kxTXxDyLQuPw6KP2rbbpd7VzwwvU6XsA=;
 b=RxGfT8z6vXzzlF1JAAWmcd440Lp7CzVZBXTPBAip8ZxsEnN2ZUDtcexx0Iq+H+aYLpugVs
 kXBHYQ8VQWE7M2E1oNxQnt28MDITgWJr+LCs3J21hGw6rBB9xd2jA92yTGlGHziNw+NGQ4
 9zASs4hSWOL44NaQMxDMUxJC5+owCEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-va0V2lwMN6OiCBFS1C2ZIg-1; Wed, 26 May 2021 04:17:06 -0400
X-MC-Unique: va0V2lwMN6OiCBFS1C2ZIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 352A91009446;
 Wed, 26 May 2021 08:17:05 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 550641001281;
 Wed, 26 May 2021 08:16:56 +0000 (UTC)
Date: Wed, 26 May 2021 16:16:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv3 1/4] block: support polling through blk_execute_rq
Message-ID: <YK4D9HZjBtg5AK/2@T590>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-2-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_011713_090162_B7FC7E57 
X-CRM114-Status: UNSURE (   9.67  )
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

On Fri, May 21, 2021 at 01:21:42PM -0700, Keith Busch wrote:
> Poll for completions if the request's hctx is a polling type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Moved blk_execute_rq's poll handling into a small helper function

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

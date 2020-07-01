Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B9C433E1
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:26:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583142082F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NV0wVr1L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9NmtUM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g6MXGMoDIBW2853XKwCoodKPAzeFxkNE/QrODHrEZes=; b=NV0wVr1LvlK/JDSETvnMPxX81
	tCOi21hHf3e620kNzFimqEfM2n4aGuSI+kwFdhSUQCgu/hrqocWO+7rBEHgtMwgE+Zf4ypi2MuHg1
	LYltxMpgOkZiEB5IRNDDIbli2uDjfC0UydOQESn/oQZfGiQr792urlCD4Hbpt71GxKzzesWE0oRKh
	pSdoHueX/RzHX/IHVxQTxnOGYI2PFodq196bADLG7F1PwtGW99Ug8Sgrqm8GoHLoC8YaFkfAQhXTV
	lXuiP8NxxlF8NT4/6KzZtgkjc22BHVatYlJuFi+EDF5IcLUYeN0j5/r2/6v+MZwIjHhF4mc5r2hDj
	V7MbbLHEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhR4-0006yR-Fp; Wed, 01 Jul 2020 18:26:18 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhR2-0006y8-Rx
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:26:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593627976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gM4o34lY2Q2Fu9DNpo9nmnqeENsycpsv4CwD0QpSKRo=;
 b=G9NmtUM1pMLYG4HnVxISZwKWcokRDOlFvJZ+5mLWYwAIBgrhOvQ9Jg0JmqkMj4GlaywWXM
 sryuHmqIk7+dC8HoIXLKjOZ9iDCcTw9g09TVaTWHja4pGzn034zZSoMoRGpInDKf29oahb
 r4HKvio3qSFSfTqRE6keQ9Uha/ndE8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-ve54S7gINvapvHMQrfW7sQ-1; Wed, 01 Jul 2020 14:26:14 -0400
X-MC-Unique: ve54S7gINvapvHMQrfW7sQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE0A80183C;
 Wed,  1 Jul 2020 18:26:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 244BF5C1D3;
 Wed,  1 Jul 2020 18:26:08 +0000 (UTC)
Date: Wed, 1 Jul 2020 13:24:48 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/20] dm: stop using ->queuedata
Message-ID: <20200701172448.GA27528@redhat.com>
References: <20200701085947.3354405-1-hch@lst.de>
 <20200701085947.3354405-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701085947.3354405-11-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_142616_932250_31377023 
X-CRM114-Status: UNSURE (   9.90  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-s390@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-nvdimm@lists.01.org, dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 01 2020 at  4:59am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Instead of setting up the queuedata as well just use one private data
> field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

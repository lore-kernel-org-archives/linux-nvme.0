Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F64C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 12:21:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3165261466
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 12:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3165261466
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U5xcNPGbIYrWjog+/WWPm5FSNNOBnBCepGgbuh7AHl4=; b=Lt64ORDJVLS21S
	UApYHzbKxvms2agrJgPCsgPGOyh0RjGq2hN9I1LoUaNuoRrxilEW5DBRz3YshaPx1p3uPZo+b/A7N
	4GzRbhn5Nat5dBz1m6ChrqfjWbJTE6zkia1nTo0jK1j2XqYsoaORzi6DMyb78ZfUMg26RuJNFn1N/
	bLPoN4aDcvNjkLfzHx+3G5OLYCvHbkfBHmoDPHDShL6WIq3xncz31GYbJLz8JFVi7qZtk2aT+7Q0V
	ZFZjwYKgzDKYQTIROb2oCcFs1P2ux5g6jldrGfTlsShtlWaN756ZFQMSGM8xdeu4/SG2OcQpP/0b0
	rVrPkKPI1S8j7XQjTkNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0k4t-00BjOx-IY; Tue, 06 Jul 2021 12:21:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0k4p-00BjNn-Ku
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 12:21:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E9B9C2268E;
 Tue,  6 Jul 2021 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625574081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aan1cXxL9cGbh1ZIWdDquBEBFJ6tOJ0dEGiZCExfdPk=;
 b=Gzk09SPy9r7nBaOoFRzQ1o4vTDZ7iPcOFQ1ohOQjGNbvSWq/jgngkFMSbN6mToryBZ3lWF
 u6VMkY331ZVy601UsysUGXESBNLZSYcR1Jfh5SGLNamu45LpLq7CWTG0yNbDuRhauWBDC8
 7uXVf43sir8hoYJZVj5WGNpTyaz2mgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625574081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aan1cXxL9cGbh1ZIWdDquBEBFJ6tOJ0dEGiZCExfdPk=;
 b=1jMACZT9F8Q3ycI2hz/rH/kIDTg2mcyNSDY5Ea2v++3lCNDte3a2PSHA4pH+9/1Bg06/gy
 Ny643wCDws67o3Cw==
Received: from localhost (unknown [10.163.25.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CAEE4A3EF0;
 Tue,  6 Jul 2021 12:21:21 +0000 (UTC)
Date: Tue, 6 Jul 2021 14:21:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210706122121.qicyihexk2qawvef@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
 <YOQYKn+POVR2g/h1@T590>
 <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_052124_584049_B3A25D17 
X-CRM114-Status: UNSURE (   8.99  )
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

A nvme_start_freeze() before nvme_wait_freeze() fixes the hangers. It is this
simple?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

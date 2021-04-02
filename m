Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A9C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 01:49:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D6260FD9
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 01:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D6260FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eoe6+jG2c1zz/HBwpH/k53Vhmjvvj8emW3+FOmuXegI=; b=UB2+/Kovj7CWfZio38niGTZM8
	4y0aEkZe8YmqhYQtZ9mfxEKt9Z3XwalNXW+8l+qez7Uy7YKPKyGY6QWIfbXHyhEJvktzPaRwn3X//
	L+rqLRf0NxImq8fSzkOMi8CNwjTuJ1667LAD8gT7VMdV77LCy4fEwdi5b7OsITt5cWYI4l/5kMyH8
	fUhHyIQfWraBSR8FmTvsmNOckcoOT5Y82ufH/6jd+L6mL6pTpdWbaQM6/0VxhGaPuaGORHIG8y3eE
	K1i8dUIoqQ7x8YAr4EsJNK5vkKXhUC3XqDOaIGa8Om5qDWgfoHeXLxxyEZxhK5qRm9drLKaxCpaEZ
	0aFZECojg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS8wO-00Bfyg-RG; Fri, 02 Apr 2021 01:49:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS8wA-00BfuG-Oi
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 01:49:32 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B41DF60FD9;
 Fri,  2 Apr 2021 01:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617328163;
 bh=GJQv+WaDJSF8GJvlXea3UcVapj1PmAKCiYJolfmxN7c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qAV9Bja0ZJ4NfkjZOV1Wsk2ZLrfQ9dJkXwIvKm9aVRmv3jNveobEXGAtg3VNWQUGu
 69rDgkfDfX+L5iBPjO0/ktAJ2VL9hoed+gPXcQTVzqWrklRHAyAHJ0pp64mbJJXpWD
 oSp8kqolxln9SCrHfYSwXjg04MZt9odRiWG1i7PtJvvuiwQ4SH+i2qIhq740Vecvfz
 KTFYh6z6L5Q7lGyKKqB//GpIPwyIFQlNBMBps9LXYpf28KQxYZ+LyL/E9QrZvtQ283
 z6iuGmXs4Vjv3Lb9dRCzvMM3kEZeFWR+bwX+OGPUyHv+ANOAeOarqlCq13f7TgHnpj
 W/S9Y+K21bn8g==
Date: Fri, 2 Apr 2021 10:49:16 +0900
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: Fix handling of large MDTS values
Message-ID: <20210402014916.GA3277@redsun51.ssa.fujisawa.hgst.com>
References: <20210402013907.10131-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210402013907.10131-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_024927_107113_23B50B26 
X-CRM114-Status: UNSURE (   6.49  )
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

On Thu, Apr 01, 2021 at 06:39:07PM -0700, Bart Van Assche wrote:
> Instead of triggering an integer overflow and undefined behavior if MDTS is
> large, set max_hw_sectors to UINT_MAX.

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21FC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 23:13:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F6D61245
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 23:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6D61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tkuSiXzTWUpzmxcWmPW7OR4fZ5cgKXirdMyluRLiL9E=; b=iNvzwOYsRsK6wuwlJmUykbFpn7
	O3WLSvyP1tAr7o2eohRnJWj7mO8q5ss9IainRMXB08CNJ5up7bhv82ZrPOzOoxs0doNunXb/9qmz5
	GafRAvoXdtcxn5aK3UrcHa28aJpgxEtORg9Sf58qw5FfjRtyNhEkqlq7IJ58aXHxahUijpoy0RWku
	1O97SzU1WuOPfGconJct1V9n5SOlesohYBOej5Wk2PYP+aaP/nyhbrYO6H/Aya5gVVn3xjn6hfqi0
	mBWhUkV+nfboWZzmKgYmhm9kE0uDGLpoKo9nPewtHNUgucpz9UzXL+VXq5TNpn5L5RtUK5oAfeTkg
	G+0Js/wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltIEk-003nGQ-Ch; Tue, 15 Jun 2021 23:12:50 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltHdA-003aig-1f
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 22:34:01 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 k22-20020a17090aef16b0290163512accedso2573143pjz.0
 for <linux-nvme@lists.infradead.org>; Tue, 15 Jun 2021 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=ZjYvd5oV6ZirLRDoS4iZSLQ6JWghSOge3IHQJEmNz+U=;
 b=fe3Ac0AD/O35m9Bn6qTy7LcZM9igRqoM89vlL0E119q7I7pP6vw63OoaGMvXnzl996
 A1urlEFW2AC+kLDewk/SuzO6fP01gqOhHFG5iIEbhOzMLL6fLVmzC1CVt2hidsenptZI
 1w9KJU5Hfgopo5oaP+lh9ZJhAS3Yfg0mGejL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ZjYvd5oV6ZirLRDoS4iZSLQ6JWghSOge3IHQJEmNz+U=;
 b=d9+4x5UBw5JYDd0AZ9suBTf/ZmtqO8KJMqoJZ4osXFHaVPbnZBv1v6xAV0b4aQzDk8
 G6Hj/GmHLEfeX010yPqXdLeTW/B2vHTMkZEAum5EG6961OF5zwFzCyni9BNE6O9Rfp6c
 cRXIbk0c1kbjLsZZvtGh0l7KrByUfM3HSlJK36EpyhKbMnXhXK35/r0je3KBp0g6quCC
 bny1+N9/6RW2sD49H6Vtj5vdFzOE7mU1VzlU15vyGAxUOMZuWDNs5PPnVDhu5/ogpIzm
 JGaVLd6C2g2dOfwwYePBeGtPCIOtHmn8BIuhHI7H+TfKlmSi406rVVe3mVLsiqT26bYY
 MKJg==
X-Gm-Message-State: AOAM530uczZrWzN6PF9hLkUj0XwV27s67H1BrllaLtBQYQn17A/z14Dk
 6g2zsyXCOtnC1eQlSta69ptIRoa9FiUdDYD8ORMx7Q==
X-Google-Smtp-Source: ABdhPJxrsF2vCvph+Wm0rR4dmEaetzZ6KhN+CoPChfcWA5hiXvGoSR9eh9A4BjmAcEBc32YyWhzARiTlN3MQ86Coc6o=
X-Received: by 2002:a17:903:304e:b029:11d:41c:fa73 with SMTP id
 u14-20020a170903304eb029011d041cfa73mr5648828pla.82.1623796438635; Tue, 15
 Jun 2021 15:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALCePG0up2GK_ihFnLxHuUS4Zn0kfSAC2x1U4Vm_6BQw3Deo5w@mail.gmail.com>
 <YMjX2qpSQCjVkToL@infradead.org>
In-Reply-To: <YMjX2qpSQCjVkToL@infradead.org>
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 15 Jun 2021 15:33:48 -0700
Message-ID: <CALCePG3BAbCJo2EDhv_w7kjJpcYUrO4=WAwb4tA-EtUKhBJhgg@mail.gmail.com>
Subject: Re: nvme-pci: Fix multiple races in nvme_setup_io_queues()
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_153400_287506_C7282219 
X-CRM114-Status: GOOD (  11.40  )
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

Sorry for the previous bad emails I have sent.

Please discuss and comment on the latest email I sent using git
send-email at 2:58 PM PDT.
There were two emails: one is a summary with subject 'Review Request:
nvme-pci: Fix multiple races in nvme_setup_io_queues()'
The other is patch with subject '[PATCH] nvme-pci: Fix multiple races
in nvme_setup_io_queues()'

I am waiting for more comments and then resolve them together. Thanks!


On Tue, Jun 15, 2021 at 9:40 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> The patch is so wrapped that it not only doesn't apply, but that I also
> have a hard time reading it.  Can you resend it using git-send-email?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E66C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:32:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0453964F5E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0453964F5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2y8AcXU6YHxj0+TG/O5krSiEVJt15wYy1yLwlMj0rWA=; b=F+8eD6UpJCcvNbQzU0oJnpKA3
	9fE4GNHQ5DVwJEzSx22OsUQtQ03H43G/o84dcBPTSPS+vnNYMv7gWMZkTiTYIFQScRgKWjGKlBHob
	0l+fORdTbQ36RFPVECtXj/LIENY2YYx1A2V3Nlf8f5Qghhoj3S8DODDkOTRk8zpN3GSe9JEaAHjPF
	j3IKb1KS28ViaRAMnNgxZ8OpXZVC36yC6e7OPXufMK4jsfe+bWnvu9RpYMepZqggV3VKtDEHiRucM
	AdmrwysAyhAFqp2gyHkPQnB2UeBAvygHtxAbzfbf8aZXGhXU2QNSMe8Q9OdIhYrh9eQB1iTkOo6Wo
	IiPq2ifqw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKoQr-00CLV7-2U; Fri, 12 Mar 2021 20:31:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKoHD-00CL0s-AM
 for linux-nvme@desiato.infradead.org; Fri, 12 Mar 2021 20:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=otb3LF22QrkNLfbh/hj/fFQ0SOolTYszqEC35Z7P/14=; b=fEpH/IO614HbIv25u3JDbKcAea
 0g+xEf5eWo2v2YQ1pCZ4nvjxUF3GY1yx7sraBUp7sx2g/YauOLi5iZgeOSnf+s6qYU2jeW+ARXsgN
 VFX5T3wOj2gSkbaZ+zKAkP7ItfmY3YrLb3OmmUS1/Y4J8x36+Q9WTvxSF7OKyjGo4NfiVphahphvp
 KI+iU8K8aw69F2cQMZTHrA/kSwUOlx0KBRF72RtGSXqkEOI36AYoNryOVxkuXUa2SJ7UM8RUgOXS1
 66C+RFiJMOcvKsIG4ZRWZe5Hn2fEv7LCsLAlMkM3Pd9DCb5I/9OM35P6qS6LbkKz/06VfLnPl1rnz
 aHLJewlA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lKoGv-00Bf0q-FS; Fri, 12 Mar 2021 20:20:36 +0000
Date: Fri, 12 Mar 2021 20:20:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 5.12
Message-ID: <20210312202033.GA2778279@infradead.org>
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
 <20210312195932.GA2766489@infradead.org>
 <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Fri, Mar 12, 2021 at 01:01:18PM -0700, Jens Axboe wrote:
> On 3/12/21 12:59 PM, Christoph Hellwig wrote:
> > On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
> >> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
> >>> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
> >>>
> >>>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
> >>
> >> Pulled, thanks.
> > 
> > I just sent you another one liner fixup on top of this directly.
> 
> Where? I didn't receive any.

"[PATCH] nvme: fix the nsid value to print in nvme_validate_or_alloc_ns"

I just noticed it went into your facebook address as I copied and pasted
from MAINTAINERS..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

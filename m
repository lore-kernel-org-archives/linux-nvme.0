Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058CCC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA2960200
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA2960200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mSJFOoSDS1Ox9fyAGx2lGa+ake4OpiPlSCP0IPW5ZA4=; b=lqeRGZCZo+cQP7
	7DBtD6hWpdHFxKnobJ6bIxs6zgzgsHT2QV1AzESIu4Sj/uKcdGDSH0ds055iKJGtprVcUIQlsYIun
	bTg7xuH6/QjuS/O7K+jlGowuakuflIX57qgvxdAOqPRGP+3y2Co2/epzcsBqjnWs2lEepp75EREdC
	qq0l7ykRJnlPzoen+DWmGRY7D0h+AQA9N/wcJE5TXdZdZMcSX2G5gR1VBDTCF0CK6i2M6rAWdRHIY
	cXsBZLDAztSeog7MEX6z/S7Ru5ajG0cEHDfTblp7fKvPQpXRrSqJ2RqlZPOPsJ4zPWbMVQ14oUErg
	eoZOEMaXND7PuHpt9B/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Le2-008Xwj-UK; Mon, 05 Jul 2021 10:16:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Ldx-008Xvk-Kh
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 10:16:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C7A9968B05; Mon,  5 Jul 2021 12:15:54 +0200 (CEST)
Date: Mon, 5 Jul 2021 12:15:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: shiva.linuxworks@gmail.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210705101554.GA12803@lst.de>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705101157.1009135-1-sshivamurthy@micron.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_031601_870774_E87B8012 
X-CRM114-Status: GOOD (  10.62  )
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

On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com wrote:
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Enabling the abrupt shutdown support. In this shutdown type host does
> not need to send Delete I/O Submission Queue and Delete I/O Completion
> queue commands to the device.

Why?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1ABC49ED7
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 01:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21DF20678
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 01:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BBo3kFoT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcfC/ry/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21DF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4t7STfbAKo/W4rDtRrmakFBQPwI8o6A3wG76jT2kY1I=; b=BBo3kFoT772DWN
	XGFJCyEB+gT3KN173KfvznS8KioGS7CpUGO2ECiGNVxe5eqoqWSEUmB3+nnBPNbEW+NgSxBchCZqB
	+W6BvXDdSdom72utvRfxxHrUP4HpBMInrzNbuUjTq1uXvQhHm0ICHPpJK+XTTtLoD15xzoAcEIdyH
	LEeRCf5+7VhKkuIUkGN/cOoFwPHJv4T4/ZPLcu+ZXV45gLPew3uFHHnNu/NnzDBT8QJmt0lm91YZu
	n2Frmrf+F+iS+QBIwabJWprgMgFnAFdJRNONwzK8li4ZuwXPvoMebHg6xJOlNtHF8ZmQM+Z61Kae0
	JKvgPeExR/WHtqthBz0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iA24v-0007wl-Fx; Tue, 17 Sep 2019 01:14:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA24s-0007wJ-ES
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 01:14:47 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A08D520678;
 Tue, 17 Sep 2019 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568682882;
 bh=9W8L/XQu4xeDhUsfMrZKB5pgdmpfN4Cjql4l+af2epc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gcfC/ry/sHi/fzFQF94M3MoR2mmJPquSlvdhRB0a+N6uueSVpaN+pVzbgtri6+nsE
 knSuBj0DnSNYm9PI/LDTXcTCpcq4Tt0VioL4HVU2Kkk/eImWds/nuFBejJFD9PpiFT
 0rIQE7myxvdQgocsWLjmPAO1mwXhPSSyZp2LDNU0=
Date: Mon, 16 Sep 2019 19:14:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Singh, Balbir" <sblbir@amazon.com>
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
Message-ID: <20190917011441.GA31163@C02WT3WMHTD6>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com>
 <20190916074153.GA25606@lst.de>
 <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
 <20190916160117.GB1455@lst.de>
 <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_181446_530734_82FBC934 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "sblbir@amzn.com" <sblbir@amzn.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 16, 2019 at 09:04:31PM +0000, Singh, Balbir wrote:
> I wonder if I should just call it debug_wait_ready_timeout and in the
> comments about the help/description call out that this is a debug
> feature.
> 
> What do you suggest?

I recommend going to the vendors that report incorrect timeout values, and
apparently broken controllers that can't initialize, to have them fix
both. If it doesn't initialize in 128 seconds, your only debugging
recourse is to report to the vendor anyway; overriding the timeout to
something under what the device reports it requires doesn't exactly
provide you any additional debugging information.

If you really need the driver to do spec non-compliant behavior, we have
quirks for that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD9C12002
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 15:10:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC7161221
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC7161221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EvCK7bATtFIo6DadFUI7eHSTFuEUM4szZq5lyyS7q94=; b=SPi3VBkPLpR9hk
	4NKMjYol6kTcyh7U9VIhJAwR+a2Znx4fqPMF/EN13mFydfJWUBQfPiizksxdhG8f/f888BqGVxRe5
	7JrRB9UIMxOUo3lSPE9fU9+Kcsck1MR2B1T00LvDDK7/3Vbal/qqiRllrIk8J/++46e7OOBKRbcH3
	jfimMvoI3elM6VVITjL7hpeX8Vp1PyfhlLG8yjPsnRqtZozri2EnQqXDbjGeK0ISqpM9qTObfKZfj
	A5ggoVx+uQ3E+1QrHmlzXsjsH/aytwyzM5ddvGtCeYC2rZ1cBANtqvVtJb9MrKelB/9Mj815XBNkH
	F9orrDafQTB0QWQuKA1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Drp-00GCwP-Cn; Wed, 21 Jul 2021 15:10:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6D9V-00Fx9p-1J
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 14:24:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48F59610F7;
 Wed, 21 Jul 2021 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626877488;
 bh=K5ZELAgE4GHMednfkhkic1X1sTel+a26JH+ZXie1DXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vI27lsnzjcuvKVvP6OmFrarliAhMzQ4pjbJdV74thjHSIaOTCC+4s18NjEoF3+Lsb
 Zv18I9+XhI/Gqd8X7xTHuhTP2MT9xMBEZYQaRB2kL/hhKf+bmKP3x8hyW2xkRG+F8e
 XrWb76ahssY14cnsq9igGYu8XMQRvlCL5kLAjBYS0fNAoJyVD7SGK8z8YTcrKyYLY/
 s3ICcbS61/NUxPDwHFHKDLfRtniUE2dK1YxqQakaSjLReKnuslF3XPUxiaIxwGZM8S
 JxO4qJ7ZigYGBsMMl12T+Vk7XXsFDu/QQr92kPRQ0CLTrhbwHjv/aHzajLtVT6Bgnw
 URrHZw0jQjLLQ==
Date: Wed, 21 Jul 2021 07:24:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
 keith.busch@wdc.com, sagi@grimberg.me
Subject: Re: [PATCH] nvme: set the PRACT bit when using Write Zeroes with T10
 PI
Message-ID: <20210721142446.GD2005888@dhcp-10-100-145-180.wdc.com>
References: <20210721080556.600892-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721080556.600892-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_072449_151788_BC318AA6 
X-CRM114-Status: UNSURE (   9.45  )
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

On Wed, Jul 21, 2021 at 10:05:56AM +0200, Christoph Hellwig wrote:
> When using Write Zeroes on a namespace that has protection
> information enabled they behavior without the PRACT bit
> counter-intuitive and will generally lead to validation failures
> when reading the written blocks.  Fix this by always setting the
> PRACT bit that generates matching PI data on the fly.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

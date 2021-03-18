Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0235C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 04:41:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530A664F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 04:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530A664F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/rxW8oc6RBpUO6lpG70oHkIJC92L++lK3qEGfzoJClc=; b=hGK6DYaQ784jRQCYmariKljEs
	s6P9jK/cnqJy+A2GN/zmd5PEg5tw97Eev0Tc4ew4KkO/nPsfCTqMarPbDAmlEbOwWC5mtTTffza6Y
	PmN2/BkkoItSJbj6kdCAyx6N4oSPw+E1OftITanMt9Rn5XT7RSZ20+O7M2Y6gumqzVinZ72BkPlat
	CHbHY5kXxXUcTM3j4d3f7cs2QuMrOpQT3AvS9TJGoJS+PN7FEJdJ82KHc57+wQL7or97htDNA8NFd
	j68A3QDIxpLQsAfMyzFbcQle22R8cgW4bqFPVL/aMXJ6UsOfao46gOSzCsXAt7yVQZpBna8rQljLP
	iKRpkpXiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMkT6-004QMi-Ud; Thu, 18 Mar 2021 04:41:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMkSU-004QDy-Ll
 for linux-nvme@desiato.infradead.org; Thu, 18 Mar 2021 04:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mj8eBj+VT4BL6egNSJRqQr4Kz1rqAxuIWsFt0M1Ifrk=; b=r6LPHkAClaG+RvjaPpAJD2/wtJ
 G/XGe/YRASkUHTX7RggQNxBYWPC1SPfCaVdS6jOVRIQnT84o2q2VOqBGyTr0nVVRdpF7bq3RAkjsn
 eWT8KKyz8A2PMAxcjxVyELfSTMS5ac8ZauC1elYqeyoDDZGWzpQ/G67zoNYInRy9ZYYEvM+xiMnl5
 5ayJ2SS1OdwqQLSjAJRrVrcyQ+3+Wrt+UUpvBn/y7KSZW4UW/VolsYp9SmjhgzJyjQQ+mvRw43Ku4
 3nVsk+FFAzbq7c71BeMB+am0Fa745azYzKNZCMPg9rqcXwezTv4Sj/Qw+Rt0XQE42g2GG1/i4Xe8i
 WdXEnwcg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lMkRv-002Y2V-N1; Thu, 18 Mar 2021 04:40:03 +0000
Date: Thu, 18 Mar 2021 04:39:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: elad.grupi@dell.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix kmap leak when data digest in use
Message-ID: <20210318043955.GA607481@infradead.org>
References: <20210316154425.16434-1-elad.grupi@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316154425.16434-1-elad.grupi@dell.com>
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

Thanks,

applied to nvme-5.12.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

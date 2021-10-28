Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38259C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:34:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B3560F70
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06B3560F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=StzVdKGodmqbJDIBUR9DWwgevNhH96RBF+XBEeSZ+Sc=; b=EjpVBmeT8SAu3QMxEfx9KWthJe
	iz5XPXK+L+ge0JwV7HLJqRnmdNAb+bO5epYgCvbxTfQhG+4UJn/zvNrF6YpyrBSVJLj0lrlqzHrVn
	S4Wa5yV1pbFWoZrSzzANLMdt6Usb8S9tq81R+ucK2UIUzvpnHYgbthC91/AP00pTPHOXSXXrMibN4
	AdFzJkpJBhsfF5pYiErvAZyikGOl/1udZMTEsf4+z1qxFJ+uTSErzKgDT04tS5qkSLbkecIBz0fSF
	qa5FbyayMhwEAAKrRM6BMjRNdJaqIWbwNlcoONXflfcVXD0wxUI0IyKOFeIDTpHoU1apWhD3gLIty
	vMeJ3XZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg6UR-008C98-9b; Thu, 28 Oct 2021 14:34:47 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg6UN-008C6b-Qr
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 14:34:45 +0000
Received: by mail-io1-xd2d.google.com with SMTP id r194so8375221iod.7
 for <linux-nvme@lists.infradead.org>; Thu, 28 Oct 2021 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=StzVdKGodmqbJDIBUR9DWwgevNhH96RBF+XBEeSZ+Sc=;
 b=3RsmBvVPdTBjYaF+2TyhLfAVi99JBUcFXoqh52NzCZE0+LzxkN+oglT3A++0MeDz9Z
 Wj2QIBdmUIrh2DOmyEEw4jUmP70Oop6a1A2suFabE+V9NNuPWEMYZ6ZVegvBspGmRQgt
 PZ9ZQ/GL1+tIr9Yn68q4QNJ+rLCsFU9zgArB3SPyzLrc3+iKbxBRLpR+ckt0PNWwZyEH
 UibLIHuRNTMK68sU0xGy0c8EBhTKRG4G2fQbcagqAfXMPsZpO9ScFntcSoz+iIDGfo1u
 GSed7G/kjt2wg6on6xCeSTnLf55QVhMCnhej3DxIyFSNqzH9ZssK4B2VeDiNa2uEjVXK
 puOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=StzVdKGodmqbJDIBUR9DWwgevNhH96RBF+XBEeSZ+Sc=;
 b=4/wsIxqfR0Zc4G6v0uqoglgw6SoqNuOuRwfgHZU5oBTPyuWVoL5FvUo8jnjLyFzgsI
 k+lLAhEqllE2vdcn9/REfePTh5GSAvWeiFqCXDOJh5PCsIEtMhJ/+LFnnwOYQz8XM+i/
 6Fj++bNmrT6j7J276cWcYaMcqyqePtuybK6xMJKpW4FAb3lXJE40xPC0bPSIRShVh1GL
 Vc9aBScwTHIOlLSDo9isr5oZF2RsQa88TkstLPOt08dRrta487Y2L1/2oNuDTBB9OXtP
 KVyCdl4feFC4rj21Tc43Nv8/sjnyOdIsdbyhoQRFMk91/3WvtIfysbHOFrBqTdjUSMvp
 p52Q==
X-Gm-Message-State: AOAM532VmJyr5w6YuWp91L12AREDkVfN1jYFGfQFvUZMbAxeR8D9qL+l
 NJ9jEdftSx5pByUsM01Hb+Khir9UD96sOA==
X-Google-Smtp-Source: ABdhPJypv9niIA/4OLY+bTE84uanziUPjfRe2C4Q0c12WIcsYwYvgYh1C80AtEYMNh+2DRR4SSDl2w==
X-Received: by 2002:a05:6602:1487:: with SMTP id
 a7mr3396502iow.203.1635431680546; 
 Thu, 28 Oct 2021 07:34:40 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id y5sm1751855ilv.5.2021.10.28.07.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Oct 2021 07:34:40 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YXqyyRRUV4GJis4I@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cf58cc3d-a919-df7a-86e3-3b183fc4ff58@kernel.dk>
Date: Thu, 28 Oct 2021 08:34:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXqyyRRUV4GJis4I@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_073443_894971_9D48516E 
X-CRM114-Status: GOOD (  10.93  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/28/21 8:25 AM, Christoph Hellwig wrote:
> The following changes since commit 9fbfabfda25d8774c5a08634fdd2da000a924890:
> 
>   block: fix incorrect references to disk objects (2021-10-18 11:20:38 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-28

Pulled, thanks.

-- 
Jens Axboe



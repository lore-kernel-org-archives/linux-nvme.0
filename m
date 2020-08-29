Return-Path: <SRS0=h+kd=CH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D8C433E2
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 16:47:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F0E2098B
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 16:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XfOJrcTq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m+jv6bJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F0E2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zAHRtZ10uBB1XSLfvo+tLDdHtthKLwaFgGz0SmjUwuA=; b=XfOJrcTq00viBHWDfDISGGiYq
	8kiM3xXufl1dJ8rr+V0/5YEdU2EYr+TdHFJ8RIfxtgx4MUUKUfQurU3cWYHvzPv+ZWI4oi0tEWPPP
	adVmB332AXlv69SGPSGoCld/ptGuaZiubmFsNXN2/t+3vklpWzTUeVAsaNKs0BGKqbM5tftpyl9Za
	AC4Ma6xSqWNuWqT5YlJsMR0fVEpTQRxm8fpCssDuvfwQiEnuk0GPmTljZqGiVKsZn1K91uG8SY+hT
	yZABDllTeKGMdExcpLIFUHNq2PhoBplJmtTuvCZdfzg7KlnT0s/0dUMzLgvJGbFuL/GVJKpMHYqEw
	JWuLrDBkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kC40g-0007iM-Dd; Sat, 29 Aug 2020 16:47:22 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kC40b-0007hr-N9
 for linux-nvme@lists.infradead.org; Sat, 29 Aug 2020 16:47:19 +0000
Received: by mail-pj1-x102e.google.com with SMTP id mt12so969929pjb.4
 for <linux-nvme@lists.infradead.org>; Sat, 29 Aug 2020 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Rt5+Gjo0UGdPCISf5CydG1I/Z+wq56+kU1eC124qs0=;
 b=m+jv6bJZRhsllEVJr5l4EY9W/YKC3BAZMM01kcSyMJjFYDecSRzG/FmZTuCJs/t2ny
 OTZ9rLbXL2RR9XafeWT8qZMVX3EveS6Y24+PU4GHbshyYp9ee+dMK+C0YDAdbf9aKVfG
 jFqCByaqPcul+XLJJeoNuBseGgzPL/FnONYDc4Cu2YlXVbpi+Vb87s5ho1nAAniIHKh2
 KXR7ViPjwNUAJWYxoNcQWgVEZejYo15uNzb3F2nN2WGlqbFQbig7tdJIWt883ZSPHmjM
 5IySceO5HRVeWhmNoEcv3uAu5gm6m3KKHdwRHSbGF0wVoZVgzPve+VtbuXjvG8XJZ7Uy
 as5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Rt5+Gjo0UGdPCISf5CydG1I/Z+wq56+kU1eC124qs0=;
 b=cWYllHqGzm64OOoEu0nUXMZ3y0/vQXpGhlv1SOVrMgN+N9ovN6QwzVAOCbHxuey8gO
 yIWVDDY5p73xlnoPYdXmFBEJ513FgQd12PWL0CRi2m6I4s+kBR9NVekg6eLAQ5pqez8i
 GAHKaZQyvpqVbeWk5o1x3hVV7ZtPVgj0IGTAk5SjABSwxzlWfprGepP5n8Tme/WPwxXs
 xMlFnger96oaaFysIAjQyOA26GGHHzEvcSY98VlvQOfjL8K8GDI/4kagHqW4OR2213Tx
 QR05dixibH+OEL/9Pi5FAJA6QADvImljzKwIc2CfPGjhEkm2TX8c6dVm+ddNNBIASEl7
 xqyw==
X-Gm-Message-State: AOAM5300DDlHT1oFRKfuJAdMHI+4ymOZX/Noi8a/1U1Xc/nAIk+nUCR6
 o26Hu7nUifdNuLoOflNVZBDGhIRrRZNXqnR1
X-Google-Smtp-Source: ABdhPJwh/IaT8sjJze0JR0UOlWwMhEHIvT0ikyEXE/ycXPb0JRTnRL4uDSst200BKNS1envrwdz+3g==
X-Received: by 2002:a17:90a:c917:: with SMTP id
 v23mr3622499pjt.97.1598719634004; 
 Sat, 29 Aug 2020 09:47:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id w82sm3114901pfc.183.2020.08.29.09.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 09:47:13 -0700 (PDT)
Subject: Re: fix block device size update serialization v2
To: Christoph Hellwig <hch@lst.de>
References: <20200823091043.2600261-1-hch@lst.de>
 <20200827074758.GA8009@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b1960016-c265-1e1d-cfd7-de2330bc5eac@kernel.dk>
Date: Sat, 29 Aug 2020 10:47:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827074758.GA8009@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200829_124717_862945_9B924115 
X-CRM114-Status: GOOD (  14.97  )
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
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
 Justin Sanders <justin@coraid.com>, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Haberland <sth@linux.ibm.com>, nbd@other.debian.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/27/20 1:47 AM, Christoph Hellwig wrote:
> Jens, can you consider this for 5.9?  It reliably fixes the reported
> hangs with nvme hotremoval that we've had for a few releases.

I've queued this up for 5.10. I think it's too late for 5.9 at this
point, and it's not a regression in this release.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

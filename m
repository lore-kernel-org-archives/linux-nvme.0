Return-Path: <SRS0=Oz+k=7S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B8C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 03:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9775A20772
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 03:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HTN9Djt9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nwwZGmKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9775A20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=afc0l8mKlR+fLuPS+QCgDTaPvWk3f63PmaGdrzgkQL0=; b=HTN9Djt9wmR9n3
	wa7BIxEu9O/EUBplE6+2iuu6A6qDWUKKR3P1MJfZXKQTxSMDD7w7921RuzTv+aB0lEQW/0srYi93t
	smAcGCThRA5n4A/6g1B9avJi5ZkSDf3GrLjg1gER/oTLfTzrDwkjqKyO+Hn3rjYM32td/fZ+Ju9Dx
	8SEjN3lIoGGimcdRm72eJc5Z1GQgqCV0koUbm0QatATHSZwpAH7SciqEwJIl1eca1ObNPXa2lzViu
	ghikHoai5CbiOFeMWwAuIcmjnKbdm6uImFF0z3jmhzwkvB+/svsigsAFibLEZeS2yQbKD37pj+You
	eqMJBYvAakjWYmV+D8Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jh2qX-0000Nc-MK; Fri, 05 Jun 2020 03:16:41 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jh2qT-0000Mx-EN
 for linux-nvme@lists.infradead.org; Fri, 05 Jun 2020 03:16:38 +0000
Received: by mail-pj1-x1043.google.com with SMTP id jz3so2002840pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 04 Jun 2020 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bctzVQ8SIG8ea27wo554J62PZF0MOCP82/vS8y9jLf4=;
 b=nwwZGmKL2JSLcG3yJdDes19PRwsefTxEdzQXV3UoEaIJMppOnkNJ0yLzml+7eRhhr4
 C0tEb0axhGFC0uamROITrRN1H+727cRjPDTOoRr1LCOfnvojG+PpM9YRE33GaggHQKhe
 R40oxFAiS0MXAMKwUzhYZ/wgRD2YNxuxZeTqY9GgTtc0J/+3+mfkSOUuNQMpV0l8X1b8
 B2YYscM//GgYzMe3Biq5pUVJ+oULarPuV5q0GSua6MDxdTovUulXmKDugfoPbdhlJtpp
 RBmIaAFVCFGfqQus9NdgnzYxBOOLZAJonG74KD7ik1GWbtDxzaKoS1SAxGWrYhCVbqDw
 QQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bctzVQ8SIG8ea27wo554J62PZF0MOCP82/vS8y9jLf4=;
 b=bqn7blNelhd/9szaEjG6he6G18b3vCImVVICZTQ1vDwZ/DZdwy9hwOw14pCustmgqo
 KjFk1YdhSoLQBvp/n91vDHHokhmuWLlSUH7OXa5pJjQ/LxxGpXijnAtGaUtfWPYANaMy
 TY4e0Rvvz8s4aH1qJIqNNcL/JIGnk2xuF71rDGJfK5Qp+QMwwQ8Pt5yGGz5+j3TNjcPZ
 ziu7evV40ZBR9FOAdphFJwejnR5jzR6gMay/1LXrvJeG/erMMWt9ekmjtA4fvGlO7l7K
 EFBr5ot6ue/zgPZAbkedzJXXe86CaEfQxNeMg5Lw2OPC+llRBfpOOwgtgy8zdFQytnuv
 8m3Q==
X-Gm-Message-State: AOAM530SHJxV1IlNXOX1iTNj8P5hIm//rFqBWHRXw77sVg2/9NTSClve
 k8Gt4llD3eCnnhuwV3BhiytoVrklaHiPaQ==
X-Google-Smtp-Source: ABdhPJwmPyXkUafuc100JuyhcxdTbOoCHtdt4NGHMPe735k0ADUTPCKvIHAO7A/vxQEvTYjqbrJC2A==
X-Received: by 2002:a17:90a:f184:: with SMTP id
 bv4mr563999pjb.57.1591326996097; 
 Thu, 04 Jun 2020 20:16:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id k19sm6115552pfg.153.2020.06.04.20.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 20:16:35 -0700 (PDT)
Subject: Re: [PATCH] block: remove the error argument to the
 block_bio_complete tracepoint
To: Christoph Hellwig <hch@lst.de>
References: <20200603051443.579748-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c98a1900-7746-6bb7-2301-457df60ec066@kernel.dk>
Date: Thu, 4 Jun 2020 21:16:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603051443.579748-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_201637_482184_559CAB3F 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: linux-block@vger.kernel.org, hare@suse.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/2/20 11:14 PM, Christoph Hellwig wrote:
> The status can be trivially derived from the bio itself.  That also avoid
> callers like NVMe to incorrectly pass a blk_status_t instead of the errno,
> and the overhead of translating the blk_status_t to the errno in the I/O
> completion fast path when no tracing is enabled.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

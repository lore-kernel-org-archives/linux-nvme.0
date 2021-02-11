Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE3C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:32:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E56764E5F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E56764E5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KLTNNfZ9L0Q6HvS9cYqDccxbNKMSN+4l0Iclzw/eRTg=; b=c8b0tgpuYUMb2hKtQMaEmMXcU
	RjmhlV93IxGYqBJBJFfcTthCmHxcu6SqFx1CtSkqmavb+cxr1dGr1zR8stg95fWka5oROznhXsr+5
	unWvssy8R8nbd1gdxJvthgflDxPl4AbXJUtFsRKNC+9gjYvn3IbORHb75m3BNz3GrLRERd+gDEFmu
	qQIgLEG/qy1Xw9p4/4vCRqmrzUooLJETFV1U+ZlsdVpokELhQap012OOGz1ygq9aBAeF9iMltGCHp
	/p6QBmPJsB6qTjL7dNUznbvFCaRTltO45LK1/DUkca515UPy0Ad7H3xUxqOEXewRtK6lYbs3lcdbN
	buWkn0UPw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGl3-00037l-K2; Thu, 11 Feb 2021 18:32:05 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGl1-00036Q-PC
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:32:04 +0000
Received: by mail-il1-x12d.google.com with SMTP id m20so5921061ilj.13
 for <linux-nvme@lists.infradead.org>; Thu, 11 Feb 2021 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AnAjxOD/QFbt9Jf2jIcI+bHB/hd0uOUG+fq9pOrDIk4=;
 b=bSySlswpTRFjWa+bXxino4wBcg1AFxg1uXM/GQgtfxNuM9L0yD2VWwooWTo7qGmKfO
 VIGt7LhhR4PP8lchdw84IY69vp1Zmjj5P0VC+mzwKcO5gyD/QyM70FryNRptKzHoqfWq
 ZBQdtpw3kUHLdNJyBB16ezrg0I/vhk8J65nly3Kt1DUa8T2HXF3aVBelErkGMS+JocG5
 L620UXSEF0PlTYMs0oBqGKDr7ibhpnfiZnkry8TKCOt+vEJN9SWA0yiMSj9bwxemEG1f
 86hW4F6F3vOdrtL5CSVu99WuX2pk3WP7Ti7C+rr33an775pzOVq6pXgW8MIEIuvteae4
 nn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AnAjxOD/QFbt9Jf2jIcI+bHB/hd0uOUG+fq9pOrDIk4=;
 b=mhZhJgKFTV8QYKSUmVZfLIHnECd2N0lUUn2zGtIGfvp+J6qO6c9mbQ4O6AWW4VDT8F
 4olYqekOhySFFMoeK24R8NzEAD4/bKgX9qTCF7HT+G9yAIfz1CbQlVzlXoCSuftZQpZ9
 rJcnVWGxs5z6InrI6PLUcfm104iqos7ZH+TeUfvcInCmk6KG9LIUE3NrKMTo3TCb6gDh
 NvupbEZ6F0rF8Vnyga4GW1QlWS8E9gV2II/Y/ZVcnBdmj3zQvn19GAE+EB/bDvpGD7L8
 0Ww+vkct80gfyeSzfzWI6ikvC/jZ/iK9ZHZbw5NNRbuuKKUQ8ON8VwDxenPbwH3xuCk7
 2stg==
X-Gm-Message-State: AOAM530gVPPEtXEiLvS5WcQWlAE5tZ5hybT3XbA6p+jhyd52rgLcN8EK
 izZxWtSEwAMP7ZgIvicJSjMAvn1j6tSRFbDm
X-Google-Smtp-Source: ABdhPJwb7plA/5DWabOa/BlLbXodn0IbqI5WNUyE/W442JQGUg6/zfWZrKN8aEo27p5N1FeB53/hTA==
X-Received: by 2002:a92:da8a:: with SMTP id u10mr7059230iln.238.1613068319974; 
 Thu, 11 Feb 2021 10:31:59 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r9sm3028671ill.72.2021.02.11.10.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 10:31:59 -0800 (PST)
Subject: Re: [GIT PULL] second round of nvme updates for 5.12
To: Christoph Hellwig <hch@infradead.org>
References: <YCV0PmcdMDOeQp5Q@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
Date: Thu, 11 Feb 2021 11:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCV0PmcdMDOeQp5Q@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_133203_936279_E279013D 
X-CRM114-Status: GOOD (  14.79  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/21 11:15 AM, Christoph Hellwig wrote:
> Note that we have some issues with the previous updates.  We're working
> fast on fixes for those, but in the meantime I think it is good to get
> these changes out to you and into linux-next.

Pulled - it throws a trivial reject in the quirks list, fwiw.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

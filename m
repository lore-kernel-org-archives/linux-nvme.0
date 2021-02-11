Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED27BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:34:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EDC64DCF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EDC64DCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+EczFz5voIjIiQzHycEy9xVQ50rt2tMsQ+IcdIKo5VY=; b=ayFmCw5Fi1H+G3FMu61vTxFmi
	8o08DC0ZgAOiOQK3iA4biKKbnR+vguNdmcVfYOkN8rEblrf8VikE/1fptBzHxYmhBoMgWCTZm4lfA
	LNmcmQhUiFjVwHPxmh8DGyZsAFuPwa6YQTwB6Nnug6tH0oAcS8R5SjW5lhENwuO1ZmNnWbFXiyZRh
	8jR/8sHxq3zmP7o6VxEZcdS803WsNx/Hkp+G8Q+a8cr3nsMWO5a1XMs/3e2lSKZRJ9BWrMzgpaqcj
	3z7eUe8oLJlCrUQLBL4LgPRS6Ux85ZyD5ZQ7BBfiZVP3RQUelAobgI/2O+XbuTq8qV8i/OsxFHt2a
	vxJELf2lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGnP-0003WC-Dj; Thu, 11 Feb 2021 18:34:31 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGnL-0003VA-1G
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:34:30 +0000
Received: by mail-il1-x132.google.com with SMTP id w1so4796549ilm.12
 for <linux-nvme@lists.infradead.org>; Thu, 11 Feb 2021 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W5xqSQEqNa7VWm5f18JqQ7X2PMrfpMdRo0ENoP0C/bU=;
 b=ZQL72SZiPb2lAkc2QSg8cK5zNsUjkbqoVUIZxHY0+3QiKlXZ7No9xsZ5SelUBnJ6qB
 m7EKaEGLmODZ02Ow/HOcxv6snDahUQlyOB9UY/GvYiEEyElINBwPVSkxnNDj+9qj21gb
 aP2RmIeK0OTdDWslF1Id8qKo6++7wfnJOSJ5xAwjAl5Xp/XUIOJVeM2E40LcgdLK9ieS
 UUuwDcXMK8WiwuXA+oQURELnoN+ETH1hYw+bRzV2HDmzOS4biyW5rTPZC9rUo6e6W26b
 myT0PeZE97WyEqQRi99eL+lyBSsuOJpWH2uuxZIT4b8tCmFrQI47i6bT5dTWenqmaFN4
 uQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W5xqSQEqNa7VWm5f18JqQ7X2PMrfpMdRo0ENoP0C/bU=;
 b=EBtSfZSBeEeFJoBaFdKZmthPfMoLAeKMnPCXQBkiEgEn7Mjfd+fDrCao+iB3ZupKhj
 FFv+K5ebcR7vTpx7Ho4U8uUA+QLjDipjskFOKnAAbDoEXdRtWufM42nq6s+sSXap3EBi
 f+GgWB8syvmSKxbUZtc8QcCmAwdII26c9pPbwR0BhPaGwXtI9T0+H1Ax6MceTWY7jIeu
 15FMPsNOeVG6YO5BDnqGb03IrrNwRmZcmhO7m9iSl1SCO3J/kJLtsxdPB6fxPeh1T3OS
 P+AxUaGHQ7lMhJnAEy7EdFFqdc43NCw1w2IHHMnZ6mL3Mw9sKnsVwLv6CGW8QYRDhsIW
 TX9w==
X-Gm-Message-State: AOAM533J+QUEDVx1N5lfU6/3Zj5IJLdRhP2uYJDaXLk2hVKGhN3aQxj6
 ywWEBVEq9wjr0goqIuwFA5qp5IdRhPr+H/JZ
X-Google-Smtp-Source: ABdhPJyVWfI0szbeblheEu9U8yvRcSwO5mPTnxtmdPeTIpZRgipQdNG232Lwf9BKxhkGTzIXCoYK/w==
X-Received: by 2002:a05:6e02:13eb:: with SMTP id
 w11mr6819376ilj.103.1613068464766; 
 Thu, 11 Feb 2021 10:34:24 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id b9sm2962688ilo.41.2021.02.11.10.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 10:34:24 -0800 (PST)
Subject: Re: [GIT PULL] second round of nvme updates for 5.12
To: Christoph Hellwig <hch@infradead.org>
References: <YCV0PmcdMDOeQp5Q@infradead.org>
 <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
 <20210211183316.GA2527859@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06daa8d8-3ec9-8372-f912-65e844b87e31@kernel.dk>
Date: Thu, 11 Feb 2021 11:34:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211183316.GA2527859@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_133427_127821_0553F415 
X-CRM114-Status: GOOD (  15.70  )
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

On 2/11/21 11:33 AM, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 11:31:58AM -0700, Jens Axboe wrote:
>> On 2/11/21 11:15 AM, Christoph Hellwig wrote:
>>> Note that we have some issues with the previous updates.  We're working
>>> fast on fixes for those, but in the meantime I think it is good to get
>>> these changes out to you and into linux-next.
>>
>> Pulled - it throws a trivial reject in the quirks list, fwiw.
> 
> Yes, people are producing buggy controllers way to quickly.. :(

We'll do whitelists instead next time, less churn ;-)

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

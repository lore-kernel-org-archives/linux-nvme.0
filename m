Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A9C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:55:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDE32075E
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nEsO46V4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GGzTdSY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDE32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nG3eoejVmH6Yb8RyQphZL6g2IXOe3S74KxIaWgtmTy8=; b=nEsO46V4rT1j3/
	R+R/TDpRhbPjen7DhZSiid5CKjCYMu9xt6nO+Pzay2STR+b8HRSUrg11mBHlUWwfZAMjN/TZzQg/P
	joqxm8MdafALL/wCarWZs3Lns29wYdcJmmT537eljPKMaclJpGKXAF07VtdHeBrd2roEkWRXVEHtp
	9uH3w+DKwzqXfmiK/qhxJb7C0Ck9ECBi3gJ7dOfWj0g4sl5Rf9q7C77zIimsBumupzGwPjTUGVei6
	+oViXNq6pSS0La6cRmK2TkbwF1QRlwXBE2T7uTes1klYfbhUQfiCSTz1tjUa1Gh4FSmn4fh9eQ2SP
	K01Xz7H3lktsSUFuttQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvx6-00074R-Qj; Thu, 18 Jun 2020 14:55:40 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvvq-0003gn-Nc
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:54:26 +0000
Received: by mail-pj1-x1032.google.com with SMTP id a45so3470061pje.1
 for <linux-nvme@lists.infradead.org>; Thu, 18 Jun 2020 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wEuao5wn8UXQpITMLbI7NpgCyzdB4/2AS+Ysy0CQ4Sg=;
 b=GGzTdSY5m/+RG9/R7F6uhZjZ4Cjccdq4hLYK8CfMO8lq854zI5fOybiL/qphzD2Etx
 GEYYNjyuRD+bbju0mmC0cdBdfebDKnfh64BAUvrjldij8mjooBnyv/KP2fnvu4fJayFE
 tSL9SBK6Kej5XA2+pTMTb1ULJuOjjoNWmRCJqzpfLQ91gkJgHZHCg3502oZa4uOQuW9b
 Wkdo6BvdMXWYpCljTVq0Hm4dY0YkeA0yrIjSn56wrl6a3wWm79j9bJYW1soqab4JWvtV
 am9eAXUrrxITQyeczKb9ljW9HBZY+cbpNA5hqVc5pR1C7RUBc7dsz5XRChvch86hd0et
 2FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wEuao5wn8UXQpITMLbI7NpgCyzdB4/2AS+Ysy0CQ4Sg=;
 b=iqHX4D4t9B6saPbAfgJgKalA0VGNDyyODXsm2jTA1MXq67n9WcIisAqSgbpdycbC1G
 NOn/T4hCN6PyoR1H+rJiEVOXnC0UnalM9bsieTXnZljjopfLJNaJld0rBVmSb17lu8DW
 oalE7TqNgWOUkm+c7KDrBRF1YcjvAYCI7tX7tQ/6p6WCHV/c8krk/V7S+tyePYsmeFO+
 ZI0SWsAKZo4PyvALQdm++5o2zM+XTp0WKCvPKSJmu65mR19LmWU2rCdYGYO9sM5pbmnI
 a3gDjWwX+3BWfAXFc2bp+PLGy1U3cZpbL2PWad/Q3a+51RYq1VqiuontBNgGjrn5Je+D
 h5DA==
X-Gm-Message-State: AOAM532tFvjOj9ePV0AbhbN7NUBzLUhZ3ll1nk0CjbSNLHR1fwA1s8aa
 fLy0sw6lCMjdPsjtEdSh3Rqzmtqt91nw1Q==
X-Google-Smtp-Source: ABdhPJwcFOc5Yr92uc93fm7894g1kSKgQZVoOZV5HwWbPNZS46MHJ8WAPgFlOhcLhn8gRP3SnaVudQ==
X-Received: by 2002:a17:902:d902:: with SMTP id
 c2mr4292295plz.194.1592492059351; 
 Thu, 18 Jun 2020 07:54:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id 8sm3052619pja.0.2020.06.18.07.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 07:54:18 -0700 (PDT)
Subject: Re: blk_mq_complete_request overhaul
To: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
 <20200618141103.GA16866@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b46ff4dc-45de-0130-d36c-70278f49abb1@kernel.dk>
Date: Thu, 18 Jun 2020 08:54:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618141103.GA16866@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_075422_791175_68AA3AF0 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/18/20 8:11 AM, Christoph Hellwig wrote:
> Any comments?
> 
> (and yes, I misspelled the nvme list address, but the interested
> parties should be on linux-block anyway)

I've looked over it, and it looks fine to me. Haven't done a full
test pass yet, but assuming that's good, I'll queue this up for
5.9.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

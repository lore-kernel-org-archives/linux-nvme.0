Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDCC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 14:55:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D2E206D4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 14:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aD36oIkf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IB5rE6UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D2E206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E42cDMJFw9j8ET/rlQLVXNeWy4+1Dn02yaZG/ABuhzI=; b=aD36oIkfZbrcpjS07BErOaqnK
	vYlpIgMrVoUjqKS2tGGiTwqY0/urnl2qa1GCZXWmz+wHWAz5gWOwPN4MnFh84coAs6DpiO4qudAgo
	U2MiWCNfJXdK0ECmtsdxmS5ccjbTVBlTx3So64SqNCx7paccLyI1aff+/RzaNHHeaLp2ggq827zjd
	HQs2G46+rNdo3H2LCPVPed4Um9HbxVEGZWcJ0wuwrBGLBfvR66L7RR6hKiCo0qYu3+2cDk93LPtA8
	qsAWVBjkXl5R6yEOL0BjjZACwdmDZoV04KhAv9PXit6XNm6gDyeUFhN/FZe9WtLb7TEqXJRD7p7Kn
	JAONgomcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kY9KT-0003Of-2d; Thu, 29 Oct 2020 14:55:05 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kY9KQ-0003NL-JV
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 14:55:03 +0000
Received: by mail-il1-x134.google.com with SMTP id n5so3299436ile.7
 for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XFoROk73a/XXJEseX0yuJjHe8vXTqL1xoK95/dOWNqc=;
 b=IB5rE6UZtAb4aoo/uj0PgEbc+yHU1rZ1jJuzLJTbmVqDwKsLAKmJvJopnTbfHJ0m6e
 eE5Ig+6pfIVePjZsnekYXXewGdPaocu4UINfHxr3QGRJCN5TflhO7QNrscogpFIVHIG7
 xAdJ5G/dwQoaQQlZTbomXI/16IkMfQh/LpjdvEtSVax4ABMcbx5mgqjHw0JDKVYOTOSI
 KcvY4QsGTcTNfldqYDE9R2k/eBIbMGKHMNv7RryDPQo1lyQQxM5vKtJz/EymLPprgptw
 mUE+HAUQuQ2COpCqAwHwci/GJhBEIWzpVVrHpcLFMq3T+8HzJ/X2H5RJvbl1+g05gkLf
 /qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XFoROk73a/XXJEseX0yuJjHe8vXTqL1xoK95/dOWNqc=;
 b=kz2qbRVBFqfFzSaCVqWP+27cNM3+e2e2XL3Ea3BIfLzg9wEyhvAsIyiOlhZkOx+5YO
 YLUTF7fW3Uu4PmMmPdcx2Ooj+r7EF2YVgi007WRDSqa/qu31zTQn7yMTVSAyHBtBS1+w
 N7X8ZR5IbVCwkCl6OjbiZSg8cp7zAomvtmo5kWn9LkuiLJvStUdFA2kyLBauGmUq6qRi
 9VIuUBewPOSH767dSXe3pBsVK66khWmIlRjT2uvFAEFPX9T52L4JB1Z9IHHUgDACFJPF
 eIW/laQh8rhiuivltqqEXgXjPRg2WYHdVn9Nk9WdD9AVwTIU6KrpJjJqr+MjcZiYvQem
 Fcaw==
X-Gm-Message-State: AOAM530Bjguzd6yMrlKjXtuZBVDdC/v4I23+fMdbuKuHEhjGZDJpzmtb
 VSpwJD8sIKoFcd6YIFLywUKIF4zwgLsf6g==
X-Google-Smtp-Source: ABdhPJzH3AtusSBG5TKEe4gJ2Ke6wyh4zCMPLEnAb75Xqr9/wjy5gFAtC0CIvhn64JCFyYFnUXEQhA==
X-Received: by 2002:a92:9907:: with SMTP id p7mr3624323ili.200.1603983299040; 
 Thu, 29 Oct 2020 07:54:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id f12sm2200291iop.45.2020.10.29.07.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 07:54:58 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201029144934.GA143642@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <306d09c9-be4c-d535-c397-920b960a265f@kernel.dk>
Date: Thu, 29 Oct 2020 08:54:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029144934.GA143642@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_105502_678966_EF55276B 
X-CRM114-Status: GOOD (  13.44  )
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

On 10/29/20 8:49 AM, Christoph Hellwig wrote:
> The following changes since commit f255c19b3ab46d3cad3b1b2e1036f4c926cb1d0c:
> 
>   blk-cgroup: Pre-allocate tree node on blkg_conf_prep (2020-10-26 07:57:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-29

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

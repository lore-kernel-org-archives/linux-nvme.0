Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78895C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEE66121F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EEE66121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjo8/1xhCByFj24D2uvkYYxEalaUO4YdIsYjUlnOG5c=; b=FqBWlGfgb6AlFy9D7rOsEGU9U0
	0rmwg+j17LLo72848vI8Rvj0XwZKpb4llK0Kq8XvQeEkNB56iKQzT2XtqwZv8kqRSxntIbPpK8Imf
	U1bxnMp87UKemhHe2WY3Z3ZIm9a4nU4FlLEuJgZilvvvBkc2yvcGNsUYnnO+tf2yVEAQbOqbBOylF
	uvS04jabVazjJ62quIu8F1+mL2fZUV6RQWRXfy+TfwATBMeB7RJmLofyL02JFEUuR3KJn9G926Yye
	9AYPtcTyK2wO05lyXtmW9woIthDhA81i+NvgzeuDchZE+sPlLMkIVSP66hk7295cHgDb+GkSfevcf
	+ljVHEYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdZ1x-007ptG-MK; Thu, 21 Oct 2021 14:26:53 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdZ1h-007pmf-Ed
 for linux-nvme@lists.infradead.org; Thu, 21 Oct 2021 14:26:39 +0000
Received: by mail-oi1-x22d.google.com with SMTP id o83so1077040oif.4
 for <linux-nvme@lists.infradead.org>; Thu, 21 Oct 2021 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pjo8/1xhCByFj24D2uvkYYxEalaUO4YdIsYjUlnOG5c=;
 b=kc93k3l5YlQAlCienhWOoj4hZWRUrvEm3nOCeb+3WKhWZVSB6iyqQxhlD1OUxi04gA
 oxDT1zRg5joGCvYdiUP+RK87aEkg3loDRq6S0W5tUiQSGm2Nb5mfP7DZb3bgXKco+qUq
 EojMr0zgrXdkrPT7bebZZ9xzGQSQkz8Q23QqVQ9ucU9tQYVdHsezjaOg2gL7xeFx60QS
 kfkSPjUIca3pAK3B8DNLSQSn8Fv/q5usjb6JjTuqElhagtTFdOERabJ/BhsKjdCznHfV
 01fSzbkPVKykRSEDDktYHYOTrZiqXLlj/Cz4NRiRLgQq/ZNH0bs7PilLoupw6FeiAspz
 3+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pjo8/1xhCByFj24D2uvkYYxEalaUO4YdIsYjUlnOG5c=;
 b=QAzXI0xvvkJzn1lfF0JxJC49SmeF7ICq85zMMC0jgQN7flOorN18yWKRghbFgAvjFm
 FsNcNTBViPsHZ2h2h/OmM/CWzHMTN/U20nu8dKcp4ETliNqtXf67SlSQ/f1tV9236e8d
 FyPwpE/v/s4JM1wFu8cZgtZIta7AwWIniVpO7IfAklPDW9WrQjBTrRC9y/9NHJBO/SSi
 xw2jnYTpGxJPavXAftbndzL2G+2XFUnH8/t6ps4CecINmT6kVOnS8XHjvdpjjbJ3Z9Ig
 lLn6K7a5UIJDh+XnEjp4vNtW/AjhpVp3bxx+SUkfh29S2igpYs6WxnJLfWqa9exkZ3/D
 IU/A==
X-Gm-Message-State: AOAM530Yl5WpJ5ZnvcVcmwfXUu/ups1lEq4bSuwxRAxWTcQ7OD4r+93G
 BAHlRzzkJx/nl34wYKJoJVyokvMAGVkhuuan
X-Google-Smtp-Source: ABdhPJyFK37EeyeeopmxukxBsFTzpAPFfr7vo9DAYIN5Pi3ZWvq73WSwEcNmR2ilyb2f8pBHb80phA==
X-Received: by 2002:a05:6808:bc6:: with SMTP id
 o6mr4931496oik.33.1634826395708; 
 Thu, 21 Oct 2021 07:26:35 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac?
 ([2600:380:783a:c43c:af64:c142:4db7:63ac])
 by smtp.gmail.com with ESMTPSA id c17sm1163600ots.35.2021.10.21.07.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Oct 2021 07:26:35 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YXFjRq8JzDdVXww/@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f27b729f-f7dc-2ceb-4ae2-5de18e2d4c4d@kernel.dk>
Date: Thu, 21 Oct 2021 08:26:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXFjRq8JzDdVXww/@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211021_072637_559181_FEF44763 
X-CRM114-Status: GOOD (  11.20  )
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

On 10/21/21 6:55 AM, Christoph Hellwig wrote:
> The following changes since commit a9a7e30fd918588bc312ba782426e3a1282df359:
> 
>   nvme: don't memset() the normal read/write command (2021-10-19 12:41:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-21

Pulled, thanks.

-- 
Jens Axboe



Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33711C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:36:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFB960F70
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABFB960F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HdOnGgqdLoCyU34bqJgaOEfvztTrDictBqijAyk0E64=; b=d7VndBEMWVXDiVaIk3b+KZiFZJ
	N/8CH7hYdJrPb9MUDMssMCbV6tM2Ovd5kzrdWkQr3Lxr2LvhlS9ZZcXC7qxKZYwxyOqjyqrOd9TZB
	ps+aADEVPq+TD/qklWt40lXOozDZyRCAcr17TQ04OCRpmkG1ZW/q/dIfFewLrjn6JSr7vMkEA9csm
	XXYZ03VZos+6JqTeYHv6gF2biNC4DVLvzxEyNRazM/j1U6BqYpwN5bMMKohsCUFdPEP5w+Nz5zwH5
	jNLhwIbwaoydL5ueE3BCGLus5wPqi2H9PvTuCsmHJ/RtgdLFjgtknCcZDd/gZhJikJRy1aBa7Zz6t
	ozVJDztA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg6VZ-008CX1-6x; Thu, 28 Oct 2021 14:35:57 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg6VM-008CRx-EX
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 14:35:45 +0000
Received: by mail-il1-x12d.google.com with SMTP id s3so7171146ild.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Oct 2021 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HdOnGgqdLoCyU34bqJgaOEfvztTrDictBqijAyk0E64=;
 b=y+sGzDgzGP2VflVeg0IIejzEplQHJnV/sPnc2aDcLRsvNkhIr6Bd6B1rKY+tgBcZcq
 VueZlHWgl6p2dHKf8RpKZp8BuED9Vj9uLTk3/tPg2zDZKu67swBSUi+UrAW2feDqX1Pg
 lVoW2MQD9ALyM54vuIdGsSCvy7PUnnrCrbEzwv28DDVYTrSaQsH03oTgvGy2s2zaawYq
 RnLzqJiAW35fIDMFIPbJZ570v5XA2YJE/v3lbZivn+Cl65ndYpnSygkYUsrHdN/lOngA
 1hdtoSaJ5slBglkhfqQRQeJK3Il3iuXlhE7JgARKgfRyxk84EcncCPz/37OeCW88Mlzn
 r2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HdOnGgqdLoCyU34bqJgaOEfvztTrDictBqijAyk0E64=;
 b=uPoZX/L+bk1EB1ESoLxYcw7iLY8q4h5Jt5jNHGc/DHlCXb7CmWRrwnYrLj/hMgNdIi
 Om2KrvAw2bw4DTbdQcdNVQYtpRcm0NY3eRUJqAnYz2Zp8WgVU7816gbfZxG1ByGLeVTE
 WQm3qWf/P/T1QjBsYC+Wb4hSlRI5ptonOBGgojxDn1+fixtSC7kvdz5K0OJN6d87iVje
 jnv3b59fgPjp54OcL3lJFwd4GXHS9I5hkX5DyMXCHf54WwR/qXsgNueCYZ779YWM2XaG
 jlYMpWYiWNCj3dQnMpLqR/a8iXC33YIjvYMBUi11W1nmqdLIOwai/JoMSYxnZpruFrhe
 F1Jw==
X-Gm-Message-State: AOAM530zEoDBX7GJEW7GIkq4wF3Da5HlLIW/RRKzlb3qIZjTEllo601R
 alpNHLmY5Q3qpjrCxfU2wvAPCcsOOVtg+w==
X-Google-Smtp-Source: ABdhPJw0nVFFjdBeM4GU37FAwbAHTvRxUD0Miy7CvjmLpFDK54qDAZQAhcgbjcr4/C1mdkBmW/16cw==
X-Received: by 2002:a92:ca0e:: with SMTP id j14mr3605427ils.131.1635431742907; 
 Thu, 28 Oct 2021 07:35:42 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id n17sm1622556ile.76.2021.10.28.07.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Oct 2021 07:35:42 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YXqzb6dj0DCrIbGY@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7b21a606-d582-ad3b-54d3-d8b8e7b247c8@kernel.dk>
Date: Thu, 28 Oct 2021 08:35:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXqzb6dj0DCrIbGY@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_073544_517260_B119E2FB 
X-CRM114-Status: GOOD (  10.95  )
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

On 10/28/21 8:27 AM, Christoph Hellwig wrote:
> The following changes since commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17:
> 
>   block: ataflop: more blk-mq refactoring fixes (2021-10-25 07:54:32 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-28

Pulled, thanks.

-- 
Jens Axboe



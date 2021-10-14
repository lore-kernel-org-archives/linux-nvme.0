Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F394DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 15:07:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57440600CC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 15:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57440600CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfJyXvRKhjtS0cyhrXF03/tm4IHT9n76BF2F5ZJ0mLM=; b=TKrU/L9djwzGQL3OIFIaqbmcxN
	WN0BlJVTcdZNd4o4u/ncdi9kMwPIIYyqgxi88INPRr8AZjD4C2IiRBdx2IMEMjpupN6pO/ChpP6jy
	rGT8vP2KXlsjWjAY9X1KcWD8J78AWN3oCZYnIWqSYgDgeEOKP7K5lcg+H4bhBh7SX2lklvmn9PQ7h
	tSTxQpE3sarCapKGAuODDkThM2gnld+MuOLHoMg2ItUVd1Q671iV1jF+x3E5z+n+t8QkRY4EIbfaR
	+mivzVtPyAaJIDBIgamA56FrIJrUKiFrCBbtJsTRi/hGK9daiHPBLDjqbDxrSZp+iADlB4MaAm+0F
	HHCpV1PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb2Kg-003aEo-KW; Thu, 14 Oct 2021 15:07:46 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb2Ke-003aDb-9k
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 15:07:45 +0000
Received: by mail-il1-x133.google.com with SMTP id s3so3920487ild.0
 for <linux-nvme@lists.infradead.org>; Thu, 14 Oct 2021 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SfJyXvRKhjtS0cyhrXF03/tm4IHT9n76BF2F5ZJ0mLM=;
 b=63SgkVEVxlJJbLeYFQziy19tPIXplozPNML5kfLIXNs6YRiGgFBBD3dRDj1J5b9CFJ
 e5w0LwRUaGXRKdGDAsGxVw1ZMHWSsWQCDfiqKU2n+knjeYra8i1ROa37Xss4gAg1SVZi
 t0X1HEoMAeO1brtYgdHzSbCX0PFNqEgdZyHL9WJ7YJbGznalJVPxTLdgEVh+nQBTNKhr
 CVtemTh6TSwEQc38JVq6N+xCjGoN/O7Ef7zz3u02n0p9Knjws7oxPQCsc5tLJU7M6Hdw
 CMVQi2ygZ5xv/B3D9fNdGzt91Uj6xqhNlmCLR6eYhbITAjCQn4w+Pp++aeqjEyxKdTtF
 dlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SfJyXvRKhjtS0cyhrXF03/tm4IHT9n76BF2F5ZJ0mLM=;
 b=PEjBt0wWGNtekkt0nspWD1y3xUd/y3/PdGEtvPZYna9ugNR/8Fj4+rrAGmi6fNj6sv
 goFCLt6Gp5JlVv3U0JvvqRhyabZruPPnambdLO+VDOfKyT0wVEwQByepc90RT8FStBrc
 AegYF9LdDYau3SHd0D0TD8Uss1qqJXlRW6tchN8fPR3IUw2ILFNh4CToy1PlLbujsm7x
 Y3GArhXkewkawRtkB8k/ptS7FkPt4ye3WxsYh30VzAdy6NpCC9KR1eJ9PUOXOGEdGBPM
 hH9j1unz6fnvOLxtu10dL2aiM5Qr6gClkRIPQicKfcdDf1k+Y3We2DtldAJKgQbsXevE
 JMwQ==
X-Gm-Message-State: AOAM531L2jKlt5lV02KS4RJ14CYdoUhpido8oB23VC4ViddSURGwcg1p
 T8H6nzAO9PySnDjpv20PefjdSfWizIssIg==
X-Google-Smtp-Source: ABdhPJxdB4ieGCBY+L04nlT2giJ1T7Gt6iBQIwYTJx1PW7z0qeSZzOhwM5nr6LUuVtYSXEDy6CoO5g==
X-Received: by 2002:a92:2c0d:: with SMTP id t13mr2799365ile.99.1634224059075; 
 Thu, 14 Oct 2021 08:07:39 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id ay5sm1486566iob.46.2021.10.14.08.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Oct 2021 08:07:38 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YWgrK/7ttndn93Fx@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b77904e4-7a20-fe98-55e2-b211d2217553@kernel.dk>
Date: Thu, 14 Oct 2021 09:07:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWgrK/7ttndn93Fx@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_080744_350676_691720EC 
X-CRM114-Status: GOOD (  10.94  )
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

On 10/14/21 7:05 AM, Christoph Hellwig wrote:
> The following changes since commit 298ba0e3d4af539cc37f982d4c011a0f07fca48c:
> 
>   nvme: keep ctrl->namespaces ordered (2021-09-21 09:17:15 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-14

Pulled, thanks.

-- 
Jens Axboe



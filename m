Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3844C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edqEgyj1aQJgqVQU6EdhYMAIpwztdCTolhlaMIVQJAA=; b=puJSInQ0hLGRCgCUSJBJHX3qyC
	hOLjDYEE5BXimdEX0cjS2w69Z5XJMpye1F3ZyuhQ5JK/d7oigb8pTgwIzJK0PB5KHKCLfWsHPeVoS
	lUKZbrGu+wz694DUgokkY6bjVhLMRu2TC64MQ/+wlKMMRjAJu6I38oDxEb/APseEuMg1x1OsLzZhA
	s31/qQ2yreumL43KqRJtkvWKVb/Xt9hCfWes9ce1rXg8pPgWBimwPdxdd2YczuKDI1YzM+u184KWS
	haOhI20lccQI1+R/PYuz92+XMMErEqWFZvoqimDlZefWHP0IVX55ZE5R3piDVGyG8wlkhXVa4ZD0k
	u3o7i4zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1V7R-00FBUd-JO; Wed, 15 Jun 2022 15:39:45 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1V7O-00FBT3-1E
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 15:39:43 +0000
Received: by mail-pj1-x1036.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so2408416pjb.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=edqEgyj1aQJgqVQU6EdhYMAIpwztdCTolhlaMIVQJAA=;
        b=LMx819ruwdoW6TQqOHWhQQa7z0SFBi8W4FuE4hmY3Rsjh+8lKKoVZu7tk8/vNgKQJ4
         uWBzb9hBnhV4GZqLzzFSZX9m83AuBKCJTxGN3il6rHAq3AdT3UF0x08LeVwbm+iyr/gh
         2SM0jGjkUIc6nmnPKdsyURIyZBivqH2fbPBTJDJ2Q+/tPDmoF9afeDYnaLPcBdGw6YX1
         YiUM16bLP8Uz0vgxo92xUk0z4SvhL4V3I/doXN6WShM06cuoY1eeT/hGFtxp2uiCVtNQ
         NTCM2TMnTah6DszqGELMYls/55vaIx93z6s3IFf8i5NpS9KL3bVGTJgojkkaOxSsOAEi
         +FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=edqEgyj1aQJgqVQU6EdhYMAIpwztdCTolhlaMIVQJAA=;
        b=1lkBzv8tDeLqmUpm7VuGBZl3WZPBffxDZKTmQ/O0t/FMzVAJC7emB474SthNv9xHGI
         C9ffwlckbcV/Ff/pHtNnmLNUwhY2uG5tnVoFewB3KzVXigBiRTLQDLrL+fvVAhDIqI4J
         V4OvdmxH2dkJZSICpQctrt7wD7/yDfJRB9kSaYPsSOkWx+FD5dd9bs5Rku1xOqYR0DMh
         brrLrREqD7Xdr+1FH+uLNtPjGMwLiWIlRs+JoZzm1u1OdScFFcFU3PxGxwPz8vm6OHfq
         NIIdaOSZ8fyJ3HTT3LpkDMRatNhr6Vd6MB6rlPYSGeFlmQR1VSU+2oGiJhe1Yx98GKsG
         QXEw==
X-Gm-Message-State: AJIora8uCXsudwLUy1cOkecin00JhSbDHsr/hlgztAdAee6+mQKyBr1P
	fGF7YMPUt0rESNX2xGGK7Ix8RwtofZM2jw==
X-Google-Smtp-Source: AGRyM1sF8ewweLMdOZ4+abu2W9yM5IN/bhLQXvRlCf8Us7XqgX83BB8sTa1LHpN/EUDyKE09tiM3HA==
X-Received: by 2002:a17:90a:be16:b0:1ea:e19f:b3a2 with SMTP id a22-20020a17090abe1600b001eae19fb3a2mr903760pjs.191.1655307579040;
        Wed, 15 Jun 2022 08:39:39 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x13-20020a63b20d000000b003faebbb772esm10346530pge.25.2022.06.15.08.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 08:39:38 -0700 (PDT)
Message-ID: <98db9274-67ef-1e8d-33d3-e9020337cb02@kernel.dk>
Date: Wed, 15 Jun 2022 09:39:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YqngkWynuVHY+aDS@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YqngkWynuVHY+aDS@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_083942_324641_6F91A526 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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

On 6/15/22 7:37 AM, Christoph Hellwig wrote:
> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:
> 
>   Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-15

Pulled, thanks.

-- 
Jens Axboe



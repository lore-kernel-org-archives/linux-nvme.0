Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6085C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6i5uE6A5Zlvkv7XdG8O/0f5q21B/jG/q2vmpQr/6x4=; b=dQUF31gze1J83FQS9randUBayG
	et/ojzTUcpkZvtd7E4QF3BSjr83iztDT5iuKEWe6IcjJvoj+EyHMUVvdCpkmli4AbUgTCjCQoxifM
	G0/b4Kz2uSVvR7yTET9N9iw2lLqfpMcqxnAffpRpxR0NXBNqr3J/M83Y7Rj56F68q0jrGTP5xxrZ7
	l9Di1xIg6WLaZvwrjpB5UofHwfZLOHOZ9kPAFx+/tCQJdvvMtQMtv9N8rJOrJYhcKOgfOZ1+z6u1p
	1NZFAN0UWncUaylvQ9Q7cRWt05nO+/CRlyAg9Iu43kWzMcamLrRpcoYHabC/UhvNdg53d5TK8jgN9
	3zC39bcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqGA5-007un1-7l; Thu, 25 Nov 2021 14:55:45 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqGA1-007ulp-Ua
 for linux-nvme@lists.infradead.org; Thu, 25 Nov 2021 14:55:43 +0000
Received: by mail-io1-xd2f.google.com with SMTP id p23so7843996iod.7
 for <linux-nvme@lists.infradead.org>; Thu, 25 Nov 2021 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s6i5uE6A5Zlvkv7XdG8O/0f5q21B/jG/q2vmpQr/6x4=;
 b=XjQJQph9gjOiocBWA8oarogiZo1zQaHaFayjIPR25YouaRc7GIGfePuIYBLZGY1hVC
 JKyXldqpoy+RrnM9xaFWSPi5wnZjPmD/pkXxjoKhsW7KBA+Lg1Y+HDliT2qzcd3eSF32
 CoVcV+CTIom0XQSC/+kmtXDQPNGipw9t/NHD0G7mFKmUWlDwAkpQKukApTqhk2OLwWf4
 Cz8OdQCMymvCO+DeiQ/SajmvPqzejSISGrVd54B+gWmNYY2rwM8TpwD67jDpa4GAIqeF
 dRG+kQEob1f96SQDKC68FCTg1//fdyyuUVTPRfxr1xRckuUFTIcS0HsWbV1Xbr7bn1c2
 0LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s6i5uE6A5Zlvkv7XdG8O/0f5q21B/jG/q2vmpQr/6x4=;
 b=cR5pEiJCqw+xtPEo7+OP+AwGwXYmku+bz1iola57JmslNpV2JB+Y4VtwkObPVnZYI0
 J+bTRjkaRkuMxzoRcSunODeM5MnUf0vTp309Y3uUBSVZnHmVa2afdFUrrmmgnIAj80kQ
 DR766uLV0YfJD/a9RsX3tzq+BjxP6SPzAoM+JvW+Dbc/9/u84C2k/FmnBljycf3LuYMr
 rZDb1D+1su9sVORaoQGSbGsa1/PvsgiUm0nz2fR4E8Rm+5omJ9asHTsTESW4/+ZDmIYz
 QtjqAP8FSqxpsguQdqo66HGkEimoWCBs1zTEhFBc+fs7EtL7bV5kkZlP1EUI1IdHXCDf
 NDcA==
X-Gm-Message-State: AOAM532vppir4hPlv8mIqUiogjNgE2k2+CJ8hKCc8pqYM06bP3MFZnkx
 5zD6m05DUXxZO1l/iewLGwVnH4S3KgtIdWZL
X-Google-Smtp-Source: ABdhPJz3B/lUaWW5cnX5/KkRg/D6TToXlvT5+9PMMEJtf+RK+xiJnm8tv2NGAcpxcb1ZL3qkVwjEww==
X-Received: by 2002:a05:6602:14d3:: with SMTP id
 b19mr26406594iow.17.1637852140455; 
 Thu, 25 Nov 2021 06:55:40 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id f2sm1889908ilu.2.2021.11.25.06.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Nov 2021 06:55:40 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YZ+X/qGC6/w3bp2c@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
Date: Thu, 25 Nov 2021 07:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ+X/qGC6/w3bp2c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_065541_996278_6A703731 
X-CRM114-Status: GOOD (  11.68  )
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

On 11/25/21 7:04 AM, Christoph Hellwig wrote:
>  drivers/nvme/host/core.c          | 29 +++++++++++++++++--
>  drivers/nvme/host/fabrics.c       |  3 ++
>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
>  drivers/nvme/target/io-cmd-file.c |  2 ++
>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
>  5 files changed, 93 insertions(+), 46 deletions(-)

This doesn't match what I get:

 drivers/nvme/host/core.c          | 29 +++++++++++++++++++---
 drivers/nvme/host/fabrics.c       |  3 +++
 drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++++++-----------------------
 drivers/nvme/target/io-cmd-file.c |  4 ++-
 drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++++++---------
 5 files changed, 94 insertions(+), 47 deletions(-)

Hmm?

-- 
Jens Axboe



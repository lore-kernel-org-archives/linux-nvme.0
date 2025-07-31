Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6164EC87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSDxbK07W8AVyHd9cJSd+DPYfd611H9p/rcU8K0ZniQ=; b=u61ZxeAySW2WeAl1xmWLwCHHX9
	hBrl2nRb7EeZpwrMym7CxkllOqEGjZFsmej2bldSrDxn92u3bt+IWKw/C7OMf/m0vHalqrPSR7mYx
	s504b4FjIkMS83L9QH7UZiV8VR3ubflhkll7XsXjZGTHKqHUWs3fFDfgdDhF+lObWWryc88whH+RI
	WSiOa7bvuI2BEhnH6RgLQFalZlT02IYzTpsmHXD3q+jh6QzZuLLdQoye5iHMwNGlVdh8X1732OkSC
	xfM0D2ISE6biEncQcSo4ZRCTGqkLiQFFUrJfxIhHpNIzV7WEEB8c1dl7VrBRAXuQk+hh6T17YKEbk
	vme7gv3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhWZJ-000000047TD-1qgL;
	Thu, 31 Jul 2025 16:55:49 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhWZH-000000047Rc-0FC9
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 16:55:48 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-40a55314d06so206499b6e.1
        for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753980946; x=1754585746; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSDxbK07W8AVyHd9cJSd+DPYfd611H9p/rcU8K0ZniQ=;
        b=lS3dBXNAIBtyjVbr5bWqYzGMf1ZN9D5+fRjVlIv6bQ4OhZhlJX1mzqO+ZWZNT73GMn
         F3NcFhp6N+zXyvTY4SAQUyUSVQ1cxB3GWcM2QaM3rIvsOiFYBU66BJTw+KWZ4ntUVgBR
         fr4wdx6HiPkTYhUAkuyehRnWr9EzYJ78OGx4NzDMvj/UMqOKH0kCO0j9yWFP7tcNvAjr
         LLJZknQYujcGv+L/mGbk/gajQT9T8ddS6iLfUJAfQZpXjp/x7IbMUxrimaWMpNtvHrBk
         oaOdxSUP+M0ckpFrG0XAqUwe8WEQKrjJ7YNA8TBzHsX1hKJ40ZcfneF0jq9fRvhF7hi8
         SFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980946; x=1754585746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSDxbK07W8AVyHd9cJSd+DPYfd611H9p/rcU8K0ZniQ=;
        b=mHCskMJ2+SanGFXIKkPmVTbAAQNQqEvbM36HDuupu69nIqDJ62Jn5NdxYWgyDdDu14
         M3MJK46Z99xLElwF4WgOIMvLguPFLSnzwQthpV/YYR+GdgByQDPPC71/FlhziD0dgvrv
         WNKaARn6ItF88ktvSSmqNd+/IjEalJUGeD6+HZvgaQVsQGWBk2Ja/IG1JFZH02mOyTIF
         VqqLZ19ifpeYbtY14yMCWqfhRJAw8Su5dpul/tp+gmR+nCA7R8IZlZca4oYHc1hTfVnA
         IO2nALYNHlI8nKJq2KJtSFTWbcKnQAuoD4FHR+dm5oXOs6l2ODmbHjiL+KdXIHzUQM9D
         WU8g==
X-Forwarded-Encrypted: i=1; AJvYcCX3WOuNzEcdxt+OcCZVyehF30SDVn7QAnLdW4dFo2Q1l2xnBlkCP22Vv0Qx/q0xXrRm7F5hXGrQVpRh@lists.infradead.org
X-Gm-Message-State: AOJu0YzC+LXvMA3VYpJMW5jWq+5qgmFWNqfNCNwQfeIbRjW6fLlVzrg/
	7nvgW9kNbxJmVwc+m1cKaS7zg1XzLR4+3VzSKDm2aW5Rd03DxmSS3TM5yqRk7n981Fw=
X-Gm-Gg: ASbGnct4iIP21Dc5zI1V3S2ilVNP4RSYKbZZL8O7q5MBrS3DklcscnuUwS2rF2nbipp
	zsx5T8fCbjIMy0PeR4cMsRMzsCXMqpUG6E63dp3siYJMQASPiQfHZh9BCqY8NcigQ+kQu4W4Pb/
	f0LWJhQnzOtsB2U00D5uk8deaiVnFfSDiXuDhbWaCLN/f4Vdj8TtLhH+YhbnD/0O+rIZj7PHnT1
	4yWL6iYfLKCKlQyEoXMNFr689Yb3wnn2ZZ+nvd2Pf558Yddj6aMFqgyo3LSbvEd4LccxNRRVXPy
	e6WhFPt2hyUSJmhQM9Cf+dxZZiyyFydDeLOvYoHztHhJN8tap0sifQyXBLMvh+HSJWS1eNrxbIk
	58H3gtgRRza+JPbPrlw==
X-Google-Smtp-Source: AGHT+IGcqLPvX2byoEbvS8JWIBfH9x2heV5qHLZk2PAWhIXT8vEiajkPM4wjhrW3C/Kl2vqmdXYTOQ==
X-Received: by 2002:a05:6808:1a11:b0:40c:fc48:33b5 with SMTP id 5614622812f47-43199c847d7mr4264174b6e.12.1753980946077;
        Thu, 31 Jul 2025 09:55:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55db1402sm615015173.93.2025.07.31.09.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 09:55:45 -0700 (PDT)
Message-ID: <fdd15ad1-a1e6-4e22-9cef-0dfce1f8b24d@kernel.dk>
Date: Thu, 31 Jul 2025 10:55:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.17
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aIt40gBo9MuyC9Y2@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aIt40gBo9MuyC9Y2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_095547_345418_1DA6484E 
X-CRM114-Status: GOOD (  14.40  )
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

On 7/31/25 8:08 AM, Christoph Hellwig wrote:
> The following changes since commit 5421681bc3ef13476bd9443379cd69381e8760fa:
> 
>   blk-ioc: don't hold queue_lock for ioc_lookup_icq() (2025-07-29 06:26:34 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-31
> 
> for you to fetch changes up to 367c240b0a99c7ada700a44345dd3144a02b6164:
> 
>   nvme: fix various comment typos (2025-07-31 06:35:58 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.17
> 
>  - add support for getting the FDP featuee in fabrics passthru path
>    (Nitesh Shetty)
>  - add capability to connect to an administrative controller
>    (Kamaljit Singh)
>  - fix a leak on sgl setup error (Keith Busch)
>  - initialize discovery subsys after debugfs is initialized
>    (Mohamed Khalfella)
>  - fix various comment typos (Bjorn Helgaas)
>  - remove unneeded semicolons (Jiapeng Chong)

Pulled, thanks.

-- 
Jens Axboe



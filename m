Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F97C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5pA5aIxORn31gOeVUCZ7gdchDq/GlpHL8GDXDDRARI=; b=wg7d+88p0TlDZH+IJxJhUxTDpl
	pBt7nG+C2N32o/elxUCQJW1MUW6yL27koXSS/CdI/Vm65tG/N2HquD2h245qt5huGhIZWGHwjiAeE
	QUSWcvGOtlRfsAppjBmzSTdyz+0hqijx86rEMxFL0t+lnuQru+CKcYVHnwcwwDgQ7Ifsze0V4vPz0
	TX5JaZI76DaPCMp5kJ/lqIOgyNqLsZ+woNB1YhgxG+V7GFKCmECyxWBUfZ1cBcIMeP3NwkNcBXjc1
	4tvxAhpr8u0LSfmCDWYZ0Xb1RujaKzfyRbViFg98SYvRHklUKSo1UDX3GXktEXxkCeI0WJ0ygV7Hz
	vkXB9ErQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nomYc-0071iR-0O; Wed, 11 May 2022 13:39:14 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nomYY-0071ge-LQ
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 13:39:12 +0000
Received: by mail-pf1-x432.google.com with SMTP id v11so2016135pff.6
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=a5pA5aIxORn31gOeVUCZ7gdchDq/GlpHL8GDXDDRARI=;
 b=rKNaL+SS7CnnjaBYAviIhhQI1e5lSwJ33aHBU+S9tGfgmbis4smAzOt86brGwATbIu
 cCO6km0Bx42c7+pjlMBcYUDVwUcYhZonwnH/ALLEFM3XabiOjitGUJ5H5dmfW5SlbS5T
 FaOe8PuXaPUtplRd1QE8uNBQ0kwoNNL1+AcSyHGg/VVG1MsqI7WolEqdDtm6OslubYOx
 meej5SVJM2Y/rR6sYjQx7hV38yG/ub3qcFfLCY7xPEJsXUdPGyi/H64VwHNc2LMoUmkr
 PFKIpOlyKE7WPleNXD6+rOy17rBpXn1atmqxZYbG1XFkMni8ujSZ//szh2LWIWlxGqRO
 mqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=a5pA5aIxORn31gOeVUCZ7gdchDq/GlpHL8GDXDDRARI=;
 b=P0wBtxoKkkmT2jzrkmxhoSss8C5woTqpar1hAjZoatxcRFdVNIMGabXimokCttUrWC
 L9V7cg5n7zZbK3HNt/hxjeOlfzZyZ5MuROmofHrSWkwLfc8nTVXC0ciTlQ1W8lI5NJsA
 i5FDUsJFn2PFOe6+26pgZHdDmUOpGIZUa5mgV1Q3ItFO6TUh5NX/zQFCZ5dZmm29xvNq
 6C+9viRLM8GUKbOB9fVODKS+XFr+MTMBQq+Lmr736dVoFVdrgbgpKWZ2rBGDNSt7yuI0
 IqH0+Vj/3Ss+adc/0aQdx3m9ZUmvlMCPEF06/gx769/c1xh3ZMeYTBG8YzSqu3rybwA1
 RiKg==
X-Gm-Message-State: AOAM5302iLrdiTLInEqYGRswe38B/Fj6ndMPRAEG19jgvfRsiLwXyKGp
 UB0SoCYaHxlF5jGrQG+PsVnB4TrLQQYa5w==
X-Google-Smtp-Source: ABdhPJwJ3MHxH/51EknoHEeEnx5QcTJ8lYf39MphB2xHMd3lorw0Jx0ugjpXflx6o+rMHN6EgpSHXQ==
X-Received: by 2002:a63:6705:0:b0:3c1:976d:bd68 with SMTP id
 b5-20020a636705000000b003c1976dbd68mr21140536pgc.133.1652276347591; 
 Wed, 11 May 2022 06:39:07 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 w186-20020a6230c3000000b0050dc7628134sm1794251pfw.14.2022.05.11.06.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 06:39:07 -0700 (PDT)
Message-ID: <9541e45e-76cc-1b62-8f8c-239585354e40@kernel.dk>
Date: Wed, 11 May 2022 07:39:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 0/6] io_uring passthrough for nvme
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Stefan Roesch <shr@fb.com>,
 Anuj Gupta <anuj20.g@samsung.com>, gost.dev@samsung.com
References: <CGME20220511055306epcas5p3bf3b4c1e32d2bb43db12785bd7caf5da@epcas5p3.samsung.com>
 <20220511054750.20432-1-joshi.k@samsung.com>
 <b7f8258a-8a63-3e5c-7a1a-d2a0eedf7b00@kernel.dk>
 <CA+1E3rLe0QASNQFMwSjOe-xn_JMzrtG416cAKBTdore+hYYk5g@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rLe0QASNQFMwSjOe-xn_JMzrtG416cAKBTdore+hYYk5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_063911_002062_01DA3F8C 
X-CRM114-Status: GOOD (  18.75  )
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

On 5/11/22 7:14 AM, Kanchan Joshi wrote:
> On Wed, May 11, 2022 at 6:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Which patches had changes in this series? I'm assuming it's just patch
>> 1, but the changelog doesn't actually say. Would save me from comparing
>> to what's in-tree already.
> 
> Compared to in-tree, it is Patch 1 and Patch 4.
> This part in patch 4:
> +int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
> +               unsigned int issue_flags)
> +{
> +       struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> +       struct nvme_ns_head *head = container_of(cdev, struct
> nvme_ns_head, cdev);
> +       int srcu_idx = srcu_read_lock(&head->srcu);
> +       struct nvme_ns *ns = nvme_find_path(head);
> +       int ret = -EINVAL;
> +
> +       if (ns)
> +               ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
> +       srcu_read_unlock(&head->srcu, srcu_idx);
> +       return ret;
> +}
> Initializing ret to -EINVAL rather than 0.
> We do not support admin commands yet, so ns can be null only if
> something goes wrong with multipath.
> So if at all anything goes wrong and ns is null, it is better to
> return failure than success.
> 
> And I removed the lore links from commit-messages, thinking those will
> be refreshed too.

OK all good, that's what I expected. I'll update the series.

-- 
Jens Axboe



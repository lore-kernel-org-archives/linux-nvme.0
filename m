Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8855C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bdz5sb/5Bj04wbxfxx7fYOU1+4HLlzIpCd/Rkfte9I=; b=IHNBQGbynIPTLfyFf94/dElZN2
	q0Fmu9XRfjx0PjVwwTQHspahdSUTy1JaRe2vzn9ylCyx8/Zuk7e5jv5FIFDLIwAHainGf3cdJa6j+
	aiN6Pb1n73wA7Kwq6/6JZyNgWHK5CzeFFHKOC78k0KbTKs7RyNqI4PcEkX4UDJZ5GxkO16nkz91yl
	OnJn7SLmg0nuxW6rjXlMCS+5Lu2naz5e1suXjEm5UZffC9pN5XlA2F/+GnrTgnCBGHWB+/btfcpKn
	7xHn1hZH4Xs7ol/WHOQtLQk0OkjOhNgPkz+zjnLASjKAmC1O+NJzhHUmDoO37HqUgs+tX2am/oTV6
	kGL9+Ytg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or5SE-005PFL-7X; Fri, 04 Nov 2022 22:46:26 +0000
Received: from mail-il1-x163.google.com ([2607:f8b0:4864:20::163])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or5SB-005PEg-Ok
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 22:46:25 +0000
Received: by mail-il1-x163.google.com with SMTP id z9so3304734ilu.10
        for <linux-nvme@lists.infradead.org>; Fri, 04 Nov 2022 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bdz5sb/5Bj04wbxfxx7fYOU1+4HLlzIpCd/Rkfte9I=;
        b=MeP69e8r2OE5m+57oxKhLKeFYFt8CRUObDzWDmfNpKTsDigB4OoGdZBIA5s9u2K3zJ
         VTPaFi5VdPyGk17ZjCkA/euD7KIkXiOBTdwcSondfjI+UG5nwOo3UQL4sX0sXj0ELzyg
         E6fXVd0TSbqoRQZtSoOY9uxbKaWBuDXjCsizI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bdz5sb/5Bj04wbxfxx7fYOU1+4HLlzIpCd/Rkfte9I=;
        b=060z6ZF1PMokrk+BAk/s/aXZm3XBsV4YOK1BLabWZFuNErmvBxin3hapFESIql3WcK
         flyrX2lyWLnwSIN9B5/DYo/eNzXMWIKRMqs78rXpt8Q6ezbrB5IpyehB9Bg4tkkqIHhQ
         U0DQBKoE1jX723gT21YTquWwamaPJukrYTGgCmyFdJgzrz2cpejQ1DNa+ODFFKXgCNMt
         K/vc5NuT2Mud7JfKg0hLgpniJrgCskXkChFqBftBMvBcYpgEYkipzHJwO3MTxSWZhcNH
         g2V+Ra08xnTG33cf8k0X2+iBOUWi8nJ0dw/cO1GhESYJR/hFpmRNovWPOHz31jNDt+i+
         Z0fg==
X-Gm-Message-State: ACrzQf0Xfd8F7UX8EX3Zh6p7xeRWuD2HwwpvqMYcgskwWOoE2Zx4VE2Q
	qVq7sgk3aY5jpDTXJQU9EoAxn/f9GLSKA2sppiWPjbY7EpEXOw==
X-Google-Smtp-Source: AMsMyM73iOuW/hF8k860ggpxyv5vht11CscaIhmp0dRldMuPIWad7cOkpDdZJ1cBhLlFvKQ3X+04B6j/pWNc
X-Received: by 2002:a05:6e02:1e0d:b0:300:6eee:c36f with SMTP id g13-20020a056e021e0d00b003006eeec36fmr21780599ila.120.1667601982777;
        Fri, 04 Nov 2022 15:46:22 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id o24-20020a056638125800b003640dc4f9a0sm22846jas.0.2022.11.04.15.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Nov 2022 15:46:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id B4B9B21B0D;
	Fri,  4 Nov 2022 16:46:21 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B07CFE403F5; Fri,  4 Nov 2022 16:46:21 -0600 (MDT)
Date: Fri, 4 Nov 2022 16:46:21 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: scan sequentially only when list scan unsupported
Message-ID: <20221104224621.GA1437924@dev-ushankar.dev.purestorage.com>
References: <20221104223621.1435666-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223621.1435666-1-ushankar@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_154623_825124_F2936BAF 
X-CRM114-Status: GOOD (  19.12  )
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

> Currently, if nvme_scan_ns_list fails, nvme_scan_work will fall back to
> a sequential scan. nvme_scan_ns_list can fail for a variety of reasons,
> e.g. transient transport issue. And the resulting sequential scan can be
> extremely expensive on controllers reporting an NN value close to the
> maximum allowed (>4 billion). Avoid sequential scans wherever possible
> by only falling back to them if nvme_scan_ns_list fails due to
> controller non-support of Identify NS List.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>

> ---
> This would break devices that claim to support version NVME_VS(1, 1, 0)
> or above, but don't support Identify NS List. But it looks like we
> already have NVME_QUIRK_IDENTIFY_CNS to deal with that.
> 
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0090dc0b3ae6..5bd19819d33b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4535,7 +4535,7 @@ static void nvme_scan_work(struct work_struct *work)
>  	}
>  
>  	mutex_lock(&ctrl->scan_lock);
> -	if (nvme_scan_ns_list(ctrl) != 0)
> +	if (nvme_scan_ns_list(ctrl) == -EOPNOTSUPP)
>  		nvme_scan_ns_sequential(ctrl);
>  	mutex_unlock(&ctrl->scan_lock);
>  }
> 
> base-commit: d30a909f9bb5283e701a5fdfffac763ef57a3e7c
> -- 
> 2.25.1
> 


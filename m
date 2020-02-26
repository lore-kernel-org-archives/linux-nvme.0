Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13EC4BA2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7127924670
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAE+4K+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7127924670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iXzLuF/0sKTDcFGWjOEA+1/1KFU4CFtZH9KSMD51TW8=; b=rAE+4K+/b+Sz0ekiO+ZRvX6qF
	dpks/mYxAwTQYsf46uwun2kX8+cEQpOSZc3Hh/cYuvHMU0tC1lwDecYvARBPTo7VXbx9wupSFl4HT
	/zUQD86L9RbGeP0nxO4s5h2HYE6Gt525MFMgTLBZyCJiZ0jEOoCH8JIx0ngsfaAdcXLRwPCVRnB4R
	Zn8toD8KfSHAUdrAOepvq0gVd5CW2DiuWlEr95+iTYPuMrUu1IV9D+9frCdit5zVeh8Y5KJp0YgGD
	ZARyQlzDxXH0OtfMqUWR0VHJv981clAscs0+e3abd2msA8T24P9NJvJimjs8halWy3FpyE3EbWO1f
	uL1I+rRmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j76Bl-0003Nd-I7; Wed, 26 Feb 2020 23:34:01 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j76Bj-0003Mj-60
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 23:34:00 +0000
Received: by mail-ot1-f67.google.com with SMTP id 77so1185149oty.6
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 15:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E9CsIeVCqDRp047URh32XSYQmYRUen+22sX2IooW5EM=;
 b=rT7jWKwraikEU6JhIFjDimvX2d0cG5CVk4bs9HHxSiIwcOgYoqkFgd80ZDpc7f7mtA
 12owuMP/v8r7E6WzlY+HUlzYmIsdfkrfs7i+B3KfGODxTnTd4N1PAaVuP250osd7FEZ4
 PKwOQVDOt7G6qqVKgn18ymCjSTNh2bDilnovwcChDxgTG4wlydzHyu6iWjN8B0e8QbX2
 Tb2ajQbzQHPc4QmWPzRHXZD7EIDuAEYrFiqGjZ7lWFlXkQKp5YO3L2cLzqFOod6+mGhp
 ZvHSL8VPLswbmWZyw0SybfEHs6fbyVRzpLKJjDg0Sq4O6vipwezcYU4As1t3XBs7lQp9
 EA6A==
X-Gm-Message-State: APjAAAXnAT9n6NPjeJ0be8VMZdXjJ3twZD6PBRHQPE1QNupEAjTiyklK
 IDD5D1Aul+VvxH12Y5lkI7k=
X-Google-Smtp-Source: APXvYqy6gtVO8C9So5Lp6miPMAu8Syj4Y8v6QvC1U1iT1SAhjKYksxQym5vUPzUKa2ZvbAm6L0C8Zw==
X-Received: by 2002:a9d:7a96:: with SMTP id l22mr1017139otn.217.1582760038567; 
 Wed, 26 Feb 2020 15:33:58 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id v14sm1309886oto.16.2020.02.26.15.33.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 15:33:57 -0800 (PST)
Subject: Re: [PATCH v11 8/9] nvmet-passthru: Add enable/disable helpers
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-9-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96234649-fbc1-fb56-54d8-2f73dc455ffd@grimberg.me>
Date: Wed, 26 Feb 2020 15:33:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-9-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_153359_224378_A9CA3708 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +	if (subsys->ver < NVME_VS(1, 2, 1)) {
> +		pr_warn("nvme controller version is too old: %d.%d.%d, advertising 1.2.1\n",
> +			(int)NVME_MAJOR(subsys->ver),
> +			(int)NVME_MINOR(subsys->ver),
> +			(int)NVME_TERTIARY(subsys->ver));
> +		subsys->ver = NVME_VS(1, 2, 1);

Umm.. is this OK? do we implement the mandatory 1.2.1 features on behalf
of the passthru device?

> +	}
> +
> +	mutex_unlock(&subsys->lock);
> +	return 0;
> +
> +out_put_ctrl:
> +	nvme_put_ctrl(ctrl);
> +out_unlock:
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}
> +
> +static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +	if (subsys->passthru_ctrl) {
> +		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
> +		nvme_put_ctrl(subsys->passthru_ctrl);
> +	}
> +	subsys->passthru_ctrl = NULL;
> +	subsys->ver = NVMET_DEFAULT_VS;
> +}

Isn't it strange that a subsystem changes its version in its lifetime?

> +
> +void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +	mutex_lock(&subsys->lock);
> +	__nvmet_passthru_ctrl_disable(subsys);
> +	mutex_unlock(&subsys->lock);
> +}
> +
> +void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
> +{
> +	mutex_lock(&subsys->lock);
> +	__nvmet_passthru_ctrl_disable(subsys);
> +	kfree(subsys->passthru_ctrl_path);
> +	mutex_unlock(&subsys->lock);

Nit, any reason why the free is in the mutex?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

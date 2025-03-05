Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA7C282E5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iwOQvwTg5BHs7dRwnkQr+dhmEfDDx/7fnNHWIfQqz+A=; b=ZNGkWdWxziedjhbKa/kEJiFePo
	qhmAUl/tHtREwy1A8InrfIpi6u2vkkeQXxdUHO1VQGhVYLAUYb67NNdX76faNiYxX616/l1xyu5RH
	5YkrCfk7LWuB666YmsNZKs7FW6eV0UqXy0m9pDoPX+0zzUKqkCmGMTFDtvfqXpR7aEcuKFRBI842N
	n2NkilNKJ0H44zeLQ4q+2EqoFcIxtjitkSjhLHfGfXqwT+vqrpIbY0kdIKtZtyIvOTrlEW4pOxN4w
	St2ETm4PIHwDdBxxRoblt1brdlSsIjWomata0w5go5MHYMRnUcDNNciKDieA9NOM6A+qEVDUBQdC0
	Bos19g9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqzE-00000008Yd7-1cVM;
	Wed, 05 Mar 2025 15:48:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppsD-00000008Nbd-33SC
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Mar 2025 14:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iwOQvwTg5BHs7dRwnkQr+dhmEfDDx/7fnNHWIfQqz+A=; b=BQcmGnBkO4aF+VgHvGnQiSMdWn
	Jur0XAnLo9S3ZZb9kCBiS+Y/r1wTft08ZYeUThQn6dUlC5MdDqRcdKP81P+VE0jyItvNVqDU37PtA
	47kBoR1FLHJOVBWp5GSor+qVcr8diYrnoHo361CrrKbgqwBzG1tMPFHoqlHS90wyidSbBW+YWpvLW
	wod3iiyQNuWpBU08ZgNpDd9cy50Ygwu7UwQubK8bi4GSy7XpJ9B0PfeQ9IS+ieWdZ/bB/OATkKcgy
	ZiR14e28KIReLf5zYKOTu6pp1rSoyqKP0DKJf7gtKENMO9PySQRRaCvHm5HJSKOYwoae3XuccwnwB
	BSM9IL6A==;
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpps9-00000000aG0-3Z0n
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:37:24 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-43948021a45so62733465e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741185439; x=1741790239; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwOQvwTg5BHs7dRwnkQr+dhmEfDDx/7fnNHWIfQqz+A=;
        b=fGvk5Uw/i9CwqbLk/RakZClRMFw5Qi9yDw6UtYykM4qn9SWrceyzZmDsvhJmUYrjhA
         s8Juo5S3T9QFDsHPsL7TCm/35lwkNilN5RVQBZCjKh1h9rxEr+WN7hSPe+fd6qzeuCBh
         SwniLvAXhuOdHoMxSVwA9h1hM/TP0s95rGfFRMtHQhY+EhnAwGfLVLdY6yfRFst89II5
         DXe4UpHrYFUn+AH+pUsUW+LOqwVF/GtJnDPAr8ERddpbtoyKQSs8Yfz3pMscIBmThSS2
         aMa1C1HQRo2NumrsYemHeegEyGQPq8lAH/lmdV7d2NrsFyUu+VahtJUwcabiCSmgsicQ
         w3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185439; x=1741790239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwOQvwTg5BHs7dRwnkQr+dhmEfDDx/7fnNHWIfQqz+A=;
        b=rWX5f7nx/n8dvG8ez7M6usmshFiwnntuoYBSxgA/GHKO3P3Fyy4RamwliDymDzvDk/
         SmJUd1DbzUmet8OZ4s9ESDyYxOdlOh2ZS98MyBECOOQw7UNe1p9MJ9VJHEa2o6ulBEny
         QVnzMzlYV/BOoAbeTwLOzKmJUYd8SXFRp6aQERcvTfj1/4w/Ro8OTVwnoVy1mqs71AAn
         FIkLllfuhnLnt/ZpBJ4mtn7rsj9/lHlej5CX+UfVAMGpW5WLwex4zfGtdbsWuqgSzwO2
         N3CgaG7/TgqjKgs1zYkCvPk5tOAjfGIqS+mY8vSuBoV8pm5R3pbZztu8Ewnyg0Ne3V/F
         YyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2P/gckFSZ6JYbrIM/6rjJaNT8rmeahC+akFD/oKrRP+kmJQtVVr0A9hQqTsF8ouU+fLkCBKnsXwCu@lists.infradead.org
X-Gm-Message-State: AOJu0YxUxWrDLo/u93J+Nvz2tNQWE0W5iK/sg+2/m8/vTMDQmWM9Ui6M
	Qkt8xrHa6veTrvv7v6aX5OQKFHFMLvgDEtzdKfZHCwKIlnm+3wWfV7O8y2IE0PM=
X-Gm-Gg: ASbGncvEhj01DXJTsi6vXqSgvKnaVT7Efq7vegsoJdCKFkgbk9YPgFcn0Xj4MZ4ZfuE
	1/VHXqM9fxh1ERDuoyyUCRx3RC8e37CEtJjTUxzRdKOBG55btLMLdzXzvZvAbiZTbilNmbEYlK2
	DlBhMXpdMkjFGF3421D9w8ik4lxHoY85e8adrSP5cK++jhbHHvRAxwcrbZYZFAVPNflwIY5RjFR
	h/2HHnBP2E+jBeBFqkeukPQyXM7HjlWRWX9tQOC3ZP2gbvSZCY7DImp2S6DOwLmcMFZ+47yk1lh
	V21FloAAepYprFsI53wBS3S/4HL2P96qO9aL9jQ070AC9CdbXQ==
X-Google-Smtp-Source: AGHT+IEMxeY9Q/Lqs9IN5AO0arzXvUgn/JnK58WwLTaOCw86mTQyFLw5mdcoyDfgg9Sb1o7X+y2SwQ==
X-Received: by 2002:a05:600c:a40a:b0:43b:da56:4d57 with SMTP id 5b1f17b1804b1-43bda564dd8mr1635005e9.10.1741185439498;
        Wed, 05 Mar 2025 06:37:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485df5asm21429993f8f.96.2025.03.05.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:37:19 -0800 (PST)
Date: Wed, 5 Mar 2025 17:37:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <739d3443-61c4-4b69-866b-142efde59062@stanley.mountain>
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
 <20250305142554.GA18330@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305142554.GA18330@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_143722_005234_BDD1433B 
X-CRM114-Status: GOOD (  17.08  )
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

On Wed, Mar 05, 2025 at 03:25:54PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 28, 2025 at 12:39:41PM +0300, Dan Carpenter wrote:
> > index 8a9131c95a3d..361b04ec5b5d 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> >  	msg.msg_flags = MSG_WAITALL;
> >  	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> >  			iov.iov_len, msg.msg_flags);
> > -	if (ret < sizeof(*icresp)) {
> > +	if (ret < (int)sizeof(*icresp)) {
> >  		pr_warn("queue %d: failed to receive icresp, error %d\n",
> >  			nvme_tcp_queue_id(queue), ret);
> >  		if (ret >= 0)
> 
> I hate these magic casts.  What about something like:
> 
> 	if (ret >= 0 && ret < sizeof(*icresp))
> 		ret = -ECONNRESET;
> 	if (ret < 0) {
> 		...

Sure, I can do that.

I don't love casts either.  I normally have tried to write these as
"if (ret < 0 || ret < sizeof(*icresp)) {" and people don't love that.

regards,
dan carpenter


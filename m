Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD5E7717D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 00:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FI4OekMx89+rpVFZQHKVqiWtpaXZ7Gf7NcsWVZ70s9o=; b=jGyGOVNqU76ltRS9fGNRdqXdsj
	nBCsCwfzQ9qV/67I+kmW39fa/sGMFN11o8saNSOY0UvrxpGwle0OamFBdsFbhlsTs5fz24P9GL5lZ
	5HwB4CVo35q+qZhiwD+JhR2kr0w3nAksHDxeSROwLFHUa+eUlDECgM3duiKbhozlBIcS85f/GTSzI
	w5OG39iKnZ3Tkn5kRuDnrW7ifZxciqTV1/aSymhS0F+RnUhi3TcVyX67+5aSp12NH7qnjn63rwKcp
	KVcCdB4HhK6tGU6VEy0xbHUSkMY+qq2GqUsjPoU468KVFHsiPgmXT4jH3xZq21HhgoCWmemYiDPkm
	MkN/xY7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKoFR-00000009j0L-3kvN;
	Tue, 10 Dec 2024 00:37:09 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKoFP-00000009izu-1iEf
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 00:37:08 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-725ee27e905so1735883b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1733791026; x=1734395826; darn=lists.infradead.org;
        h=content-disposition:in-reply-to:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FI4OekMx89+rpVFZQHKVqiWtpaXZ7Gf7NcsWVZ70s9o=;
        b=GX5K1FgP5rWuEiQEBz4L9iOdiTOX8Hbg7ol/Wm/Q8zTfAKp51fysVTyzbFFUpEhCoh
         MO9ddEp41ORdXMClQvO/ZIU92btco8i8IXLo8NRb71L/FD+JMaTw8HP4ReMq5Uh6qJ/R
         bt7NKqSoLirZUAzhlbINSUHJTJZ7nBQLnvHJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733791026; x=1734395826;
        h=content-disposition:in-reply-to:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI4OekMx89+rpVFZQHKVqiWtpaXZ7Gf7NcsWVZ70s9o=;
        b=dM3G/WDkcP7wBSogr5PjkGiqBJH4QEvEiAIyqm3dJAP7g8BhH2BWmCDi7zypNmXqxD
         qLpsqqGxPC/Q8n6zjP6a7Q+dz4g9KQ1UU306wbb6Lee5ty+DR0HZfmhC4pUmGeAH1HdY
         Desbul0wR/VwPhF8tZTs2noEpkkRXWYVajnYB/vKzYNkNt8Ey3zRcztVDO2w7Ld0YtFM
         gCQEEHm0s/kV7I8x9yynGzEWyIs8FZW6C0lb7V9OzuCcrnBeJQfbo7OGngOu/XecCQIu
         2B8PRox19MfOLAMstuaIWJeAhSNKTHCLLAMJNJA3VW7ad1AiYVL1rnXkpVenfCZC62gW
         mT+A==
X-Forwarded-Encrypted: i=1; AJvYcCXM1RDjul+M7xIneRLrMs/mKsKVB7sYRRuj2Q6O2VdeBr3M2D7qOYLmtYoNHK7wMjnBVnfV5/K86CI+@lists.infradead.org
X-Gm-Message-State: AOJu0YxpSwX0uVadvbeboF8PfMCi4A38j2/aFBZMen7LQDqSPcOESKV6
	r0OiXCrjowPIQBQtUyl6mKa4yU8wySrwlAizR1WbvaE2dHsgL7hR4JPOWCH4YIhmwCuUs+r/Dl2
	MQW4KvUZsnvbbohI4Jx7//NH6WrftZAYlNmbCX0N3ASOp9re8jwoRiHP/UA==
X-Gm-Gg: ASbGnct3AffzqhZdUtvkWXNBdG5H7nRmmOzPFXMXaW/1+HGzVYAJb71w9HO/rARMBko
	z7BdN5XbtDF5oU9jxl+SMshGQHcWnGwoKa4pdp2HgAl0SC+13vm9MTXvkYWnRbN65j1lUuyGQku
	q9yYC2Hab6VANibmcz/wVszu8hBFQsk0yrphOmvxKeoryGwbVDOCZnhwouWl7L69PPa8u40BCgu
	gY9cvZ/nc4XMAO0OBzN6rukvV0cK2MwGvKhZslwLJ85Gro=
X-Google-Smtp-Source: AGHT+IFm88qeRdkvOMho+gDmEVsXVjkldJEf3fLDtwk6cBXvx6LoOjsHQO3HuC51SqFOJGdzQFHMYA==
X-Received: by 2002:a05:6a00:4b50:b0:725:df1a:282 with SMTP id d2e1a72fcca58-725df1a17c6mr11652180b3a.10.1733791026471;
        Mon, 09 Dec 2024 16:37:06 -0800 (PST)
Received: from ubuntu ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e03ef67dsm3827175b3a.124.2024.12.09.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:37:06 -0800 (PST)
Date: Tue, 10 Dec 2024 00:37:01 +0000
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: change the return type of nvme_poll()
Message-ID: <Z1eNLcVokPHbPKrn@ubuntu>
References: <20241209133343.125885-1-ysjoo@kookmin.ac.kr>
 <Z1cQXGWGRZ5dcWOW@kbusch-mbp.dhcp.thefacebook.com>
 <Z1djnrzTvra6wyMn@ubuntu>
 <Z1eEwms3ArQBNHE-@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <Z1eEwms3ArQBNHE-@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_163707_451531_A5FA1672 
X-CRM114-Status: GOOD (  30.49  )
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

On Mon, Dec 09, 2024 at 05:01:06PM -0700, Keith Busch wrote:
> On Mon, Dec 09, 2024 at 09:39:42PM +0000, Yongsoo Joo wrote:
> > On Mon, Dec 09, 2024 at 08:44:28AM -0700, Keith Busch wrote:
> > > On Mon, Dec 09, 2024 at 01:33:44PM +0000, Yongsoo Joo wrote:
> > > > -static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > > > +static bool nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > > >  {
> > > >  	struct nvme_queue *nvmeq = hctx->driver_data;
> > > >  	bool found;
> > > > -- 
> > > 
> > > This function is registered with blk_mq_ops, so you would have to change
> > > the prototype there too, and every other driver that also registers a
> > > poll op. Honestly, it may not be worth the effort.
> > Oh, I overlooked the issue you pointed out, which brings me back to my initial 
> > suggestion. The function nvme_poll_cq() returns the number of found CQEs, but 
> > nvme_poll() seems to unnecessarily reduce this information to a boolean.
> 
> Can we just change nvme_poll_cq() instead to return a bool instead?

Thank you for your suggestion; it makes sense to me. We could consider modifying 
nvme_poll() to return the number of CQEs in the future when specific use cases 
arise. 
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4c644bb7f0692..54910f8eadff8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1148,13 +1148,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>  	}
>  }
>  
> -static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
> -			       struct io_comp_batch *iob)
> +static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
> +				struct io_comp_batch *iob)
>  {
> -	int found = 0;
> +	bool found = false;
>  
>  	while (nvme_cqe_pending(nvmeq)) {
> -		found++;
> +		found = true

  +             found = true;

>  		/*
>  		 * load-load control dependency between phase and the rest of
>  		 * the cqe requires a full read memory barrier
> --
> 
> > A minimal change from "bool found" to "int found" in nvme_poll() would 
> > preserve this information, allowing any interested researcher to make use of 
> > it. Also, the description of poll in blk_mq_ops can be expanded as follows:
> >        /**
> >         * @poll: Called to poll for completion of a specific tag.
            * @poll: Called to poll for completion of any CQE.
> >         * Returns the number of CQEs found.
> >         */
> 
> Since you pointed this comment out, I see it is from an earlier versions
> of this interface and outdated. The current behavior polls for any
> completion rather than a specific tag.
Oh, I see. How about revising the comment to "Called to poll for the 
completion of any CQE"? Do you think this change should be submitted as a 
seperated patch?


-- 



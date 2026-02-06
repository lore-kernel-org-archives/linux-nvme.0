Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F0CEE20A6
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=; b=Ix4eXqA9fQHDSzYxRsOzaW1Fon
	IBHBR+PcEsRztpLQD1X7WrbovWq96eC7IcP1XphzrGyIg9DqOpFcQv0RipkEtqM8E0xPZqjMVqUM0
	bE7Bc/1jIq4hFMD4NsM2NJXG+XsiXAxAoCI4sepoekYPyw9y9XfkjzP3wjahGtf5ucDmVPwNxy/Y/
	qTb2oLndLNxmJkRtUB/Una2HeSsRWw2S7zXujGfkAvoWLnZnNa5/j5NWKcapBXTbabU7pfD6GxMdK
	KH6D/kVsNhDyxvygvaqv+2cbinIaiOvE1I4BupTAjM2hLkuZiVKCSD9e8tOPJgh5MDyrtqmSSebhK
	fJvmk2Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNMw-0000000BSwc-0dXB;
	Fri, 06 Feb 2026 15:03:38 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNMm-0000000BSwH-3eLX
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 15:03:30 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so2950063a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Feb 2026 07:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390206; cv=none;
        d=google.com; s=arc-20240605;
        b=TSg4RAQJNrpbPqhqx0YGCW4QTCeZIzO7QrlHd2DplcgUr8tvThdIJramfGYueNVFM7
         1PtjrNBol9stxvXHb/gavHsPLAsQpLGcssdQlM2mLs3GkSTxpI0wdBArbiSVozve9slo
         xQJHirtCDoNarELkPmCowGESFMHlkjQKXn/FfxNMXaX07UGMg0MYKvfysM+tM7mKT+D/
         GYRPT3TYY/rvKgHYcaWxl4xnlGQxLvT83YSWqZTfh1shkolCVRVZvA1L5xu+ulJjcyqF
         yVPkUzolySUDpPeWY+2wzGVIay6RoeQo9uAiwnYmxYSzcFflyh/Fi3NfPWCVO5QiQrnH
         xIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        fh=w6qsxdryE10wLV4TAzDS5FNXZoPNmz8CcJ/ZJkaqKEo=;
        b=Llp7/MQ76o8b9TlgStVeoeyUaFqpFNMEvDGdSM3P5BsXRQzLz7+muIOV2RH7dEXZAo
         Aw3A5G/1OjM6sYkMi/mg1aLLwUIqNusEsYCuRfPjxJlMcvXjdqjEhoMnEAz5IpK5ynqp
         xM/XlLSOd1p/cIXyV99d0fB101C9komvnjhLZ8Y4fI/faTZhK33TCspfYcSruCjz3Byq
         0/wXl998xZVVXR0SJ3yff5UyKHTMXVPaO8PQQ6uYzM2PGTU0PxIhxqOhUPfwwN7uj1dd
         zCEL5qZr1tgVSu8qt1vdbBfN6oQ9AtNQxjpYCr9zJOvD9uDXshoa2SF8DzEpNPXSSRN6
         96mQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390206; x=1770995006; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        b=IHALI2oyNoo6gBtv+bZIEjgv1VCO2HaYB6O9puB8sn5m7aGE+GQyp1KWIMro4JBOd6
         iEg9TSoy6t0nsPlOrr3pM20Ai+FuX+HKN8kqUvT4KVEKzUUQdgZyk/HLse9pQEsTKud9
         iBvqpCcopDq3isCjpnJ3cSxY2TzGqJoYABVtm5Solghp3uyPY4LqECerBh7a0tLUJyTd
         9syVsDhn6vqqvXpMDtFuBBLSGIQN6ExHQ397aYZ2twAxDszFFnFe0Fadi6DoFH5bc/IW
         8GrVFfdgqVlsIzmkqcjp+hQt4uevY6CnNVKgR1ioSv4jdy6+UdAj0VkhtiaF1U3zVfnf
         8klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390206; x=1770995006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        b=IMkWmZKQnKsleFheRJh7GwHEcPAkELjGBltqkku9Rvy+CGOOyyG3cqfq1ZPr7F3Ojm
         R7rZAQGfIdQ9x/xg2pAdAVm/9EmHxvztVk09wNfwysaR4UxJgFeGtz2srR6Ntd4H9v7W
         yi4qRF/qGWOvTZlb5ljxyQQpd6qCGbu5rk7cDZeg69Da6EAKz9ZvyNAWbCvIw4QsPtyt
         LAlMKQc8ZAyxGJvocSFjhmJQyXic6GuWpcd+fjce52r9uXwAe7HVDweu11ZW9/WY7Q3a
         LQ0TzJw9bvrGPNrIqjuhWsZxT0U9Iw2RuvXsfXaSLZHJJ8HEUWkZqoxiVHxr/JwPHnZU
         w48A==
X-Forwarded-Encrypted: i=1; AJvYcCVO16dp8H78dJLwetmCP85fqIusEP+s46RWCys6I9nTdgqonfLTmPMs1pzU7sbCwl0qQ4yOsBEbpqI4@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ2B/0FqB1OWRAw49zy5RhWO0rlOJ1UM18Z1HnHspvY8kBcnWS
	U2AgWPqy6E8CYRlwff4DI+EEBwlPHxIqziFsDUlp0fi7joVkvF3If+iCMaLREdI98VP7KGBA54y
	DPYTGhU3W8trfSmvbr9iGd4RWsxyupw==
X-Gm-Gg: AZuq6aK/A+Fg+zGLe/7fUuuUgS0Aq8wDJN445cLQib+AHBzASUrCtpGITJAMpdDGNeL
	0Pin1s+0T6v6CWpu1SKUqprfaF++5YNBqb8FXd6s9KvRiSZtBscbJukeQeDHMrsIidByTyzSmS1
	SoLtxfzPX0OR/2ZDtmVZQNxg73CHgGBW1sdXXIH+CAQSPaxIAkMWzRcjO6qYxDw3m/4xQkBD+14
	qN6NFd1HjePsW8St4a8ZZg6eMk3Dnb3udxu75rhFrCYWBiYAJlZ5kImeaPQva8yhJaSjXJFDtWC
	yOy0JGda5J5kr9nEafhOoTa6XlTY8ZMlNs4IHJwyYp/1i4D9GKmIhBVvwQ==
X-Received: by 2002:a05:6402:3583:b0:659:4383:c491 with SMTP id
 4fb4d7f45d1cf-65984193946mr1569160a12.33.1770390205748; Fri, 06 Feb 2026
 07:03:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:32:47 +0530
X-Gm-Features: AZwV_QgZhDOY8h13FRDtMZqnV6_xaqir1VOWq2MTchb4BXyrN5R68VQhosU9bGY
Message-ID: <CACzX3Av_g5g=ssfSjHzkosEj7DMU=+xY5fpdU-zYGYc0cUWPSA@mail.gmail.com>
Subject: Re: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered dma
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_070328_946708_023F7D27 
X-CRM114-Status: UNSURE (   9.71  )
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

> +void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
> +                       struct dma_token *token,
> +                       loff_t off, size_t count)
> +{
> +       WARN_ON(direction & ~(READ | WRITE));
> +       *i = (struct iov_iter){
> +               .iter_type = ITER_DMA_TOKEN,
> +               .data_source = direction,
> +               .dma_token = token,
> +               .iov_offset = 0,

nit: iov_offset is getting below too. can get rid of this one.
> +               .count = count,
> +               .iov_offset = off,
> +       };


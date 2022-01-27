Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C821C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXUUPQa1aUv+YBHhpXUraTxpOw9EvSTI8Y9qQN6SCis=; b=JCwdorZWNe3OM4Ael6Ckxv3B4s
	FzjxOgsJLQiblkXddHttFwLwhwZMbmTp/X66uf3Gsi6U5YExCvroEZEkz+wd7mrgPTLIuPzRtfrKG
	onAm3M+W7SOAB0fDIuOlUSU2EVrEdsjbemWWN1/tM1V1OxR+jwa4Vcvps98a/Vr8Pc9KwBDPm7Yu8
	gZYbThNkJEUHuJQyfQ6r94zBXCdsCdgsnHwaw5BPQ7mUyL1GVQyZS2o9I8d5SOdb6eLFO3T+YzFRO
	VzaTKRaG9d+sbTa/Xg0UegdUJJPjgFVDZ+zMOHqi9ggdErHOcR825okL3jM164orpZzS5+UHsOoYV
	HtPbR7cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD60W-00G6ss-QV; Thu, 27 Jan 2022 14:44:16 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD60T-00G6rQ-HU
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 14:44:14 +0000
Received: by mail-pf1-x42d.google.com with SMTP id i17so2785340pfq.13
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XXUUPQa1aUv+YBHhpXUraTxpOw9EvSTI8Y9qQN6SCis=;
 b=Nz6tExmq7RyTSsHC/6qD1f1o4nViCCtTuKQFK27QzpkOPANQB2MqT1LUhILQue8adp
 llmNpcEWpwrYNxj01XYateYIsqVJNInOoL3JDYxMARIp5Td8Rw9WvCWcyDk70MBOcjCZ
 NRNm8+N06Au3lu3VSoBrqtXivtPkMVES0CthJG5ZIwvNrhhBjZcEnC/9L8EtlC4RSQTG
 PriUaFABeUrtG1OFH+mFEqNzErkzw29Jf79HrLJ0r43UyDz7LNkgx2ux13yi5MNn/bCU
 XcyTB1N8n2dMfCaxeyghUvDjzdFhqZ4fM2NkUd3cZlccJ6bATJHIJ/+NjrO0gwif6r9s
 gfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XXUUPQa1aUv+YBHhpXUraTxpOw9EvSTI8Y9qQN6SCis=;
 b=fjUNWFHHB5b4jF0pHmrsmhK9v9aF/8hhnbVMh2FIYPougUTdg190sVPTL6EOcTCLu4
 qdoV9r136ARpEvCzCirOXi/daf4RkwuZxC1D5h1XsizsGXpA/R3PF65SGDwPS6/heC+b
 7XsoKb2+/ayJqLTYRUb72HsLFG8MHG8U+x3qa3mUMpbFlfzIMhFoaDkGeGEMZ89dY/bw
 UVVfZj6imZI06ykM66Bk2BImBfEOKfdNmEQqPVHZ3mL16kTxBKAN/g4IXlYRfEfvhKZb
 nn9Uvz2Ho47cdML9S3ax38KBJhA72ON3E6nvrBtmx6J8JIGwDAzNd0PWPOJMJkZb8TVg
 UVSg==
X-Gm-Message-State: AOAM533HTI/dJ7p8gO1qHX2wndU0PqCPA0mlLQuBdC3fI4tSDj79M6/S
 nA2haGLNO3cKVMuJ+wYebKPw22+tYoZs0sdbHv4=
X-Google-Smtp-Source: ABdhPJxWzybUYiMCznLtPeYdZtDVjf2rDOfAX9Rrw9FX8v6dAynvxlT2Ud9pJ95Cf5o1uUp3soNb7gIcInF0CGbVFCw=
X-Received: by 2002:a63:6cc9:: with SMTP id h192mr2920360pgc.486.1643294652441; 
 Thu, 27 Jan 2022 06:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20220127082536.7243-1-joshi.k@samsung.com>
 <CGME20220127083035epcas5p3e3760849513fb7939757f4e6678405a0@epcas5p3.samsung.com>
 <20220127082536.7243-3-joshi.k@samsung.com> <20220127092921.GB14431@lst.de>
In-Reply-To: <20220127092921.GB14431@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 27 Jan 2022 20:13:46 +0530
Message-ID: <CA+1E3r+tZH4AtnHduTTZenbJTzn1pC9HuDcYNaZUVX4+umyk5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: add vectored-io support for user passthru
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_064413_599944_E6C41671 
X-CRM114-Status: GOOD (  12.00  )
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

On Thu, Jan 27, 2022 at 2:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 27, 2022 at 01:55:36PM +0530, Kanchan Joshi wrote:
> > wire up support for passthru that takes an array of buffers (using
> > iovec). Enable it for NVME_IOCTL_IO64_CMD; same ioctl code to be used
> > with following differences -
>
> Flags overloading for a completely different ABI is a bad idea.
> Please add a separate ioctl instead.

Hope "NVME_IOCTL_IO64_VEC_CMD" sounds fine for the new one?

-- 
Kanchan


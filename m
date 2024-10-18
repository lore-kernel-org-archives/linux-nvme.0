Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E370D30019
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kEmzdJ/Pc8ND50WdJniLJozPO03McgYyB0Bd/e0lB0g=; b=eFR6fK/E1PhrOLeBG/VHREMuI6
	2qcpQ3KoF4sAfW/YA7l+q2aK8bXvA0fM8Z8X3ogCm+BvocQvLYwlhl9emodYMg3V/nFbZf+FFu90x
	AGY0jHF+GV0kreeqaZ4SzN5tKpj4SYKoH/m3cquUcP8PuiZv435woeD0fM1aHA6tSISwQiFtnEQ0y
	qpVy/eG8lu861vXi9YJFdwehWqMOFZGTzXOw6Aq/EgFglHOj1ZrzSb9Oq7xiohwx9jHQt4fVofM6D
	p5DvzRVTepXcpj0jOzHv2dCQOzwUt8c23zigqFxMEF8TLLdXeGn2Pmog6dNxW7w6wE8cX8/gs8QB4
	PuL9vFSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pZf-00000001J4c-3j1V;
	Fri, 18 Oct 2024 16:11:35 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pZc-00000001J4E-3LRB
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 16:11:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XVV7l3Vzbz6ClSpy;
	Fri, 18 Oct 2024 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729267883; x=1731859884; bh=kEmzdJ/Pc8ND50WdJniLJozP
	O03McgYyB0Bd/e0lB0g=; b=2uVJSzJkdlwNEqOpx9tmSMH+CPOezCQCNAoiyIPi
	1U4b3IoNqFGi9NwxX+k2z24xxT4cUiEG98zI4htS4Wu59EwlBVDHr2xKdM3bf1eR
	4EF2hGtuxBvFEXOWIbpGA1nZ/FolbIciC/JWngD0YyH9NqbhVYuvTQo+XYB/wO+Y
	07AMTmLBf/cw/tm06LPqfLBPiRa0rFJiAZHzcJLT3FeC7T3Gm7c+RJVPHO1vU56h
	XW2PuHZEypIQPAVHM3M8NGfZ1h+llopdNalmX5Xs9jrRbDTMH4Qw1BJGB+mUJ77t
	2mC06KRXxRlU1asJtRWoNw7Bjp6PGROMWkF5yir2fg/7+Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dCHz-rmM4GJs; Fri, 18 Oct 2024 16:11:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XVV7S1wb9z6ClSqP;
	Fri, 18 Oct 2024 16:11:13 +0000 (UTC)
Message-ID: <09e672a2-4421-4637-bfdc-e1c46af4d0ad@acm.org>
Date: Fri, 18 Oct 2024 09:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-2-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241017160937.2283225-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_091132_904061_C517E5E9 
X-CRM114-Status: UNSURE (   9.56  )
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

On 10/17/24 9:09 AM, Keith Busch wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c15..04e875a37f604 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -370,6 +370,7 @@ struct kiocb {
>   	void			*private;
>   	int			ki_flags;
>   	u16			ki_ioprio; /* See linux/ioprio.h */
> +	u16			ki_write_hint;
>   	union {
>   		/*
>   		 * Only used for async buffered reads, where it denotes the

Why 'u16'? Shouldn't this patch use the type 'enum rw_hint' for 
ki_write_hint and shouldn't this type be changed into u16 in a later patch?

Thanks,

Bart.



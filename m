Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84498C636C9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1689E613C3
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1689E613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLMmG2cnb4d3HJ9SmvfyAB/HUOmvVQ+7G83LNbxt56s=; b=GsgeS0Saj6XFdn3s3DRQ4olC5M
	qRawVaq2qZ2RZT1/aoisoiVrIm0L2wCb90OhyajCyymS9szVFmVTNp9u+Zsxv1QaNN5VoyCTFpJND
	aHSP5GtmiNvBGI7/doJW2tIuJT5MzKasi3mAtZayAeshkofQCIVSxcWdkAR9/QqTNoT58pzv7ANGm
	+L9ngKSDqb0DhqoJxDvsDEVvECThU78WNzx+a9hS7nuMYSdbinroBd+7wVaNonrFqqovEIyWEth8L
	i9Y+oyhA9o2uPT4wuPxCoTZGMs0yXp9dZg0t/+Ugwc0dn+kypvyycIWvmbJEinQ43O3/0g3F5W3zz
	SqcK5ZYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4dTY-0061vN-Lq; Sat, 17 Jul 2021 06:07:00 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4dTJ-0061v2-3n
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 06:06:46 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 b8-20020a17090a4888b02901725eedd346so8318797pjh.4
 for <linux-nvme@lists.infradead.org>; Fri, 16 Jul 2021 23:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iecH09b7HqGULzKRar6QvP6MSKtrjyPzZdrhashSeis=;
 b=WjwPbkfvOL+Ud7vxsyLWVXqBrsJKQfwNOEr7CpAlKcxFsjpRViR6jsSufSi55uNa+N
 I+BIbekhnfGTb8Yy19DWGGh0pAycxatnWVqoYoAj2KWxkZpk6KWEeRQJaLnZcV+PAWwK
 zuyTA0/HRystzou5LQ0QI1o7xsRtdXgBWt3hoW01F1tQTrqzcPVa8PeeZDZzYatcYfIt
 7Y5dA9kYRjIV8285UNZCy2CfuKsthQM8G2qi/GY8XNEEdlnsshTqpHI3uagqGD85Ghlu
 3C1b4OsImEHStE1rB3VRIJCO1tnveVBRMy4zIr3WRG72J96Z7A57UFqBXl1XRjXvPZHT
 e9cQ==
X-Gm-Message-State: AOAM53307GbuDxALJO9YfzlpQoE36aPSrfxflKumq1Gwvo8vkwqgPQza
 We1ubyR0MpjxKjSRbBCEj84=
X-Google-Smtp-Source: ABdhPJyVeqq48WLZr9OvVk5En15/bxWx6SqptqJJP7c2a8W5YwU+1ppbmHvvGq3jE5ISGqtGX7r9Ag==
X-Received: by 2002:a17:90a:6d82:: with SMTP id
 a2mr13433583pjk.150.1626502003218; 
 Fri, 16 Jul 2021 23:06:43 -0700 (PDT)
Received: from [10.0.0.146] ([162.211.128.122])
 by smtp.gmail.com with ESMTPSA id y1sm13263460pgr.70.2021.07.16.23.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 23:06:42 -0700 (PDT)
Subject: Re: [RFC PATCH 00/11] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <64771d4b-38e6-6081-dadf-cae0de44c591@grimberg.me>
Date: Fri, 16 Jul 2021 23:06:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_230645_268259_DDCB5FD3 
X-CRM114-Status: GOOD (  20.25  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi all,

Hey Hannes, nice progress. This is definitely
a step in the right direction.

> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit especially
> for NVMe-TCP here's an attempt to implement it.

Please call out the TP 8006 specifically so people can look
into it.

> Tricky bit here is that the specification orients itself on TLS 1.3,
> but supports only the FFDHE groups. Which of course the kernel doesn't
> support. I've been able to come up with a patch for this, but as this
> is my first attempt to fix anything in the crypto area I would invite
> people more familiar with these matters to have a look.

Glad to see this turned out to be very simple!

> Also note that this is just for in-band authentication. Secure concatenation
> (ie starting TLS with the negotiated parameters) is not implemented; one would
> need to update the kernel TLS implementation for this, which at this time is
> beyond scope.

TLS is an additional effort, as discussed, inband auth alone
has merits and we should not lock it down to NVMe/TCP-TLS.

> As usual, comments and reviews are welcome.

Having another look into this now...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

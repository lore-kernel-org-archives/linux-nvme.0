Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qRF+VZpfEmRbJMHAgGIrZAT75pNmIgAmizw+wtuOwd4=; b=foPOPS/nmoI7GX1nBfKKKdSImv
	oOjpiBm+3RAgba99QbBrjiWFWtawlIWRCfHK7r8n8LJsrf5XLG+fDwkHm5v0hcPUzt/n0iC7NqmHg
	buuGj0XOPxpVvsIzvwbkVvuPBzRY2GA9Z+Gj9UIPI3ZapLZb1XYNx5qgH1wQ6Y1exn4/wN5NOnGaL
	yvO1CQwy+Q2UG/dRURmSmbRRTK4LH61cBljt6k5UGMiOdtioTIVz6s4Vg1nDmCFndjsDJqlCL35nU
	Iq0iB3qC6wl/0xNQ0RSP7LszKzVn7d/kroKAfZTDl0o3Vxnqinl0MzMKQKeLaWITFiKGm3t3ilzEr
	CL7lGoJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSIBZ-00CpWs-Jp; Thu, 10 Mar 2022 12:46:29 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSIBW-00CpWN-7d
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:46:27 +0000
Received: by mail-ed1-x533.google.com with SMTP id b15so2711056edn.4
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 04:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qRF+VZpfEmRbJMHAgGIrZAT75pNmIgAmizw+wtuOwd4=;
 b=BkXou2coQLW2BePyxpmPohHHewf1babgTbdDbTk6tIQyA7Z1c8+0lFkFEtjFFKnOs4
 is/2tt/Gd7D5WHJ24HY3n66RzMQTY95RdTfSa4mmMFmTJZxytkOMqaYgTFad4nN+yyN6
 BkV1ynKdaaJKDbMc0jOGGa2y65noZsEXKKc6A3yVqIl4KVQFu9MAcaB63a0x5c/0hEt8
 EvgcesruR8jC43fGzNnDBGY3JMX9mETHSzSTDpveJlY2MpYWckwg3WRZQ2YK8v4JzsY3
 Bv63iN6XX1AuwpelJQboLN7GdyImbdh722F594C+pxqueHLPmSKjAS2FFcW+Ny9akhod
 MOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qRF+VZpfEmRbJMHAgGIrZAT75pNmIgAmizw+wtuOwd4=;
 b=bXnqjKpnpf3XIjoFdfAC5v0tiIhDHqvOL5rVOxAvoQ5AgqnzXqcC9iZTVLc6/vHu15
 4jUjYhWXBq4FBDJlf1YMAfr1COUAySugpVuLwlmmTEl00mry9r7GjfURl62kko6tethZ
 gdjEnlfVb06Nu6Db5s5epGhmMlbOoUrYqFpsPQA/7RIrmDnrAqRRCoPHC+5N6tXYjqh+
 r3aSeBVJaMujzXzML7lCWWCwExh4EQXDZ4/BRVZvgdSqb4NA7roNDOvxM1wVyIqrTQVR
 +DA9UKQInPrt5SloejWpgEmiJS5AboEHJ1HjPoc6yAuuwo22O5JUf4Hbz+9Q7B29vFuS
 JMmA==
X-Gm-Message-State: AOAM531KJq4lEyc0HwN5nP05cWSCqyixTBQny5kp/vfXzLA4xDAx9tGT
 rfUHIZhr9713mW+/sGTmvzU=
X-Google-Smtp-Source: ABdhPJyAdyNauASvxJIWPmUqonMmFHPUN2vlGrSB1And4f+44FJMTp3BB8vaI/l1+cEfoQlub909Lw==
X-Received: by 2002:aa7:c982:0:b0:416:1dd3:7704 with SMTP id
 c2-20020aa7c982000000b004161dd37704mr4212120edt.69.1646916384386; 
 Thu, 10 Mar 2022 04:46:24 -0800 (PST)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98?
 (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
 by smtp.gmail.com with ESMTPSA id
 p14-20020aa7cc8e000000b0040f13865fa9sm1969289edt.3.2022.03.10.04.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 04:46:23 -0800 (PST)
Message-ID: <9a019440-98a5-983e-0fbb-ef9bed0193a6@gmail.com>
Date: Thu, 10 Mar 2022 13:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bart Van Assche <bvanassche@acm.org>
References: <20220310012511.82536-1-dossche.niels@gmail.com>
 <20220310063846.GA24359@lst.de>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <20220310063846.GA24359@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_044626_310216_70A1799B 
X-CRM114-Status: GOOD (  12.69  )
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

On 10/03/2022 07:38, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 02:25:11AM +0100, Niels Dossche wrote:
>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>> held. The only caller of nvmet_ns_changed which does not acquire that
>> lock is nvmet_ns_revalidate.
> 
> So acquire it in nvmet_ns_revalidate only when we actually call
> nvmet_ns_changed.  Otherwise we take a subsystem-wide lock for every
> Identify Namespace all.

There are 3 callers of nvmet_ns_revalidate, of which 2 do not acquire the lock and 1 does.
I'll send a v3 patch which does the locking locally inside that if check by adding an additional argument to indicate whether the lock should be acquired or not.
Thanks.


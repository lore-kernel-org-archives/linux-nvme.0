Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2208DC0015E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIUczj9bs1O78vkM/hgRNTlEuquy8FSpvOKXYtiURkA=; b=wgoTFQah2na3SfHROflCA+3Ihw
	gXSBLrxhN7Zi29nZrUZJa51/4wpX6kbTDinRDtN6vjKkFDIPL+9PfzkAp3N3/P3nvzJ5oefCDuxre
	RP1/osEP7VmZWSb0X8qD97+5JNOOBun1CHdcdEp4yWhOT9xcnV6pwbnQfb2ZNYCO5yz0WiVHUPJfY
	q3+wuFI5jb3IIYZJDCWmvPIWLoXZYpqpAGeaLKsqB6xIA2epz9BA2z8BkKD7r3SjQ3l1MAdHIDuL9
	tLiOUhwpQSIhuL5mRISJWRJ60ksoNKjZX7LBdTtuKYDI9M2Tek34kQjgyT5A7voj+418IGFyRfeBe
	a0gMo/Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNxbR-004kYR-0Q;
	Mon, 24 Jul 2023 15:36:05 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNxbM-004kXP-0R
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 15:36:02 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso5241455e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 08:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212958; x=1690817758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIUczj9bs1O78vkM/hgRNTlEuquy8FSpvOKXYtiURkA=;
        b=Zp/cDXd1Ci35gcYyb6dzW8Ng8GyF54rJk+UDnG0HGoXcwYLdxhCWkS1z7cL8mDilrf
         sYp483LX0OV3fOvbS+xPrZy45LmIwfTGxsLOP7eWyJsu1KmYXV3ypT3Z/iMd6r7cqpxJ
         j3xLptHlRuLbE/DojBl0CcbdWOyWluRuondTVjsEpEkbCm5w9B7RcK+0OwJe2RzINQWp
         6ecao89yWiz4ZJxTEmZuqbtip4CqmWdeUbloJgqNo2S+spZuoPffhjeOlLG+y4zbXVae
         r1XFMgvnpgk/mF3xQG3kTE6bpTB8ZB/nfjkuibPoXeEM4DNFk5nfGopKOnS9pHJQUtOc
         yjDQ==
X-Gm-Message-State: ABy/qLabsBZ+TKnRdR0aCR3L0P82NZ4xfOLS2LJ5A/pS0WMcVY0l8GOw
	gArKAd/Zh1nDf0eS71xDRww=
X-Google-Smtp-Source: APBJJlHZtg+dgdU4ogu3m35MypHx0nJVgv9wZFid6fPaltpza4GOuyNKcu3eA+/wNQy+Ujj6SC6ZcQ==
X-Received: by 2002:adf:e905:0:b0:30e:4af6:87fb with SMTP id f5-20020adfe905000000b0030e4af687fbmr7347169wrm.3.1690212957733;
        Mon, 24 Jul 2023 08:35:57 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6781000000b0031434c08bb7sm13246198wru.105.2023.07.24.08.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:35:57 -0700 (PDT)
Message-ID: <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
Date: Mon, 24 Jul 2023 18:35:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel
 does not support the option
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
References: <20230724090611.705366-1-sagi@grimberg.me>
 <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_083600_174593_7671A715 
X-CRM114-Status: GOOD (  33.50  )
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


> Hi Sagi,
> 
> On Mon, Jul 24, 2023 at 2:11 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>> Instead of retrying again without it.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   src/nvme/fabrics.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
>> index fd761d10d0cb..2a9d8dc7f23a 100644
>> --- a/src/nvme/fabrics.c
>> +++ b/src/nvme/fabrics.c
>> @@ -1026,7 +1026,7 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>>                  return NULL;
>>          }
>>
>> -       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
>> +       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && h->r->options->disable_sqflow)
> 
> How do we know options is initialized here? It looks like that's done
> in __nvmf_supported_options(), called from nvmf_add_ctrl(), which is
> called a few lines later in this function.

This is for connecting discovery log entries, so the kernel cap was
already read once for the discovery controller.

Although granted, this can be udev driven on an existing discovery
controller. Probably need to do it regardless of adding a controller.

I remember when adding the capability to check supported opts I added
an interface to do it per feature. Not sure why it was changed, it is
much more sane to just read it on demand given that there is just a
simple and short string copy in the kernel...

Ideally this would become:
	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
	    nvmf_check_cap("disable_sqflow"))
		c->cfg.disable_sqflow = true;
	else
		c->cfg.disable_sqflow = false;

Daniel? Any reason why we are caching these opts in an executable
with a short lifetime? And apparently we need to be very precise when
we rely on this cache to be stable.

If you prefer to cache it, at least do it in the start of every
fabrics callback so we don't need to understand when this cache
is valid...

> 
>>                  c->cfg.disable_sqflow = true;
>>
>>          if (e->trtype == NVMF_TRTYPE_TCP &&
>> @@ -1038,16 +1038,6 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>>          if (!ret)
>>                  return c;
>>
>> -       if (errno == EINVAL && c->cfg.disable_sqflow) {
>> -               errno = 0;
>> -               /* disable_sqflow is unrecognized option on older kernels */
> 
> The kernel didn't add support for reporting its supported options
> until 5.17. If the kernel doesn't report this information, we fall
> back to default_supported_options, which represents the options the
> kernel supported when the reporting mechanism was added. These include
> disable_sqflow, so h->r->options->disable_sqflow will always be true
> (unless support for it is removed in the future), even if the kernel
> is an old version that doesn't support it. So if this disable_sqflow
> fallback behavior is necessary for older kernels, I don't think it can
> safely be replaced by the h->r->options->disable_sqflow check.

You right, it needs an else case, so we always set it based on the
default/treq _and_ what the kernel supports.

I will hold off with this patch until Daniel will reply to what
he thinks needs to be done here.


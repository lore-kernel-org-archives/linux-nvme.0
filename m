Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ED3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjbsJV0tf/+TgfypSEH3AyZuLV1GSukmKItVgX1rjL0=; b=xXbI8nsNvf0gtVjnjFsxIYcvFC
	IVkxs6wJA92ZqXA5o5HQuNGbuXiFXRLeK2lFIDT4Tog8fj5QsYBNT9hmouMFGJi5zYLL0a0vZCrUM
	9KiGrmeKsr4ONIG9yy3LZwberjwuBr1qxp0h9G9en/vyerPJd2lIvWBcl1QLn3pHVcsiyy1/+44hM
	ZW3BUH2TGDGZlIZSlDIQnsVx/R9pKrp4Ise/GgXfs6hdYpgsbJxsFtkJSufWSnDYysdvCuW/QDCgB
	KV8FOXlZ090RSXxiUKDskJfPaixEXD4URF9aOcDU7oSQOcxclMgoXvd1V1r/fmsxVEgEjlg0sbSY5
	W52Fu2Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3wOc-009WXQ-NC; Wed, 22 Jun 2022 09:11:34 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3wNC-009VRr-3V
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 09:10:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id w17so22419853wrg.7
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 02:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XjbsJV0tf/+TgfypSEH3AyZuLV1GSukmKItVgX1rjL0=;
        b=ZhlXz6H/GEuBC9j66GDaezdtv06hEsPmPBZ6BfB8xUIVhjgSIyf8G2IXoBnx9buI7C
         8AuRj82kDB/sWB8Oh/VHc3b1D/4mHyn2NPS+vTRo43BrG6BgqauyL1Ajyz9uChgCAK6y
         JMwAYaRQSRskkatXLFEC5j4RDt4PdkBf0/qkk49J3LOm5SFMdRYi0vguas7wo2wr6Wsn
         TAO48b/BZ6aM1NpQh3oznxLzRUZyQIpVh7g3rB/q+6GFFDs3Q4UbA4fLF1SzZeumkxBU
         I/a1qKvyHiueXuXMWvrfaVbSAVk9I2Lv1A/KabLaWrvDniLaQuc7yi/is9i6ajJbGSi3
         LgqA==
X-Gm-Message-State: AJIora+y0opLT+21FUVwtB3HcXeyB0y9lfZAjF60fdsC9KstuLEShQIl
	d2MgdFwTDDZ1qcGzSytJe/k=
X-Google-Smtp-Source: AGRyM1tIkObHWUkh0Vajh4ZGbqoWCZDoT8h1oEdAdCu8SwxK6vVWGA3blzm3s1MiYP/rHdrfqMMIBA==
X-Received: by 2002:a5d:410d:0:b0:21b:893a:7ca2 with SMTP id l13-20020a5d410d000000b0021b893a7ca2mr2178825wrp.449.1655888999508;
        Wed, 22 Jun 2022 02:09:59 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b0039c60e33702sm20387253wmb.16.2022.06.22.02.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:09:59 -0700 (PDT)
Message-ID: <5c650ecb-1459-d47c-ed9e-ebd552fe5ffc@grimberg.me>
Date: Wed, 22 Jun 2022 12:09:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
 <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
 <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
 <b0e6fa33-ed59-eaa7-3629-3d72430b8ad6@grimberg.me>
 <c06b6657-b015-3ff4-6044-8e800aaeae81@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c06b6657-b015-3ff4-6044-8e800aaeae81@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_021006_225725_EBA186C7 
X-CRM114-Status: GOOD (  17.49  )
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


>>>>> Looks like if I pass a malformed ctrl key to nvme connect I am able to
>>>>> crash the system:
>>>>
>>>> This was what I used in this:
>>>> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
>>>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
>>>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>>>>
>>>> The dhchap_ctrl_key is the offending string...
>>>>
>>> Right. Should be fixed with the attached patch.
>>> Can you check?
>>
>> Yes, that works.
> 
> So, to summarize: With this one and the tentative patch I've sent earlier:
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 53184ac76240..a03f41fa146e 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int 
> qid)
>                  dev_warn(ctrl->device, "qid %d: no key\n", qid);
>                  return -ENOKEY;
>          }
> +       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
> +               dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
> +               return -ENOKEY;
> +       }
> 
>          mutex_lock(&ctrl->dhchap_auth_mutex);
>          /* Check if the context is already queued */
> 
> 
> 
> your issues are resolved?
> Just to clarify before I sent another round of patches ...

No. I don't understand why this patch is needed. As I noted
earlier, when I pass a wrong ctrl key I fail to connect do
to authentication error. Also when I pass a malformed ctrl key.

So what does this patch fix? Can you give me an example that should
have failed before and only with this patch it fails?

And for the other issue, please read it again, I think it is related
to nvme-cli and not this patchset.


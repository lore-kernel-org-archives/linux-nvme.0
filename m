Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B12EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AeR7KcQKZR3NVhQn3wvthZAq+UYLkXB7yxvzjpPKOWA=; b=u+wSMpBluGbN2iZXrY3mCc2Hm7
	tfYHx/c6Z2BnkzrrS6YYaIKzhFUd85KykQsQBRLFN6RLd1mnbwQzPeFFGRCb3aToKv1kym8JKuYsn
	EU6eS6hNm5pjMWC0jdhEUZb12yfwVwJdGja3hv4ZhXeBwcrlEl1WqKQ7qcDfP/04PStZkA/2bFc+B
	yzYcA6nzFXiQHJXb1q5ihMnxETnEdjT2DGE6GYUuevhs6EdGtsl77jJrUsjWWy4Mj6DooX2ma4rpA
	9Vi7k1+F/9iUUV4XOrtS6ZYH2fZWhPlJz/C9lQxx5L9zvQnTrY1JgOpegeMDvbLc5t2hIDnjyvTte
	2UAMKtEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTVlp-003Pdd-OQ; Sun, 13 Mar 2022 21:28:58 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTVlm-003PdG-KW
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 21:28:55 +0000
Received: by mail-ej1-f45.google.com with SMTP id qa43so29844316ejc.12
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 14:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=AeR7KcQKZR3NVhQn3wvthZAq+UYLkXB7yxvzjpPKOWA=;
 b=P0WRwV9C6K3N5PUcze4zc96wyzNE2zWPFTnJrzBj9rlXsvIxoFTGpdiM4c88ST1wc3
 Ayv3fBwIEM2RAMPM4T6nxaHJtOX5vcEZ121hGHtSfZse64uGE76ztXgCf8W53DlOkpZ4
 0/fIiPPpB81OZ/tHSyytDtSs2ZNQiVtyCALg1C72enOFtd1lRgZBcwZozEfXR7dgh+lX
 SjkMcx9Vu3tD9cenMEkfOFTZE+xqRHnWENhUGFUVo+YH9LauubW270nYnxqm3d354ptm
 jJ4i1NSvojcRS22EEIT4S/7OY3t7kUhV958Zjr9Fbo2+Q7I661Y2FMq0MiL7mLlqellu
 PuTA==
X-Gm-Message-State: AOAM533Yd7nAojiQ78gpsEK7kDM/BUFro22vDePHAVak9tDtLh8vI79R
 fjofK4bvxE/K87am5aVmZEc=
X-Google-Smtp-Source: ABdhPJy3zrL8Hixp6zhBqTyDRv9cDxCH6Wq47+UwLOiLElhmqAvQePMyidfvTwSxrt1vhtmAvIdGwA==
X-Received: by 2002:a17:906:d54d:b0:6db:ab37:60d0 with SMTP id
 cr13-20020a170906d54d00b006dbab3760d0mr9916035ejc.234.1647206933183; 
 Sun, 13 Mar 2022 14:28:53 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 a1-20020aa7d901000000b00416217c99bcsm6794941edr.65.2022.03.13.14.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 14:28:52 -0700 (PDT)
Message-ID: <16af7558-70ef-6ce2-bfcf-10a8f28dd749@grimberg.me>
Date: Sun, 13 Mar 2022 23:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: nvme-tcp: invalid h2cdata pdus in response to r2t
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0coRbCPVnwVfeHYVxLHQp3HRd5V3aWZJ5uVwyyr-zk9=Sg@mail.gmail.com>
 <d01b7cf5-e46c-0cf3-5e58-64547f84817e@grimberg.me>
 <CAHex0crgDtzTcC1BMECvPsCUcdn_CtPeLLKQAtF2R=Yc=kELTA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0crgDtzTcC1BMECvPsCUcdn_CtPeLLKQAtF2R=Yc=kELTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_142854_712812_968F131D 
X-CRM114-Status: UNSURE (   9.89  )
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



> Good news. The patch applies cleanly with offsets. And, I can confirm
> that the host driver issues multiple data h2c pdus correctly. The
> various combinations of digest options work as well.
> 
> Of course, there are options for target implementations to avoid the
> need to send r2ts, but in the interest of correctness and
> interoperability, it seems valuable to fix this bug. Whether or not to
> shepherd this through to other kernels is a different question...

Did you happen to look if this patch was picked up by stable?


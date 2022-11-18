Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DC7C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Nov 2022 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVcITqTfA54zxh/oCvajvqJSOWC9JNP1bYO7WRHqeV4=; b=s4zmM78Zgv1ymNS5t5PF/W94XD
	qo9HKD/nUDmAIJR9yVHFiu285NwHkb7HwREiKj+ARidimaL8NROlP3UHkKZWqLA/I4OWWS8HyuwyG
	wF5YVvxLJ4xOUoFkgd/Sp8JA86ETn/fv+MqBGsc9Zvf8w77p2k8dcH+1OPhDPsfV9xa+caz+Q1ZE4
	BASzQSpbIEMytvk34xVkGkLwdeHjcT9ZRBM/BeXDi2FBQQe44PgFga6H9YsPMuFJlsxgai3gArOEM
	yP26sM2xvI6ei6tK4QvlmYEf8StVtm15NAgkPROI3tunGh84118bIGEVCKZuhtO7obq85SEEwEOdB
	23HmoXEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow2gJ-004cHp-2I; Fri, 18 Nov 2022 14:49:27 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow2fL-004bi1-Fc
	for linux-nvme@lists.infradead.org; Fri, 18 Nov 2022 14:48:30 +0000
Received: by mail-io1-xd2c.google.com with SMTP id s10so3954762ioa.5
        for <linux-nvme@lists.infradead.org>; Fri, 18 Nov 2022 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVcITqTfA54zxh/oCvajvqJSOWC9JNP1bYO7WRHqeV4=;
        b=Qu74ZOqOn6GKVY7GcuRh5r705PYSo/x2FT/b2dlQGJ008Y74TU6wY1ZXp4w4OCbIvz
         qzKUl3sCkKLFlcmaoAj+N0CLsL16krvnTvUEHOG4CDwmFA9L0HUu6PY4xMvFGT5/Huqd
         UOBj0Ya8xdutcRW0zot8LC9ch57dQzV9rBXqEL5vDL9m0Bw2eRywq965Oji6Olh2WVGj
         XxSivFzi4xwZv1fpivoPzViIxBywWbFfaB+tSdLmC7gio6YB3H+3AOBCF32DtHyZWMgp
         MRWoSKDP492kPX4LfRwMgEkSnfr78olLGg9XF9DmpAsfQWFAfVMCYPMi/11MaZ7xXLxH
         /wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVcITqTfA54zxh/oCvajvqJSOWC9JNP1bYO7WRHqeV4=;
        b=g95cAoRUcB60Oyve6OOX3M4BDDTPKlTFc7RNPbLRywMVbzjJ9HmA3yIzILGOO1J92G
         S11AhthxDLJZDqzGZ4N03eS0AnY9z1589LfJACCL1r5gnbJaKfWZml/JpGFuo6tgGObs
         ff29gZ0jS7TZOBqbdqu99LejQ9S3zasnB3yc6rGe1z7jbLR0W91pun+o6+87s0bOAbYR
         E6eHTDb53v0NNzk4NMjZxX3Rfho8E1alA7ZKCzAmcHXSeDIA3XKKdUyA6VjF1k13NgvZ
         hz0inXCgGaXFHujMgHOgibDRpPDDHAnH6CQTG2Nhlaok+J27n4OCwn+ycghIFXF2zYpq
         sPFg==
X-Gm-Message-State: ANoB5pmNNMdsVCs/3KS/HnXoQ4mFjufUmc7OfIjuux5cHK0KEb8Rh402
	P+EBZU/JkugRfr3wjcWv55p1lA==
X-Google-Smtp-Source: AA0mqf7IBDSvCR5oAnITMb+Bw+FQ4OldTb0hwnyud9yl9790sGvW/UfndzhvSrYWV9V+9SKiMD5Dtg==
X-Received: by 2002:a6b:8d87:0:b0:6dd:f2f4:b335 with SMTP id p129-20020a6b8d87000000b006ddf2f4b335mr3454515iod.99.1668782905144;
        Fri, 18 Nov 2022 06:48:25 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a26-20020a027a1a000000b003495b85a3b9sm1279672jac.178.2022.11.18.06.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:48:24 -0800 (PST)
Message-ID: <8bf147c6-4d1a-5440-93c5-84d735a931ca@kernel.dk>
Date: Fri, 18 Nov 2022 07:48:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] nvmes fixes for Linux 6.1
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y3d7EA+VHiylXGu+@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y3d7EA+VHiylXGu+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_064827_863940_C132DC72 
X-CRM114-Status: UNSURE (   8.42  )
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

On 11/18/22 5:31 AM, Christoph Hellwig wrote:
> The following changes since commit d7dbd43f4a828fa1d9a8614d5b0ac40aee6375fe:
> 
>   blk-cgroup: properly pin the parent in blkcg_css_online (2022-11-14 12:13:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-18

Pulled, thanks.

-- 
Jens Axboe




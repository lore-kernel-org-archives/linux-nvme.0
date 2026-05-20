Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9FBCD4F3C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edMLRPUCAVLSmTlha8pnqzZ5uIOoJFK6HSAfsV9WXoE=; b=n6A4GA0VBmtd3QTZvDe3RJlT+o
	e0cZpoGHFLruUk5hT0GBd41/7X2QxViSq/D+vkuYmhrFXvOYRtccCmRrEwk2QdDdhf8m1D4E5MV1N
	VzTHE9X7CItKcw2FH86ebRtbut4fGZtQ8he8s2VgQdY9dH+yFPiVZXe4P4GTzf6uozn/Y0TSIXbdf
	nBNlioIWd9VwHRml280HGWRuwKOfROg+hRSW9rqVr+wJfsbIjkFmjE5xWx5nYOTVcCWZzl8pj6vRd
	qfbX5TL93QB27I63L+jz8bYQva9X0DwalXnXk34UojG1TnRWK+VK1EDvRsx+4PgdPe5r495uuXzb5
	PjM4CVNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPhrO-00000004nku-1onq;
	Wed, 20 May 2026 14:25:22 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPhrM-00000004nkD-0Y1L
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 14:25:21 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-369002b26f4so2647832a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779287119; x=1779891919; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edMLRPUCAVLSmTlha8pnqzZ5uIOoJFK6HSAfsV9WXoE=;
        b=eHBJsQjWnMslM80Szc34U952WIWvEI6d+0FyYdMYfj2rAwgL4MO0J42lRESwbOzSaP
         CEn8V+W6GcoXsHVYHr49Mv6KqfOBH+2AOtPt3kxUaMq3H034GYGuz5VEhPW2bK5eOAJ8
         a3bHKDru8LABr+dZuEfeERMqy7LN4Pgm2qfyNx/XCA0AoZVEnHGOIw7U7IGUeawzpO32
         V/ZO1mjY0msSk+g2toJnerlYYJ0YQMIkmroVr8p2zlAbMeW6grbnRT6jjlWFUq0EWa5r
         vjnJenLZ2oLHFXoNld9XJeHFK6APls3aLHr/EOHhpmY5N/fQelgiQY7m/lkC89/EBfYT
         9x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287119; x=1779891919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edMLRPUCAVLSmTlha8pnqzZ5uIOoJFK6HSAfsV9WXoE=;
        b=gW+5BaWgue5KBb5XYJ4vxdl0ZQ/rdcXFrYHPvKwERHYRVAwr21IcAmbGeBzoiCuaMA
         mpzFl9A3XdF5RjCZ1qi6+rMsT5wSk+tWlyBg/SMsSmNjOk8Nr42hY3Vr8LKmja2FrQpq
         /CmlNpz2EpOIX/8VEQkLBBstqmRmrGaaz+qhM6AOjVJG7ff9dgwZEW/c402Pa1VVK+6z
         8q4dofcOoMH64MTyz2riLDjAHvZ8X+hC4HV32ydKINtdLy9TA5+KDFoTewj4+hPdM1WP
         IH/DzqM5VfEeP3QssDxBvBsgeGS2f+CA/oojnzjm0PGPHj2Av2VD1/5ZWoNPbm7WgFoQ
         6UVg==
X-Forwarded-Encrypted: i=1; AFNElJ/sFkeRjPX0ZJEHbvLIsIaGfDHcf+HUlBxIH1v1DvdGaMi72LL/7EUZiv6MCLFGoV2vVi1jtdCwcQjI@lists.infradead.org
X-Gm-Message-State: AOJu0YylA1JOqan6eLAqFlTFIy2wEyC1TSOulexTiO8pkxfB8mGRNWmX
	/iioGvnrbtLxsXuEN5IMo2RNJNwf0urNvdrB+p5irGK1XR001PDnTcobdlfZVQ==
X-Gm-Gg: Acq92OHgp2qpImqiGmV8MWJB12IcH9gEVBE/zJ5yvRRP2a0pIUkBLhhLXsPzWfkkshy
	cgsXkvtz391L+EV+lxV3Zi9FangSEdFK/KZNFLChZcrfKgXYrXiU8dnYCY+4bQpMJMk3YPnQmNO
	6M8XhvdVCvDFhp2++5ZVdzQOb1TRdEcE/cH8/Inbl1W7/UtfJryT39FIzrrRgQRGrjWd2uEPuPl
	IFPxo+lBkpHAT8sydxi7WWLkLUmg99q+xijVD0Oi/Z1zG9oQYw9RGy+dRvCYmk6B1+6kro8vRtB
	2WlFq7EIRaBsXAuTmetyucbGK7OuG9Vn0/0mD79va/v/YbgxwC6MjtSbcQNNvZSXI31a793IuCQ
	25A+FBa5VbwG7eapAt7jMJAQhpiCoh/a2RW5zduB4NsoY5wHimje2CSkEuaKxaKfFB8jlJFv0gk
	pfaFSn6qMqd8OxB5BVZTdDk4uNC7JUiVfE4vwDO6RBrUSKGIxUzPiHhORjYHbo2OSy2UbvToOAL
	zBB5Iw=
X-Received: by 2002:a17:90b:3c8f:b0:368:ddd7:abcd with SMTP id 98e67ed59e1d1-36951c9a01amr23605419a91.27.1779287119174;
        Wed, 20 May 2026 07:25:19 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:952f:f656:789f:85b6? ([240b:10:2720:5500:952f:f656:789f:85b6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm17847489a91.5.2026.05.20.07.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:25:18 -0700 (PDT)
Message-ID: <74924751-16db-4358-9766-b155cd87fe16@gmail.com>
Date: Wed, 20 May 2026 23:25:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-cli] nvme: check MUD support before firmware commit
To: =?UTF-8?B?6aG+5rO95YW1?= <guzebing@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20260519134542.1841435-1-guzebing1612@gmail.com>
 <7e688c2e-7fa5-45d2-9163-a81e1fd8c9f3@gmail.com>
 <4b210910448ef2227190f426e97614787d15d32b.ec564600.33b5.4dec.b88e.b13b57f6dffb@bytedance.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <4b210910448ef2227190f426e97614787d15d32b.ec564600.33b5.4dec.b88e.b13b57f6dffb@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_072520_171356_BB9D3039 
X-CRM114-Status: GOOD (  13.10  )
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

On 2026/05/20 15:22, 顾泽兵 wrote:
> Yes, we observed this in our production environment last week. For the
> SOLIDIGM SB5PH27X076T Gen5 NVMe device, when upgrading the firmware from
> G70YG472 to G70YG473, nvme-cli printed the following error after Firmware
> Commit:
>
>      identify-ctrl: No such device or address
>
> It reproduced 100% in our environment for this device and this firmware update
> path. I suspect this is because the firmware activation takes long enough for
> the post-command Identify Controller command to hit the controller reset window.
>
> After applying this patch, the extra identify-ctrl error after the successful
> Firmware Commit disappeared.
>
> Environment:
>    - kernel: Linux 6.12
>    - OS: Debian 13.2
>    - nvme-cli: 2.13
Understood.
> There is no public issue report yet.
>
> The user-visible nvme-cli output was:
>
>      Success committing firmware action:3 slot:1
>      identify-ctrl: No such device or address
>
> We did not find any kernel error messages in dmesg around the failure. The only
> user-visible error was printed by nvme-cli.
Noted this also. Thank you.
Reviewed-by: Tokunori Ikegami <ikegami.t@gmail.com>



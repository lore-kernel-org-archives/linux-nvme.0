Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F1C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Txps8BV5KXXLE5Z8Dj4HtwZJIjHx8LsUHB2vb03furM=; b=bEiV8sg83KgF1uoZIvXaQnLuGS
	Le6F1qlGn99Itb73m48QC64u1MyxEvdevTYd+qkj8E26jIGq+xcQX7TrQLdp/uoKYwlGS6qRPBCSj
	XQRw/hA/qmK8V0M39lpd5VtXS2nWIU7+j7UFo5pU5NxafdaYQqKtCqZ5WD5kS8oNCnFDPqVROQTjA
	kpotK7Q2Bu7XfSCUd/cv+yy4TAnQ/dxdqBCUpHCK5SZNJufW3owSKF2ZGvahZar41nLsO/dj31fPS
	ViDbYlRIMoZh/3Skx/1Ma1NcN89R9PMKjmsQuhTsn0cR0sxsEEOoPFcWPiFD6ANmW1rpCDD/Pus0Q
	pcJaHzQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrLVt-00FzsH-1W; Sun, 28 Nov 2021 14:50:45 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrLVp-00FzrW-Tj
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 14:50:43 +0000
Received: by mail-io1-xd35.google.com with SMTP id 14so17709015ioe.2
 for <linux-nvme@lists.infradead.org>; Sun, 28 Nov 2021 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Txps8BV5KXXLE5Z8Dj4HtwZJIjHx8LsUHB2vb03furM=;
 b=RiTzv1xSgdvwqnqWp1SXVPrTRBpb6DAg2TnKPceezDniBL2S1NlsonFMXDz+45YHO1
 BFIMKqdBc445J8nJfMwWjBLKzbxvlekQBNG+/tLTBdUs9dOXF8l06CLOeehBcYDkSjFg
 lPNfFvxzd7Uhkq6B67VDg0SJSb3gZ94qDT+srk+nHBI8z5oGgs5f+Th6ZGOCdv9DUqCQ
 E3p2Fu8+sIqRXqw/bSOGqX7vi4/JKRGEw1kLcDvUbcVRoBLDvU5us2mBfCOHTa6Q+L6F
 tF9CY4KfFjx5LR/uTlm1vqtnZTSmuzl40A2UTPxF9XmouhSBeqVajze+KY76eljOjjCI
 mTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Txps8BV5KXXLE5Z8Dj4HtwZJIjHx8LsUHB2vb03furM=;
 b=x25i+nmgCE3nXE7zUH+wHEyeQof+gr/oZCaJyZ6SzAqCRZU09bWAuh8HzeJuuaUL5E
 HhJNNi7MP4AG9O/5+FDlWeqXLEqzu6PboWDYkp+Hmi50ArKUegoh7VzKJVspgl2UTvRH
 YkZjoG78C6XAhCoVaehEg1T+e7Pf5P6L9CR0qDFXg61YnhAFLpMr1zvTK1qZ5sO55WN0
 w4JGcEa8eol80CdG2KddlIDKTvJB6B16qlpV/CGUk2JaPDWDuVf+2tXZpN+7lsf8irpg
 Ucq/0eEVYVKERZ8eUx4QeGLNZMnI8q3xHasi1RZvoacOwchKm9zKO8mVBtJs1BMTDnMq
 FUGA==
X-Gm-Message-State: AOAM532zrFGyItogOoVi/1YQRxu/Op1WGohXyTP1OK7R+dRvmn8OGq3N
 A1JWjY1rq3zEBl2CBDiFpsOmRw==
X-Google-Smtp-Source: ABdhPJyLSvA0K16M7WTbsvdBpW4pLzudrSbFlFJc6kW9I+0NBLSERL16NBvWVxYaC6PS327/5+okjw==
X-Received: by 2002:a02:9609:: with SMTP id c9mr62298537jai.118.1638111040447; 
 Sun, 28 Nov 2021 06:50:40 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id s9sm6817343iow.48.2021.11.28.06.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Nov 2021 06:50:39 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
 <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
 <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
 <a4d728c2-703d-66be-bffd-3bfde0fddf41@kernel.dk>
 <b549b4ce-4156-eaab-a146-1fa52f51b642@panix.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <838c86fa-bb3d-6794-64fd-35b81c62bbb6@kernel.dk>
Date: Sun, 28 Nov 2021 07:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b549b4ce-4156-eaab-a146-1fa52f51b642@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_065042_057648_C8214D6B 
X-CRM114-Status: UNSURE (   9.44  )
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

On 11/27/21 5:11 PM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>>>> That said, I'm pretty confident in the fix,
> 
> Moot point kinda, as I see the fix in Linus' master, but yeah, it's
> working here.

Thanks for testing! I had a high level of confidence in that fix, and
wanted to flush it out before -rc3. But testing is always appreciated,
and thanks for the initial report as well.

-- 
Jens Axboe



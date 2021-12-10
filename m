Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BF0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zocsZqbIpXZdqvpCYwUWFrEIkd60Xqe+FQJzj1rvev4=; b=tDlkrkfViswtMQrHCn6Xpp674O
	cxMjw90bd98gx2qLJLgMk7VawKtZy7NDVmSJ4LJB82euMcBzQlYRcsxqikYDbF132aL97Bd5P/+YX
	g3B4hGXIkMD21dMo3wxMHrdDP39ln7YeUiVRZQjBtnYiGEYPajp+G2bnN+pCifcto9eYx/PQzjqRE
	ryhzGxmKC5ApDD3vSEj9kf+aWWALEdVjRciS0vMNslcmQ6zOzd9lkHN/JzGzrIQHeCdKgs+Xp/1HK
	zUW7a4OSQvo69A78zVkm/xRdnFz7hZnbJW6mt2YTI0ZTetDUvknV3bdZpsGdZeSVnZ9r1kZ66n0li
	HpV6qrYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvgCv-0024HR-Ma; Fri, 10 Dec 2021 13:45:05 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvgCt-0024Fx-EV
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 13:45:04 +0000
Received: by mail-pf1-x42f.google.com with SMTP id g18so8507903pfk.5
 for <linux-nvme@lists.infradead.org>; Fri, 10 Dec 2021 05:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zocsZqbIpXZdqvpCYwUWFrEIkd60Xqe+FQJzj1rvev4=;
 b=AbQhCDpQ0Ehd4y6VRCU9Xp+w2iQGThwL+NrLq8mt0bnUP2hycyjxRZBLqD3ukR45J5
 qpwkggjvZhxJ/8D9Ohs4B8DQxubXC1f9fecars+MacsJzSKZo4J5BbwFhDliV9Xv+ppM
 y7xSOYpUxM+tdGoQr1obbDGMz8eCwBpgHqkgSnM9UB4O4ZM8zrx8rWVAXQE6Dr5ydL5i
 cpltsrsYQiBtptl3QfPCJtsq6xUkhMAwEh3eUkeEciXfdg2xlkZXNGTNkC6SB30pbu0r
 R4wpD0Mfm8YH/tJdRbebkzuWhXZYaxdYkvOP664IIZxelc43tMFReJp/K2GlUVZsJQGg
 eq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zocsZqbIpXZdqvpCYwUWFrEIkd60Xqe+FQJzj1rvev4=;
 b=Lw1NpN9hSh4JYVz36UU2xoU65vWo1KyAZ6abzpj9CBm+8V/jxSM4RrxZJA7bIJLs/H
 CwGBLRR5GMe7+U+14FYJKK5P5iC0XjKrhZjyHiVgYPz52BcUahxhVgSawQzVNnwyxCWJ
 zoQ3AmXcbwHdr5MNrd2E1CwTfM1KWpchstVGpWtilf/WgIYNE1ZesN4APe2WZmrjJSrs
 h/kG6cYDhnFxvFknP+joGMgizKPOfOouV5fGBmn0vUrX7kcdg1gwlz/La3TJVbcN+rWM
 L1y77u3QdVmfw0zzV2N8o5hS6wcZKmyj9YP6HsvmGGQR3GcDzKMYCTtWxclOFDOtG8bp
 s6NA==
X-Gm-Message-State: AOAM5312tsMWdNam/owNs6ZeB4KI3+12s+8wf15rCpRWoZcXr1/c3ZG0
 79A8GbClQ12MaTTYDjI4vVqg9+0RwmZ+nQ==
X-Google-Smtp-Source: ABdhPJwlCLpg1648Cq9/sjohU1cgq2MOES4F7USfuo1J6BYOQRwajmcZVxBHWuHjb7DNs9Um6rzvFQ==
X-Received: by 2002:a63:d04:: with SMTP id c4mr35264634pgl.472.1639143901579; 
 Fri, 10 Dec 2021 05:45:01 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
 by smtp.gmail.com with ESMTPSA id ot7sm13827753pjb.21.2021.12.10.05.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Dec 2021 05:45:00 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YbLwmaLqilKEW0Q/@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97bdd109-4854-459c-ca05-8c5c7c4ac9b0@kernel.dk>
Date: Fri, 10 Dec 2021 06:44:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbLwmaLqilKEW0Q/@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_054503_498624_2A4D172E 
X-CRM114-Status: UNSURE (   8.66  )
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

On 12/9/21 11:15 PM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.16-2021-12-10

Pulled, thanks.

-- 
Jens Axboe



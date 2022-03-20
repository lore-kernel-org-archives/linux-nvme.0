Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AE7C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Mar 2022 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UtfcX32qKLRxKG69woUQhqT3BV
	Z8HoELB030qsI6K4LmDpvJmTHQglylotIn+eG4nbEN2HvHq5Gk2YIDpWMSj7zNyal9ECTdgLw6yqg
	yl3zN31YdSxFMzvMLe4Hm3OrUIlDhQskZHSQ6fcUz9hV28ujs1ENtelSoeZLPkjL1MCsb/QLCJtLI
	lUd0HQvfO9cRd8IS1ek9fmPjy4HBWbskI0e5ZEqF7uLuj4tjAJOVZWhBMBN2uQbKFLe/9uU1lLJit
	MK3pf/LiEVn00hhGu3L43ihvoESreQ7FQjewdtq5WHYtm29DknyybjRaMqqIOH+8bQ/EJ9MMbk5fD
	x3CzRH6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nVuwD-005FUz-0b; Sun, 20 Mar 2022 12:45:37 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nVuwA-005FUI-Tq
 for linux-nvme@lists.infradead.org; Sun, 20 Mar 2022 12:45:36 +0000
Received: by mail-wr1-f49.google.com with SMTP id j18so7824281wrd.6
 for <linux-nvme@lists.infradead.org>; Sun, 20 Mar 2022 05:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=egJDt/3Q2eyFRxF5E0bDzgq67fl6PnrVO094HV/8VQIjSTcCvtigjb8JECyt+m7PWv
 pfnf/oN7jABMHEfn2UZH8x/Mh8kIny3KF58mzFSlV1KoNJKa535En9NtJyxUGLJUpjta
 A0+zZjZHjY1VhxOzzpt/Xk77/7VtsdoT+CDgTBGAr27EsWvY6CAmYPLg9LQ2zqc213rM
 vel1GG2qgOWkg6Hy9r5p4l1EEea7FygtLlJP0MmEE0ICgqmsqKMU+Rh2ylsjvsrVjAZs
 zU6DxAlP1bF9N/DtDzvJMwsGQQtPWWb4OJK8jFubaxIEt1PwDrSwYsiCrHyE5AIr1arq
 AasA==
X-Gm-Message-State: AOAM5333kYaKVaJRpzOwQjP/j/IUOe7i6EoicR66EdCAF1/ZuKFOWagj
 EkD6k9GWvtbWrjwwHO70DgY=
X-Google-Smtp-Source: ABdhPJwUhVv8N3+HVdjB9bZ7jwZ3LbfVvveY4iMeQ2qaYFGGp2rir5abMkeDckl1WwU3ljob2dY6iQ==
X-Received: by 2002:adf:f442:0:b0:203:e0ef:32c9 with SMTP id
 f2-20020adff442000000b00203e0ef32c9mr14947152wrp.53.1647780332577; 
 Sun, 20 Mar 2022 05:45:32 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 l13-20020adfbd8d000000b002040daf5dffsm1896488wrh.18.2022.03.20.05.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Mar 2022 05:45:31 -0700 (PDT)
Message-ID: <77d616bf-96a0-ce01-7139-1253c414da0f@grimberg.me>
Date: Sun, 20 Mar 2022 14:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: remove redundant assignment after left shift
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20220318013014.90698-1-colin.i.king@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220318013014.90698-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220320_054534_996360_178B0CE9 
X-CRM114-Status: UNSURE (   6.18  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50546EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ux1mIcW3SAWS/hk4Rq4USkCMrg
	FGO7i3RPC2nhrdMeOEm7VECn98T0c8WAyZdSRGZC99RnFZMNqELKviWeQXSiBZqCWtYUXH8VZ32SL
	9Qe3REXuudmQwVphQsSH391A8aFD7k9TV/okcWGAc0sxi+up7kFVwWyiXwQN2cjU+WlArlquWPhKi
	AgHHAhFJ4s9aC5o1YKhwnP3wGpcu8mpPzQUKUbvBhCf5c/iS9so9f2ZKQJ82AjfE4P03ZxtQmPFZO
	Px4HbrQamFFldhYGdhLqkWb1MZGMfzMthnDJpd2i52SkvO+MUkUm3a4Gd+My+h4bqF6swD84ns62V
	9D9HBWVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaUm-006BwC-2j;
	Thu, 17 Aug 2023 10:44:52 +0000
Received: from mail-lj1-f170.google.com ([209.85.208.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaUj-006Btz-1l
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 10:44:51 +0000
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b70357ca12so20581851fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 03:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269086; x=1692873886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Kq4RhvODjKY5AVj4Kh8VGhZl6j9CV99pTtHU/4bOIOgJZ4rOEseEimWVQPE66FG2BT
         nOZQJPPHU6h6hvGnUD5q92InunxvzMa9mXehn87TIB93lwpWI4YmS++ImAysFuhsVUlL
         iivfXCvpGPvuCpj6B9elCkTjk12nOvca6ICdMv43fqYpnnkf8hHo0Mv1cMYSoEy86sd9
         kDgmGA/pvk2YXcce71t7Jj//cu68Z92QWfRsoB8sa45/OwDg40NsXqkSd6pAWVpaTRDu
         lCVQQ/2EBCrOK13HxutieEXM7A2hsuxR/kDs5r76pfOQrUq6o3yC2B7yUBH6dkMeU+sc
         oJLg==
X-Gm-Message-State: AOJu0YzeW7QdcsLmKF6ioHez2cdXX/CFIZ/mbK4vLIpk5Bp/avZOd5kx
	gQMeog+FNXJRvhCeq/WCqIo=
X-Google-Smtp-Source: AGHT+IHQhPAimqm2S3tsqWSnyRt48WBkAnyb8t7usGqYa91blIE3h5md4AHUCXHn5TR/x3fgKh6RaQ==
X-Received: by 2002:a2e:bc88:0:b0:2b6:9969:d0ab with SMTP id h8-20020a2ebc88000000b002b69969d0abmr3404304ljf.4.1692269086359;
        Thu, 17 Aug 2023 03:44:46 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b0099315454e76sm9956545ejp.211.2023.08.17.03.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:44:45 -0700 (PDT)
Message-ID: <15ef9677-0bec-84d0-07e5-770c8a1f1e47@grimberg.me>
Date: Thu, 17 Aug 2023 13:44:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/18] nvme-tcp: improve icreq/icresp logging
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230816120608.37135-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_034449_589123_0714A454 
X-CRM114-Status: UNSURE (   6.37  )
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


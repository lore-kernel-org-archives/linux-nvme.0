Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F27C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vw1pAO2XFwZN/p3777fvdTmIyh
	OoCol5KtJruz4BlTxi9U+I+Dll4fWjSdlSsCWgx7ezdLEYSh1ivCFkpiDVNrU/cy3o8zml9mbERwb
	BBzmWhVi8Qm+140FM7+kq2NFcWgUgI/gqDUM5zGHmQmOloyn9BlprzPlPFNgGsVw2CvpFVM6XVt2I
	a0Q3bnWxS1w1xsTkU4xlT9XDg5HbcJSWVLi7lmdDDa3dSAoztGLlvgqczu+OORF4i+36yN0O+hulH
	wpSYmXgif90ecJlWcuZsX0/TtTC4rBzYvJn6Nb1mH9MuTfPEvUA3Jpl3EpQ4WkMYoCnxgk+R3wXJ8
	L3tomUYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IkW-00H1BI-1B;
	Mon, 05 Jun 2023 22:32:28 +0000
Received: from mail-lf1-f41.google.com ([209.85.167.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IkT-00H1AZ-0F
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 22:32:26 +0000
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f628cc4a35so307589e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 15:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004340; x=1688596340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OS9PFvJBlstxZQGfqAGq2xSDgjjr0stYst2LcwvqBQfe7vNyVFVEvjw+9hIMxetPYp
         B33awG1OwjrhJZd6kSmyN3QgZSBHSpd1tO/vN90W1OMjP5SILNsBSgWHIUv3RuJ6ZEc9
         f6LpUiJ9C/1KbIi6KS5Iwa8OL1Rg2aNhRq3kwC2D8nUqi2yDH5TxeZhT3hQQMz3zU/lj
         8rvt2AA6nqK7e2X89rLtq9L7LCu5gS8RCxa3XBjcFrGuJ4cjyDKhhwuHdzI2bbZNTVvt
         Tg602S3Wdu3Uy6H6d6Y57IK7zYTwa4HZpfGytDY+EytSZhwQDzW7uBRfmGNhq2wTJPEP
         Ms1w==
X-Gm-Message-State: AC+VfDxzJknEi2ZgmeHXSajITso77GU+cJJP4EJOVTNf+VtWyb0Iw6jD
	D0WvGFcMovtilH3BtINsp35UGZa7fMo=
X-Google-Smtp-Source: ACHHUZ71t35GtNf2TeqS2sRYcEAVkYP5h5MGFJ18nBwjb5OBUjIxiwlHSQPWQ7Vhz+Xkdk3BkPYt0A==
X-Received: by 2002:ac2:4907:0:b0:4f6:1a99:3b05 with SMTP id n7-20020ac24907000000b004f61a993b05mr141664lfi.2.1686004340471;
        Mon, 05 Jun 2023 15:32:20 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id s6-20020a19ad46000000b004efff420b11sm1245942lfd.181.2023.06.05.15.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:32:20 -0700 (PDT)
Message-ID: <70461d5a-5e45-760e-7a50-2348cb0b90d9@grimberg.me>
Date: Tue, 6 Jun 2023 01:32:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: print disposition on err req completion
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Amit.Engel@Dell.com, kbusch@kernel.org
References: <20230605064933.46933-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230605064933.46933-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_153225_115344_51202F85 
X-CRM114-Status: UNSURE (   6.13  )
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


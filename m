Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F105C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=zi1lcwBditT3GHpOZSpKODk3f1
	vUemlZOQL6djGt8n1A8V97WbaNBKlLIck9vTGUI5xG9wFH/RquK6C4Jx6cHNppcbeU6cPC5C6+JmH
	ISVedafw93tK396JRtARCxxtatyf5cJV2oNb66woxSHF6l3SSEyiYeYqZGELA90bS0FHqtVhLL/UA
	BZcI666beV3yfSpWxllYD4xao6fYIi4nyTejB6r01IJ4/rB8lR8snLLKn91QEYS7OXP3yt37/RE09
	dAYUHEzx5VOCVouhXl+va/qHZiCmbm8rZBH3gzed/xW7DCos/K6BvA7Dq8Dy1pLQlwgCsvG79hOSj
	xRg4wN+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4p9-00DbyZ-1i;
	Tue, 28 Mar 2023 08:36:59 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4p6-00Dbwx-33
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:36:58 +0000
Received: by mail-wr1-f43.google.com with SMTP id r11so11245203wrr.12
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992612; x=1682584612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=emEC4Y6G65auIawUSc62hvQCwV9Mac7to4Tol5N2rJ77PFZUVSTqBXmGmE+b0zlfh1
         Iq4lh+JZ1BhcizYgKxq865A4POLKK+fWuY3V5EX6FJJZzxAtCkezpRDhsLCxfPB9RO7a
         WNMteyA1NtZQOSTKsFgSMwUr69MfcUP1xLi4v7u/F05XIRpumyOBrg7ilfVGFwfnHe6P
         HhRmSXa5Rzr0bdFoLI2rx38eT/qW+Q9XXxNFeWOy/b3aVJ17swiJz5pXAJgCMff+dBDm
         AxwGolr+dUU10lmLSugUovnJCNSyRlSDxrZquvI4asJSTdBn0kGwnl6Wy9A41ChM3e5r
         /KZA==
X-Gm-Message-State: AAQBX9eVy5VkRQRh+vBg8tl9rPqsBGsxFxWMZGbfCJoJDFERsIA8Vogx
	7Zlka3Dckga28x7h1HfTIbk=
X-Google-Smtp-Source: AKy350ZUhtjmaLZY/0rDanXqv2Hsr3IoxZxNDojZHsu3ODm6o3fcokKVkD0iKEYeSDq04CSK/pAoAw==
X-Received: by 2002:a5d:4144:0:b0:2db:76e5:76b3 with SMTP id c4-20020a5d4144000000b002db76e576b3mr8419985wrq.3.1679992611963;
        Tue, 28 Mar 2023 01:36:51 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm27091530wru.23.2023.03.28.01.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:36:51 -0700 (PDT)
Message-ID: <c9f03cfc-cbac-99f5-216e-18c1b7727a7f@grimberg.me>
Date: Tue, 28 Mar 2023 11:36:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] nvmet-tcp: validate idle poll modparam value
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230327053724.62363-1-kch@nvidia.com>
 <20230327053724.62363-3-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230327053724.62363-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_013656_978437_2EEAAAE2 
X-CRM114-Status: UNSURE (   6.46  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D81EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Fcb7nYT7pLk4pqMAjqbMeKG3hg
	kLpyAogTqPqCwk4QSXeVWjxC+oJOZ2ydEcPPzuRS5PB+2RfiVSWRkNVktjizJWhdIQyL48VaGoFS0
	hHeFT/KVES/Ny0D/ovrNqFc/Ns8iWxc+6quqfK25cZuGLDGkZ+YvnpdD/KmFTYjbTZPI7AZTpPKJa
	Dhmckm41UaDtkGQvAHDQy7qsqPw8+DaQGj3LTZX4VYYaq6IcZhAtv3PltN+qYp+De84q3P8bYA0WM
	qqNGNIakWIYybPusBaGiY+KXNjq1cTMLEpvvoe7PHMGEXFm616HpobZAyy5ZQdvy8eL1irUcHss4k
	FBiVYEUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJAlT-00Edrh-0P;
	Tue, 11 Jul 2023 10:38:39 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJAlQ-00EdpL-36
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 10:38:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-31422f20399so1208088f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 03:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071914; x=1691663914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mDa9qQ0cvpwGOEeAbcyIQdtUyxJuLV4PHzKdDaZtkey4NP0mp1M3wtOFg/Lc0pBuxL
         cuo3bd75taWxflBZ91zM44VkrDRjXHxI6mgE8OubSxL1jy68JLJRTNzycBkkOswmNBJb
         VcDY7yXJYbPAQltze6XVaVZ70Gpw4oTVIu2lnLCxJGoIEi0GQWfl693hKkh27TQ2K0uL
         Vtm1zFy9l53zns3XcQTPKB8VofSNDEf3Fl0g43L2BFVu18yWK2ZTJlk7KNAXEklH2Tlb
         tksexZrpcs4czNRiQrgqNIls44ZneV4BrKyq9TFtb6rFv7vmafH9mOATE1fL1opL45bi
         unmQ==
X-Gm-Message-State: ABy/qLa+F01Rl9L1fYPpPUt8hTRZPY+RRiiJpVtsud5mxlwNi1zD7WJt
	Be8PBMFl/AfusVBnkPNDFLE=
X-Google-Smtp-Source: APBJJlFFs9XqqYORhWsk2APEGGk+VSzShkQ+i3uE78roAxfWx6F7jAI4ik45PxlK2gnQBGy2uCLYmw==
X-Received: by 2002:a05:6000:11c2:b0:30a:f103:1f55 with SMTP id i2-20020a05600011c200b0030af1031f55mr14033907wrx.0.1689071913750;
        Tue, 11 Jul 2023 03:38:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm1850004wrv.108.2023.07.11.03.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:38:33 -0700 (PDT)
Message-ID: <992bfec5-5997-6e5e-f8fd-096f8eeaa551@grimberg.me>
Date: Tue, 11 Jul 2023 13:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 2/3] nvme-tcp: fix potential unbalanced freeze &
 unfreeze
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
 stable@vger.kernel.org
References: <20230711094041.1819102-1-ming.lei@redhat.com>
 <20230711094041.1819102-3-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230711094041.1819102-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_033837_001276_88DB5E41 
X-CRM114-Status: UNSURE (   7.66  )
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


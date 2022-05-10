Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2AEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=co2eBHYlJ/8jSI1HX8IuIkIXr/lTF8w1YbWXQnk2TLw=; b=zLbDrKwZ8+wzQC4lTOpCdRRBct
	wUT2dSp9UpUo4+/Ts3AhojlwH/l/Zr0CLISjFyrW6WzGp3PpkO+2PnJLPMOrhmYdl95jYKklv0Sbo
	S+3UDq1HkwfZ4mbWIXdL9Xmz7YEoe2eH+RePQdoVlc2LstC6saqmTZfMVGfJpajL68XDshlSSGocD
	D83p4jzM7eUxe9IMSM0/kPUSf+Mvo4MxAnRNetWX+QcHVaAemM/OpYIFc/wibjsw1x2MhEU1cZOfQ
	QLajK6GAE/6o0YExAwWl6Oahh0Qd2T2qmmrZZLJJzTbxKXY1c6sichmbSdmqUIP+L3G1Z9fZgSdWI
	oKE5vbVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJfJ-000DlP-Bj; Tue, 10 May 2022 06:48:13 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJfF-000Dgs-1s
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:48:11 +0000
Received: by mail-pj1-x1035.google.com with SMTP id
 cq17-20020a17090af99100b001dc0386cd8fso1332378pjb.5
 for <linux-nvme@lists.infradead.org>; Mon, 09 May 2022 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=co2eBHYlJ/8jSI1HX8IuIkIXr/lTF8w1YbWXQnk2TLw=;
 b=fkM8j4GyHljGKWn2LbaZQuIkisiytpq68of+xbM/uFT3nwScwYQGsqaAQIeSE0VjSv
 DrJh5FuYLssyPmI2SE1B4SRvJKYVihDlaLqI++iBX2qBWg450izB3AfQkmnY/bBWLPdc
 aZK56kzzJ5imdE5cFafPTcs9b9EGanCPTTuFXG3oRECooG+/bBU1inYMPY+CGBGJsBO3
 Q54yr2enCbhmxKXqn//QUh1q0kuYkPEShh2a9E4FGe5Lw0KBjhM1Tgtg5VzwS9nD85zv
 mRLrLac9TldMMUgntcKQfKTqM5S6ganSQEyxwxpgmX70ctz5ABvfk2M2grUvI1/CcpPC
 oqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=co2eBHYlJ/8jSI1HX8IuIkIXr/lTF8w1YbWXQnk2TLw=;
 b=aMM8K7QvHvjXIJC/cagjduk0mCi1iY9h3cXwjctyNzxStRUXZ5V4QmT+9h0Daj2UVe
 p8gxeOvIqbu0GJ9tlYiRYukV0MnQ62WlnttMoaEynEvX18W9tzQirAD1+LXRdzMCRdNA
 JLc2KuXvuibNA6toN1pX90/c3/EmrRd7IL1pQsIDBWRz++9634lupQaF+D1fc1Bmn9bI
 9nqR7QZMZV5Yon3SuaIzszfGMA2Dux6OdiVzJ6xfVJ6UmarSal5j3fD7g/SMDzC7RXER
 RQM3XM1gED6r2HM6gwLl64WP3HCzTZvY9NuerDBFF5w++0D1TaY2cJwPeUozowV7QyTY
 IsYA==
X-Gm-Message-State: AOAM5330Nr8U/sAdYUIDsq+3sRrPrxf2VL0N5MQxKKJTHqaVCgRWF9m8
 Cly7kwc8PscDSuzJIxkPf89D8A==
X-Google-Smtp-Source: ABdhPJyon4i99lL4Z56gC2OxIKRnjK+6Jt7ZWreKPWL9YHl9eJQRBDv3XujFVaeiuF61RwtLV/wGbg==
X-Received: by 2002:a17:902:b284:b0:15f:179c:9828 with SMTP id
 u4-20020a170902b28400b0015f179c9828mr6447989plr.4.1652165286357; 
 Mon, 09 May 2022 23:48:06 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170903110a00b0015e8d4eb20fsm1105863plh.89.2022.05.09.23.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 May 2022 23:48:05 -0700 (PDT)
Message-ID: <0859381a-5c09-ef54-89bf-e27f79429b97@bytedance.com>
Date: Tue, 10 May 2022 14:44:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 1/3] nvme: introduce bit 5 of smart critical warning
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
 <20220507065026.260306-2-pizhenwei@bytedance.com>
 <20220510054904.GA10460@lst.de>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220510054904.GA10460@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_234809_141430_73E8CFF8 
X-CRM114-Status: GOOD (  11.16  )
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



On 5/10/22 13:49, Christoph Hellwig wrote:
> On Sat, May 07, 2022 at 02:50:24PM +0800, zhenwei pi wrote:
>> According to NVM Express v1.4, Section 5.14.1.2 ("SMART / Health
>> Information"), introduce bit 5 for "Persistent Memory Region has become
>> read-only or unreliable".
> 
> Given that Linux does not support the PMR, do we really need this?

OK, let's drop this change.

Klaus Jensen corrected me about OAES[7:0]. Sorry, I misunderstand this.

-- 
zhenwei pi


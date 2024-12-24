Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79004E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=zYaKlcYlYj52fkGobp+2REg5IV
	NJBK7Bc+BDtQgEly/tTDD+t/bTeV668Imf7Uv131ulnOsUovEMwDRSrUyfoxY1h4oz6qctsJpfHiz
	2Af9b4rOKFKmksXch6gYQawBMTXFJUsGvj+j/UUfEvNszNKg5ClOG5O+3kviNoWRIM41RRKqkrrcf
	jtNg/vzU3XeyMkSx8cpY1pizNqUl+UvqmRCDvkyTWm2nTg790OMYkQ3vp19PYVjSm8/Vg4m//C/dw
	IAukOryIMWdo6couPCtUMJIynSgEf/GpJ/ASPLFiW4ScvdCR/t9f4eAKS/UZc5GubZuRIMzd0CJr4
	KmOZc8ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ31I-0000000BquB-3IYx;
	Tue, 24 Dec 2024 11:24:12 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ31G-0000000Bqts-0r7I
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:24:11 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2709435f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039448; x=1735644248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WX6e8+xRzWDcEn+RVGBWf1zhcrd/OIfr/E/jWgNw0wbt7j7mIgRE6T52gHPMwIV9Si
         0efZKNS+q/uYr25ahpWE5lGvItlmzJPFzpQfJSA7Gz/VZLxsxcJGGv2bOrCubNCH9xcI
         G4GjX0GiTIKNTIVUbMc3mLggWbV2AlEPYKCmZFLaOiVHT37jOfWBmBa8scNgRkjofEtM
         KSSJUMQvM4h3bQGDFpOTDR9ezc9I539RFFB5wZDjzWmsQd4vD5Hqm/apADKKGN8iMb+l
         zgXbsinVRUWuCi9GZH/ySjfcDoLxzMBvL8rN49yl6I+0/sHW5TD6FAHo1/44Q/+5yIS4
         75kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmmXqEmKSKl30PWoEuBvh+N6f6rffImkHCBcXje/IK1+3DYi6pKvyFHyXQp8stkUcUqVqPDjmLM1Nw@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9tjft4wRr7UY/ZPOEMH0oTUKgZ32knjRfdLONrAAtKOosqQCa
	WHjbzE0pXvIfxlssTm5p5r9TUpWf5hzLVGMLisCnXoYmgC9Aq/Qt
X-Gm-Gg: ASbGncuvMqUQyNnkO6hA4LGiG5Cuyq6468ji9t+zVhcMfhfrfFIgNviwgGU3fptldZw
	YbcCAatn+QD34Z1P3haXuQeFBayYZI26RxmC3K3DeTDYF6b/Tht7VG9DOBnSvkubjwhgvvUPPu4
	cselPZWhqmd9ZVQp5qvVQHmFYjv3dPkochyuGUpzoLkk5ScUPSIf1fyicmKstVhzAKwX9adWiS8
	hmm0367cWxrpJvAgXkaUIQw4LzATloFvVz9f25AtA2JGQZsVoNm88iI459QjFhjZJxbu3Zbs7mj
	FQGfDJygeZ+U8dUfP+u4Kik=
X-Google-Smtp-Source: AGHT+IEClnOA0LGg9VDeBZvWnJd8cLzC9rNnhUXGi/IDq1dlXKtly6axMX9weBVTQfZ13RzFBNdpoA==
X-Received: by 2002:a5d:64e5:0:b0:385:fb56:fb73 with SMTP id ffacd0b85a97d-38a221f9bfcmr14887212f8f.15.1735039448570;
        Tue, 24 Dec 2024 03:24:08 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828e3fsm14085229f8f.5.2024.12.24.03.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:24:08 -0800 (PST)
Message-ID: <0fef1bc2-53c0-4436-8af5-9710e960bda1@grimberg.me>
Date: Tue, 24 Dec 2024 13:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet-loop: avoid using mutex in IO hotpath
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, axboe@kernel.dk,
 shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20241211085814.1239731-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241211085814.1239731-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_032410_247581_811504B0 
X-CRM114-Status: UNSURE (   4.19  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65DFD3C935
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gtL9JzB+BGYJOeTHTTqCGuoqpW
	XZmT2jmi3snJDpusD8274dk7cGNQ7+SO7qjW44GyNWka8es5DAe760b2hSEPq8+S3kxLtMa3FhySb
	uZNKYgvKdnjxtaUKtvgeO9P14drsCFF7OS+wwsUd09aBWpDxZq3n2eoqDQ7vLoVvD/KLBw2RHEsVG
	i/tn40oivAr2r//hu8XWt2NtqMihfv6ctw4yNIczidVfiWSjWuez3rDmRB10TqHZhVoMpzoi11jsm
	iFDHXT5S8ZKoLlE6Y96KaQKvM2BWBJ7Bwh8BHTZrr939Om+TfPWwqXDnICLT1oH3uTFdtyn9kQLMq
	LwTySBhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2flr-00000005f0d-1CQa;
	Sun, 20 Oct 2024 23:55:39 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2flo-00000005ezs-1r6c
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:55:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431695fa98bso13327755e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729468535; x=1730073335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CIfP2i94MimRE8xNI/wwLSaFMoq/XigYVWv0IO39gsdunERfqm3XI2EMOKmwDxQqp2
         BxV+yiVXk7UFrW6ndelMZG8dnglW0toLtYjPZeTbSVPTKTtKw4ZV7msq+4KpOdmnDFKH
         d0bRsSkfecdOO8Sa/PfscjyBkmNoeSnUE+hSJcg1mlQ9WPfEHAQWla/v1imcUmvMk72t
         P52qAqFJ7gQ8X9rJ12g4Xd7RZd+ZxUlhJjRoCHuix1b8mD7PbFY6zraQJbjBX8xqZUc0
         g7y7pEDYc7UdHwJmS+2nkvTqEmtpqcUgOaY39QCilr0OIgc7hPTNSf6qKUkEQ3bpPvmO
         +8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWQAtkeZvY4PYCjhcHcBKu9J9aPWov5V0KSQQ/78hu6cvbSOdf9PKBKML9NbZUDevXu58BbpLTQ0g/@lists.infradead.org
X-Gm-Message-State: AOJu0YzPZNu/A/G6rzCrS1RVXWXFEK2FP5LxWkC1ysk6ZVIHJQVSoJff
	1hjMzbQQMBN2/1vbPC20LMiwj5N4Qwc3GaKpjXdzmML8AF3LPYw6
X-Google-Smtp-Source: AGHT+IFyVFAv70h/AJr7FhoVOAEdezseZLdrbbHy0wgG8J5GYist9hhBZeIY90BpXIrVd9MEyxK+bg==
X-Received: by 2002:a05:600c:4687:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-43161622809mr66747635e9.2.1729468534620;
        Sun, 20 Oct 2024 16:55:34 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c311bsm37978785e9.29.2024.10.20.16.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:55:34 -0700 (PDT)
Message-ID: <0e7ca790-e354-441c-881d-6b12bfc7a115@grimberg.me>
Date: Mon, 21 Oct 2024 02:55:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] nvmet: rename and move nvmet_get_log_page_len()
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-2-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241007044351.157912-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_165536_488089_866C858A 
X-CRM114-Status: UNSURE (   4.38  )
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


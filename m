Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B22C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cvjH/fNuIwlQSqJdcvfFrpeTBw
	3xnnkQNG8ShGc/bjYGTqCQ4WfDjgKXFZ4jE78FEaPdeLtIC3Juv3cZ+5uOymkldCeMSfUnYVQYIcu
	IZQa5bIGAWNI8IucXZHntAc94jn5iTqIBg/lwYs7X3CvpeQT0vMJrNVwpeAajTUyxTVaS3ie2mOZ4
	cezyrtHdDRGOkD/T3mzW0uzhzlxXh3x63gVvMI88RVZz86LO2nAPk2lCq8e2UYGB77TirMVlcBJ6X
	7Qw+8epZdJq6+3k09XJ9Eiu1I8cpRBgOLtaaJXn62wbI7ASSTDxGrLiWweiFtE8J1FbHRgGYeTMYN
	yI/FIANw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCML1-0000000CsyA-356S;
	Tue, 06 May 2025 17:44:15 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIeG-0000000CC54-1XcR
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 13:47:53 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso3653063f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 06:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539270; x=1747144070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NvOIM8wz/LwC/nKiDFVQl/RqNIcxL3UQjIL8XFdet49v2mW17WWTPpZ0/aGGynFcET
         BkvjwL8xNpQ9seTnTjnKIzbGToYer3lPSK3mYkVmDOTPGrFvOkz5Z22JjpllfhJdsh7c
         +VJ2aDg+qm3a7H3tSrMR40fqSVpG1qA40tlFVV3DyKZwLdLD44itYVKmsGOww2SYtRwq
         e2/wfEyad2LlyL9XkNMztRC28WnKmKdRzIPloFxKykV5MsRs6k+uvsGAuVuHXw3fEq/m
         evbw9jZoHbPXpOEhhdzma7q2JJrJwsbo7L//sf8cDAkJ7CHhB/Y3s4CKCbSTproL9NVS
         ai/Q==
X-Gm-Message-State: AOJu0YzDMf6AoZMhVq4V50hLKFvy5NA0j4aYeGaSw48Ugn75SnE86BD3
	M8R6HPLM9n9j2/WEymmscxJet6Q1NuEHbfmszVFuSTowc09uwgTGArSELA==
X-Gm-Gg: ASbGnculLfvIVfv7BOTR//Foinj7h+GKb1cjZVSx+nREnt0Zt1NnWvXLP/s2T3xJm4O
	B3PQ9JyYAq/EwhtRRAfm7lpOgKVvThFaMWn+g7H6VjGGMo86GT3fBPEO67OfRxY4EjqJ8lhjjHb
	IDQoJ3yImgiKpm1uS7zU/kjkiGxx4kr9hyyPF404mu+msIQilsJ+HRhWvecp3Jiy8TK4AJAPMwM
	QtinuufpkXIMp8q9pLWPfV8nkkEajBlvmeHkJdbDGfno21IFOYU+E6FT+lleXsz6VznD4DOz0UV
	E8XagrnVSfTSV3tFm8Fhx2ZEsblpcwsppI4PdvupqvIY3IKBvkWEsvrSQpx/roBNk/bo/Q8Cs0F
	jZD63sg==
X-Google-Smtp-Source: AGHT+IFOJX6YlxnVrgxMK8YmYZahdnlE/xA2AQBbvJYVkjv0CgZMaoGxv+/f07H81htlVd0umQiS6Q==
X-Received: by 2002:a05:6000:420f:b0:3a0:7139:d178 with SMTP id ffacd0b85a97d-3a099aef9c0mr12596257f8f.51.1746539270462;
        Tue, 06 May 2025 06:47:50 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3c1fsm13873104f8f.37.2025.05.06.06.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:47:50 -0700 (PDT)
Message-ID: <b31b1bd7-c18b-4d97-8888-f145fa07a809@grimberg.me>
Date: Tue, 6 May 2025 16:47:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: unblock ctrl state transition for firmware update
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
References: <20250502-nvme-fix-fw-update-v1-1-cd7a9f3031f7@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250502-nvme-fix-fw-update-v1-1-cd7a9f3031f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_064752_405916_6CED3775 
X-CRM114-Status: UNSURE (   6.79  )
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


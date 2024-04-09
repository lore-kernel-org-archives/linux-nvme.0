Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD80C67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCOR0WJudJbzjB5pv2Hf85CU5+m3kodzezwqXEzi7ZI=; b=FRuDU+5uQPFYvZC31qelsozwAy
	d8vhvNYyGKm4TqJmyKW8MyOxOA6DC9IPdb8yu5DqwOBw5/S9P1JqtwmCfsERELmcKAyr8m9ZsQ8rz
	7bL+MWRL+7B29zEGzKF64IX0OmtvGmUZMR4cZaYZZeZrGUY1qjt6CuMtKPGaQyRdiivXdyDzzpsKp
	VxzNfleAAYU1mICPaN1NhiT3lquUGMzlSY2nv5vqvQHFtDUtpNrte/vAPYRGTbg/vY/7QIstlMdJf
	Kg0Ta0eQa3doRIR2SEQNmtkb2aPVT+J/eFoz+rp6geZee9NfGOdUyhsqBWuR8DjCfKuWbxM5onRM7
	/eFB6G2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruI0E-00000003hm9-3qOB;
	Tue, 09 Apr 2024 20:23:34 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruI0A-00000003hkL-0BWU
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:23:34 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343c8d7064aso998905f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694208; x=1713299008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCOR0WJudJbzjB5pv2Hf85CU5+m3kodzezwqXEzi7ZI=;
        b=ZNDMiEr+TQ6JSQdv/NYnjnvqzWLZvLsR+y14ZREdLfsLsULu+Uv6ceJaQ8xy949nk9
         ygkDb7/gOwWoIUm2Xd7+z14msSAQoWqi+AwhOI0QGXQ3G3EcHfxbbMze33D/NAjVpXq/
         oI5+UsYJzzfZwf8z2X15ncoFUYMsly/5wBIkE3n/hmcW0sfzVosMlW/u5cCR+5KeOcDh
         mCp645ooNnijCdZJWVb69dPAw7CNJ1LX1AOC3v9/rL9c8KLWTA2CBRF3Bje7bUMQY2Ds
         Ho7+/qKRG5ZggeLqHgsD7JEAKqULDaQWYtvedNXQkw+FJE9HWUmDmL2bPyptGwNnScqc
         EXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+jWVNq5nkZ+lkvhpEGcEjQ2cODAJjzTBeZqTiwiS0a5zJZjXv8r6l1kWHTwtLvgNOPru3Nk01RDMPoT6Gch4K1Bo1jcamdx5+FPGp9GQ=
X-Gm-Message-State: AOJu0YwjVT/cq6ebqmam2t9/vOxTXO+eINzJnfrw/XOlieFkzb7mIZ0U
	jTuXvR9UUgqSkagb3OQ1CpFGBuzNhCQlWAemUG2P9qWOhuBd+3j9
X-Google-Smtp-Source: AGHT+IFnaFGh5uosiCZ9pYjIkJ0Yrx9c2LHdTt/7noZRXAhQS4rHVxW5Vylh/D3s5fo/SVsxcj2Zgw==
X-Received: by 2002:a5d:51c3:0:b0:346:408d:4341 with SMTP id n3-20020a5d51c3000000b00346408d4341mr495890wrv.1.1712694207679;
        Tue, 09 Apr 2024 13:23:27 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f13-20020adfdb4d000000b00341c6b53358sm12222367wrj.66.2024.04.09.13.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:23:27 -0700 (PDT)
Message-ID: <f8c84937-a3e6-479b-b6a7-be5affc9a937@grimberg.me>
Date: Tue, 9 Apr 2024 23:23:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-7-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_132330_119690_F527F7C1 
X-CRM114-Status: GOOD (  10.14  )
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



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@kernel.org>
>
> A failure in nvmet_setup_auth() does not mean that the NVMe
> authentication command failed, so we should rather return a protocol
> error with a 'failure1' response than an NVMe status.
>
> Also update the type used for dhchap_step and dhchap_status to u8 to
> avoid confusions with nvme status. Furthermore, split dhchap_status and
> nvme status so we don't accidentally mix these return values.

What is the implications of this on the host behavior? In other
words, why is this a part of the series?


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948F3C77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qPyI9ifRPBg4EofQc4w/nSimaJ
	o+bwr+4W9bwW3hh53upVDkC/PRJzrmMdQnNSIHsLES8jrRA/AVaVNvnmIh8fn6NfYmTHScirDA4YF
	QAHRv6GJ8KMdu1a2Qp3JU0bCAGNbwWCESj8BQzBCaCGii0P7941XyUlARhdHg/9qeHukNvgMFIoUX
	fecwpEdsP3i+OAuC+VpP7OcXyGPP+8BZcpawNxFQ8lRRVy170q6SSONr+JWyYgph/OY06HedHhT9F
	8pL4RGrJMqBoGuPFms9L3VC8D2CYuSPK3UUlFv65YVMhplteJlRNQchfIjfV9XUM0sxM2TEZPK+Cv
	dIsotHEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMU-00G3kQ-1p;
	Mon, 01 May 2023 13:14:38 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMR-00G3k3-1o
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 13:14:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3062d33b5ccso155421f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 06:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946865; x=1685538865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=lRQjbL/t4nG82r35EusQUIZJqehBIFUZP2HghsqSJU88RHEQKs/F/9HKdxEUCTcoS8
         FbsXg3FGSGlioUvN7HVoK3cDKv7ITNMp6FXP3I1uCctZg92Yh77SuVLZy2euayMXoiLt
         4ZaThwWpfoTQ6S/othGmT84qabxrSEKlWOwSUfTo0eSFBTdDFRjmZaLuSJNrHKSNAAyD
         EIcPXb1xhb9uH/U7kSLAXgStOBikBwdgua8CifqntFdgPbhBgC+qDaZQpCYkocLxmwp6
         uMah0PORqby0pPseqcoVTKIPZn0eu1c0e2n87gfXgg4F2qQvYT3tGqvxYuuIu8tsF/Lo
         nKsg==
X-Gm-Message-State: AC+VfDxV9AKIcXK+gobVS+KKoJfftTEzVQMlJ3wW9/58dpQ5YkOBohXs
	keuF3trEeYr0Gjzg12ItQlUwB0WX9f0=
X-Google-Smtp-Source: ACHHUZ7tXKtozTsOhRhH5HzW7wl2yQ51Lb+hK7NqUL+spHuBPtE2c7EfFbonORMKUv+fMha1ej550w==
X-Received: by 2002:a05:600c:3511:b0:3f1:7fd7:addc with SMTP id h17-20020a05600c351100b003f17fd7addcmr10371524wmq.2.1682946865364;
        Mon, 01 May 2023 06:14:25 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm28346500wrz.75.2023.05.01.06.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:14:25 -0700 (PDT)
Message-ID: <6357c313-de4f-f3e0-64c0-1da577ebaa15@grimberg.me>
Date: Mon, 1 May 2023 16:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/4] nvme-core: fix memory leak in dhchap_secret_store
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de,
 Yi Zhang <yi.zhang@redhat.com>
References: <20230428073115.22987-1-kch@nvidia.com>
 <20230428073115.22987-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230428073115.22987-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_061435_622924_9033EEC3 
X-CRM114-Status: UNSURE (   6.44  )
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


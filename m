Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23FDC369B8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=D1BhNzgTfJtcIk5dBqrCMZt+lA
	6nb9Vokukq7tfB+VXBXk8zsOahEDTaEeJkVmppNlPsXX+CA+tHRJvDumzJ0TvO+1xETCXN52SIqHD
	KdO6vHwECusbgqAsU8R3nCvH/U/i1wTZhjsmtBWton473gVzDmn+fIRaVlqRxkxVF9rn/NAl20A91
	zfXAi3cRw+esUmQPPS+5ui4vBDxT/OBwVAOA3zpeDAmP/YJkxIzi0N7Q7R3hl033UVEeQ1EQBV2SS
	DUHjrb/gm723CqOflZxrXRimxxzUQtpJXrExi9vFlnjyJd/Sj+1xDR3hKP9u1UYtgpnGijzDFJOF4
	W+WMnpeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rzk-00000003gpA-0pyL;
	Mon, 14 Apr 2025 22:09:36 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rtx-00000003fLm-1d7n
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 22:03:38 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2634708f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 15:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668215; x=1745273015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nCcJxcTpYm/M9AwErElTkRdZOTg8NRVxONC5akLwtITfPi67FFeC+K2JDjSqVqWFeI
         vL0eEyBNFVlwm/TrING7MF/HvUAFPeHSPY5IYSNmWEykze54o1CcWrIdCaUb1a23YlQh
         Vzumlhpq/A26xW0by2GBGCHi5abIRocuoMAUSN1ZFD9QpR+uTYFEwmhduuc4ZrGAUSRS
         op/o2swqfaWeRfPDvbuqOIAjUhL2+srp4IVMnhPgFqBqFyscgq0xda4K1819KhukJMcu
         0PfXWS0iXBEsaBcuDslgmXrAqJj8LWDUof3Iny2oSRX0yRdQNIHPD0YhNhJV+u66phoc
         eXkw==
X-Forwarded-Encrypted: i=1; AJvYcCV57d4Q7hAOk3fd+qi6qBlgqtT0hOcn0DDqZtXDlsVINsshiMG/PUfjgqbNXiFidxl9PR/CRItFygR3@lists.infradead.org
X-Gm-Message-State: AOJu0YyHTmjUn5ZBAur/XiHTcW24W+/KBtfr572rlbGs+VcSWplEEF9X
	X4z+rV5cjfEBtuCylljchDvM7/+2L8RVcRZ3oA7qqhLkPHSxWDbZ
X-Gm-Gg: ASbGnctHr39p+gggR4rUjv+xTzLbz8aPgzMPqCoDh1PV9CXACI6EntbKxQxyJrHzNzd
	G54TX7FQC54dMcnYKjh4GOV/MwBIcxNgfNA8WNvGi9YpOiRE90y73jGcUqGTQhMzYZGuNerLHQ7
	tt7rN1BEuv59RMAHY3RikuU5Znj4/rj/IemJEWUhrTSdy46ez3U6nGKtnJ4AzHHJ0fl1VZsAwYA
	AVSdPyB6Xs+cawqUUb7XWdLLwFlQANFbklLhcUYtwYhp/PUOq4GCbEqJrr4ATC4S601VZAFZvuA
	8F/GwvyiPbn+5DEjtKp3pTDpTycgxTOXTa3d9AUnBlpfxkH9hJlnoGlSBNcjzGi28EGUtGSE
X-Google-Smtp-Source: AGHT+IHfdEsmFu/864gX8gIiagN26OGBA/PuXksjgQg/07RLJG4HW2z9V+7daiZlSjrheeNpeFC/TQ==
X-Received: by 2002:a05:6000:2406:b0:391:2df9:772d with SMTP id ffacd0b85a97d-39ea51f591amr11162968f8f.13.1744668215374;
        Mon, 14 Apr 2025 15:03:35 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96bdf9sm11929607f8f.22.2025.04.14.15.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:03:34 -0700 (PDT)
Message-ID: <bc6211e3-f4da-498a-ad09-13cdf2b4c5b5@grimberg.me>
Date: Tue, 15 Apr 2025 01:03:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvmet: pci-epf: Always fully initialize completion
 entries
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-2-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250408024733.690966-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_150337_422212_5151521F 
X-CRM114-Status: UNSURE (   5.16  )
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


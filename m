Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18168C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqZQrV/XzwOsxRcoa9RzarjdIIcoC8TyED19bYZr0Wc=; b=o4iXrcb2RRJKsKGEZQWhNSUhpd
	HW0XEKFGGCzva9L7kbpm/bir0grR2aMe4eJHW7SClh6jPPRKPX5o9C1/FiWmyaYtsNtv5w3jV0eBs
	Nk6WwRHRMHtiuagYV3zjg91EFj+2zuSSXxca2Oi9HmbodC8aPa7dMu/xswqXAasjsheTLm8yKqRTA
	7jDO8S532ASFEZfb5uWFrYbReE6gCrf7DRvcI13/j/1B7G/xKNavZTJ7rJ0fk/YhTO+VwmYhfRSEJ
	cXJU7HR8JqirHWdGhDliWMhkf4tEhZBq/edcNYR1BDl+m6fLEqg/zJi44MFGx4rEu+oiIgUgb5bhh
	jNpW+uRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXAq-00000008glh-1dLP;
	Fri, 08 Mar 2024 10:09:56 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXAn-00000008gkX-2N3M
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 10:09:54 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e79eca772so31443f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 02:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892591; x=1710497391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqZQrV/XzwOsxRcoa9RzarjdIIcoC8TyED19bYZr0Wc=;
        b=SnTjMuqJb9Xs0Lu5K5KwTzoVylqMQp8QtSoCBclJFk2kakg3JCiJO0Poq8fcCjOFBZ
         nqbr61zcqo9VeS1ddiljK6wCNPdlOkI/akAjhXx2dLO+l9UZw8agm3HsLXb+YKtQ0Y32
         yvNAQkRAWB6P+hCGZ/e/ZyG7DDDyTtYKeZPhrq5tgPTmwoIU4he0BiPdgDuta/w3Ah0l
         nSfA5wO5sW+eyjO2voe7/d54iB/JTIaVieGTFyFPIOzJaNQdukfI7t2JZV1eL+E739Tj
         8nuC/wKYdD4k8htwALsvquirAUpUdrsxlxrEsKOiKtGgUUVshwRp9xsTF0drNfi6J9UC
         diPg==
X-Forwarded-Encrypted: i=1; AJvYcCXuk49P14OVaqLRvFvtOwlbAbosaWZKpZuUavTOh+9fDxndrlB0OS9acloxSRaWIYx3sZv50IxlNi+rxO64I5c1IoJUTAIW+73fSaUUmFc=
X-Gm-Message-State: AOJu0Yw8cjepwjLCUOt7moogwy5DZuDb/eKLv7ZNyZS8ryRrkqbRP0b9
	98Nu0XAEWatbZXOcNPRSk/yNehPz/pUSARwI+XH7A1rmAUS4jFOX
X-Google-Smtp-Source: AGHT+IGPiOezysgKiskWm4w6mYNdeHoKKtPk5JWEyQfa75/eSn4zbs2x/KvaANk5jvOWJ/MpzqaJ6A==
X-Received: by 2002:a05:600c:5009:b0:412:f887:644f with SMTP id n9-20020a05600c500900b00412f887644fmr1023843wmr.0.1709892590718;
        Fri, 08 Mar 2024 02:09:50 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ba27-20020a0560001c1b00b0033e68338fbasm3537593wrb.81.2024.03.08.02.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:09:50 -0800 (PST)
Message-ID: <2bed335b-b5d4-4dc5-a934-f0f04f9c54f7@grimberg.me>
Date: Fri, 8 Mar 2024 12:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Re-word D3 Entry Latency message
Content-Language: he-IL, en-US
To: Len Brown <lenb@kernel.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com, axboe@kernel.dk, hch@lst.de,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_020953_632270_29A1BD95 
X-CRM114-Status: UNSURE (   4.18  )
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

Whatever is taken...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


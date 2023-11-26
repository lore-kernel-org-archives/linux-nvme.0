Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09F4C4167B
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Nov 2023 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=DsrhF12WEZ5dzHpJfMFS0sMO/r
	rSyIcTvdyvQF01N0BttU1kx7aO9aMz67LfwGYQ9nxxJBddtyMAtLncjygyXm6ofO0I9kXYxt//BfT
	4H7wL0LQwlo63LZyCOkI7XG1Y2zOyN+gKVVtG1R1G8vsitROwCc8SDPz7oE6m4Fsu5Q+fYXJ5dAio
	XHpoXvdNQ2/LE9w3pD4P01vQltvEGnFssXJMg57qfHYAjr0C8zLyvJhp2qyzV0Esku/6+TA7hpQvK
	w1O8cBc7aF9ZUN4dFkIV/m3ZAU8QGtAsPLF/B6qfqiFmCUxiuV3+t3qr3CJqc2vy8B+sc9tpK6Nq7
	xScq42pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Efc-00BEqb-36;
	Sun, 26 Nov 2023 12:55:32 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EfX-00BEp9-2F
	for linux-nvme@lists.infradead.org;
	Sun, 26 Nov 2023 12:55:28 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3316d855828so677971f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Nov 2023 04:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701003325; x=1701608125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Pgu3mi8nyTYPYZDLhWF+9aihA6yhL+HFgiIPLhf3KxC25zGKlBpxeglbljawuR46x/
         42W9BCgzBauUXsj/REC88cW09SUmqBneD9fYEDiGeyL0cx8ugq3roOrZHKn86aE0igAW
         FPgXJX2NRLd4ikXHvGpBBGNfLawufPEBQLlAwypQkKV1K3cctz1vleFcePkoOfDfhUsi
         LuXAhkGjyZeEmuVJ+jWmeerqi/V1fucehDP7khySytBj2DUMDMlUAljhZPrkOQybNRZc
         WLaARk4RYPYoYqrFDvWDd1ScsYAOVPgHAs/jBZbN7Gzr1cT+I9bDVU4+n0KmcM8xfZH+
         S1ng==
X-Gm-Message-State: AOJu0YysfeXr2ZcEOprUN8NG+2CHVTSpY2ONPvGZyDF54w3E0dMxP/5d
	trRVmviR9kiZei4gzA0kVsJMeXh2mww=
X-Google-Smtp-Source: AGHT+IGBw6B9rUECVBwX8uMZpbmnJuR1HR1p7f+AtesU7kD9bhcYOJOaHXzLDT91Tz/6N/d7P1jIbQ==
X-Received: by 2002:a5d:64c2:0:b0:32f:7d22:6311 with SMTP id f2-20020a5d64c2000000b0032f7d226311mr6570482wri.6.1701003324766;
        Sun, 26 Nov 2023 04:55:24 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id s15-20020adf978f000000b00332d41f0798sm9294435wrb.29.2023.11.26.04.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 04:55:23 -0800 (PST)
Message-ID: <017b9e39-f9cc-4c16-9d24-fbc9c819b9a6@grimberg.me>
Date: Sun, 26 Nov 2023 14:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: fix a memory leak in
 nvme_ns_info_from_identify()
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, emilne@redhat.com
References: <20231123140741.411735-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231123140741.411735-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_045527_756594_27802152 
X-CRM114-Status: UNSURE (   4.54  )
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


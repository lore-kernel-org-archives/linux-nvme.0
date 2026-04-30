Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27802FF8873
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=PtUY5jJXW1R6JwabR2tpcpWpg6
	GIJAGx75bNbq9fKCwhFGv3oNnbtOA0Yo57pw86rFMG88wBc7393CcAYvv6B9wPVQYYpmyWl/0YUm0
	4HC0qbsbhb9qzPd6M/KMiX1v5/NaIOW/qoTVJ0brJAJCvMQPqbBSDrWEjArRTAzeQQtz59G8f6gJ1
	ikZlQFxVtVw58cZu74TdK1IpcUzOjp+VNHLFLX/5wmjL9DDkRfyzY3lXtvMuTikKj+W4ajSjMgTtc
	IJ6bkWSHT3IgJL6zOnwbz1a8Ag4kdh92Jq5V0idXqcPiF1pLOZD7Y/yDkZFHvZHpa8oWzb/0RyYNm
	Ok0Fp9dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIRVl-00000005Xg2-3KGr;
	Thu, 30 Apr 2026 13:33:01 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIRVj-00000005XfK-2XXJ
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 13:33:00 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7645adbdso673651f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 06:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555977; x=1778160777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nDmG42OTdA/itatGGTdONbVOTG9JZZaBndUrLiRrCToKq/wWGT0TArn0ezckfs09z7
         T7NS7UsyCAVpn37kuPz2yvtO5oyCKNw2O2p55FevU6rxWpRlq6ub2J8rkYOFmVVbroRM
         Pbws7dAErx9OZ5Y/xuhOoevpWLAp0D5ySVgHcvkicG68xt1tPHHREKLMY1ABFtLEtZZ4
         2TsE94RbV3pAVizechdZOzKNi2oLMAAJp0vPnaQ3uClGKXc3fVUD1d7FpqHYzCIWHPH2
         mylvA+Vwm+zZ357RoW3t4kq6YWE9aND/pOzTA2iOGz352xTTqLGnd8/uzsIUqcuUM7Cv
         mb0w==
X-Forwarded-Encrypted: i=1; AFNElJ81z1ye6P4AGyZmnBATyI42dohW9eW55hCSRdXdNE+IknRlLKaKDrXqHqXrRH50QxFctLRwNUmOufsM@lists.infradead.org
X-Gm-Message-State: AOJu0YzZKGLupXC99KhNI/Kq/4Xj16FhTcMYX+/pK5D+m1ZHqwmdvaQl
	ZEBLVX2Y1LOK78fhl1HcTXxF1kEoZotKfDvqSybZJNVTLXQyzmifMzJ6/NFMzQ==
X-Gm-Gg: AeBDiespDqc6wVjYxh5RZGkHROH4l4yyNUDNXRUoBez9V2DifTzHF4cMk6GHMtPc4l6
	ckLEXa5sG5Woal5XT8/pUiSUK/yEY3QqHrf9fOwn0kTcormPdE2CCQyNDFdzIGSOYkAqt0HqMS6
	BbUIKbyaJRz82M4NrSelUNJIytJtD0qzsNJmcUTEZszeUec6VO83bvxhHZg+f2D+hAhkBDfZA4F
	mKdv5JfFc6EZAWiLYVZOpVQByIfEst2gI24CwsYic7Iui84qJgpBu6PqJqTZ0kLVw+3ZinNOZHd
	sWzzEJZ3YjXi61AOhR5h4QdN04JPZj3g7vIQsaB5HD+pUejMzduKTvwGB+QmQGSi59LJ/H1q37O
	ayWrxrLNkGDRLYBE6VJ8dvPMkLP54UoyJ7vdKdR8+UhA8Wkt3QEh8XllVwmnvf2TBVeQNP90ocF
	c/BIcODanHYPbnjTVOeQsNMjZtfIn9xfgxUIdJukV+Jrgd8RNzNu1QMSNGJNDQDcLJTDqp
X-Received: by 2002:a05:6000:26c8:b0:43f:e22f:606 with SMTP id ffacd0b85a97d-4493dbdb55dmr4584837f8f.2.1777555976982;
        Thu, 30 Apr 2026 06:32:56 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481b2sm13653162f8f.4.2026.04.30.06.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:32:56 -0700 (PDT)
Message-ID: <41302463-2707-4d38-a4ce-c895c9bd71e5@grimberg.me>
Date: Thu, 30 Apr 2026 16:32:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: Do not print DH-HMAC-CHAP secrets
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Thorsten Blum <thorsten.blum@linux.dev>
References: <20260430132232.91416-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260430132232.91416-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_063259_647573_F18A0C19 
X-CRM114-Status: UNSURE (   5.55  )
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


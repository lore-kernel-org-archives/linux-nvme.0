Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F044C5DF97
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ijleZso0LpOCRBUbj4KmSaX82T
	9v6hQK7d3kVmL5CPrN3zSdcLmGtIsKxDg9LP1/+UzPBjSmv89fwQ6FLBXQDbQdC3ep286Spwyibzg
	Lf7FHR4w07hm0dd2dS+01zZMOGn+gQVp/ntWganIfmIr3hhesQUE0Yf3h/1qCH+9iIMPyTyTMsuIw
	drRqaN+jOET61v++8u9BCIEvu+/clNMPrejdo6qx2MrGkbT3jckcwS0G6MSYC+4oTGFqGNdo5jRJu
	ezHytHERNrYUKwkeIsM/a8MNRnCQhmx3Hp2D4TvXesKKHRnbkLwB6QNaKF7XALHsjS6qThWzYzQpk
	CHL3WG4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtGP-0000000EoLg-0CT3;
	Sat, 22 Aug 2026 21:28:29 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtGM-0000000EoLI-0Z5M
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:28:27 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c52d920b8so314767866b.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434104; x=1788038904;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FdlOyuTiKoqh8CSJDCRJtqXmuSA68t+PwFPkyr2Ad2MZICpWewoi10VsAjzzecCb0h
         j9ZHPAIyV72S6x4FFJ2+AlJLa17llUeNiGl0DMBZPDFwZxmd2c+15W85CHt4dHrytaRq
         nGYMOgXyN5YtaqJTkaVJTa/6rpgidaScr8l0Kfd9jE2PAlqv8VMIv9ybCCaM8E0CwcBS
         MKA1XdVP20soCr9iTZjBPz9zR0lFsCESjJBpGSxGo6OAVcVbpfKjveHhEvt8GUhScsIY
         +uq3OQP66XruZJbFGGt1H6kSU5b9/h7OLptUNtE7eCI2DvVgEHzuDKKDe6HH3bTKmLBW
         dNOA==
X-Gm-Message-State: AFuF++nzSsneSBmX+jnYLCbZpK8+AEjDZq1CEJa5qljS+gt0+iFZaJ0M
	LrBfiPFeRcxXITp4gkguUTwT5OvSiSeWm7XDaHA9lriXUUcuvdidBiXt
X-Gm-Gg: AR+sD11F4hVi23V4QOK5JzpDhV8raZpdMeolV9sxyGmUivkVdhyW1JTGn8tPx9o/sMc
	iHdd9LSEBNJNsLIAFwzV0R5I0c81CVfRGJxvq8UGn144uH5zlKmOcgDs3WqdwDA9yaiQujOsetw
	UGGvqITbcaaqGF7wTBS1Cq8vidzJOSNnPmexUehPW/enFwDj5++R7nzO7X+Pg+Jw2GAiihCtyTF
	pgFvV2v/ACru04BictGx+ag1LNhcFF54w9SimE9p3qxJCbeyKOsN8r8VABFri5d1ZfxTgN6fiQD
	DkfzwdUoXbra+sBfz0EPgC4RD8D/EMO+DMg4+aX1L12kRZg7DbaGMt43s12JdIiI1bsmKGVFXf9
	6SSpdCt6+H7W42f0V66YRDlC73Hrmf9gzdLkiK8Xxsmp0FNek8VeWnJt/iIzasQui8R65zfn/Wg
	Wcou1wgtHdJISfYEwAVw6zN8An29zvMpE+OScHLq0K0BSssPqQwK5PmVunMTijOCt+nJYrRXYnP
	jsy5GJNH8QaHa1Sl+H8stI=
X-Received: by 2002:a17:906:ee89:b0:c20:f95c:9088 with SMTP id a640c23a62f3a-c246a30c3b5mr1757326966b.4.1787434104033;
        Sat, 22 Aug 2026 14:28:24 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b696sm556476766b.7.2026.08.22.14.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:28:23 -0700 (PDT)
Message-ID: <9b8a69a3-49d0-471d-a957-d755788d3f4a@grimberg.me>
Date: Sun, 23 Aug 2026 00:28:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: print namespace IDs as unsigned 32bit value
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260821230310.3937527-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260821230310.3937527-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_142826_204479_5E12CDA4 
X-CRM114-Status: UNSURE (   5.72  )
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


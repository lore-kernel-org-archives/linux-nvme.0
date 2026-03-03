Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A29E67A6F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2Ju36mr4bvkPwgZixZd3t2ngeaxuwiZ8lFBXsrk3Fg=; b=OnP9cZa3GX4WUH1PoRGVOH4uwR
	QAnKjDVI8IivsWMJCpck4YkoCnvSPw6qM1vC5qY9pZc6fTH3VoqNoHC5nuFZLK1uXj9tzjyU1aKXU
	Mab6nh550P4fVhmVATBpS594gaSd5t/rZvkvrXbzrZP9iLX9sBr/A3sXY2Bt1203CjB/Q3ZPCOUs3
	PkAlaeA79WXOkzC7s9H7dyw6MoL8yTy5hO/VoASF96Gws9+q5c+gSEzMJXHFzJqhFm3jutlRe9i3H
	5FkVob6Q5SBY3qc3ZU+QWs1qaoddUKnxICy9Hey+mN356JMToUykHkWry/DA/7Y0X6TgX7vmCn9rW
	7gq8i9XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJcl-0000000EdWs-2rjt;
	Tue, 03 Mar 2026 06:52:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJck-0000000EdW6-2CvL
	for linux-nvme@bombadil.infradead.org;
	Tue, 03 Mar 2026 06:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=a2Ju36mr4bvkPwgZixZd3t2ngeaxuwiZ8lFBXsrk3Fg=; b=CJp37keJU11I2ITRNqdJGGuIjG
	ynsGx2qgtMPkG7/BiG7exN5FNRhkX/Vc/gbDIi7B5aLAbwP/0/pTQafbgoJLW3i5yLEjZQoXR7Cz9
	eN8GRe3hOpasgV8uQ3RGgcbGUbH6xyyb9zCygFu8359J1BNlOg97FgTw/MlYx/8Vr3T2LoF9BvW/+
	eXeYtkUvWxGGNpdXHQuAympQLEgtRAHtWQIU660xm6geGqZEW7zRy8rTAVFCG6BeGbuEX1LlqzE7V
	2hjwnoGM8y/ZWbrTwIfBQ7QIueW5q02y2uZvoRj24t92j2FoMyy2MDBEcIC50bfzfQN70vDYvYBJQ
	Rs6c6foQ==;
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJch-00000001jrd-0ke5
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 06:52:53 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-483a2338616so32756965e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 22:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772520769; x=1773125569; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2Ju36mr4bvkPwgZixZd3t2ngeaxuwiZ8lFBXsrk3Fg=;
        b=S2Nrgk/bI8KFNG0VkYmvZvwY6XvGT//89qxmAtcxq7fSht1YIJZRuULOHCtiEH74OA
         KjWVY4iZssUkb1jP6bQ50l1rHNBW3wnHn4sNtXWXR/ShcbiHSAki/AwxhrNsz3j4ylzK
         VbTrQtmlc1a9UZoHqICAy4QKPBQwlPanqlcX8i3scn9afj+GZk7YJUWvkZxfDCcaiU8J
         yzqDo9LKJI1IroAoEhYfeS8747EvFePETPaX7LeubazRu5Ve8HufRsUpB3xleLI49duH
         YVPD9pGXBTX3OQRWSMMy/Z6deKZ/uWJyeVDWNTaVxMPuUEYAPQLxWoN+huSZPeytJxdm
         /aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772520769; x=1773125569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2Ju36mr4bvkPwgZixZd3t2ngeaxuwiZ8lFBXsrk3Fg=;
        b=EZdOImIF0LSkMkegK5BAyXigOlkP+QrKO5s39Vn5js4ujLqb1ygu6rtcvlwuEp6Eba
         ymB69BbX4D3RxuvxLdfh4ZrQ26QLwmiSBcllVFe3cfXOoUOfF/RLAIr5sJSGA58/jSg9
         /pAIfTxo6BkGAeDQvwcOZ0rifbvxfJeyF1joOjSgy4UasIZfFrFgjrhg+k+lYNtgGN1o
         wKmoy41wrU182nHf5eZAsvigw3w8Rfpvd5yqisTxgu8pAWOIiUe/0kjjJIFjyd6/9olN
         xzQwp7YBs4rmpssW9HO6xX7YSgQhIG3esisHJ4FgfbQ/ew6Si7G+1j7s1pGBeKVZ37Vj
         mIOg==
X-Forwarded-Encrypted: i=1; AJvYcCUOe8+KGNqMn/7KtKbpsOtdsWlKRP0VeBWumQZHYGS5kbeqj1dnL2QgLzfKyW0WFO7uUD84r0zFKJkV@lists.infradead.org
X-Gm-Message-State: AOJu0YxrHkQwJyEznmVHRAKidvueQk113xEk3A30wkOQhiEzoUnxTtPX
	w6ijnI3nTS4J/TcNglQrToNU77jPrc+sjPl0BlqYh18ePjZED7KFTgdFwllQtOeWxqE=
X-Gm-Gg: ATEYQzwijT5TlUkuIIWBc3QU7P/vuaQlh5cXgK5YlQZpb1uVry9n46f1WW0eK6uV1Px
	PUBZkBu9mLGBRvGh0erVVw58/GdzHK7O7cdaB3dwmjPJCvQIGQm41R61cl6fHt75xgixv2TYZTv
	XtGU4J49QTGWU/0Q8A95fyJECqEw57c3x0nMhoQlKPQ6bWHA04L2YCwwm8rCwlZfRSk3ToPArEK
	9MeWPRfcvEicbHf7vp60pQEEXd3RdEbqViGfTpteiqZiGl+1O2kjg2WWw+PE2+4kjovneDJlCE+
	1oZgHMWVyoh8vfkJ6G8H48PsbUl9UXRirBwMbd8GQjK+8Du5SrYFg7IOIN0BFX+RjRqjNmQS8zD
	/nHmHaAxUy9iQCfYwMC8sKImkBHg9E+E1blQm7jSLlySCcMSSmJh9/jepMvisG9g/ChBpZHtc99
	THcftoWXL7Jksi0qT+t3JYLXJSwPO8OTup6U7eUgD6esrX2G22xMB4mJiOHvDViNDdQm3UsjxXd
	6AX
X-Received: by 2002:a05:600c:3108:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-483c9c1cd2bmr282993795e9.35.1772520769194;
        Mon, 02 Mar 2026 22:52:49 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3ce8fsm329359945e9.4.2026.03.02.22.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 22:52:48 -0800 (PST)
Message-ID: <d79cb9d5-8935-45ac-b2f0-f86f0728bd8d@suse.com>
Date: Tue, 3 Mar 2026 07:52:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] scsi: core: add SCSI_MAX_QUEUE_DEPTH
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_065251_293742_65D43F0F 
X-CRM114-Status: UNSURE (   9.48  )
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

On 2/25/26 16:36, John Garry wrote:
> Add a macro for the max queue depth which is supported.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi.c      | 2 +-
>   drivers/scsi/scsi_priv.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
Maybe: 'Add a macro for the supported queue depth'?

Anyway:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


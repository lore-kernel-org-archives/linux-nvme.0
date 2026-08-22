Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CA9C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cPg0BybK49gdAhP+Eh5XAvX3cp
	qlInADdZqF9nd3YJU8E44elb1+5XFoqotSfMHowqjO51MJhiPTif5Va3dMjrBO4E+oJj7++8i3B3b
	0T9ds7FaqBkakvplq5qBbcSKnJw9JyuLODfLF/3bwogmWZQXSw8uXg4s0Sxu589s64rPGMEf1Iscw
	lUOtwkMtGvR09+Ffbj4PLA7xCeXV5V8nqOfk/rhz7V/tDpgu2IYD0JwVdTg0EtdiUOx+iqxh+Kjur
	LfdRKE3gAs+jQFuSl/JsK75+s4HNSSiXK0HKV00dWpyecPfkcgMkWqBxUsk/rKOJ93Nf1VcZn8RPr
	fJoYueFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuXL-0000000EsEn-0QkX;
	Sat, 22 Aug 2026 22:50:03 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuXH-0000000EsDu-3aFC
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:50:00 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1670dad7a8so393673766b.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787438998; x=1788043798;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PCE4cS4R5Lw9YxoRGNgA2HkFo28fj2CLtAxP/mdXyWyLdzedhO1ajFpxTuTVF1W2nI
         m0qFL5HCCWZa5daZ3DBwta4O6+73az3LkrDiOu3SqyOe+Q7sSQ9NDGh0+U1XuRuEMQGA
         fVSEYCASeD4gw+BHdeEWM3DEmNkrjDHSnsXhysncSruPctYyPObGyoxv1cYfd0k0BQA2
         j/VmzFiQDZHb7NYCWO82ArJ4hiuU3g7bYShLTX4i04yuatZW1H6XveVp5Z/8neWq5axz
         t0b5gbQBReqb4rYJibgKfcN1ZNNqLBBbyuKLUHLnaXugYuzPHtxNSq6jG90fWemjeXS+
         epeg==
X-Gm-Message-State: AFuF++nJQ9+fS8Um7zz+pOGc+lClGONbB/njqzcaSWnNtRUV9gQw9hIL
	yaTSFmDigwR6Ed5PKGICpapgqvU3W6Tc4l3UjCSw2tBr19H1VGC7xDTP
X-Gm-Gg: AR+sD13fVWXzYhKbgo58jguUkvTHrTD89nVUb55sQQsfjMUGcPwzFE39NAE8nbhj8cR
	C8nuFNV/2Al3rFCewpb9P2BfnNk2eWp0E4e1e+ao1c4vOWyp7ClZ+g6NTcLoNwrQUjFJs9k7yGv
	0BAVFEniHmyIZ1TObTA/NFJQt558sBjOZtqP5XrJN/FfDZTF+KBiFGmLZx2exxjT2QyowFVtQai
	EqHyxHHFGiqlZjZ4Xl0OKKfmtol9nC4qwHDa4FxzFx74QQ9PVO33O14D/78lF8bndnnENxvpzZB
	q3qO7YCDKYCzbCuZTpX2USsikKyt42L3aW61MqOoCxyTm11oEzRLEphUHCRMN4j3+NFBCEbeyni
	5dDQajW0508H0HUurRopcqi9WTAAvY8rzOI2Wnr/xQAsy+YbNV5/4yfGgIpGGfjvEZs+KLkY1kU
	3ZNqg3cfsFdD3ndyqnwko6qGYbTQos8iBnFg1JPTOEcBg5f8yoyb6V4XSAp980T6r4WNvDyjqJy
	CFQSp7xBQrbEQJ0AWf2D/8=
X-Received: by 2002:a17:907:9308:b0:c12:695b:8876 with SMTP id a640c23a62f3a-c246a39efb5mr1786532266b.5.1787438997905;
        Sat, 22 Aug 2026 15:49:57 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249689fa97sm413795866b.57.2026.08.22.15.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:49:57 -0700 (PDT)
Message-ID: <5bcbae43-ff29-4ded-aed7-193c99e92b6c@grimberg.me>
Date: Sun, 23 Aug 2026 01:49:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add opcode filtering for fault injection
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260811231152.1138761-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260811231152.1138761-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_154959_895232_62D0F0B6 
X-CRM114-Status: UNSURE (   6.34  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDAC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3opExwJGar/brDcNfDJr4P34OUHHIMhj+qBB8pcTVJo=; b=3Z9hr2pRrPVyS9yybNr9shJLyN
	8Kb4a/I5XtYWGC+6zcAotcCGXIN1r4cae4qlZt8ymj7ABbpPseCgQbWuWIoHNHaih4T+YGgM78G1g
	ZJt3WKFCLtSgWsJVEdSsCTa8snuSeL98Xf4UM2mcvQ8rzPd8TvfWuFMrorAj5DD8TfsB6krYe/bBL
	dUTP92KKe2sYW3YbDgZSjabYMv8rMkEmls3GKfrYoP9k3uv0zzQNYYfRsJB7sABMBHWXx1wEgD/AO
	1d5TGbFdKJTSRLRFAdV8copHeSrK5IMGR9ocGLAx8yEgxIuunw72ECdayWakoa+J7ov8xswQcwUQ3
	nJhd7Z0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwUn-0000000EwhC-1vmu;
	Sun, 23 Aug 2026 00:55:33 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwUk-0000000Ewgt-39oN
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:55:31 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1c52d920b8so326452066b.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446529; x=1788051329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3opExwJGar/brDcNfDJr4P34OUHHIMhj+qBB8pcTVJo=;
        b=XLVJ5g21WcuS+QAH/5zjPm9ATamfgYva3FBQYSNoxsylm8NU02gdZbdHCc2q5UGVj9
         i24NfsiBUfODRj2QDP6xNVlTUCrvm5xkrUgl6ZtIqnwm5lOiHHzK4LB9Dkg7zb44pl0f
         dA6nhnurGe2igy3nQqHsgYMBraG4Tmc15ZHdSTh6lera3s7/3ayptvGYV0Xaup49c4/k
         F9C6jaEbAa1ihouYqlQXeGLP3cAodXBDxMktR/isrxdfZjGIVdr21Ir0z2VDP1RK2i/g
         SjfbfGyK6IP460IKyC5gBAmwG1fxSfUJrASb8B0Uisc3Dn7dRNELYjg1Z9KbLPMV02Ub
         9uRw==
X-Forwarded-Encrypted: i=1; AHgh+RqJ2YOcLimsJFTsw5k83Ofs9vbgKbNzxcXs0+9L0F0IBMnVaaRK6Ja74odSXsI6zrlagHBlon03m/aL@lists.infradead.org
X-Gm-Message-State: AFuF++ktxHY5BxVAUYVrMG5oy9nD9vN7FN64HwRfED3+sLe/FkpX+0da
	fBAtdSlvF4AQdlMg9tcGakjWux6aJi+A5SiFJuz6NPHvJzvTSwIVLTwV
X-Gm-Gg: AR+sD11SO3/C4N4d5Szv8Yn/QVBEELuqHtwUNwjdye13LxSXTali1ZJHZeC5syDEs3F
	XXoVDIuN/5ZkxKj1atDjw5wokQRbDpjjtvJjjONx31gLYNTGhQn5G+qvqCpU5upKcoLZSgTuXBa
	mQsQb7AraW9vP1+YGU8y+ap4Rt0qVjU/2uI0MuDJVPk9kd+lFIhUdHU4tp6ddzCfdFvd3D4nmhU
	FwEimZyAI4BxgUIItUT7xuv39k61IJMVGE2N/IOT2k1qTEIzaFYCOWvpZXMNwGzcj62+dSQV6hj
	oCnPUM+jd1PgdL2NNXWlC6xcp7U2sK1YbcAq1kvLpz2wZqYsRg3kKzUtvqmDofoflKTFspmxFjF
	Usz5kC0yIsskrndduk6HghycxBFffQ8aoTlxWSvMS/26wSjdEautNod1STggWXjVPj5/30x+HKS
	cBVTA0KfO1Xs+qGZS5wpIRp6VkFYUIegqgxxNk0UALyeECZ1AJvr676UpaIfYDYUaVueuacqnpH
	LfgLrsj+4Gci4tF/2xir+9L97cBJb5EqA==
X-Received: by 2002:a17:907:7b83:b0:c20:fe93:a86 with SMTP id a640c23a62f3a-c246a62b495mr2065827966b.18.1787446528790;
        Sat, 22 Aug 2026 17:55:28 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629563dsm562075066b.17.2026.08.22.17.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:55:28 -0700 (PDT)
Message-ID: <5dcacf8f-8a46-4c71-b915-c2f938828ab9@grimberg.me>
Date: Sun, 23 Aug 2026 03:55:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/16] nvme: Rapid Path Failure Recovery read
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-7-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-7-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175530_806136_CE09CE36 
X-CRM114-Status: UNSURE (   4.89  )
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

nit - no caller for nvme_fence_timeout_ms() otherwise, Reviewed-by: Sagi 
Grimberg <sagi@grimberg.me>


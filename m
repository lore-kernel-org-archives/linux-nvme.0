Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466CFC6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIf28pv7axIYiQOjBRTA8yMZDSKvSQebXckvUnG4rMY=; b=k6p9wr7OsWL7oCdqSSLks+2xL0
	axGvMqRZ4rncYILsBYvBogJeOZLkzCKJ9JW/m1gssJQulqHaLf+7JICCLtKPNQ3Acq89mS9gS3T+W
	y549roMfT34KUENYw69aeYO/2wXFLQR8E4z+DkFFhMl4Y/wR1L7NaiTEsYlK8pEGf7BkqaUeKRucM
	8yaATW1Tck+pSk5dGpEZx/hbSqkAksWywMuDRavhx8HA14hGyccE0o2VxEt5LIkI/9TBBBc3fOc1E
	LKJJnUxLiKk0JZSzf/wfBWVmJ2Vla1cmBbhnAayfUsJPE8UCUPkfbGeAKZpzlxQznk+S0l90xfNXw
	WpQldVTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYW9q-005pbx-Ln; Wed, 14 Sep 2022 17:26:42 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYW9n-005paE-68
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 17:26:40 +0000
Received: by mail-qv1-xf31.google.com with SMTP id m9so12276475qvv.7
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QIf28pv7axIYiQOjBRTA8yMZDSKvSQebXckvUnG4rMY=;
        b=BLyTw0305B8drjWmZYAWxCC6ijmgcyeSFUvOpjkv3aHzSD1KNeacXv/+nG8ili63hq
         k0E5KUoRM7ng8NNuSsMC3BROJa/RTIi3C5xyYgJONVxrvQ8+sUbnb6aRKRaiDtsvK44p
         UQRw8PH7GgzTIkAgK4Mu3JI0Ri3ACrEjUtHyNIpCvbdnUxR2QxOMcR8YK15VrtQiiD59
         7yQMeY/7eRxdVjlOMpcngSLh5Qqj+GlVjTgk8VIoa5lBjciMjSLloo8HP32wcoemECTp
         t+64qnPP95XpOZHbcL27vTzOjzUFJKwxaoLFzHiYvXN3rYUCNKS/Kqxxep+cdPdqtSwX
         MhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QIf28pv7axIYiQOjBRTA8yMZDSKvSQebXckvUnG4rMY=;
        b=hyCQgBqO4FgAonIzyuvydIiQj79yhG7/dccAltdNFYYf9faO+NLiBoGOmXVDv8Ke6H
         S/DN2/s1m+hv4ZrnvbUKLyET5y/akX9yJnCeruGNbC6+v9TAkfl/ol371IqNbVZ7Abvv
         WkPta47UkswMNaIwlPscbg+lWdhRgw8fpnWHMRV9IZmMhCckh84sAzNlYDv9PbKNJUle
         700TwK57+jFhgWIOs4HYgQHC/iFV1fE9IOt2IpgEmr31bMe6llbHaYi/tkIMhFzK5KJU
         HqRPGFkD66ZEJKCLmqFkTCwRaHsdbP1hh41JRiTLjTpDhSROgncjnuIrgmMoTI+lnNq9
         A9TA==
X-Gm-Message-State: ACgBeo15KqsXbSJAnY80DNhafGwqbNzQy6c/ajdp379DqEVKpHonu+AV
	r4YmXVm5SUehhU17v6dsu5s=
X-Google-Smtp-Source: AA6agR7HdXB0LMCUM9v7CsO1LhPYs+AgAwzYut93gUhTCM28FPfsSkhQIDeY2kt0RvnBJ0PSrQPc/Q==
X-Received: by 2002:a05:6214:1c47:b0:4ac:928e:c3c6 with SMTP id if7-20020a0562141c4700b004ac928ec3c6mr20385892qvb.12.1663176397963;
        Wed, 14 Sep 2022 10:26:37 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f902000000b006b9c355ed75sm2161442qkj.70.2022.09.14.10.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:26:37 -0700 (PDT)
Message-ID: <917848e1-5650-bf1e-7dce-3a994c453c38@gmail.com>
Date: Wed, 14 Sep 2022 10:26:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
 <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
 <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
 <bf83b747-e6b5-57fb-0de7-e2fb646633aa@grimberg.me>
 <73b6631a-1ec5-5a46-8f2a-f816acdeb97d@gmail.com>
 <0d34d7e9-b5e1-149c-aefd-aa3bf182ad94@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <0d34d7e9-b5e1-149c-aefd-aa3bf182ad94@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_102639_259661_F0D54860 
X-CRM114-Status: GOOD (  12.32  )
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

On 9/14/2022 8:31 AM, Sagi Grimberg wrote:
> The fact that the event is called rediscover semantically means that
> this is the discovery controller. It would be weird coming on any other
> controller, even if userspace happened to ask for it. If at all, I'd
> prefer to fail the parameter for controllers that are not discovery
> controller, which is strict, but at least not resulting in a weird
> event...

yeah... I guess I fell into is "rediscover" because the controller was 
"rediscovered" on the link ?   vs "please rediscover on a discovery 
controller"

either way - based on other people's input is fine with me.

-- james


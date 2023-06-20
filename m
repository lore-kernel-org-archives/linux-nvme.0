Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06420C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WS5s1vsNpWXH8PMxNLyz58xjeH
	nv/FLST9dCOK9vXxTb667PSLts2eHIA34TOkNVJTvJEyY7uUYTpWh/lLPPaVtDtpwOK6m50B2xBzz
	y1tyB6sNJEILG7CeoPjpI4uqPMGxlaO66K6kGpGNeEA32RKzWYrWDYL7OybQ+zyyBgX9MO3PxClej
	SsfbT6uhIZlIviaslW/jYheVlvaOBzWkYc65TSZXImuCtph7JhplIrKfPscOKFqSux2qwlbngZ/oU
	PICOTsDzJa7ZL6RImwBg90g+6u3Fm8r9aZdvyg/pz0A7rp8Z7MmczqE/fRB2N1cqtZiUYdILEeoZn
	zPHVTohA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBc6c-00BVY4-0y;
	Tue, 20 Jun 2023 14:13:14 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBc6a-00BVX3-0d
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 14:13:13 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f9085f97a4so8704635e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 07:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270388; x=1689862388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NMcmPs9sWiWXv0y8WnQOwji/62fcoJtQ4sLHkMzMMKdXxgwRxtEoBXlpxKzi4Dgkgd
         mnrVagAvV9cgmzu/O0xP50sAX6Pis+FtzEZ9l1ki/8s65VxY4lAZe4+JwGpJq+JRdor4
         yYiJP+WjIxj9vgBBpi3e9Z+LP8BBVQqV0K1jajoZIsWC7mxW3r8xlkvhFEezp/E5ywDW
         ORT9Uo2gePExLg0RN/aZDOjcl6DT2uYDrH4tGMP6EieLYfElBX2PZpZlBclkvWfNGBY1
         7BnaIbkzjtAwwUqgY0pUfOUAfdG7WLDI/cdpkmaLeRfoq444FZve02rZmm2L+fX3Ay38
         WIyQ==
X-Gm-Message-State: AC+VfDxrUEwlLd4Kd7COELpnxjT43VscFwIbWhRhUXteWlPITgfTN227
	7lyKDrVehYZNA9zA3EsInLA=
X-Google-Smtp-Source: ACHHUZ4g3isyRwCrwcjd2Om7u+FTf0FHHIAZ/J9ebt+mRhj31XdhigHftz/TVnLibCmotJ54wqtjTA==
X-Received: by 2002:a05:600c:3c87:b0:3f8:efad:31ee with SMTP id bg7-20020a05600c3c8700b003f8efad31eemr11170736wmb.2.1687270388436;
        Tue, 20 Jun 2023 07:13:08 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003f907bdeef3sm9769924wml.26.2023.06.20.07.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 07:13:08 -0700 (PDT)
Message-ID: <eb0d768d-d395-e49f-c478-394f5ce9f656@grimberg.me>
Date: Tue, 20 Jun 2023 17:13:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: leit@fb.com, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
References: <20230615094903.1341683-1-leitao@debian.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_071312_232504_FC386C2C 
X-CRM114-Status: UNSURE (   7.57  )
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


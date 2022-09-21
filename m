Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5636ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 08:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=h8l3K1cEmf3be6Q8DFf4NHyGwa
	Wr9IkGgeEyYz2ftJUKw/dwCgl9jH8caTVMivxdl7N9DkGHdF498x5sgXgpqtVeYfU0qYwniCciiDO
	L/DIrP+7Kzm7jR/CRuTAMZBxedsicSaY/1fKlCTP28mWWnaL03FV7M+OTjd8LHdNvGISFNknYoPDH
	0testgxN8kek6Y6ReI4GE9dtA48Q48NLg5opy6ZvFI3lVcbIsRXlFfT+JUhnLxWv0DgGGzRGPIctf
	GE9d+vJrzKVL9UCCi+NnpUDeKQYJi4bxWRmeBBbwa5ldRJfKYsxhO10gOidzZ52XrcuYOmlVDm6q5
	OLgUeikw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaunR-009ojZ-Fr; Wed, 21 Sep 2022 08:09:29 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaunO-009ocy-F4
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:09:27 +0000
Received: by mail-wr1-f49.google.com with SMTP id r7so8552950wrm.2
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aY9nHtBxcHyRw31dNy6HR1KKA0AEpXkCjSP8n4AyZLkPDkj7YBfDstzivj+PW5osRW
         ZWPh6GZtDtTiFmOzXm1DLBI/loNz/R1WXGywJWxvpT1CKd3goeG5wKGl7uqjHQh1Oy0h
         0CKRNlcGDKXdGcmFOlUU9jm9RusO8/A1KedBx66VCKAyhUUJjvjYHeQlk/3wBVtNIe2b
         ugHBEh8cT2pnsNFd5aH6Hs2tbB/6+MZUn8+D+n7632DZQNvduBAVu2piZbjY9uYQeNL+
         FDaEkRG7u/HQ0qwIVz8WKU7funvwr2IAa3iWXgXYwejA6r8fcf/Go/UEo6KtT7rV1/N+
         IvVQ==
X-Gm-Message-State: ACrzQf1HU0Ifh/m9hCivHOFFJ1/4OvSXwGVmIBD9sQXd0V9XmzFNPRip
	A7cPlueLDsmGAXx+VTMgyEs=
X-Google-Smtp-Source: AMsMyM6OfPT5BsK8hSHBiomkKy0aauzpsc4chLZgCr58WybRTYo1eQuWEOTVqnfE9P+n+1rheE8qbA==
X-Received: by 2002:adf:ee86:0:b0:228:6fe1:371 with SMTP id b6-20020adfee86000000b002286fe10371mr15820242wro.684.1663747754169;
        Wed, 21 Sep 2022 01:09:14 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q18-20020adfdfd2000000b0022ad393ba3csm1739372wrn.107.2022.09.21.01.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:09:13 -0700 (PDT)
Message-ID: <1d22d110-1c77-fb3d-4fda-efd8304a6e54@grimberg.me>
Date: Wed, 21 Sep 2022 11:09:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 RESEND] nvmet-tcp: handle ICReq PDU received in
 NVMET_TCP_Q_LIVE state
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20220920183444.5115-1-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920183444.5115-1-varun@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_010926_509154_65D9F079 
X-CRM114-Status: UNSURE (   6.17  )
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


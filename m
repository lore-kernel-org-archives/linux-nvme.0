Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7CC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yEIv0mpPqT6iAHQ12FfnifyqYoeAQW4rrtrDxVFk1U8=; b=z9FBYGjqapdw+xi4ui9DKsRJSP
	yl2CA/LIy2LdPHB502O5IcYCjEYegfwMYGvH8/ZvpUqD8FBYE257uEyUYe4ivd8A7QFgl6DdXuFUD
	NSoFD61eltCWATy6XdC3rZcltsMiPdCRbTa//t5cRLkfi9IITmQn7UOleuFdsojnRdx7/mTeLz81P
	c8XqMAq7j0wGv+7ljLh3tQwy/YSG2/FNkLTz5M9lkD9UaZu92I6OUfeKVbOGr7B9y59sVOwu18KNV
	cVmLWxEs9tm5AUOf/r9sFPZEJa3LiQrUEDSGhTOFnnmKZi5SbTch8C8/GI1pLxe1vktGbKmTxtoFN
	jclQ660A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psAbt-007kVT-36;
	Thu, 27 Apr 2023 23:01:09 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psAbr-007kUx-2d
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 23:01:08 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b9f00640eso2060709b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682636466; x=1685228466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEIv0mpPqT6iAHQ12FfnifyqYoeAQW4rrtrDxVFk1U8=;
        b=Do9/pqSIjG1lwOjGDZ90CWJjHVOBweqpeo0Zs/cqh502uf8tNs+7ry8nJci/0hYzvw
         VxTLFS1CaC7cfPWLwL7Xn1IwAEM7cahAGBIvx6/NEtqeGvjDeZ68+eed7WpYXGFxl7ec
         4EWirWJfUxVNUh5CXYuucg0SDYJtmd9L6HJfkNc6XtcQeWpAirjDxNi5M9+K1JmccXCO
         vPpn8p+5DT/LzB9Y+UZE8sL4aWzSnR5E24wTwMqmXmN6IZYznyDvlFnFO8MvajagvmmD
         pf3GY4yYkBH6jVSoq2VQaqdS7gMYynCinRL/cnQ+gZRNMuFi1oOMRqOdhxuzzqlp0zfI
         45BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682636466; x=1685228466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEIv0mpPqT6iAHQ12FfnifyqYoeAQW4rrtrDxVFk1U8=;
        b=cmXzwt1FxwywNwAGbjlqyXVcYlzINYn6FKxWryksyKEYM4u5ZBDOkcyoG94loxZepg
         7wUNAXg2dsGTvRf5jtLclMALMlfUa5iY33UoZbDzzndf3mFPufW3+plms49pZX4strBj
         5tdvctthR3OdQC0tW1wlu5vE8NiQmxwy1P9rfxMUdBDrTkqnwauF07QmcKG9i3c8NCl5
         wOOM4+jxWOpwLMpHmxN2XkcDx57f7nnb7O41gdsvZ4x+oQHMvvHB+5lTvvOXsyBICH1Y
         tDpG9nxn90D4uC5v7GKNj2gs85ElOl3Gsy0OMp9mEA5NZzgzo9sXWSI3qp/G2UC1o3r7
         22sA==
X-Gm-Message-State: AC+VfDz61pjsfG61h5MsXqkSwUSSP/qVUg8csTKqw8k9kCqt+YjXOvTr
	krlNe6rhgODRzWYREHDm/rJ9hg==
X-Google-Smtp-Source: ACHHUZ4agbOrasu1chzWjy354jO+EEIA67oWUAcf7l6h4rFBDwFZ9No+KBZyh7mgI5P40TQdekIg6Q==
X-Received: by 2002:a05:6a20:440d:b0:f8:ea21:7c4f with SMTP id ce13-20020a056a20440d00b000f8ea217c4fmr3472983pzb.5.1682636466237;
        Thu, 27 Apr 2023 16:01:06 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f17-20020a63f751000000b00502ecb91940sm11903029pgk.55.2023.04.27.16.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 16:01:05 -0700 (PDT)
Message-ID: <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
Date: Thu, 27 Apr 2023 17:01:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_160107_857155_2CD39A27 
X-CRM114-Status: GOOD (  13.00  )
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

On 4/27/23 4:59?PM, Chaitanya Kulkarni wrote:
> On 4/27/23 12:47, Christophe JAILLET wrote:
>> Group some variables based on their sizes to reduce holes.
>> On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
>> bytes.
>>
> 
> Although this looks good, we at least need to document what
> happens on other arch(s) which are not mentioned in the
> commit log ? is there a possibility that someone might come
> up with the contradictory data in future for the arch(s) which
> arch that are not mentioned here ?

The change is certainly not going to make things _worse_ for any arch,
so I think that's somewhat of a pointless exercise and an unreasonable
ask for something that makes sense on 64-bit arm/x86 and saves half the
space.

-- 
Jens Axboe



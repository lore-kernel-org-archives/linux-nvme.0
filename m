Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C22C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Feb 2022 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gtS9EQMTZ5QMxnTyQJHQTIfhNX
	Eve+RC83sL7sd9oIDNR70zjIi2H9fRqBpPgDtzjvkGPC2Vn385sCBfpTsEY8SJefublswfVdR3Unw
	RGuumumVuSSrIG3dj1rGwzp6DjHfBhAwwsIH7yQR2hC6dLIAzdydegLIA4dK6C+oYxjASi5+zT5N6
	OTtvQTYJ8nmgdH9NUlBpsqNmhMswqIF+j1WveQ6BbyPjLbUeoa+mhWnol4vgUbH0BMW9YvqjPwVby
	8UzYHNkQNI/OJHNPwUT93Y+u4ZKZGLDWlSR3c4SArf8kc04j81rd5Lvh2ZfHfP9Ois1/QvFxdQXHh
	LhaKXGmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nLljl-001Lyg-Ag; Sun, 20 Feb 2022 12:54:49 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nLljY-001Ly1-LS
 for linux-nvme@lists.infradead.org; Sun, 20 Feb 2022 12:54:38 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 l123-20020a1c2581000000b0037b9d960079so11814959wml.0
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 04:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=4QqOEWi3tvLdO8qId1A5oG0Y4spGMN+585wQmApCI4Yuy5m01FaSN07FM/1J2bgd+J
 07dnQkvec1hTOKHXyBWhoAaUhuht696uaNB8RIAzCs8g9eTt3WscYtnwu7m51KZ9WS88
 th+w0Qv5XcnZO1iH6oOyas7vYNOK/Lvq9jEDKzny8tRbFoVcyDTtSuxe3JiRMky9MCG/
 91TXcFqUMcV0jqCuyNK00AHuvj5gGZRrCQ7/5dByNLLDERJarh8mtTaQy9C9gU64dJiW
 dRRXxsYPtrDfhm9yb1BEzO4y2BW3217UCiZBDrVejfIjzyMqPIKG7pNFpqfku29wF8Qy
 9M0w==
X-Gm-Message-State: AOAM533i4y7pczkVTnlg3BNQZX3swquMHfkwalcjc4dcmNcG96jccouQ
 pPd4+4F1HcO0+eqjfotqoWY=
X-Google-Smtp-Source: ABdhPJwesN4qZXYPRahXmELCsDeaf3rKfGEZHZhnNHEFK0/FYIo0ldgsNgd7qLel09lUWac82aDRlg==
X-Received: by 2002:a1c:6a03:0:b0:37b:dda6:4259 with SMTP id
 f3-20020a1c6a03000000b0037bdda64259mr17968622wmc.20.1645361674485; 
 Sun, 20 Feb 2022 04:54:34 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n15sm21058438wri.80.2022.02.20.04.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 04:54:33 -0800 (PST)
Message-ID: <639070a3-ce83-9e59-7aa0-bb2f62d1d608@grimberg.me>
Date: Sun, 20 Feb 2022 14:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] nvme: don't return an error from
 nvme_configure_metadata
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: dwagner@suse.de, joshi.k@samsung.com, linux-nvme@lists.infradead.org
References: <20220216141220.4162670-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220216141220.4162670-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_045436_732166_99B44696 
X-CRM114-Status: UNSURE (   6.73  )
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


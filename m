Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3F5E728CF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J2/eTj4ZTeW96Njy5Yu8y4iGoVQL5PWTi4ftqXgho1g=; b=2IfkQq/DzZTKDJJB/ewFVTiJnn
	cJMf11jVXRTDSvmuZjUrI8GVa5NSzGbKtm7wlkIE4CJaMTNxZISi2BHYLUWh8RK7CDdc5XZ3TdNJc
	bsX019JF6mk94aEKvXLRSNJ8qMhRR3XbersYoKvj+zoxwKou6Ma1dFzp8F9yUchf0Wh//X3rIjC6M
	1H0u29fG+CAAEz3HgMJ/WEsyL8ohrJIG882IPAXQnTa1Zwu5bRu2e9hBMCfqQqI47w0K4ze/vp1x+
	kXt/nvYOvsfEJF/4xqxQ0HhMLxcxazH5pgw81lc2DZOgZJ+ZOvcmIQRU9GhqN1nAe39oF/W2GL4On
	FsJHNcDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmHef-008MqG-0H;
	Fri, 29 Sep 2023 17:51:57 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmHeb-008MoP-11
	for linux-nvme@lists.infradead.org;
	Fri, 29 Sep 2023 17:51:54 +0000
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so11563450b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 29 Sep 2023 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009907; x=1696614707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2/eTj4ZTeW96Njy5Yu8y4iGoVQL5PWTi4ftqXgho1g=;
        b=KA/VZslmw9o6s1SStqTwfNqI8O9JsLKR838zsCfYodG1LA/NY15LbLZQ1Qa7ucHo0j
         CBOovr+S/J1W1NFK6zmGW+CoCj6UzLkmbWGBBILzYgtdAFUCMjXfZiHJM8S+slVt+Ciw
         rjFzcZW9ZwqvwWZqRgMBS4WnePVvua4iRn1a/csODbjOb8Q/y+z4wc80ausPbPZzxxiZ
         +5msTaM3Be7LO7xn7+4QTV0N/tLeffJGMiKIB3SfdCoAnjl9tcVlhAznNxA54uXtaQNi
         y4UYfvO7WhjZsIm+uD+R9w0b4u5Uuj49GDn19g/o6KBwUErtpCnrtGZxriPZuRJT0qsS
         TKAQ==
X-Gm-Message-State: AOJu0YwqHpRZ4dqKOEUxjcHStJZMCXwggCKfdp6nMvC7iiRDI9xp4EAI
	lqooG7TFa0CcISb7i5z51oo=
X-Google-Smtp-Source: AGHT+IGOOjLnU6w2a9/rCpNU/gUfKj+HX8K9T3Khoyfb1oo9lzEzxrnEv7Kr7MNDQD94unm8RFU33Q==
X-Received: by 2002:a05:6a20:548f:b0:161:28e0:9abd with SMTP id i15-20020a056a20548f00b0016128e09abdmr5716860pzk.16.1696009906659;
        Fri, 29 Sep 2023 10:51:46 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c73d829fb0sm2953239plb.32.2023.09.29.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 10:51:46 -0700 (PDT)
Message-ID: <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
Date: Fri, 29 Sep 2023 10:51:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-11-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_105153_360345_25D1BA1A 
X-CRM114-Status: UNSURE (   7.98  )
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

On 9/29/23 03:27, John Garry wrote:
> +	if (pos % atomic_write_unit_min_bytes)
> +		return false;
> +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> +		return false;
> +	if (!is_power_of_2(iov_iter_count(iter)))
> +		return false;
[ ... ]
> +	if (pos % iov_iter_count(iter))
> +		return false;

Where do these rules come from? Is there any standard that requires
any of the above?

Thanks,

Bart.



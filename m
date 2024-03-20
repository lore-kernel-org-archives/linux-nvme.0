Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8F3C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=CoUrlBUCYl/TlY7I5W+qITBr3L
	jtCjZ4Aaj55qqA5UIp+WI4UnoIr50FiYQ62zNDExcqPH+h84l/U4Gu4lHrZuvbC5uBQgrai4gd60I
	5W+djXgVfr9FrY7WpZCMJVBsPk5fpbfq5L6kpXu+ClW6rlbVdLqV6qDCnS+kw1KWGEggtm8eFlbZs
	UZA9ml1ECicgmaoBTspqGzOJxTkEzM2REDHAbNqBdXpmkDHYls3rriZitBm1ytb8qejWqRJOC+Cu2
	GhUCQTzfAqn8skU6cP90uhpYB1ErcXkX0bIiEBK97p3xCk1PjefpL3n27cgB94soqvaTqu0ef3ith
	2B0fULgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtSU-0000000GpW9-1EOt;
	Wed, 20 Mar 2024 10:46:10 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtSQ-0000000GpVE-3v81
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 10:46:08 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso1295926f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 03:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931565; x=1711536365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FSnrPLkGM5whU2Qi3zU1lsvg7FXQ5NfoBNa6sw+u2OA7Ic3XOaBidOfw7dVwR72PR+
         QwtjTpIXOLMx2qgMzEJztYZEdIhZPyogA09ftPX4MgsRmfn5FrBEJlVK8H2I+lg/E4Tw
         M2qOZa8G6F1lus5qS+zUB6lGKrNk/tbkllYVewWeMBsc2T5gKbTQTnVuv+EL8ud98kcy
         zyObAZw1DmGk4aPV1g6UYcyqiXfUwyt4c+ao5KajLu0/SS0XjWtVqarX/KAtKeUmUjcC
         zd32NZBP1ZLNRN/3AuBAgmX6ZNNbeDEsKBaTR1LJ6x6PqMjCrkPdV+0sTNcOoRsSw9n9
         ig1g==
X-Gm-Message-State: AOJu0YwDaDupv1PJRyH+oxVFyN4mk61xdW9eLURC+WGTqKe/TtoZ/zBF
	/ywqN3Egj0zA15CB0aI0BZbmmcyZNSZi22Vq9Bz6WYmUobzQ1Roc
X-Google-Smtp-Source: AGHT+IFk93lrHBpdP3kkvj9WuuoojytXLM8LssA/bOMn0tS2unQWF28PxbdmtL+SmNWLvHG7bfXo+w==
X-Received: by 2002:a05:600c:3b86:b0:414:68c7:1887 with SMTP id n6-20020a05600c3b8600b0041468c71887mr1039970wms.0.1710931564549;
        Wed, 20 Mar 2024 03:46:04 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b0041462a42c82sm1761016wmb.17.2024.03.20.03.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:46:04 -0700 (PDT)
Message-ID: <7c653e38-289e-4c83-9141-f1f058bc7a8b@grimberg.me>
Date: Wed, 20 Mar 2024 12:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove redundant BUILD_BUG_ON check
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240320091949.20791-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240320091949.20791-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_034607_010158_26C31273 
X-CRM114-Status: UNSURE (   4.87  )
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


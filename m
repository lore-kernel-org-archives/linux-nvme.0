Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E72EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/a4ZoeUIQd+ndOko8895m/fdnD+arM41bba+h2c+H8w=; b=qnc3+/oi6Pkf6HTr59LbmbEaLE
	h6cKoSZuDLu8RZ6HW6YNFoJnpv9+j8/7uTuGq0tkHPeC/+NmhrLFXx2HvvMIwR6TLjRUmOlLXuPql
	O9z7gvTUoni6q3KwnB2fP++19BAGFY5uHKkgRKbQkbuIVIXH4i+pBgPTRD67xQ/grjMnOOBpTbv56
	MxHBTESE/hWRnRZD0C36kfpWJf9nVKPz+RhAa5BP3Dr2t1+yUf5onNv4tm6xBi6IyKOU3woUZxVRL
	V6VvWM2R7Z90ZfN30LuQk+Xlb13lulvpGUMHh1PfNQ49/22wf1xUGJd85iEzB2IWGjpDs1DY3D0A3
	+50LRSBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5m9-007Ki4-0v;
	Wed, 19 Jul 2023 11:55:25 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5m6-007Kgw-2c
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:55:23 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fa86011753so11643195e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jul 2023 04:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767720; x=1692359720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/a4ZoeUIQd+ndOko8895m/fdnD+arM41bba+h2c+H8w=;
        b=VDWqSIQ71y2mQIw+jPh5KkIGmvdDyL0b3NQptdkdX5GG1Y6b2HBpqJ/6dFtnBfPVWn
         a7QTCZoO57qJ3jMsOdBGxySzlpa2JMNot7Ew/OGSvAfZT/iyWW1sRyKd6+vQgvB0olbo
         ljE+r9zSciO8dKLcUuCzRZSG/m3QAlcStdBlBoKL2um+9gg973ArjbA4zi2BGqkSgHxV
         tdhQ6wnJZW0xQTeGd2u6kzn+i1UYffK4sp+W9H83Yu2MmrlxDZ9O7eciwyGJ8UafDyAA
         w0pWA9lnPtvAHFyb0Z/BER+bTte2xxO8mZ9H1Hd/E9mxs4op75iHEPcOK4J92hkIGSRu
         y7zw==
X-Gm-Message-State: ABy/qLbXpAStErD5fv7sGR9wBEyurryr4O2gCJVqyGXxwF8Jskv77Ojm
	qFn/55JFNjHOo5gtAoLfzhc=
X-Google-Smtp-Source: APBJJlESnghbYQXGyfZxB4mM4YLWOfrFx755yr/rKauJE470zLJzZB7SXY+XrWpq0hmJNvePuvLq+g==
X-Received: by 2002:a05:600c:3b89:b0:3fb:f4f1:2739 with SMTP id n9-20020a05600c3b8900b003fbf4f12739mr2344442wms.3.1689767719536;
        Wed, 19 Jul 2023 04:55:19 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fa95f328afsm1509740wmi.29.2023.07.19.04.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:55:19 -0700 (PDT)
Message-ID: <f26a613d-1cba-5448-1365-c51ad7aace02@grimberg.me>
Date: Wed, 19 Jul 2023 14:55:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230719113836.68859-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_045522_849299_CD0CCC89 
X-CRM114-Status: UNSURE (   7.41  )
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


> Implement ->read_sock() function for use with nvme-tcp.

This implementation looks better.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


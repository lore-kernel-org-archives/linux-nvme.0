Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742A9C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XzFntB13hEKgmdNe04IF5BINDF
	rPbyxYvskQgHyzRPdBpDdJMT7WKBOST143axc4x/NNZwzvbBjGTFTxBv6WFQrNMFy4PlNrMmo4wEq
	m69XzMAKGA39ptGdHZkYGgsax5hNzzHTzAwrjHDly2nAVjQAKVTJGxxe1WZM68wwcMYZ49UTv5ajC
	c9LLtRgB4+K2CeH/8H3jiz84J8SBTVl66u8HM0P6vVwtc/R0sVKVLRf60IVBp2ANxpEUXI2SMTaxN
	jYl24G3eW5dtfU8MLMf2+dM3YwCHr5rn5YlsPjBCW0RffL0RTFGKZFvSWhPEZ522sqNJ2ZZSzR9Dd
	pPJIB+yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAt3-000000044PY-3NKa;
	Thu, 07 Mar 2024 10:22:05 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAt1-000000044Or-2cMN
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:22:04 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso229882f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806922; x=1710411722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WU+3+drxJod3p6zBbnJ7z5emKIZuH9aA+TLta4/CwW8iQnAIGnaMnEpy4zThv98GFF
         AnaJ/xcYjHLyJzpa8ktwJYTBlCFRmrAj3uuWjBZ3txtibmUPjU7Vl/9Er7M2JIeAMkJT
         tCiWxPn5J7E/Sw+TSbRzBLdMbsmLIzcE8phkiq0KKBANQGD9NpZcRp8cgRjyPOO3ke3e
         7t/aSIVjxFeHNRRTRc59eXJ9kkCcCqtfUaRfUFjuZLmOwdjNXhQbenP3GRXbxgEbWUhw
         UEAsOSRyX5eDk66qCMR3e11WadAqz+h3Ng4qEhFHw82cUfKOcXdGcae6X5DGUfcF4xtS
         WQzg==
X-Forwarded-Encrypted: i=1; AJvYcCXpm0hVdiikNSI07QUHfeH1d37s9OQ5DF9RXkutjZsynepKEQxhgZt1xA4+GtE78BoFXVeblKrKQ2eFGmAHBIh/QFKLINfAal5S5XUWJvo=
X-Gm-Message-State: AOJu0Yz3msZAAgzjQ7a1zKYQ5khKNgV1ylSv3ftd/jr+0uxabl1H4Nz/
	Qk/vHfzdSevKSKFq+Iv4lS/6l1N5i0v4PISVr8k0OgvG2iKIkfOZ
X-Google-Smtp-Source: AGHT+IHiESQNFFn/TLpsaU0l+IHiLBxWQfLFn84CO1s8OLpvi8fQD/7OM9POKNuAu6WpNACSXxLpVA==
X-Received: by 2002:adf:dd87:0:b0:33e:4503:3ba4 with SMTP id x7-20020adfdd87000000b0033e45033ba4mr3478250wrl.7.1709806921679;
        Thu, 07 Mar 2024 02:22:01 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id n8-20020a056000170800b0033e2291fbc0sm16579579wrc.68.2024.03.07.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:22:01 -0800 (PST)
Message-ID: <9e6a8168-468f-4e7a-9871-7425f1a0f109@grimberg.me>
Date: Thu, 7 Mar 2024 12:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] nvme-fc: rename free_ctrl callback to match name
 pattern
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240221132404.6311-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_022203_670917_BC8DFCCF 
X-CRM114-Status: UNSURE (   5.90  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C99FC27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jun 2024 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g91th0tK02L5/7oyZfTxRjmbK5UT3mTxP3D8iw8/M00=; b=DG5vbV3IhRgQNeTWSRt8nz8I0r
	dbsp+G7J+Io7VN8DNF9TfEi2yC9DNlO/hmQvHpEtocA30np6JhBuR6/usbzrd9h1FRWxc1rH5KsdN
	qQbBfTqsr8gzCLUQdN3rQzutdgTx0bv1lPKnwZ3t8ApWPothz3527KIzQWW4YAy/AGz6w3W1KHsMw
	bpVC/1A8AUw34zBnXkmucY1NFz1r/BRHC8dYxClr64WHpwhc3JBO8o2fVdCmD2lEEhoLT/6ncbcus
	pnyYKAgRNIUTzb5COXUY8nUDTXj/lvTc+8/NLFU6L2YNS9gjbD5pf4zvhJNaQEfcjHH85WeIHNql1
	hvgE0tyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNqFz-000000005ji-1RQP;
	Sun, 30 Jun 2024 08:49:59 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNqFw-000000005jC-4A0w
	for linux-nvme@lists.infradead.org;
	Sun, 30 Jun 2024 08:49:58 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3672ab915bdso146921f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Jun 2024 01:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719737395; x=1720342195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g91th0tK02L5/7oyZfTxRjmbK5UT3mTxP3D8iw8/M00=;
        b=YdmiF/zh4PPmU7A7iDoHRkA3EXulKwrZAgp1D0bdyslMWx4vYohaAAHHI2sh4ElSYL
         ZXOlJ0OJMcV6lbampLc3cWlTBx9BtIhgg6rk5yyUo0OLj7zluPOWhcdsYa1+EpfVKMHC
         FpMWm5WQVrUr9D+LW7grWS60Ffkp0Iwq5raNbUx/AZ52m/OqgeOg/yh/Mnl1zOw7Hjc5
         yEB+YXUNwvDLm8+LeT55sHFb6IRwM/v+8RE+8gbNtDaDWD23Cuywuwp+4HnazK7lfY2s
         JJRCyfMe6KU8i3NstCfubuECMLxdw0u+QCXcBkvMscJMXTZHfkvxDLVsyp1RjrKqeBOT
         whQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0hp2LFbPxVL5O4NnecZAmkdWWUl23uHTaBHxCNd0UICSCbiAc8QZG9+R0IZdik+dNM94wgvNyqeEhgGLEJxbsIMSp97pcP3k+U+wVGXE=
X-Gm-Message-State: AOJu0YwuxhWhm9nsTQbtKVMvAbvHCjrGqIQtLlvLpLyu51EF30dMtpyL
	wMmpYCugdn2qcnUkYkU7w9PkEtkHgpTK+RHbfxj/8M//Q1UcbjAn
X-Google-Smtp-Source: AGHT+IGlK0eq3fIPBuezcOgR8iO4vTCNYBUvNItany8mCRXPRFMRIi3ZkULp7oqCuyudg3OtRTrFOg==
X-Received: by 2002:a05:600c:4fd3:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-4257a07799dmr18694325e9.2.1719737395395;
        Sun, 30 Jun 2024 01:49:55 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b098b4dsm105155665e9.29.2024.06.30.01.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:49:51 -0700 (PDT)
Message-ID: <0ac06a70-1233-4fcd-b191-d8605e04b7c9@grimberg.me>
Date: Sun, 30 Jun 2024 11:49:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_014957_062972_54507220 
X-CRM114-Status: UNSURE (   4.68  )
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

For the series,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


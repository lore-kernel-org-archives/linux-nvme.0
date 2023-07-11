Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC87AEB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=O0vFiifkbyNt+u/d3eIy6tvUf/
	8Ov927gUWmvVu4RTHlibvqXR1xFEFFC3TCauuNSL9UK4x/koy4/9IVJg+rnfQMgFK8FbAQs/NWCnI
	F+WfiqL/B2YKT/JDYw/GZ2iuW/CBVle6YKrmSo3QXWVlu+5U2oQ6cnLuVyQ58tFM5Tux93rx91EwO
	gn4QhmEIFp2mG15eD9gBCL8TW2FEd/0bRliDfzWHhChnQ82P4gon+Trvlzs2Jub2Wz8g2JntYf6T1
	wF8Vzz4BBGADmwuY/MFkxcI5w+ReQ3nZSc3iP+Epwxschal7V8i3nIvcDm5jZY8RT07qvc1Oib4M4
	pnFCXdsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJAla-00Educ-03;
	Tue, 11 Jul 2023 10:38:46 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJAlX-00EdsE-24
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 10:38:44 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso8211235e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 03:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071919; x=1691663919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SPygGf6m9Woke91nu7KbxixdVUxk48gt9kwiXxUFpdQ/NCZrX0H/Lan1WoxFmnrgK4
         JNjtj3vbAo0nBbnLJtH8s0NwQ3+kTsBVj+503TKPoK9o4t6nAefEKzGmN9+Bl3dRNAf4
         tky7BjQkmWF0xi16G/bhAVJvgLzPKIIqQ/C6mcdOSEr4eEaa2GV+0dlrD1xEzNTpyYPG
         0AVR4I6GIHx0kr3Lxf1DPvleIAad1t5KWyyFK2jTHKP2nD9um4cBCQmM9BCU8PDPKorI
         ftJIY12cjngxYu3VJyfeXKy/13jeBhXIz2mtyd7V06QGAg1X2+sXfQI+babvUjwnfmeO
         OLxw==
X-Gm-Message-State: ABy/qLahii2f1nJDWF6J5Qxia/QKS6Y8MDcOLCnqWv8sBrSP33JgImHS
	g3rZzLw0gIGl4ppVx0viaAE=
X-Google-Smtp-Source: APBJJlHv5XjfzBkov98wBLAfDvgbpZPRWEOgg45lWt+wMlb3vVDWKD/SJxDLe7KALXGDWkxhJp2D6A==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr14371116wmn.1.1689071919431;
        Tue, 11 Jul 2023 03:38:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id hn32-20020a05600ca3a000b003fbdd5d0758sm2177467wmb.22.2023.07.11.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:38:38 -0700 (PDT)
Message-ID: <8c548c75-7980-9b19-c46a-7ff8a75d0aeb@grimberg.me>
Date: Tue, 11 Jul 2023 13:38:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 3/3] nvme-rdma: fix potential unbalanced freeze &
 unfreeze
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
 stable@vger.kernel.org
References: <20230711094041.1819102-1-ming.lei@redhat.com>
 <20230711094041.1819102-4-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230711094041.1819102-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_033843_676376_D7918278 
X-CRM114-Status: UNSURE (   7.95  )
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


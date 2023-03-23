Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E229C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58k2WhvscX9wKntlixVpOpCsaCk4DUub20yFRnnGLz8=; b=PuYshqnNnppUuuKJhvyY/GLywn
	hXIklygusnyvcCqIMIRa8HTFXgVWANG/dGaatj11Qbsib8xyUMszHZOXmsfYsPd5UXDT1PEUrAfn6
	XK/w+H1FFWg0ll74mCAMRlq/B8O0m5BU7+gtnlg2NYM6F/3ZZPPE0qKGhQMVJpXcjtvNgOMbDcFxj
	7ht3UNB20vnlA7OC7jlc2l/psLhPzauCD5F1x1RYmkjK7lV98m/UetgEQXdDMvKlV06gSrVtL46VS
	1/2A5Tpp14EfBTkKOPWLv1W93nLnQFMJbJOQp74csXrByv9rvrkxHiAk6NKv4G6d4O0XEWVeEF2rK
	zkuCcvOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfGPD-001Had-26;
	Thu, 23 Mar 2023 08:34:43 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfGPB-001HZl-1i
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:34:42 +0000
Received: by mail-wm1-f54.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1559746wmo.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58k2WhvscX9wKntlixVpOpCsaCk4DUub20yFRnnGLz8=;
        b=TvxUyWNSKkAUiZpm13AnlrVGIaUa0cRPG6ULLnjYk8EfgtMkPJShx2p9AXXRZa0qEA
         SLTKtXPTXJ5m4wYlxoDw/F2wnJCW6T3joEX05qbH89Oq8AA0KnzYB4QJKjodJS6wLH5y
         HxSFdzEh7o1bgc0cOLsd3BkRiqJMi4XGhgDCSzyztHgmRX6+SfcazoW4mnfoL/L/tkIg
         Chh5rvRiei/uV9XME6EjsSzos2vRA9GZQ33WhJl8FZ0PsSl1+MIP4ZcvM6RC4QqOlwsa
         hvOZsejI7hdxGWwwNaI54OlEaqMLc3PodzjX8UGc0eSxX0146R3dt1KvVcHV61GwAIQl
         /zCw==
X-Gm-Message-State: AO0yUKXFKNhzZmlsy/0bglQpDTy4gpMzfPahW5Eybl9TK6pMSgz73RS6
	JCdnM7PrcaTCDOAup8qUusD0KOU05oM=
X-Google-Smtp-Source: AK7set8Om8diWSMFeWv+tLiVqVhTL7jH/8fSyKeC/3kMxCcM3Yk9Tf6eURF4+dduoAxBwflBDP/Wfw==
X-Received: by 2002:a05:600c:4ec7:b0:3ed:d119:df36 with SMTP id g7-20020a05600c4ec700b003edd119df36mr9031078wmq.0.1679560477286;
        Thu, 23 Mar 2023 01:34:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c419300b003ee581f37a9sm1186392wmh.10.2023.03.23.01.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:34:37 -0700 (PDT)
Message-ID: <d23ec73b-4867-189a-8a57-c356e1846d23@grimberg.me>
Date: Thu, 23 Mar 2023 10:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/7] nvmet: use centralize req completion for log
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230323075203.824096-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323075203.824096-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_013441_564228_B43CEE0E 
X-CRM114-Status: UNSURE (   6.16  )
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

Series looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


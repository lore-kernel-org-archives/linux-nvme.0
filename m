Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFADC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VlGPtSrw2R8pqr0Pj4WWPKBB0VVInHmRW+IQGsnGCo8=; b=Y2Ta9H6KSb+vKeiTGhD5/9nUX7
	if0fnZkRXI+EbhYMhHHnMdnEDXhVyPv084dn2sWHtXvuuaM957zVyFOvUptycMS2CBQB0XDlNPjoD
	fciYWcuCLnacnsW5i1HFU9SHcfBpTtH9g4CLGq3PpTdOSrrGlD9tqpaQcg7ZvPTQDv/HWdK1lL3Ig
	F4J8qv4LLKl4IKUGVchlMpP5lD2X9ewQBrxgdXuBa/P4AQiTkYyR+IwwgDc433PQHm3HUrEo4PG5G
	Ue0QBwDsL6yDgH7M7SKJYwNHGaLIjs6Yv1waJrz43xyyj1H7tECjS6CtuMBwSaYsQWhCq8Z5AWeRP
	gKdWp7cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phu8N-004FIW-03;
	Thu, 30 Mar 2023 15:24:15 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phu8K-004FCL-0B
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 15:24:13 +0000
Received: by mail-wm1-f41.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso13676347wmb.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 08:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189847; x=1682781847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlGPtSrw2R8pqr0Pj4WWPKBB0VVInHmRW+IQGsnGCo8=;
        b=tl+HpbdmWwTDKSSqLwC441yeY0jEPC73KJvPhDlCIW3cam2+tnEOZQxWvBi2Bdno7R
         5ZET2qx+ZUCGTjmbx8dwEPC2LRKCN9kcIHOwd1ZpER4vDi4nS6c04I0EGp/Yij5eZm3X
         Ka9/o5aZoj+h3HjtLnluW+nhr/oWrrS21exCkbkbXKSAQCiaihZWOEzi3YjOMgapQ4tP
         ouCLJKqkuuptT6OH/ADKFYBAdgouys78SVfXElB7czB7FSSOlrUS1Koq0rahBt095Rf3
         /o9ig/253hCZ2GNESaHmymtrYpqNzwKJSIagEK1amGBPZfIUMJ4LCWDjxTl5+0lAHGBl
         w9cA==
X-Gm-Message-State: AAQBX9dzRROToPYD4HxHib7pZyzDYqjeal3Rm/ZbCCLCI3UEirmro3KJ
	tn406YNzcZh2eiMhlLq3O0E=
X-Google-Smtp-Source: AKy350Zp8ga7rUElh7ZS66R//b9iDODBzsxym/l0056NcE0QKDadMpst3XEgpILsxVkgH3yFbtEz4A==
X-Received: by 2002:a05:600c:4f4e:b0:3f0:330b:d316 with SMTP id m14-20020a05600c4f4e00b003f0330bd316mr3480367wmq.3.1680189846847;
        Thu, 30 Mar 2023 08:24:06 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm33073548wrt.110.2023.03.30.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 08:24:06 -0700 (PDT)
Message-ID: <634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
Date: Thu, 30 Mar 2023 18:24:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Boris Pismenny <borisp@nvidia.com>, john.fastabend@gmail.com,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_082412_097461_D3B1E2D1 
X-CRM114-Status: GOOD (  11.85  )
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


> kTLS does not support MSG_EOR flag for sendmsg(), and in general
> is really picky about invalid MSG_XXX flags.

CC'ing TLS folks.

Can't tls simply ignore MSG_EOR instead of consumers having to be 
careful over it?

> So ensure that the MSG_EOR flags is blanked out for TLS, and that
> the MSG_SENDPAGE_LAST is only set if we actually do sendpage().

You mean MSG_SENDPAGE_NOTLAST.

It is also a bit annoying that a tls socket dictates different behavior
than a normal socket.

The current logic is rather simple:
if more data comming:
	flags = MSG_MORE | MSG_SENDPAGE_NOTLAST
else:
	flags = MSG_EOR

Would like to keep it that way for tls as well. Can someone
explain why this is a problem with tls?


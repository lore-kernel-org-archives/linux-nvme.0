Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF0C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h40FAMHEonffoTpqkkXO45XN1zo3tuXeo1DoCo/mEwc=; b=YeEZF7sBolU8Vgjpr/Xyn+uVus
	2np6/Wm8hCnXeZd4qeAUf2fz6FkU5QL6vwAWlCsdrImiirawiZQ7acf2sjG0Lcq1ZrhGAiafMfUy+
	AI5VdMhkbzjnvhD0XnJUTtki5wNrGPCLQc4nrwcyPcM5VEVXI910FWy9G55es6bNdVppLQMb22ANk
	qjqqx0VVizgiNTRGUNYzj8zEUKlqoruKJ70Ekmy+8aEtqsQhNc81oC6tG0ksn02E/iLHuNLcDzuTM
	S7m9TIcowTgCtX8p0m6eLLH5PFshGqLmJUNtCfaOvUlmifpSdzdSNxh5rP1FLmUtSpFDUuuTSoGKd
	Mz3MZIFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peuSw-00FJ7q-2M;
	Wed, 22 Mar 2023 09:09:06 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peuSu-00FJ64-0D
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 09:09:05 +0000
Received: by mail-wr1-f49.google.com with SMTP id j24so7309003wrd.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 02:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476140; x=1682068140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h40FAMHEonffoTpqkkXO45XN1zo3tuXeo1DoCo/mEwc=;
        b=KmEbCC4WcH1vjr1iC+7Gzh6Aa2Z5i0KhZr7QUMQfTLDJqYvU+PtiOSbUj729nyI7dn
         oJL1iZHNSdqn581tggtKMNn5jMKIiBo9905EXrOmUTKeGkbQUz8pdTA6HFmpSg7NnlML
         BSM/lDZwyoGW1NsmW0dzoDVJW315LceNJuZYm78wNdxf0YFCBr3kawky9wKCmjnn71NF
         I1UKCVH9su/lH1djgwhFVIeFi0NZjPOEnpepVLZWXwSyWMa9ktXRqJczv/aGgvEYKyeu
         RbxwKrlhQ++cHmwnsf/Pj0zlMHkc30b1KbPDlGGjFf+jrSEG1T11ZvELq6jf9FuvyLw5
         7BbQ==
X-Gm-Message-State: AO0yUKVIQpkJ/RiUL2T61SpkzHkXFtXDmvrJ/a48t/MY5Z4QqNf6awBc
	kIup+JHwbT7EfKJNbWRVqpg=
X-Google-Smtp-Source: AK7set8yMc8Me6Dj5dRzONNSWjCH9IM/yeOPp6k6riRkNytCNO9czTUZ8n67OBTyVX8oetA5tjpFjA==
X-Received: by 2002:adf:edc8:0:b0:2cf:f30f:c916 with SMTP id v8-20020adfedc8000000b002cff30fc916mr3768351wro.4.1679476139983;
        Wed, 22 Mar 2023 02:08:59 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm13317443wrt.110.2023.03.22.02.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:08:59 -0700 (PDT)
Message-ID: <3f95e5b2-234f-2121-1296-43c2efbcfc8b@grimberg.me>
Date: Wed, 22 Mar 2023 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>, Daniel Wagner <dwagner@suse.de>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com> <20230322082336.GB22782@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322082336.GB22782@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_020904_106275_D062C359 
X-CRM114-Status: UNSURE (   8.79  )
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


> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This should go in unrelated to the rest of the series.


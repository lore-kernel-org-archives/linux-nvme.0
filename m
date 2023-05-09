Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4BFC7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbFqpGhl407L63WqTAu6YqrbKjBaDfEXdUVn89eSy5M=; b=2RsDHV9i+nRnFU/+gfklbjT3Oz
	AUeutGUCKmIV36PZrLfP04w/79mGJO+BzViMsktjqs0K5SA/JXvseROV5jCzLN0556BUhUPZz3qQh
	Tn9VMiE3dTE+SsgNFL9FaxY/wz+cXDn2eLEMaL1BkLvcwzGbGSOQRe2GaizteaqDgzG8D4tIZjyjA
	wEYtkYJ26UZKO7nCCdonrLs/Mln1ZNon6g35CbWTYq+79rbqY4iIVu08J6O2LO2UxlyeCV7PKmDA8
	6t2On8XTEojOG/F1Yq+T4MQL6Sm1VfBEMWboEx+d9eUeLv2OGXkJe14Omf3o2JaWPAApIadYc0C9Z
	IfONJhDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWWn-004Tkl-1g;
	Tue, 09 May 2023 23:13:53 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWWl-004Tjz-0A
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:13:52 +0000
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-643a1656b79so4296174b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 16:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683674030; x=1686266030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbFqpGhl407L63WqTAu6YqrbKjBaDfEXdUVn89eSy5M=;
        b=f8gKT/K4UOgvA8Ryg6NXaQSC4cwIE5pN9/x6u8zMFFLx+ICmM7Sbh3VsBU11pgQlLg
         vUP4wWNgFQ5JZZPCvBP+hyGIEr7XQubV6A84HyL7G1lc1UAqNXNUp8u+k+vix/nA16f1
         YqhknHfyR5+xyirMpvQvY4SvyG+omX70txnxcWnyvCHimViGLsxqwUd9ntUGDHJGsI60
         EU6jzZM/C4zJAPoVhMagCqcF2+pa7M4GXcmfQCsPjEI9uUUO5qlQ9rIsqEeOSxXd3H35
         KGSUXAxfqTfUW+8/AzuB51tzoz3XIYvbCDJeUuZ2f4bCzIDAtz51jSgYF5abOkZsoueW
         sm5A==
X-Gm-Message-State: AC+VfDzjDW195PGMIGp9h4VrjJHk9txH2PqLomkiDTuJWgCrLhXNFJ6e
	rK1gu3POVU6Y6Zwf5+KjbJZQJ1KCBMo=
X-Google-Smtp-Source: ACHHUZ7lfFvulTxxAeYl5Zqtxg4LDqAje2QcFq2VN595n9zpFdzz6wteKuhHk9wm8VL1acEo2+CQ0g==
X-Received: by 2002:a05:6a00:2e1b:b0:63d:6744:8caf with SMTP id fc27-20020a056a002e1b00b0063d67448cafmr19647960pfb.26.1683674029756;
        Tue, 09 May 2023 16:13:49 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78d53000000b0063b86aff031sm2290407pfe.108.2023.05.09.16.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 16:13:49 -0700 (PDT)
Message-ID: <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
Date: Tue, 9 May 2023 16:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_161351_087742_ED0BD761 
X-CRM114-Status: GOOD (  11.73  )
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

On 5/9/23 15:55, Max Gurtovoy wrote:
> Can we fix the lockdep not to get confused

Lockdep uses static keys by default. Associating a single static key 
with multiple synchronization object instances can cause false 
positives. This is why I introduced support for dynamic keys in lockdep 
about four years ago. I don't think that it is possible to make dynamic 
keys the default without changing all synchronization primitives.

> or ignore it if its not a real issue ?

Most lockdep reports indicate a real problem so every lockdep report 
should be reviewed. Having to review false positive complaints every 
time blocktests is run is tedious. I think it is much better to suppress 
false positive complaints (in a safe way) rather than asking everyone 
who runs blktests to review all false positive lockdep complaints every 
time blktests is run.

Bart.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F69C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qChp3gqwNKY4UYmJTk12Nqs4USSc/p3MjTW1nFT/Rao=; b=znf1nUSoyfr8gKRNlzhk10ifRN
	9Vwn8D+dRK/fR12XY+VCuGxu9s0ySVi5fwEm1OqYb6FEKPt2kMdfzQv4+O9KrEesoN3e53JeDV9Aj
	aMSNgHgsfBeppqzzlueGieW8rT5Ovr9uKtPjsW2b9RVkxEoG7KcyTza8Or7TqUs/Ow9N4YPBhjv6X
	pnNv57CU+fdqGMdEkna3tEaFSUhwCwumlP7MHhZ4w6M5Y3L5TFEs9vF3xdczJzPtT2IU6k0G6ue8L
	eJ19juAWE2ONJJWcvtg9urmExHgR/IqGD+kk14VYYNBNn1mI+U9NaxoWdnJrZVSmTcMiA0GLWrbZH
	aQSxRGuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oibbX-0087lV-3s; Wed, 12 Oct 2022 13:16:59 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oibbT-0087in-FJ
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 13:16:57 +0000
Received: by mail-pf1-x433.google.com with SMTP id w2so16520866pfb.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Oct 2022 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qChp3gqwNKY4UYmJTk12Nqs4USSc/p3MjTW1nFT/Rao=;
        b=8KedyDzcJWSdTSKEB8GfpHhT0MKWMtWdSs2B5Fv0wHOfZHlW2Ko01iRZ6SHy7jOBZw
         Jih9lswX6MHymL5tBS8KLs6oH54ZcKwaeWPsfrh2WPp4+NKMKmz72Dtmp7h6tRpSFLkN
         1qV1P5O65A3qpbgTm77c3iLDtGzRTsqJbjzRcJ+EwT0WOWNhVjzaDFY1Z5akH3htws99
         rqMYieI/cwjVf9t+wEmnegeBqt36yG5kv+Mx4TF5ffrbA0yccbtqkszGqjIv7S6VOJss
         amxMKrsbryoBaiEeVRp+engyODtODsye4QLq/EeqQ+4tpUGpiOuxUREMJtIHnag9Q7tr
         M5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qChp3gqwNKY4UYmJTk12Nqs4USSc/p3MjTW1nFT/Rao=;
        b=riq64elcwiFrMNVdUIvwWQsWkFToKTi5iOeVm6soR4trexJXamM+HpDLhlF66rhKhF
         Ed21NslTx1YBSesZwXFl3jcz6WetNTh59s4vAu6DtSQEgVGtc2aFVjFdFppI1Q0e8yZz
         uINF2uVi0IYFgUQ6/9tdJJ2GIY429RhXZZ4wriwpFDA7AITSAp+69m0BB275qSSEM21/
         YaDR3T0v3PdILQYABZpBrvqkSmCznJ/j/qszQ2az8+//6eh10Utu5RME0jbhjD24kYk8
         tF1hJe9B7zqw5eVHcOki0l3qoi0ltf5FwAGzWgIRj7PXpR3oIzGdoi/MXI92mrq8n/OU
         28HQ==
X-Gm-Message-State: ACrzQf2q2m3EadsxeMbsGMghQAU/WgdPSJoh90Y6+hFv2TUrnust24W4
	/xq/38+G33SVe651Y+4efJ7Q9A==
X-Google-Smtp-Source: AMsMyM4N0HekE1X0X8yhc92JPelO7xJzaeG4Mz2OJV9qfgQQJEinQ9fOlm4kkwwl4jxyF4sexexd4Q==
X-Received: by 2002:a63:5811:0:b0:43c:9d3d:700a with SMTP id m17-20020a635811000000b0043c9d3d700amr26209264pgb.419.1665580612732;
        Wed, 12 Oct 2022 06:16:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y2-20020aa79e02000000b005604c1a0fbcsm11129149pfq.74.2022.10.12.06.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:16:52 -0700 (PDT)
Message-ID: <71234c8e-9a6e-ac13-ce3b-618cc8bd5a2b@kernel.dk>
Date: Wed, 12 Oct 2022 07:16:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Y0aoYSBCx2Wrw74I@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y0aoYSBCx2Wrw74I@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_061655_813545_D172700F 
X-CRM114-Status: UNSURE (   9.12  )
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

On 10/12/22 5:43 AM, Christoph Hellwig wrote:
> The following changes since commit 24a403340d70aad3667b3ee0f9a7aa5c0a5193a0:
> 
>   Merge branch 'for-6.1/block' into block-6.1 (2022-10-10 11:26:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-12

Pulled, thanks.

-- 
Jens Axboe




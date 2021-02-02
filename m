Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A8FC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 17:43:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741C464F5F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 17:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C464F5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nSwpRv8tGGTr7A70PYM7pLCddPR4P3PmuPzOfB6xy6k=; b=xLe0+Oj1XS/QZNKolVXYMklG1
	XMUgFz2iXBPEXCMH6aUqIKEt9YU3nYdYkeJsBy5wpAQp8l/Iuiug4MdfGGB7RlNERvrcrnKHzJgUK
	WOQo/5Xk/ub/JY5dAMcd2cu81lvFU14QnUGyiI/P2SXzoGls5YSutECs2p4aotWFCmrY7ThIPtbDF
	1dXZkiv85J524018qGW0dB4KFBQ1tQyfnw+QexFk7hngZ9BL8zg12yLwHRc4I3ajGbrJyHMVY241T
	NR5+MSzfTEi35ghEko1lEU0w0bY+hoYn+CP3LzGVyTH0Rn7W1w+maqmLJNWPWf/Ixa6pkgJuhbhLN
	yLvAL+9VA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6ziC-0008TH-HG; Tue, 02 Feb 2021 17:43:36 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6zi9-0008S7-QO
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 17:43:34 +0000
Received: by mail-io1-xd35.google.com with SMTP id u8so17128168ior.13
 for <linux-nvme@lists.infradead.org>; Tue, 02 Feb 2021 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AtD0BtUx5Er+Wsi4ZVwrP5AJ9In+NpH9yW0BLmuixe0=;
 b=bPV17FHWE0VwzkPPxZvIBGx6tBb0G+Rmuk2Gj3jqdZF4eNHK77gdFJLn6UGqO4OXWc
 QKRuR1OacuOQ/q1k9Ldj0NB0kQ6p4eNUPOBm6h2ck2MXlv7Kku1WKISsfD7EfRIqLw8r
 pAo/abXOMZQMIIi1L6MZbD+q7DmZaYxa14RCNglqoVW0Of6M9vdiC2E8YAjwINe8bHGo
 nOhe1Lsut9NLyJV1+tomd4FICxCP5Xof02/hxkGn7tfozrgSrbL5nPxwc9kkYS9Snx1R
 KNKHadH840V/otPcZ6+mZsyYD+ZcDgeOyXpBGfbfcRXKV6vWrza/z5PYPFjvU+fDKzmJ
 ak9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AtD0BtUx5Er+Wsi4ZVwrP5AJ9In+NpH9yW0BLmuixe0=;
 b=SRd8aKFa/bH+6RHSgiVvoHEwA4++WIyUEQTVcdWJb1pZNOUUFzaHxrsrASH9eNEl9v
 IzlDkHMyodvNumKp8VsxcIGBTrN9GwYzewyWvn4M5gvSy5rOzfu8Hp/5XXs6dz2iJu+X
 jyo9FalZ/N2zqP3xwdYqK1HiN4Iuw164FdFqwkFL3Ue4mKU1VrQQI+3ltdcNFhnHr0Oo
 Ixixu3KjkUWIMgvqcl+YEEV57SDV5ruORIEgKEPLPWoA2iWH+kjz6vSrhgeqj48h6JOe
 lFF3spGeX39pQJnZ9PRmxVdZwKn5vT1xcL3C6y6vHvCZM6GUWuI9tt9KXzKpDcXyU0KB
 9pyQ==
X-Gm-Message-State: AOAM5322/Y//vtgzmBtjYDLVfu7zaaSBusc3ukH8u2gs3Hpo+Gqyw1gF
 +Jd6BqsihDg41LiZ/JKfsRWkORNmNIj8K6Vc
X-Google-Smtp-Source: ABdhPJwFaAqjyYVbXyS580/67bS1Dm10Mi9A92fvnNillmxqvI/0Sj5e534TqKGoRt5PFqhr25f0rg==
X-Received: by 2002:a05:6602:2e83:: with SMTP id
 m3mr17823035iow.160.1612287809996; 
 Tue, 02 Feb 2021 09:43:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id x3sm610521iof.21.2021.02.02.09.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Feb 2021 09:43:29 -0800 (PST)
Subject: Re: [GIT PULL] first round of nvme updates for 5.12
To: Christoph Hellwig <hch@infradead.org>
References: <YBkcYFf7hJfpK+vl@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fba2a647-1885-f508-0f40-e3968b005cbe@kernel.dk>
Date: Tue, 2 Feb 2021 10:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBkcYFf7hJfpK+vl@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_124333_870674_9581E65C 
X-CRM114-Status: GOOD (  11.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/2/21 2:33 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.21-2020-02-02

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

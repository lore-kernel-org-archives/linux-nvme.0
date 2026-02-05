Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496F7ECD983
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSrWcFty1sjoYZPVolSaDN6OMume40OggjC+fPQE8k0=; b=AD2THeRgTOWRk6/XnAxJ+SA0Kt
	D6pIAWUqoXaO9DqCzTwUr3t4Bpb38ktvvNyE3/jyLvwMeoVbIwaRxedY6Ut+N5Hef1J+IeEhQKMyH
	UeGroxvNh5pLSoCYlQwqVVvfLAHRWbd2qxzlZjFoopncNOJjD4Ih5RB2/C0kn/kMkCVoVGCV6LxNA
	SXmTydfVtY1Ll/px7JqMlU/hMPzn7+TMl4mTR0xiTkhXTB7Ghzfz60bn0xTuav3in3LmDtDB+jKc5
	2CR53WAGhgvBBEPmSAnlZ7j9RmMSFMFHFFgfNPt1zIxREUx3R7gZpVBmj/bd4ZOupbflfA9DBfQSf
	KaIWmknQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1dO-0000000AAqi-0qnx;
	Thu, 05 Feb 2026 15:51:10 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1dM-0000000AApq-0eXo
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:51:09 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-4094b31a037so681202fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Feb 2026 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306667; x=1770911467; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSrWcFty1sjoYZPVolSaDN6OMume40OggjC+fPQE8k0=;
        b=JPyMYmupQtgaYOa/UGJup0xT4y92Ncmh69J0dUho9aCsSKP9rO8Y57sKpFldmhH7j2
         nm1yc+7HWnaN7krt5L2S4ZBL6Nhhg4yiKzwJ06UfOcdVp1Fp0GS9RL/R9nfqkr30mM3K
         maWdJGuzoUfKsQzInQ1Na8NnVk9G9o8UYSoHCKrpSAIss5d3ckiV47sO021cPskwJnkf
         7QAv73PXnYWxzNERY1oXxr3GOimxYJhmlYIHf7yWrYVhDoi4KG90jPlGDfrFagVOSKYs
         fgZ9896NOozLQYtj4YL/TLo8phH6RI7BTsw1QcBumovh2fb/V7Aq8NBzNr9fwHNvrfUc
         3E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306667; x=1770911467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSrWcFty1sjoYZPVolSaDN6OMume40OggjC+fPQE8k0=;
        b=oPNXx+PTbNUO+43RDNtYIUmtIuPcF89l8/gDomBLtPFssuukCCaT6yxIRntFSbyUAI
         c8ksAOqRg2BREn3vbRxz9zdKV0wEnRNr/QaCO5clOEFt1o2zdlAfjl9VC6R5zDJ0xD5g
         tLWxGHFbHhjllmhAgWj/2kENd2n0bEMPvU1xWvm26lnpm61d5g1hmyWEaC4XHbVhNKGH
         OEKEWYvjJpGMvZWNqInTbBHLAKLbLuwPFm4ukG82snipg51IwYHOq3ASsXJYVLP7gY7B
         HeQODcx1QaKklR+fPQ0X68lwhq1Cef0C69A6htN0luJU7A0u3dPtXOXBNQt+4MH3g+eH
         d1MA==
X-Forwarded-Encrypted: i=1; AJvYcCUavCqmW/4sF2tf6HnYW3JeYfLP/hAIOBK/RmCFH86DhClJQ+tFN/D6OecFdlmysuJyXRlKRGc7EQJA@lists.infradead.org
X-Gm-Message-State: AOJu0YwPBd3sRiTRBroHwA2BDqJvS6nBi1pE3kkd9scSZrIvfyU9c+YS
	M7MESd1ZMZWlxrv0q/ytKKywMBFyymOpjAxG6MGCaWd6R6YDkUI9GG2MNAFELMRti4Za9s2UcGV
	YQZSt0mU=
X-Gm-Gg: AZuq6aLFPOscd2rnSgOnunTtev2n05+IQ6EH+wO7n7g/j6RPGLYFCU5liUPfuv85B9N
	3Je5ggDUviGWAiT+QJj2liOdnAHEzZjf0Vir8fzKMT92ntpAditeGDx2cNedjgESNgg+igG70vg
	DbP4wpqkZjzuXFJccbGnxmrapTEtHINfjIr47bxew6m9SQoT5K0AaY225CgIq5+rg16jbv879HJ
	mIZ+rVtdw3qRpKDjODc6RPHRmSDcHrrltsIUFoK+Z+7rBvoZJDsn/JoU9UixHfyXC7Lrz22IrzX
	4L/UYEoS4hKKIsv39pzViegIDY6v73MDL/EfrdynRFed9m+JBkT6QuSCHb2pmHoQKbQPhvURUpE
	GBx7aEq3x3eb38kNsJtKvjHSJO1mNqRbNGldb4qZgUzzIYfA3jxoIjEGQllLasUoYDPVSAz3lZS
	AErGkAxb1Z5qnksN0Klt58Q7zvnmjD5lua4LiK2PojXillN4+GqNVr/ds/MU9ipbDN86SdsQ==
X-Received: by 2002:a05:6820:1624:b0:663:f65:1c8a with SMTP id 006d021491bc7-66a2297948cmr3272210eaf.44.1770306667002;
        Thu, 05 Feb 2026 07:51:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a3d3e5705sm3207979eaf.5.2026.02.05.07.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:51:06 -0800 (PST)
Message-ID: <6fae59fb-0dd3-4447-ae2e-e03f06255231@kernel.dk>
Date: Thu, 5 Feb 2026 08:51:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
 <20260205154922.GA28226@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260205154922.GA28226@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_075108_212487_3FF71BF1 
X-CRM114-Status: UNSURE (   9.88  )
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

On 2/5/26 8:49 AM, Christoph Hellwig wrote:
> On Thu, Feb 05, 2026 at 08:47:48AM -0700, Jens Axboe wrote:
>> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
>> will trigger a compiler warning...
> 
> Must be compiler dependent, because it does not for me.  But yeah,
> it should go away.

Probably gcc vs clang, gcc often lets these slip by.

-- 
Jens Axboe



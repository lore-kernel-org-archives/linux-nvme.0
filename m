Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A1CC3064D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hdziQqMIHtmWYYC3U6YBP0fNbpLTLhpowDVrFRHdLqM=; b=cIUB+hFvFddJimmZWZTOON+J10
	mmMsdvzl0jtNmAsRxdL4vRPrvWO9hma0NRwliwyXiFefQxuluyo3tELFxqpU9xd/fuhtVsXgv9v6H
	53GKMNOCBVLvmzBWaNAFiBATuO1/BmppMdN4HlGLkwSgXSvhiXXpau6bfMFPd+pFdE4oToM3T8r/U
	TpX6Hm5dEHb217SVkXGIoTWsAav2Q7LgxQ+rjoykMOA/oRBsAExS1JSgUAc2juSH+09Q6YC1JVQBA
	W+eQCkXKszSsTo3pVHUWVlYMgzaRJONSCq5LJCnKj2SCO0XDKytca5WXrDJMT6ww42dUhB00uranS
	TzeKq29A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMWPV-00000007lBe-46M7;
	Wed, 26 Jun 2024 17:26:21 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMWPT-00000007lAP-0IEZ
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 17:26:20 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4248ff53f04so25917985e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719422777; x=1720027577; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hdziQqMIHtmWYYC3U6YBP0fNbpLTLhpowDVrFRHdLqM=;
        b=ccM90rME8+kUlit9V1uQSCT9L4FVYW24UnBbNq80d8TYYuP8+/lkIzXqvuV9rClvPq
         ExlqudBbQlfuO6wGLJ0dZ4x9g+/hd/S5+wnpPhzsfHHSpMx8feN5MWMuJD384QU91NQ6
         xpuPYBkoTsVII1rIm+jHnrWJHvqXYQPsyjmZ3zU3+I8NZZN4lWl5a67QDblbFA3/A5ev
         MwwZdrbyrblVk7/wCo3xvtBMWLrMmpuInZohT2eGDYp3MeOO+9mk8edxnUlW4V22DSDi
         SGL00oLFP0ocJqqdtywAbWYkAO7FwMJM03UbVU6AEK/itad1o2S6NatR0pXO4ozPHi2Z
         axnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422777; x=1720027577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdziQqMIHtmWYYC3U6YBP0fNbpLTLhpowDVrFRHdLqM=;
        b=Xp21eH2OiMl+Q2EPS9jEoYc7lmqLtqTXIarqwAdUcbQ5K52GwE+NGGkp8o1uoqC0MG
         4rQU+mQooguLLPwPQkq6Xw+iUGOztpEWT/Rh7ZvG2TtrKv1oI5OWJBlKBrHgdz1e7sX9
         UctJJZXLjhQc7aj6FQ07274tQy0IlRpiEDnDfjg/mqw0QSISegKIOs91YzuqFIPrZ0CA
         aZq5emQ71sm6Mfq0iw5HDkUzFYXyqE/BaKx2UlGui17X/nTTigKQfejMDyIYAkYbfE0c
         wt+lQySvgnkWTJ9TLos1o+V/ieBjXgQ2zUD2Kwv1OBG9Vmel2KbFV5AxFzAqDv3fM8FP
         KRoA==
X-Forwarded-Encrypted: i=1; AJvYcCUtb+cASJ1A+Lh5IFJQdvt0yo0yE9o0ODHqJGRefRKev8a73OBzPvMEDIPdIE5Uq9hIohWAe1yjUSxetr/lSVpJlSoFrdtaoDGNSmkq4Mw=
X-Gm-Message-State: AOJu0YypeJBTrTbkzygw1EmkGjLZSc6FU2A2Rym73zCoq6vEbExpfcxW
	K/IPxh1e4rIj+4xutout0DNuXvJmxxx1hrYFHjf9kagdF4pRU99BQF3l55h+xQa/BKXbzJ2ZWcV
	40wgZAD5YFBamBi7CqorzG1gENnajNHTeU4jD/Q==
X-Google-Smtp-Source: AGHT+IFahjV2p+0jb7TmBNawhEs+kITz8DpgAILl/YOsslr05y3/eAw+boWA26XBNXr//vtV4EDunrUcL09OOlQ4xTM=
X-Received: by 2002:a5d:6c63:0:b0:366:ead8:6019 with SMTP id
 ffacd0b85a97d-366ead86044mr11222202f8f.49.1719422776897; Wed, 26 Jun 2024
 10:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240625122605.857462-1-jmeneghi@redhat.com> <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
 <ZnxHwNflN3l9EN8p@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZnxHwNflN3l9EN8p@kbusch-mbp.dhcp.thefacebook.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Wed, 26 Jun 2024 10:26:08 -0700
Message-ID: <CAPpK+O0SneKwOKqPZ+aw7=_1=xqKHOs0p6+reeA+r0=u2rLiyg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	emilne@redhat.com, jrani@purestorage.com, chaitanyak@nvidia.com, 
	hare@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_102619_134668_F017B5E7 
X-CRM114-Status: UNSURE (   7.12  )
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

> I fixed up the suggestions from Christoph while applying. Thanks,
> patches are now in nvme-6.11.
Thank you very much!

Sincerely,
Randy Jennings


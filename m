Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE2EB64DD
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Aug 2023 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCU9onRKvTeYDYs+U7rhikuAJ4uEWERJeXEWHadQLds=; b=dVpmviamtQoGMl0UMuMrnlq2UC
	szsMAcVE8KBb0G+CSLZTG8GrmM8ZhoTQSVh8qGVP5viSxfEstZS7bTQSvk/h98l+7YVRbPSkUPAdd
	kdsU1nZB3v3w0y/iQ750nnM6FjfGzIlcXJcgJgWfS+9sbEkdoS41QJI86U0y3iGoYMN4kqOrSDG68
	Ce67fi6CJV4KlinZTBputE8H9mYT6uJMWSr1UyERi0bae7a2H/PjX3l7vAZ9hQHXyyjEhkIMptcYI
	nRLmOBrOyFwWe+IIVxbT4psPoLO7vU+MfKNpO/6rP7j/YSN4jy+jIV8qJnGxZMR9xCW6f1NU/qjRr
	aPkgju2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRkBD-00BKAQ-3B;
	Fri, 04 Aug 2023 02:04:39 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRkBB-00BK9f-0O
	for linux-nvme@lists.infradead.org;
	Fri, 04 Aug 2023 02:04:38 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6878db91494so210362b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 03 Aug 2023 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691114675; x=1691719475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCU9onRKvTeYDYs+U7rhikuAJ4uEWERJeXEWHadQLds=;
        b=VXmm8S+RRPBpYcAuRGa6Ki7bbaThoYtq7TWhO5gLC1BzjRsEFAtbyPH3uZGlKZJhhU
         NdrQAgMH2Vlezl82sBTQETizgFDkgGyLNWnaH4lP+iiNB8JKXV5zkxQ0odEaSmI/V7Nw
         +n+uoxBIliRS1wNbHc66hs0s9MtcmumOWqIFVZpCZXJS04LHVLCX3wDe+So1QNEA8Fx+
         Fi8Ezb+B3tNCfsSYFfae7T8M57DkrJG9gvHPoBBs+YGtM5xBTn8A1l8zlZcz4JrA6G3i
         AKQ6PIdZZ1Y1sKfVGkaoJGOT/s0DiTvOSEf2ovDbPsVsjWHdbnGclqs0TbNnm+ulZ+M4
         84bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691114675; x=1691719475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCU9onRKvTeYDYs+U7rhikuAJ4uEWERJeXEWHadQLds=;
        b=figfVzizE87fWD55JGMKgHyfnsU+D6BTpIWeM6Xw5Z4qbsyC5rMJC1AV6FnzX2l9sl
         ivAK5jx4CiyqhU1MHDT+cD7bbC2ToKcFPSm77ecghQNJTaRlbZkhYUwZDEQHe2YsL6JN
         JrqLG1cdaARDOITUNHlc1P4lv7f7nQe7ha5HDiDn2dgTWugcUJXDY8+olPmsERZJB0Ip
         KavpPvUMpb/gqR0lxAeItkmqdL+d2HnvdzmIv4vMeGhzk+Cjb8ciVsSrlV1kYXK3d5PT
         sOsYot08uqSifZA9x1fRRahu9cueyp45u4bxbPBqvlnEqKLuks+k6DtlL/oOwWB4q5m/
         ErAQ==
X-Gm-Message-State: AOJu0Yw4tvWrBqMHecpEk1pqZPv1L7VN1V38mbDXY4sBigeDAB1KFzyo
	ml1ih6gljZGr/xNCERgmWYcfTA==
X-Google-Smtp-Source: AGHT+IEoBfAn0n5TEBB1C81zJ/EV79GAJhI3gAq21AhvtVu18caNRXKWEvBX3a1vQqMbzt6xraFtCg==
X-Received: by 2002:a17:902:cec9:b0:1bc:496c:8edb with SMTP id d9-20020a170902cec900b001bc496c8edbmr2377487plg.0.1691114674715;
        Thu, 03 Aug 2023 19:04:34 -0700 (PDT)
Received: from [172.20.1.218] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902a41800b001b03cda6389sm508607plq.10.2023.08.03.19.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 19:04:34 -0700 (PDT)
Message-ID: <8a6a94a1-86ca-864b-28f7-318beebcca2c@kernel.dk>
Date: Thu, 3 Aug 2023 20:04:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.5
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZMu/Kcw8rknRQYJa@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZMu/Kcw8rknRQYJa@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_190437_162015_F78619FD 
X-CRM114-Status: GOOD (  11.22  )
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

On 8/3/23 8:52?AM, Keith Busch wrote:
> The following changes since commit b8f6446b6853768cb99e7c201bddce69ca60c15e:
> 
>   nvme-pci: fix DMA direction of unmapping integrity data (2023-07-13 08:16:07 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.5-2023-08-02
> 
> for you to fetch changes up to 688b419c57c13637d95d7879e165fff3dec581eb:
> 
>   nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G (2023-08-01 13:28:29 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.5
> 
>  - Fixes for request_queue state (Ming)
>  - Another uuid quirk (August)

Pulled, thanks.

-- 
Jens Axboe



Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7E7C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CAB207CD
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nyjFzS45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CAB207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KBrS56PNkMZjULfpY32TF0TRwLkxmBk7cRGTxvAvNyc=; b=nyjFzS45mmRkaBAlNpHyWQiYy
	FtzyAXvP8H3mo6rGxbiPxYfyPIGKqhV1E1qzSYnApgWDnIfPb5UOZHdtPJd2rdqL8sZX3NfugccfZ
	9XcFnlzqL2kZMm4PfNTwW1D1hYqUhjg33/7HO9s8++KR8sUQQJhgFcSjXZM7zE75nbEaRHOLnN1i1
	7C56cNm14B5pmFjJpqAW7dm+31YwASkP55UHAQ2RwwB6bs8ODZu5l3SOytEDtTnneUtkI1LjSEWLL
	gjYSvyy02uAey0J2LHnDjkx1G3EE+0/joybptm9Grfr5QaH3cZ5ubtOJzn/GWvKyhuoj8XnFBoCgz
	0iBQ93gHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBM6O-0003xy-T0; Thu, 27 Aug 2020 17:54:20 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBM6L-0003tx-UZ
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 17:54:18 +0000
Received: by mail-pg1-f194.google.com with SMTP id 67so3877991pgd.12
 for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2020 10:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uP06PufNPPslE0lwiNJKgeEgW1x5Z5qXHScKKVTznKc=;
 b=aEslxdRDSu9J+6zE4Pb6QEHDI7MMK/fYvpGFAHa3gqCcdWZ1fSY274J8nRW0dIExRR
 9/WTwcHg+V/fB5JLh4WPmMdQG/9qWa1wTx5HhX9n19ccyCmlIaEePnupzf3RVPPC+XP6
 pXQstDj+Hw9p0Ct90Bgm6WaxdLs3rXBFQSO4IiAHJgjcWsT1x+8QVVZ5vS03oUTETEbk
 hxit86txL/4BqmaPJHhHmV9Bv0caG77bMhpagxeGnlOpv/kMBOyD2vIQxJEDeL0ME8AQ
 CBWEkfG4nniKSU3MTm66Mbz8zjwcUZsa8yiTMtTZ3dD52AOoESmA0WqGeHGTQQVZuTMJ
 d+vg==
X-Gm-Message-State: AOAM530oXDXjLpJe9dh691HW2srJX3EVgITcco2ADx/3HnQ+25KtyCiJ
 HefP/mbBx2km9GAWnH7Qv/8=
X-Google-Smtp-Source: ABdhPJwSIBxTIc+6J31yOkXkVKasJ8ycS856RAndQDGgNTyDdljFN/kI+HoJDefhskCdFxVTJdeiTA==
X-Received: by 2002:a65:5302:: with SMTP id m2mr15301703pgq.185.1598550855080; 
 Thu, 27 Aug 2020 10:54:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4db8:239a:e6ad:7ec?
 ([2601:647:4802:9070:4db8:239a:e6ad:7ec])
 by smtp.gmail.com with ESMTPSA id o2sm2971728pjh.4.2020.08.27.10.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 10:54:14 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: only use power of two io boundaries
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200827173857.2825087-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a49e47fc-eada-bf14-852a-749e1920a6db@grimberg.me>
Date: Thu, 27 Aug 2020 10:54:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827173857.2825087-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_135418_023939_5FD42AE6 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Christoph?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

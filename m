Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C94C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PP9HkPudxFKzM8yV+TLaxrJjGUojTwU1FfhBFhCGIak=; b=a6v16+FlZuROOgn+CI3Ipx/MK+
	oS/PyK9RInO42pN1BwduHB625FLDFUvTxFvcuPiKuB3ZoZo6H063zo+zBHnCgimJapk5NqWMc0wao
	KOMW2XAhfp9T7eeOWUoh9SIRrTo28HtREUcSH6HwxKt1+qUBCDvFZEB1cfMFQYT7oiFfYsQTHVOnR
	BLDHymg+PeixWxIjnScxTT2Zh1+3KFnn8+2foaYabfoFY3qqJeuO7FOPE/jTvheF5Q/rDJiAFuwnJ
	wx35gk4BicvH/fxwMnPiVCwVaO9bNNQZXDF17ZKAekwzxUUgMqW81958LfbSRNFlqDGep1LotCVLD
	plafedVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9b5M-000g7B-55; Thu, 07 Jul 2022 23:39:04 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9b5I-000g6J-O0
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 23:39:01 +0000
Received: by mail-pl1-x636.google.com with SMTP id 5so9102328plk.9
        for <linux-nvme@lists.infradead.org>; Thu, 07 Jul 2022 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PP9HkPudxFKzM8yV+TLaxrJjGUojTwU1FfhBFhCGIak=;
        b=k4DbY5CyszwGTRynUgdVmiEQWvjZnndGUrPAPZGQ4Ojy/qbB+yaiCzY9YpS92QfHXi
         8c8b5Pzl63N8gqNO1qSb91heIcdaW1BOBsybROj6J6rXvJtgxQ5a0DIK+gIcqG1YjpgN
         +hcB82NURRBVyEsxs3I5s3hQLdXjgIcXeQL2piz8GcZBuuQF9obPt/DLszZudS46ucub
         DI5Vd9HxarF/LpjejqdQE8wUe/ENl/pJJFn9BOBfFjWC2M2hnYYCMzjPR0bOzLoi66jg
         Tz9gxX5FwRVo8RBpHV2MjKDZpX4DRkBgxjH5LUUPVtPyyHBy3YoMCSSK8+vFtVuHaU1X
         c2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PP9HkPudxFKzM8yV+TLaxrJjGUojTwU1FfhBFhCGIak=;
        b=f+7cf5/jhRzS+ChIhW+SjoiGDwReOROGQGS/rVom5pkQv4OJqHkGNpdDPL1D2ROOFh
         lwGzOkTGjTU5+TtTgkWXsryLN0fCFw5+fpiXr7nB27qLI29W3MyBqwwHfuZokHAJvlKk
         5VhJkhih+0Hb1HzbAAhqX0CabRvQRBJqrVSue/YxCslxL3Y5zd8c5BxNPKKJURIZdS4p
         jmDxUUHGvx9W6aPceX42TX6wFDruOVDmlv6rtRAw8p9X3lqr05My/UrrSoXYRp740uAR
         qWgIc6RZ/dNN94pHQPv0Euvm0yu7bgHecR/QNqu/kcUVRfLZ/20Q4nJ9QfScD2FVI4lZ
         4zKg==
X-Gm-Message-State: AJIora92AxhezeBhHaKs6GxCdjAuWtUIda93XenRn/orFytP78KTt+dW
	U/fGJU+JeWUIL5vInXYIIIqRdQ==
X-Google-Smtp-Source: AGRyM1sxQx+dUXvX0uvZBKWwJQ+i/OUosw96hqoXkyxuyiDKgo5ekEl3UoZvfwx71s1oOZoqYs60Fw==
X-Received: by 2002:a17:902:a589:b0:16b:c227:d7f9 with SMTP id az9-20020a170902a58900b0016bc227d7f9mr439863plb.29.1657237139487;
        Thu, 07 Jul 2022 16:38:59 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b0016a7d9e6548sm11888188plf.262.2022.07.07.16.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 16:38:59 -0700 (PDT)
Message-ID: <e4c2a81e-dd57-a55d-9a9f-56b7c03cc861@kernel.dk>
Date: Thu, 7 Jul 2022 17:38:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Ysbe1DGn9vLRpEOh@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ysbe1DGn9vLRpEOh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_163900_804514_1931C996 
X-CRM114-Status: UNSURE (   9.72  )
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

On 7/7/22 7:25 AM, Christoph Hellwig wrote:
> The following changes since commit f3163d8567adbfebe574fb22c647ce5b829c5971:
> 
>   Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19 (2022-06-30 14:00:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-07

Pulled, thanks.

-- 
Jens Axboe



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4946CC6B1A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=; b=0k2E1fKz6z0NhgVBU12eODUN0s
	oYak8jwFOekt+DYcPy8+Uz+2cBI8kp2prZhnisrOpgLpWnTpQWkGZ+oHVKXYNWVvh5Z6pdb/wE3h1
	EYI3J2UWUP/QjCzDrD0ApZLMRM24+oSsHS6vQYD7ND0MIqKj5cYeoj7fxv2/WtuZTDQzP4Jh5PaJq
	51umoc9OICOb+3iKMTemrGmt8oA2wd136YGXaB0k76nhnCAxv7FYM0Q+EQG6Ft/12qQ6pWh3HXO6T
	90CPponI3mtsmp7fqANB565nIFMV5N+S+rANTcKQOvWVqm0hS8hfp58jBctKkNarVgu3c0jm6rmXD
	T2ZhRNig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGhzX-0000000Du20-0Lpe;
	Tue, 13 Oct 2026 19:16:51 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGhzU-0000000Du1d-1dew
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 19:16:50 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-6df93f00f4dso124378eaf.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791919007; x=1792523807; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=;
        b=QA8N3EeNxm2ZTYpjdEXcUWcVbt700q95TJCqOJrrEyK+vIHxUKCOcCGu5F4QdZQYrA
         IJSTAei0GAFgnbdpmJ4Z4ew+PDp28/1Cpaf2c5KXsugegSpP8jc+3VSCOXKxCSMNC+LG
         oDG73QW5E8IxIB0sXyauIuVa7bKuHo/ErR7Css3zT+QxSVFjb93TzIJPXKOGc8kAh1OY
         mqBznruAsKsaprzbogurlMATpcLwgyU0E0MlDoRWrUSqhqzpIaeexezKOP3+rRVdJ2IJ
         kSV0SqJxb8DK8zZCCA5dxJH3JK+COCsKSfzXH/3GePD31W+w9gTz4U/1gHWEjhIPjEDf
         OK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919007; x=1792523807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=;
        b=C6buH78HLqtqnDvU8XCfiJugaFTUmhKMoVmDs35ilbuRksW6GMPGIQC08pH+yhUmco
         RZUWwp49yKV7sPJZeu0H1NUHIfnxo3UG46Sh1B3gIUAv0umd3+20nrq2rXPmD5PL3Cci
         ZXwMhE9h3OVw+rlXKnbX4LXFkF50m8tja9SVIos6iZghxV/mrhLaTi6qsRQgCyQD66pI
         diHE9XQTbasNIebHWaJXxYvBjsk9weRTeP2LxJHR1EjxWZUBrQM4JXU3/eWk8MlQ1tAV
         usKSRr7RLhCroHmc9AlD85UlYa00CyGudBYXkYv9DH2zYSRrqUfvy0YecUsQpjj6GrkH
         mQfQ==
X-Forwarded-Encrypted: i=1; AKwUvByyOcBwHUF7IrECiAxzMGxkzBm262AgVpu3e79qL9mukAxuyPd3UdF8ppw/v8cyA15mw3okA68OZZGM@lists.infradead.org
X-Gm-Message-State: AFq9FYJ/mLtsppdZ9DCLr8eTr9HnH/N2/qFRh5efqg5hwI791js//VJV
	cgDbgQuFxO/oHCrm41p/Pz8o0fSfssAnpXD04/7tIn322wh76Wrc5xFHdGP23ycU6E4=
X-Gm-Gg: AYBFou3ps8Heej8E8Urmzsi8JAHy4dui7xw/FvgoLmQKxEBOfyjopms/zxr1R++xMez
	fmqBqZ64oiDkvBCqOc0j3ZA/D0OtEyWRiqNFuYlHYjdVgWcC04lKVYfeed4uek8KcBARNMZs1Y3
	VOsPqy2RAQIXHHY75GJKI0dh8ZormqTt82igodzx/CMP/f6aOMXfxXb2qHdgOXqcgrjaBVtnGOD
	V7OmkYWlZ32e9WJW26eVeN3ZF0NYRBEL4DeKtPOqYDaIoOdF/8pP+lqAYozE+Fb707BIHECc3Yc
	bTvOP2N2XBkAbGmFmyLEtaqH8AJw+NgkFVxLKl+GAofC612tMEQ3DY9Zoa1LnDp7zDfVghLVTEY
	6cVKHfpUspnUZMHJXohFqVla/FhYLjY8KCTexEXx5ZHxMxJMhv6PvCTKCzn6aEijEq40htssY3r
	0tWvfcxjC37FJcwtSsr6NK8BR1y54S1mYKxG6yH6QxRODMixShrV4BE19krVwtEXdldvHh96JQg
	M54oa2Flaq8ZfK6qxqEtNvK0WPttGuHPdj/y3MmuUQrj37rOEXcMVrdsg==
X-Received: by 2002:a05:6820:c8f:b0:6e2:2dcf:2cd4 with SMTP id 006d021491bc7-6ef0eec73fdmr9825677eaf.16.1791919007140;
        Tue, 13 Oct 2026 12:16:47 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef023a1c1dsm12597782eaf.10.2026.10.13.12.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:16:46 -0700 (PDT)
Message-ID: <baae166a-4464-4065-a642-348034cda28a@kernel.dk>
Date: Tue, 13 Oct 2026 13:16:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261013141046.GA12680@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_121648_436790_8BCE51A3 
X-CRM114-Status: GOOD (  15.43  )
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

On 10/13/26 8:10 AM, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,
> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.  So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix
> from Anuj, although making the combination work would of course be
> even better.

Agree on both of those (sashiko and folding the PI fix), but it's been
forever and let's at least get some testing done. As mentioned, it's in
a separate branch, easy to update. But if we were to have any hope of
making 7.4 and also not missing yet another release, then it would
basically have to happen asap.

-- 
Jens Axboe


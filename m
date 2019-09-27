Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5AEC4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 19:18:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA30207E0
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 19:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5IjhZIO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1CSg2oZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA30207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pwzl0Gq8iHy9TvLymzr8m/qhIoM/PSer/IK0C/Q3YXg=; b=V5IjhZIOLgY+ut
	54a3QOVmHCFQZAad8rbuaMjmbZ8EywO9C7wG2oYpzrevK9tHIhL8befwFVi/YKEjs0cXlWpMkyS80
	xAEp/oaViJ1BElRDk5qp4d0hHb84E2Ao5ybM9dNFwRwwLcwE4R5DBvlADlSjvuS+4+OhcQHPBcUmf
	geiveyx51/ng0vrLpkJbi/xFhQciCMLWweNgdZa/cTqL0h/Ng3qoqqZtVMPEEDmmlEXPWL49V2b3x
	TVlGH8AEGNYDLdWUsKJOcjV4fDwMbPlhbQ8sEEghpNPQ8QFQcEhXM7ukWrJ/4dJUglUTVFRkPEgXd
	UkEVhwCqbHXI9cwPfk8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDvlQ-0006Hj-Af; Fri, 27 Sep 2019 19:18:48 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDvlM-0006H5-FO
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 19:18:46 +0000
Received: by mail-wm1-x344.google.com with SMTP id r19so7117538wmh.2
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ow1TJdn0wU/PNvtjCyUuemBEiSzz/wD4mCwzclK+jE4=;
 b=1CSg2oZbMen4+lKMUxzaYn6bDfZbuRwQO6MSThdXL9uKza2KMExYFMpW43eVMdaC23
 sEQeAd7YAYrL85AphrfaIuL2lMK2uJDWaIhlsuvOOgVLULJAfVFkLOK3zUbnpiToAvLU
 4br1ui0eeic0KFKSMfgjLoLK/RIi6eqeLnO/QQBfAQWMystTjYjsjyi/UZzkIt0q/OFN
 hgCBYMpphXAYONSIc0vGOwpqZJj1Syz4Z0vn6U5HHagpjVLqXlV68lH0iE4kyvi5VnJE
 oFTHtSr8U6Yb9LGnad3pXJIuHSTp1wfMsQ8kap9XG26z2Lduu0xcvkxBr5dCwOx9EpCZ
 URSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ow1TJdn0wU/PNvtjCyUuemBEiSzz/wD4mCwzclK+jE4=;
 b=VdzvjkrFPNiJ89GXASjbPe6sj+Z80Hl5rieieaxl7KGtwsL1ZofuYfesIySL1eI1o0
 mdJPOJHaYIxYHR4SVIuTXUJR0TrJv+D90WBOC2Cjnwc34rwPJZFPwhr97s6unxZemVHY
 IlLnMhjaKw6w75NcYcHONg/MHE1DquxO0SVxLRE34G1e42T0x1njq4NaWO3/f0gcwoBl
 itzgQQ10pAvog1e+FzPTH1w8OYGWXDXs23y6OraSiRCf8NLoMOIDb6RmrG2jigrlaK9q
 cr8pS0SHLOY7Ijn8LQjiECYTEjJunrpepd6R6wRUhtPCTGkfAi5q6PHKnsqCOD/2y97p
 MYmg==
X-Gm-Message-State: APjAAAXKcDeMYsAt5dNRk+yX+/i2LKVTqHRF2DCEpmUpI6uSkWvn64ms
 4ThB5/R4Z2YDQwRxWmLEP8wh2YZ6gAAA+JHA
X-Google-Smtp-Source: APXvYqy+DB2pKLFOKCCvLDcFv/gFHFWMTek4vUq7c5TH1yiEsm1E0UXCZnuWa3GhtpxFNGyIR7VxBA==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr8149712wmh.155.1569611922524; 
 Fri, 27 Sep 2019 12:18:42 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
 by smtp.gmail.com with ESMTPSA id v8sm3964262wra.79.2019.09.27.12.18.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 12:18:41 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for kernel 5.4-rc1
To: Sagi Grimberg <sagi@grimberg.me>
References: <20190927175801.12900-1-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9d599517-dd43-6f40-a605-86fe011854e5@kernel.dk>
Date: Fri, 27 Sep 2019 21:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927175801.12900-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_121844_575478_BF49EE0E 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/27/19 7:58 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> This set consists of various fixes and clenaups:
> - controller removal race fix from Balbir
> - quirk additions from Gabriel and Jian-Hong
> - nvme-pci power state save fix from Mario
> - Add 64bit user commands (for 64bit registers) from Marta
> - nvme-rdma/nvme-tcp fixes from Max, Mark and Me
> - Minor cleanups and nits from James, Dan and John

Thanks Sagi, pulled.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

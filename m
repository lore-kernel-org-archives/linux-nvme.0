Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD61BC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:18:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5A120707
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lRX6y8p2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eMbcpyG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5A120707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ePB+m7omycaEdXKWxuECtNk076574D2KJEsiVJPjwnw=; b=lRX6y8p2Hp0NN8
	cLUxEabmVT+ZtQWYhil1hTckknD4k+z5iDNZKlJSBQqx7Li0EY8knAZrpJCYzvFGUq8vyRcz0Zm6Q
	zRY1uNfVxoZOx1bu4Tyxik5s+9T+dGo0BbOVGrvaaWYfl+lNNEWbNBKhNCyG4MhjUEue/cfM0rkLq
	q2U1BMxNl/y7qs8QFtTxKxgKsF77gaSAN4aC/BDcVJ+oVkNFq+xVcP6IHOoBGjtFhAgBoIdZjgifl
	NS9RcgGZWpOwzBOXnLnIao8FD05RcFc7T0UttUtBacDjgU+OR8npHX1IoNqcbz9SGk+nR0FELjMhT
	rtpzhF3CmL+afuljU1FA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jefpv-00006q-C5; Fri, 29 May 2020 14:18:15 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jefps-00006R-Rd
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 14:18:14 +0000
Received: by mail-pl1-x62a.google.com with SMTP id bg4so1215300plb.3
 for <linux-nvme@lists.infradead.org>; Fri, 29 May 2020 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vFk86EXtsKCeDly7uqWscsOEe4rJYmK/9rM41/0cNNo=;
 b=eMbcpyG0JJ8IpczRGqAHzEDKTqvpsH3s/ka7bm8PoFKGgb13AJ74aqjJkqs4HFnQeI
 9Ftiv/KTLFgD6wDD2GI2o4zhGKhq7ItgUl30BcPrUofBUbRhx0n6jJkWjhkN9eV3Gyzc
 MWsG291YGwV+RCpLzy/zkXsuTVhGKwFzL4ACZOCKmPa9Re0FH49dTxjCQnh3/WfmEuZd
 7SdLtFirUMgub6BFRTOuNSvuFG3iEQZ+FwL2Z+hadm/I/rrL3IHaYB7G528vhDF5b0h1
 oCl9K7QUu3w/E9PXc2XnZzXoKgOpkymfnUuwosmkd0i401889fIzrBhY8PwN1l9fEIuo
 rxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vFk86EXtsKCeDly7uqWscsOEe4rJYmK/9rM41/0cNNo=;
 b=D495w5BhlgULMwFwbLXFEntkel01s2dgLUQJ0nF2+ywjI2MZPmDm8QvG9wlHWYlOyC
 6FiJCyhLU7swXl9vrRJh5H970axzq61QIs+TByCDgnX715iuWUdvAzfZ9YQi5Y/a6g38
 KdvWgTHKHAi329dhvBCiiwicGPbMb5XlTJ4ZiSU5oX1t2FAtvRVsdxjTpsFemN5NngK7
 GHlbgvdg5oRVj5EfYCruLnDimiyJ6VHdcLWHlpaoVrGMayJFsG3TzyV4HB2PaV4EX37b
 KTdNAiVItp5TznhQguSDFr1olRkAFVkz88xS7G1JBD+gvhvU7tCbk0g5akGNuT25m+dE
 RjhA==
X-Gm-Message-State: AOAM530JzdZbjB3LZhOZqoWWL8gjRkzzVMTMZRH4qypcH/z/aGctbvY+
 e5mmd7uizUa9xe7y2rg8s/iWWp0o08RFTA==
X-Google-Smtp-Source: ABdhPJx1ph9FO0uJPxiEel7Q0EiHsxe0gr6USoYYB/1q6mYFBTPzokdsLj4T47urJWipkYn7SGLlcg==
X-Received: by 2002:a17:90a:5aa4:: with SMTP id
 n33mr9911935pji.226.1590761892021; 
 Fri, 29 May 2020 07:18:12 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id q5sm7594138pfl.199.2020.05.29.07.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 07:18:11 -0700 (PDT)
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
To: Christoph Hellwig <hch@lst.de>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
 <20200529122746.GB28107@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0dbabed4-d233-ce75-7ccd-c1c9922ecd28@kernel.dk>
Date: Fri, 29 May 2020 08:18:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529122746.GB28107@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_071812_889576_C7C5DD2C 
X-CRM114-Status: GOOD (  12.44  )
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
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/29/20 6:27 AM, Christoph Hellwig wrote:
> On Thu, May 28, 2020 at 09:36:23AM -0600, Jens Axboe wrote:
>> On 5/28/20 9:34 AM, Keith Busch wrote:
>>> For when drivers have a need to bypass error injection.
>>
>> Acked-by: Jens Axboe <axboe@kernel.dk
>>
>> Assuming this goes in through the NVMe tree.
> 
> Given that other drivers will need this as well, and the nvme queue for
> 5.8 is empty at the moment I think you should pick up the next version
> once it has better naming and documentation.

Sure

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

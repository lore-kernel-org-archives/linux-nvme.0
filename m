Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA1CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1HuJ2W+QpQjeVYmHeslUCmfHHxxZeV5A2pWY7A5hVk=; b=TNNo+LBIe3cZ58nn0NC4PgDr5k
	M0cvpjzIp8f7lldUlvReZyeh8Kv7YsabWOEO6MgrRbSUqVSc9+BetX3CrDc+YIIc7NigA5IFi7iN8
	FR58VsjaOThjw1UzEPu4bUJwza4FIusuY2dwy/jinOLSirLVyUnr4YNzG7Wy3g67OgkJ9bZ686imf
	IseMXClnPuNU9N8hiQRslCNJ+liyoFsiUsPtg9BVP4oyVEllsF59bfUCjqYOmeyWa/jRQassWE6bc
	4BwpESerxA3+Q6m1Q6+WakF8Rox/VLgQ/Slfnfflgu0Ci7QZliPlXdHctbhX+Q185DOgRSfOGTkoe
	T3VBl1Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np7yX-00BoXU-HH; Thu, 12 May 2022 12:31:25 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np7yV-00BoWW-Cv
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 12:31:24 +0000
Received: by mail-pg1-x532.google.com with SMTP id h186so1820196pgc.3
 for <linux-nvme@lists.infradead.org>; Thu, 12 May 2022 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=V1HuJ2W+QpQjeVYmHeslUCmfHHxxZeV5A2pWY7A5hVk=;
 b=siY9VER8FhUdPqzbEapXlOZyiDnaxEEbWFUAXbsuczxV1CjKlCACfRcoxJZxEjH5ax
 OtB74BvnBXSR3hixQCbqilrcL4BIzvuUQ/zjU90yfV4XizL+XwlFzqLn+yZbmE/siryM
 2L8lZCuGuigKdL8yZnHj+CxNigRWpBSzu3azvZTsI+z76gDJMCMbBC2DoCI5eoqdtr+s
 KjP4XE74vj0wenQ0sQitM7Wa70MMHl2yv56Gd2DZwwv8ZbG0JY2VciwtOHNMpUJvZ298
 8VFT6px48AN4TZP8DUU12o5YL6v0vPWiWP36DogYa6Mmpf/bqw0eritNTtgCcS9xS7LG
 m1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=V1HuJ2W+QpQjeVYmHeslUCmfHHxxZeV5A2pWY7A5hVk=;
 b=Axf6H4zUPDSg2CbSsG5Yn02Zdjc8kUn3fem3ZjMDRHmv/EkHRily+A4i9E9Ic6JzFT
 qAfF3Kyz0YHyhs+tZUH8LH0KE/zqA/GiOb+h6rAnAZOKWYEVKpv8XXeuKiABxqoJZ1w1
 j8o2v/adIVsVDG9AuXgDIpeuztbiXh60Ac0jt3cERyUBzV36342oQ8bQGvlgWEloSmsu
 L9e0IWSwMIAfoD3do10iqQv7V4NlMz6jv9CEnTH2UyIFVmf0RJH25/vpa48thf6KH3Ba
 Kacvx7u8sgtaAiujT7mOFdqeg0crbWeNXFnaMXpPZDdv2BsvRJrc98xrc7BzbO+0p7nA
 QR8Q==
X-Gm-Message-State: AOAM5318KTEFicyIYT0IbKAYOkzkpNwcgHtX+X3iYhBUuYReo377x4eC
 j14ZfELqBBdG1ta7aMY/8/u1nw==
X-Google-Smtp-Source: ABdhPJyDYK6f9G0PNbHRaiWTYyPhkhEQVtpTNMumvuS/aIOGzhTfGpgapvmt00ZNfGM45MVGB9EMDw==
X-Received: by 2002:a63:4b17:0:b0:3c5:f761:c77a with SMTP id
 y23-20020a634b17000000b003c5f761c77amr24466913pga.117.1652358680329; 
 Thu, 12 May 2022 05:31:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a170902821400b0015e8d4eb238sm3773799pln.130.2022.05.12.05.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 05:31:19 -0700 (PDT)
Message-ID: <74e33b5d-71ce-1309-7897-e5e8ad2ed778@kernel.dk>
Date: Thu, 12 May 2022 06:31:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 2/6] block: wire-up support for passthrough plugging
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055310epcas5p46650f5b6fe963279f686b8f50a98a286@epcas5p4.samsung.com>
 <20220511054750.20432-3-joshi.k@samsung.com> <YnyaRB+u1x6nIVp1@T590>
 <20220512080912.GA26882@lst.de> <YnzI7CgI+KOHNKPb@T590>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YnzI7CgI+KOHNKPb@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_053123_484481_12138457 
X-CRM114-Status: GOOD (  14.60  )
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

On 5/12/22 2:44 AM, Ming Lei wrote:
> On Thu, May 12, 2022 at 10:09:12AM +0200, Christoph Hellwig wrote:
>> On Thu, May 12, 2022 at 01:25:24PM +0800, Ming Lei wrote:
>>> This way may cause nested plugging, and breaks xfstests generic/131.
>>> Also may cause io hang since request can't be polled before flushing
>>> plug in blk_execute_rq().
>>
>> Looking at this again, yes blk_mq_request_bypass_insert is probably the
>> wrong place.
>>
>>> I'd suggest to apply the plug in blk_execute_rq_nowait(), such as:
>>
>> Do we really need the use_plug parameter and the extra helper?  If
>> someone holds a plug over passthrough command submission I think
>> we can assume they actually do want to use it.  Otherwise this does
>> indeed look like the better plan.
> 
> use_plug is just for avoiding hang in blk_rq_poll_completion(), so
> I think we can bypass plug if one polled rq is executed inside
> blk_execute_rq().

Agree, and good catch. Do you want to send out a patch for this?

-- 
Jens Axboe



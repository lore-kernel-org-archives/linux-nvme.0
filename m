Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C7DC4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cj39quEbp/3rMGQQSZrsh39+o0IBwtiFFjZPI9seYxY=; b=JKyaZHWciPLkJX12sXiyLk3E4R
	94sxoP/rHHOIta+tkfG8zHJSHt1y2vHEylq4dR5B9ukzVh/+4GnCey3+I7q8uRRTkrwyp7+dF77Cp
	Oc5xGVOhWX+o4ndw6HOXQHnR41pwPS/D1l3ZUwV4557PqGNKCKn42rV91XwXpuawlMQcLz5krLVUl
	9TO8wqT8Ayrk5c6hzMLPoYeM46+TkQMzGunDQ7kpHrNsetRI8tqpD93kEW7ZDlgXUmsJTNpSRDGsn
	qgOibdfJiYlhOMydRAoU4ikotwNmiDBR2rlcJoLmirXxkBZzMVg/02P4ScWp7Ue2saQsDr+4bLHEW
	I3lRIRPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2WlM-0000000Cppv-0YMr;
	Thu, 02 May 2024 13:46:16 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2WlI-0000000Cpmq-02MB
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 13:46:15 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7da55194b31so70178339f.3
        for <linux-nvme@lists.infradead.org>; Thu, 02 May 2024 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714657569; x=1715262369; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cj39quEbp/3rMGQQSZrsh39+o0IBwtiFFjZPI9seYxY=;
        b=uBdh4Q4fzTy7G1SU35hXcGxHcdqglVEWmVn17uhCYrS3cW/ElvRfUCWFJCp4hq0T1l
         u0uYEfH+6Mao7VxY5a7BOizHcOHebY/aOX/fU4PxoBNtLNWNnm3wYLjoXuwgWqdjsrAU
         uYVMNV+quXPA42vKQsqbZcpKxFfmlwTbRosVzZ/YeuH84PsSFoDq0iTgv1YNO/AsZI5G
         v3Cbl0p7ikh2gRNvCYjL6/J53uWD45JJWSFd9xMOZ3V7NCehHOqnz2A3MTafwJxlCokt
         1KVYrUL9iLJkoRcc9jX+kTckULtFr07JrXVQd+DPE53+iCUgFa9SYoO/gyU3ePG53J9f
         INDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657569; x=1715262369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj39quEbp/3rMGQQSZrsh39+o0IBwtiFFjZPI9seYxY=;
        b=vD8jQOtoRF23S9oytXK7/5EUk3jsuOWNAPeUF1+IfDnvrILBHb4j820L4QwbisNIoI
         M7m+fU0j5OMbUJB804Im0OgNwL2xUPlHTDM0i3AmuTU3HJjjVJCQUkOVQ9eOdRwyvJls
         o8yIVqhBidBM68OlrHVtCyG2mRAUf3d6O5TfWDPH5IMKs54GBJGDgI86tWGTljse6PA2
         bRVu+E7UgOKFXMmkuBcnnF3uNeT9W9peQaR+CQqE2x4tDuk+Kqi9atBWxui7wdKp+3e5
         pc7tg9Ey6N/7vBJ8T+2VGq8PJmVihGeVNrQ5XDk8sA99pWBaz8KgUvAIETz+qgrf+aw4
         V78A==
X-Gm-Message-State: AOJu0YzQxwNrFlnGQfeusOMjUucA3B9SmyeTfcj1hHIEUKyxoPQ+zQNC
	u2fYO+GcID5LRamHJEtBo347hbKY9Uq2skA01laSDDuW9Sr0OLesuVZMgmB3434=
X-Google-Smtp-Source: AGHT+IGDAmk36dAIKwrFnljo/1GfxFQWnWzeXir/YCnj4unuMvKujTn4tRaWdOkWc6ES58nntSjbHQ==
X-Received: by 2002:a6b:3113:0:b0:7dd:88df:b673 with SMTP id j19-20020a6b3113000000b007dd88dfb673mr6994262ioa.0.1714657568826;
        Thu, 02 May 2024 06:46:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p6-20020a0566022b0600b007dee4fc847csm213333iov.32.2024.05.02.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:46:08 -0700 (PDT)
Message-ID: <b34db4f2-9f95-4426-9d0d-d99abedc896b@kernel.dk>
Date: Thu, 2 May 2024 07:46:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.9
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZjOOa7KiIGnOjlDM@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZjOOa7KiIGnOjlDM@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_064612_184031_676251F3 
X-CRM114-Status: GOOD (  10.29  )
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

On 5/2/24 7:00 AM, Keith Busch wrote:
> Jens:
> 
> I am on travel right now, and I've lost communication with my remote
> server with my signing and push keys; therefore this does not have a
> tag, much less a signed one. Since nvme is a bit behind on our pull
> requests, I would like to get this out before the next rc. You can ping
> me on back channel if you want to verify the legitimacy of the pull.

Verified out-of-band - thanks, pulled!

-- 
Jens Axboe



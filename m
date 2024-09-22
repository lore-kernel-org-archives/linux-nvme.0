Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D67CF9C64
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xz2U6XQqiti0rUcBqjpb644SVzKZA15ooHy8rXkzac8=; b=xpTd86fzZpLJda71TFpfwcsDeU
	lVmSbgTburWPDvttaBwFYwQofk7SPWvHprFcNT3b+zmcT5SVdd3w+qi/t7n7QIJIGVWsYY/fjtqzz
	7KB33YXlseN1Y3mqXd6QEZORivymm9L64VKvMcGYzdtqeqZybsskeqDCnIdstudZKKBUNZluiK6rf
	kuZTWsc30j2JAPgNNZta5hLDywLIwSrXLhS+rTjdilvBcRGVv2fCySoertP5kpX8pj/O3YAbMf/dY
	eWy+ZM5MHCs0TyU3OXOnj4jEybB0bxT+nMRexctO5t1lfayqAlfJ31JvJjD+c36i5+qxpm/GDyoOz
	5hkUQt5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssRUz-0000000FZ7n-2LVW;
	Sun, 22 Sep 2024 18:39:57 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssRUw-0000000FZ7J-2rvr
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 18:39:56 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso2438327a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 22 Sep 2024 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727030393; x=1727635193; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz2U6XQqiti0rUcBqjpb644SVzKZA15ooHy8rXkzac8=;
        b=FMpGxGQ3wjpDJFLZ+SxgwWsXvlodvNDIvyQHPVKLN0F+I048oRWyacEYlOOzVHyQOb
         i9ZbxgblU5v4bH14MFXCKt82kx2EqJFP94Lq3SVDtIkkOISMpy8W9p+PKp4BwjhvWln4
         gjVfnazfnlnLER33zoFGHrDcRacVVGrT9sof+5FfQz0QLOwvUJxi5DjKOs6yKbZ/P/js
         oml7i6M1PabNVc6vFGW9X23OxYji41uDI1fgouPtyNj8lzkc30e80WLTPewYS0GBzuWt
         UMB0ttz9FR4q2MGtiRflIO1AHkjg544OsBIF4mw99TmyGZlsqnRBYEsC6hRvcQQuTdau
         JNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727030393; x=1727635193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz2U6XQqiti0rUcBqjpb644SVzKZA15ooHy8rXkzac8=;
        b=ZoRjp/wo8RQYWBqcd5jmu6PMf15BDKDg6Z2/j59GIceAdDuxMc1vfTgUbptu24zhIB
         gPmqcsy93+t/z3x/8rvF6454zq/Hde2gMSIqDwHPsVkXdzztfbDFOkGTC5i/Lkl1/qgq
         4ArrjXBqIcuXXjkD7+ZbRe6hvueqV92YCZeCivVYQvVz6aZLs2t41peXW9LGXbA3BeI9
         aNzV6yAFF1Qq5VP/4igRGp52tZUo1a8DONoYfce6PZbs+cTRVamXOtjMrbLa/cYOSSuC
         +xmSh+0pYWNDXVxNe4yZp7zR4u/bFUNrfc3UDRAnE9sT0WZVQ1AEVkI7PA+VVYR0hgQ7
         vYSQ==
X-Gm-Message-State: AOJu0Yy6F7/HhYRAuUysTTtII0sj3DZjUV+573uMhKLUol+pkT9OsiUK
	7/vm0Cmu0YfeA0idDG3FZLgIOBI8Xh763p9MK7QsSd52bcIfyRuwjpr/xQ==
X-Google-Smtp-Source: AGHT+IH00cN5uUBepfTDPT/IQ8B9G9np7V7dtGzPafDoE//+M51HpA7EKc2aowaJw8VtgYVolpS0LA==
X-Received: by 2002:a17:90a:cf18:b0:2d3:b8d6:d041 with SMTP id 98e67ed59e1d1-2dd80c95adfmr10860333a91.32.1727030393272;
        Sun, 22 Sep 2024 11:39:53 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:7cd9:6049:93c1:442? ([240b:10:2720:5500:7cd9:6049:93c1:442])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3666bsm7883537a91.45.2024.09.22.11.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 11:39:52 -0700 (PDT)
Message-ID: <e9e8fa6b-dc69-41f7-91c6-4e3b5f34a454@gmail.com>
Date: Mon, 23 Sep 2024 03:39:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: add 'lba_shift' ns attribute
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20240922105621.4642-1-ikegami.t@gmail.com>
 <ZvA3FbEIWC-crwmB@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZvA3FbEIWC-crwmB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_113954_763908_13FA313D 
X-CRM114-Status: UNSURE (   8.00  )
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

Okay will do consider to use the attribute mentioned. Thank you.

On 2024/09/23 0:26, Keith Busch wrote:
> On Sun, Sep 22, 2024 at 07:55:42PM +0900, Tokunori Ikegami wrote:
>> This is to reduce the identify commands to get the information.
> This proposed attribute is redundant with the request_queue's already
> exported "logical_block_size" attribute.


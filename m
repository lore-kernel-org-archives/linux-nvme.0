Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF1FE776E9
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 01:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BB3iEMAprkU5w0PW0FKGJedlQe7dl0je9yUM666sRNU=; b=K1642OaY2HTVrUPEs1aPCnNM13
	2VDtSYVWbCbLv4Hg/wbtcWutcBA3SW52XsqkYUPU60DURG+ff+i7CYFA2H4gkgj5OMotg7SNEqh0C
	drdOs4bXlbgrx/gdilVMkwcrevipU6kaMsmmgqlcVqcfzWHkOUXnXe5VhDT0k/1uakaSwLrG5OekB
	TLJ7OlBZn24dVSkPlpNGrjrMXC2Z1VcZy8h2noYgSvlD26xe5cjFU1U+/X3qPDAZU+zfSJBcT1D+1
	OwOcofzTllI/ClYMyCbqE94ZwNP8+aNhQnkps4UejkWPiJ+nIHK2nUDls4Y5g4CaKbCHvl9iAjVSV
	rJn46uCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnU1e-00DcQO-0I;
	Tue, 03 Oct 2023 01:16:38 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnU1Z-00DcPK-2z
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 01:16:35 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b0a16f0338so178153241.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696295791; x=1696900591; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BB3iEMAprkU5w0PW0FKGJedlQe7dl0je9yUM666sRNU=;
        b=xb1NmmnsyX5nnu0puPZfu8jKVXxLKBIJXmQyBXg/fF8Yqd/bwLK2QJEJ10IjHP/ukt
         jTIOdvCcrxF9KucuRKvnSBxQYjz7f0rHqe0tHIP7kWyCSDjkxm6KufeDMqHmWVUHeBR3
         AdjkH47pRIDEVZa8BQVz010Q36Uq+V2hTRgIVEw/U0wEWY1Y5eyNzSoN0ut14yxU6s5+
         Sptdhqrb6u7X7vW1HpMudqk1UT1w8/M6MafTAI7my3vnORF7gmbadSRQT50xw4lFxt4a
         WGm+Xm98UmHeY93m2SPoOoyuHJkubFtbQt3esJWjqxWX9e4tMg/wrTyOqc253CtxYBlr
         lXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696295791; x=1696900591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB3iEMAprkU5w0PW0FKGJedlQe7dl0je9yUM666sRNU=;
        b=gCpMpW7YMaPGfLNS8q9qDQfT1gkiVanFfjfqnV0Je1lmRI24C9K1YM8uVHQUMzBtxc
         gI2MQ/fFQJlCQNJSx79P6Upx0PXGL7Xxr2TbbviC5XXK6IvcH4rc7zYpM17a6lifiJab
         MDcwWywtPhj2jsPwNV2DD5bnk9fLgWdXwhj3KXajuoXZJO+ohJs/29/lSoMFq8DrVZBF
         o8gbQkEBYgtYvU7eNHXbWEI+c6P8Us1baKLgKO8MhJPiINpBnUApv6tV5WgskTTFEUSp
         awkX1RQDrw/U8yJiVKgX1fsf+tg+/lurX1+Z5Ui2e4zs0roqRjb/zjETOYiP2A27L+tM
         zt4A==
X-Gm-Message-State: AOJu0YxnCQySxu7pPSxruJFVtHCisgu5ZxLjvQ0Z4wf/4Q6XZyspszhS
	gsC3iCtts4qunLG0anOUgUnMCQ==
X-Google-Smtp-Source: AGHT+IE35X8Sz7vQVe8EdhhrT+0QOjqYkjnQDhJaF4R5rYBMaePmI4d2ce5eF4SjFNEwfyHeQyalJQ==
X-Received: by 2002:a1f:4ac1:0:b0:49a:b737:4dfa with SMTP id x184-20020a1f4ac1000000b0049ab7374dfamr9143255vka.4.1696295791419;
        Mon, 02 Oct 2023 18:16:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00273fc850342sm7572762pjb.20.2023.10.02.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:16:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qnU1S-008hIN-36;
	Tue, 03 Oct 2023 12:16:26 +1100
Date: Tue, 3 Oct 2023 12:16:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <ZRtrap9v9xJrf6nq@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-12-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_181634_191102_89AA96D4 
X-CRM114-Status: GOOD (  17.94  )
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

On Fri, Sep 29, 2023 at 10:27:16AM +0000, John Garry wrote:
> The low-space allocator doesn't honour the alignment requirement, so don't
> attempt to even use it (when we have an alignment requirement).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 30c931b38853..328134c22104 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
>  {
>  	int			error;
>  
> +	/* The allocator doesn't honour args->alignment */
> +	if (args->alignment > 1)
> +		return 0;
> +

How does this happen?

The earlier failing aligned allocations will clear alignment before
we get here....

-Dave.
-- 
Dave Chinner
david@fromorbit.com


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3B3C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=311tmwoPi+X9O5T0jkqGhTRpiGHy+F0ctJn+X1ijaso=; b=NCJCd76cIjyUVr/r3r+n1VjRpn
	5b+Zb13dcxwlmMU50SHFJ5JRBqATPVOufJgKvZi9iD4jLsfVUY/Zu3t76rxvsoyG2L87kOalR2WkV
	1UqBBHDXoRtxt/BJvskqN7yfKFfjzaHfdKg6OrepsuA1C7kX9dGDxtXDSePGTBNMVEs7CQtH8Nhpe
	mQrMRoJmOSSpmgdvDMvi6RDzOEASI1OsyZUoG3bMzzSfVX9J9c9xEUMvxZWlrGuzaUnUICoI31Kbw
	FYga47l6fg0bN79QfPwIZx7UZz6eck24f1QgKi9DfUjKkoiXNfe+koiQ85CFoSsyx6PBPXFIM9Tl+
	xLo93aKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcT0c-00DtJA-0t;
	Wed, 15 Mar 2023 15:25:46 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcT0Z-00DtHp-0I
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 15:25:44 +0000
Received: by mail-il1-x130.google.com with SMTP id s7so2929050ilv.12
        for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678893940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=311tmwoPi+X9O5T0jkqGhTRpiGHy+F0ctJn+X1ijaso=;
        b=qYE0Yh+Dr6g5FhU3UDIDpBZiS8bSqullsfODEjWgs48s22YaiRWZjhi72NvARPqxA6
         Mts/ktND9T2CdEZcKS7/GIQvhMpcqWf/XUTxXzqf4ArZpijmzmcLT3Vwaqd7Iqoa6BlH
         ExzgK2RISR/MkDPFNYNKxg0LZtJ27kwk4q7JdhPLwuYLyU9/Gi2ixKzw7PYz4iFVsUaO
         3qXmPreckFEdOvvPf1bFULR69krUdEAAVLZkD6q5l1iM5GZLkxHQRS0VpJBvYT34Kngg
         13HVI6kosHszl3H84XHVeNYdVbgew4iSTjXRIelK6y/iKxWhM4v1ajISD46TzaV9VPcv
         vDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=311tmwoPi+X9O5T0jkqGhTRpiGHy+F0ctJn+X1ijaso=;
        b=SEZ9zF/t/7vkE6XWeb1Y/qfmIezXSqIWwHWCzsKpwGtC8FUxj3cZbQzRRHKpbZghMZ
         S9VO0+RRZk4OL3J1iz9yunkBZ2V9VJQydXtRUUb21fm6PzpAgGAz/+KGfqUoBzzO+46d
         ThHk6EBHw3sjBAW+GaiSFkxAJwa0vU7KYbeIdvjcU+9UkV3luLxyCS4Xm5Si+snVn/T/
         KzCUDpEPwnKEbTzw8OMWAv4qsUqZJE9MxURY9RXUxBqiAzW4mUnBZUKW0yzTkfE9Qt4i
         apeWbU0NQHyUlcllnakrAvnsqkFoC8Bd6cJTSqYqCUhYfHjyr+p8A3MFfxNNXa0bgveE
         U0Mw==
X-Gm-Message-State: AO0yUKWmCr10yDIlf8fWQpzqnLtLvHe7ca0ac3jNE0GdRrKY8OHT9rvE
	wRzN8SbpJqBmebM1m9L+i2d4hQ==
X-Google-Smtp-Source: AK7set+GXeS45AV6ZCOSt9EJghEpaRhu4keAdlUsc5MciV2dt1MDmCOkfh6V8QLE789iJhm5iwmeYQ==
X-Received: by 2002:a92:d704:0:b0:317:943c:2280 with SMTP id m4-20020a92d704000000b00317943c2280mr10003193iln.0.1678893940152;
        Wed, 15 Mar 2023 08:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h11-20020a02b60b000000b003e80d0843e4sm1713415jam.78.2023.03.15.08.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:25:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com, 
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, guz.fnst@cn.fujitsu.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
References: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is
 done for bio-based device
Message-Id: <167889393912.42717.4228399799157411797.b4-ty@kernel.dk>
Date: Wed, 15 Mar 2023 09:25:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_082543_133096_513CACC9 
X-CRM114-Status: GOOD (  10.47  )
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


On Thu, 23 Feb 2023 17:12:26 +0800, Yu Kuai wrote:
> While using iostat for raid, I observed very strange 'await'
> occasionally, and turns out it's due to that 'ios' and 'sectors' is
> counted in bdev_start_io_acct(), while 'nsecs' is counted in
> bdev_end_io_acct(). I'm not sure why they are ccounted like that
> but I think this behaviour is obviously wrong because user will get
> wrong disk stats.
> 
> [...]

Applied, thanks!

[1/1] block: count 'ios' and 'sectors' when io is done for bio-based device
      commit: 5f27571382ca42daa3e3d40d1b252bf18c2b61d2

Best regards,
-- 
Jens Axboe





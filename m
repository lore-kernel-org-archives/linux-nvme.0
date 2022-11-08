Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A9BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bWo0wICwvqJmPXPuoTpa5Ov9X6wNIXJjhaYFsJ+BGYo=; b=iSPZiIQ7O0OFXUTa4AXXQWdx/j
	vKqpvYThz5iJOJ/X/o6bjzk7IM+9lnpUr4+AZCWu+UCFWnBFfzBvthsIHzGKV3Ny7pCwsBDeamJXn
	2oMZ25fgzkvagzKLTL9xZhdCeS9McKhcOXHOBXf2L81IQMb4HHWoqCW2tBjuMEpsCU0IRKMNERNYi
	7D8nXM2SNyFLPCFUnODapB198Q5gyx0Ovau+G4LibC0Ip1I/3W226IQmejP9UQntBNkylC4FoHEaK
	9TkpNSdlhLjxjcc4LY/6xn0oJKU2bGZfTlxriHlGXeThJOFiy0iecn8g8rkk0ZcdRpGd5FPzxXX0W
	0KAyM9Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osSQt-00727G-Hr; Tue, 08 Nov 2022 17:30:43 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osSQm-00726O-MB
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 17:30:38 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13bd2aea61bso17049358fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWo0wICwvqJmPXPuoTpa5Ov9X6wNIXJjhaYFsJ+BGYo=;
        b=inpZwFESW1ZamihaSqdrc9ChUddB6Fjv4GA30UUriCnKoWNZPua4c19i62HP0o9S2a
         qEWl1Tp7GsrnEFR1/5QI1MAS9CF6nX/bGHjx3Lk5QfR6EB6Q4YqdByIEx0PYn5SGa4F6
         qc1DldWyqPJs1pzLWEnAx3R6itk4Fxamd6ErGvU5koAuSn+3HgoI6MX7oPMDX7/w74tm
         UT6a8EYtym0NbjYnsulw9YHXuHNzcvyt9X9t4SPqvrzBwcXYI7p1KW53k1KjJJlm9K5j
         I8ZT1Pfs6P/hMgzIbRnAaI/9h9kNfTxXobMUivlUo2RcAV2ZL9egrsTRPtfB8LZiyNke
         cETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWo0wICwvqJmPXPuoTpa5Ov9X6wNIXJjhaYFsJ+BGYo=;
        b=4ZxZW05dP9QO4NLuMM1SKMlbljXbPGSB92GeToMZK5ORQWSOewrHUvHD3NRl9nOtvE
         4113BCt9XR73vcbuRdOYmrMxKdWQ4aaYGHSh1UC4y+XR7Gw4delrKeFcdBLmHcqGWZPv
         XuyYQRFUvGyMSvyeXV5ODyn2F3CJFOTdIuzFSB42iJF3Ay8gBV17db6RxPrqIAWtcrZz
         NeH9j52PGRcCLpUut/+dao60Vj3RzaH404ZhStyLWI4iFGAJrZ41PA7u3tQGmhqXQI3I
         iYOIgptirRYM0LR5JruNHZXlL+Qv1g/oU2mn4rOB+4yGPH6LXq3yAk8/ahtpSE4Uv1Uz
         u6+A==
X-Gm-Message-State: ACrzQf2Hg65XJX3FFlU3PbfMnsfA2+GnJetSF7KqkL6YlXXUkGA1+hex
	cyF90McOtuNgbRU/7JIXxfCgQVqaRWbqWYB/Hn8asw==
X-Google-Smtp-Source: AMsMyM5PyRLrb7aHWWG0mjHPxLyk0Yjif/RFNPSHYipaQZ54lZuk3GTphB97+yjXW9cIHwHIwpFjeA/4v43I8HrXxPY=
X-Received: by 2002:a05:6870:3516:b0:13b:8bc3:1140 with SMTP id
 k22-20020a056870351600b0013b8bc31140mr42724335oah.293.1667928635061; Tue, 08
 Nov 2022 09:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com> <Y2qJE2Bpbvnf5Ejb@kbusch-mbp>
In-Reply-To: <Y2qJE2Bpbvnf5Ejb@kbusch-mbp>
From: Francesco Ruggeri <fruggeri@arista.com>
Date: Tue, 8 Nov 2022 09:30:23 -0800
Message-ID: <CA+HUmGijWOvmt_+UZyc8bArdOYMecDUbwpMiSBBjnfJsLx6ofg@mail.gmail.com>
Subject: Re: nvme: hung task in blk_mq_freeze_queue_wait
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, hch@lst.de, axboe@fb.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_093036_988249_80DD7C22 
X-CRM114-Status: GOOD (  10.02  )
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

On Tue, Nov 8, 2022 at 8:51 AM Keith Busch <kbusch@kernel.org> wrote:
> That is an old kernel, I think it'd be worth trying something newer to
> confirm if this observation isn't already fixed. Specifically, it looks
> like you have multiple namespaces timing out IO near simultaneously, and
> causing a mismatched handling. That kind of thing was fixed after the
> follow (plus some prior dependencies):
>
>   commit d6135c3a1ec0cddda7b8b8e1b5b4abeeafd98289
>   Author: Keith Busch <kbusch@kernel.org>
>   Date:   Tue May 14 14:46:09 2019 -0600
>
>       nvme-pci: Sync queues on reset


On Tue, Nov 8, 2022 at 3:29 AM Hillf Danton <hdanton@sina.com> wrote:
>
> Given blk_mq_freeze_queue_wait() in the call trace, another explanation
> may be percpu refcount [1], which can be tested with the diff attached.
>
> Only for thoughts.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/block/blk-mq.c?h=next-20221104#n228
>
> Hillf

Thanks Keith, Hillf, I will look into that.

Francesco


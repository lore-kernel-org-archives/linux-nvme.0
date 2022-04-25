Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15477C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rifsCv69nw69I4GK+bCshQc/cldrT0s0BDup/p3lDA=; b=h2NmLh4rPlGuF0hhrMN+T3GjrO
	IOQYw5yZP99Jq9Nu635go3/LOj5lzxsY2bQ4PUizR0JICP195icnw/uFK8SiC1gQpDMZCIIJoCA95
	Tvhs+G0PpqQEghYt9d5jUq0Jm23I6ZgQVbr2G53UtU+q1h5znMCMREik6b+Zf1/6zIRz0EV+ytJRH
	YgBCJEklzXVBStd11WK2QHna+2ZAhCcbKC6w5i9mm+WF+gKjqLDzz9Oq/FW/uEt/EpMzrNchBotdO
	JZfBY/I2IYURNTdNDZnkXdk1q8vJlS3MYUzUTqmQ4Pq/0Fnu9+avMHd3Y9An0hVh67+vpAUFWp4i+
	dMgqLoAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3bg-00AuGm-OZ; Mon, 25 Apr 2022 18:38:44 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3bd-00AuET-OR
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:38:43 +0000
Received: by mail-io1-xd34.google.com with SMTP id 79so16850570iou.7
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=8rifsCv69nw69I4GK+bCshQc/cldrT0s0BDup/p3lDA=;
 b=snebphsNQtpdq/ohNXnGeiRMsil3rcL47KdegCFOuFFfqsYZ43enuZoTv8QYh/Gr79
 VjZHHuYjoJHLOn/guoImYrvAhuhzdMj48CPXAg64TLLn7e8WZviQUBLA7nyedjcnV4q9
 ZVK3ZoSKlxicdRzBkF+sCSnXD5qh2KInb40cg5JrWR+h5FkgVXdvkRdtoH/q1bQgP8hy
 HYwJnKMXRTBNmsw509oivV8jtXU300TdWvwb/UnBeQT0yK8U/VI2clJ3Bp2W8qRhaYtD
 45CRu111aeveRXFccPNe3cHglRjiiL2EtwzzfwrqggZLhfU5d1LE4Guyz7l/VZpnWWxb
 ATYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=8rifsCv69nw69I4GK+bCshQc/cldrT0s0BDup/p3lDA=;
 b=GPlqW6/YrgnyKrGajuzULsak/WQapysg9xxyjdkxUeOBbVpMYTJQ1z3+u/87VXG1nt
 Y0CcAc4ixUGt2Gwj0xbt1dLOar8gNR4cg2JMbxAt4IW6RVTGEa/7Izh+JFwwi4J0FRAg
 hAUqsEaJ7IFg5+v787BVpXTQkZOuucvZpg0SbPZ8PLfkcUJ6ypWGGtzFaLPGaDrtC/cG
 rnpujepmAsjQXRR5TcwvayEoIe8lVEQpFii4fXivjvi70Rtvze2dc47yRi+ZCUaesuZ8
 kiHDcKXpOewktmlxBcY/xRIEcIp2lpdhCDtaJ5wudwAD14UjhUhCO21rOVZVo01zir2r
 64qA==
X-Gm-Message-State: AOAM530n+KgzIYqWIfV9ZEtTkK7IXjW3XorXK5RDQKS421icEqQeAYaS
 6mUE2N/WPOa9VATTxA7IAYkBnQ==
X-Google-Smtp-Source: ABdhPJxtf54grF47OAFHtwhuSFVj0W3OCtRnFivuE8zvEVlrgD8vXDtiUevVPhD71wB+oVHrR4s5qQ==
X-Received: by 2002:a05:6638:130d:b0:32a:e3da:92d0 with SMTP id
 r13-20020a056638130d00b0032ae3da92d0mr3523801jad.141.1650911917291; 
 Mon, 25 Apr 2022 11:38:37 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a6bfe05000000b006572a49d97fsm8132234ioh.49.2022.04.25.11.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 11:38:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, kernel-team@fb.com, shr@fb.com,
 linux-nvme@lists.infradead.org
Cc: joshi.k@samsung.com
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
Subject: Re: [PATCH v3 00/12] add large CQE support for io-uring
Message-Id: <165091191658.1541118.14572706023286710745.b4-ty@kernel.dk>
Date: Mon, 25 Apr 2022 12:38:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_113841_820402_A83AF57F 
X-CRM114-Status: GOOD (  10.60  )
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

On Mon, 25 Apr 2022 11:25:18 -0700, Stefan Roesch wrote:
> This adds the large CQE support for io-uring. Large CQE's are 16 bytes longer.
> To support the longer CQE's the allocation part is changed and when the CQE is
> accessed.
> 
> The allocation of the large CQE's is twice as big, so the allocation size is
> doubled. The ring size calculation needs to take this into account.
> 
> [...]

Applied, thanks!

[01/12] io_uring: support CQE32 in io_uring_cqe
        commit: fd5bd0a6ce17d29a41a05e1a90e0bf9589afcc61
[02/12] io_uring: wire up inline completion path for CQE32
        commit: f867ab4b4ff36109c62e2babcbbfb28937409d3a
[03/12] io_uring: change ring size calculation for CQE32
        commit: 279480550322febcceeecc3ca655fb04f3783c43
[04/12] io_uring: add CQE32 setup processing
        commit: 823d4b0ba7cd3c3fa3c3f2578517cf6ec1cbd932
[05/12] io_uring: add CQE32 completion processing
        commit: e9ba19e1015db1f874d15b3cc6d96a4b0420e647
[06/12] io_uring: modify io_get_cqe for CQE32
        commit: e2caab09ddfc573fd89fa77a5963577f6c7331d8
[07/12] io_uring: flush completions for CQE32
        commit: 0f5ddaf0afb7ca17d645ddba4ad866ce845028a3
[08/12] io_uring: overflow processing for CQE32
        commit: e440146360bac2740298c46e1d26802a8006d18f
[09/12] io_uring: add tracing for additional CQE32 fields
        commit: 0db691c0a5959c1e412d9237449c56b345777e57
[10/12] io_uring: support CQE32 in /proc info
        commit: 3b5a857e9998e18d970496b8989cd73c8214bb57
[11/12] io_uring: enable CQE32
        commit: 3b27f0e387239593c3074f8f9bcefea05b25ab7e
[12/12] io_uring: support CQE32 for nop operation
        commit: c5eb9a698f2a082cdfbfdc0b32ed8d855bc6040e

Best regards,
-- 
Jens Axboe




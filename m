Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05734C6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nAY+ae4YYDmrPwboA5knbssvQe7BX+AZX/H5WnjBoCM=; b=JgGHl1ZZrv52LzZYQ31L1gKwQT
	vmOI3KjokTNrM3cV7DP1cNEHoZmiPRJCcBlnyYJDKzGhK5z+SHOc6yApV7UsVMRPLNriYl0D9lRIZ
	Juxy3Ap1p1JYumcegDDJp6KQ5iJ45fRjP9Kr9qDXvbLskCXD1OljD0BFdqktlR8S5JTXTawz+fk04
	g8jCP+ge9cGt2sL/EfUOb1H0cJsque1tT89ozFzz31MCtAhUglbew1BMEy/rZ6uduW8CKgYvsuPf/
	0SjQnNPUTicxyjdu0RdgHpTitYHFIJ/wqKXC6L6DmOFGnlvoYSW4mn0rbsnV7+TanczuYa4sLAubt
	YrcTvRaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYYJ4-008XBE-8j; Wed, 14 Sep 2022 19:44:22 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYYJ1-008X7v-Et
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 19:44:20 +0000
Received: by mail-qt1-x82f.google.com with SMTP id g12so11633003qts.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=nAY+ae4YYDmrPwboA5knbssvQe7BX+AZX/H5WnjBoCM=;
        b=RIAYJT9epDNn3TDGW/PQCUrcsgT0Zmhe/JgPbW22vTl7CZ1iVfondTH4rDpbG4I0Jf
         /IY9w7f0i5D4cF+iSXMf22hByZ/FN3GZq4keV76NBXeoKEYfT7tpN3I1cTHKB2PEuQ48
         wT7ep2VZgwCSnih3KETbGwSyYoYrJ94JcGNcuq0jhotCUNp8JNR6vqGZsQM4uCIixN+0
         9hs9uBxGLR0EI3QA6y/lk0nvzX/DR66QD2thLPahhQvHzUnSbTuIshD0fGj3S0LWEBZd
         W/xceFVqtmll5Bnon0caBmAdZQlCc+LL32SLTWQNDTvbv4QNwikVHnh+l8EB1UmLo7nv
         BqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=nAY+ae4YYDmrPwboA5knbssvQe7BX+AZX/H5WnjBoCM=;
        b=KCe+rwOePirWxtXgzzRXZsEx156Z1LWVbHgr2qoEW7rPtf+Y87vHRHYZats8ASj7WD
         gVkwmpWleJX5Sbwy/Ol6UgPE8NV5uG0FLce2h6EDHzJVCzmmQpOteGzzK4ZDesWsSi3U
         TfMxK8xJsiVsFVmF1Gs15jqUWWChKBOmd1VWCFmgxmbINJA2Ra5gMP2izRGIiHJ9/Eqv
         dAm36/bGMJrrnvv2HiOS3MUYxK1jLN0/5lYnFuVefhCLA0YXpy49qkHPclVpOHq/na9K
         ES0Wa2uDBrk6hE6kKBnzdX+EC8FJg9OhYwch153NsTdE2ZvPyQDAWOOFZpyIJ5178EaJ
         kNew==
X-Gm-Message-State: ACgBeo29/02/GmdFsh5Cyk7Ycu4ZLMQ5Q/AaP2BNx4WkAdhQeWz7RQ5l
	UcyLZ6u3mbFlL7RAJWZN/XStVahbfMAybPTXBwf8cV5MnJZndw==
X-Google-Smtp-Source: AA6agR7GwhR44VXa85JQ9TO9zmcgDGRWtDmI//m6oqSVLtHVcljPp+LuBUcF9fz1R/KSzP5sm8AyylvDXf0+H2YL6s8=
X-Received: by 2002:a05:622a:144c:b0:35c:c05d:2889 with SMTP id
 v12-20020a05622a144c00b0035cc05d2889mr525868qtx.610.1663184655878; Wed, 14
 Sep 2022 12:44:15 -0700 (PDT)
MIME-Version: 1.0
From: Nick Neumann <nick@pcpartpicker.com>
Date: Wed, 14 Sep 2022 14:44:03 -0500
Message-ID: <CADqNVTpcFuPh8w3Gcx2ftYh_4EjObxpenA2Ps2y=055W0o13=A@mail.gmail.com>
Subject: smartctl "kills" specific drives on kernel 5.13 but works fine on
 5.15 - why?
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_124419_544289_62170ED8 
X-CRM114-Status: GOOD (  12.63  )
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

I'm running ubuntu 20.04 LTS with HWE, which reports kernel 5.13.0-51
generic . Both a crucial P5 1TB and Crucial P5 2TB behave rather
poorly. With one drive installed, running

sudo smartctl -x /dev/nvme0

will output some info, then hang for a while, and then print
"NVME_IOCTL_ADMIN_CMD: Interrupted system call"

From that point on, the drives are gone from the system until I cut
and restore power (reboot is not enough).

Running smartctl against the drives works fine in windows and in
Ubuntu 22.04 LTS, which reports kernel 5.15.0-43

I thought for sure I'd find that a quirk for the drives had been added
between kernels 5.13 and 5.15, but alas, I don't see one. The PCI
Vendor/Device ID is 1344:5405 for the 1TB model, and while the crucial
P2 has a quirk in drivers/nvme/host/pci.c, it has a different vendor
ID altogether (c0a9).

Any thoughts on where I can look or what I might compare to try to
figure out what changed to get the Crucial P5 drives behaving? I was
hoping there was some setting I could tweak to get them going without
having to move to 22.04 LTS. (I've tried
"nvme_core.default_ps_max_latency_us=0" and various values for
"pci_aspm" with no luck.)

Thanks,
Nick


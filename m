Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822E2C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Nov 2022 05:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jzHmpuPDoHJMDQu9tI9BfcY4PB9e+vTa64/6n5VuLQI=; b=4yOsddRyuhq9g4t2WuKsy7ZUkW
	n61DXhAr6PFa2EET1jjTK8M8ewNjbx6nH0fYgwuptiBZFHebRrxCnjKcQdYUjQpCKFBoqvt/DBL/J
	xaCzVXhHe6IRgRBa7bZZn4zTJq8D2m+yPlQEUhy8PPx8Uhs77CeBu7is7fgLRcEalUCBkI6k21ivB
	LLo1Xbz8SidRCdFUQ1hyo2c9ubAINHdw+IbOKGAkNFJTajud8C0NRjxn/8uNzjVbbKnXY+0elFRV6
	LLdNUwJMHNiH7GwbQt55SrCmZM1NamGwDMlBB/0DWc51NgXNegG//p/fq4ANqc6N8VZSPmuSWfRHB
	u0tZ8SEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owcfF-002CHy-Gt; Sun, 20 Nov 2022 05:14:45 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owcfA-002CHg-Fh
	for linux-nvme@lists.infradead.org; Sun, 20 Nov 2022 05:14:41 +0000
Received: by mail-pj1-x1036.google.com with SMTP id k5so7820869pjo.5
        for <linux-nvme@lists.infradead.org>; Sat, 19 Nov 2022 21:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jzHmpuPDoHJMDQu9tI9BfcY4PB9e+vTa64/6n5VuLQI=;
        b=aZz5yi/iQu1clft84RFQMZZmQywHI0Y5jY1iiMtsLDMkRgNIbkpNt4XKOURhXHj/FJ
         iKQLvZjuSAotGOYjtLsS4lCj0VMegrv3OO9pIJiVlV1RRLHto9T6f+Zq2ChkVmwWLBRE
         0Hj9+b2UGD7X31D7Ml68j5Q3EFn/3oGU/ODLtVxC+qoFHQpfY4Q802NyTAFmJSF2I2S9
         5VMb1jvu2sZ75bE89N507b446iytVvYbIZ7LfwusfdIdEgpFajhlZaExjPqjAHr/DVfe
         UYu26HmCvi7ySUl6EbLBnT9QQ6Gcbm147eKzNJoBvBET+rFn/NT5E7uABKIyP0Diclpq
         ZEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzHmpuPDoHJMDQu9tI9BfcY4PB9e+vTa64/6n5VuLQI=;
        b=ryD7XfjD7Mh/OBJwbJL0elSTjWrrre1IDujThR82P3wOonupwDMlFQhXQU8hY8Vgln
         VZ/gM0iP36QPyjjy9UCHsLLIVt7Q10F1rbeGgFC5I5xB9ORwBv5U1N9iK5A0rT2Vlkng
         HNUN7EDIakum3HqvbnHpNfs/TMlj+IpW/bVlJLG+mPUG1hCJCr7DFyKbGN0tzQLx2/0B
         XsfHcdAAsHySjXVAodFELZiNgXEV9of3yXTBJYxFxnCcLoC+N154VvOGMSOgh7iLeonM
         dhF3r4FBebYy6iM9yB6qNYjezpAgv/OlS24HMFmJw8PK0r5OJiQxjylgsfZo3cISGVAp
         lAjA==
X-Gm-Message-State: ANoB5pmKco/Mv0+BcTt2/YXXbqtgpGPpFCEb8CIpK/o/ALlSDRhya482
	Lu2Yp8u5Sy3xECRFlYOoKD1/J/BeudvYsSb3kMJ8TTlbeNo=
X-Google-Smtp-Source: AA0mqf6BCZvMnFVc9jHe8AquuFLrNoXEISlqOV1CY3fNzVG9BVCqWudF1Lo4uGII/CrfJSDtamROKCr/Odu9Vl+RfKg=
X-Received: by 2002:a17:903:3256:b0:188:5240:5142 with SMTP id
 ji22-20020a170903325600b0018852405142mr95605plb.171.1668921276476; Sat, 19
 Nov 2022 21:14:36 -0800 (PST)
MIME-Version: 1.0
From: P BS <pbs3141@googlemail.com>
Date: Sun, 20 Nov 2022 14:14:25 +0900
Message-ID: <CAKkq1L9hQ6qYpnnT+Ve-E_Qw1SnWhAKCY7Gioxf71PFQJAVj1A@mail.gmail.com>
Subject: KIOXIA KBG40ZNV256G stuck after resume
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221119_211440_582378_2A1FD17B 
X-CRM114-Status: UNSURE (   6.98  )
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

Hi,

About a year ago, I filed this bug

    https://bugzilla.kernel.org/show_bug.cgi?id=214983
    KIOXIA KBG40ZNV256G NVME SSD killed by resume from s2idle

about an SSD that wouldn't wake up after suspend. While the bug is
still open, I'd managed to work around it up to now by setting
iommu=soft. But somewhere between 5.18.16 and 5.19.1, that workaround
broke. So following Keith Busch's suggestion in that bug report, I'm
taking the issue here. I'm hoping that given the narrow range of
commits, somebody will be able to identify the commit that likely
caused the regression. Otherwise, I'll bisect it and report the
results here.

Philip


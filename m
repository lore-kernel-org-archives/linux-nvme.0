Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFBC001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WyzMdIIymW/6Z0nnVSNvD7p0pdlAEYGfFstKND3Wt9Q=; b=L0ltYg9QL1f3T4AqSAe0C+hAhL
	qTEZYs+oyaMifZYCMzUlKn/I7GNvv7XCg7iP/WWoD0vBaxFduEcFcztusB/kpJ5WHmmj/ljRcBg7p
	wklhXY2oCM3F6B1jRGytR1B3cKS+ySU4eUYaf2MeRDUtELKVDT7/CDshu1SgvWRN+9uoLWjmAYaPa
	TWzU5pHA75gVF/Qt6xmxGtOSK+DNmQWkEVkziEq+KL1JrU1oze71MVO2QDnu022MZ1xegfgGX5BV/
	5mAQKE20pvFkxsDn0WbBBpqlc/x83MH6i72TS2rJ8NBnC00+WNgKpIzvweG+coQoxQfTn4V3ofuCn
	JwQoHPPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQQVk-00FA7o-1m;
	Mon, 31 Jul 2023 10:52:24 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQQVi-00FA6e-2O
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 10:52:23 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so917133766b.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690800738; x=1691405538;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WyzMdIIymW/6Z0nnVSNvD7p0pdlAEYGfFstKND3Wt9Q=;
        b=bOOywGtTBRFFY4anR8RhweoVbXh8ikC/EhW5cfJMY3NFDRVK7BfeP5dJ7jiN5K/5m3
         w/0E803fwZgQy0xthHoW2pEPUjU+9h0nz/K1BpDuU46l78VvoL7hnzKWG3u1YJBTuW/V
         cCM5kcvaj63o9ArnvQWRmwyIepKRur0o+OV3i2ukFEMSqcC9HBKNIgabm2Mvgw9BZqBp
         vWEIoJbcAblMRzn3BMAfLKVgpzHlYXYJ1ktfafNkSDWXw/l8TtFx2x5oDP5YIGfcyS7B
         BfLikxdI4x6Jn16wREqq5D8I7kdVdNn0ldg51fiVVDFxKuyHaauUtUl9Pw4lIldmIS1W
         Oo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800738; x=1691405538;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyzMdIIymW/6Z0nnVSNvD7p0pdlAEYGfFstKND3Wt9Q=;
        b=i0KFi538xRVqc00TKBqqGAet2Ko1QKpxqLPJr/yhD25e3SZPh+4teccr7WguOIhAoT
         BESe6ahqo1VG00d4Q8lg2gLveB1LBwHh/cqS7csBLKZHvIbwKDJmDxwV5eQCgjfQYkcD
         H3V5BL+efno4RMaGA5l567+dedvb/WBqPQiLvvDKxbTB190x97Za4pJoxRhVj84tqV+C
         OswuWY5uGD6LltKTBlsCERL8sxA/jsy5CMe5YCYKeh2476TU9yyU3IdgvUtCZr5isPT/
         fTffoTlB0CH6cwYW7lH/RR2Y6mqh1vSdthyNv+IdLJzet8Hci1XzdCPqoYtqJUtQyPSd
         RyZg==
X-Gm-Message-State: ABy/qLb36QrN9whrFAUO0mAHHQPhWtKsWqbG3ldYz/O9gzgNW1HHhWZa
	8ATb5L7i24B86xe4ZdiQGecgQerNpL94IxboOYM=
X-Google-Smtp-Source: APBJJlHdlQ4xwI3zGrAhyqtA/GK3cGGo2F6IgrdOeSv368cGiqu2oCZ7h2NJxqv5jwzWjAVEyQpg++TI2XmTYkuOP1w=
X-Received: by 2002:a17:906:9b94:b0:991:f0dc:c930 with SMTP id
 dd20-20020a1709069b9400b00991f0dcc930mr6652609ejc.16.1690800737540; Mon, 31
 Jul 2023 03:52:17 -0700 (PDT)
MIME-Version: 1.0
From: irvin cote <irvincoteg@gmail.com>
Date: Mon, 31 Jul 2023 12:52:06 +0200
Message-ID: <CALL+9egphcj9_tD+jw5jUZTftjQzXAxeEk26s0rQQDDBK=hRPg@mail.gmail.com>
Subject: Not possible to have PI at the end of metadata
To: hch@lst.de, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_035222_776587_553650D5 
X-CRM114-Status: GOOD (  11.98  )
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

Hi all, I am not sure of the exact procedure/format for this type of
submission,
but I have noticed something about the code for which I had no patch but that
seemed to be at odds with the spec.
Basically if the user has formatted the namespace with a format for which
metadata size > PI size and has set the PIL bit to 0, then in nvme_init_ms
ns->pi_type is set to 0 (effectively disabling PI).
Is there a particular reason why the driver should disable PI in this
situation?
Additionally, in the description of the PIL bit in the NVME NVM
Command Set spec, it is said
that PIL shall be cleared to 0 for implementations compliant with
version 1.0 or later.
I don't really know if this is intended for the user or for the
developer and how it impacts
the above.
Thank you for your time
Cheers
Irvin Cote.


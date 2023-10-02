Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4EBE784AD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Oct 2023 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HHv4X97F01xaj4byhBbsnyCvj5nIODpqidbx4VymW28=; b=tCCmvcIAROzhQmMe6qtg07EmW8
	xsICONHqhS+4h98Jphrsw65NDvOeLdDBZmQDbPQvkbNrBCOBLWj1Rrx31VUS5+17fBXMHRc4Xisdy
	fIDLNVJK3QDpYuWOPp5FiU+h9PK2JJDA+cO0zV6dww5ZGvBctJRb/kAjLBDzmBY6cgeZrX57eEtp1
	zxyMonrdw9X0V3ritpeGblFfEvH+bIlGnXno7HDuMQG14z28ZQP3/pFLAi8DoB+s+P8Rn/kv4Qyu/
	n68qo7LGTpL4Xnio+Dch6D8vVGCAucRoF5Gu8N/i6Y3f4+KIf51qPE5qO7qy2+ooAczoc//9SpXo0
	Y4Ujn2PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnHxD-00ChgA-0T;
	Mon, 02 Oct 2023 12:23:15 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnHxA-00ChfO-0R
	for linux-nvme@lists.infradead.org;
	Mon, 02 Oct 2023 12:23:13 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3232be274a0so1793752f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1696249390; x=1696854190; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HHv4X97F01xaj4byhBbsnyCvj5nIODpqidbx4VymW28=;
        b=US7m1vGUWzdXQwWcmCTpiNdpIxFsjPm8xmt1DFC0U5sBwGaVBwWmMgbqXJ6GcSQvjy
         JKUURwR4qkO89LLebpEk0K+uEQU5Lq7Y4U6Wg6sM3t8C6Lnz/Sx7+09kcSEtMC/2tfMT
         jfr0QtX6t2QDNEzA5w4NasjsAxqfB9Y38/tIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249390; x=1696854190;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHv4X97F01xaj4byhBbsnyCvj5nIODpqidbx4VymW28=;
        b=fuZWFyNjYZNBQ/KVVFRpHrulPIvEv9Xj1sw6tGxu4eNdw1DM/X+tkvYacdUygA/i31
         OL4QzGWAYpWNP5vhZIqobH7WntrnHY857B+WteWR2XofWfmN+ph78yHoYPC2xbUA3ihL
         sEiMoTU2vam7kYUHHUNP4pZrZlmslkq0p21sgxVxW9uiq38Lo7yG4P0SqVYNkm1bywLn
         ueQ/oAzj8NQ7709gA/V22r9zo/cICW6JWX1aWLf3+yuIkG38B36YLAdvZNuQpJfZrfuG
         NmIlUNTvHMgFjnMYSupk7GiU6zZx9O7hWteN8EYG7YvWxJNI9fd9RmqLuywwg13sqtlz
         r5yg==
X-Gm-Message-State: AOJu0Yy7DZSb+5YcrtpTClIK0Kirq7NHgQMbyY/KqEireBPv24D8xT94
	xgWAFdkv04P2RJ8EnydBgJyhHjgi2WokVGKupqCUxMgeUhHdIPS1++c=
X-Google-Smtp-Source: AGHT+IEj6rEqe4lsmCArvIXZjUyUW6OybpW/ASF5sgeviWTsSB7q6t712eJuxzBbXjJYGrM0mhBhnoPjlODDJy5oCPY=
X-Received: by 2002:a5d:604c:0:b0:317:dadc:4a63 with SMTP id
 j12-20020a5d604c000000b00317dadc4a63mr9886425wrt.8.1696249390219; Mon, 02 Oct
 2023 05:23:10 -0700 (PDT)
MIME-Version: 1.0
From: Mark Syms <mark.syms@cloud.com>
Date: Mon, 2 Oct 2023 13:22:59 +0100
Message-ID: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
Subject: NVMe fabric multipathing
To: linux-nvme@lists.infradead.org
Cc: Ross Lagerwall <ross.lagerwall@cloud.com>, Andrew Cooper <andrew.cooper@cloud.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_052312_192246_F36D16BF 
X-CRM114-Status: UNSURE (   7.14  )
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

We have a requirement to report information about the status of NVMe
multipath controllers on an NVMe over fabrics deployment. In
particular the total number of "known" paths and the number of
"currently active" paths. As far as we can see right now, when a path
to an NVMe target device, when using Fibre Channel, is blocked, all
local information about the affected controller is flushed leaving
just the currently active controller(s) present.

Is this the intentional outcome or are we missing something? We can of
course keep an external record of the paths (controllers) that have
been seen but it's a level of complexity that would preferably be
avoided unless absolutely necessary.

Any suggestions would be gratefully received.

Thanks,

Mark.


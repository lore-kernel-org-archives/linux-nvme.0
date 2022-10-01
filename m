Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B040AC433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Oct 2022 00:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fYLStWIJy+Jlv7mm6BrR195c33v9G8mJsNoTuzBumio=; b=jY3lunB6xDx3Lx7BmEApG+nc0H
	Z5WkjouBXUiljyjNU+KQBIHn1m59HwyJMVr2dUF8VaDLI5PUEKv+I7husmshXdelvTfnCH9LzK/tI
	PKK61cMvFhL4jkowIUlnfwmz/uyUi4QtJGpdMZ+241f2K/9eU/Z1YYR7NrcEhnsF89cUkhXdZ2uH7
	d9h2S91cWFXFJWsmWg9Qsj0hWJKH5l+7ktJz2yNnBjftrL0HJPNaoTXtHgkkWotET7qbiFjSAr4Xc
	S2i9i+LE+jSrG0+4HLhkELQ2YsN7c3oToAyl8tXZoNzXHshJrNOenkq1zfv61hJ8PaRdiPhvVGy2p
	vgrhO13w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeQc5-00CL01-9o; Sat, 01 Oct 2022 00:44:17 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeQc2-00CKyf-QD
	for linux-nvme@lists.infradead.org; Sat, 01 Oct 2022 00:44:16 +0000
Received: by mail-lf1-x133.google.com with SMTP id u26so581695lfk.8
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=fYLStWIJy+Jlv7mm6BrR195c33v9G8mJsNoTuzBumio=;
        b=QJC88LXvPJjdFg/j6qcjo6OJNjdtS2nnz2Nnu2LmyG6uYWw51Q0khWs8TAt5Zx0gpc
         fnQccKHU3ckEeQB42OSs4L1dGpvRgsyyjW0eoQ0n5KxEKHA665TQ7iDaH/yqx+DXJHOB
         f1ELKC8aUhH+Q17ghrNXDCdIkQ6ykNRbWqkihevhXrInV4eyC4LNY+dZqsssoJO+tmNv
         DGGRzR89lPkeXjzF4lvG9URiyMKRT4AGtWmv+/SOnnRNzkrm0/2J4BULgST/i/FrC3lN
         JdJkF6Cz5maDdlPwx88oTlelzjbI96jlEWS7gF5k4sZxEnC6U29mlqcpb5FcXF73yoHf
         3O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=fYLStWIJy+Jlv7mm6BrR195c33v9G8mJsNoTuzBumio=;
        b=Si1qt7htPYCuupefkVjLCTjl/NfGYDJc2aPPg4H9vSGBd55ZVCcP1wdViAyi9bHB5P
         R4GVVb41iMHZwvVhr6OwGkcJuB60hWPRW5RosS6k6+hG2zdeZcb5yMwOAfUXl9wSgyEs
         bSwkpSVUikkFktMFhv5RLHNRqw8IzWvRoK/jS6uQdT9GiSGkJkYAcndj3n8OejrjxHKs
         VGwHEMdT1trLbDvlbC718Zmwt8DQfLncvrT3f9QHiU5Q63p33WYgiIgI6pOvnTpsdj2G
         yjOInySIz1mc9LJqLTQsSElU1evED/sxTWxtUo+qRK3BXFil/P4OSK6jIWdYdoGF1cpK
         CftQ==
X-Gm-Message-State: ACrzQf1lxSpgTOnM7pumAjwgK4oSNVNXds9BSSybK3P9b0fB7mkekO9I
	MmfW5sQzt3zCa+r2LRDOGBCZIpLB8mq9C3S5ljTwz3+gmwEsnfsu
X-Google-Smtp-Source: AMsMyM4p9x7tBS0Y3WpUAV6I0522VTzPJl5VNtWYcjYHgFF8OmgkzXosTYQ6XQmJOEDKtGfUdF6c3wMsQvOP+5Xo5FU=
X-Received: by 2002:a05:6512:e8f:b0:4a2:e29:75ae with SMTP id
 bi15-20020a0565120e8f00b004a20e2975aemr2808259lfb.308.1664585049554; Fri, 30
 Sep 2022 17:44:09 -0700 (PDT)
MIME-Version: 1.0
From: Nick Neumann <nick@pcpartpicker.com>
Date: Fri, 30 Sep 2022 19:43:57 -0500
Message-ID: <CADqNVTrNZRGgjmZ5NNaMvp1nhbnRHA-KUO+H8VxTmdhU6iX8rw@mail.gmail.com>
Subject: NVMe SMART Log critical warning during benchmark - is it really critical?
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_174414_883229_04710C2C 
X-CRM114-Status: UNSURE (   8.80  )
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

I was running fio to fill an NVMe SSD with a sequential write. During
this, the drive gets hot, eventually climbing to 84C or higher.

The drive lists 84C for Warning Comp. Temp. Threshold, and 88C for
Critical Comp. Temp. Threshold.

When it hits 84C, it returns Critical Warning 0x02 if I query its
SMART log page. The NVMe docs say "when this is enabled the drive has
a problem". But the docs also say that Critical Warning is set when
"exceeding the temperature threshold and/or throttling".

These two things in the NVMe docs seem contradictory. Throttling
happens, especially with some higher end consumer drives under
sustained load, It seems odd to consider the drive having "a problem"
when something that happens under unremarkable but heavy use happens.

If using Critical Warning like this is appropriate, it feels out of
place to have it bundled in with the other reasons for Critical
Warning. Those reasons are degraded/read only mode due to media
errors, and hardware failure

I've had other drives run the same fio test and thermal throttle, and
*not* set Critical Warning. I'd expect Critical Warning for
temperature only if a drive got so hot that data loss could occur, and
would expect thermal throttling to happen first.

Any insight on this? How Critical is Critical Warning 0x02? Thanks in advance.


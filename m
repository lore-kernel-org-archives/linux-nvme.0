Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2B0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kaolm6Os/3cYJKaDSzust5MRbo5ubRIlvfUTbhge3kg=; b=zdmvBSy/ly2Q8yS+aEqmgLqR7o
	4SgqeelCNGtr+yHbcW6L/3HCGgodvMkDkpzZ5o1xImv9kiEgycsrZrfPQBTuoqX/Bm9Z5nTS9yCfj
	qGqipYtKcjv8OCW5axPWrx9CbHgypqZi+aMXVAXGfKSM29rp7OVXQomPI5mZYL8BQ6aSi6+5E73gJ
	3xphSCLQ0ka2J8uDcuv+bDglHT2s5ppYCOMfZqMWd5Wk5XQTghE/mhCde+MAHzihIJKKaLXw2fpTV
	23Phq7uosKtgo2UHQGH0ctrIDeD8p7rkVeePAtPcKYdwkl9NNiO8oDxT1+lmR1OaeuXOtxG8am/oP
	LoNbrKzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5Ba8-00Feav-CQ; Wed, 05 Jan 2022 19:04:20 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5BZw-00FeWn-7P
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 19:04:09 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id m19so614704ybf.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 Jan 2022 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=kaolm6Os/3cYJKaDSzust5MRbo5ubRIlvfUTbhge3kg=;
 b=QDsyV8xe/VbhCDxlW9KyisMfv5fmsoaPCXKtpCrr5wV5W4nDoxPnhMmLkl7DAKldPA
 dO0R4NS3nvZe2qiByjZplEoJr2WgAf1bYDDYXIs55jlcbHkbTqwyri79NAoYgxB6+VBe
 TJI5PZCdItpC8oZiQWZgl2XW5LZm5+I5+zsaPIn86//uQhiqLLHpoX169NGoid9Hk+Dv
 LWQKM93zxZoj0RGqo/Uj4EWpXX+sJDftKxY/NfYXOBtufG80dOpfMk1H5jSedfhD7n1g
 bayb/KjRDI/HrUgqjNg3x86mi6a1Qe+R2TzgFr7KwzYdKKIwN65ckoZ45wHq90VVMMkZ
 /c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=kaolm6Os/3cYJKaDSzust5MRbo5ubRIlvfUTbhge3kg=;
 b=IlfuoZqcXdg3y7xN+5Rjl04iWLj8FgJdeJmzYnnhFjEQJPeDeQS+cM8b1LaIHlYR7S
 H3XtJs2qohltpMO/5nbJNG0bjDxk/kqo2SL0q+dLYcO0oOPWx3JCicx5J0S8LikWvASY
 lEczy1UqmbMOaonlkGbhtkM8q7UuWPm4ozCZzt6SriiPmtJpevowu85tOWDdj2/f/Uao
 ++e1KHt74sSm7dZDOGC9JtwAuuKmt2bvyOa/qRN+9PAWe52hqwpiB1qFUloa7mg+SWwV
 jV7q73Ssizjf6LupYKaMD7Lua6msFSSwHc9xR3Xpd1r4uIVFI2iBw/8clRQEsVAPZ9WY
 Y6og==
X-Gm-Message-State: AOAM531K6tMj6bwRDUlVY94RnY/mRvgjST0A83Mo3p7WG2qNcpMO3lyg
 TO55RpxcvSObev2SxuM2MRSiDkuShejasnhIIo8gRANLydRNSA==
X-Google-Smtp-Source: ABdhPJxJ9/gsZBqtFOn08omdViGYrXM7mna2Meqvq77Tz1Hq52lhdqfW+sVMHzcx9ufEQ+BMTEt4ZBCKN9syWi/M2HA=
X-Received: by 2002:a25:a245:: with SMTP id b63mr32502719ybi.325.1641409446539; 
 Wed, 05 Jan 2022 11:04:06 -0800 (PST)
MIME-Version: 1.0
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Wed, 5 Jan 2022 14:03:31 -0500
Message-ID: <CAHex0crxy=3c-OouRWLXhvBMZjhgDsg-7wcyGrPE0R8ymPTEYg@mail.gmail.com>
Subject: nvme-tcp: io queue shutdown ordering
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_110408_292953_42936A02 
X-CRM114-Status: UNSURE (   7.00  )
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

When disconnecting an nvme-tcp device using nvme cli (i.e., nvme
disconnect), nvme_tcp_teardown_ctrl() destroys I/O queues before
issuing the shutdown notification on the admin queue.

According to the fabrics spec version 1.1a section 1.5.2, an
association is terminated if an NVMe Transport connection is lost
between the host and controller for any I/O Queue when the host or
controller does not support individual I/O Queue deletion.

The initiator in mainline does not advertise support for I/O queue
deletion in the fabrics connect attributes (i.e., bit 3). Therefore,
termination of the association in response to connection loss of an
I/O queue should terminate the admin queue connection. This could
result in an inability to process the shutdown notification, causing a
disconnect request to hang until a timeout occurs.

Is this possibly a bug or my misunderstanding of the spec?

Thanks,
-Jonathan


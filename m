Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7E4C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VmKQGNO17JlT5XX3kTPlf+6BMGl0Zp1Spd/vSsRvH2Q=; b=KITj9v0/eHdzeTRo1pjeEi+ZxK
	+tU7S+Sy+Li4muhKVUc3uJL3dqQiZKI9Osrh30OinZOuZo8U9Kga0P7DQ16hieDohLKo/INnQ7DR1
	KxcXNBlWTFXbCi7i1C/guvEtkQOKGG1LJBEWgHHUSFWPGP8LzrEm9RRYPOpGnTNOHtvnuUAs/R0hl
	8RJBqX+54Ed8lCr8Z/Q3ItROOSGPhMh+44KZ4C0SHXCKXNieVAemI80zhAxwZto5VlhSADuHm9MvG
	0k5xCHdNTsQ7MAXVqQ41B4N5OPxc2Oy4lhijrHaDec8FopbqOl/1Q5nszxi590zaMS/NsuRAi2c3w
	RBjKw3Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GAW-00000005PK1-3IF0;
	Tue, 08 Apr 2025 21:07:40 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GAU-00000005PJG-15BX
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 21:07:39 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so57289725e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 08 Apr 2025 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744146456; x=1744751256; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmKQGNO17JlT5XX3kTPlf+6BMGl0Zp1Spd/vSsRvH2Q=;
        b=dPN7shYtbUjjrTHyBZqhir3u0fYs0nHVzLRen6T5mf+iQHgBiqlQANHcX75VrTRgto
         tEfYnCgbmn8MAyqkSCpi4kT4xod9TiYr8DPLOZRhRXJUVRG20hFTdpojZCOTFZWshiQH
         YR6Fo4hhC0WaPrfwY7XX/oiYZ3i+sEhM/3b2nuTBHzfVYca4Bvp9Ydz/XGkMxRp++zkU
         BZa4cKxB33S+jA4CxsSikoH3VHWheNv4lvIvCHjndfq6gqTV0lbUXaCm4VAXY84SGxT7
         2XScb41vDol6lID0xZmVcHuhh5khDViLS6VmtOc1GAerSlLS3242AmaDNZ1XLKH94pfv
         oLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744146456; x=1744751256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmKQGNO17JlT5XX3kTPlf+6BMGl0Zp1Spd/vSsRvH2Q=;
        b=OPQX1T7sjOUW6pEZQv6120c4QE5vAzeZzPF+yXJKKwQ8E5aJ+UywWlYBTLK3duhVea
         kujPSiqiiZ2r+Oc/w0dpEum3G4W/Gt+GdxT8oah7oU2IlrHyDZ078I8SVhEAehim/mdA
         DKRGLdAoWOfrhQiXf16fW3GjJw1kXqMan/Ed8RfOlY641CeBJDRy1Wvr9XSDXQC0AUyD
         5mXi+SgQv7cisERrvpDYZSkVh7kkeb5VItO8tqpdA5yc/AvnyqW9CjRA1s0ok2UJaUNA
         SgbRjuCl1ttOvXy+53SBlxqJySygWDU6cawNI16ZIQkRDpSibilk4XRz6eahKpC2URiZ
         /cQw==
X-Forwarded-Encrypted: i=1; AJvYcCUre/BPoVNLSLHmOpQy1zF7hi/Yd2W0S7p39Rl8FdDfHDBCRXLTQ1iLs00M6u/JhVCX/KEbFDHuQswk@lists.infradead.org
X-Gm-Message-State: AOJu0Yx334xZcLjCGaPt1WT1kqHYpdzKZlBPo9OHR6nWL/Sbzq9BAxO8
	CWEj3KVyzgRCMe9KBwkMdYRG7KiFcpqK0dR9oC6oB9ZKF89vzxact5RVjT0QWN1Ia5tokNVXR3p
	R3R06JIJqWJcRnX46CysYPUvOEE55POdoXWyYLg==
X-Gm-Gg: ASbGncuqg0niXG9zHdBc8qjy7DV4AHiRnVmroKlCdq26/SFDVa9rh5DBowDa0mO/FRR
	SfOJRmKNA9IJzfimXfmveEc/kFAR25eR+5zTZcpEjrIMZl7XQEGaHTeE1ZG365jBLzuhJg2MRxe
	KeqQW2ql1JpkVfz0p5PH3fuSussDw=
X-Google-Smtp-Source: AGHT+IFQbVv/s84Y+T1st8tT4/l6Pfqjnc7EF+pvFgIp4N2vKFFcQDYEDpKwqMKa9jDGgHo80JlGjfoxQ6bfGhLYVlc=
X-Received: by 2002:a05:600c:cc4:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43f1ed33369mr4294535e9.23.1744146456118; Tue, 08 Apr 2025
 14:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250405054848.3773471-1-mliang@purestorage.com>
In-Reply-To: <20250405054848.3773471-1-mliang@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 8 Apr 2025 14:07:24 -0700
X-Gm-Features: ATxdqUFFtjYbMoveKboHE089vHuNzkw5X7zdoXj_S3_G1loNm5Y_nWMwyRt_KL0
Message-ID: <CAPpK+O3_3KLxA6QuLSu7QbBwAt9jLBKmihbqQUYfmJwNzNGQ1g@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
To: Michael Liang <mliang@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Mohamed Khalfella <mkhalfella@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_140738_328984_78E5B647 
X-CRM114-Status: GOOD (  20.45  )
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

On Fri, Apr 4, 2025 at 10:49=E2=80=AFPM Michael Liang <mliang@purestorage.c=
om> wrote:
>
> This patch addresses a data corruption issue observed in nvme-tcp during
> testing.
>
> Issue description:
> In an NVMe native multipath setup, when an I/O timeout occurs, all inflig=
ht
> I/Os are canceled almost immediately after the kernel socket is shut down=
.
> These canceled I/Os are reported as host path errors, triggering a failov=
er
> that succeeds on a different path.
>
> However, at this point, the original I/O may still be outstanding in the
> host's network transmission path (e.g., the NIC=E2=80=99s TX queue). From=
 the
> user-space app's perspective, the buffer associated with the I/O is consi=
dered
> completed since they're acked on the different path and may be reused for=
 new
> I/O requests.
>
> Because nvme-tcp enables zero-copy by default in the transmission path,
> this can lead to corrupted data being sent to the original target, ultima=
tely
> causing data corruption.
>
> We can reproduce this data corruption by injecting delay on one path and
> triggering i/o timeout.
>
> To prevent this issue, this change ensures that all inflight transmission=
s are
> fully completed from host's perspective before returning from queue stop.
> This aligns with the behavior of queue stopping in other NVMe fabric tran=
sports.
>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Michael Liang <mliang@purestorage.com>

Through additional testing, we have recreated the corruption with this
patch.  We had a previous iteration of the patch that ran some time
without the corruption, and we convinced ourselves internally that a
portion of that version should not be needed.  So, unfortunately, it
looks like this patch is not sufficient to prevent the data
corruption.  We do believe the issue is still with the zero-copy and
too-quick retransmission (our tests showed that data that was only in
the buffer while userspace controlled the buffer was transmitted on
the wire), but we are still investigating.

Sincerely,
Randy Jennings


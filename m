Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A44EC77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=; b=WfBziYug4+HoQayJTvqLH4Q+yG
	RbaMKdmR7B2mMq24CNNs2gscyaD7Fs51wF/Z2kzj1N94Zix3vQ+mpAnRISqWd2+E9GiEbjbK4fk+/
	cZE5rYY2zXOFd8/c4LE2tPFVrAb5DUf0L5EwxW9cWzexa+N0mqVfoWR5dqum0yBMXSsg1jEhv+kVW
	Gmzuevd4E1aiIYOBFLapdy2ZpnweLDpuARAsqUT/GI6olZ9r5X2xKF8jpSdO8hHdxIMYOY5onM+oY
	IMTeV+/GkMzcK7XOzszr0KSzAO9Ykm8W53BGvpFK6i7tXYcS3K2tEaQxMitBuKjd2NWswEX3V9DJ6
	o0EUjQDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmXg3-002efH-0V;
	Wed, 12 Apr 2023 10:26:11 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmXg0-002eeO-1o
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 10:26:09 +0000
Received: by mail-vs1-xe29.google.com with SMTP id h7so864827vsk.8
        for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681295164; x=1683887164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=;
        b=DM3bChJapodBr2WHktIVXkF4wESvZSLuZZn2zwhzSHR/k6aeEsuyuFmPaLw5+pOEUH
         38OFPm/u+VF2r1UB6keKE0knkwIJ5ONc5nihQRbRBi4ys6eO9dD/BwWOhpwU1lnUAsoQ
         QWbjR57oIsH1xb7GH369h+6pXCS185B8PYydBy/JDB17T1tWZ9hNiiHN1LHHjEY6+0Hy
         0Q0+E9O5D0VcLEepEGChzSMZ6z/f/v+YVqLuO6Miuh3vJuk84aN1Hki0sQx6NJbLdCmQ
         Jrb3ja03hDHyBjgR4WXtGsDSxFNmfB6ohsQgcmFwlzfyCv/HuWB142U0UN9sAYewWI/8
         2Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681295164; x=1683887164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=;
        b=i/xxrpFqqbq95dgRU2mnV4OxWYbCaHSvW+JRxrDs6qjfwPG5XLXOlcCTNRLWKgjOXt
         qLXvH25kt9TQFO0tSMgZZPGtkO/196GRT1JYC+lLXfXjnFF4J9598zIYRXPuu5C6C7MG
         LkdZly/tLyE5zLcBLEqxfXiJnRVS39KXYCaAbdLHy3RNtkUA1UTpppdyHA7Z2luWft2T
         xcqD3BW7NX8EANSY8RmSeu3F/JfnofyeOjQPwWV2yiMVyMfQBbYVnmDefSXq+yCd5+Xj
         s6g8M+iHU5mv8rAbIyK5nh+YwkLxuEXI4H8ZqCN9/yXLCuOcgaiKwXsX1J+Q/0buhMfY
         1yqA==
X-Gm-Message-State: AAQBX9d0mIvxoG/nA3ouh13HPiIhYR7cX/K8Kc3OFna7BWtP/rg00+2p
	VXgLkE2IVgdTClp2lV12ZsMBifaqVEB1da+epH8S0Q==
X-Google-Smtp-Source: AKy350Y0FPXWa3mLhpuSfB2wOlCNyI4G0X8q0GPeu0ZGyUt76BO9Zf7I0z0F2H0jq5JCqvcQzrzp/+A3FO8XMIP0FFg=
X-Received: by 2002:a67:cc0f:0:b0:42c:74a1:424f with SMTP id
 q15-20020a67cc0f000000b0042c74a1424fmr3659466vsl.1.1681295164459; Wed, 12 Apr
 2023 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230407200551.12660-1-michael.christie@oracle.com> <20230412093617.285177-1-naresh.kamboju@linaro.org>
In-Reply-To: <20230412093617.285177-1-naresh.kamboju@linaro.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Apr 2023 15:55:53 +0530
Message-ID: <CA+G9fYv2nEBe=kJK4veunkvXD9GvqyaPFQ7rUbMD1S4+0nUS3Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Use block pr_ops in LIO
To: michael.christie@oracle.com
Cc: axboe@kernel.dk, bvanassche@acm.org, chaitanyak@nvidia.com, 
	dm-devel@redhat.com, hch@lst.de, james.bottomley@hansenpartnership.com, 
	kbusch@kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, snitzer@kernel.org, target-devel@vger.kernel.org, 
	vbabka@suse.cz, mgorman@techsingularity.net, halbuer@sra.uni-hannover.de, 
	keescook@chromium.org, akpm@linux-foundation.org, 
	kirill.shutemov@linux.intel.com, willy@infradead.org, mkoutny@suse.com, 
	roman.gushchin@linux.dev, ryan.roberts@arm.com, shy828301@gmail.com, 
	yuzhao@google.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_032608_606097_FCE523C0 
X-CRM114-Status: UNSURE (   8.56  )
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

On Wed, 12 Apr 2023 at 15:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> [sorry for the adding you in CC]
>
> While running LTP controllers test suite on this patch set applied on top of
> the next-20230406 and the following kernel panic noticed on qemu-i386.

Also noticed on qemu-x86_64.

Crash log link,
------------------
- https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171908/suite/log-parser-test/test/check-kernel-panic/log
- https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171908/suite/log-parser-test/tests/

lore link,
https://lore.kernel.org/linux-block/20230407200551.12660-1-michael.christie@oracle.com/


--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573B7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LyQ6Fx0ZnY45xGr5Y2jsnDq8ZWgzz0EhlHFyuG9haXs=; b=XQpNccDJVAtTu7PPjSdK0Dntvw
	PYc5crXVJZIQ8VumQVmLsLvVC190NYmvsLsCtAny3SNz//khApnjD6b564iETy7YshCvVo6Eb0gWi
	Nj/LUMI7ZKSFLrP/70t8Y9G9aWb//dVQBIFjB0SBXaTycvv7DJtPsBd8muJ6pFFuhFOtS6kFFwaoV
	wJMIaJn0b2E1U+DzEwL6CrFbY1oUoLqQpHvYrcNjSweKSeBvf2sSVZ/AsydS3lZ53Yuznhy4koogK
	subWPBWErVqFolENBZpmNuJdh6/ssLJz5/dZt0qfwRNXQtdWlpISoqSGIxnV1PGSv35iI+0cuZc3H
	UreCF3xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrJiF-002J2C-FC; Wed, 18 May 2022 13:27:39 +0000
Received: from mail-yb1-f182.google.com ([209.85.219.182])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrJiC-002J0o-Ea
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 13:27:37 +0000
Received: by mail-yb1-f182.google.com with SMTP id d137so3595643ybc.13
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LyQ6Fx0ZnY45xGr5Y2jsnDq8ZWgzz0EhlHFyuG9haXs=;
 b=PovVnjSpkm4BfsTGXiCkNQEWePtgX9tPf2SZ3sUyeZg6TPcTTKYUYQOXL48izLkml0
 vSo3pl9mORdwdXpBftqOqySM5vFoZWU8j/ogNXNZ/K0c0nwGwt8N4mRDXmOoY3/KdHO6
 G9z2JwWDeAkUYPlppDPSukv2vwsbk9vqdOSpCLJp354RRo0Idqi8uO8LGyQHDmaex23y
 xoU8lZ5oiwId/YzDNz4OLcVVdAI4ip/cvv8cygoXkEGa3XADKqAGNbPs3sup520er2LI
 oZknHFyoLCYcmAehGpnb0CVGF69IBiHYDHyTt+uptTcV19Eq4Pdr5+UjNMt5RbgWQhHJ
 tRcA==
X-Gm-Message-State: AOAM532/CHzpak6GU9VNqI1Nr8CB9WfOYguYo1CFBNNJrra4XQHV2bdS
 H5VGtYQ/p7iaji5luFntCETtPweZsiN6HW2NlXI=
X-Google-Smtp-Source: ABdhPJyjRx5gA7bKsO07czfdltoky1/Nf4DCcgRm0CA+ey3YCQSpZFTINNpWzDS3Y96jPW58VJCCVFx1k4Cf/+aYtDE=
X-Received: by 2002:a25:e7ce:0:b0:64d:6028:96b9 with SMTP id
 e197-20020a25e7ce000000b0064d602896b9mr19858608ybh.365.1652880452946; Wed, 18
 May 2022 06:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 May 2022 15:27:22 +0200
Message-ID: <CAJZ5v0hLtU=naptVYfp9ZmLeWzJREQ1icWJYrjh+a5LqOYG4Dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCI: Notify PCI drivers about powerdown during
 suspend
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 linux-nvme <linux-nvme@lists.infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, 
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, svarbanov@mm-sol.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Jens Axboe <axboe@fb.com>,
 quic_vbadigan@quicinc.com, 
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com, 
 Vidya Sagar <vidyas@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_062736_525234_801AADA6 
X-CRM114-Status: GOOD (  13.33  )
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

On Wed, May 18, 2022 at 3:19 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> This series adds support for notifying the PCI drivers like NVMe about the
> transition of PCI devices into powerdown mode during system suspend.

What kind of system suspend are you referring to?  Suspend-to-idle or
suspend-to-RAM?

For suspend-to-RAM this series should not be necessary at all, because
drivers cannot assume that the state of devices will be preserved
anyway in this case.

For suspend-to-idle, drivers can expect the preservation of the device
state, so perhaps the firmware should be prevented from powering them
off in the suspend-to-idle path instead.


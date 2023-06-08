Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBF1C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 08:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Z0zXMf0/p1bWmc9mPlzpLlXYRZkfsnJE7sT8NRRA6c=; b=4YSEVgHH47lSnkrN83mCJtUS44
	jq5caz1Z9Rh2DaXv4QD754PnwZyaoHHZnfpbS9MmuXShdJTztYgNIcr1hZ8sCzZ6Aa/oNydE4OqIc
	1vGe4cUvbyuG/5YeXPvSrHVtA0fYD8fnfM3xx4PPxWalDC9dkuUKCXjr03hFn+zZvPNfct/3cQAv1
	X6z93zvzqmV9lfo1LAh8JEPi0hyxlyLAUV+shsEis/t26ULXv8h51672DAsFP78iU0idIvy9/YBTb
	TgkWkDh8vAE/saWn03WEm37fnEXA0I/4OQ8fPXF+ZvOW4bX+uftf5JnAmU9IVLynl8vdzffMyXV3W
	cRgw7kQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7BIv-008ZvT-2T;
	Thu, 08 Jun 2023 08:47:37 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7BIs-008Zsi-2R
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jun 2023 08:47:35 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so1827115e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 08 Jun 2023 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686214050; x=1688806050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z0zXMf0/p1bWmc9mPlzpLlXYRZkfsnJE7sT8NRRA6c=;
        b=vkzOBIDyJZnE5t4Mj6KFwse5JLCGNYhVpD7M+LgRRAMweH7g5OH2v9GR8Kjk+mPpJm
         NFJNzRyEA3IyKuvp7ODnGHL2Af5KJgwvRhzjwf+IFMbbs3Ted974+vGTeleHQR5SKwGb
         b51DB4GATQSJy7/aa6dVBWvtN1fKh3j+MsQqSLaL0gg8C7sUjIaXCDmas7Q82iLoi2Fi
         ugG3zDp2J/kj+Q3TNNSScGVCX2fMCwjdIX6YCNNx4q8YsyhkIaQSOa714CgWEa7Wuf3g
         xuWNdIeV51MWblNgszX4dDTQTNus8HSvkBuoP0iMTSy1oAvOKlY2L1m7f7ZPLQvrDhY6
         hPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214050; x=1688806050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z0zXMf0/p1bWmc9mPlzpLlXYRZkfsnJE7sT8NRRA6c=;
        b=PleSUbTi2E0o71HzE90mnmgEQyZxmV/f+ufK7AV3gN/DLaxc/T94H7caYASQlNfJww
         Rp5LFFGX2L5zTSYh6YdZp4BOWp3F4t0QtE6s5zSJ8AUJsWvNK4dTfsN8/geiHtwnnI2H
         wTDfIaNPB/hzla8b6syrb52vaV77j3wO2t2mx/n8X33TSW35+C7aSK3es5GX6ef9su0t
         D26qZLdLnH0vVUodXKD8svZndlsRhYGPy7KLhpbPETRB6iPBRzFaH5bA63LmdissijgH
         BA5ZWmHweN0GFEDblbb/83kIW3LYAizmr2L6KnRcGUM2bWaLU7VwOrhyDtrLVA1s+q53
         5OaQ==
X-Gm-Message-State: AC+VfDyDqdUVY6BKyLxqUKjqlozt20nZLKZCXLWKPiTsMqKR7a1RNAGC
	TLwNf8nOaBplD+yM1OSl0QtUjw==
X-Google-Smtp-Source: ACHHUZ64php+m1QCHow4PROIWkYJdsxvPRvM75l2Ndr3HzBRHztMsSyV31x82/mpTwubbqm80EXyLg==
X-Received: by 2002:a05:600c:d6:b0:3f6:389:73b1 with SMTP id u22-20020a05600c00d600b003f6038973b1mr839950wmm.6.1686214049725;
        Thu, 08 Jun 2023 01:47:29 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bcbd3000000b003f73a101f88sm1253740wmi.16.2023.06.08.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:47:29 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:47:27 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <ZIGVn9E9ME26V0Gn@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
 <ZH+6qd1W75G49P7p@equinox>
 <20230608084129.GA14689@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608084129.GA14689@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_014734_818357_52248EF6 
X-CRM114-Status: GOOD (  14.74  )
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

On Thu, Jun 08, 2023 at 10:41:29AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 12:00:57AM +0100, Phillip Potter wrote:
> > Looks good, thanks.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Hmm, these signoffs don't really make sense here.  Were they intended
> as Reviewed-bys?
> 
Hi Christoph,

Yes indeed - I was under the impression it was appropriate for a
maintainer to signal their approval of a patch to maintained code using
a Signed-off-by tag due to their involvement in the submission process?
Apologies if I've got this wrong, happy to send Reviewed-bys by all
means.

Regards,
Phil


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD7606A31B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KRPbqDMf;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Y3Tgregc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tp3CD8lFBlbmXgKO0n7UELCHD4PM1w2C75qMVowhucM=; b=KRPbqDMfuLAx3gpWqwhwpM/nWX
	qgwJNcxtalP0Xkvj2ydN1neniyoOt8ak3y/iTafQGjbZgJ68ImtqAOFbpK1Mjp2o/dmV78zs3TSCL
	TOa8/kCz+hCYdVOqG2ogtg1w/mH0R0Brak8SVMkWfk03x7Cy2VcEARFhJlW0fKtDFh3MnEpuw5FrO
	AV4KWGePpRzkGj/I3tPVCjV31AtJ+bUVyNOgTmS5ohWKh0Q2IVL6q36pkuofMeuvr4QPOu2reGuDC
	txYYXH5w/ThZicS9CtIGdc6A2LrpTnoKyqhPYaO3cMxsuLJr14zhvUTmkEZdRK73D4By9moJzi8kH
	rMVQP4sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbDN-0000000CfWp-13nL;
	Wed, 21 Oct 2026 18:39:05 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbDK-0000000CfW7-2RXg
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:39:04 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-35c76e9614aso1894487eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792607942; x=1793212742; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tp3CD8lFBlbmXgKO0n7UELCHD4PM1w2C75qMVowhucM=;
        b=Y3TgregcdJut1emYFbrMytNuwKmHGqS5vKJY1pbzj1Tbwr2GaOKxiMryHY2r06REDD
         PvtIWyPH8245fcVSaJBwBtPZZ1d7mMTlsoHTBCTxyYoBlFwpwAsCDqsuoEY4/st2RPqR
         6KBNLYZOSneT4nPdzX158tIiafDqZpq3KODqin2kjWAWCnBh5rmrpU3bNh++iqcF52NG
         5d9FVWBh6d7HvdtPlIOcMRzxvUHVrvXkN7qzQ6sjdkZQffTxzJsOJRr/l+74WEAfRA9c
         rC5Cb3g7pCr8C6J7pYdXROYb/n+dTgcVsxHsM6i1gQIUxLmPv3xNZX/hRSQMeCoq6qM4
         DntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607942; x=1793212742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tp3CD8lFBlbmXgKO0n7UELCHD4PM1w2C75qMVowhucM=;
        b=RmdU27iREVoYm+KA729be4DxwG2XveGjuLKqdNpQZM803iqX0ia6B47VxTBMjeDK/n
         yVbX27Qs5f76x6hBmsIzNuWKMucix/5TAMn2w2KeZu7/7WDU1eJGDeCyNGr6fpzPE92x
         hGnUdwCvptIRmbx7j6+MCezA2Agt66F+8L5/tymVSF5Tb5NX16ruGP1Rb+5DIY3tQoZZ
         DrQNTZKmKZ+c4PT5HwAzBKGeOR/I1+QgJ5ACVmMlxBhpynXXGQ42pQQ6gdHxQRVcbYiv
         B4FgFRied5oFJ60o357G+XqSfjniEVHk9wlNMqOMTRU2l+FHbUOJyY3+q1EcJ/J3chAd
         CPyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtR7L4vgpSWUMPq1zNpDNs6ejww6kKgApMIzRN1etLrAmr7a1k716DXyUsG277PwgDXYlGW7lMxoBx@lists.infradead.org
X-Gm-Message-State: AFq9FYKXwvcr+JUBMuIVNMrZnYZmmFt2J+j5g2CRdsM4z9HduLyxDwSB
	Q4EeSyL63LqdGeb22Nd83hRbBaj7ShuP737crFvxjDcCL8fn9GaXuxuWS1NTTUWl5Os=
X-Gm-Gg: AYBFou3zv4jwWZYkQ5GAjWIDx7i8W0D/ErUUUTrVpnsfEcdx2T4QcFa2Lk7qYlAvf7j
	rBS2f5Eh+W309/cqQ8QJBpncR7XLEprMYKn7BvEsmqA7LxlQ31JVidNhZcq+k+RuWAx+JqRt4W+
	XPiOoF1MVVJpMD6PmsFhjqIf8Yr6TOpsCgSThJv+5YcDJkCsFh9oi7pRPN2fKu94zmeOoLwaaIj
	jjU/liDQRs6NGKaiBsWXARn0OH+wL7SrEAFMzQ+qiPnjefvi5SJXaNQ+2unbxsYyqkYDmkivR6V
	xJeUG3TtvdHoNtHBcaNRHg2kHpV0KA7a2JS9uU39oy5ioyT/56PnMAwHy3Cq+FDFYG5ZAnbI9fz
	JuzxIJ3PVnwn2AQrGfNrt36ikO6MceM/LYEUxE4sZc2GZAcINVUNFG5rJvUzlHbO0OIfumg+ZJC
	1DQV3YhkCnBijIvwOGnlGv8SioeRP3/8qUTDeI7KizgxxfoN2hwEFZ0beW8If9JC5ctrpROB9YA
	01zmJmUgV9jY4hogpGW72nHXDdsXCQyMyH9UcOybaSyyAfJ0kNkPH0VqSJrMruN4veMxKxDw468
X-Received: by 2002:a05:7022:6b81:b0:15a:4155:3d9d with SMTP id a92af1059eb24-190a6dc116fmr5008052c88.31.1792607941333;
        Wed, 21 Oct 2026 11:39:01 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1903bf5d61csm8302114c88.15.2026.10.21.11.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:39:00 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:38:59 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 02/18] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
Message-ID: <20261021183859.GY2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-3-mkhalfella@purestorage.com>
 <179241127352.3544975.2554197788837860779.b4-reply@b4>
 <20261019190106.GK2931-mkhalfella@purestorage.com>
 <a3852ed1-4b6d-44e7-b4de-bc1c6a3b635b@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3852ed1-4b6d-44e7-b4de-bc1c6a3b635b@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_113902_643167_EA7FB8E3 
X-CRM114-Status: GOOD (  16.55  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 14:59:04 +0200, Daniel Wagner wrote:
> On Mon, Oct 19, 2026 at 12:01:06PM -0700, Mohamed Khalfella wrote:
> > On Mon 2026-10-19 14:01:13 +0200, Daniel Wagner wrote:
> > > On 2026-09-20 11:28 -0700, Mohamed Khalfella wrote:
> > > > Export ctrl->ciu and ctrl->cirn as debugfs files under controller
> > > > debugfs directory.
> > > 
> > > Could you add the 'why' part to the commit message?
> > 
> > target# grep . /sys/kernel/debug/nvmet/mysubsystem/ctrl1/{ciu,cirn}
> > /sys/kernel/debug/nvmet/mysubsystem/ctrl1/ciu:57
> > /sys/kernel/debug/nvmet/mysubsystem/ctrl1/cirn:42541d24813bb536
> > target#
> > 
> > host# grep . /sys/class/nvme/nvme0/{cntlid,cirn,ciu}
> > /sys/class/nvme/nvme0/cntlid:1
> > /sys/class/nvme/nvme0/cirn:42541d24813bb536
> > /sys/class/nvme/nvme0/ciu:57
> > host# nvme admin-passthru \
> >   --opcode 0x38 \
> >   --cdw10=$(( 0x1 | 0x57<<16 )) \
> >   --cdw12=$(( 0x42541d24813bb536 & 0xffffffff )) \
> >   --cdw13=$(( ( 0x42541d24813bb536 >> 32 ) & 0xffffffff )) \
> >   /dev/nvme1
> > Admin Command Vendor Specific is Success and result: 0x00000000
> > host#
> 
> In the meantime, nvme-cli learned to dump those values as well. I'm not
> sure if it's worth adding these just for this use case.
> 
> 

Good to know that nvme-cli now parses these fields. That is said, the
sysfs and debugfs attributes are useful to have. Say the controller is
stuck in a state that it can not process an identify command.


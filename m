Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB0DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c0pu3AOa7Jqr4q26ebNJ4LdMU0x/lC3tR2Tx7zL6lHg=; b=C9w+WF+EHqeECxHHyKbUD/v+LK
	z+Fd8+Nze0fS4jpaH1sqzngvKf5TAITyp788ALMrpQX55IKwVQSIalYr1ShOgGjqeCEuX/om+EzkP
	fWK5ACXBmBPOd3CnPWRfD8qJ/Mhol32LOuBp48KnbYxcV5ARgZfkW8dW0iZkBBk/qaWM7MoJyFvLc
	hyyyGQDf5axOgUMLiQIVlJRjads62s4nB2T3gvoliGZgUAr52ItwTWNanYT4kv6vXZVeC2dcwaw2c
	snpKHriSTAa8nvtGnRe1uycRnMwFrboqaDl4J8AWpPG3Wkzp3jGdNIdpdygo5ltlb4pyuot9368/s
	kdiSCwsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKhZ9-00Aw4x-EW; Thu, 17 Feb 2022 14:15:27 +0000
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKcHE-009ThR-HR
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 08:36:38 +0000
Received: by mail-pg1-f173.google.com with SMTP id 195so4395802pgc.6
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 00:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c0pu3AOa7Jqr4q26ebNJ4LdMU0x/lC3tR2Tx7zL6lHg=;
 b=NzlnpIJUrd6O43rlwvvPE2Sx/ZcAk2KPy+JOd4m6OkMyr7l8T20Mp0OVNHFal0+1Qa
 uKehfMf8nZSr2RO/HSqcUxbRYBCSHtK/vFwdOJvtVP5KcU+QYuuqIR9HhnnGww8cFAcU
 hRZWjV3R8XxGEVhLsIY/Sr8MLsR/R4389jzj0TTRjMwMc59nsmkHpcGc+NiZm5jxCzl7
 KCqpeCJ1rSVO6UnUAdU+EhTHwXq2mbucEehOZdJk9CX0TsjpwZhhO4e+CSgauXO4Qm52
 CQqSl+q6cKw0Mu6z+ePHuTKHe/ad4RogB90RFyoyt6scRWXCdr8HGUchcQJRz7DiV3u2
 FQMg==
X-Gm-Message-State: AOAM532FE5R8QD6LW60wVexjWisnpGBv4IbQUOgmTaGW8oDHdOZDmvag
 vtK06DC4JLgh3LieKMiC53A=
X-Google-Smtp-Source: ABdhPJxBt7Z+O4vFbpVhfGNT3TGbLxz1vmlCiZLvikj1oSVLWqBDGQ3nJ/8d9qgUnXxcV37sMxYLVg==
X-Received: by 2002:a05:6a00:23cd:b0:4e1:7ab2:334c with SMTP id
 g13-20020a056a0023cd00b004e17ab2334cmr2123595pfc.4.1645086995489; 
 Thu, 17 Feb 2022 00:36:35 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id g1sm44078801pfu.32.2022.02.17.00.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 00:36:34 -0800 (PST)
Date: Thu, 17 Feb 2022 00:36:31 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
 jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] block: make bio_map_kern() non static
Message-ID: <20220217083631.34ii6gqdrknrmufv@garbanzo>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9@epcas5p1.samsung.com>
 <20220214080002.18381-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214080002.18381-2-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_003636_642191_990DAF73 
X-CRM114-Status: UNSURE (   8.30  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 17 Feb 2022 06:00:23 -0800
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

On Mon, Feb 14, 2022 at 01:29:51PM +0530, Nitesh Shetty wrote:
> From: SelvaKumar S <selvakuma.s1@samsung.com>
> 
> Make bio_map_kern() non static
> 
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

This patch makes no sense on its own. I'd just merge it with
its first user.

  Luis


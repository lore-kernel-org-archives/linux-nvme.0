Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A18C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o1S3y5ixG0WzR8fn4Vnp6b4Fe53woZBRZKg+SOBRRAY=; b=T+uTuS9Svi0QY0jjKhBH89x8T3
	KDPmyVCvQr6CDKjFZ8D2c5QI55bCVBsNES9lDGNLjRYFW81K+iJ1zrzGsZLYLUIuDS6v1KgAGGbhg
	aIgZYPDK4ySJib3Fafc+nn/ayVPBIR3O/IAPkh8d2Cjl9KsnyG3LEL2KQbLy2VE5SEDVH+Qpo6i21
	NhpfuPJ1ciBl5P2rUm8/5cNobuXeQbheK5th1u2Cswinrxp1zd9UWY7C2V+A8z4DKc/fRVnuMO60q
	R4tM30UlDaoVUbRNLoaL68S9chbvp2EmpcWMdGipuppNSizIbnh/KYrmizd7Smm0xjYw5GwRRoanb
	6w8AyS7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcF2-00HEnM-HK; Tue, 05 Apr 2022 06:00:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcEv-00HElp-W5
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:00:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B9FB668BFE; Tue,  5 Apr 2022 08:00:24 +0200 (CEST)
Date: Tue, 5 Apr 2022 08:00:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [RFC 3/5] io_uring: add infra and support for IORING_OP_URING_CMD
Message-ID: <20220405060023.GD23698@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110834epcas5p4d1e5e8d1beb1a6205d670bbcb932bf77@epcas5p4.samsung.com>
 <20220401110310.611869-4-joshi.k@samsung.com> <20220404071656.GC444@lst.de>
 <CA+1E3r+nHBace_K1Zt-FrOgGF5d0=TDoNtU65bFuWX8R7p8+DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+nHBace_K1Zt-FrOgGF5d0=TDoNtU65bFuWX8R7p8+DQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_230030_214676_596909BE 
X-CRM114-Status: GOOD (  12.26  )
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

On Mon, Apr 04, 2022 at 08:44:20PM +0530, Kanchan Joshi wrote:
> Another stuff that got left out from the previous series :-(
> Using this field for a bit of sanity checking at the moment. Like this in nvme:
> 
> + if (ioucmd->cmd_len != sizeof(struct nvme_passthru_cmd64))
> + return -EINVAL;
> + cptr = (struct nvme_passthru_cmd64 *)ioucmd->cmd;

Do we actually need that sanity checking?  Each command should have
a known length bound by the SQE size, right?


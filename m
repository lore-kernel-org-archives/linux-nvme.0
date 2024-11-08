Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F29CD5E142
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QpOFXUq5DjNbcaGxANLVbevJUtnPfsAjjxgbFQiQj/g=; b=gL2Zp8vQWnV3uA5TujwLsLM9ds
	2QXn7pMUHGRjqo4tcXsEPaG74VGKuIN/vKtjfMISQeLe7DqqfmFP8rf7N4hYjt1BjqLJ0aXspv36X
	mon6Cd4wwgb03D+BAsH8W1BPFGP6Z4khhO6eiFn1w2eEyIDGfjl3j5j069MX2/H5Hp7bTtwdCUkjN
	ejTXl26A5n/2SzUXQ1qx1tf+hcDHJ0wKiGT6O/cQnBrbxKYZMM01SN2co2UMnyC933ycBDf6ivSfx
	ZkTUCsFrk4KdxPZer5iItQ74Lsgm5haTIjz1qYv8oDU4WTgj2lS/r9q2daoGDX4DAWhzJVl0NHE5x
	PDYgwO2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9JAu-00000009b6D-32zO;
	Fri, 08 Nov 2024 07:12:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9JAr-00000009b4y-2xip
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 07:12:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0640768B05; Fri,  8 Nov 2024 08:12:50 +0100 (CET)
Date: Fri, 8 Nov 2024 08:12:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241108071249.GA9374@lst.de>
References: <20241029162402.21400-1-anuj20.g@samsung.com> <CGME20241029163225epcas5p24ec51c7a9b6b115757ed99cadcc3690c@epcas5p2.samsung.com> <20241029162402.21400-7-anuj20.g@samsung.com> <ZyFuxfiRqH8YB-46@kbusch-mbp.dhcp.thefacebook.com> <7995ffbd-7ec0-4f99-86a2-011bc3375228@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7995ffbd-7ec0-4f99-86a2-011bc3375228@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_231253_907822_77F74740 
X-CRM114-Status: GOOD (  13.46  )
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

On Thu, Nov 07, 2024 at 05:30:36PM +0000, Pavel Begunkov wrote:
> It makes sense to implement write hints as a meta/attribute type,
> but depends on whether it's supposed to be widely supported by
> different file types vs it being a block specific feature, and if
> SQEs have space for it.

It make sense everywhere.  Implementing it for direct I/O on regular
files is mostly trivial and I'll do it once this series lands.



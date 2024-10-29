Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187ECD74942
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 21:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56AYHcYUN+spbk38llt8j1FN9zcZj+uxltIZ3aCTggI=; b=GsRe57v8+LcEFiAk+8Wlp+xZ3j
	vtQk7v9pMvYbMKu/Q1F/Y6N+Z1GaRQtEBFNSQcnY4kPtGbkTFbo7qucSSXO6uZCytOIKi1KeRITJu
	rItf95n37fH4724hffhrbLG0HEqDaloeytu/xrpw8Poc+AG4vJS2mpcHSOONqHhy/0cWAr58NsCkn
	z/6pRqAZImyFTu3kn+jd54JuABL31Z1VVQYCmtcbbPLlqi3y/ldniJGn1fG3GktoJqKgetHZvNHzE
	EiNb01w56WrjTFNMTMDiiMjUurR1mp6HXN70rpc1TFdFu8LXvqR2BKq9bxlkik1Ov8PBoKzD7I0Sp
	1UbzHpSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5tog-0000000FxBm-1QnX;
	Tue, 29 Oct 2024 21:31:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5tod-0000000FxBQ-3gId
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 21:31:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2B0E65C3FC3;
	Tue, 29 Oct 2024 21:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB2C4CECD;
	Tue, 29 Oct 2024 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730237510;
	bh=56AYHcYUN+spbk38llt8j1FN9zcZj+uxltIZ3aCTggI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spdIkOCmPHZNkETdNxcFXTv47hnu2CVxJysnGzUTHqOTnqHNfBQSfqaRhTpCRz6+1
	 JgzMRlrE+ZqVtCKi7Xs2VcGCTHVoJ0y+MZMN3u+VilWEkEm3oU4+T1fQpSoe9WkjOZ
	 1PtMdJ/pbfJ7EzRvmS3Kn6IO9m2IuoOsjxiC4qMyXwBB05XpiYhEKih8rutZuUqOIT
	 7VREendKYBoXyTL0tO2fpxjukP5cSbgtsQ4jPzbgycb7Je3f8/PyuVbqsChbnoev4E
	 efGmHmCyXrehf7/BYL0lhJSO4dKc9ofOapI5t8/+7yuqvFfpR6R/1aaP1pyU2q4MgY
	 CMEaYVKpY+Sdw==
Date: Tue, 29 Oct 2024 15:31:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 03/10] block: modify bio_integrity_map_user to accept
 iov_iter as argument
Message-ID: <ZyFUQ78W35H73DMr@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029162402.21400-1-anuj20.g@samsung.com>
 <CGME20241029163217epcas5p414d493b7a89c6bd092afd28c4eeea24c@epcas5p4.samsung.com>
 <20241029162402.21400-4-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-4-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_143151_978172_7C3DEA77 
X-CRM114-Status: UNSURE (   6.39  )
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

On Tue, Oct 29, 2024 at 09:53:55PM +0530, Anuj Gupta wrote:
> This patch refactors bio_integrity_map_user to accept iov_iter as
> argument. This is a prep patch.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>


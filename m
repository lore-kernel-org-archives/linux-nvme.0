Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC796C7EE2D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+MqBmgFQT9EAg68aVVWwOGnedZXDbTyS48leNsrMz8=; b=I2ZzA7FDUmi8MzEldPX4NMeS9l
	thoSjlQ6Ot5JzkAXGn8UIFGme3PyGEHucQ2Vusxr89hYsGVVFHBPKXZXVzRgFWk57nJhnNkhWXWvp
	IEE77wLB6CjoFNSWyAlpzspWr6QnG7akHR4rCbmz55uY2/PRweNpy6tGgIaZ71xlrmjHCQGGuKxIX
	HYiqJN245jHHaBaWtd9ckrdHzxWx3mpzTtBCdCy9y24IW4xGuN5vS0zc9OsI6in22j7Gf2beZeDVP
	rN+ipX+jXKg9uOWA/FnGNXfrlJqGtzhXkdFYm+kdfa1tpnVdIwUK+PUmkHfdKJ05ww/i7LrwUuPGi
	MrRlvCNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puHbr-005VCk-2W;
	Wed, 03 May 2023 18:53:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puHbo-005VC4-2T
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 18:53:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 10CB5612BB;
	Wed,  3 May 2023 18:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D155C433EF;
	Wed,  3 May 2023 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683140027;
	bh=Tt1IVHowAm04rV7fMokQMuz8wTkl3aCyv7RhwH49rX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1UFMFDLq86Q5Uu322j2TdntYxiPuJOCbpIS7B6ayxvqLNiMGNapad5nAW/v5P5JW
	 cBfTMV+BAg84mI/i2e4OKxY8q8XY3QenwEn/MfMlqjEYL3pLMRsJa8q5Vgi3rSNz2u
	 aAn4CmqwI0ijiIwqpbK1hCzSarSQBXVhC+Bk9ohQ9VpOv53cB6iRHpXQ4+wSwWTjQt
	 clw5Ti3m5jtb197SbHMoi0iJ1Yap1FVnhYGiKXe0mUkwoLq3pHzbeHTlO/B4tWsro0
	 h1a4Sl2gjYKiqUnjy42PJgBKq7qxp+SEltgCrHCLKZ/q9814CPM7o6fbNEtXkiIwwx
	 3DyWjGnKXwMiw==
Date: Wed, 3 May 2023 12:53:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jejb@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH RFC 06/16] block: Limit atomic writes according to bio
 and queue limits
Message-ID: <ZFKtt2Z5BPyV9gHJ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-7-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-7-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_115348_847329_22433525 
X-CRM114-Status: UNSURE (   8.41  )
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

On Wed, May 03, 2023 at 06:38:11PM +0000, John Garry wrote:
> +	unsigned int size = (atomic_write_max_segments - 1) *
> +				(PAGE_SIZE / SECTOR_SIZE);

Maybe use PAGE_SECTORS instead of recalculating it.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B64E77184
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vU7H8TH1+MyA6/bu7EqPO4pLy7dom5wnB9Lbwme9cZM=; b=oyZyPyOzeLbLkv5xlYZmBLtiN2
	nevXVrCsIACEi1Ra9pbNdFbS6I8LxP7g7h7P4VN0v9SnT5F62JDWZ2Op3/yMeJAnNZ6l8yqAlZzAR
	mPNch8+MhZ5T8MZXAGRElHH9v6kYuTbLZHVAqeSSi26gyf+sByNE9H3mNNed55inc6GvpcfEZHMtT
	P67IddUz8K3zGi1K4WZDDqmXuE2caGYbw72tKSxqbOvYCac4sfm+E4rM1AOQt6Kr/VgpVBWmbDzmn
	5aqf7Dk6vVqvrtdEOBoPmCoVpUA0a8eic8P+0oNHoKwrGeiedGVZ/aRH7IgKQLrmuS3njfLukOhCd
	PiGtcMgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaWY-0000000ECTH-0eKw;
	Tue, 17 Dec 2024 16:34:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNZzv-0000000E42h-2KZ2
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 16:00:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 40DD15C5F97;
	Tue, 17 Dec 2024 15:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F67C4CED3;
	Tue, 17 Dec 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451233;
	bh=EHGn27UeUnw//XSv6nd3Qhmq3MootZ87QKYdo80ZL/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZVLa1H8hgXpNwONSs5txre9UH01OTtl9vxkb32Gtf9+pTFOe/Thhkdue2I9TPEub
	 jilLZsJi5raF72IUopGowSdSbVrvz2Dbp3v8NL4+JCCS4noxr6JPgyLrFyx/BlZJfZ
	 Ltd1wKtudLh7QQB89hHu3bnuSkOaDw6e/9TGTeFlHq4zu/K+uIKrq2JKxiFSQ+OcVw
	 3z577EwN3+VktbZE/wGkYulTQ6oEhICsf8WUgrd4aNXF1BKY5aiRtPSxMrbx4Wm3DP
	 tJ+ev2O7YGc5iOF0RHZOSfn2qqqa/Sh7F96ZIcEe4QVFBAN/yK0SEydYlsyYnFiA2s
	 iun5yXRIQWb/w==
Date: Tue, 17 Dec 2024 16:00:26 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, netdev@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: core: Convert inet_addr_is_any() to sockaddr_storage
Message-ID: <20241217160026.GS780307@kernel.org>
References: <20241217012618.work.323-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217012618.work.323-kees@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_080035_641486_B78AD943 
X-CRM114-Status: UNSURE (   9.80  )
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

On Mon, Dec 16, 2024 at 05:26:19PM -0800, Kees Cook wrote:
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used, as part of the work to move away from internal use of struct
> sockaddr.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


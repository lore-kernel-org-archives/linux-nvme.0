Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F4606A330
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lp5iPWUd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzRYE13j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rMRPONQOYjAF9HKKBayLjA2YuezRW4mL6HNg3dL1nlo=; b=lp5iPWUdKW7oKKueZiUhHW2Isq
	GNtOJN8pBNMYCN8/ld6WcRlQrye98W26LUourMYcmVh+xXxBWAOz3l3/ufqEKjGk5gXSQAxri7Wzg
	TCN6B/Ugnn3lIOKYSr9oyQbTQ4TdXjZ4EJuRjK16chz1oradUrYc7CYHUFhYlx3obfx91QGzvGMXU
	FeR4AoEV2NQCF/KJUTphCgyCjFEpBQt7iJc0N0flNn3zNEjj4fw1qwm1Vn/G94HLhTrVKQoA2eywu
	JG5Kjsa34bKySJlUfDXGuf3at1CxboW2elBVk+1e9340V9Rqa6GOom3L2jvIi3/mvIb6/kXHo6s+G
	Vtspb8HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFi4-00000007lsN-1uiG;
	Wed, 11 Nov 2026 21:18:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQsjF-000000050aY-3Lp4
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 20:46:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D3045618CA;
	Tue, 10 Nov 2026 20:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D441F008AB;
	Tue, 10 Nov 2026 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343564;
	bh=rMRPONQOYjAF9HKKBayLjA2YuezRW4mL6HNg3dL1nlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HzRYE13jB8RdQv3aSy711gVTQF5aN3kmny3Bm+Tqd6DGpMnW/UdmBhwvuV3tDKwWA
	 qBQkdAe99fCfyY4HwhHW6vpWLb11tiX1rqZm0gqSH24JDOLS4Qw49hrn6RKPLTZ5tX
	 8yK911/kTi5YKMv0Zeg0t9hinxeSS095ez81rveTvDj3lhZIp5MNrpZ0TzLVXjAROD
	 H+8sIgKlcwqIAFUbaPlcIA/mKF9hJXlPwet/3tzJzqABID/FKMqpm7AOyUBYjWme3C
	 0bNu78jINjA9S3ckBH6UNePnv8GkZJATc2s+TTg1AYJLjtNo7jNr7qgY8y7Qdi6pm5
	 ugUx9cOxV5vJQ==
Date: Tue, 10 Nov 2026 21:45:52 +0100
From: Gao Xiang <xiang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
Message-ID: <avOCgJPOwRdsIxgd@MacBookPro.fritz.box>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 10:14:56AM +0100, Christian Brauner wrote:
> File-backed mounts take any regular file as the image and the same goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang


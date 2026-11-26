Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B51606A323
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F3FqZids;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgFW/BRA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VE/MUdrae0rgGBZgvICrVU8zY9K62C8PJllKHbD1Ln4=; b=F3FqZidsX8EOycQE79kA5MGhaA
	xIApwDdyOdoisAVtrwQeIcrEpHHfydvIN6UIqiYj7RnAgih5zfIYHoVGRT0kUMS4OjKMcAmqcY3dG
	d7p5Yglz0lihC5f0xU9XaHQPiWo9m7hKz48IBaY+fCo58bL4m07u0JpHDZrIESYTrZxNlLbHP4zON
	YCMc0L9v2Isxd88nyzL6A9pWRXYGXYsd3m8y+R2JlDSm/yTN9ACI2xpRXDYRk1z8fkfJpCjtfS3Ig
	ZBiMacAZoQvwezaHbqqqVL4xZQ+cZhUJSUJT8e5oq5EWfyTScGiUPA/TIJ9LDvGD3MFtTAikrr8fa
	zXQ0n39w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbtL-0000000Dpcz-3m0N;
	Thu, 26 Nov 2026 16:00:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbtJ-0000000DpZp-0mRv
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 16:00:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 5EA5661D0A;
	Thu, 26 Nov 2026 16:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 032501F000D0;
	Thu, 26 Nov 2026 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795708807;
	bh=VE/MUdrae0rgGBZgvICrVU8zY9K62C8PJllKHbD1Ln4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgFW/BRA65DPqOWtWM/gHt/VabwCrxCgXXz+9nSIwQHhamHnemeygSa83/9p2C86W
	 sRuwUIjwdLY9P+dmCPycLRIeZ74vCmzvHW/XWfVKc0bHU3jhXKiw2+jwiGnidRFGFs
	 ixyhTw7zavr/KFwjQAOA/Y2TLLwfvDe6Cv/Ac0Ua/w2f/DP5b8fg7uE88BIMOqFyzw
	 cgd5QVxwfDG9Swd2IwLE/EDFFCgjBKEdcUGAZIIIXBiVDMztZmz5v31qrbr0CtTAwx
	 gRoiYPvthCWCPbcTt1H5hERTcX3kBT2u70PrryJgSZVNyValwweN9omZ3bAs+iYErm
	 bS4Lv4zBSJbHA==
Date: Thu, 26 Nov 2026 18:00:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>
Subject: Re: [PATCH v7 00/14] nvme-auth: switch to use the kernel keyring
Message-ID: <awhXg41rBQL982qk@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 03:12:18PM +0100, Hannes Reinecke wrote:
> Hey all,
> 
> the current NVMe authentication code is using a hand-crafted key
> structure; idea was to have the initial implementation with a minimal
> set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the
> nvme-cli commandline, which is far from ideal from a security standpoint.
> 
> So this patchset switches the authentication code over to use
> 'struct key' to hold DH-HMAC-CHAP secrets. User-facing interfaces
> (namely argument to 'nvme connect') remain the same, but the key data
> is converted into keys which are stored as a new key type 'dhchap' with
> a random UUID as description in the .nvme keyring.
> 
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface), a key description, _or_ a key serial referring to a
> pre-populated dhchap key in the kernel keyring. This allows for external
> provisioning of keys and avoids the security risk from having to specify
> the key data on the kernel commandline.
> 
> The entire patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
> branch dhchap-keyring.v6
> 
> As usual, comments and reviews are welcome.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
> Changes in v7:
> - Fixup next round of issues from sashiko
> - Modify to use key_serial_t instead of 'struct key' to pass key references
> - Include suggestions from Martin Belanger
> - Link to v6: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org
> 
> Changes in v6:
> - Fixup next round of issues from sashiko
> - Fixup kbuild robot issues
> - Link to v5: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org
> 
> Changes in v5:
> - Fixup issues found by sashiko
> - Link to v4: https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org
> 
> ---
> Hannes Reinecke (14):
>       nvme-auth: modify nvme_auth_transform_key() to return status
>       nvme-keyring: add 'dhchap' key type
>       nvme-keyring: drop nvme_tls_psk_revoked()
>       Documentation/security/keys: fixup function name
>       nvme-keyring: link addtional keyring into .nvme keyring
>       nvme-auth: switch to use 'struct key'
>       nvme: parse dhchap keys during option parsing
>       nvmet-auth: parse dhchap key from configfs attribute
>       nvme: allow to pass in key description as dhchap secret
>       nvme-auth: allow to specify the key by key serial
>       nvme-auth: wait for authentication to finish when changing keys
>       nvme-fabrics: allow to pass in keyring by name
>       nvme-auth: link pre-provisioned keys into .nvme keyring
>       nvme-auth: allow to update pre-provisioned keys
> 
>  Documentation/ABI/stable/sysfs-nvme  |  10 +
>  Documentation/security/keys/core.rst |   2 +-
>  drivers/nvme/common/Kconfig          |   2 +
>  drivers/nvme/common/auth.c           | 232 ++++++++++------------
>  drivers/nvme/common/keyring.c        | 370 ++++++++++++++++++++++++++++++++---
>  drivers/nvme/host/Kconfig            |   1 -
>  drivers/nvme/host/auth.c             | 176 ++++++++++++-----
>  drivers/nvme/host/fabrics.c          | 169 ++++++++++++----
>  drivers/nvme/host/fabrics.h          |  12 +-
>  drivers/nvme/host/nvme.h             |   6 +-
>  drivers/nvme/host/sysfs.c            | 300 ++++++++++++++++++++++------
>  drivers/nvme/host/tcp.c              |   5 +-
>  drivers/nvme/target/Kconfig          |   1 -
>  drivers/nvme/target/auth.c           | 250 +++++++++++++++--------
>  drivers/nvme/target/configfs.c       |  84 ++++++--
>  drivers/nvme/target/nvmet.h          |  15 +-
>  include/linux/nvme-auth.h            |  17 +-
>  include/linux/nvme-keyring.h         |  47 ++++-
>  18 files changed, 1257 insertions(+), 442 deletions(-)
> ---
> base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
> change-id: 20261120-dhchap-keyring-v4-09f0bac1d8c5
> 
> Best regards,
> -- 
> Hannes Reinecke <hare@kernel.org>
> 

Without looking into detail to the changes, it'd be best if key type
semantics would align with [1]. See the preparation patches for other
subsystems.

I'll send updated patch set after v7.5 merge window. The only reason
I'm not moving forward sooner is to gather as many bug fixes as
possible for the "previous world", which LLM bots kindly provide.

Otherwise, this needs to be refactored very soon after the patch set is
merged.

[1] https://lore.kernel.org/keyrings/20261112040242.247168-1-jarkko@kernel.org/


Br, Jarkko


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B52BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v9oqJ4ReCQNKGEgoZL9Mfj95gWny0SVqr+Sx6WdZedI=; b=gFs3YehebcszznbxWLk5mz9CiP
	ZK9nHerDNDMQAfWuTK8yqkqCTVxv23CHbl+i+/wVTL9O6/one7Lu6lKvOe4Hpnfjv9qEv0b//ZkFA
	1qfGkHozsNV4P1RTwbFtHmhRfp46LW9B+R7EACYlJ/DR3cMNT8k/v3W7VktKJFAB51622xqz0MpxQ
	jVyGpOe6Hp2/bXO87JzYnLMDCdd/uqSYJtXPw46V6rTuylgt4XV5xcyDippwHYQdGjlPsgx27Kwcy
	Qq0mv7aIVpuruY1qlJ56NTKf20t1xXs5HvOlMV+MurONPw/XC74XopbSEK0pkKgQ2ATf/oXioxJ9g
	L2fTQKHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol36u-00FxS7-8p; Wed, 19 Oct 2022 07:03:28 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol36r-00FxPp-6d
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:03:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB723202AF;
	Wed, 19 Oct 2022 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666163001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9oqJ4ReCQNKGEgoZL9Mfj95gWny0SVqr+Sx6WdZedI=;
	b=Zp4cAIFQKC0xDaFYEejdhTqSQpzNx1v9NJrYKl6rhpFthXwb9vGvBpKAbTJtPfiCx/dGbR
	UcM8FpX1UJxYNVglE8uVQxk1V5yyYLVqqRoaGP+xYtho/CMzuSQZ+peaWksiOimJ+G+LDy
	U2BcAiBGUzSDXRI4RoN3Z4PVNS8aMxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666163001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9oqJ4ReCQNKGEgoZL9Mfj95gWny0SVqr+Sx6WdZedI=;
	b=KUFJhEDahGFzTKETyW8dijoaM5IP7K5Rpj17UzDUBOtWZhSR7WY9liMp86NGhTv9rVd19A
	YJ8HQUf6dPUH72Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DCD113A36;
	Wed, 19 Oct 2022 07:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /FJ3JjmhT2PCMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 07:03:21 +0000
Date: Wed, 19 Oct 2022 09:03:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Arunpandian J <apj.arun@samsung.com>
Subject: Re: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
Message-ID: <20221019070321.ra5wns3sc3dv3r74@carbon.lan>
References: <20220517061456.7623-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517061456.7623-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_000325_405637_EBC17584 
X-CRM114-Status: GOOD (  18.87  )
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

On Tue, May 17, 2022 at 08:14:56AM +0200, Daniel Wagner wrote:
> When I reviewed the tests I asked wrongly for GPL-2.0-only. The
> project is using the GPL-2.0-or-later license. Relax the license
> requirement to GPL-2.0-or-later.
> 
> Cc: Arunpandian J <apj.arun@samsung.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi Arunpandian,
> 
> Sorry for the mess, but could I get a signed-off-by from you?

ping?

> 
> Thanks,
> Daniel
> 
>  tests/nvme_copy_test.py           | 2 +-
>  tests/nvme_dsm_test.py            | 2 +-
>  tests/nvme_get_lba_status_test.py | 2 +-
>  tests/nvme_lba_status_log_test.py | 2 +-
>  tests/nvme_verify_test.py         | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/nvme_copy_test.py b/tests/nvme_copy_test.py
> index 8bee55584e0c..7cb087e27ef6 100644
> --- a/tests/nvme_copy_test.py
> +++ b/tests/nvme_copy_test.py
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #
>  # This file is part of nvme-cli
>  #
> diff --git a/tests/nvme_dsm_test.py b/tests/nvme_dsm_test.py
> index fe3dc01f6a8d..51f35ecec0a3 100644
> --- a/tests/nvme_dsm_test.py
> +++ b/tests/nvme_dsm_test.py
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #
>  # This file is part of nvme-cli
>  #
> diff --git a/tests/nvme_get_lba_status_test.py b/tests/nvme_get_lba_status_test.py
> index 5f970c487478..7ce8d33b829d 100644
> --- a/tests/nvme_get_lba_status_test.py
> +++ b/tests/nvme_get_lba_status_test.py
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #
>  # This file is part of nvme-cli
>  #
> diff --git a/tests/nvme_lba_status_log_test.py b/tests/nvme_lba_status_log_test.py
> index ecc3fce8bff2..8420adf4e5b9 100644
> --- a/tests/nvme_lba_status_log_test.py
> +++ b/tests/nvme_lba_status_log_test.py
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #
>  # This file is part of nvme-cli
>  #
> diff --git a/tests/nvme_verify_test.py b/tests/nvme_verify_test.py
> index c783d5de07a5..19559c028c8a 100644
> --- a/tests/nvme_verify_test.py
> +++ b/tests/nvme_verify_test.py
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #
>  # This file is part of nvme-cli
>  #
> -- 
> 2.36.0
> 


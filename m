Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1323EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2H7inTYFwoLcVFpKmahDzL1toqDRQqRrEkGleeHWcPI=; b=jgIrH0eHiXzemdFzDW1xLyIo5c
	GMnpzYoAcjtE8ZENw4TgvKy22cwEe+aIQ17QhrUhD7miQ0/oj/cmIOqDLF5wSQsLaHSnPPfhflRXb
	s0OQ6QnuPaGknVqeFPwgCob8MpG5f0qutO0GYj+HzdC06s1nsYRsfvKDnsy9bzBX3fXYFf4fX6lUK
	bljJOcwzA5qFD6YkqcA71JsvWwYfqAyYF+22EnOQb6UyOLgqquEujs4tiZR3Y/Qqbjtnpu9mHkuRo
	5HOJd3BSer0Zyh3IcZfaNIAHujqOZgF0DToMWWfD0hwHeujV9l9GzCfZwh3nFG0e/wGGaqLAyHiGV
	SPUxMhiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5ke8-00H7D4-3h; Mon, 27 Jun 2022 09:03:04 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5ke2-00H78D-1i
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 09:03:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6FB821D39;
	Mon, 27 Jun 2022 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656320575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2H7inTYFwoLcVFpKmahDzL1toqDRQqRrEkGleeHWcPI=;
	b=b9aDiD7q6X3u5uLZ2fPzHaGrZOYtZUtiVVoj5wQCVeHrF9qFF/4IWtFFd8E2T/wYBbzibT
	3eLcFnRN1cUBZfhPxuBqF/J+qIABRVaEwzJeGheeM0PXo2E2ISL+3H2qZwo/4XzBujsSUi
	gEyU6Oj8JDPOJfFOekuRMjfgqu3pUiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656320575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2H7inTYFwoLcVFpKmahDzL1toqDRQqRrEkGleeHWcPI=;
	b=s3X+7YlU8kksT6K8fFCXw6dZtjqNVOJkqkHD5FWxetqOV1HgxhYgDXGCM6ZlUH+Um2hn+N
	2e6c4ncePqxLHvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C800613456;
	Mon, 27 Jun 2022 09:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qubLMD9yuWI4HgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 27 Jun 2022 09:02:55 +0000
Date: Mon, 27 Jun 2022 11:02:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH nvme-cli] udev: re-read the discovery log page when a
 discovery controller reconnected
Message-ID: <20220627090255.5vpqvzcd7l2vjja2@carbon.lan>
References: <20220627080650.108936-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627080650.108936-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_020258_296452_95B37DC2 
X-CRM114-Status: GOOD (  19.02  )
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

On Mon, Jun 27, 2022 at 11:06:50AM +0300, Sagi Grimberg wrote:
> When using persistent discovery controllers, if the discovery
> controller loses connectivity and manage to reconnect after a while,
> we need to retrieve again the discovery log page in order to learn
> about possible changes that may have occurred during this time as
> discovery log change events were lost.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> index 434cc080ffe3..245e0d0dbad0 100644
> --- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> +++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> @@ -17,3 +17,10 @@ ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="0x70f002",\
>  ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
>    ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
>    RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"
> +
> +# A discovery controller just (re)connected, re-read the discovery log change to
> +# check if there were any changes since it was last connected.
> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="connected", ATTR{cntrltype}=="discovery", \
> +  ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
> +  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
> +  RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=$kernel\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"

Stupid question, but when we issue the initial 'nvme discover' wouldn't
we run this rule as well? And if so, is this okay?


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782E3EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlDFAtgp099nKHXgUx+YZ+acML+IbkVe385YE5jXbOA=; b=BbDq7PacYOXJzTukWid0OG2CFV
	RWXXE8Ev3x2r5GfSL3Sxw5et4Bx9cBgjc4V25tfBcbZp4fLwqnlHdLVbXaFoOenegblJejOsB/edh
	1rEuT0DhVEy/VQOgHiNEQj8YFHRzhYhrwVB3o68+3LS7NA0wAJ5oqnhrdqYzivKqJajVeA6goMhgU
	ayrW6Ql6JGqYXVKfRClLfcqaxqkLNfYE4IQOa6eujOry9TISltqOwVSUisyyPGdYu5lEdESU7QGT3
	CvU8IzRfqZKQNOW0V31prUe27nn2+kvVb5Rs1IsLJsS0Sch7BE2xzpUnjqtJhOPOaEiplVV61EOhP
	cGoAFSRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTg25-004Ubt-0g;
	Wed, 09 Aug 2023 10:03:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTg22-004UbH-2x
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:03:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A51821862;
	Wed,  9 Aug 2023 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691575388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlDFAtgp099nKHXgUx+YZ+acML+IbkVe385YE5jXbOA=;
	b=NsgQyxDqeyggechlZElg1R7WrlinbP742oHOCOsky2uxo487G4d7HsEmG28KpK6BocDWup
	NSJYGO2/QSo+SPZLcZmbU89RkP/CCBSgHgn9k/R+oYxYQf10xy7lMF/mhITS6WuASBAKzB
	CGJawZUEKgSrMhvtSUs5Vg0uaWDxO6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691575388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlDFAtgp099nKHXgUx+YZ+acML+IbkVe385YE5jXbOA=;
	b=ZmD9xyWTXfZ3RZTv6V7fyk8KZCJE9Y9yv59kdA0dZV12fyWIN2t9tUOwTjzEyfawfUjDru
	12Z2sa8wB22YHWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C3A2133B5;
	Wed,  9 Aug 2023 10:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nGvcBlxk02SoIwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 09 Aug 2023 10:03:08 +0000
Date: Wed, 9 Aug 2023 12:03:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH libnvme v4 1/2] fabrics: Read the supported options lazy
Message-ID: <eebuo3upuc4cv2tkozd37nxrwnqlhe2jmb2v5ygres35o6ld2p@3wzbcf4jtrtb>
References: <20230808133028.14643-1-dwagner@suse.de>
 <20230808133028.14643-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808133028.14643-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_030311_115269_E90E6245 
X-CRM114-Status: GOOD (  16.24  )
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

On Tue, Aug 08, 2023 at 03:30:27PM +0200, Daniel Wagner wrote:
> Read the options in when we need the for the first time.
> 
> Reported-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/nvme/fabrics.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 800293e2a8e7..9725eeb3cda8 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -357,10 +357,18 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
>  	return 0;
>  }
>  
> +static int __nvmf_supported_options(nvme_root_t r);
> +#define nvmf_check_option(r, tok)					\
> +({									\
> +	if (!(r)->options)						\
> +		__nvmf_supported_options(r);				\

I'm adding a check if __nvmf_support_options() returns an error.
Feedback from Caleb.


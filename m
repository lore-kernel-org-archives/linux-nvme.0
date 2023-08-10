Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70608C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dj/3hiHNvgy84wGzyP6ros8JwJPIhLDARNnNreLN2PM=; b=m5ucCE8KWh6zMDkIH71qPxW99+
	9kwNIcmkrxTaxfqoGwiz1/RM/inAHuBdOJ8obr5Vs4TOhbJUEsHl3Az1R5O/rYqHLitdJra7sFDqk
	jt4PipJm94TPuOKa//g+gfjGv5yKsOrMsuDKPP9xnhtp+BJ4ev1iZDkXqI8nzEEeFrt/9aQ+5JI95
	kBq/FxSx2rwoWDE3E8Sx6kb9uUWO534k0MhP3gdcr7zC/jnqpd7oerZbXIghOJ0LArL4rT+dfaOU6
	i0deW4GdSlYwFCZprSw0tHWILKex1ELILlqbknH4lL+DD2TzbC/V328n0q5KPos3wR0uzxxtW+Pze
	WcSkljdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU1o4-006xxE-2y;
	Thu, 10 Aug 2023 09:18:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU1o1-006xwa-21
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 09:18:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F1EF1F749;
	Thu, 10 Aug 2023 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691659088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dj/3hiHNvgy84wGzyP6ros8JwJPIhLDARNnNreLN2PM=;
	b=QPw6JNrH/pKSGpx3LnXjM0mQesM+zq9YEFJs/YQwXLfW8w6okEW3jQX9O9aXVbJpRvd0TU
	pc3sCdRGsgfvR8r5pBnt1dOZdxms04k1kTx/3qyjEcSeUIjlY1O0U1R8BGM8WxXWI4y6QU
	ynkvBZEhHCldoIAFrrNVk0CXi5jauyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691659088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dj/3hiHNvgy84wGzyP6ros8JwJPIhLDARNnNreLN2PM=;
	b=foBJ2yxslq2CWH0awapgv4EzeEgtLFLUwyGnyBvDtcwZAKCfecHARxRReh6Xo6fJ/fL1XC
	zhejFe+BeD6ZekCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ECD5138E0;
	Thu, 10 Aug 2023 09:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GiORA1Cr1GSgewAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 09:18:08 +0000
Date: Thu, 10 Aug 2023 11:18:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	linux-block <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Message-ID: <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_021809_804827_F8C73B54 
X-CRM114-Status: GOOD (  13.78  )
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

On Thu, Aug 10, 2023 at 12:19:39AM +0000, Shinichiro Kawasaki wrote:
> Yi, could you try and see if it avoids the failure?
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 4f3a994..005db80 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -740,7 +740,7 @@ _find_nvme_dev() {
>  		if [[ "$subsysnqn" == "$subsys" ]]; then
>  			echo "$dev"
>  			for ((i = 0; i < 10; i++)); do
> -				if [[ -e /sys/block/$dev/uuid &&
> +				if [[ -e /dev/$dev && -e /sys/block/$dev/uuid &&
>  					-e /sys/block/$dev/wwid ]]; then
>  					return
>  				fi

The path for uuid is not correct. It's needs to be something like

	if [[ -e /dev/$dev && -e /sys/block/"${dev}n1"/uuid &&
		-e /sys/block/"${dev}n1"/wwid ]]; then
			return
	fi


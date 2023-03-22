Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE51C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOGdcO1EZD9n5IqMHjs3eG75QoqO37wM75r0PcRnhsE=; b=A5RAaXJ2BjjHSYYIib/uX0YpOu
	z6Vyes9/9lg48kd2XCVN2ZvGc+LiJa8QV6itUdE2W3S6k7XbrAchVieQKUaBZP4G6XwE2bTRxE5YQ
	zWY9NygkyzmD97FEG0jiT27F1c295s+y0sytAHvVEQ2L7RJdCsU3+UxTdbMCIsFByPotAvHq4PPyk
	dUcXrx8bv6wNqXJka3Bn5jPl+o5jTNfBldHGTC7mJUQKaSU+N1kqmg/NaGjcIYEWRgCM88AUyHx35
	e3BGvDT1Wel5+/l8pjPJsqkwvcidUq3Qw0eNgvTiSLdesDBHjnO0Zl7099gsodzecraOFms+Igrkm
	9UvrfE/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pewKW-00FjFh-1L;
	Wed, 22 Mar 2023 11:08:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pewKS-00FjFK-2b
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 11:08:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 471A133A2E;
	Wed, 22 Mar 2023 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679483306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOGdcO1EZD9n5IqMHjs3eG75QoqO37wM75r0PcRnhsE=;
	b=TJGJQb1KcF1EzjdmPNM+Rysb2Afw8R8rs19Du6PRIL9gtVr39Y8NuvFTIBHy28OPdSwpA5
	Hy+h9A+Lo/LbCDveXFnem91qEVLqKtn7lbkkniqFyz50/hFrH/imjnQo8gPTGqYl2jz5yC
	N4IM0OFh+QQ8urQ670gVP1SvsUip+34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679483306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOGdcO1EZD9n5IqMHjs3eG75QoqO37wM75r0PcRnhsE=;
	b=tnrAgcXyTos48Pm9+N8iijpdW8lVrKAtqFySqLco1v/3GGXzKIVHTHv9+xUPqvMy9Ot3k2
	tCHKFTWfO/khekDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AD97138E9;
	Wed, 22 Mar 2023 11:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id r8hRDqrhGmRqKgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 11:08:26 +0000
Date: Wed, 22 Mar 2023 12:08:25 +0100
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 1/3] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Message-ID: <20230322110825.333gezvuiaf7gof3@carbon.lan>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230322101648.31514-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322101648.31514-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_040829_015600_B0D5B67C 
X-CRM114-Status: UNSURE (   7.72  )
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

On Wed, Mar 22, 2023 at 11:16:46AM +0100, Daniel Wagner wrote:
> +			-S|--dhchap-secret)
> +				hostkey="$2"
> +				shift
> +				shift
> +				;;
> +			-C|--dhchap-ctrl-sectret)

Urgh, typo. I wonder why I didn't caught this in my first round of testing.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1291EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCQPzpWxcZjuHFf6utFBojmN5TpojM+GSpmbcHQTbsQ=; b=Q8X8yzKg8+zSjlclDteKbKG/0x
	SrZvGTv6BQZJHeh6BZrRk/bzpm+iWTjYTit+pNREwryd1iEIVW3t54orjZQmQvxZ1ax0p9C+dRtmA
	1B4MERpQAK8ABv6X7GnKpHpo/yd5xlCHd2l4B4n83+DnFMhzOm+usypROdXQUYqFBUTfAjzrKAGYE
	9i+j4uhuIu+tnktnKcFuvIYeyHdZWIE8ooJLJoJnJCUnyj9604Y4/g1h0pZuJHaMhPEnhjCwjH6oO
	JAMjIvODj/jOCmpQp3OxCW1D1/Qacs7Q/AwWOwp6OMVWv1ftQUsanrwXTV+tfh3JCev4IF93z/EqD
	Y1BsFNIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM57S-0072Fy-2R;
	Wed, 19 Jul 2023 11:13:22 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM57Q-0072Dc-11
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:13:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D52FC21AD4;
	Wed, 19 Jul 2023 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689765198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCQPzpWxcZjuHFf6utFBojmN5TpojM+GSpmbcHQTbsQ=;
	b=mM2dbWuflBsMUmLa+3J1WZ4pOrRrhsvPZbKuFFoU/RZJ139n8AoGzoif3mZ+kOSFWfroDl
	cm55cSw0KexH4mgbcphkQSN/xb7qOQtFPdzJnbm3RNUCc7ho15j5vrQuhNldc92PNFubw+
	GQBN3adt1AYPlvutmu9L5eBnMiUH7OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689765198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCQPzpWxcZjuHFf6utFBojmN5TpojM+GSpmbcHQTbsQ=;
	b=2DVgUvOhDHQWrzldFbcIybG31X6hYgP1oUqf9KxJ6fP+fs9lcICU4iFLTNz5i+ssARGE2S
	s/4SO2KxF8+jOVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6E7C1361C;
	Wed, 19 Jul 2023 11:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kJyGME7Ft2RfWQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Jul 2023 11:13:18 +0000
Date: Wed, 19 Jul 2023 13:13:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_041320_516002_98986BDC 
X-CRM114-Status: GOOD (  14.43  )
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

On Wed, Jul 19, 2023 at 12:04:50PM +0200, Keith Busch wrote:
> From my reading of this message, I thought the intention was that this
> driver will eventually replace it with a:
> 
>   			goto out_put_ns_head;

This would obviously make the PowerPath module unhappy. Sure, I am aware of our
upstream policy so I wont argue.

> instead of letting the namespace become visible for some unsupported
> mode. The warning was to give people a chance to migrate off whatever
> unsupported setup they were using, not a deadline for when the warning
> dissappears.

I assume this means the dm-multipath setups? If so, I understand the motivation
but do we really have to burn the bridge here? It's not that we have additional
code or maintaince overhead, except the module parameter multipath.


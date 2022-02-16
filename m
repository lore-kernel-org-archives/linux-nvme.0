Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3282C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wljECwOVGGlrm20XVbopXludY2oCOk9cN7qd31vUzRQ=; b=WzpNpAkDg/F3tjQlvRnH85KpTe
	rnkwmVhvuX6bOdOFclOTj2eRLWHl0B02916X53UsMMU2i71uDkqYWJ7oxApzfCQgZ548Q8TfL0k7Z
	QUNCaVD5F6tWkuTZA88bQd8g5uxNAWsWboBH5vebZkGVe9WTkq4ZfES5Fdr0sBqbQjF8v5Fd+4TRO
	6FNUNm8GsMiHFB/a9G/J1oTwcg+5mZIbXkIY4QsJM31WLRT/7TLdVzumdRblivSfhPPlSv1h5NxmS
	jORuRSLtfmNHOSFike6m4DFOdz44Z7vQ5d0WgfG5orP45N6vz/nnAaUNtz8K4KqgsT2Ml2s5UhUiH
	FeyQsOcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKNWv-007mzJ-Es; Wed, 16 Feb 2022 16:51:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKNWo-007mwn-RR
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 16:51:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58B651FD32;
 Wed, 16 Feb 2022 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645030301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wljECwOVGGlrm20XVbopXludY2oCOk9cN7qd31vUzRQ=;
 b=JA4V+gednpIbA9roM72P6l3asrTF33Y+ZYb95cgbRilBoBVlE6J6lrJgjtgOqHZyQoWxK3
 qCGklgKKNPd1mNWH10BPHApPcA+FmkvD8iPYzXMqEXNVV0jwtOXCXpxVXdQUzX7nb7REnk
 eln6g39EOba0xGqHvlWyI3f1CXSBQR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645030301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wljECwOVGGlrm20XVbopXludY2oCOk9cN7qd31vUzRQ=;
 b=T4uQ3u3xeBQXBrEnAgsFmfhV7cpv62czfUro7PscDt07+A848sMmTJhX7ySqjd2xaE9Nc0
 M4cg6e3DcTQZyLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D7E013B35;
 Wed, 16 Feb 2022 16:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bs4BD50rDWKVWwAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 16 Feb 2022 16:51:41 +0000
Date: Wed, 16 Feb 2022 17:51:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: don't return an error from
 nvme_configure_metadata
Message-ID: <20220216165140.jho4ejao4phyg2hz@carbon.lan>
References: <20220216141220.4162670-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216141220.4162670-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_085143_068920_C90999C9 
X-CRM114-Status: GOOD (  10.23  )
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

On Wed, Feb 16, 2022 at 03:12:19PM +0100, Christoph Hellwig wrote:
> When a fabrics controller claims to support an invalidate metadata
> configuration we already warn and disable metadata support.  No need to
> also return an error during revalidation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


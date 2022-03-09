Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3472C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/VSCStMTGWep+zdq9LYjYJlnBrIqvGq9HEAKFHWCIY=; b=cFzMbUGslN+yprgfcwvyauxouW
	hyuHw0mKj758yejBD//KRNu5sxzZ6q9LnjvmiarNd7/cVix0O7HRQo01ZE+ylTrOYygGCgMwim4f9
	IMLAeJEhTjxSeMaxVTiQKOgumnm3V/xODg2RwSUpGQnpCw0w9iaNww2Lo25uzBIKv5eJ5tw87NNE5
	X/qqKD5//riSPBDPUrxrvcYfypMjC3YknW/4/BluzB2bLU8hH0fXZaadsuZBOuG1mOFCfB2f2+dOp
	Q390mNqIA2PPJjjkH/0XC5l9SmVjRCeXwRlKIymfMTAVqptFPcNJEy1Gcs1hanpC7jdPJlzWubrGL
	+zhCa5pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRzkV-009gJP-Cq; Wed, 09 Mar 2022 17:05:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRzZz-009bWh-Tr
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 16:54:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE2761F382;
 Wed,  9 Mar 2022 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646844865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/VSCStMTGWep+zdq9LYjYJlnBrIqvGq9HEAKFHWCIY=;
 b=1E9xRySEaZ8HaDJTfTB8fQlcV1G1gINmStbOnL5jkv2AHrYi5FqAK9+jbkMScowWWTXs4K
 7KDP0v2EQCxEKsPg9AMOMUU97sj1+0Tq29FMjkZo7vUvWDPfV8Nzu0OFJDR+DBZ4zNvhhz
 9mkMsRo/HR8WoOBxL+wfmf8Z7ZzF63U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646844865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/VSCStMTGWep+zdq9LYjYJlnBrIqvGq9HEAKFHWCIY=;
 b=uLzi6hR0jSeaU/6M3V27n+v7iRJZ+ZYcOUCMOCgr2eMjgwE9OEWT+SShy8i3Z3Q1pME2OI
 NLIhATk/0zuUaMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A462913D7C;
 Wed,  9 Mar 2022 16:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hekbKMHbKGKSCgAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 09 Mar 2022 16:54:25 +0000
Date: Wed, 9 Mar 2022 17:54:25 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-multipath: use vmalloc for ANA log buffer
Message-ID: <20220309165425.dcu24zgltmswpbh7@carbon.lan>
References: <20220309132900.1171-1-dwagner@suse.de>
 <7ce203c8-792c-8e34-eda8-3b44f873c5f2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce203c8-792c-8e34-eda8-3b44f873c5f2@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_085428_156158_FBA725F9 
X-CRM114-Status: GOOD (  10.14  )
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

On Wed, Mar 09, 2022 at 04:09:08PM +0000, Chaitanya Kulkarni wrote:
> We need a blktests for this as earlier code was never exercised
> to its limits, anyways:-

To test the old code path, you would need to make sure that free memory
is fragmented to the point where an order n allocation always fails (n
is depending on the ANA log buffer). With the vmalloc in place, I doubt
you can really test this allocation problem. Unless you are interested
to figure out if it's possible to DOS a machine from the target side out
;)


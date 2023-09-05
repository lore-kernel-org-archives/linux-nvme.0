Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2323EC83F33
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=694nKN4ExyQrxRRysh2YmMnPN+5dzRGEaf0BQ2Mbzm0=; b=QF22shA7zDbM6tldYN0+ayG+je
	HJIfon3jK2XDrfvn7aMc5Om1c7YRBa+LIVVs2ZtogvyknQOvl2hfiqsauygFoNJSOXmGra2GfhEGn
	LuN8jxOfZm8jmDVpZwb2GcoiXg2CfEs6yn9y2NcmZKz1DSO02ioJEc9/TMTNjZcqR35TYE1mu+AiJ
	8okLeU9BImJYh1vXZE94I7YKP8LNPJ7uc2mNySYOY6DjQHy5J4S9mskRTZIYk9z9yKUT2v8A09gLs
	8Wyh9XprgfHUvjtfonizGm0ULymotHKETjg/IRHqYe3USSuoH45EPKseFpvOVYFzPH00+Nvrx5a17
	AWuwTOBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdTFT-005jpI-0b;
	Tue, 05 Sep 2023 10:25:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdTFL-005jlo-2L
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 10:25:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E90921832;
	Tue,  5 Sep 2023 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693909519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=694nKN4ExyQrxRRysh2YmMnPN+5dzRGEaf0BQ2Mbzm0=;
	b=A3XnTG6oHa5tCYnpBeqqKHOXcgArPLPpSP580o2PjGBN1DCBX+ApYKHdTVjL+sCUzKcEdF
	0yEFzeo5SIW4rDH3Wz+9gAfkWmmsf+8i1JE3OOmVvRPn39nCKbjtZdd3mqpj4mNGHDfj8T
	bkMkV1KKbNZph/XMPPtw64NTvf88Yjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693909519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=694nKN4ExyQrxRRysh2YmMnPN+5dzRGEaf0BQ2Mbzm0=;
	b=1NBvVtGHMjvFJlhgRXTDEQ9OmW3hOKT/RRLiHXsuvwAlE0PLUeEruIOXTRlMEBnNzCLydi
	8nIxEZ2NC5yqqyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F6EC13911;
	Tue,  5 Sep 2023 10:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eeV1Dw8C92QyTwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 05 Sep 2023 10:25:19 +0000
Date: Tue, 5 Sep 2023 12:25:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 2/4] nvmet-trace: null terminate device name string
 correctly
Message-ID: <jnuxxernxywnyrcotnm3peryeiw6adc3gd7qn4u35lpwz4ekds@nl6zd5fecdju>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-3-dwagner@suse.de>
 <20230905064921.GB19701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905064921.GB19701@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_032523_927625_1D21950E 
X-CRM114-Status: GOOD (  18.26  )
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

On Tue, Sep 05, 2023 at 08:49:21AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 29, 2023 at 11:13:47AM +0200, Daniel Wagner wrote:
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  drivers/nvme/target/trace.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
> > index 6997bd7e45cf..9ba466b49613 100644
> > --- a/drivers/nvme/target/trace.h
> > +++ b/drivers/nvme/target/trace.h
> > @@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
> >  		return;
> >  	}
> >  
> > -	strncpy(name, req->ns->device_path,
> > -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> > +	strscpy(name, req->ns->device_path,
> > +		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));
> 
> I'd just switch to snprintf instead, that the best way to ensure
> termination..

Okay, but we still need the +1 as the string is cut short; 'loop0' gets
logged as 'loop' at least with the strscpy variant.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A4AC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPnN3J1fYYc7EHLn+MXsTI6meJVzzJceBOZyn8kBA4w=; b=D9F1KKzAJyMIVmThQJKTAtbFz+
	sohTPnqRBSBcUzOwTJUpRqr0Z4q9ENUbutbQcUe9yFNYsYRiGB7Hb2FHPf1ZVLuy9GDWnJm/u5Ym6
	gTVLhdjRX1Uja5ATGZYIasHvSebhDeJOy9vVmDAPQzaQ+MH9+9xFj02GZ0hBb7rNFoGyOTJTUlj+g
	3By+T90Z30MotnPnLIJtgWAgIpEPxtjeupCfZ2KyPths4+9b2I7OKM894pQNzCHdFCG1Z5fUZrn/8
	/20sAiMfQ7OJk0cAjWwM4fJ3O9MJNn9nAde5xW62zYuyktnHzKe6LNwbQfkrQiLVF3jxGj8p9r6rO
	P+Jk3NDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poPuK-00Gdnq-36;
	Mon, 17 Apr 2023 14:32:40 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poPuH-00Gdlk-0u
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 14:32:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 975FB21A08;
	Mon, 17 Apr 2023 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681741955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPnN3J1fYYc7EHLn+MXsTI6meJVzzJceBOZyn8kBA4w=;
	b=YmlwwoP2QMNFiFrhUrd4ASxmNj2uw3EqEFmvMg4/0RUOZSm8xKIKgyAHYdhgrs8fB3OVUY
	/Vq2jKUZWqivw7EfsOnWPbu5k3qxYgVaObk0UQLaZ8Kx4u/1BVb6FZOpkQrOIpd4uCyXw6
	N1AOHmp+bP8pdkkLRMOkhdUxStYyDw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681741955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPnN3J1fYYc7EHLn+MXsTI6meJVzzJceBOZyn8kBA4w=;
	b=7e7jv+JKXyFY95q3xbzP1sC89x58JdLaTTIoHeT0BQcIAXWi7UMlaTPt709EYCwCzKxIOj
	w9ajYq+jY6P2h1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86BC81390E;
	Mon, 17 Apr 2023 14:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XXrXIINYPWQhFgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 17 Apr 2023 14:32:35 +0000
Date: Mon, 17 Apr 2023 16:32:35 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: WTF is going on with the nvme-cli build
Message-ID: <6fuh43gsczjido6okjs3wok6mx3q2kuhcsmhdalqlatmnhylk2@krladcc3nzma>
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
 <2a464237-975a-bfaf-ef2f-15ffd45b4d8a@kernel.org>
 <sqrbip3dafgf4cnmmdziect6vem2msocsxqcqmnvyrlkartomj@ilwk43vyl53s>
 <c70e194b-ed19-7d0e-5976-477cfa74a716@kernel.org>
 <rjoeveo4f64f6hwdu65weljwbeceoj4h6eriiborxtnvfzmeqo@l3t5uh5s24rq>
 <76432336-a866-0fa5-f42d-aa1f64945214@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76432336-a866-0fa5-f42d-aa1f64945214@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_073237_461807_48E9C890 
X-CRM114-Status: GOOD (  11.20  )
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

On Mon, Apr 17, 2023 at 08:06:52PM +0900, Damien Le Moal wrote:
> Replacing 'pkg-config' with 'pkgconf' and reconfiguring+compile still gives the
> same error.

Just checked what my local machine uses. It's also pkgconf and there is
wrapper around the invocation, similar what Fedora does:

https://src.fedoraproject.org/rpms/pkgconf/blob/rawhide/f/platform-pkg-config.in

I suspect one of those environment variables includes the path the
/usr/local/lib/pkgconfig

> But I think I found the issue: I had a
> /usr/local/lib64/pkgconfig/json-c.pc file pointing at /usr/local/include/json-c.
> Not sure how that garbage ended up there. Removing this file and compilation is ok.

That's also a solution :)

> My apologies for the noise.

All good. I am sure this know-how on pkg-config will be helpful in future :)


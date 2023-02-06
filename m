Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F37C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SimJm/Hp/22Gg0dAfx5cGztddez17nA1O+pQLYR692Y=; b=d4aKhjFAMgbhjPVuD4Hx3XUTtD
	2jki+j3NkXAD1yDCIEuqdyby9l7KlUzZnVYqNPF+RwitSu1AgVKh15x2UA880Xig7DdWGX+jXbYNa
	P8pLrY6gpHUfzran5tSuOJMPrp0oK8W4GPWGeCQLpATvZBUq9xHCswKFnOq981WrNQeyH5K/9hODF
	OvyQTDdAO0gzq4oDUSvxr7ThxuHZntnTHXgKhM0oE4we4eCkn5+BreDdyEFOyTvDITGGq0B0EesrC
	fJTCocdnp1PTxThXB3Z3BgYdmheG2hwmT3wCuEw5uE06BQnINmCqx182zqElNPQpGmcz3Cs1hWBxb
	f/GFQ6fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOxpk-007tKk-F3; Mon, 06 Feb 2023 09:30:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOxpc-007tGz-W9
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 09:30:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1DE115FEAD;
	Mon,  6 Feb 2023 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675675832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SimJm/Hp/22Gg0dAfx5cGztddez17nA1O+pQLYR692Y=;
	b=wFgPhfmnsu3L25a7l8jOuI8XyZrZ0cu0qwaUVhnlUJAjOvreYZSpmHfJEcs1dOQbG2tR/W
	CL+YIzZI7NBa5p60b2pIND7vmsTxgKGCmxrJaQ6oLFJZwGl/h7f4ynsBqxrukM/vM/+Pkr
	46NXa8+3ra9jWoVtQ+LjYhxZ5Ponko8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675675832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SimJm/Hp/22Gg0dAfx5cGztddez17nA1O+pQLYR692Y=;
	b=uq6h/1FKYvle9UGHI45oAql1OAhWcMw2a2+8tJEFK2I8bvMel4vv7F34ogp+C2QRDSuP3m
	F9FFsQxW/j/6iWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC9213677;
	Mon,  6 Feb 2023 09:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zfnBArjI4GMSPgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Feb 2023 09:30:32 +0000
Date: Mon, 6 Feb 2023 10:30:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Message-ID: <20230206093031.n34a2fduvkefsgfj@carbon.lan>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
 <SJ0PR19MB4544DB4A38A27B4D9FBA9E91F2D79@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB4544DB4A38A27B4D9FBA9E91F2D79@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_013037_236866_6A9E845D 
X-CRM114-Status: UNSURE (   7.49  )
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

On Fri, Feb 03, 2023 at 04:27:25PM +0000, Belanger, Martin wrote:
> In meson_options.txt we find the build option libdbus. Maybe the dependency can be disabled simply as follows:
> 
> $ meson .build -Dlibdbus=disabled

Good point, this just need to subproject prefix to make it work:

meson .build -Dlibnvme:libdbus=disabled


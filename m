Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CC1125855
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtQdlcl9F2UIHu4crS5Nr1GPSCLLKEfGdSzPecAesfQ=; b=vioQ1uB9BX9owm1OIzAnULAfBR
	YTs65ArJ87KnfhEJW5izIEXgq+fDBNl5+9ZCwayaBA2soQDJoi4enfF29MEwwVHHMgASuuHJvwyNA
	nFQYnq/RrQrsACz0OeQw+VUNWslnqxuzrJ2JSZrc9752nIm7W/PXBxcXjKiWBYJLXbssZ1Ma+7R55
	lZnMOc0gGeDHP+nhsVXoev6JfL8KMusmRtlRicF6+re8sronXVInx4PCwizIy8kRw17gIyiiioiWj
	tyd1+k6/H1baBpG3QhK6Mj2jrYpjd1xnSTBnEnpHwjmzU6eh+C7maHkgdpJDNz9Tl3aB4Tzk4CwBG
	9rCGk2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Mg5-0000000BwQg-23xf;
	Wed, 11 Mar 2026 16:44:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Mg2-0000000BwPv-3K18
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 16:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773247493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtQdlcl9F2UIHu4crS5Nr1GPSCLLKEfGdSzPecAesfQ=;
	b=gKO8vSRPasz4S9YesmEhegCbhVOJesXjZgcofTsvUnXqO3ooGacGlwJ2Q66J81oIoYRsg4
	zGoe40+BCQbHYwsjr0+Kzso0+a1MyUjnXdKA+Lz+hHNRhwy/n81v+rpVcONPZeqAOo8GBW
	S4AuE7WFRWSQwNSQ016tO/lhRkJMmKI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-1ZY-LLFQN0a5U8oeGAZjZA-1; Wed,
 11 Mar 2026 12:44:51 -0400
X-MC-Unique: 1ZY-LLFQN0a5U8oeGAZjZA-1
X-Mimecast-MFC-AGG-ID: 1ZY-LLFQN0a5U8oeGAZjZA_1773247490
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E75F71800464;
	Wed, 11 Mar 2026 16:44:49 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D4034180035F;
	Wed, 11 Mar 2026 16:44:47 +0000 (UTC)
Date: Wed, 11 Mar 2026 09:44:46 -0700
From: Chris Leech <cleech@redhat.com>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] nvme-auth: Hash DH shared secret to create session key
Message-ID: <20260311-flirt-autograph-39692a66b23a@redhat.com>
References: <20260311012116.2504291-1-cleech@redhat.com>
 <2fbad8b9c5e100bf04854b20b3790578fb724f89.camel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2fbad8b9c5e100bf04854b20b3790578fb724f89.camel@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gg5SvIrtYysodiiUNUjtublaq5Z-tBS_vZYeMnOIV2M_1773247490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_094454_899050_127B83E5 
X-CRM114-Status: GOOD (  15.88  )
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

On Wed, Mar 11, 2026 at 09:17:49PM +0530, Martin George wrote:
> On Tue, 2026-03-10 at 18:21 -0700, Chris Leech wrote:
> > When using secure channel concatenation with bidirectional
> > authentication, this results in hashing the DH value three times:
> > twice
> > for augmented challenge calculations and once during PSK generation.
> > 
> 
> But secure channel concatenation is supported only with unidirectional
> auth and not really with bidirectional auth, isn't it? As per NVMe base
> spec 2.1, section 8.3.4.5.9 Generated PSK for TLS:
>  
> "The host may request secure channel concatenation with the TLS
> protocol by setting the SC_C field in the AUTH_Negotiate message to
> NEWTLSPSK while performing only unidirectional authentication. In this
> case the host shall still send a challenge value C2 to the controller
> and clear the sequence number S2 to 0h to indicate that controller
> authentication is not requested."

I believe this is specifying how secure channel concatenation can work
"while performing only unidirectional authentication", not that it's
only allowed with unidirectional. It's a special case where C2 is sent
in Reply without expecting an R2 value in Success1 or to send Success2.

It would be counterproductive to forbid the host from authenticating the
controller when a secure channel is desired.

- Chris



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFE2F45A0A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZiwF1IZ+iqJ62AEoJed1FVgex1uf9oRtCkn8Of99PQc=; b=P+tbvvsmy4qKSOp7eASCcUmNnZ
	BUXqF4Dgu9BFEl2a7QLOh8L9gSQ8MNPtS772T+f0hUay7m1co1WdJmUlFZqlrx2+Nj/5s9FgsypU8
	Gydv819NKNqlkpB2R92ENv58/NbeswsjlRt0yNpwF/lHns0XyKMo/AHs25cwQhgHwCeIcsYkd8DsU
	cm5plJitrhskBEC7+HlyQ4qIppurRgCUn3yC4qs2Rd4tJ2jiqxkAfnE2T1xmlCg5KfkrUvG/t5mhT
	YsheMOxUTGf20L3Mj6hUfjVJYJJuSsVLb2XM+0t2+PQjjMgQnsiJE6jWWS14pNy6b9KtErNTbokfL
	WKfyq0jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIUP-0000000ClsY-21ET;
	Fri, 10 Apr 2026 20:30:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIUN-0000000ClsC-0Bpm
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 20:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775853002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiwF1IZ+iqJ62AEoJed1FVgex1uf9oRtCkn8Of99PQc=;
	b=XKCgo8eZZfeHnZQLElBn7cH/by9nGjq6DO87WnCzggrmm6Hy0CHFwpylji16pnIpCy0gm6
	4y2zsagdPWiqZtpnf1XOueL2p0KuAsYo+G3XFazkckekTUYeybBK2GNwo/a+Op9DYdKQaI
	tDQpR+pQGirZkWpqF+Xx5wNSQ0x5eTk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-f0E6JlQNOd2OGOKO_j_lOg-1; Fri,
 10 Apr 2026 16:29:57 -0400
X-MC-Unique: f0E6JlQNOd2OGOKO_j_lOg-1
X-Mimecast-MFC-AGG-ID: f0E6JlQNOd2OGOKO_j_lOg_1775852995
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A3181800371;
	Fri, 10 Apr 2026 20:29:55 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DCE11195608E;
	Fri, 10 Apr 2026 20:29:52 +0000 (UTC)
Date: Fri, 10 Apr 2026 13:29:51 -0700
From: Chris Leech <cleech@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: expose TLS mode
Message-ID: <20260410-a7837a6847c8f98c51c89739@redhat.com>
References: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 90jNciH3hAGkhkbJK7w2wEUKg25OrHTc7jxYVhXVF8o_1775852995
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_133003_157971_EE2C255E 
X-CRM114-Status: GOOD (  13.22  )
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

On Wed, Apr 08, 2026 at 06:19:56PM +0200, Daniel Wagner wrote:
> It is not possible to determine the active TLS mode from the
> presence or absence of sysfs attributes like tls_key,
> tls_configured_key, or dhchap_secret.
> 
> With the introduction of the concat mode and optional DH-CHAP
> authentication, different configurations can result in identical
> sysfs state. This makes user space detection unreliable.
> 
> Expose the TLS mode explicitly to allow user space to
> unambiguously identify the active configuration and avoid
> fragile heuristics in nvme-cli.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good, I look forward to 'nvme config --scan --dump' being able to
get these configurations correct.  Thanks Daniel.

Reviewed-by: Chris Leech <cleech@redhat.com>



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F88606A322
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JZM1LmPN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIvjj5IR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSpOP5JDP1s4MsxBzzWXWOtmM01006FnrrTq7GMsgos=; b=JZM1LmPNW7SzxbK92qZQjd0p+J
	H3v70jvjpyQM67XYDpn5zIBQJ6Hy0vd9HX/5/Lc/CmzN4/2C/wPt/JyY6/get0tWMw0JBQ27eUJ7F
	1SVhEueez4Bxo8ihfmX3UVK8P1n5QRH8d+4/DJzVpkCA3Tm2L9msKPK6lrQZjde8EF91GYb5xlIqR
	SVVUlKs5Gfl3hXWidPVdnsHpf8cX7+TQ/dXJzOsWAQTWUczHXICqA77H2zEkVIH9bR5UOFBDGRHW2
	eZDmEhF2xl1DiugsCLUVjtGbFbS5PywvCLQ2vSYbYwe/omJo5rwn6NcTpVVbwmF13c1zpV6zaHChE
	K5DGWnEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJeYq-0000000CyBh-2tWG;
	Wed, 21 Oct 2026 22:13:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJeYq-0000000CyBb-0BR4
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 22:13:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8245240915;
	Wed, 21 Oct 2026 22:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC71F000CC;
	Wed, 21 Oct 2026 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792620807;
	bh=KSpOP5JDP1s4MsxBzzWXWOtmM01006FnrrTq7GMsgos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SIvjj5IRzPy9dLyp03zJiiI886jCCJyYtZRWMGRdh2i6VaHAanysqb9x0Du8ZOZx1
	 mqypw1DhIwW4hJlECaOLBEFtqDxzcdPFZSzHXoW5Tln8/LOp698zt4mc73Sq4iC1rL
	 8LeHSIj5JP2+tb2t7rjgz9z0OjqVnjbowYzvXjOM4xc5MrUW8tq2z7k/M1GY7Cyizs
	 u6tK6x0xxspu0QmilLrE8Y8kIY1qvokEdQMlHRdB+UrOoxQ04almvAEvjk+7y5uagD
	 Ew7buhBfEzFeSW0p2VjYTSdeTPIPXYz/zMjX6ln0MU6rWQG2ApWSPcz5+OXg8wnOWD
	 RxCLrd+2rPvIQ==
Date: Wed, 21 Oct 2026 16:13:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-auth: update error log in nvme_auth_submit()
Message-ID: <atk5BSnlkfyow6u2@kbusch-mbp>
References: <20261021083647.8519-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021083647.8519-1-marting@netapp.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 02:06:46PM +0530, Martin George wrote:
> nvme_auth_submit() issues both AUTH Send and AUTH Receive commands,
> but the failure messages are hardcoded to "auth_send failed", which
> can be misleading when an AUTH Receive fails. So print the correct
> direction instead.

Thanks, applied to nvme-7.4.


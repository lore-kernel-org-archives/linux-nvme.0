Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D397F5545D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 05:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+WTYB6lVXw606x/HBX2m1Jcvv1uQbq325pOYgX2g38U=; b=Jd/J+i+B/bGEwZptBWdJkxkg21
	uydBaJ6MnYE+rUT2KnxzL/SJg9yzAtMvWn365S7JMyDdkGLCQRvPCTTQ5P5AgTjLwY6F3GeDnTGH0
	QecHL8hzaXeyUYWbXrRRN/k9JUtMtJpDgwyA8fN26ZCrkysKK8uRDQXhArUWq5C1IbJl1BH3yD4IA
	TAu7IkeL5d6zcABGt2gt/Ce2u6s2yT0NZWmfTviSwuy1ZZaXmg7XG8PZbhBxKvCfG6//QGX1ExhLy
	bJ96upZAhTB9ZGJ0naUEpFcwajMkwyfVPx5vc5271yWOqyEE/yEcdUCcXV9SIJDPyessxGDigr0O6
	t7ZhQ8vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv7ud-00000003Gfw-3ppq;
	Wed, 25 Feb 2026 05:58:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv7ua-00000003GfT-26lQ
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 05:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771999092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+WTYB6lVXw606x/HBX2m1Jcvv1uQbq325pOYgX2g38U=;
	b=hiGQOqxl9j8/a0/Znybu4WvxKvPAdOaW6zVfcSTVbmoTx0IwBxvYAFQIyW3p7KznNNW76F
	Q51d2RHdUK7huOvFMNuYL62ntNgddNSo0teTaDM6ovidCF+EVGUnP4b0ke0gdE1IRtXX+8
	NPGS3jFvKW+y4W9m5CyJSh095a4WERA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-Ts0wPBUmODWpQO4ks_ZNpw-1; Wed,
 25 Feb 2026 00:58:08 -0500
X-MC-Unique: Ts0wPBUmODWpQO4ks_ZNpw-1
X-Mimecast-MFC-AGG-ID: Ts0wPBUmODWpQO4ks_ZNpw_1771999087
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 001B8195605A;
	Wed, 25 Feb 2026 05:58:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4261955D71;
	Wed, 25 Feb 2026 05:57:59 +0000 (UTC)
Date: Wed, 25 Feb 2026 13:57:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Geliang Tang <geliang@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org,
	mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
Message-ID: <aZ6PYgJ0ZWeSc_GS@fedora>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aiKePlcLoit65AHkzl02nH5mDaMMDkYnGuC2C4J-B_8_1771999087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_215816_639135_69F99C9C 
X-CRM114-Status: GOOD (  19.87  )
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

Hi Geliang,

Looks one interesting topic!

On Thu, Jan 29, 2026 at 12:13:25PM +0800, Geliang Tang wrote:
> As one of the MPTCP upstream developers, I'm recently working on adding
> MPTCP support to 'NVMe over TCP'. This approach achieves a multi-fold
> performance improvement over using standard TCP. The implementation and
> testing phases are largely complete. The code is currently in the RFC
> stage and has undergone several rounds of discussion and iteration on
> the MPTCP mailing list [1]. It will be sent to the NVMe mailing list
> shortly.
> 
> 1. Introduction to MPTCP
> 
> Multipath TCP (MPTCP), standardized in RFC 8684, represents a major
> evolution of the TCP protocol. It enables a single transport connection
> to utilize multiple network paths simultaneously, providing benefits in
> redundancy, resilience, and bandwidth aggregation. Since its
> introduction in Linux kernel v5.6, it has become a key technology for
> modern networking, particularly in multi-NIC environments.
> 
> On a supported system such as Linux, an MPTCP socket is created by
> specifying the IPPROTO_MPTCP protocol in the socket() system call:
> 
> 	int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> 
> This creates a socket that appears as a standard TCP socket to the
> application but uses the MPTCP protocol stack underneath.
> 
> For more details, please visit the project website: https://mptcp.dev.
> 
> 2. Implementation
> 
> 'NVMe over TCP' establishes multiple TCP connections between the target
> and host for data transfer. This includes one admin queue connection
> for management traffic and multiple I/O queue connections for data
> traffic, with the number typically scaling with available CPU cores.
> While these multiple TCP connections (using the same IP address but
> different ports) help distribute computational load across CPUs, all
> data traffic still flows through a single network interface card (NIC),
> even in multi-NIC environments.
> 
> The 'NVMe over MPTCP' solution enhances 'NVMe over TCP' by replacing
> the multiple TCP connections with multiple MPTCP connections, leaving
> other mechanisms unchanged. Internally, each MPTCP connection can
> establish multiple subflows based on the number of configured NICs.
> This distributes data traffic across all available NICs, thereby
> increasing aggregate transmission speed.

NVMe supports multipath, which can apply load balance or sort of algorithm
to maximize network link/bandwidth too.

Maybe you can compare mptcp with multipath in this viewpoint.



Thanks,
Ming



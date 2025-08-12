Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FB7CA0EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMssdVH4Rks0Q/ZwR+fPWHWTct8d8e26WGrG6Qv+0sU=; b=ovIWGgvrYcMz6yihTBv49kg/1J
	ol+dcwZW/J1udKI5ShsC4ik7OEbyaNtjhMr/dCzJQh0UlhHDo/M6fQVtsLrIlQCEWcODLhddAQILq
	a8kcvab+u810XSUjpBQUTvisKxp7/KswwVn43J8pDnYHODN9pbuxlzgPgbb/cumsmdlbe8eJwzuuM
	VBbL+7fuJXsfbXgVZuGxk/+hxe3KmSDu3GaFeqf3gFD7tVxmPzLgV+h5grK123uf+nR269d9FzL0L
	w0pSAcV1tsW59FTauPNScgK7+/RhKyB8Ze4WXy+oOSTglXoIsLOAnOEaI96reQsP8Z1pvYOksjYnZ
	3pSLK9Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulx87-0000000C85w-0uej;
	Tue, 12 Aug 2025 22:06:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulx85-0000000C85N-0jR9
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 22:06:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755036360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMssdVH4Rks0Q/ZwR+fPWHWTct8d8e26WGrG6Qv+0sU=;
	b=I2jLz1+s5W8jlMt2uX6YFLrhzYerHvIQiANqxyUGPmrPzUvr7XPWvs6/5pCGgkxUokRGfU
	Kb7L7XB51w3MoFv2grtylbefASEgOtN4m5E+DmjxJD0aUO5J+WGfqeZiQ5/N5a7OKfycqG
	gYJF53QfpuqVbE0o8rNyisKomXNcvu8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-Z6-ZQWi4NL-Sk8Z2cA-1CQ-1; Tue,
 12 Aug 2025 18:05:56 -0400
X-MC-Unique: Z6-ZQWi4NL-Sk8Z2cA-1CQ-1
X-Mimecast-MFC-AGG-ID: Z6-ZQWi4NL-Sk8Z2cA-1CQ_1755036355
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4250195608E;
	Tue, 12 Aug 2025 22:05:55 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.17.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76E2E195608F;
	Tue, 12 Aug 2025 22:05:53 +0000 (UTC)
Date: Tue, 12 Aug 2025 15:05:50 -0700
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
Message-ID: <aJu6viaKxh4CX4Hh@my-developer-toolbox-latest>
References: <20250721021718.1159879-1-cleech@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20250721021718.1159879-1-cleech@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IQDKDKWLxiqtCgQeIGPBvnRyxRfGEn6iWbtvVR0RgBI_1755036355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_150601_289242_47FEACA0 
X-CRM114-Status: GOOD (  13.85  )
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

On Sun, Jul 20, 2025 at 07:17:17PM -0700, Chris Leech wrote:
> I was attempting to debug connecting the Linux driver / libnvme /
> ktls-utils host stack to the SPDK nvmf_tgt over TLS, and ran into some
> issues.
> 
> The TLS connection fails to complete a handshake because the TLS PSKs
> are different. The NVMe/TCP specified key derivation steps from the
> configured interchange format, to a retained PSK and finally the TLS
> PSK, is implemented incompatibly in libnvme and SPDK.  After some
> investigation, I believe the SPDK implementation to be correct and am
> providing a libnvme patch to match it. With libnvme modified, I see the
> TLS handshake complete in tlshd.

Ug, the kernel has key derivation code for secure channel concatenation
and it has the same issue.

RFC patchs to follow, only tested with a quick blktests nvme/063
currently.

- Chris



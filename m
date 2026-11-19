Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55F606A32C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C+M1LYpC;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=C+4nrjky
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nvYHsUl9tM9NZmLFifKI5Wv7jeouh/26xY3mVdlczVQ=; b=C+M1LYpCFVp9V/
	MBmyeVxJ4RQZ9BklLO7Xcm80MfszmGZV7VaCCmv3kEHHt9TldON5DU6sQN3FloNSO6YPY4Q2vuanE
	HkEBI2K2/bk9z5OesUVW0CJYqYxCs7qLrzM4bTossAlHojd2lgi+GpZfgJMRcpduMh4ODGBL4l0Jy
	Z+j79jKH9yWKOJ+x3qWuiymuRbvXrzJhAlAx0hqbbVwlu3iUTJs0yevoloIB6lrFnN7Ll0OxiGLCT
	dnTPXx26SW3scFvP+Yg3WEWrR6qgDeaimF/86Zn0VTlUeCpN5Ztz5rWHctMxJOEvTbf1n0sTr455e
	mQ5/dKyezIYkqLwgGDGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTpyV-0000000AZUR-1W8g;
	Thu, 19 Nov 2026 00:26:03 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTpyS-0000000AZTb-3K3R
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 00:26:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jVK541VqDzlffvd;
	Thu, 19 Nov 2026 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795047957; x=1797639958; bh=nvYHsUl9tM9NZmLFifKI5Wv7
	jeouh/26xY3mVdlczVQ=; b=C+4nrjkyWhLV68GexCa2wAaCqope9EVwVpEW3fsq
	EKTn3KsmGJR8kqyfKWWQrVovzv7TKiCorLUZroL3z/Pz4fFOeq3t/RauA+bI+lN7
	+KxT689LcSNX+2tHcDB/XQap7EbfgiTiVwW9Aq48jSzdVotR7zt8b0/QSlvCnTB0
	u2ctNiRY507HGbj7v9Kkai+YJpaXBRrercY/Qo0yC1jSWbkD4iAiAfpl7XFj8vyA
	X+VyesJRnrCPZEA+R8QVlnbJoFL7V/6H7/idEuBjB7vakJ2M+JBkjMOTOdFaiIce
	JtmtSS9yQ/lWjcbhysPhsgOzdu7ah8a5TaCZPZw8hPlMvA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zjc7Til3-Ozk; Thu, 19 Nov 2026 00:25:57 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jVK506Fvwzlg7KN;
	Thu, 19 Nov 2026 00:25:56 +0000 (UTC)
Message-ID: <829201ae-e646-44ee-afc5-39f63117bfe6@acm.org>
Date: Wed, 18 Nov 2026 16:25:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] nvmet: add context annotation for nvmet_ns::bdev
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261118073505.288910-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_162600_876992_77D28133 
X-CRM114-Status: GOOD (  10.73  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 11:34 PM, Nilay Shroff wrote:
> +/*
> + * The accessors generated by this macro are annotated with __context_unsafe()
> + * because they are intended for use in I/O hotpaths and request-processing
> + * paths where a namespace reference is held. These paths access namespace
> + * fields that are guaranteed not to change while the reference is held and the
> + * I/O or request processing is in progress.
> + */
> +#define NVMET_NS_ACCESSOR(_type, _name)					    \
> +static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
> +	__context_unsafe(/* access _name after getting ns reference */)	    \
> +{									    \
> +	return ns->_name;						    \
> +}

Lock context analysis enables thread-safety checking at compile time.
The accessors defined by NVMET_NS_ACCESSOR() disable compile time
thread-safety checks. So these accessors defeat the purpose of this
patch series, isn't it?

Thanks,

Bart.


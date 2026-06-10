Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00774CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCnXydsePUfWI7wJheU60rsZ9XtI7ABtFbNJBgzR4iY=; b=KwzV8RbUGNDUQbXJlPfvG05fUM
	a3IMAVbe+226BudaZv9kCroEnIkK9+XjuyUOKapld2J7Nb8erHRsUOlUz09oVm8NGYWnYYaE05Ff3
	hYDSyFcOfU2mYpj1YwqH+wGxz7/RBqylvmqoB9am5EhfoH3rGU0d3B091g+vzJtAfHCxO4+V25YDp
	L76VrAk07sL4VjEIPIsexkcIJXwirjNBIjykMivaLWem3ixRxyJMoreYXMqyzN0kTRkIuX7p7hXNr
	vmh3LhJNeL+kHSsqEdkcOpwlalctpN3Xm79yOUbt47Ai/WYR7Sk9OTNxqs4dCatCuf7rKgn8ovC5N
	QK3lGjXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLtg-0000000880u-3znc;
	Wed, 10 Jun 2026 16:35:24 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLte-00000008803-00T5
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 16:35:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbBGF5tVBz1XLyhV;
	Wed, 10 Jun 2026 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781109314; x=1783701315; bh=vCnXydsePUfWI7wJheU60rsZ
	9XtI7ABtFbNJBgzR4iY=; b=BARpm7xK8qMUJnr6rC1e9MnKJ7ytgbJO2HkFsPgZ
	KFVHdAK2SJ8IfLlBu9978CbLrNmIB67yHeVQeI58W5UOMm0OMYOWa8bt0oUjiZev
	t4R0bmhBwU7op6zo8wJ5wf/XBW30KJ4dvJVXRFOFuayP0Mjknkb0gvn8I54DjYIc
	8F4GAMkmiIOdFDmx/n7b50ofaxby2Mv1+w1fABq9GlXxoCJ8orwfLHavcKA712J7
	ZSiKCJEyS0gZtOqsz2Yp3LAtxOEnEcBRUXbphSDlrx49s4sJAZ9a7xw2hpygmtCg
	bfXLULxxH3fDXNGb1mBZjEHRW+wZe5W/629HyamcusglwQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y2lO1yU4r7MD; Wed, 10 Jun 2026 16:35:14 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbBG75wfYz1XLyhT;
	Wed, 10 Jun 2026 16:35:11 +0000 (UTC)
Message-ID: <b360713d-9518-4e46-875e-974317e74ddf@acm.org>
Date: Wed, 10 Jun 2026 09:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-13-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610142743.115898-13-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_093518_077883_78C0C912 
X-CRM114-Status: UNSURE (   6.28  )
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

On 6/10/26 7:27 AM, Nilay Shroff wrote:
> Fix the warning by acquiring nvme_queue::cq_poll_lock before invoking
> nvme_cqe_pending() in nvme_poll().

Please separate functionality changes from Clang context annotations.

Thanks,

Bart.


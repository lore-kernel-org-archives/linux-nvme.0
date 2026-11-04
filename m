Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67A607040E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2U0YmImq;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aW9MxGcN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Q5ylkFwCSFYny5VkrDa+VS2X6oriL1/EsEN3JDNDXmk=; b=2U0YmImqgmBcPh
	OrQhwk3XcCLKXuKr+Y8jrXd9fhHLdXohL2T9TaQZjgWYTtxpMJw83QuxujVVDkAl4C1oE4jm/XU1y
	IQ7LH8NGptPElNbr6pEZ+J7lSiW3NzHW0A5Jvasf9jrRYhG5N8fRA4KwYFH6ovb4lnxmBQaulAUmh
	VaxohbwMAW5fDP5uWT4cq1bukDHefoD4iy9C+WPDBz7dkXs/zs96CP4JeBPub4e8uY2zGInra/Uby
	0LL4q9YEkcO3i2OGnni/N8MDR1ljCUUYUs0qGdALYoJeoxueMYs7J7R777fGtjBejrcD00lswkbY7
	zvk8rls/LpAwejIZ7NxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhTz-00000006sZe-3cZ7;
	Wed, 04 Nov 2026 20:21:19 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhTw-00000006sZF-2lkp
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 20:21:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=Q5ylkFwCSFYny5VkrDa+VS2X6oriL1/EsEN3JDNDXmk=; t=1793823676; x=2109183676; 
	b=aW9MxGcNrB0Aj9XE0wUUxpFPif/3sQghP7U60oU5265nJ+GY1SebQvOVnXEjGDb87/qWziDAJZ9
	ip4lWzPsShfEqNtnKWByit4pkt5dZ5BahORjY6/K4A1hQ4CCMAVBVR8fpVQLFk6bggrSudN4EeOXx
	7iDUUNZiy/puwqJUD7TtbXylUa/8l7KZm0yEjyoCZfmzti0liRc67FUOUGJLWtP2uxZJCJks/azze
	Caidz2y4BPgpcfR1s9dkgYcXz8jzWPTzUOtqWJnp9AtlDBPQt5cSCXcjWBx11F02xbeF3NRi378m3
	hwLDZoatpZbFRyfJrqmtJyoj18FZffDyy4+Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xOhTo-002dN2-Kj; Wed, 04 Nov 2026 21:21:08 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xOhTn-0000000EerO-32lX;
	Wed, 04 Nov 2026 21:21:08 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1xOhTn-0000000F9ry-2QNi;
	Wed, 04 Nov 2026 21:21:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 17:21:07 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chao Shi <coshi036@gmail.com>,
 kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
In-Reply-To: <auuRhVO8nZHM-MwY@kbusch-mbp>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp> <352cfcec6865cbf636a22442511f16b1@igalia.com>
 <auo-v5ZliGbM1Tiz@kbusch-mbp> <65414ea51d23fdbeb5d8b7bb4bd9d535@igalia.com>
 <auuRhVO8nZHM-MwY@kbusch-mbp>
Message-ID: <610c32b5a2e5e36844071a367356aed6@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -1.0
X-Rspamd-Action: no action
X-Rspamd-Bar: -
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_122116_729604_8DB97B58 
X-CRM114-Status: GOOD (  22.54  )
X-Spam-Score: -2.1 (--)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 
 Content preview:  On 2026-11-04 17:11, Keith Busch wrote: > On Wed, Nov 04,
   2026 at 04:46:12PM -0300, Mauricio Faria de Oliveira wrote: >> On 2026-11-03
    17:06, Keith Busch wrote: >> > On Tue, Nov 03, 2026 at 04:54:27PM [...] 
 
 Content analysis details:   (-2.1 points, 5.0 required)
 
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -0.1 DKIM_VALID_AU          Message has a valid DKIM or DK signature from author's
                             domain
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
 -0.1 DKIM_VALID_EF          Message has a valid DKIM or DK signature from
                             envelope-from domain
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily valid
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.0 DMARC_PASS             DMARC pass policy
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 17:11, Keith Busch wrote:
> On Wed, Nov 04, 2026 at 04:46:12PM -0300, Mauricio Faria de Oliveira wrote:
>> On 2026-11-03 17:06, Keith Busch wrote:
>> > On Tue, Nov 03, 2026 at 04:54:27PM -0300, Mauricio Faria de Oliveira wrote:
>> >> For the former question, I'd imagine other block drivers might be
>> >> subject to a similar issue, under incorrect completions, and can take a
>> >> look at this later. I'd appreciate feedback on the points above before
>> >> trying to address it generically in the block layer, if at all possible.
>> > 
>> > Here's my real concern: the proposal is a race. Another CPU can change
>> > the request state to in-flight, and this code will declare it complete
>> > before the hardware even saw it. It's a silent data corruption problem
>> > that we can't fix because it is impossible to tell the difference
>> > between a bogus and a legit completion at that point. This kind of
>> > hardware shouldn't be allowed to exist as it can't be used successfully
>> > when it behaves this way.
>> 
>> Could you please clarify? Not that I'm defending the patch; just so I
>> understand your point.
>> 
>> The reason I ask is, IIUIC, if another CPU changes the request state to
>> in-flight and wins the race over an incorrect completion that maps to
>> that request, the request is declared complete anyway, even without this
>> code, no?
> 
> Yes, the race I'm mentioning is pre-existing assuming we're dealing with
> this kind of protocol breaking hardware. It just can't be fixed on the
> kernel side, and the proposal trying to cater to it makes it painfully
> obvious. I'd rather crash the kernel than risk passing on corrupted data
> as a success.

Indeed, under risk, crashing sounds better. Thanks for clarifying.

-- 
Mauricio


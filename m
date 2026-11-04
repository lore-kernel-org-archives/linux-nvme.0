Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBDF606EEAE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fKOKT58l;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OxdEUxei
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0PcCihOuFAnilp2mklYvKQzE/8b41vnt7v3E6IaO7LA=; b=fKOKT58lCCp905
	YEbhQN4Vm0oXHX1rPPKa9MuT49JcqOiKkeJibXjahQUa+GjfcAwk1UUyLpXty4GSjc1UiP1pcqxLI
	/PaCjnDk6kEhJV387shPcMHmniFBzSHFkInebSQZMzbIKlHRyGcDKn0TJ1g6ERgLSy+cyzZP9MTTT
	lsFkmRTLXGUPEohYT7wD6lXOt38KIGBF8m2LcEiaUgZgXvXOc8zk/tsLzFsagK3EJxqPZK2kassjY
	OUcAi5QYR0rKJQ2mNVI+pcLjxzsG7e9vV0rZ94b2p9L1p4Ii6CfmEwIFbJKZO030EHzU73iqK7iAl
	l5F7a6ZDjJH4gDYBsfxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhHM-00000006rDD-2bxd;
	Wed, 04 Nov 2026 20:08:16 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhHJ-00000006rC2-1caA
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 20:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=0PcCihOuFAnilp2mklYvKQzE/8b41vnt7v3E6IaO7LA=; t=1793822893; x=2109182893; 
	b=OxdEUxeir3xi082QbfIjRK2Qqa/LVL7WmaYuWDEUxXAGtBK9Y9/r0uH7lEz3uoe153FmTihW7nM
	znJzgFXJ4oLwYH0tnc46IMv1C8ro0Au43xXICuPm0BgwCgNBXcfn4IbOFFygOXnwaHQizaACt32ML
	knXL12JxLWNQsTwqFzBJTaA7V7pfczn4RDJ5LUrJq7hluyqzkAYn2GVAbKcSMOhURdYX+V0MrpjTA
	t5wBtzqoTUAOrjpU15g4KMrafFaXM3eft6Pnrpy70VDA4ybi2n5EQfG0jv1u1I1bkND+PdfGe3PKM
	3OJOVL9aEhX6rGDLNRdSYu6lvLkTa/BMe6Xw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xOhHD-002ceZ-1n; Wed, 04 Nov 2026 21:08:07 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xOhHC-0000000EdDv-22S9;
	Wed, 04 Nov 2026 21:08:06 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1xOhHC-0000000F9iF-1R6L;
	Wed, 04 Nov 2026 21:08:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 17:08:06 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chao Shi <coshi036@gmail.com>,
 kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
In-Reply-To: <641c7c0d-0455-490a-8811-e6eda728a7e7@kernel.dk>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp> <352cfcec6865cbf636a22442511f16b1@igalia.com>
 <auo-v5ZliGbM1Tiz@kbusch-mbp> <65414ea51d23fdbeb5d8b7bb4bd9d535@igalia.com>
 <641c7c0d-0455-490a-8811-e6eda728a7e7@kernel.dk>
Message-ID: <cb53c4ac3cd1ec95ec01374dc757a5f7@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -1.6
X-Rspamd-Action: no action
X-Rspamd-Bar: -
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_120813_452245_145614F8 
X-CRM114-Status: GOOD (  12.41  )
X-Spam-Score: -2.1 (--)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 
 Content preview:  On 2026-11-04 17:01, Jens Axboe wrote: >> I agree that a device
    in this state can't be used successfully, but the >> kernel should, IMHO.
    >> Say, in case the device hits this due to firmware which nee [...] 
 
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

On 2026-11-04 17:01, Jens Axboe wrote:
>> I agree that a device in this state can't be used successfully, but the
>> kernel should, IMHO. 
>> Say, in case the device hits this due to firmware which needs an update,
>> the kernel crash might prevent the user from applying it, in the first
>> place.
> 
> OK, now we're really reaching... If the device is so buggy that it can't
> even do basic operations without violating protocol and crashing the
> kernel, then there's nothing the kernel can (or should) do to try and
> prevent that. We don't cater to severely broken firmware or devices.
> 
> Please stop all of this nonsense.

Ok; thanks for the feedback and clarifications.

-- 
Mauricio


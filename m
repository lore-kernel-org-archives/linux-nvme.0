Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513E1CD6E44
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNVV5RSrjS7o4TZe/Jrrlts9X2T/sN3FLRhdTJhxOMw=; b=CRYTlvMdmxO0q3C9+Jx9p8S/jc
	dfHEd/RWcRkj9DkYA2kXsls8NoxjXTxw4hjKu06O/bkKJD5kcKCOzCyCQ95wH/W/MMO+zOpaNW4cn
	lpJTNBexQ9PI9nFO/QGtrRlpSOxdfAAjhkWiNttA7u9nwTpLzpBWlABMVCucHrAjFa8eQDfVqt/S1
	l9eMWM6WIY+LyUOcjjNEpi2hDswmyPi8GOkDaWcgx5FMGOXA5UeJ8qUJPwklC4TbIujoBpeYayn+r
	FaC/GNQEacSWCOXXpaYuOgjWfmXbgrw/NkWnH+AFY1sEuTLARc0AceX2OtRleY6OMt5goW3Kwa08l
	yYW6A/zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScaM-00000005unZ-2itw;
	Thu, 28 May 2026 15:23:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScaJ-00000005un5-3VGD
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 15:23:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9622C44042;
	Thu, 28 May 2026 15:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0A1F000E9;
	Thu, 28 May 2026 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981826;
	bh=XNVV5RSrjS7o4TZe/Jrrlts9X2T/sN3FLRhdTJhxOMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D6PQ6VwtW6cAq0yzywDit9p+dufchYyF+Ef8J4paq0mpWLghLZu/sdBNX6riFA9b3
	 Y1F1hP5qh7w0UTdPEYH3sr/3hy42GlbcIYehzVP0wZEUWDTW7CeTzMd7tNBGqkoRxN
	 ycYk/SHD3/JsTz9lapKL9K46+dbOUxujaYQQgzYIRcxcXSQyiVUNng37MOCkgh3BqU
	 daOO6Zh88lKbt3XxtNyB1+1SQsY+HAIw1BBQN3YikJtv1Ix2CLQ10+wZWtESggLSmH
	 8Eq39SMfiFfWJjKBJIWV4mEY74kxof0pQN6UfcFPQoDI6pphcJZ/7G3cKyeFRd42Du
	 3BPWOHxHposNA==
Date: Thu, 28 May 2026 08:23:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>, John
 Meneghini <jmeneghi@redhat.com>, Randy Jennings <randyj@purestorage.com>,
 Nilay Shroff <nilay@linux.ibm.com>, zhenwei pi <zhenwei.pi@linux.dev>, Hui
 Zhu <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
Message-ID: <20260528082344.7e4cd1a1@kernel.org>
In-Reply-To: <a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
	<a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_082347_895458_E38E1797 
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

On Thu, 28 May 2026 11:10:36 +0800 Geliang Tang wrote:
> Dedicated MPTCP helpers are introduced for setting accept socket options.
> These helpers (no_linger, set_priority, set_tos) set the values on all
> existing subflows using mptcp_for_each_subflow(). The values are then
> synchronized to other newly created subflows in sync_socket_options().

These are not protocol specific options, why do we have to export
MPTCP-specific functions for them?


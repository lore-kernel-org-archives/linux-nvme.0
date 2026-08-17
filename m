Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCFAC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9NtS90fRAe355xukfFtCNj/3OysLrTWOHdxxnVUAgf0=; b=gFtbr8/K+75uNLNTp3de+tMuPF
	FohviSM3YEtNB+HuS77fn5n2xb2RleFv+Kms7i32tFvgAlzOGA4fZXB4HfzkD8Vzw2Z6rdm0XeNDZ
	R2BOF2nzqh9iBYfzz4yScqz76WlzLpaEdlXamtVj+uh83A5tuWC8vtnJp3B8P6gmdygWVNlfrJVoG
	hhlT3cu9sMgObm4APhb2oCYXRAVSavynJD4EZYFM9LE/qBTvL3zNNt6TZkO7Tqu2Dq2PRTStXc1Iw
	b0dC44xMl46+2n4P0b2T1y9KGN40klGoy4Q/YsJgfU0HkmA0NPHI67cw7/5QxNREA7KIIo2d7CUv0
	wLF76pAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsfU-00000005gLw-45fE;
	Mon, 17 Aug 2026 08:26:04 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsem-00000005gCM-1oMt
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:25:25 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=eYNadUi07A8AhvVYvTwlB5KEurgeLlJSPKo7wDdWLLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786955118; v=1; x=1787559918;
 b=LjSgLYlyre7Bl9wzcfiwZnMLoGsyIYf9q8avtbrrLh4qRigtQGJCLkGEhRdOzNjEtR0FDJ2V
 wqeQAlf5nV6ZloadOxF0iTp92ncJJ7FcPM5OlPTDlNLFY02HJU5jaKQJRU/UIJzYS/uda5GT0qV
 xLqAy0diEUnzSweW7JvbwBgg=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: from localhost (3.112.29.171)
	by mta10.migadu.com with ESMTPS id 5d0fb72b720b7f63;
	Mon, 17 Aug 2026 08:25:17 +0000
X-Migadu-Flow: FLOW_OUT
Date: Mon, 17 Aug 2026 16:25:14 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Lukas Wunner <lukas@wunner.de>,
	Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <contact@jaseg.de>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATCH v2 01/13] kexec: add CRASH_WIPE_SECRETS to wipe secrets
 before kdump
Message-ID: <aoLFai0gzzH2bGgy@MiWiFi-R3L-srv>
References: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
 <20260811-crash-zeroize-rework-v2-1-9561d13c2340@jaseg.de>
 <anw9ILJiO5xIjP4f@MiWiFi-R3L-srv>
 <9765f7ea-36bb-4c7b-a19b-7facec97b762@jaseg.de>
 <aoGpcczo5GkBsPwt@wunner.de>
 <aoK6jXA-tF9qfKOZ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoK6jXA-tF9qfKOZ@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_012520_675340_DB7DE6FC 
X-CRM114-Status: GOOD (  26.56  )
X-Mailman-Approved-At: Mon, 17 Aug 2026 01:26:02 -0700
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

On 08/17/26 at 03:38pm, Baoquan He wrote:
> On 08/16/26 at 02:13pm, Lukas Wunner wrote:
> > On Wed, Aug 12, 2026 at 12:08:39PM +0200, Jan Sebastian Götte wrote:
> > > I can imagine one alternative way to approach this, tell me what you think:
> > > Instead of registering wipe handlers that memzero places on panic, I could
> > > put an optional registry of (addr, len) descriptors into crashkernel memory
> > > that the original kernel populates with the PAs of buffers to clear ahead of
> > > time. Then the kdump kernel could do the actual memzero. This would remove
> > > all code from the actual kdump path here. The registry could be made
> > > per-core to avoid locks.

If this has to be done in kernel, your (addr, len) registry idea is a
better direction, and we can make it a bit more general.

Instead of a secrets-only wipe registry, consider a small "crash memory
region" table with an action per entry:

enum crash_region_action {
    CRASH_REG_WIPE,   /* memzero, then dump normally (leave zeros) */
    CRASH_REG_SKIP,   /* do not include in the vmcore at all */
};

struct crash_region {
    phys_addr_t addr;
    size_t      len;
    enum crash_region_action action;
};

void crash_reg_add(phys_addr_t addr, size_t len,
                   enum crash_region_action action);
void crash_reg_del(phys_addr_t addr, size_t len);

Two actions because the use cases differ:

- WIPE is what you need: zero the secret, 
- SKIP covers things people do not want in the dump at all
   — Registering as SKIP reduce dump size. I have been considering how
     to shrink vmcore size on some big system with huge memory, the
     vmcore size usually is several or tens of GB.

If this is OK to you, you can start a regiestry table
infrastructure with wiping secrets, we can add SKIP later and plus some
driver used memory.

I am not sure if it's satisfactory, but you can give it a shot to show
what it looks like.

Thanks
Baoquan

> 
> Since there are a lot of security expert in CC, I am wondering what's
> the risk if we wipe secrets during dumping. System is located in
> user's place, and vmcore is dumped and collected in user's place. If we
> filter out secrets memory when we dumping, what could be leaked out?
> 
> > 
> > Or create a dedicated mempool from which all sensitive data is allocated,
> > then call mempool_free_bulk() on kexec to poison everything in that pool?
> > 
> > Thanks,
> > 
> > Lukas


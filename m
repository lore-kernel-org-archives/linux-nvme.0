Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38907C5DF75
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmqgrBJxUvss5ev2qg4hR/y+Shhz4DNLrdh9R3vpGbM=; b=2VTqiZ7ICozxOs3jS6ulmZHKxO
	LXX3VhsVHZFA6t3MvoN162/bBQUVd+MZCn6LvgTb3X8pbPSxaoFCK9SqYcXY+X6hTJOTgmqDL/f1U
	gL1J1Yl4lXI7vkFs1ybQhOXP91ilmWz09qCnokTnslW5IucssH1bxEwDtf6PRcAqLWxfedUk6roGS
	LURlwtMX+TCNUKfTaysG0Ws6JruVr/j2s8SaMdvLtao6N4zNJOd8XYQCdyKkWBJDLdd46XyQOMrJ4
	IYmgduhH+Y0xHjvMUEWiibQlHw3+suFuqrKo4LHkkl7ljz3G29UW6av5A6jOyLDS8Rw/3yasT3SxY
	zoQUkIQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWvb-00000000tHs-2sNU;
	Thu, 13 Aug 2026 15:01:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttJU-0000000EwZy-1Ezb;
	Tue, 11 Aug 2026 20:43:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F1D11600AE;
	Tue, 11 Aug 2026 20:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049C71F000E9;
	Tue, 11 Aug 2026 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786480986;
	bh=tmqgrBJxUvss5ev2qg4hR/y+Shhz4DNLrdh9R3vpGbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YXLgdApMQVjB8O5UsuRCftLgsXmP3cSJYvwGgrqZ6b+hB2edLW/uSBh3oj2DAKDLB
	 6IioToKp+fdIkMueq1I/JRHsiwugXBDmJ97vp4UxyiCAtTlbgjkSl4kj3fA2aKAij5
	 Qgg6Hbg7EYU+2aNCB4H6ya401I1ujfkQIF2fhblv0bLnVJ432LahjN1sFPCZeRdz14
	 Cw5oUW8a78hswG6XALU3IdgCkVcHjig6EUfeU9hkjUA2GGFHo2hnqTAj7OaCds1AU4
	 UNwXanpKaMexoPY5I1l0K/a0V8GThMm0LE5dEKAkZ0GBpRhjDX5FR/2e1tnXNyczMQ
	 ftS06T2V5gAHQ==
Date: Tue, 11 Aug 2026 13:41:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <contact@jaseg.de>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
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
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>,
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
	Simon Horman <horms@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Subject: Re: [PATCH v2 00/13] CRASH_WIPE_SECRETS: Wipe secrets before kdump
 (was: CRASH_ZEROIZE)
Message-ID: <20260811204101.GA1905@sol>
References: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
 <20260811182012.GB2895176@google.com>
 <d242ab53-a39e-421d-ac39-4bee49be6ac0@jaseg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d242ab53-a39e-421d-ac39-4bee49be6ac0@jaseg.de>
X-Mailman-Approved-At: Thu, 13 Aug 2026 08:01:01 -0700
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

On Tue, Aug 11, 2026 at 09:38:20PM +0200, Jan Sebastian Götte wrote:
> > Could you perhaps narrow the scope to one or two things that actually
> > are useful and can reasonably be supported for the application?  For
> > example, secretmem seems to be the only thing you mentioned that you're
> > actually planning to use.
> 
> I'm open to whittling down the scope of this series. In my use case I need
> at least secretmem as well as dm-crypt, which then pulls in the crypto tfm
> stuff. Personally, I could live without the other bits, I just thought
> they'd be easy enough to include.

Please do reduce the scope.

Note that even if dm-crypt is in scope, "crypto: api - wipe tfm contexts
before kdump" is neither required nor sufficient.  For one, dm-crypt has
its own copy of the key.  The wiping should be done by the kernel
feature(s) that need it, as they know what actually needs to be wiped,
and they can do so without the bottleneck of a new global list.

- Eric


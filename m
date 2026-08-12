Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C29C5DF6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fi1Sk4Bvje0wghFbC6BANw7VYtZF68SyZp7oYrXoxaI=; b=OsGCsl9KwUxiBlrMjHwk1gQBdt
	hKw0IGsR8MklINeotAnZP7ztKSnWc7dqngaqWxsLfjiQLX34fOzg0b3ZLFAhoX27nCavYqcfNLZ3w
	J3R6Q+GxNTf21zkhKs0//scHHyU/V/ZIVsc+vFVYhjKXUCEtzpJrknNRzYY2AQBrsi50hjmpUMIsG
	/Im83Nx3sAmlVN7L97Op2JPnuo/AzB+s9u9FHccti+R4b5xLeiMYQLtVEBsRmP+3qirgA2Ze4+auv
	STVoZWZI/NjzomT9DGsvUd7cEPhl9CYl1IVPrblO01PwfxQWIJCK0cehwAgLIw0FRBBQFDHBf7f7B
	SV6sGCEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWvb-00000000tIU-3aMY;
	Thu, 13 Aug 2026 15:01:07 +0000
Received: from out-70.mta0.migadu.com ([2001:41d0:1004:224b::46] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu5I3-0000000FlAQ-41nE
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 09:30:30 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=5Hb81DX76S8IAtLPuaQ2fxU+mq3IGFWwbuaXDXn7mzM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786527020; v=1; x=1787131820;
 b=K+KKG6z9cIX9FtV4SGWxRFZtkclJ4Ip7BFSWS0p9EXL4lcbba2/pLfi2aZfUuk+5r3CDEm1j
 W6szvLRQ6EhL+a+giwTbBdWM3A40Qo2tyt/eFA104x0TxZSuEnJxPhsqGTe5Au2rrkD2koxtgFK
 /EtO5qN45kjk2sssO05EjFmU=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: from localhost (3.112.29.171)
	by mta11.migadu.com with ESMTPS id 5cf300efea8cce09;
	Wed, 12 Aug 2026 09:30:20 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Date: Wed, 12 Aug 2026 17:30:08 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <anw9ILJiO5xIjP4f@MiWiFi-R3L-srv>
References: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
 <20260811-crash-zeroize-rework-v2-1-9561d13c2340@jaseg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-crash-zeroize-rework-v2-1-9561d13c2340@jaseg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_023028_558192_003AD62E 
X-CRM114-Status: GOOD (  14.82  )
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

On 08/11/26 at 07:52pm, Jan Sebastian Götte wrote:
.....snip...
> @@ -142,6 +170,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();
> +			crash_wipe_secrets();

I remember when crash_cma added this, we argued a lot about the risk,
finally it's added in with an added note to tell it's an opt-in feature
and risky. I don't know if it opens a Pandora box, I think anything
wanted being here need prove anything else has been tried, and the thing
is very very important. If we don't guard the door well, one day one guy
cold come and said I need ask Oracle database to do some transactions
before juming into kdump kernel because the actions will save billions
of dollar. 

And what does security people say about this wiping? Is it very
important information and wiping is mandotary? There's no any other way
to wipe it or pollute it, no way in kdump kernel? I noticed it's
happening on en embedded target, is it possible you do this on your
embedded kernel tree, but not mainline tree?

Anyone who wants to do thing like this, please prepare answers for them,
and be ready to accept failure.

Thanks
Baoquan

>  			machine_kexec(kexec_crash_image);
>  		}
>  		kexec_unlock();
> 
> -- 
> 2.53.0
> 


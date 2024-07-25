Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C6BC3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EgqAccS+4p660hOnjY9L7pV1nVv+9hVBAqTQ2TZf0Dk=; b=2bUbS85SC8T/UzdJPerJg4PuaI
	1TVAGk/jMhPWwQhFuPxQx4YMuJjtT67GOadzgucoVQ6NS06yjyqRsQk2AmFe8YQAFVoIIdoYRNGLO
	EawAbZELpPVGzsGxoPBVlTyPzFIb0qkf5Ggq2L06mrwDzOKLYaxn2VzvzBORx5T/FJhhRTzeUvj2r
	nLBfFOBZkcQYyeogXsyANeZWPtffRPdZSJvlyCoJ7gYcm5Q4IHYELGyNMEyS6oKQGZnyBsN5qAz+S
	KhXSL1JxljtzeGagDRE42BA/PoMKqO3KUTdFAP5soESfIUw5k463eX4Q1VZdy3NdiAYIjROMWnr5A
	ACzQrlKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX29f-00000001eFf-1TV6;
	Thu, 25 Jul 2024 17:21:27 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX29c-00000001eEe-1I0a
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 17:21:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 25402CE1407;
	Thu, 25 Jul 2024 17:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1826CC116B1;
	Thu, 25 Jul 2024 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721928080;
	bh=L0LOSg0VQO3PDyUpf27E5dmEAxesk/J4GrY7urab8NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdlbMQT7z5DTs3khWLOKMDLar6th+8iW2ZbR2KxOB34Hk0dBr9wZwgg2C9q+g0iVh
	 qWndx+P4oof9Ac1X4SAUiY7+rt1hrt9OeKBC4DzwM0DdmssQu/nCCCRzMFaVIuSUTJ
	 ef4e6Zd+nJNDQquNsRp3dITrnFQBFD83S9K0GZjrcZUj+X3MaphVfABOsJ1T/rsExf
	 FUDkY4lPnYNQUa2xgW1vy+hFvl8QSkQs6qvLe6R5dfsMDvnJifnnF/cXbQrzqWKjrC
	 07K1k0IbdIweya0AEnGhAVIz4na7+yGfuwU+mmQuDSRLlMouyC8mJny50OUt2kjLpb
	 SFh9sa6bOxvvQ==
Date: Thu, 25 Jul 2024 10:21:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-crypto@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/9] nvmet-tcp: support secure channel concatenation
Message-ID: <20240725172118.GA2020@sol.localdomain>
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-9-hare@kernel.org>
 <20240723014854.GC2319848@google.com>
 <f69aee16-8238-48cc-986a-6d9dc7f6d933@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69aee16-8238-48cc-986a-6d9dc7f6d933@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_102124_725095_BCEBCEAC 
X-CRM114-Status: GOOD (  26.32  )
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

On Thu, Jul 25, 2024 at 01:50:19PM +0200, Hannes Reinecke wrote:
> On 7/23/24 03:48, Eric Biggers wrote:
> > On Mon, Jul 22, 2024 at 04:21:21PM +0200, Hannes Reinecke wrote:
> > > +	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
> > > +					sq->ctrl->subsysnqn,
> > > +					sq->ctrl->hostnqn, &digest);
> > > +	if (ret) {
> > > +		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %d\n",
> > > +			__func__, sq->ctrl->cntlid, sq->qid, ret);
> > > +		goto out_free_psk;
> > > +	}
> > > +	ret = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len,
> > > +				       digest, &tls_psk);
> > > +	if (ret) {
> > > +		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %d\n",
> > > +			__func__, sq->ctrl->cntlid, sq->qid, ret);
> > > +		goto out_free_digest;
> > > +	}
> > 
> > This reuses 'psk' as both an HMAC key and as input keying material for HKDF.
> > It's *probably* still secure, but this violates cryptographic best practices in
> > that it reuses a key for multiple purposes.  Is this a defect in the spec?
> > 
> This is using a digest calculated from the actual PSK key material, true.
> You are right that with that we probably impact cryptographic
> reliability, but that that is what the spec mandates.

How set in stone is this specification?  Is it finalized and has it been
implemented by anyone else?  Your code didn't correctly implement the spec
anyway, so at least you must not have done any interoperability testing.

> 
> Actual reason for this modification was the need to identify the TLS PSKs
> for each connection, _and_ support key refresh.
> 
> We identify TLS PSKs by the combination of '<hash> <hostnqn> <subsysnqn>',
> where '<hostnqn>' is the identification of the
> initiator (source), and '<subsynqn>' the identification of the
> target. But as we regenerate the PSK for each reset we are having
> a hard time identifying the newly generated PSK by the original
> '<hash> <hostnqn> <subsysnqn>' tuple only.
> We cannot delete the original TLS PSK directly as it might be used
> by other connections, so there will be a time where both PSKs
> are valid and have to be stored in the keyring.
> 
> And keeping a global 'revision' counter is horrible, the alternative
> of having a per-connection instance counter is similarly unpleasant.
> 
> Not ideal, true, so if you have better ideas I'd like to hear them.
> 
> But thanks for your consideration. I'll be bringing them up.
> 

You are already using HKDF, so you could just use that, similar to how fscrypt
uses HKDF to derive both its key identifiers and its actual subkeys.  HKDF can
be used to derive both public and non-public values; there's no need to use a
separate algorithm such as plain HMAC just because you need a public value.

- Eric


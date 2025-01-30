Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6234C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=; b=d6F+0cgihsn2N9scpapCbrV2/u
	wVcONcexKRZUbko5NCMZ+8mZf5M03O0M0APk9nilq6W73USv3MNQQIfTOWHUhFCaLksPGQAWXZFoH
	mnsClE1D8L51GgLcV7QNcPiC/64wsWB4jHBRU8Fr/lLDju9P6W4wpxze2hjMd/gq0msZ7gwfJgN4b
	3FRiTv9w83VRDevhMnNr4DOGAdVCvtEF4TIDy89zl0b3x24yzGfVekHKEOkhkXFevyPg3xhWhjyJv
	KuTZm0NX5zZPBZdR7wAG0fON+0aFnq4fTjlP2gvkIIGrLe9xRgn1t7D+KWqyEZ8QcaLpU14cnymJh
	9B9C89AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQvY-00000008WF1-47FB;
	Thu, 30 Jan 2025 09:33:36 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQvX-00000008WEZ-1xDb
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 09:33:36 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-aa67ac42819so95712366b.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 01:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738229613; x=1738834413; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=;
        b=LOp+bqpmtk8RhmDOxDI3sxe/Ld5GrPVUxcDzuxl3v33rswv2ZqJnNHjKsHGtLlOQ7X
         jMivyCxBajUdc2kMG6wccXcciKlyG/lgVyegGsiiFJtiWrQnOziMhU9gUazNXIvkPEzt
         reWkriDj+nS5aou3n/kw337s4j0Q+nqn0/jqg9Ded6KRpjFHfzUsrQFWfw6sDSj//KjP
         ihnO1MA1F/VgI4YegNv20DxamjUSijow9sIJpe0MVtC96Zu9Z2pYNNNJ1NJyPp88yKEr
         jJDGL/YHaD0TmyJf4jIAP/erl4AJEAruppz0mNS4dbFqg/3c+6CsVDrZry45DyLoQ4DY
         5NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738229613; x=1738834413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=;
        b=CNbHu+gNfBFADFI86y2UGKNGYUq5fZgryf1zel8Mq/RMkvlYLQQayEZ2LAC5HEvfv7
         hAeF/6AAipUie5D7XBk47fvGVgxvqRwGAayQ29827oZSHQEtn8UR7/C+rVnT2B+iBl3i
         FGvI1ai9/+WEV17mLhNma2+pa+QNjIATtm3TX/9uWs3UiH0tVC8gPLSmJA550bMCJPPH
         C71T5Ecgx54HhgZG5ALpIXBv8P7+0NoVaIP3dmYnBtmhSNEeimQ6oFiJ9wDGQj0DOHbM
         EUTvup6mvD4P27VcbDtmziXOP41jttIUjZ+0YEtHnZ1K12qZX+TkU9CDipMiGgNBGhhB
         bjsw==
X-Forwarded-Encrypted: i=1; AJvYcCVbRaptZH/+UU4rzx84kiL4mMYTkEEZMC5JoTCBljgzy4wavV0bVikCQOE2UtjFlumzP5yOZh07pIpN@lists.infradead.org
X-Gm-Message-State: AOJu0YzZZ7biz8DyzXxn4Y5ierrMDWJlVbTx08SR5jSDGg03e1KRQgCl
	HWmPmQTpvhxl2eg7R3F3HgPPTCt6bqIK7jnP4Oo108rTp1b3F9fzVpP0Yvcc1C4AyUI1BkD+Tlo
	fSLUlOrBQC18nYWAekGA0AEQaAHqdhAfCOOxUNg==
X-Gm-Gg: ASbGncuz8JhxD6pdZv1Wj/wnpDmP2TUpbF75lh5j96BchOFWXeQC0vPtUD0wB//PUUj
	0LVpPwo0GbaUVqhPrdyXa32cJ4Uzp84bFXOylSNh1xwxiygipdt8c2bQ23djBtljZxiUgip4=
X-Google-Smtp-Source: AGHT+IFLid2+WkSj6gu0lJi8p/7/70xJkyZVifghUCgkxBo7ETqsM3r+bLCKK8Tr5GjCVEb2p1okzGL2E2nx5E81PMQ=
X-Received: by 2002:a17:907:6d0e:b0:aa6:ac9b:6822 with SMTP id
 a640c23a62f3a-ab6cfcb3a5dmr652262466b.12.1738229612883; Thu, 30 Jan 2025
 01:33:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com> <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
In-Reply-To: <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 30 Jan 2025 10:33:22 +0100
X-Gm-Features: AWEUYZkybIerZJOKdDh3HY5vqE9uTDjGlhoRTLZknshJLSkWQTdvtODbWIPUCHU
Message-ID: <CAPjX3Fd3NXe-U5G3kW+TCfBYoguW9rCAtnNCRqN84dsimGR5iA@mail.gmail.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: kreijack@inwind.it
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, 
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_013335_513173_946E10FE 
X-CRM114-Status: GOOD (  15.91  )
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

On Wed, 29 Jan 2025 at 20:04, Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 29/01/2025 15.02, Kanchan Joshi wrote:
> > TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
> > SSD for data checksumming.
> >
> > Now, the longer version for why/how.
> >
> > End-to-end data protection (E2EDP)-capable drives require the transfer
> > of integrity metadata (PI).
> > This is currently handled by the block layer, without filesystem
> > involvement/awareness.
> > The block layer attaches the metadata buffer, generates the checksum
> > (and reftag) for write I/O, and verifies it during read I/O.
> >
> May be this is a stupid question, but if we can (will) avoid storing the checksum
> in the FS, which is the advantage of having a COW filesystem ?

I was wondering the same. My understanding is the checksums are there
primarily to protect against untrusted devices or data transfers over
the line. And now suddenly we're going to trust them? What's even the
point then?

Is there any other advantage of having these checksums that I may be missing?
Perhaps logic code bugs accidentally corrupting the data? Is the
stored payload even ever touched? That would not be wanted, right?
Or perhaps data mangled on the storage by an attacker?

> My understand is that a COW filesystem is needed mainly to synchronize
> csum and data. Am I wrong ?
>
> [...]
>
> BR
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>


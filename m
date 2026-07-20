Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9710C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzKZztxfHahgMkFrixMi9FNZB/aFI2nYhfBRqnN3Xns=; b=A3zNBJTwJeXvI/XTsV1BdkebDd
	ozBz3mJOi2Cp5WAQIwvfCXdTdEUUOreMBQ3HRNuXQNcduO71/M9vf80h/aUwujdYWGMV4IPD0DYd1
	FrtcTtvBML07RRsdjGZKGfdMCZj3LTXmJkWE5KtumGYLwqjdmiveLnLgYkuK3zwckyD6UUxLsGw3T
	3435EJHSlk2S+nHVF0JkgJ7f4EjCygK1/xYEVU8K3FpEBUSokYaf36NJ3IiF62+vHGAR29AL+pA9J
	Tp/eTU8Juv/eR7t8ecg3F0XRFRAuKWAsoyjDkUSmy+K6jZnVLdA7A6dfy1nclmk7EqHZkG5ILo881
	//M4Qvzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlny0-00000006nNJ-3PJD;
	Mon, 20 Jul 2026 13:23:32 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlnxx-00000006nLx-1F87
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 13:23:30 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so5949311a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2026 06:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784553807; cv=none;
        d=google.com; s=arc-20260327;
        b=T4hdsmx7RovoQnluvbNUBJcTBxZuMjexrfo4yBz8o8XadTTTaLyO7iO/3cPmEPuPQo
         aJv+ZXe1Ov7n+z8cwXJ4GOJ1Rk/nSdpRp7wil60ZyQII7LBtrOcfSVjARglLTF+rlWDA
         Vu9NMcd5KHOPqYTnYddTQguFhyZCYOfUQMmnNAGoH9wYoJj9lR4crFnW9qWfNN5Xj9tR
         SdrGeIVlDssesVgRz0oLfv0xBVrPAuVz2FCYcdUNYK0Hg8RZIlcHAjFbJ0PQylB09hMC
         VFFYhS63CudA0ubr/vxyElEi7dQvDxwZmThDHPVUB/hhNB+js4bVjKbOs4iNmSZqXMpl
         7iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mzKZztxfHahgMkFrixMi9FNZB/aFI2nYhfBRqnN3Xns=;
        fh=/3MVdC+lCZthyf57AjJHkE4E9SbbGS4QNfTFfgMfI14=;
        b=Cp9FwhKSq9HXzI3f/sSDTz3FRk97qRLS0XWdeB5ku/S6tQKYxrVAjgpLHVrRYLZyPE
         ncZWLucHf8QNJuMZpLMCvXZoF5CJHYu0R42AiZK+Y2kw70ta5J7SHoCvRIwbi6okMKAk
         qoNx1xjp6OdZ9RiQFUYmTXCaCtPKUTX9nCtJNBxmPdhJloj9RoPnyGTqiqabRPvsuUPS
         a8chsCvGTx0l/e0mHvEsTtB3Gjv3Fdq8eqNyzRqlSqkAcbSTORIYxyJdppqUjR8xuPNt
         HhPtAjBsOBlewuhJYM+i1wbl7gHR6Gl/l6Bp/adlR5SnUKXyEhUz/E8gTTNWS/hu6FGD
         Gmpg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784553807; x=1785158607; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzKZztxfHahgMkFrixMi9FNZB/aFI2nYhfBRqnN3Xns=;
        b=Cs4xHeAVEvwPR+VXk8A5fTpTf9MYl8uBRIm68APBOl/8qkmqQinjP2EaZwNrBUdaLo
         jkk+h48KMHLHLoNpn4x2B8gHLn6kkEVnAeYLNvujenQ+FjDr7zujT/bN6vMW3wo94Tsu
         xx7Am5ix7W9pBOtWODRVIuJhuPF4IksvKHbHzLkINmlUZyQ/pzrf39ef4VrG6s0lLKit
         NctvILRKRFsM33eFiY8LbM0zgXmxeEM++2pXR6IKj9sH34gc3zPIUm9dPPLKBvHFrBVD
         wg7ux5MusHC31KvdwFWHgoDfwAMVp4VI9TbJX3QaBLYagbOz25VIlVszyB3bk8RBrqqV
         1iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784553807; x=1785158607;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mzKZztxfHahgMkFrixMi9FNZB/aFI2nYhfBRqnN3Xns=;
        b=fbNNFi29zIyJWUpkwOo20AMutOGDro6zkIb/vze+cw4rkreJQu4/nm5uqljliJuEF8
         A7UYbTgJjHbw+rrsVG+bkSiaFFu6zEqICkvsHCt+PsuWi75h0RmhIjU/8EZODwJ8pYAN
         Tx4QL0X3Eevcw6cyT8pw0WDtvG5QXxHff3td07s8hb3mNtPJCzzYYt41n34l3RaoZXWb
         nKiuYcLde003hNxj3eBxnBUc0HIhGspawcv5JXg3wpg9Q5B3/0O+k+C6EC1yQmHtWHvf
         ZHa8GTu63Njf3+k8GfRqpblPSWJFDEnc7b47uAPL3Qr4drNvkuWkRYM282ZP0lZbHHRN
         xjNA==
X-Gm-Message-State: AOJu0YxmTxFWYqBThmjHLlybMRcBOYwgRocJt66giW78H4aOv2rL6lL5
	5Ee2ECc0c8LfLS/hIEmWrfFSS5AKIwnaGYWLL5wb/CBtQ0WGSAVibsnUwftKmhPLL1KoOy9EYNA
	j03Fjwg0URLQpkbyOtr/E/ZV1Tw0BVfu8mjKt9nHc
X-Gm-Gg: AR+sD13+4DFpd6Ggl+KIsAc1mPB7fB5T+v31Esbh2hVbvDpfTD31yT55stA/czyK9Gb
	wEnOMtmJc0Qlkm0X4JBiT0arXX/ikHRTaWfmreMnf3aOkRdppskOI2wbgolAyQD3vE6EBxr1TCF
	L2EO1l4v35Ga5vmPfg7iq8KwPn/Y8bInvQDdYmBoVPhIzHbEjXxWRDvFZu7Lf0XRkgXYQbbnfom
	Mxd2uU9cbVN/drwR/Nn2p0snDNQglNJ78C5FiW/3lDSFQ0n0x2QoNQrdVRBadZ48YSd1ldjKgZu
	g+RhaHF3VQDtRoYdUmzHpgLiuQ==
X-Received: by 2002:a17:90b:35c1:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-38e4b43145bmr16358035a91.15.1784553806666; Mon, 20 Jul 2026
 06:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260713115444.465704-1-nilay@linux.ibm.com>
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
From: Marco Elver <elver@google.com>
Date: Mon, 20 Jul 2026 15:22:49 +0200
X-Gm-Features: AUfX_mwVgNQ07S75fjdL3lVeubHz8P2VayCKCxRSO3ocoEc8yaPWqXFGkhcG9zs
Message-ID: <CANpmjNNa=rNAaRSWg6ao9HGxH6JTRr7AgZfw8kqHGQCHJWmQfQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Support Clang context analysis for NVMe host drivers
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de, 
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_062329_346847_CC5C97FA 
X-CRM114-Status: GOOD (  30.49  )
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

On Mon, 13 Jul 2026 at 13:55, Nilay Shroff <nilay@linux.ibm.com> wrote:
>
> Hi,
>
> This series adds support for Clang's context analysis to the NVMe host
> drivers.
>
> Recent work[1] by Marco Elver introduced infrastructure for lock context
> analysis in the kernel, allowing Clang to verify locking requirements at
> compile time through various annotations.
>
> This series build on top of that infrastructure by annotating the NVMe
> host drivers with the appropriate locking requirements and by addressing
> warnings reported by the analyzer.
>
> The series was built and tested with LLVM/Clang 23.x and enables the
> NVMe host drivers to build cleanly with CONFIG_CONTEXT_ANALYSIS enabled.
>
> Support for the NVMe target drivers will be addressed separately.
>
> As usual, comments/feedback/suggestions are most welcome!
>
> Thanks!
>
> [1] https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/
>
> Changes from v3:
>
> - Moved the infrastructure patches to the front of the series; the first two
>   patches are now the infrastructure patches (hch).
>
> - Annotated initialization functions, which typically initialize objects
>   before they are published, with __context_unsafe instead of wrapping
>   individual initialization statements in context_unsafe(...).
>
> - Annotated nvme_next_ns() and nvme_available_path() with
>   __must_hold_shared(&head->srcu) since both APIs require the caller to
>   hold the SRCU read lock (Sashiko).
>
> - Split the removal of the redundant initialization of
>   nvme_ns_head::delayed_removal_secs into a separate patch (09/20)
>   (hch).
>
> - Split the removal of the redundant initialization of
>   nvme_ns_head::requeue_list into a separate patch (05/20)
>
> Link to v3: https://lore.kernel.org/all/20260706141452.3008233-1-nilay@linux.ibm.com/
>
> Changes from v2:
>
> - removed "Clang" from each commit subject line (hch)
>
> - for zero-initialized struct bio_list_init() is redundant and also to
>   suppress false-positive context analysis warning for a list variable
>   guarded by lock, remove bio_list_init(&head->requeue_list) from
>   nvme_mpath_alloc_disk() (hch)
>
> - get rid off wrapping rcu_access_pointer() using context_unsafe() as
>   the access to __rcu_guarded pointer using helper rcu_access_pointer()
>   should be implicitly safe (hch, Marco, Paul)
>
> - wrap INIT_LIST_HEAD() under context_unsafe(...) instead of interleaving
>   it under scoped_guard(...) to suppress context analysis warning while
>   initializing subsys->nsheads  (hch)
>
> - initializing head->delayed_removal_secs from nvme_mpath_alloc_disk() is
>   redudnamt as struct nvme_ns_head is zero allocated. This also helps
>   avoid false positive conext analysis warning (hch)
>
> - introduce LIST_HEAD_GUARDED(_name, _lock) and use it for guarding a
>   list (hch)
>
> - dropped context annotations for nvme_queue::cq_poll_lock as this
>   requires a annotation which could support guarding multiple
>   valid synchronization mechanisms for a single object, which is
>   ,as of today, not yet avalilable (hch)
>
> - new patch in the series from Marco Elver <elver@google.com>, which
>   annotates list_empty_careful() using __context_unsafe
>
> - context_unsafe() has a statement expression inside so group
>   multiple scope guarded variables before those are publsihed
>   under context_unsafe(...) where possible (Marco)
>
> Link to v2: https://lore.kernel.org/all/20260614131541.2017845-1-nilay@linux.ibm.com/
>
> Changes from v1:
>   - replace guard() with scoped_guard() for guarding request_list (Bart)
>   - annotate nvme_alloc_ns_head() using __must_hold(&ctrl->subsys->lock)
>     (Sashiko)
>   - guard nvme_queue::sq_cmds using nvme_queue::sq_lock
>   - annotate nvme_cqe_pending() using context_unsafe in nvme_poll()
>     (Keith)
>   - Split patch #13 and #14 to separate the context annotation change
>     from functionality change (Bart)
>
> Marco Elver (1):
>   list: Permit context-unguarded access with list_empty_careful()
>
> Nilay Shroff (19):
>   list: introduce LIST_HEAD_GUARDED
>   nvme: update nvme_passthru_end() signature
>   nvme: add context annotations for nvme_passthru_{start|stop}
>   nvme: add context annotations for nvme_ns_head::srcu
>   nvme: remove redundant initialization of nvme_ns_head::requeue_list
>   nvme: add context annotations for nvme_ns_head::requeue_list
>   nvme: add context annotations for nvme_ns_head::current_path
>   nvme: add context annotations for nvme_dev::shutdown_lock
>   nvme: remove redundant initialization of delayed_removal_secs
>   nvme: add context annotations for nvme_subsystem::lock
>   nvme: add context annotations for nvme_ctrl::ana_lock
>   nvme: add context annotations for nvme_subsystems_lock
>   nvme: add context annotations in fabric.c
>   nvme: add context annotations for nvme_queue::sq_lock
>   nvme: add context annotations in rdma.c
>   nvme: fix context analysis warning in rdma.c
>   nvme: add context annotations in tcp.c
>   nvme: fix context analysis warning in tcp.c
>   nvme: enable context analysis support for nvme host driver

Acked-by: Marco Elver <elver@google.com>

... from my end this looks reasonable.

Thanks!


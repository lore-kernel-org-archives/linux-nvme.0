Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAD3FAD3E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zFC/lhaJxqcQaSZZI2Q5H4LNgPqDYPjdF5yg0OAM20A=; b=hA7fzAkJFRgAoDlmaIqStXTEAn
	qaFzfKOvnMqz97G7Dl6xCQlU6hsRyGRHFr4KtoAiOxvO+rAauMM85TxTNT6D/Y8zVn8SfGUx2aGlw
	yGqlx48EMwvtgKFlmbMjzMI2F5myvFS6RW4fL5/WNuToxmfGqnBZ3HK7hU/81Or1+/2OTMRBxb6Et
	hfh3D6jyQSOHVnlPtTYNFg4ibr4O+RoamkkFtOxex1N3WgwME/psQ+c6r/2jYGewg38do39XgQHxv
	LVrQu4GviJ8BeC9AhLMmh8/02YD1BbkJpqgmWQ+uPx4bVwWVROkjlf3TecpsNc0mpZAH+5RmMim77
	M13Nl8JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFgj7-0000000Aowx-06oi;
	Wed, 22 Apr 2026 23:11:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFgj4-0000000AowM-10WW
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 23:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776899480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zFC/lhaJxqcQaSZZI2Q5H4LNgPqDYPjdF5yg0OAM20A=;
	b=JtY3qzWAPCthNYmpVDG1OoPMq1bSgXSn9mqvw49Q0U+DvjXs4O6NY5m/uduwZNXyg3iJym
	cmA99ZjnIP14Bw9wyI4xKeiIlCPd9bMARlJ1lIYFgxK5mpt1SqIhJp11FBQEVggXMFoG4H
	xG2metvtBTB+kjAilN4NKTOJpjxe3r0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-MZHPTE24NOyilGDgoCsrSg-1; Wed,
 22 Apr 2026 19:11:17 -0400
X-MC-Unique: MZHPTE24NOyilGDgoCsrSg-1
X-Mimecast-MFC-AGG-ID: MZHPTE24NOyilGDgoCsrSg_1776899477
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B98818003F6;
	Wed, 22 Apr 2026 23:11:16 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.2.17.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3865C1956095;
	Wed, 22 Apr 2026 23:11:14 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: [RFC nvme-keyring nvme-cli] Should NVMe/TLS PSKs support the request_key API?
Date: Wed, 22 Apr 2026 16:10:21 -0700
Message-ID: <20260422231043.2689681-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oRtTkDvvS2hMHjTj469S3io5nUrdt-EFlrI1YdI_cYo_1776899477
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_161122_371988_7E469199 
X-CRM114-Status: GOOD (  18.27  )
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

Would it be of interest to support the request_key API with NVMe/TLS
PSKs? I think it would be an improvement, allowing PSKs to be loaded
into the keyring as needed.

Issues (if it was simple I'd just send a patch):

 - a key cannot have it's description changed
 - request_key() creates an uninstantiated key with the description set
 - tlshd (ktls-utils) uses the description as the PSK Identity
 - NVMe specifies this Identity in a way that the kernel cannot know it
   when a request_key() would be needed (it includes an encoding of the
   key length and a digest of the source key it was derived from)

As nvme_keyring can't just request the key it needs, I went through a
few ideas:

 - request a new keyring full of PSK keys
   (requesting a keyring is explicitly blocked)
 - have the user-space handler create a temporary keyring, put one or
   more PSKs in it, and return the keyring serial in a "psk request key"
   (worked, but seems unlikely to be accepted as intended use)
 - have a request key format that expects to receive a key containing
   one or more PSKs + identity metadata, unpack those in the kernel into
   actual psk keys than can be used

I'm going to follow this with a _rough_ prototype of the last option in
that list. The user-space side is a shell script, I'd replace that with
an new nvme-cli command (but the request_key configuration does
provide a convenient place to allow for other key storage solutions to
hook in).

Motivation: The current solution for loading NVMe/TLS PSKs into the
kernel keyring (70-nvmf-keys.rules in the nvme-cli repo) falls short in
a few areas by triggering from a kmod load uevent:

 - doesn't work for the target modules
   (that one's easy, /nvme_tcp/nvme_keyring/)
 - doesn't work if the modules are built into the kernel
 - doesn't work if the modules are loaded from initramfs, with more PSKs
   and connections are configured outside of the nBFT
 - only runs once, must load all keys and cannot help with new keys
   (ok, nvme-cli doesn't have a command to save to a keyfile without
    importing to the keyring first anyway)

 Biggest problem I see, requiring explicit loading of nvme_tcp before it
 can be used with TLS:

 - The async uevent handling loses the race against the kernel when the
   transport kmod is requested on demand.

  ┌────────┐     ┌──────────┐     ┌──────────┐     ┌──────┐
  │ kernel │     │ nvme-cli │     │ modprobe │     │ udev │
  └────┬───┘     └─────┬────┘     └─────┬────┘     └───┬──┘
       │               │                │              │
       │ connect       │                │              │
       │◄──────────────┤                │              │
       │               │                │              │
       │ request kmod  │                │              │
       ├───────────────────────────────►│              │
       │               │                │              │
       │ load kmod     │                │              │
       │◄───────────────────────────────┤              │
       │               │                │              │
       │ uevent kmod   │                │              │
       ├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌►│
       │               │                │              │
       │ check keyring for PSK ❌       │              │
       ├──┐            │                │              │
       │  │            │                │              │
       │◄─┘            │                │              │
       │               │                │              │
       │ connect failed ❌              │              │
       ├──────────────►│                │              │
       │               │                │              │
       │               │ nvme tls --import --keyfile   │
       │               │◄──────────────────────────────┤
       │               │                │              │
       │ populate .nvme keyring         │              │
       │◄──────────────┤                │              │
       │               │                │              │

- Chris



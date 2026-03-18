Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9272210775E1
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bMBkRhNtl1otgu2Cs3jk5tJVzD2P2TtDrsldPd05Oik=; b=eHKfzWebm6j/4+5ZlExSPhbQye
	1OielU91gwvJdbJRe/CDmhE6jLB2HuVffjhcjrIpZOWpfK8Nas8rG6fZ/WsnkKn1wOMAT4AEavd9I
	wpRsYKBKQZgw5fFbF9MeV9ghOfgX5DxF1yvQ4hmDI3vD88ec3r94F/xm+pHFHgL3xGAYz9MgtTzhv
	F/1KCAT5jsASdHIahZK8BSbq/JzFLmGF1Cpj+XXnb2oebhacKxcz/tE4RVtLGE+5ayNAsPYTX/dWG
	vuA56Bn75A0Ug/BYzze4Pz+dmWp7FkARBqAcjVaT8aSkE3nBNrx8LVfWrJ4rZsi3cjnBSaW+ehfBA
	zwlhe7ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2tyD-00000008zOt-1610;
	Wed, 18 Mar 2026 16:42:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ty7-00000008zON-1VCh
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 16:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773852122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMBkRhNtl1otgu2Cs3jk5tJVzD2P2TtDrsldPd05Oik=;
	b=ioAFuOdFjptXKUCMMydpPu27J06tyRBf7SN1wnwpHfroZ8TPE3hrNmhc2vNXfyblRuAQVQ
	SSHOzS2zRUhX8UBrRRYbDcc2R/Ncail7grkqhbz8dEUw9DSWuJdrhLotNUenmPMOWAMEwM
	fb9XUUt6XD6j761gBbMOc4MG3b8Wdco=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-tJlDMtgMOUWA-GjSaf3ifQ-1; Wed,
 18 Mar 2026 12:40:11 -0400
X-MC-Unique: tJlDMtgMOUWA-GjSaf3ifQ-1
X-Mimecast-MFC-AGG-ID: tJlDMtgMOUWA-GjSaf3ifQ_1773852010
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF45B1955F18;
	Wed, 18 Mar 2026 16:40:09 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2D6021800351;
	Wed, 18 Mar 2026 16:40:07 +0000 (UTC)
Date: Wed, 18 Mar 2026 09:40:05 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme-auth: Include SC_C in RVAL controller hash
Message-ID: <20260318-straw-snazzy-a8976b9c9427@redhat.com>
References: <20260317031330.2794078-1-alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20260317031330.2794078-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: -BOBoTOkaNv_XpyVi9EvWo8as_5_z5eeXI-eroERI0c_1773852010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_094203_493883_4C64A60F 
X-CRM114-Status: GOOD (  10.68  )
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

On Tue, Mar 17, 2026 at 01:13:30PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> included in the Response Value (RVAL) hash and SC_C should be included.
> Currently we are hardcoding 0 instead of using the correct SC_C value.
> 
> Update the host and target code to use the SC_C when calculating the
> RVAL instead of using 0.

Am I correct in reading this, the current kernel implementation is out
of spec when doing secure channel concatenation (SC_C != 0) with
bidirectional authentication (R1 takes SC_C into account, but not R2)?

- Chris



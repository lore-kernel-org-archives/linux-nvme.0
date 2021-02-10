Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DEC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 03:38:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B7464DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 03:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B7464DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LZS8VY6ioxf4oTOQ0MLGaPboOXGTZwWWcK1jpUycDwY=; b=ONrbgeQxFGFpvX88ZQDZDu3pD
	ce5bYdDm9HWg3ujHaranMbUteVT8uue+HDR3S25wgoKEahzZbkwBdLDeHO4EgGt4uXr5bsbQiVM9O
	3x4fKERxqsFfyUQIxJvIA97uryUi1GgZF+ZbH7aPTJAgGCNNLpqNsjWp1qtZbKtliVvhF2n+8sIRZ
	xag8cvFbnAdgA93dQqvQKfJ+tgcb+upYemVwJ1Z3cIHb5eKEj7ubDBCZshwUFz0xpnmG4KqixDGPh
	l71EpZGCcgg44xOFGUYI36zuO3wpDfXnh8JZGmvlPvVazzoRzLHLRufHkI9HzKinsC6ybrR32e+sm
	Wm+fTKkpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9gKP-0007Ib-Q5; Wed, 10 Feb 2021 03:38:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9gKN-0007IJ-N2
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 03:38:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94AE16146D;
 Wed, 10 Feb 2021 03:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612928285;
 bh=omuswNr75IfEADV8hRxzWRhLCQdRwzy/+d1/OpWn4CY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IFGKOKNJUV5n9llW6YtIQZyuq/UAy/AhA4NMLNTfNw7eyUhOVEIuUgiBEIY4HA/1J
 CO1FdfUc8GCujMAEIlLAYe+dYmcm8iNBkilswJqBRDUhSHECY4Srks4d3//ZgJAHeJ
 /wnGjQIMwtu5LuuhwS+QKGbjSOLcRVw3dnhnazGjAgEW7Y1TZJFb+yaC9X/Ixoe0Jh
 34sVtx9JODJHJPDWRGulX1LA4esMOkNmSLvSNZ2M8NCIUAA4Cxl/vo4HZBO6UdIJPd
 OMxDHW+dv8NCj4aCFA680LKgTgmYz3NhGE1ZN0AWmhA6rPpUpsUE4r8g3te5R1By4E
 X/Pqyu5tgEn5A==
Date: Wed, 10 Feb 2021 12:38:02 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Message-ID: <20210210033802.GA23363@redsun51.ssa.fujisawa.hgst.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
 <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_223807_829132_E3C64787 
X-CRM114-Status: UNSURE (   8.40  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block <linux-block@vger.kernel.org>,
 CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 10, 2021 at 10:51:56AM +0800, Yi Zhang wrote:
> On 2/10/21 2:01 AM, Sagi Grimberg wrote:
> So it's nvme_admin_abort_cmd here

The opcode 8 would be abort if this were an admin command, but we can't
tell that from the nvme print. The subsequent blk_update_request log
indicates this is the IO command for a Write Zeroes operation.
 =

> [=A0=A0 75.235059] nvme_tcp: rq 38 opcode 8
> [=A0=A0 75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector 1=
048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431B4CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jaIDociwPi0biv0GwgN4RLcwAH/6H4qEBY/7UhYwGOk=; b=arz+lGUPt3qclOP4tojDiNK7cW
	8DZndyzoTl7t5acQDdJd2WqyWU8Jkzvnbrp0OuO78LsCcrtS/uhh1kZYlp8YwB/mvdxc1hYmaKjkK
	TiAcs3rCUBT2nMHOIa6Z1ZjyBx1loOdJzzKLiRtOgio1dXlGh+W9vXabY97fNAlXZKvesuQLDbAYu
	fwacSgwsXxdJ9FMuz0lcvvwH0rTqRlI1J7pVUbYE/N65WJ7rZhyJE+W9/o9kCF3ALTeGefXLcwqrO
	86mZ3WyAy3PO2AgxXmftK7ObtdqaisY9X3ZvdFL6VBJLvJYr5dl+6JMIONVI/x9G2o2aSIEc1fGF8
	XIaOSNtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtNAi-00Ga0i-0Q;
	Thu, 19 Oct 2023 07:10:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtNAg-00Ga0M-0p
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 07:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697699415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaIDociwPi0biv0GwgN4RLcwAH/6H4qEBY/7UhYwGOk=;
	b=Inr59XQOZDi0N/ryyDbOhOAO0oH/IeS7xjX4M5+9xewr3e+16kbxJCKs+QpuQjAA63o5Mj
	+wqocYkb9LGjnVfbhl+LEawuAo46iYw0geFVhxJ1oB5AzZJhdijB0eceK1uZQxeVPdxhdc
	Mws5JCw+n0ErCIpkmXCN2sRIut8xLY8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-InFVmRecOrq_bz2KBZf-Hg-1; Thu, 19 Oct 2023 03:10:04 -0400
X-MC-Unique: InFVmRecOrq_bz2KBZf-Hg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-457d4020f0fso1934331137.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 00:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699404; x=1698304204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaIDociwPi0biv0GwgN4RLcwAH/6H4qEBY/7UhYwGOk=;
        b=aYP/QJVU0aUeaGJ9qL2s3OW0wg8A5RTP853nWN+1ZCARNcysMhsp5n5gLDswxdAcJA
         tbnBBEVqX/T6eA4J118YqWY4ubtBXlSeCjzelbN5g/ewuuZ4CGjxOa4rnWIFPrw0Nc6O
         C3AV9Dw3ocNQawe19N/rV5zspsuc7yY1oOFalnlOJX/AxWxqT8uLiskXzetRWBWkIOMI
         SD3eYoa4mVKya4fIURiyXz0XuxwDFDtyi6JMhv5CegpW8bAMMY7Gs3IL6AKzvspnC/uT
         I7o/r4CDka5/4cx2uSegv9+ZuZ2xL/Mzk/3BjRxWedOTqFKcv1HjTwaxS28pMLdquW2Y
         4HsQ==
X-Gm-Message-State: AOJu0Yz33Kd76li5IM/11XfjFiCw9nvQ+jQ201rkCdEtR7QVPA5xtUXq
	WDJ5W0wAjwXCnXYnZC89j2szoyBh3UEAUsojqmA/ug2t8XH8rbLuPDRUwaWCiRDkDzmkrLtqydc
	Z9GbFQ6hJFi2EhhbAvkmr6ZWBlWVMQRC6l8D9GUdQiuU=
X-Received: by 2002:a67:cc1b:0:b0:457:e862:8bc1 with SMTP id q27-20020a67cc1b000000b00457e8628bc1mr1097643vsl.2.1697699404033;
        Thu, 19 Oct 2023 00:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiznte4nV3Qz5eLEjzHTAX0XxQ1Z/pH24A9aFObBXkDWSwWhMqdMFsK7Z60rk7nBpeChy7ZvXXKSggSm963NU=
X-Received: by 2002:a67:cc1b:0:b0:457:e862:8bc1 with SMTP id
 q27-20020a67cc1b000000b00457e8628bc1mr1097636vsl.2.1697699403769; Thu, 19 Oct
 2023 00:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOYvU9SLpmLTtw@mail.gmail.com>
 <ZS_wgTeyndh1WjTI@kbusch-mbp> <CAHj4cs_FiGXKySrgv-DvGTr3AFLwE-TgWzMCn+v3mgSUfhQYxg@mail.gmail.com>
In-Reply-To: <CAHj4cs_FiGXKySrgv-DvGTr3AFLwE-TgWzMCn+v3mgSUfhQYxg@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 19 Oct 2023 09:09:52 +0200
Message-ID: <CAFL455kTFgx++rYHoUda_rXY2f12MOMwKsB75NewZukH7E3ceg@mail.gmail.com>
Subject: Re: [bug report][bisected] blktests nvme/tcp failed on the latest linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_001018_385544_EFD198C8 
X-CRM114-Status: UNSURE (   8.57  )
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

=C4=8Dt 19. 10. 2023 v 7:29 odes=C3=ADlatel Yi Zhang <yi.zhang@redhat.com> =
napsal:
>
> Hi Hannes
> Bisect shows it was introduced from this commit:
>
> commit 675b453e024154dd547921c6e6d5b58747ba7e0e
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Thu Aug 24 16:39:23 2023 +0200
>
>     nvmet-tcp: enable TLS handshake upcall

st 18. 10. 2023 v 16:08 odes=C3=ADlatel Yi Zhang <yi.zhang@redhat.com> naps=
al:
>
> [ 5161.405594] ODEBUG: assert_init not available (active state 0)
> [ 5161.521808] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tc=
p]
> [ 5161.697797]  __timer_delete+0x70/0x170
> [ 5161.701550]  ? __pfx___timer_delete+0x10/0x10
> [ 5161.705907]  ? __mutex_lock+0x741/0x14b0
> [ 5161.709833]  ? try_to_grab_pending+0x70/0x80
> [ 5161.714105]  ? rcu_is_watching+0x11/0xb0
> [ 5161.718032]  try_to_grab_pending+0x46/0x80
> [ 5161.722132]  __cancel_work_timer+0xa0/0x460
> [ 5161.726318]  ? mutex_lock_io_nested+0x1273/0x1310
> [ 5161.731024]  ? __pfx___cancel_work_timer+0x10/0x10
> [ 5161.735816]  ? do_raw_write_trylock+0xb5/0x190
> [ 5161.740260]  ? __pfx_do_raw_write_trylock+0x10/0x10
> [ 5161.745141]  ? rcu_is_watching+0x11/0xb0
> [ 5161.749066]  ? trace_irq_enable.constprop.0+0x13d/0x180
> [ 5161.754292]  ? __pfx_sk_stream_write_space+0x10/0x10
> [ 5161.759258]  nvmet_tcp_release_queue_work+0x2db/0x1350 [nvmet_tcp]

Maybe the problem is that nvmet_tcp_release_queue_work() always calls
cancel_delayed_work_sync() against the tls_handshake_tmo_work timer,
but the latter is initialized only if
CONFIG_NVME_TARGET_TCP_TLS is defined.

Maurizio



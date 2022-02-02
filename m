Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9000DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGlmPh+lpFCFUzwkF/NTnSbC4pQ69+yQaOHVbCiVAdo=; b=pRHJ7AP1e3v35XH/0fkHw1O+7w
	MYcjPuZK50UXCdrmnPC3SUFaBtf7WUhdp9VdCGouTzKwPFxIO6/2IQ0KQ5VOwGNYkrYpWJIRJsQBZ
	Jei7yzONOLzK7FeYK7+HWom31+Dr5Fv4f3qgrBv4OJDV+tw8ERo0cgbcZUY8qBkqk3Dl/mT1EkH24
	0i2IGPYa+jTOb1Iow5Hh1EDTAhqzvt9lRYOs3YCYCbzJE1cf+nI4bVVEhj/rXYkViA63xPsFcVG8P
	PRzlTLq9ho8izB9NV1jkkeHxytgSOe8YkTlaDElbsey6OOshwskEXUluGaIqSntjd3c6sORNfmm67
	alLLVaZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFGwg-00FnXr-Jn; Wed, 02 Feb 2022 14:49:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFGwc-00FnWa-SM
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 14:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643813352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGlmPh+lpFCFUzwkF/NTnSbC4pQ69+yQaOHVbCiVAdo=;
 b=KaIsT/RFs1Ytp0qOqkvzkCVmA0ahXzxL5EtjT+Vqk1CyOKsFlk01PAdQbcebTlhwkgo1T8
 KcTCGSlOUhh8LIgIn1nByWbmCiOrGMetLiaE4HDq7hievdBGAP0+ddomW7jDI+atwEdx81
 oE/qFu//kVGyua49TfCLeGoP84OfwtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-w-xX1KEaMoiBIYAFgBKfgA-1; Wed, 02 Feb 2022 09:47:36 -0500
X-MC-Unique: w-xX1KEaMoiBIYAFgBKfgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C363318B9ECC;
 Wed,  2 Feb 2022 14:47:34 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C83747B3;
 Wed,  2 Feb 2022 14:47:33 +0000 (UTC)
From: "Benjamin Coddington" <bcodding@redhat.com>
To: "Hannes Reinecke" <hare@suse.de>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Chuck Lever III" <chuck.lever@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] TLS handshake for
 in-kernel consumers
Date: Wed, 02 Feb 2022 09:47:32 -0500
Message-ID: <1AF72276-E808-48E5-9824-6355129E58BE@redhat.com>
In-Reply-To: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_064915_245626_63C1D1EB 
X-CRM114-Status: GOOD (  25.11  )
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

On 2 Feb 2022, at 9:12, Hannes Reinecke wrote:

> Hi all,
>
> nvme-over-tcp has the option to utilize TLS for encrypted traffic, but 
> due to the internal design of the nvme-over-fabrics stack we cannot 
> initiate the TLS connection from userspace (as the current in-kernel 
> TLS implementation is designed).
>
> This leaves us with two options:
> 1) Put TLS handshake into the kernel (which will be quite some
>   discussion as it's arguably a userspace configuration)
> 2) Pass an in-kernel socket to userspace and have a userspace
>   application to run the TLS handshake.
>
> None of these options are quiet clear cut, as we will be have to put
> quite some complexity into the kernel to do full TLS handshake (if we
> were to go with option 1) or will have to design a mechanism to pass
> an in-kernel socket to userspace as we don't do that currently (if we 
> were going with option 2).
>
> We have been discussing some ideas on how to implement option 2 
> (together with Chuck Lever and the NFS crowd), but so far haven't been 
> able to come up with a decent design.
>
> So I would like to discuss with interested parties on how TLS 
> handshake could be facilitated, and what would be the best design 
> options here.
>
> The proposed configd would be an option, but then we don't have that, 
> either :-)
>
> Required attendees:
>
> Chuck Lever
> James Bottomley
> Sagi Grimberg
> Keith Busch
> Christoph Hellwig
> David Howells

I'm interested in this as well, and have gone down quite a rabbit-hole 
of
experimental implementation for NFS.  I've found the keys API to be 
useful
to implement a tls_session keytype that allows kernel subsystems to 
request
that userspace do the heavy lifting of establishing a TLS session and
installing the kTLS bits on the socket by passing an existing socket fd 
to
userspace.

However, something more persistent than call_usermode_helper is needed,
since userspace helpers may not be able to be looked up from a 
filesystem
when establishing or re-keying (or doing a number of other things) on a 
TLS
session for NFS or NVMe-over-tcp.

I've got a rough idea to create a thing called a "keyagent" which would 
be
an alternative to using call_usermode_helper to service request-key.
Keyagents would be persistent processes in userspace themselves 
represented
by keys, and if a keyagent key is linked into a process' keyrings and
matches the requested type it is consulted to service request-key and 
update
for those keys.

Ben



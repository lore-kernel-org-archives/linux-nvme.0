Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F25C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZeU/He+6khomoWAT8bo7Pq7shtJeaFymOMgng/v7Ac=; b=td9SwvEgIFgA0qpUPPzMl3qJWZ
	XPKJCTR26u3z9vK5nu7vQacd+2ZaRxspyqhBj3Bqke5ibMLBJ1e9+RqQ8FiKOT2LuXBKaKe3W4ezm
	sdIP2FqmJlNzxUBcotXO15HSqjYN+a6Iq2vUnWPwD1Ee4YC3jamwHBETXmFbdV7cA0UkczSqXaXSJ
	SQlWgErOUzIICBXDNF36gGlGZ0CuvWDqYnd+DkS5Dtf8AGHWsUm6T7RrtOh28VbHjYssaSe9OuQpB
	PZ7iz5b2e1hCkQNDecAC2GEHwbNyxLn8MblATzJi4SFO29ReKLSsKDuA1H7FUZO5fnuVPR6OQPXXy
	GIh0KV+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk3yU-006weU-Bt; Thu, 28 Apr 2022 13:14:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk3yR-006wdM-Qt
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 13:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651151661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZeU/He+6khomoWAT8bo7Pq7shtJeaFymOMgng/v7Ac=;
 b=i1aPGwaaNX/kqczDcKdB57407iSdcOC6F0YSlEvtFRs5Y1hy7M9/z2gaKT1oRV78567jYQ
 LXjLVdqyJad/uJt954t6/aZlAffEKJeTthdpeKtZTVeVrm5LIlSmuqQpj7wLdpWC68Peur
 HA1B4q7BIY6nG6oy3AGR7YJJL5YqKq8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-P4O97WGBNtqshBseR4rayw-1; Thu, 28 Apr 2022 09:12:23 -0400
X-MC-Unique: P4O97WGBNtqshBseR4rayw-1
Received: by mail-qt1-f199.google.com with SMTP id
 s3-20020a05622a1a8300b002f3692d5a18so3262392qtc.21
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 06:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=RZeU/He+6khomoWAT8bo7Pq7shtJeaFymOMgng/v7Ac=;
 b=F9q8bZ3+qj5mbSLSzJYZBgyZmpYXgiKDfcQLqA6nP9wVEg1eSUi2CGkIyPT6YsjRu5
 FKoyQErzbrJNMt7mVwsnKf2N4p7Hw05iEbhwqDsFibOeiLNyTZuXZjUmviZxTiqQ7O/i
 gYVhrQFv5Z06lxsHv0xEkKsh8QYim20vKGH0/cmnhoz31jlqY+WQZFNsqkJma1jtgZkB
 qWa9sHlHVtnThHcVA4/f8QOum8cYUdNvAgiOwf4hMVKYfGD8FRuu4qjw3g1EWQIB4s6w
 pPkOMQ22E3DSadqRH0+twxaMj4a3Q8/ztZ7RwixDSXu7SyEiGT8oS9zWbuTKZ73lRF9I
 GEqw==
X-Gm-Message-State: AOAM532gUZQ/STxBmlQG7DwoLSArk28qrbByp6uvymgAO4MNmwz/ZUyL
 zplWFgg34sQWheXpSaq8CGUeFI7I3yeBUG78fwZggcC3/E4weQHKVZqoPOnLL/OsZjfiRO+Bqo5
 hW+SeCecppsLaEnzyG+Q8VgfScYM=
X-Received: by 2002:a37:9f14:0:b0:69f:9b05:cc81 with SMTP id
 i20-20020a379f14000000b0069f9b05cc81mr3834553qke.697.1651151543185; 
 Thu, 28 Apr 2022 06:12:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwclu7EAK2/mxyXFVpKaxBff3R40ELe9mhnqEe6rK0Ij+NdFcfcxKZjuAeW0OVNqLZCq92GlQ==
X-Received: by 2002:a37:9f14:0:b0:69f:9b05:cc81 with SMTP id
 i20-20020a379f14000000b0069f9b05cc81mr3834518qke.697.1651151542901; 
 Thu, 28 Apr 2022 06:12:22 -0700 (PDT)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com.
 [158.222.141.151]) by smtp.gmail.com with ESMTPSA id
 o21-20020a05620a0d5500b0069c59fae1a5sm9282786qkl.96.2022.04.28.06.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 06:12:22 -0700 (PDT)
Message-ID: <089628513e1cadc0d711874d9ed2e70bb689e3f1.camel@redhat.com>
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
From: Simo Sorce <simo@redhat.com>
To: Boris Pismenny <borispismenny@gmail.com>, Chuck Lever
 <chuck.lever@oracle.com>
Cc: ak@tempesta-tech.com, linux-fsdevel@vger.kernel.org, 
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Date: Thu, 28 Apr 2022 09:12:20 -0400
In-Reply-To: <068945db-f29e-8586-0487-bb5be68c7ba8@gmail.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <068945db-f29e-8586-0487-bb5be68c7ba8@gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=simo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_061423_997046_0497606F 
X-CRM114-Status: GOOD (  28.55  )
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

On Thu, 2022-04-28 at 11:49 +0300, Boris Pismenny wrote:
> On 18/04/2022 19:49, Chuck Lever wrote:
> > In-kernel TLS consumers need a way to perform a TLS handshake. In
> > the absence of a handshake implementation in the kernel itself, a
> > mechanism to perform the handshake in user space, using an existing
> > TLS handshake library, is necessary.
> > 
> > I've designed a way to pass a connected kernel socket endpoint to
> > user space using the traditional listen/accept mechanism. accept(2)
> > gives us a well-understood way to materialize a socket endpoint as a
> > normal file descriptor in a specific user space process. Like any
> > open socket descriptor, the accepted FD can then be passed to a
> > library such as openSSL to perform a TLS handshake.
> > 
> > This prototype currently handles only initiating client-side TLS
> > handshakes. Server-side handshakes and key renegotiation are left
> > to do.
> > 
> > Security Considerations
> > ~~~~~~~~ ~~~~~~~~~~~~~~
> > 
> > This prototype is net-namespace aware.
> > 
> > The kernel has no mechanism to attest that the listening user space
> > agent is trustworthy.
> > 
> > Currently the prototype does not handle multiple listeners that
> > overlap -- multiple listeners in the same net namespace that have
> > overlapping bind addresses.
> > 
> 
> Thanks for posting this. As we discussed offline, I think this approach
> is more manageable compared to a full in-kernel TLS handshake. A while
> ago, I've hacked around TLS to implement the data-path for NVMe-TLS and
> the data-path is indeed very simple provided an infrastructure such as
> this one.
> 
> Making this more generic is desirable, and this obviously requires
> supporting multiple listeners for multiple protocols (TLS, DTLS, QUIC,
> PSP, etc.), which suggests that it will reside somewhere outside of net/tls.
> Moreover, there is a need to support (TLS) control messages here too.
> These will occasionally require going back to the userspace daemon
> during kernel packet processing. A few examples are handling: TLS rekey,
> TLS close_notify, and TLS keepalives. I'm not saying that we need to
> support everything from day-1, but there needs to be a way to support these.
> 
> A related kernel interface is the XFRM netlink where the kernel asks a
> userspace daemon to perform an IKE handshake for establishing IPsec SAs.
> This works well when the handshake runs on a different socket, perhaps
> that interface can be extended to do handshakes on a given socket that
> lives in the kernel without actually passing the fd to userespace. If we
> avoid instantiating a full socket fd in userspace, then the need for an
> accept(2) interface is reduced, right?

JFYI:
For in kernel NFSD hadnshakes we also use the gssproxy unix socket in
the kernel, which allows GSSAPI handshakes to be relayed from the
kernel to a user space listening daemon.

The infrastructure is technically already available and could be
reasonably simply extended to do TLS negotiations as well.

Not saying it is the best interface, but it is already available, and
already used by NFS code.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc






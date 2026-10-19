Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C4606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aFlW43wq;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ektzJOa1
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9F2CCF2E6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BfocLhumB1fGZxHu/mtdCb1aY9ZLnRM2UcKaUhQFaqo=; b=aFlW43wq48tckFw3vICLvCKaWq
	WcMTOj/HhaIHtcfWmMN3zazMzkyRNdYLka23Q2ZQqR/50TQ2MAegEM/cX9cYZfV6FzRllFCAGvr13
	czOuYF56Bg8BbnXiIxF0fKPrlRjphi8Jqv/TU/iwauwZp34eQHuNBIY6h8TbpxNzH85pEeEMHI9JY
	zteaoKu6Rh5j8w65hJLKAdmb6QXz15YZVSJ1ew1qdWCGYtGBQd/vjenBh7uF27gX4M2OidsNIwv0x
	r33or/RumbjDt5KMg6dVbeBXr860gBq4ftTHFm/IjVptqppt0toGhRaGXgM3CSuZ4VDp5oLj5uTna
	9pETVh9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIoiX-00000007maE-3lpy;
	Mon, 19 Oct 2026 14:52:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIoiV-00000007mZY-2XPS
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 14:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792421518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfocLhumB1fGZxHu/mtdCb1aY9ZLnRM2UcKaUhQFaqo=;
	b=ektzJOa1JZNQBaVjBDTITXjLP1HFvqRUFeBOJ4+yWE1/k9HmNftBb6LSGpojly0UqEvWk1
	cvsL10F/JR049wpsWYZ5EVL7cDB0PMyJ7QLcLHgiDmvCJZhkukZWicoQ3nIns7+yG7ZKbI
	vtylXWGKn7ot1SKZB+YmrlPi455xWfM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-2g7yqhQ7PemQNV3oFpAIhA-1; Mon, 19 Oct 2026 14:51:56 +0000
X-MC-Unique: 2g7yqhQ7PemQNV3oFpAIhA-1
X-Mimecast-MFC-AGG-ID: 2g7yqhQ7PemQNV3oFpAIhA_1792421516
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b937ecbb4so47489396d6.2
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 07:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421516; x=1793026316;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BfocLhumB1fGZxHu/mtdCb1aY9ZLnRM2UcKaUhQFaqo=;
        b=tiweQacKUNhldBuZgGhRNWPVtEIIXvyHHe/FFkvqpHfH5G+hCXGyfK2hx+6LCVkIgN
         tI+01C5qagzxHi/AX5ARvox25wY+jW/1fNkzx8hZH0WtDzaPpGepjn6Ysd5rjQppmTRz
         VQOo98ZG98SfOQpzeXVcG8Vw4IBZl5FmFhuPkC49CLK/3faJRwXlSzeXY3qzSSALF6YF
         vU4K7NwDBHGkvHs0fq/Q0dNfTiWnEOo1qzp+a01XsQ57uCCq7B3UrwkW5NMHGk3bMziB
         4ZLpx1rvW9jC6kl7Xro85S/Xl6q0aSCBW32ufb6QHykFcB4ZhSe7LamDNj+RlN7PU9C4
         qUbQ==
X-Gm-Message-State: AFq9FYLis7Dz3Gr+kHo+cnXLFSVVg7IEP2zeD8WSR7s/VJHjSyr4MKVf
	OWAsHO6RBpPnCdQZFWha9ByxWFbdTzqRQ5Sotj44Up1FOIy7SxLxDlv8KxqacexHrqKlIVvv3EL
	+agzaRf7TqtfHS3MnAaaG9gf/JzehXArWgvNbd73GOLrkhTUm8EoQor1mzRd6fwFkZ0/S
X-Gm-Gg: AYBFou1GMQ5bgwWD+gUZHFl6SbsBXpvc4pTQyUMiBk/DDaRmjsU9GsBeTt11xqWB6rh
	roqDM5Hf5ctgSqF5zvgu8tzeLfHZvTWm7U2dTSfgMZqjouBN3HwaZI9h8cbi+nwBZBIXwW55EuR
	Zb833lJzUz8MayVfHMmaYchr+KsSeMFv4WFXjoCdfaxlborEOuhp9PYz/+mjWB2iIkyAOFxveZp
	EnxF5DKEwCbxCF9KlLlkNZ94ZqcRIRqKWaqInsRVHi+nScwMsfBkPb1UpDtdAIwz1vOraG3+J+g
	+HDTkkW+m+1Pbl22rrf8WSxFB0yh1/uWAxDgldQPMQJy7g57xn8nFq5YDVH32T+TAtwcfAySRSh
	upnqpqX9nrfTj2CFrC6wM+CTUQSiqrY+aPujd
X-Received: by 2002:a05:620a:1b86:b0:93e:6f65:de63 with SMTP id af79cd13be357-93f29d0ed53mr1300749285a.47.1792421516049;
        Mon, 19 Oct 2026 07:51:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1b86:b0:93e:6f65:de63 with SMTP id af79cd13be357-93f29d0ed53mr1300743085a.47.1792421515388;
        Mon, 19 Oct 2026 07:51:55 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3c61c440sm353019685a.10.2026.10.19.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:51:54 -0700 (PDT)
Message-ID: <94b5d467f5ad5bffb8b958104fcff2bfa07dc085.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
From: Laurence Oberman <loberman@redhat.com>
To: Martin George <martinus.gpy@gmail.com>, Guixin Liu
 <kanie@linux.alibaba.com>, 	sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Date: Mon, 19 Oct 2026 10:51:53 -0400
In-Reply-To: <1af1ff8db7803c1b8f8e656eebe249cbe5e622b4.camel@gmail.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
		 <20261019075607.808947-4-kanie@linux.alibaba.com>
		 <sashiko-outbox-176783@kernel.org>
		 <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
		 <c4b6b7cfd51a498df8aaa7f5bc5cef9a0605b733.camel@gmail.com>
		 <1a84584bc9cf64fab6b4e17bdf2050f9b176ad6a.camel@redhat.com>
	 <1af1ff8db7803c1b8f8e656eebe249cbe5e622b4.camel@gmail.com>
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hOIuQouaj-VKnhTDIjYOGKxpcW8cCSVKgFuiY4Zt3lE_1792421516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_075159_718346_6357CC50 
X-CRM114-Status: GOOD (  18.37  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-19 at 20:16 +0530, Martin George wrote:
> On Mon, 2026-10-19 at 08:43 -0400, Laurence Oberman wrote:
> > On Mon, 2026-10-19 at 17:43 +0530, Martin George wrote:
> > > On Mon, 2026-10-19 at 19:13 +0800, Guixin Liu wrote:
> > > > >=20
> > > > > Should "service-time" also be added to the accepted values
> > > > > for
> > > > > /sys/class/nvme-subsystem/nvme-subsysX/iopolicy?
> > > > >=20
> > > > > =D9=87=D8=A7=DB=8C=DB=8C
> > > > Sure, changed in v3.
> > >=20
> > > Not just /sys/class/nvme-subsystem/nvme-subsysX/iopolicy, but
> > > this
> > > should be added to the accepted values in /sys/class/nvme-
> > > subsystem/nvme-subsysX/iopolicies as well.
> > >=20
> > > -Martin
> > Hello
> >=20
> > There should be no changes needed for my original iopolicies patch=C2=
=A0
> >=20
> > iopolicies_show() walks ARRAY_SIZE(nvme_iopolicy_names), so whoever
> > adds a service-time policy adds its enum value and its string to
> > nvme_iopolicy_names[] as part of that work. The new name then shows
> > up
> > in iopolicies automatically. The existing iopolicy store path
> > already
> > matches against the same array, so both attributes stay in sync
> > without
> > code changes
> >=20
>=20
> I meant adding to the iopolicies documentation here.
>=20
> -Martin

Thanks, makes perfect sense
Regards
Laurence


